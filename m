From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH 2/4] t6030: explicitly test for bisection cleanup
Date: Wed,  8 Jun 2016 02:24:52 +0530
Message-ID: <20160607205454.22576-2-pranit.bauva@gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 22:56:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAO2f-0004C7-9G
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 22:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbcFGUz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 16:55:59 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34429 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932709AbcFGUz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 16:55:58 -0400
Received: by mail-pa0-f68.google.com with SMTP id ug1so4888511pab.1
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 13:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zieKyb9FnLE14Ctz7ugdhj65fZw3V18JHTnSWCtOsqc=;
        b=NZF5e7hEK64rL0/wgw4CsU/jgcsFimoeQvyNQIj6M1qQyPzKoZcDFDH8+QyPzPOB0s
         gMSuZBezwWkSxaBMUxHNnAS/OO8oSrywohntSKTEDxbyKe/qOmb5kdfHdCr40L8sjtJ3
         whKxry/psTCvhtfKp2o76LUQeoGrsyuiv+RfVM+r3WsqF9pHmVAwA0jvXWIMYq/625wK
         G0fu0PwZEj5CcZOB6JTWHSr0hNGTorxWGGQG/ag3obdKjmwzUZkOlmYbXILcCQQYa/7s
         8JIGjxcTaQLDw6cC+oYhuJBfa397AexuWyZGtO7C8f1YheJwe++xFi4YEXygAR7vryou
         l2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zieKyb9FnLE14Ctz7ugdhj65fZw3V18JHTnSWCtOsqc=;
        b=gJheVIiMrhj4yS+rzykkhrmVM7G1299lR1Iu+kRr92BKWoMBwEr5AasCdts02ivFqx
         rD3cKOjyiN3rxpuuvHfqn/5/zwzqY9bH3cjzwfqTeAjBQuL8zBLrXj6M7oelEfdxqac3
         zaFYh82zJDQ3563apfq1APYSlmwK4vZNy896P+wUY//ZAzse98R8p46Jx4dfmkRgSUe5
         pP14xjFobAFVg3BhVy+I+KgvxneL1CbYqp51iTeZg7W63P8bipOKNJ0SaDeFePUQIjk2
         AhojoW4kojFkY8rCNkKpMBfBpOM0TKwxsob0FBqu98SQT6M67Roei7RIC3uyJ8QvFILl
         +Mag==
X-Gm-Message-State: ALyK8tIb24RyjOOCfdPmzCJ0hTMfTYUeT+3tnA89Y7S6QQ7KNkd0450T5o9eTPcY/kWeug==
X-Received: by 10.66.199.66 with SMTP id ji2mr1490510pac.34.1465332958120;
        Tue, 07 Jun 2016 13:55:58 -0700 (PDT)
Received: from localhost.localdomain ([27.106.4.232])
        by smtp.gmail.com with ESMTPSA id hw10sm35183194pac.15.2016.06.07.13.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jun 2016 13:55:55 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160607205454.22576-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296718>

This is not an improvement in the test coverage but it helps in making
it explicit as to what exactly would be the error as other tests are
focussed on testing other things.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
I faced this problem while converting `bisect_clean_state` and the tests
where showing breakages but it wasn't clear as to where exactly are they
breaking. This will patch  will help in that. Also I tested the test
coverage of the test suite before this patch and it covers this (I did
this by purposely changing names of files in git-bisect.sh and running
the test suite).

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index e74662b..1fb5ad9 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -894,4 +894,21 @@ test_expect_success 'bisect start takes options and revs in any order' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git bisect reset cleans bisection state properly' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect reset &&
+	test -z "$(git for-each-ref "refs/bisect/*")" &&
+	! test -s "$GIT_DIR/BISECT_EXPECTED_REV" &&
+	! test -s "$GIT_DIR/BISECT_ANCESTORS_OK" &&
+	! test -s "$GIT_DIR/BISECT_LOG" &&
+	! test -s "$GIT_DIR/BISECT_RUN" &&
+	! test -s "$GIT_DIR/BISECT_TERMS" &&
+	! test -s "$GIT_DIR/head-name" &&
+	! test -s "$GIT_DIR/BISECT_HEAD" &&
+	! test -s "$GIT_DIR/BISECT_START"
+'
+
 test_done
-- 
2.8.3
