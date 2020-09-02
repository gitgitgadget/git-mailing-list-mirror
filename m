Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F86CC433E6
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356612078B
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="hXQaEoKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIBGSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIBGSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 02:18:09 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FA1C061245
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 23:18:08 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cr8so1708932qvb.10
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 23:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gutTMBWQcXZvTvbeTWmzfnFmvj4Welmjr1oQOJ5ojyU=;
        b=hXQaEoKryn9X7me+IoA4WJgYSggDUPfdVa0tEux+0bcaFvjep4/MMyhp7ibiOGUtcD
         Jh5+Z7aIq+KsaWGzTgvK+GrSlWMq2lwrW5KF5NQkegoqm+dWUCU9cSUINy/tRh1Wo+Ks
         IwbWy5A4OmNuYLfFznBVI7cq7bv0H/K8WBcndrvXxfZfvc2p7jJiCN0BGyPnz4efoM6k
         rVcta2QktcqxDng95zBSQZiY9Zghfp3CJvg597mDNUZGd7V6DM4bMJwpk93GagXueK7r
         NRGZC4OlpjvOCxKx2jCRH4+sYI2AJF+B3e9N8X0qE79KWUwRmAO1tOmzD9WJNvxPo2mA
         I7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gutTMBWQcXZvTvbeTWmzfnFmvj4Welmjr1oQOJ5ojyU=;
        b=MERwGuaAVeVOnskkTKJfQ9y1pFjsOk9Sis6+O1riBpHeQtF1IpVqZb6EaHceTWIHeh
         dmmqH/HWs2jJ4YK7qjWTjs2nVW+xC1timGugZw8Rg10C2v8hEZUMz/nMmDMeyCgnxWT+
         DenJQ3jOcEPqLn85h5DiTg4qYX8xvqmt9qcvIESndXr4adtOg/lEbgbxPyIYo6Jejz6t
         hFhVggJmLHYzCSHtoTgsu7i+wubOu9biFByPK4lsDeakrr6wdL1p4GY6w9JdJNhiIFmG
         RvusTXXWHLM9ibSdKDkrqmcZPqxg8C7/jphlypebNJHTRLnPxtewYl9IRvLbzpWKv6WH
         jIRg==
X-Gm-Message-State: AOAM532346gbdcduXdb9sRRbC1o3hayHOHXUHUMVNZ0xvqsOteKgIDyw
        aPm44h41pdpFxQzMUO/xySuA3NKYQ6PaDw==
X-Google-Smtp-Source: ABdhPJxZk+avD2PeGy/L3MsTsHyDRKCVso2FU4c1tAHHBG0Z76bCToyiAC190pt9XsT2HFzJFfXnGQ==
X-Received: by 2002:a05:6214:570:: with SMTP id cj16mr5561143qvb.24.1599027486488;
        Tue, 01 Sep 2020 23:18:06 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id x28sm3731234qki.55.2020.09.01.23.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 23:18:05 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCH v5 4/8] t/helper/test-config: check argc before accessing argv
Date:   Wed,  2 Sep 2020 03:17:33 -0300
Message-Id: <0750191342754bcca398c6fdad522616b0f3fbc3.1599026986.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599026986.git.matheus.bernardino@usp.br>
References: <cover.1599026986.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Check that we have the expected argc in 'configset_get_value' and
'configset_get_value_multi' before trying to access argv elements.

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

