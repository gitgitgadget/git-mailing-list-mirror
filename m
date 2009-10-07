From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/3] completion: update am, commit, and log
Date: Wed,  7 Oct 2009 01:48:50 -0700
Message-ID: <1254905331-29516-2-git-send-email-bebarino@gmail.com>
References: <1254905331-29516-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 07 10:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvSKI-0004jY-0I
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 10:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934138AbZJGIrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 04:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934121AbZJGIrz
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 04:47:55 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:33174 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934087AbZJGIrx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 04:47:53 -0400
Received: by qw-out-2122.google.com with SMTP id 3so1778410qwe.37
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 01:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=i2BC/E90Cge4kZD/EvzBP8LOKTyWkGaE4h9kUvE/oW0=;
        b=fwulDezR8LJKMxRlS2nK+bX6+nQRgjg17ELDF8QmQUVIufOX7ySQBSL2L/kLwAP/GR
         gf2xkNB1Zx4N/Afu2yt+blNfC2gVpMUthhCoMq4BfDKsWOI+13WDgcxRbsOPIGkpckSG
         9PxapLT9CUaMxHeDSHEEcaud1p2AG0NxAUYq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=V9PXLfkYhl1v65HrTdQRkI9r8AhK4x0ixWCYDNTmxHhHizL1zCJl6Tswh3GUCG1opU
         NsnrCZW99524KfP97mP6zWb1w/8QCJq2ya8KiyQsMs3IoV66Mamwe1YPWCbnpZcoJFR9
         7LXyKQ/qPjhNJbVzTQRTz/D1A0DPus82dedOc=
Received: by 10.224.100.148 with SMTP id y20mr2231192qan.365.1254905206957;
        Wed, 07 Oct 2009 01:46:46 -0700 (PDT)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 5sm849002qwg.23.2009.10.07.01.46.44
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 01:46:46 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 07 Oct 2009 01:48:55 -0700
X-Mailer: git-send-email 1.6.5.rc2.17.gdbc1b
In-Reply-To: <1254905331-29516-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129639>

git am learned --scissors, git commit learned --dry-run and git log
learned --decorate=long|short recently.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 332be99..2ab8c5e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -668,7 +668,7 @@ _git_am ()
 			--3way --committer-date-is-author-date --ignore-date
 			--ignore-whitespace --ignore-space-change
 			--interactive --keep --no-utf8 --signoff --utf8
-			--whitespace=
+			--whitespace= --scissors
 			"
 		return
 	esac
@@ -894,6 +894,7 @@ _git_commit ()
 		__gitcomp "
 			--all --author= --signoff --verify --no-verify
 			--edit --amend --include --only --interactive
+			--dry-run
 			"
 		return
 	esac
@@ -1179,6 +1180,10 @@ _git_log ()
 		__gitcomp "$__git_log_date_formats" "" "${cur##--date=}"
 		return
 		;;
+	--decorate=*)
+		__gitcomp "long short" "" "${cur##--decorate=}"
+		return
+		;;
 	--*)
 		__gitcomp "
 			$__git_log_common_options
@@ -1191,7 +1196,7 @@ _git_log ()
 			--pretty= --format= --oneline
 			--cherry-pick
 			--graph
-			--decorate
+			--decorate --decorate=
 			--walk-reflogs
 			--parents --children
 			$merge
-- 
1.6.5.rc2.17.gdbc1b
