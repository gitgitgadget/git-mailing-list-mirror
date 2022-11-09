Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED76C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 14:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiKIOQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiKIOQj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 09:16:39 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F98ADE96
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 06:16:38 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a14so25972525wru.5
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 06:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y96WTLTQB8sPyIOHRLNnyiH0HgZNjZ9qEdCSi4fIzj8=;
        b=mgd/0xkcGlXUobGJcJq0W+a47np7I2EYPh2/RoWn+b9xP4S1ngb8Y8DB7FegwG3o+L
         4cM3sN4wp5lR2Sui32dZBSxGlSh+2/d9LT85q80yThAHBtW4ltNOrprGJpsBILghLgsO
         7SF6rxMWMYpuXCnav8Dk4kEi2/1BJYMlloWX8ZFMRwVqpav9MzwW107qYtaUyt3A+Hq8
         Cuxw2tQXvtfUCJDzbxupoA7cjIwHi06Tcd2F7hNa6BV195LHBkuAOTtiEbHqLGDf5tN5
         YVD24TLBpcMz08LBov6J0Tq7fu8r9Ia3w60ATV05SD1+A2k44ZPSjSOK0Q3if2IDS5GT
         rCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y96WTLTQB8sPyIOHRLNnyiH0HgZNjZ9qEdCSi4fIzj8=;
        b=8Rualdtm6G9d9X5/K9fQl489lKaZCZgdr17h2QQ37ZPcA5yjvE1RHWaADRxbIpsw5m
         2A9pdShKDyunS8LBCyaGxpS4d9nFE4SVmrr8HQsN56Vd3etnSiKnGBG2CXH2MhKuDZZw
         f+n7xkZeXsCEygPBrXrEcPwdbVHOSIU0Xp2vW8ZzS4Eh4w5O+VNGnUylLcTlXujEv6/Z
         u/hfj4fEQ957H4hcw0vuXw5SiZzOSKRwbYfDqYLAT5GiHmOHE59tX+xywtNd+FNDlyC/
         h8lUVmHH5h+Uzkq5IQww0q/fkCkCPuvwkTzRkn7GVuToHHtksZZIwjEK4eSoZEm3zbu2
         TR2Q==
X-Gm-Message-State: ACrzQf0NV2WbOHhzkXXd5kFvqE4niJNjBAq4dQX002rOQi2KY7dtUy4p
        UVUP3jfTyCCfMVUQtbuiGQaSlqUas/A=
X-Google-Smtp-Source: AMsMyM6b3eZG/7bufpcAwIF1t31fDl2vqIuOLSE9M0F4/AjS1jMN+K3bRDKC24D57MOs9RcTxWBvBQ==
X-Received: by 2002:a5d:6d42:0:b0:236:c9a6:5523 with SMTP id k2-20020a5d6d42000000b00236c9a65523mr32990006wri.222.1668003396348;
        Wed, 09 Nov 2022 06:16:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003b95ed78275sm2005906wms.20.2022.11.09.06.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:16:35 -0800 (PST)
Message-Id: <673e6f1ab93200ab3b6b9ca2bded5db5a3274329.1668003388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1389.v2.git.1668003388.gitgitgadget@gmail.com>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
        <pull.1389.v2.git.1668003388.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Nov 2022 14:16:28 +0000
Subject: [PATCH v2 3/3] git_parse_signed(): avoid integer overflow
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

git_parse_signed() checks that the absolute value of the parsed string
is less than or equal to a caller supplied maximum value. When
calculating the absolute value there is a integer overflow if `val ==
INTMAX_MIN`. To fix this avoid negating `val` when it is negative by
having separate overflow checks for positive and negative values.

An alternative would be to special case INTMAX_MIN before negating `val`
as it is always out of range. That would enable us to keep the existing
code but I'm not sure that the current two-stage check is any clearer
than the new version.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 config.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index b7fb68026d8..aad3e00341d 100644
--- a/config.c
+++ b/config.c
@@ -1160,8 +1160,10 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 	if (value && *value) {
 		char *end;
 		intmax_t val;
-		uintmax_t uval;
-		uintmax_t factor;
+		intmax_t factor;
+
+		if (max < 0)
+			BUG("max must be a positive integer");
 
 		errno = 0;
 		val = strtoimax(value, &end, 0);
@@ -1176,9 +1178,8 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 			errno = EINVAL;
 			return 0;
 		}
-		uval = val < 0 ? -val : val;
-		if (unsigned_mult_overflows(factor, uval) ||
-		    factor * uval > max) {
+		if ((val < 0 && -max / factor > val) ||
+		    (val > 0 && max / factor < val)) {
 			errno = ERANGE;
 			return 0;
 		}
-- 
gitgitgadget
