From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 06/13] remote-hg: trivial test cleanups
Date: Thu,  4 Apr 2013 09:30:15 -0600
Message-ID: <1365089422-8250-7-git-send-email-felipe.contreras@gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:32:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNm9I-00048e-LG
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762504Ab3DDPbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:31:40 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:59258 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762372Ab3DDPbi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:31:38 -0400
Received: by mail-ob0-f182.google.com with SMTP id ef5so2661457obb.27
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=sp5sVp5Gs2XPFDNAFbQO9ebMZjZR+/4huVcSZJY/cRc=;
        b=cy7uve0ph8zlUbJOVB8k1u33PiEUPypuCx56J05nlsmx8oZV2OGn74MOEEZIMBO+sD
         cAESkspRXe7MozCif961j0MqbB4VRdyqDXCpixMae8SbnacXs2Rz9qeyYuNmd9kC1ttQ
         slLLkI2uWo2ex1M0V337SIOLbnUwG0l+HqpwqBxcpGeQAa1K+6WE6IaM3QcEbp1p2GaU
         3etLOOjJIz2fRzDY8OOoDYb+b6qJnxibx7QETKb6OBsnukxFs0tDVgjbcCYhAhWqitFf
         RnXCSJKWKbFy+1v03It05EqLO+Ug1HvUXPzsxVhs8wLJrGfjW/oBzbhwMgZIpetLrlu9
         Dxuw==
X-Received: by 10.60.30.33 with SMTP id p1mr4687416oeh.66.1365089498307;
        Thu, 04 Apr 2013 08:31:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id n1sm6783706obc.10.2013.04.04.08.31.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:31:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220010>

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
