From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v2 2/6] t6030: explicitly test for bisection cleanup
Date: Wed, 15 Jun 2016 19:30:22 +0530
Message-ID: <20160615140026.10519-3-pranit.bauva@gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	sunshine@sunshineco.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 16:01:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDBOF-0006q9-AI
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 16:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbcFOOBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 10:01:52 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36103 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbcFOOBv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 10:01:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id 62so1867833pfd.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 07:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TIfUGAJxydjGtJLouapsVhyOQjoWhwa6fCf7CWZygNU=;
        b=o/P0dGKX12TfW+/o8AgITLiliDxpxNH5CkB3RHATwE/vNBJNdbQb5GAjhHuuW2lu+B
         vBeqTPARv126NnscoxYZ8balN8qFEfUDft6MYJHSk8n03sQlYhlqX9yrc24Pp3AIchrI
         /87kkzObKMq3WS7v1j5ARNpRsWExwS/fdKDBCNTkfTpfzKo6sZBTBpj25lMbfK5RQ+VX
         8GHzudXICxcKCwUfzFoephsa1jP/neaLXrM5bYpfb+V+LLaNvR+lCg7REaR6FJGdk5H0
         wPHcf9ja6LC81yt/Sq5wnX21tw2569SRRrAif2t3cYgBPesuM73rAHRUOotZUCB05IFp
         1iyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TIfUGAJxydjGtJLouapsVhyOQjoWhwa6fCf7CWZygNU=;
        b=LtAkpVCtGNsQDUH8cFeJScht//+wsnh5XGagGf7XBVJtCQaTVaBUBMddElDou9HPwK
         x3AJrMC8r+ElZav+Jz2XCRTEuSCtAC3oy+gNwMsqQWq6MfU1vc+QUxyTbvG/0BQEIc9H
         V/lh42FyaDKSM3Op3sr8GdUEwJaL0habbFAqBWK8+EAUE5eKyD4xV5jaB6nodtJRlKN5
         eF74Q4AsSYOtqbhmG/Nfrhoj9cDsPvQ+zqE+LP0LH8gTw9r6FldnB6DzsleT1fw1cSM5
         VGihEPPcdnCGfAMVDfPRZDD5t7x8dPIU3HgzLyPH3ZrwzB1p18tsZ+y3m33cldPODcJ0
         cEQA==
X-Gm-Message-State: ALyK8tKgiWrZCi64AAMUsUd2A78nsscd7NL2mpAHRFK0uh/DS7XlQtYBPT7/0rn0xwX9Hw==
X-Received: by 10.98.204.130 with SMTP id j2mr4044397pfk.147.1465999310829;
        Wed, 15 Jun 2016 07:01:50 -0700 (PDT)
Received: from localhost.localdomain ([27.106.54.188])
        by smtp.gmail.com with ESMTPSA id i5sm37514156pfk.14.2016.06.15.07.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Jun 2016 07:01:50 -0700 (PDT)
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160615140026.10519-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297374>

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
index e74662b..a17f7a6 100755
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
+	test_path_is_missing "$GIT_DIR/BISECT_EXPECTED_REV" &&
+	test_path_is_missing "$GIT_DIR/BISECT_ANCESTORS_OK" &&
+	test_path_is_missing "$GIT_DIR/BISECT_LOG" &&
+	test_path_is_missing "$GIT_DIR/BISECT_RUN" &&
+	test_path_is_missing "$GIT_DIR/BISECT_TERMS" &&
+	test_path_is_missing "$GIT_DIR/head-name" &&
+	test_path_is_missing "$GIT_DIR/BISECT_HEAD" &&
+	test_path_is_missing "$GIT_DIR/BISECT_START"
+'
+
 test_done
-- 
2.9.0
