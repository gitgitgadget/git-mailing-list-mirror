From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 06/21] remote-hg: trivial test cleanups
Date: Thu, 11 Apr 2013 07:23:02 -0500
Message-ID: <1365682997-11329-7-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:24:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGYd-0007Gc-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161289Ab3DKMYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:24:43 -0400
Received: from mail-qe0-f45.google.com ([209.85.128.45]:53790 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161139Ab3DKMYm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:24:42 -0400
Received: by mail-qe0-f45.google.com with SMTP id 1so844987qee.32
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=vZD/ZTcm8epGgYqmtsODPvwU+0Gy0ZfR+E1O3guM54E=;
        b=DXMVvdN3KMEQtV8z/1pSEwpCs4nta93NLJGaeYyp1pn0H+iCYdJ45a4lyTldo0FgeM
         uu/8Y/Z4I/1qI8fgF4B3qSyw7D70l3Co2cG/YCukjqxQcKD/1tfCd9OetWidhb6A7oH4
         DwMVJMjjRH0V8EAc7wvOWc7Kr93PuxwHbUK7lLOCLBgfQtvgT/Slv4iTtkaHLWbTl2iL
         HOT95udWGm5pWVmBwfJvjlJeYleppP3GV4nu/cdSFSaUduAH8j7N/sDhdzpH8x8Lfgr9
         RlPHdC7GrRYm/HDCSqJ2fSYXwHMtJIsgjqZqk5YL3brh/VhqgcrUm/90J1p1LPenFN04
         ejPw==
X-Received: by 10.224.9.129 with SMTP id l1mr6928436qal.4.1365683081487;
        Thu, 11 Apr 2013 05:24:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id t3sm6283950qen.5.2013.04.11.05.24.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:24:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220859>

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
1.8.2.1
