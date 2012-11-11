From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/6] completion: standardize final space marker in tests
Date: Sun, 11 Nov 2012 15:35:54 +0100
Message-ID: <1352644558-9410-3-git-send-email-felipe.contreras@gmail.com>
References: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:36:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYeN-0005xu-I4
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815Ab2KKOgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:36:22 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41620 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab2KKOgU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:36:20 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2066470bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=12hloPDnJCTUcM3uXzo82T74oED1zBMydnuxb+BbG5w=;
        b=O6aOBjO+q6CQA/yEiurXZOp0PKaLSMqlfQu+7je4Qgm1+VDLoULyIQL0fFKZmw4i0T
         3dDXEDpKSH+f/CnAuvYwyLOGKzyexuScsWFag4WIYhkpO851x8mc8CxO432P2B/7BlRl
         e9Nq9tueAjMuBfrYo7X2UIQGIq1P608cKkjO6ux6whn9qDAuHDmijgUtZUxiQNU1q58c
         Jtc/COz9TfFQkhSoRiS06HPorcuLTaraaywSBPmXRGhEG55QYKTguP0g76egBjI3my3Z
         P425a5v5QVTgxDyrTIz6zGWNR0w74u6jtiLfwjEcktBaZNRW7P+9ybZGsw7M5gT7kWBT
         offA==
Received: by 10.204.12.197 with SMTP id y5mr6176582bky.77.1352644580155;
        Sun, 11 Nov 2012 06:36:20 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id k21sm1522465bkv.1.2012.11.11.06.36.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:36:19 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352644558-9410-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209383>

The rest of the code uses ' Z$'. Lets use that for
test_completion_long() as well.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5c06709..aff7e44 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -66,11 +66,10 @@ test_completion ()
 }
 
 # Like test_completion, but reads expectation from stdin,
-# which is convenient when it is multiline. We also process "_" into
-# spaces to make test vectors more readable.
+# which is convenient when it is multiline.
 test_completion_long ()
 {
-	tr _ " " >expected &&
+	sed -e 's/Z$//' > expected &&
 	test_completion "$1"
 }
 
@@ -252,24 +251,24 @@ test_expect_success 'setup for ref completion' '
 
 test_expect_success 'checkout completes ref names' '
 	test_completion_long "git checkout m" <<-\EOF
-	master_
-	mybranch_
-	mytag_
+	master Z
+	mybranch Z
+	mytag Z
 	EOF
 '
 
 test_expect_success 'show completes all refs' '
 	test_completion_long "git show m" <<-\EOF
-	master_
-	mybranch_
-	mytag_
+	master Z
+	mybranch Z
+	mytag Z
 	EOF
 '
 
 test_expect_success '<ref>: completes paths' '
 	test_completion_long "git show mytag:f" <<-\EOF
-	file1_
-	file2_
+	file1 Z
+	file2 Z
 	EOF
 '
 
@@ -278,7 +277,7 @@ test_expect_success 'complete tree filename with spaces' '
 	git add . &&
 	git commit -m spaces &&
 	test_completion_long "git show HEAD:nam" <<-\EOF
-	name with spaces_
+	name with spaces Z
 	EOF
 '
 
@@ -287,8 +286,8 @@ test_expect_failure 'complete tree filename with metacharacters' '
 	git add . &&
 	git commit -m meta &&
 	test_completion_long "git show HEAD:nam" <<-\EOF
-	name with ${meta}_
-	name with spaces_
+	name with ${meta} Z
+	name with spaces Z
 	EOF
 '
 
-- 
1.8.0
