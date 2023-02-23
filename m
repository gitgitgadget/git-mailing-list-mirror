Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077EEC6379F
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjBWJPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjBWJPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:15:09 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1B14743B
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 6so9661386wrb.11
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibJFEY2845SF2kCE5VmDJ9DqXOWGeSi626LGlcwBZc8=;
        b=HVeQGQlbV4A0zb4wie+YrbUN4gzmgkMRJNiNagiHbFN0+wuUf0Q0YFbjOY75TUJQdn
         9G4QTN6wTk8AxONzXUxWnawkldcGS0bt66MIxfPulVBUVveWmnPXkVg2b9o3wFJH8C37
         YzZyEFAlXigoDAdwdjCzEWt5C6LeR5jkA1GlxTWJ7kQeV9jlD0Sr+b/Cx8nhTdTmxUR+
         UCHIrT1p64WQcDH7NOZe51CsGLf+FRfyloiosWwDMrRG/MFGMTVqB0d0vueB6+ummvS9
         5vyH7bO6r2oEayUFIrjq+1v9j4QKtxe9DlV+XfrLgGgLTJF3/FCfoFuvikIBVkjskkgM
         YsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibJFEY2845SF2kCE5VmDJ9DqXOWGeSi626LGlcwBZc8=;
        b=tg+WUiI7cMQrDDbyaV5OjcUE0APXXvwseJZcm8mPQfZHffvv8HSDZTKPemj6KIX3Ec
         YYp8Ngap+cE1zW8cF3TVEKCMV3qfxePvBHCggYeNpW7PwtV004DX29T2fnP/knIFT6rL
         nYghfIK/alQO0d2WZolHMh288vjb1ZjhKV8UogjWOgDABs2bs+j20E9xj3fROboty/z7
         yFe1HbomvDNDMFMJS/KRimV1jwhBhkbMtprX8wk5Dwgax+rWiLzV+vl0QsahBQZSXR9i
         f8Aja00LBNrpQoQRCOzUU/geizm8n1Lbksw2O/TeETRnLFzAxcLR5tLUOtBCNIp4vTaA
         1UAA==
X-Gm-Message-State: AO0yUKW9yAwvHGfdZj72sYe6pvWmhehdSQ/veLm3ya8d12wNdWo338T6
        KFCfnhEfND+LFh1a955CJkeUve28T3Y=
X-Google-Smtp-Source: AK7set+baehvKh1uv+1MPm7QSX3z8YWUs5PbY/tW0GAcgyKfobTv2X6b18gFGPPAmVngzigoasH3aA==
X-Received: by 2002:a5d:4748:0:b0:2c5:592b:b71b with SMTP id o8-20020a5d4748000000b002c5592bb71bmr11533740wrs.45.1677143706378;
        Thu, 23 Feb 2023 01:15:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r189-20020a1c2bc6000000b003d9aa76dc6asm2799172wmr.0.2023.02.23.01.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:15:06 -0800 (PST)
Message-Id: <8955b45e35474e5feb826101423470d0b51e5470.1677143700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 09:14:55 +0000
Subject: [PATCH 06/11] sparse-checkout: avoid using internal API of
 unpack-trees, take 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 2f6b1eb794 ("cache API: add a "INDEX_STATE_INIT" macro/function,
add release_index()", 2023-01-12) mistakenly added some initialization
of a member of unpack_trees_options that was intended to be
internal-only.  Further, it served no purpose as it simply duplicated
the initialization that unpack-trees.c code was already doing.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 4b7390ce367..8d5ae6f2a60 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -217,7 +217,6 @@ static int update_working_directory(struct pattern_list *pl)
 	o.head_idx = -1;
 	o.src_index = r->index;
 	o.dst_index = r->index;
-	index_state_init(&o.result, r);
 	o.skip_sparse_checkout = 0;
 
 	setup_work_tree();
-- 
gitgitgadget

