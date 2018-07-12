Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 553771F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 12:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeGLMbo (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 08:31:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37493 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeGLMbo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 08:31:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id v22-v6so21731448edq.4
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssHIOnY7yEAjPQIgWKYOvu5K+xEZOozXtX9zWjrKQjg=;
        b=VVbseSP9d5YcamFWIaWalfLJtIOFQSen+LztlQ7b/swg2nNJM4dgGGFhCAuWb0vtMP
         4DAGR+Y/OXyxNEsPKteKcAj9+61g+bNIGmX9xSWY5G2BBL7zIqeD6heNfCmrL2eN2Mmr
         ivqS9mr/lLN0rsXs9z5y4CIB/phazIpYTMm9Xbw4NrmPTMyZdpJuRqaEMy7e57MSRkCu
         e2dIWcDH/uiSIq5lkYJWHrzt32o8qWj9KlKP2/iQ0B6HSpkGU2v8OWoa63ffYuLh5Pqd
         any7hQ1xQiXSe3J6H02sFsVtcdr09dqlbkkfC0p4mvKD9d0TwkysuPgJZ9hXh1IEkXNG
         uVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssHIOnY7yEAjPQIgWKYOvu5K+xEZOozXtX9zWjrKQjg=;
        b=Zn9/nVZkpTpZ1ig0TAApqyl4Iw+JXI1VVvEaIbHk30/Xtz5zi9XQYXmfLTI8W9Scr5
         qAnzzrSYmrG+LR6V+RLJhKhRuXiz8fgAM9YXN24dAYrBKzlIuPvcuSKpE4/hP2Jk81iK
         CAYCrSAo9RnFiga/5q9Af6hwExV0ppZ+RrIh33xgfHEeRTkrYVLen7rPSrPUMmWwY7Xu
         yB3AarR3mfcxv5bw1KlPRXB2kjqNyJB7awDlbyRmZmwwLihwLDDibeF4vZfrYwNomj6Q
         n4wBiVaQemW3W1Ua3py6s7cP5XE1yAyYolN8JmZZQx7RaGMYNmAHfe8hmesQrwyMf6Wq
         ez5Q==
X-Gm-Message-State: AOUpUlH/EwHYJtPyRnOzPWoBAA/yuAATI26k42zjNK0DW85ztGvfZax+
        TYGOPNVx4Mdt3ghg5qNdO1s=
X-Google-Smtp-Source: AAOMgpcEFH3xbz/1i9CGRbv88tWToNZMpmTcwQlFPoaMr3OzwD+sl8ln1tALFIADg7juQwO3h7Nlxg==
X-Received: by 2002:aa7:c592:: with SMTP id g18-v6mr2371892edq.214.1531398143498;
        Thu, 12 Jul 2018 05:22:23 -0700 (PDT)
Received: from localhost.localdomain (x590d07e3.dyn.telefonica.de. [89.13.7.227])
        by smtp.gmail.com with ESMTPSA id a2-v6sm165618ede.21.2018.07.12.05.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 05:22:22 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 0/3] Fix occasional test failures in http tests
Date:   Thu, 12 Jul 2018 14:22:13 +0200
Message-Id: <20180712122216.12691-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.305.g66e9e0a543
In-Reply-To: <20180711125647.16512-1-szeder.dev@gmail.com>
References: <20180711125647.16512-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To recap: 't5561-http-backend.sh' is prone to occasional failures;
luckily it's not 'git-http-backend's fault, but the test script is a
bit racy; patch 3/3's commit message discusses the details at length.

Changes since v2:

  - Use 'test_when_finished' to clear the access log in the first
    patch.  (and necessary adjustments to the subsequent patches
    because of conflicts)
  
Interdiff included below.  (I wanted to include range-diff, but it
didn't make any sense)


SZEDER Gábor (3):
  t5541: clean up truncating access log
  t/lib-httpd: add the strip_access_log() helper function
  t/lib-httpd: avoid occasional failures when checking access.log

 t/lib-httpd.sh              | 21 +++++++++++++++++++++
 t/t5541-http-push-smart.sh  | 28 ++++++----------------------
 t/t5551-http-fetch-smart.sh |  8 +-------
 t/t5561-http-backend.sh     |  8 +-------
 4 files changed, 29 insertions(+), 36 deletions(-)

-- 
2.18.0.305.g66e9e0a543

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index a481e3989a..a9836e4af0 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -38,6 +38,10 @@ GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
 EOF
 test_expect_success 'no empty path components' '
+	# Clear the log, so that it does not affect the "used receive-pack
+	# service" test which reads the log too.
+	test_when_finished ">\"$HTTPD_ROOT_PATH\"/access.log" &&
+
 	# In the URL, add a trailing slash, and see if git appends yet another
 	# slash.
 	cd "$ROOT_PATH" &&
@@ -46,12 +50,6 @@ test_expect_success 'no empty path components' '
 	check_access_log exp
 '
 
-test_expect_success 'clear access log' '
-	# Clear the log, so that it does not affect the "used receive-pack
-	# service" test which reads the log too.
-	>"$HTTPD_ROOT_PATH"/access.log
-'
-
 test_expect_success 'clone remote repository' '
 	rm -rf test_repo_clone &&
 	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone &&
