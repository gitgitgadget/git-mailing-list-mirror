Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4924DC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338A5610A0
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbhJ0MH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241799AbhJ0MHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:07:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571FBC06118D
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso6061489wmd.3
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B2qNreqxPbVLHXZVbNIw1FNvHSOsXYeU20/GeFvd7zY=;
        b=M9bwPztaiDFMSjVzO8GlFPWvOS28hK5NBMyuZ7AeZV/LnGH6FJXjSHCIWIk7ah1Njv
         4Kt4mFmkWReBbaQZmn4sN3+EIuYTohdyp3vdjhRlFuCVWqlQLEx4rtFoyuFabfAtp5Dp
         SIJUN7tn2eS+WaD8QP5PUwut6c7Zg4yBPfXHHgn7GfeDeIba/U9rjs5S9nXefVYdV+iC
         yIkoqhjKRR3vFxL81lrqwBO1vKfLVTx7pV9BONfJ/QkkjjzBDKZrlXsG4XxfVH4m9edI
         HlYEELphc1pisGqwOrdqPy2OGyyCfSMD9Kh3OIgBKr8KY2/G/jRJWMUs/39H1XNQ1Qnr
         zr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B2qNreqxPbVLHXZVbNIw1FNvHSOsXYeU20/GeFvd7zY=;
        b=EhNS1j+VIX5eddVhSD0Gmz/a3ZYDLi1m6cKFuUS56sDhtrX9Q7SZmloCRhhRe6oT6c
         vBJLul47zz4YL+2BRWj8W8oxqU5U3dmTps5c8hGCEu1j8nIAck72Ul3QxTRDLalAGe1k
         rG0dRibi4jFVMQFvLYsHaM0OThNGZGC/WeNuAlusovf5JEwJwMN9fsyt0+8mbwP3j/Sc
         D8nks+zJhpjiZklBaDaAU8EzC/MKsNKGKoYCPmj1hrcLjmPYmy3JVmAQlvR7xgua6zeg
         pSENvo74iTJiMUY/SprzzjDOdJDwMu6tNhEcgMrceTM1EAXObKBAhUH9kH0HGmvWDiVB
         FpQw==
X-Gm-Message-State: AOAM533wOl1gAq6XLh9QcstWOnCHpTV/fruVurzqx+0MROhBghaG2QMW
        EwvUUNWBg+/8JYaPKeIO+hUoM6r0f4g=
X-Google-Smtp-Source: ABdhPJyrNxhWCfLSXn+vaKdOBO5LxhdTVhMbTA5uRz0K4PMq1B4kuyiknNYNA9xwpT4W1aqWVQLmUA==
X-Received: by 2002:a05:600c:24d:: with SMTP id 13mr2254687wmj.64.1635336276950;
        Wed, 27 Oct 2021 05:04:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17sm3405265wmk.23.2021.10.27.05.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:04:36 -0700 (PDT)
Message-Id: <ef98a6e70153a2de9b4d63b5ba170e1c69e00d03.1635336263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
        <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 12:04:21 +0000
Subject: [PATCH v3 14/15] diff: use designated initializers for
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

