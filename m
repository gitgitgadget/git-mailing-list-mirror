Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B237211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbeL0QZz (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:25:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36888 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbeL0QZv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:25:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id t18-v6so16659400ljd.4
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 08:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C5nPVHWSS/KtAboKd2lwXxZyhGZcEr3Tm2KFrKoNy8A=;
        b=TRK7LOkLKDsRS51JFu+xEg/kXT6CV30BTfscttpcD77eWjO977whp9lZ5fYnx6M01+
         ng9Bgmialj18KgMTAxLLlvzZUFaFZpJk5Fbps+COESX2mVySsdXAQXRoPVDRseec+mg3
         bmr7Q7N9FUmojLP94u/ucpdMxwQHbX6a3qujonlaqdz3PHy9gxbR66O61zUTWKBgNa2J
         jAA6PSVroAhoUu/zbdtNoJnvEhs8ArBfXD8Kf/0FNUR6an5E3U7uZL+2uxOV+GZrs1Xq
         /CMkNrIo0w4WhHTWmNvu4/nwWrlRCR8uMRCJRP0RjbuLhPN+Hwhfr3NdEY9lGlwvoHLL
         zugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C5nPVHWSS/KtAboKd2lwXxZyhGZcEr3Tm2KFrKoNy8A=;
        b=mIn+YTeFIghzJwHa+GXf77VSvpJxyKf283LBoHGepSGNeQw9E82/WMS5iRdTBUmhs0
         eFcAqIUq1T2VUQ63iHPlidr0VZwmwjgZ9P2l6gQYKvFlnE06HcG4D+6h3+0gZI9nRkQp
         PjyGFzVw8sCPmDk6b9r4Qy2iKHtPW4q3I1G65N/EMfaZEZz7ArLNNgxWApXjt6fP4bVO
         BjY49Mn+Ypvb2hg3NyU0FsTL3vFVERH4N6sZQjXsAV2RDqUVYbIiMuA8CStk48LkvH6T
         OcSTTSEdvVEBGimPB/a9aAVj7ZU+9Kb8TRuknZhsxkT+wZ51h1c48upH2rsIZ1FI2dro
         Td6Q==
X-Gm-Message-State: AJcUukf5o/7DdgcM/dmLWDDEk4rnzax6qmm86y4WutjiHTyh/UutK8Dj
        D2YH74KdRfQdLJ4KSmBOh17HWCSB
X-Google-Smtp-Source: ALg8bN4ydReWQnzU6/9Id29fTPy+v8SWiFfunyso4q3tXyM7ocZitwzkuW+lPC31FMi5j7hip/3ofw==
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr14198669ljc.66.1545927948740;
        Thu, 27 Dec 2018 08:25:48 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id a127sm7643106lfe.73.2018.12.27.08.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:25:47 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/75] parse-options: allow keep-unknown + stop-at-non-opt combination
Date:   Thu, 27 Dec 2018 17:25:24 +0100
Message-Id: <20181227162536.15895-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227162536.15895-1-pclouds@gmail.com>
References: <20181227162536.15895-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two are orthogonal. One is about unknown _option_ while the
other non-option.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index d47e217b07..4cbcefc262 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -426,9 +426,6 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	ctx->prefix = prefix;
 	ctx->cpidx = ((flags & PARSE_OPT_KEEP_ARGV0) != 0);
 	ctx->flags = flags;
-	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
-	    (flags & PARSE_OPT_STOP_AT_NON_OPTION))
-		die("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
 	if ((flags & PARSE_OPT_ONE_SHOT) &&
 	    (flags & PARSE_OPT_KEEP_ARGV0))
 		BUG("Can't keep argv0 if you don't have it");
-- 
2.20.0.482.g66447595a7

