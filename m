Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A598C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12192207DE
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ynwq8t8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgIBGSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgIBGSK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 02:18:10 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608B8C061246
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 23:18:10 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n133so3177328qkn.11
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 23:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dESF7Sm/w3iAeMF9TzCd7uzNUhtLayXGCYW6gi807Ss=;
        b=ynwq8t8C/k/OJRcO3CGvAbMLhozwhcceEGGGBbx2f/f7WOOcF4I+AmPX0wlz8UJgoV
         1Ei4fk+MeF2Y1nM5exr8XVvS5US2smbLbLS8h3nBiDnVAmWlAcM1ncPmB1rp0yjgQUBM
         2NCO3vLiVS4sQwPIvgVCoyJWM/FK0n3jYNmprm1Ua0eW0v33ZOd4PHbhDCdXg6cZmRZU
         RjFwuM7VsJVW6KNzNa7pUG+vJdL2jIUT3JaxeQGr2xd8LMZzb0Vj9TtIj1EPfLRNbZC+
         SsG3/ujMgtf3slL8lgjX1+pzJISlDCQ7vmRgMj2BAmbU61LwvMZduTT7iFHcrFuNsydP
         NS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dESF7Sm/w3iAeMF9TzCd7uzNUhtLayXGCYW6gi807Ss=;
        b=gtsb2CjztqLJ2zENtOEyQ2q6RaQmOT9bFs/FSizBF1XxLucdbAmQ0H/dAvzPHG92pp
         4mvohg+CgZwrg5vz7BRHt1lkgmhEYy3J5W1a9zkyPyg7UmBboJgY4AbCcwOE54PIo/2/
         qdXcDRjA3sdkN6Z8aw3PdixYqJqwKqnf7VgKsPPnOd97Vxwh6JzBeQJmyyMFskf9xMgx
         g9kDRa+KtTFNthpSUhABSTgkuhcx2HW3JCGAMqNiIMOpMgNZi6tP/AKHXeS6EOZJkVEA
         nDnrCOqClizxJgEVo+rvEpCkRd5F9T0LGw9SlUP3chZSi1usbdtM7qN/nrE40oZ2Quc4
         sGRw==
X-Gm-Message-State: AOAM531u7qTBeBwmok4lW9rU4JDCK7x0/8VsgYyA6IjQlmd3hDfgHx4L
        d+PIDzVZrI2zMj2jkRBf60YofDvFVWwdQQ==
X-Google-Smtp-Source: ABdhPJxiHk3VZaJU+VxcIozUS1s2wtnyjBF4b2O0CYfKf3z2h9B2LIwmRm3zheNClxXEvFnyRibOvQ==
X-Received: by 2002:a37:e82:: with SMTP id 124mr5461977qko.77.1599027489173;
        Tue, 01 Sep 2020 23:18:09 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id x28sm3731234qki.55.2020.09.01.23.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 23:18:08 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCH v5 5/8] t/helper/test-config: unify exit labels
Date:   Wed,  2 Sep 2020 03:17:34 -0300
Message-Id: <56535b0e36e94dc73aa570f4f3c0466305c6432f.1599026986.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599026986.git.matheus.bernardino@usp.br>
References: <cover.1599026986.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test-config's main function has three different exit labels, all of
which have to perform the same cleanup code before returning. Unify the
labels in preparation for the next patch which will increase the cleanup
section.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/helper/test-config.c | 51 +++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 26d9c2ac4c..8fe43e9775 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -69,16 +69,19 @@ static int early_config_cb(const char *var, const char *value, void *vdata)
 	return 0;
 }
 
+#define TC_VALUE_NOT_FOUND 1
+#define TC_CONFIG_FILE_ERROR 2
+
 int cmd__config(int argc, const char **argv)
 {
-	int i, val;
+	int i, val, ret = 0;
 	const char *v;
 	const struct string_list *strptr;
 	struct config_set cs;
 
 	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
 		read_early_config(early_config_cb, (void *)argv[2]);
-		return 0;
+		return ret;
 	}
 
 	setup_git_directory();
@@ -94,10 +97,9 @@ int cmd__config(int argc, const char **argv)
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
@@ -109,41 +111,38 @@ int cmd__config(int argc, const char **argv)
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
 		if (!git_config_get_string_tmp(argv[2], &v)) {
 			printf("%s\n", v);
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
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
@@ -151,17 +150,17 @@ int cmd__config(int argc, const char **argv)
 				printf("(NULL)\n");
 			else
 				printf("%s\n", v);
-			goto exit0;
 		} else {
 			printf("Value not found for \"%s\"\n", argv[2]);
-			goto exit1;
+			ret = TC_VALUE_NOT_FOUND;
 		}
 	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value_multi")) {
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
@@ -173,27 +172,17 @@ int cmd__config(int argc, const char **argv)
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
+		die("%s: Please check the syntax and the function name", argv[0]);
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
2.28.0

