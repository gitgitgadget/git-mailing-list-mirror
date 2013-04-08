From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 06/20] remote-hg: trivial test cleanups
Date: Mon,  8 Apr 2013 12:13:20 -0500
Message-ID: <1365441214-21096-7-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:15:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFf7-0004EZ-F6
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934885Ab3DHRPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:04 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:42112 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934588Ab3DHRPD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:03 -0400
Received: by mail-ob0-f177.google.com with SMTP id uz6so5903307obc.8
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=sp5sVp5Gs2XPFDNAFbQO9ebMZjZR+/4huVcSZJY/cRc=;
        b=LHl+IWBWdAZ7wSztmQB8KHQbR38Cn8Js01vc6tSlzYC9tdKSkGeXeLpIpUVMrJvpLn
         Ja4INJyzEDDlzrNPzPgQC2n5g4Q3HS3l+v5FxnjDn/PSUoz2K9/1wkS0vGV3eazDUCJS
         +8nLiiD+M6KwvwrJu6HU4NhRibY/wC+2RYN7apGSnqxTYoVjV3Cpq3ywQ00LbVo5JgIG
         jjdOaiMEl+4ZuqS/Hts5qDODeIT38Of8qyMRVxEuwUtTT+Op9sMo5D028Wi+dUFmgkfx
         9PlQ8Yvl3onRz2nagCP23v0CK/WDS7i7rkisN8b2NPkCavgfKHxTDydbj3a1e4ennGfD
         RDuA==
X-Received: by 10.60.21.101 with SMTP id u5mr16480363oee.71.1365441302634;
        Mon, 08 Apr 2013 10:15:02 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id wl10sm13008326obc.1.2013.04.08.10.15.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220447>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg-bidi.sh   | 5 ++---
 contrib/remote-helpers/test-hg-hg-git.sh | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index fe38e49..a3c88f6 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -22,7 +22,6 @@ fi
 
 # clone to a git repo
 git_clone () {
-	hg -R $1 bookmark -f -r tip master &&
 	git clone -q "hg::$PWD/$1" $2
 }
 
@@ -201,8 +200,8 @@ test_expect_success 'hg branch' '
 	hg_push hgrepo gitrepo &&
 	hg_clone gitrepo hgrepo2 &&
 
-	: TODO, avoid "master" bookmark &&
-	(cd hgrepo2 && hg checkout gamma) &&
+	: Back to the common revision &&
+	(cd hgrepo && hg checkout default) &&
 
 	hg_log hgrepo > expected &&
 	hg_log hgrepo2 > actual &&
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index e116cb0..73ae18d 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -27,7 +27,6 @@ fi
 
 # clone to a git repo with git
 git_clone_git () {
-	hg -R $1 bookmark -f -r tip master &&
 	git clone -q "hg::$PWD/$1" $2
 }
 
@@ -48,7 +47,7 @@ git_clone_hg () {
 	(
 	git init -q $2 &&
 	cd $1 &&
-	hg bookmark -f -r tip master &&
+	hg bookmark -i -f -r tip master &&
 	hg -q push -r master ../$2 || true
 	)
 }
-- 
1.8.2
