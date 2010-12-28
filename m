From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 11/31] rebase -i: remove now unnecessary directory checks
Date: Tue, 28 Dec 2010 10:30:28 +0100
Message-ID: <1293528648-21873-12-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:33:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYi-0005Wr-Bi
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864Ab0L1Pcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:32:46 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58332 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269Ab0L1Pcn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:43 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so11286158qyj.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gRUkaQCfQs9xZaBlcBlCQ94rvZJstQYxXPYB1haB2SY=;
        b=CzhqmM4cPxvsC5yxT1RjkstEhMdBqnQw4rjGb0wgW5u8PvNIi7AGgm1/HF+KPofXoG
         wPuyJRSBfuKALeKhvX64omjkhu2DsJq29RmW5G/NrxGp0N11fFApOU6FsS5lVT+PuGU6
         2ewTEz79A1NcSFEVxWlM8n5Z5xfi0ZSwwNapA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FnQyrGs/JfI6/9bvi8AAcW9ZAA1lrPt5ogsFJ5fiXujAv/mZ7o51SqL2Bbg2UNOkgM
         88MaGEOXcGeAFf8gOSLr+JKoge0RSil4cvZMKaTyFdNt/4l91wpIdpNKEg2bmBAOozHH
         gs8cPMYfXIz4XreVMC9OGimPzTwDH/Qy/nk7o=
Received: by 10.224.6.80 with SMTP id 16mr12878839qay.186.1293550362641;
        Tue, 28 Dec 2010 07:32:42 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:42 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164250>

Remove directory checks from git-rebase--interactive.sh that are done in
git-rebase.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

Squash with previous?

 git-rebase--interactive.sh |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4d3dc63..21a9774 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -706,8 +706,6 @@ continue)
 	get_saved_options
 	comment_for_reflog continue
 
-	test -d "$DOTEST" || die "No interactive rebase running"
-
 	# Sanity check
 	git rev-parse --verify HEAD >/dev/null ||
 		die "Cannot read HEAD"
@@ -749,7 +747,6 @@ abort)
 	comment_for_reflog abort
 
 	git rerere clear
-	test -d "$DOTEST" || die "No interactive rebase running"
 
 	HEADNAME=$(cat "$DOTEST"/head-name)
 	HEAD=$(cat "$DOTEST"/head)
@@ -767,7 +764,6 @@ skip)
 	comment_for_reflog skip
 
 	git rerere clear
-	test -d "$DOTEST" || die "No interactive rebase running"
 
 	output git reset --hard && do_rest
 	;;
@@ -780,8 +776,6 @@ fi
 
 test -z "$rebase_root" -a $# -ge 1 -a $# -le 2 ||
 test ! -z "$rebase_root" -a $# -le 1 || usage
-test -d "$DOTEST" &&
-	die "Interactive rebase already started"
 
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
-- 
1.7.3.2.864.gbbb96
