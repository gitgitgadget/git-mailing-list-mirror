From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] t6302: drop unnecessary GPG requirement
Date: Sun, 31 Jan 2016 15:19:22 -0500
Message-ID: <1454271562-24291-1-git-send-email-sunshine@sunshineco.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 21:19:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPyTF-0000Gp-RG
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 21:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933506AbcAaUTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 15:19:38 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:32909 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933471AbcAaUTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 15:19:37 -0500
Received: by mail-ig0-f171.google.com with SMTP id z14so22634642igp.0
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 12:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=AH4g6/zNHmii05Bp0xMMqwA0AJEe+HLHXnO3agyFs5M=;
        b=sN+hwtol7NTG2ZQV8Tw6PLfvQMvMK80ML3ITK44MMOAshwk5JnhrcC49VMitrdZob7
         pD9XU5jT7Olsxl9F/05fn6GFI6cuWJx1Y4jKN0m7dIrM/3e+cRDvBHQ4YrfdFi6ghtY0
         yJiF4rQ4AuWKgrewwvbJ1GUFBijyMxAoCd8bUeIgXxKKOUFU+f/OEIhB/EHfSvzLlLbk
         lq4KqB1LQtzeHt1iUOX+A2ZtwzZq3Avsin+bDgXNvYQN770NlshQRAqM+q9boEte18QJ
         RhC64g+QOp+Z0tllXRdA/n6rxh/4xxJIAWjScWQZ6P4SoD04UQx1YCk1M3DzUepB0BNn
         iwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=AH4g6/zNHmii05Bp0xMMqwA0AJEe+HLHXnO3agyFs5M=;
        b=JlZEoujY+ojOqXNUTIQC0c+kp2Ej8I607jlKg2X8b5hUQdg5UlzVx/l+5wk2+mm+d4
         GlL14KzyymtEbicRkSPN7etlEGG7TVSK4SuX39Kry2WlVjHRn6qqlmr7TmgunkDBp+G4
         /c81m43mFjBSViPq53LQA4KL8qHZhPC7iiDknNPA4RJ3kKj92eDOLV9GcgHnt/HGrUsx
         1B6JyLgiYEMoQzJUkA1hsKVjR+Y4pCNSa68YTYmkpDPhdRuOs5sTPYn6IKtnJ2+yPi6n
         9rvRlYfBtykcUfnelUbhG1S4hzd46Tik5BqM669aZ9TW+du/eQuhOci4V6XGcwJkn7sW
         4OMg==
X-Gm-Message-State: AG10YOQvWV6htI5zigGCvYBds6c0zFzoAXSfX9m3+ssVQ2JZShguJx84Tm1+e7j/XbtC8w==
X-Received: by 10.50.43.228 with SMTP id z4mr7081837igl.33.1454271576594;
        Sun, 31 Jan 2016 12:19:36 -0800 (PST)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id p8sm3117532iga.10.2016.01.31.12.19.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 12:19:35 -0800 (PST)
X-Mailer: git-send-email 2.7.0.333.g9c3d022
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285170>

These tests are concerned specifically with filtering, sorting,
formatting behavior of git-for-each-ref, yet if GPG is not present, the
entire test script is skipped even though none of the tests depend upon
or care whether the tags are signed. This unnecessary dependency upon
GPG may prevent these tests from being more widely run, so drop it.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

I noticed this while reviewing[1] v3 of Karthik's "optimize
ref-filter.c:populate_value()" series when I tried to run tests the
series added but couldn't due to missing GPG.

[1]: http://article.gmane.org/gmane.comp.version-control.git/284766

t/t6302-for-each-ref-filter.sh | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fe4796c..dea2a9e 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -3,13 +3,6 @@
 test_description='test for-each-refs usage of ref-filter APIs'
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-gpg.sh
-
-if ! test_have_prereq GPG
-then
-	skip_all="skipping for-each-ref tests, GPG not available"
-	test_done
-fi
 
 test_expect_success 'setup some history and refs' '
 	test_commit one &&
@@ -17,8 +10,8 @@ test_expect_success 'setup some history and refs' '
 	test_commit three &&
 	git checkout -b side &&
 	test_commit four &&
-	git tag -s -m "A signed tag message" signed-tag &&
-	git tag -s -m "Annonated doubly" double-tag signed-tag &&
+	git tag -m "A signed tag message" signed-tag &&
+	git tag -m "Annonated doubly" double-tag signed-tag &&
 	git checkout master &&
 	git update-ref refs/odd/spot master
 '
-- 
2.7.0.333.g9c3d022
