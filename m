Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDA0C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3FB820C09
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="lXiYHPwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgIJRXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgIJRVy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:21:54 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F16C061795
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:21:54 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 16so6860268qkf.4
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0J6TixHuhkP+ec6olUDedm/4dAzFDoGAvs6N2S5ptn0=;
        b=lXiYHPwt8Bkv1hEwj4/4YNZwMEOXbdVnZKPBzS0bMVObw6c9J0vRix+XnIv1h6mwOV
         qv3mSsBs8JsIjeMf/1pvzesww4XCUuE79a6EbqagoIkKzY8IFJKyejskWw8cPcqtj6C2
         sqxpNpxuH0o3WW9twPFOlGdupchm2/dsPTsHmKFWsXz+yqY6r3Sev6vnXtzg/RLDCG0O
         n6dqhRSg/4zU7BKd8XrjBBsTqYaAUhiEAZaUApEi2wp8aoJ+k3Yo+DiQyUBjPXcIltMh
         feJudXgeFofqfccpBxo8oMWahsrikgFYqi0E9uDjzvUbr2rdV3QptRx2UwkgLGtXFB/6
         YLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0J6TixHuhkP+ec6olUDedm/4dAzFDoGAvs6N2S5ptn0=;
        b=U3bifH/J7eMbWgSx3tyAbT5r6cHJNtmUxstZaoVhh9ph35FJV9e3pBT9zVQlCdsYOh
         QQqQhsHo6agm7USYoXb/imxzWEbkPP4rykd49XXRy0x37rCCLVOoCtiBU7tmdh8ktx/u
         A+eg933b1kf5VOpcQ8yS7sAcq+Zql37eAZYWp3oaugF1TSqQqBp7+/MzDOw21Xanbmef
         AzTeelYJB4yZrow65LR+ONQfaJjraSOfwQnIF5qWlyIm8YIBnllpYHc0sRtPK4ws9gYx
         33UkOIlSjqEPwgtJXvgWplnuYouTPgLmTz7OXa8EtjrTaQOZhc9ELVnIpEnRhwWnRNQ5
         sKmg==
X-Gm-Message-State: AOAM533T2pJvVZ/2qYcy0YW1DPvhjbUE1yDvNRAf7dQtOF9G3/Dj0r4F
        ab/7jq95WLjCZvHxrJlYpjQmkr7J2Stkyw==
X-Google-Smtp-Source: ABdhPJy56R9AFtfomdOyacwPYTlKz8c8Fky3+dDS9YgwsLPrmhNGj3+zeatXc9kogzl9uBkQQ0+ZRQ==
X-Received: by 2002:a37:38c:: with SMTP id 134mr8624898qkd.193.1599758513010;
        Thu, 10 Sep 2020 10:21:53 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id h18sm7037437qkl.12.2020.09.10.10.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:21:51 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v6 4/9] t/helper/test-config: diagnose missing arguments
Date:   Thu, 10 Sep 2020 14:21:23 -0300
Message-Id: <51656e43c35e5b83a004dcd7ed34499a0ebed137.1599758167.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599758167.git.matheus.bernardino@usp.br>
References: <cover.1599758167.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test-config verifies that the correct number of arguments was given for
all of its commands except for 'configset_get_value' and
'configset_get_value_multi'. Add the check to these two, so that we
properly report missing arguments and prevent out-of-bounds access to
argv[].

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/helper/test-config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 9e9d50099a..26d9c2ac4c 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -138,7 +138,7 @@ int cmd__config(int argc, const char **argv)
 			printf("Value not found for \"%s\"\n", argv[2]);
 			goto exit1;
 		}
-	} else if (!strcmp(argv[1], "configset_get_value")) {
+	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value")) {
 		for (i = 3; i < argc; i++) {
 			int err;
 			if ((err = git_configset_add_file(&cs, argv[i]))) {
@@ -156,7 +156,7 @@ int cmd__config(int argc, const char **argv)
 			printf("Value not found for \"%s\"\n", argv[2]);
 			goto exit1;
 		}
-	} else if (!strcmp(argv[1], "configset_get_value_multi")) {
+	} else if (argc >= 3 && !strcmp(argv[1], "configset_get_value_multi")) {
 		for (i = 3; i < argc; i++) {
 			int err;
 			if ((err = git_configset_add_file(&cs, argv[i]))) {
-- 
2.28.0

