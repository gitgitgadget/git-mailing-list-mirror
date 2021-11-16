Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5451BC4321E
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A85E63218
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhKPJxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbhKPJwu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:50 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C24C061767
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:51 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d5so36356360wrc.1
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B2qNreqxPbVLHXZVbNIw1FNvHSOsXYeU20/GeFvd7zY=;
        b=az0M430aY79hhByhTNVsinq6YQXiMyejy6e0pmrO97ZUb2Vg7Iabl/xIypQwfuQMj9
         nCmKWUGdznsuDytawNXF4MqbIop2uNQjdOhLgChik1NW+S9LMnxEpy0yiX8BZEq2u3yJ
         Me3KGeyS56Yn5c12IyicaC4IvT4jjavqcn1kjBkKr/SVXBOu3bI08sqzINMl46f5QM+M
         ZPs9+x0RHrMHeC6SR9qNi1PY3VTTXbPxqtILC62LexS9EFDCn8j7n8RFoOfd11QUXO1C
         kq2xeRffwI31P91pe5pl+G1Q95zexG1QVPT+mVpyR41B4mGwe/24Pn7mCuUrf+BibV1n
         /qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B2qNreqxPbVLHXZVbNIw1FNvHSOsXYeU20/GeFvd7zY=;
        b=GUcE8u7CcsaqY2is694LTWhrVRbNnvFRogCKFRrXfTSsLP+dc8Tao0r4dKv8M5/7xA
         qOZLI0vsXKbSMHnU8W7WevttGIEB0bwq/wA5VcE7b/sWHgukwlo7mz2+gn1y+Ntd8udB
         vXm5B+WYzQ4z7tzLd1/dEASCfRniJy7yybklXwT962XrGWWG+1Ggml//2EfaHBHj11mu
         theaVPdeFcWWKxa3k8HrAiry4gWE7cMPTu+zYvfetFWam/Je1HwS9uhPwc5r89ErPBHW
         TWFAKJsudlD9c4MsjLlkoqLW3zKz3j+y3hA64ELrQpSH+qyeKUCaN1aA9qT3KyY9fj12
         EU+A==
X-Gm-Message-State: AOAM533P0rxVc8qGnUYWk4MxU2d+3tE7O0+ae9tf5WAPnCH+P9wcdM/n
        ep942ld84QyrJS0K6Zv/O7twjDxsea0=
X-Google-Smtp-Source: ABdhPJwzlYDDcy6cchZZrfgHtqJ24o4+PM3CNzqfsUMCHIwQt38+9C85imcfXcgulBNuEvcAQ0aeUw==
X-Received: by 2002:a05:6000:23a:: with SMTP id l26mr7506091wrz.215.1637056190422;
        Tue, 16 Nov 2021 01:49:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm16732301wrw.55.2021.11.16.01.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:49:50 -0800 (PST)
Message-Id: <d44c5d734c3743c7468876e90e94bc6304ad3542.1637056179.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 09:49:37 +0000
Subject: [PATCH v4 14/15] diff: use designated initializers for
 emitted_diff_symbol
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This makes it clearer which fields are being explicitly initialized
and will simplify the next commit where we add a new field to the
struct.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 2085c063675..9ef88d7665a 100644
--- a/diff.c
+++ b/diff.c
@@ -1497,7 +1497,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len, unsigned flags)
 {
-	struct emitted_diff_symbol e = {line, len, flags, 0, 0, s};
+	struct emitted_diff_symbol e = {
+		.line = line, .len = len, .flags = flags, .s = s
+	};
 
 	if (o->emitted_symbols)
 		append_emitted_diff_symbol(o, &e);
-- 
gitgitgadget

