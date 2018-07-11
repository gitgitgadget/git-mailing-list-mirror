Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AD241F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 12:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbeGKNBT (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 09:01:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45404 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeGKNBS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 09:01:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id i20-v6so6122083eds.12
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 05:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEMNaj8zqPFy9TuHU0B+HgU+L7LoWSuMZHTx+KxWJas=;
        b=OoaZNX+aI7Sa1cMpRDTl5dr+L6lbpeIz+pGKQxyfCatS8oDjdAa3qatwQLeNsQ5aay
         RGkO1uiGMIDMZsoMLF6n3mPQyCgH/QiZ7InwOuHk1/XIxGyru8u9CEA4PL8JDTG90wtC
         BB5tSRZ3io7HVaDu2r2uPLszymwf0ltgxI87f6Bw9Opr/LnjOnFl+/laVAC3x5EBgXVK
         JZHOP1OnmznjKC5eR0M2fb2zMQHHoY1tulHoPE6JC8g3iVqIQzx7O6WK1tTm/+LP+WrD
         f2outexDqVGz8RGif/cnZhj+FwtKzaZ9kkfi+FTUkOvM+UuLy2XdiOvMAWuUO6NGyUC4
         goZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEMNaj8zqPFy9TuHU0B+HgU+L7LoWSuMZHTx+KxWJas=;
        b=Z+9ZKDFGtWo6k6o84k8m0Y2hjweTqNxeQUiEAjI5TunZwR5FbrQwWeJ3wlmgwLTA0H
         UiGwdoxKmmjm4ARy7hw4u3HP9/opnvSokSjz9ALkrKQVpt4EDemkLKVLEtDwESDBoui8
         8TLj401XRybMCkwULxNk2ZSppbFo97bDJYdr68DylrXqSMZ34ufS6WlnWXHm5h2uTNyX
         3y0yNR1ugLxXZOAks5EY/NO2zw3XlI2amemN0lW6uMZ5n0oR2Aw94j0KtyKG2CHAhFX1
         3Lqigh6lALGeAgFN3Fojpi7YsVKNiUrQmvdApfKnaEpxruEiN6Qtqhy9DmvLIOvK9Oqf
         jSIg==
X-Gm-Message-State: APt69E3O+vpKP8YE3SuiBIey93aaJKXQJMqC5XGb4WJv2sqajEri5nvS
        p8m22NFgIs1jA6krydMqiVkMIw==
X-Google-Smtp-Source: AAOMgpcXgK9WVpCp/vCaVJxfjwNfmVr3GjalSikF3pKbpiFC3ir81I+sC8y1xbvnqt6SoEVGxYz6Qg==
X-Received: by 2002:a50:8a66:: with SMTP id i93-v6mr7128755edi.281.1531313824287;
        Wed, 11 Jul 2018 05:57:04 -0700 (PDT)
Received: from localhost.localdomain (x4db1cc71.dyn.telefonica.de. [77.177.204.113])
        by smtp.gmail.com with ESMTPSA id h1-v6sm768050edr.86.2018.07.11.05.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 05:57:03 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/3] t/lib-httpd: add the strip_access_log() helper function
Date:   Wed, 11 Jul 2018 14:56:46 +0200
Message-Id: <20180711125647.16512-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <20180711125647.16512-1-szeder.dev@gmail.com>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
 <20180711125647.16512-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Four tests in three httpd-related test scripts check the contents of
Apache's 'access.log', and they all do so by running 'sed' with the
exact same script consisting of four s/// commands to strip
uninteresting log fields and to vertically align the requested URLs.

Extract this into a common helper function 'strip_access_log' in
'lib-httpd.sh', and use it in all of those tests.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-httpd.sh              |  9 +++++++++
 t/t5541-http-push-smart.sh  | 14 ++------------
 t/t5551-http-fetch-smart.sh |  7 +------
 t/t5561-http-backend.sh     |  7 +------
 4 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 435a37465a..b6788fea57 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -287,3 +287,12 @@ expect_askpass() {
 	test_cmp "$TRASH_DIRECTORY/askpass-expect" \
 		 "$TRASH_DIRECTORY/askpass-query"
 }
+
+strip_access_log() {
+	sed -e "
+		s/^.* \"//
+		s/\"//
+		s/ [1-9][0-9]*\$//
+		s/^GET /GET  /
+	" "$HTTPD_ROOT_PATH"/access.log
+}
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index d623cbad97..6cd986797d 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -43,12 +43,7 @@ test_expect_success 'no empty path components' '
 	cd "$ROOT_PATH" &&
 	git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
 
-	sed -e "
-		s/^.* \"//
-		s/\"//
-		s/ [1-9][0-9]*\$//
-		s/^GET /GET  /
-	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+	strip_access_log >act &&
 
 	# Clear the log, so that it does not affect the "used receive-pack
 	# service" test which reads the log too.
@@ -137,12 +132,7 @@ GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
 EOF
 test_expect_success 'used receive-pack service' '
-	sed -e "
-		s/^.* \"//
-		s/\"//
-		s/ [1-9][0-9]*\$//
-		s/^GET /GET  /
-	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+	strip_access_log >act &&
 	test_cmp exp act
 '
 
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 913089b144..c8b6ec493b 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -103,12 +103,7 @@ GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/repo.git/git-upload-pack HTTP/1.1 200
 EOF
 test_expect_success 'used upload-pack service' '
-	sed -e "
-		s/^.* \"//
-		s/\"//
-		s/ [1-9][0-9]*\$//
-		s/^GET /GET  /
-	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+	strip_access_log >act &&
 	test_cmp exp act
 '
 
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index 84a955770a..4248b5a06d 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -129,12 +129,7 @@ GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
 POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
 EOF
 test_expect_success 'server request log matches test results' '
-	sed -e "
-		s/^.* \"//
-		s/\"//
-		s/ [1-9][0-9]*\$//
-		s/^GET /GET  /
-	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+	strip_access_log >act &&
 	test_cmp exp act
 '
 
-- 
2.18.0.273.g57f1ecce9c

