Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0757AC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbiF0Sg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240202AbiF0Sg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377F9186F4
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o16so14288628wra.4
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oQg7hS7LlJt/v3EtqBKXz/U9lqK+1s0M2CiZKor15J4=;
        b=G9K02qftiANFqWnNAfhdQm/GGxed+xXZ1l4h7pvMwsYnKbaxfhUOyXjsegZuekrZ2U
         ivkFWb0Hryu3E0VqduZBJuLJa+XX/GisJpY4yu4INgdZP8IbTFYrAJwVnLNV+RBkJrn6
         PvbGPFPGV+5a6cYGabaQoAZXx0+9Gjbg2ipn5r6V60zHnNfWAHcYRNtabKD7W9AQFjTz
         i/nR4fANshsNoj3wQtB02YJ7SMwMDAIG5lj2w4ce+IF6xVVsIAryJckaKk3pQ2mu90Qb
         RpknA6XgGsrHj6/Tv/ZRTWPlGrGnLUJrQx5RoflFjNajYyNE6jxXmFaxM4wDwH4zKyp9
         ZbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oQg7hS7LlJt/v3EtqBKXz/U9lqK+1s0M2CiZKor15J4=;
        b=K6ZScvmr3nCqXBe7b/YRop81bfvduArukiIZsITPd4Slf5RrRLVjVHj/8mZS6jsVkR
         zpyJP0UvmQnCwApvcOCthHithgTS/bHvWVfEr4AyGi4NRKs4qo4YfSPQKiTX2XZ6oabE
         SPYXqqfADTU7btXh51AWFBYGtuNtyXAWhxp61+P6HjebCoabnTQduw37bYO8ER7pBtBp
         W2BU4WU9e9L+dcsLzQ4IG8QDnuY/ztR0A08TBfHaYzYfv9O1CmuKTvPLXv/kzcg96Qdi
         n9elwI6v/sgML1txbS+a9bxhmdcekW0Ei6wYTRlw+VPoSS9tLW1FzsJIiGIHSwR0HstN
         KWqQ==
X-Gm-Message-State: AJIora/aKGV5Bcz+rk6x1LlHwb9Wtpq4brHGHBQ0Ycd8EHu8E08Fubq2
        /G0CRLGKAZzPJk/SSU2Bl+C0U7qSVrYClg==
X-Google-Smtp-Source: AGRyM1v+X/yoLDJ72BlV2uTbar60nFA5HJUCIjBLmOsUKXtctY0/RqC6V61WGDGg2QNfhE3+tendTA==
X-Received: by 2002:a5d:6c64:0:b0:219:ea71:306f with SMTP id r4-20020a5d6c64000000b00219ea71306fmr13190980wrz.223.1656354686311;
        Mon, 27 Jun 2022 11:31:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g20-20020a1c4e14000000b003a02de5de80sm18198593wmh.4.2022.06.27.11.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:25 -0700 (PDT)
Message-Id: <b94b7bb4fd0ea19871683cfe2b9fad86cd189454.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:07 +0000
Subject: [PATCH v4 06/16] bisect--helper: really retire `--bisect-autostart`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since b0f6494f70f (bisect--helper: retire `--bisect-autostart`
subcommand, 2020-10-15), the `--bisect-autostart` option is no more. But
we kept the `enum` value of the command mode around. Let's drop it, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 75d008d7fa8..477aba811f0 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1282,7 +1282,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_RESET = 1,
 		BISECT_TERMS,
 		BISECT_START,
-		BISECT_AUTOSTART,
 		BISECT_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
-- 
gitgitgadget

