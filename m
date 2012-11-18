From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/6] completion: standardize final space marker in tests
Date: Sun, 18 Nov 2012 11:51:53 +0100
Message-ID: <1353235917-13059-3-git-send-email-felipe.contreras@gmail.com>
References: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:52:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2UR-0004tn-Kk
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470Ab2KRKwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 05:52:23 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38183 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab2KRKwW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:52:22 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599489bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hpMhgwlnTBbQs2/cddRwVs+BNv6wHb+a3aPMRQS/gMs=;
        b=S8fkogNHjdnerRXkaqHVV6MdskIAZhL4uXM59GguiFzVs3Dbt8kyMFVXnFhQ/NRRJf
         3HrfDlXgNf3q+v3mU9jWIAKBqIk+imy5p2C1T70j9nSMaL3mMekhPezDD0hb6pVpVIp1
         gJG9NyK+pJl3gq1kyOgegnndDnsApX9F9+SgAAP5duGb2CLhXeYHLDMC/G6rTAzVcXfR
         qdw1X58Qsw3NIK6vTNcpQimuDKNNrZGAXHEaAwpNY/M5KWLYf6Hh1qJ6pNmu96lv+Hgm
         lMK6esj2eO3/oqhmePWSxKLk0xwX9HRhBH1UaCo1qwl4h9cl0YIyVJwrqCbjhuW+XhPc
         T6uw==
Received: by 10.204.150.220 with SMTP id z28mr3854316bkv.125.1353235942018;
        Sun, 18 Nov 2012 02:52:22 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id u3sm2893504bkw.9.2012.11.18.02.52.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:52:21 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353235917-13059-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210007>

The rest of the code uses ' Z$'. Lets use that for
test_completion_long() as well.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2276a37..f4c7342 100755
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
