Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DABC4332F
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353343AbiAXTjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352460AbiAXTab (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:30:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241ECC02982F
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:53 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v13so15448942wrv.10
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BFxgNN28edqdOZ+Gb6YENsO0axQWrnuWxBbtDVaOk9s=;
        b=K7Ey1QshAj/m9etUkmYB4NnjIKRtkZq0o96gf5SXUQF6sDwsNRUj3YSaPzRi1F1rPP
         Z2Is8a8toeFUcqmnzdbPuFHDcKaTt6QQ6ZYxQFTi7GX0144Q1h08qWNhoBGfHKVa8mu/
         g36dIBVbl6qkuRU8pS1vG3wPM/bvUotUhBKb1dXsNFXMxDu/IRz5rfaDmn0BhL2vkY8k
         YjjYn+mXgSxg1hZ9Dz1SNUUnURKFavQjA+anjKB8kNQWKZfo4wzeC7doo4Etg/n6HNtA
         wtDqAEfREs8J9113h27lsCMlKTkREBe92fLM+Pu9s1GP429hHAFBkydMCqhLkwsZqLlw
         JAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BFxgNN28edqdOZ+Gb6YENsO0axQWrnuWxBbtDVaOk9s=;
        b=EqMdsIUsIRYgkYN1Smw0s5e+dfQoez2dU4TwZhDiwKEeNQpEJyk8EbFgN7bm8I62we
         QL+Gv7u/18EDlIYL25YfcjzbYyL+yvFFOdfatUtR82ShzV/FRL0GbOebLXdPVcQZTu3w
         E5gvfkRweo7Bafe6H4AuCESjkceSbaBEgLP/Lm7ri7jJ1fjRy0yqbIzydnlIc+awZO0+
         Shi0pMJ7NEiYcQqLENKdMSCB/IB84/iXP5546JqlnCYeHi2D8CqxCTlIzrXcjs2FseQp
         6+SMBGlO5VV9lsaWngvLD2fE1Zv2a94/jwiDb3gFdmj3qHwWA35lFB5cz9p3R6xSCLEu
         9ldA==
X-Gm-Message-State: AOAM530H1p3YNnkbTKCegcRaBGs6GEYnQ2+Tfjbz7QA+9xSZ0aL0BUMF
        BF7/3ZCtdKByg5HPyf2nh8qE2/IwyJP5vQ==
X-Google-Smtp-Source: ABdhPJxWbbN+8cmlrk1892jJxmrEs9PMHFxtNuVqfyFIG6u5wl0JZ5ioOsNZwmmf5FLMbKEZkKONLA==
X-Received: by 2002:a05:6000:144c:: with SMTP id v12mr15525636wrx.218.1643051631604;
        Mon, 24 Jan 2022 11:13:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5sm18710259wrx.114.2022.01.24.11.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:51 -0800 (PST)
Message-Id: <b40d91c50a263e0e816a3b9826541a8bade267fc.1643051624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:35 +0000
Subject: [PATCH v7 07/16] reftable: all xxx_free() functions accept NULL
 arguments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This fixes NULL derefs in error paths. Spotted by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/reader.c | 2 ++
 reftable/writer.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/reftable/reader.c b/reftable/reader.c
index 35781593a29..272378ed1d5 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -646,6 +646,8 @@ int reftable_new_reader(struct reftable_reader **p,
 
 void reftable_reader_free(struct reftable_reader *r)
 {
+	if (!r)
+		return;
 	reader_close(r);
 	reftable_free(r);
 }
diff --git a/reftable/writer.c b/reftable/writer.c
index 35c8649c9b7..83a23daf60b 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -150,6 +150,8 @@ void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
 
 void reftable_writer_free(struct reftable_writer *w)
 {
+	if (!w)
+		return;
 	reftable_free(w->block);
 	reftable_free(w);
 }
-- 
gitgitgadget

