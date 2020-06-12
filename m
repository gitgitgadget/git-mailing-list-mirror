Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939C1C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 15:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6571F2074B
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 15:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="wxpvoKyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFLPpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgFLPpW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 11:45:22 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36319C08C5C1
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 08:45:22 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 205so9402332qkg.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/pNbhv6GQ2n+kU3QExekfGe2Z498pHT8VVSaNM4Vskg=;
        b=wxpvoKyXTy65bne3gpOGoT4hoT9mdju3wjjiVJKHPEmNl4oXFds5qumnVwfmFkDdEW
         vENPKM6audAuYkpPCOeIZlJKJZ4WkjAkJeKZGBXm8ZHcjcyKvHayiQqwGdV2GsubdVwR
         sRpQZNZr2CzgV6gRm2N08a+yJDoi2XNHiyzDhgOiW1uyPIDwa4Iw8P+ELakCUccHbm3h
         Sdm+ibLmNhrUE2nhy25fEkbVx9NeYMT+z9yuwt1dm74ARlPdiBxcwOdCU949Md3GdDmP
         X5LMogZKx1U9WXbRYR1VhSXFhLWUScybc9RVRusxMWw0fxCFhSRSqVhkosu9KV0XMt+b
         xt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/pNbhv6GQ2n+kU3QExekfGe2Z498pHT8VVSaNM4Vskg=;
        b=B2AFttLdQgpO2MMdSuKZPn5TJam8TJbHXBuMohODTY0ALxQBpCf78ZLP49s9yuE89r
         7wAJ8K173lbh2wWmG/JaearEpDaNCnME+EcE7V8L2dOrPhgGHzt7wbmAn0kASoq04W6H
         ozPu6peUc8np9rhj0oq3ZtY6Tx1CXeJ+sFHonkcLxnbQnDdl7KLtLxv4NN6IkEf7xMmP
         6sIKWHsZeZts6n27D1I8KSwJ7PqukwhYwi8EElJrinfbzWpHJUWddezzSYZ/WZFrzxRp
         //Lcraq8/I8nq1bbzFM5XtPBVsxqR2R8lmdNvLU2ZOoD6OVOxUVXD14ilj1Ke0L+wrFj
         /9jg==
X-Gm-Message-State: AOAM531FlWY/tbKWJmR8lmoSwtMEBWid6VCzM9kPSbQtV6jw2xpm9kel
        RkBC6TwfPNayA0YaBnYA5ejZ4iROzxSsNg==
X-Google-Smtp-Source: ABdhPJy+B+jI8XHSDtEeetT8qsNpIcyvYCdHt36PmIIJaPMuKltSn+JxkSk5AJYvMz9V/NLc/x1Uvg==
X-Received: by 2002:ae9:e813:: with SMTP id a19mr3629565qkg.264.1591976720922;
        Fri, 12 Jun 2020 08:45:20 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::3])
        by smtp.gmail.com with ESMTPSA id r37sm4988157qtk.34.2020.06.12.08.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 08:45:20 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: [PATCH v4 2/6] t/helper/test-config: return exit codes consistently
Date:   Fri, 12 Jun 2020 12:45:00 -0300
Message-Id: <85c429ac6924fefcd6b93ccefbdd52903929bb02.1591974940.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591974940.git.matheus.bernardino@usp.br>
References: <cover.1591974940.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test-config helper may exit with a variety of at least four
different codes, to reflect the status of the requested operations.
These codes are sometimes checked in the tests, but not all of the codes
are returned consistently by the helper: 1 will usually refer to a
"value not found", but usage errors can also return 1 or 128. Moreover,
128 is also expected on errors within the configset functions. These
inconsistent uses of the exit codes can lead to false positives in the
tests. Although all tests which expect errors and check the helper's
exit code currently also check the output, it's still better to
standardize the exit codes and avoid future problems in new tests.
While we are here, let's also check that we have the expected argc for
configset_get_value and configset_get_value_multi, before trying to use
argv.

Note: this change is implemented with the unification of the exit
labels. This might seem unnecessary, for now, but it will benefit the
next patch, which will increase the cleanup section.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/helper/test-config.c | 76 ++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 234c722b48..1c8e965840 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -30,6 +30,14 @@
  * iterate -> iterate over all values using git_config(), and print some
  *            data for each
  *
+ * Exit codes:
+ *     0:   success
+ *     1:   value not found for the given config key
+ *     2:   config file path given as argument is inaccessible or doesn't exist
+ *     129: test-config usage error
+ *
+ * Note: tests may also expect 128 for die() calls in the config machinery.
+ *
  * Examples:
  *
  * To print the value with highest priority for key "foo.bAr Baz.rock":
@@ -64,35 +72,42 @@ static int early_config_cb(const char *var, const char *value, void *vdata)
 	return 0;
 }
 
+enum test_config_exit_code {
+	TC_SUCCESS = 0,
+	TC_VALUE_NOT_FOUND = 1,
+	TC_CONFIG_FILE_ERROR = 2,
+	TC_USAGE_ERROR = 129,
+};
+
 int cmd__config(int argc, const char **argv)
 {
 	int i, val;
 	const char *v;
 	const struct string_list *strptr;
 	struct config_set cs;
+	enum test_config_exit_code ret = TC_SUCCESS;
 
 	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
 		read_early_config(early_config_cb, (void *)argv[2]);
-		return 0;
+		return TC_SUCCESS;
 	}
 
 	setup_git_directory();
 
 	git_configset_init(&cs);
 
-	if (argc < 2) {
-		fprintf(stderr, "Please, provide a command name on the command-line\n");
-		goto exit1;
-	} else if (argc == 3 && !strcmp(argv[1], "get_value")) {
+	if (argc < 2)
+		goto print_usage_error;
+
+	if (argc == 3 && !strcmp(argv[1], "get_value")) {
 		if (!git_config_get_value(argv[2], &v)) {
 			if (!v)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_value_multi")) {
 		strptr = git_config_get_value_multi(argv[2]);
@@ -104,41 +119,38 @@ int cmd__config(int argc, const char **argv)
 				else
 					printf("%s\n", v);
 			}
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_int")) {
 		if (!git_config_get_int(argv[2], &val)) {
 			printf("%d\n", val);
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_bool")) {
 		if (!git_config_get_bool(argv[2], &val)) {
 			printf("%d\n", val);
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc == 3 && !strcmp(argv[1], "get_string")) {
 		if (!git_config_get_string_const(argv[2], &v)) {
 			printf("%s\n", v);
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (!strcmp(argv[1], "configset_get_value")) {
+	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
 		for (i = 3; i < argc; i++) {
 			int err;
 			if ((err = git_configset_add_file(&cs, argv[i]))) {
 				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
-				goto exit2;
+				ret = TC_CONFIG_FILE_ERROR;
+				goto out;
 			}
 		}
 		if (!git_configset_get_value(&cs, argv[2], &v)) {
@@ -146,17 +158,17 @@ int cmd__config(int argc, const char **argv)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
-	} else if (!strcmp(argv[1], "configset_get_value_multi")) {
+	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value_multi")) {
 		for (i = 3; i < argc; i++) {
 			int err;
 			if ((err = git_configset_add_file(&cs, argv[i]))) {
 				fprintf(stderr, "Error (%d) reading configuration file %s.\n", err, argv[i]);
-				goto exit2;
+				ret = TC_CONFIG_FILE_ERROR;
+				goto out;
 			}
 		}
 		strptr = git_configset_get_value_multi(&cs, argv[2]);
@@ -168,27 +180,19 @@ int cmd__config(int argc, const char **argv)
 				else
 					printf("%s\n", v);
 			}
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (!strcmp(argv[1], "iterate")) {
 		git_config(iterate_cb, NULL);
-		goto exit0;
+	} else {
+print_usage_error:
+		fprintf(stderr, "Invalid syntax. Usage: test-tool config <cmd> [args]\n");
+		ret = TC_USAGE_ERROR;
 	}
 
-	die("%s: Please check the syntax and the function name", argv[0]);
-
-exit0:
-	git_configset_clear(&cs);
-	return 0;
-
-exit1:
-	git_configset_clear(&cs);
-	return 1;
-
-exit2:
+out:
 	git_configset_clear(&cs);
-	return 2;
+	return ret;
 }
-- 
2.26.2

