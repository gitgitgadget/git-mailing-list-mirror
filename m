From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 11/31] rebase -i: remove now unnecessary directory checks
Date: Sun,  6 Feb 2011 13:43:40 -0500
Message-ID: <1297017841-20678-12-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:46:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9cj-0004j0-D7
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659Ab1BFSqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:08 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58927 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab1BFSqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:05 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so3422584qyk.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=FNHWrALH1IVgnFGcUoGnzjY4XJnxeKuUoKomlI1f8BU=;
        b=OrX/Qy4vx0RNgXGqWYmQR1QsrwSB8uaqi2sFriIYPB4SQ+fG0o07htzUyxZK0Q0xAr
         1GZYKm6istlB97xI+vKKgOwUVBzrHpshhZJMfqaIw61YxvIWtT+sqnz1pQYNaydq2DOh
         a1JJfSXBgwtHg0v4BHtleNWLFAkfeeFaobfls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cRKw8fy52I8HZ6BkC2dUIB/Au20u9GDC7n0xjfC56nqaPQZifEK7JxPu6PjIC6gQFo
         2B4hv77KJrSc5itZIK48EaL3TZ7/DLqbQXUqFEqRTVwfYn8/Mx+7Va+POQrO+dgtWKoS
         hFIm4AuDGKDegZc4f13iruYGiVANjdFfhCbxU=
Received: by 10.224.54.69 with SMTP id p5mr13455499qag.46.1297017965480;
        Sun, 06 Feb 2011 10:46:05 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:04 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166169>

Remove directory checks from git-rebase--interactive.sh that are done in
git-rebase.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Squash with previous?


 git-rebase--interactive.sh |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9c43c60..4f4fb29 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -706,8 +706,6 @@ continue)
 	get_saved_options
 	comment_for_reflog continue
 
-	test -d "$dotest" || die "No interactive rebase running"
-
 	# Sanity check
 	git rev-parse --verify HEAD >/dev/null ||
 		die "Cannot read HEAD"
@@ -749,7 +747,6 @@ abort)
 	comment_for_reflog abort
 
 	git rerere clear
-	test -d "$dotest" || die "No interactive rebase running"
 
 	headname=$(cat "$dotest"/head-name)
 	head=$(cat "$dotest"/head)
@@ -767,7 +764,6 @@ skip)
 	comment_for_reflog skip
 
 	git rerere clear
-	test -d "$dotest" || die "No interactive rebase running"
 
 	output git reset --hard && do_rest
 	;;
@@ -780,8 +776,6 @@ fi
 
 test -z "$rebase_root" -a $# -ge 1 -a $# -le 2 ||
 test ! -z "$rebase_root" -a $# -le 1 || usage
-test -d "$dotest" &&
-	die "Interactive rebase already started"
 
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
-- 
1.7.4.rc2.33.g8a14f
