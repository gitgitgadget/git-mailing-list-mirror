Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44A3C6FA83
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 18:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiIESuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 14:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiIESuS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 14:50:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4F12714E
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 11:50:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r4so12341942edi.8
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Iyb5iabM/bJ/vGyXf7iP26tuMpGNgA+LStOErTvREmo=;
        b=N5kNc0zNjm8U1QkEQweu5XAAYhviVlwKrfkCsEqc1rwn13ahyeaEpNxo5xcW+anOq2
         VJqZxunL5ZSZvkHgJi0PVCTAQlGhztjxMGYYZDwdbHRn8gI1ppoRJFcaGWLvKXKMuZGF
         hrMeAE1qQAfbkKDoSC2kxp9dm+2KSRt1z0a+cyyDsTWGPSTvbm1M0Q/0EyyxpaRwQuZr
         VNJljgpGdipwlNzXclon3zfWndKnTEyzbLvmxywTPXkgaJp4KCauRbhyspHD+diXLlX/
         h7R4mRzDCiiKenpL6OqCcVBJrZW8nepVUbarSdonAJ2mJvrvVTJGAJuOQP4XqrA75pfV
         jaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Iyb5iabM/bJ/vGyXf7iP26tuMpGNgA+LStOErTvREmo=;
        b=0IzXXrNYLBpATMQF+79JoIxRpCp1WfViYUPm11CxFw1DM8ginygm9jAdFiNtZ5gYiW
         53zi8+DKEyhsCCGeqA4jLqMVp4ijtmCSEMImamPfUzrt57SIcxuzcwbEt8KHkPFMb0tv
         WSynX3kH7nzMWfQfUmUzJYCOLpm6wBhxcNgRNdNJlc+m2rY5sYmxpKexIuspUQkyk9mu
         wi/K3zW6w6vhlRwQNEj6ENo3omraOOK1POFBDB9Fwsm4bpiX5Dyd7TK2W/ByOotwP6d7
         WdimyeE6qVP8YY4YXX2+fOUJOd5sCJ7uZaGlLTZsch8PbbO/Jz1AwtxQWVC6+Q7FPG+T
         SvZQ==
X-Gm-Message-State: ACgBeo0j0moFhsYz+w/wLFySXCiJP5sxnpVonghifeIw1jJR3UexruLs
        9/vMZUunDV/yWFCLiUmN3hKRhWdW1fk=
X-Google-Smtp-Source: AA6agR7m07VS3Be/iYydYkhiP8Xno/hQBOsXUmOmAGAxo6VkG12bqKa7v6wZH3ZWuH5OeB4fgQPA1A==
X-Received: by 2002:a05:6402:51cb:b0:448:3f0c:4085 with SMTP id r11-20020a05640251cb00b004483f0c4085mr35639341edd.170.1662403814054;
        Mon, 05 Sep 2022 11:50:14 -0700 (PDT)
Received: from localhost (62-165-236-110.pool.digikabel.hu. [62.165.236.110])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7d497000000b0044ec3285b23sm290975edr.58.2022.09.05.11.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 11:50:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/5] test-parse-options.c: don't use for loop initial declaration
Date:   Mon,  5 Sep 2022 20:50:04 +0200
Message-Id: <20220905185007.9042-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.3.989.g4c3dfb3304
In-Reply-To: <20220905185007.9042-1-szeder.dev@gmail.com>
References: <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220905185007.9042-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We would like to eventually use for loop initial declarations in our
codebase, but we are not there yet.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/helper/test-parse-options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index aa0ad45851..9fe8ce66cb 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -195,7 +195,8 @@ int cmd__parse_options(int argc, const char **argv)
 
 static void print_args(int argc, const char **argv)
 {
-	for (int i = 0; i < argc; i++)
+	int i;
+	for (i = 0; i < argc; i++)
 		printf("arg %02d: %s\n", i, argv[i]);
 }
 
-- 
2.37.3.989.g4c3dfb3304

