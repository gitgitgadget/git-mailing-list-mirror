Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47030C43219
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0196321A
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhKPJxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbhKPJwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:47 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F4CC061746
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:50 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w29so36276146wra.12
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hbX6ChgF1/7zCe8TRq2mAwsHjDZd1Mp8/GA16/PwtSw=;
        b=DzazYMd+tHDdyaK3OfHPAaPbq14OTaqizCaSE2hIa+5uMRP+sjp0KTtZwqlxzT+Iqy
         SzIoqJZKJ/Wj1Q7YM2BNWOGrb9GOJRYhm5xpsi22u7IFEiF2KBsYRllI2o36KlmjejhC
         MI2JBWKPO8KG52zOhB94YV3zKlzGE1h2S0phvABdndvewqyIih8Ph7BgtnCNZPDnfnHx
         UU5u0kRN9q0XDlVW6Odd7F+NfibVKLm7KWWvQUM27LIzjpD8ivta9CbWPu+5PXJx7wXr
         MngqdzJBrFS9+EOxeziIw/Sm3BqXDNlhzuBe6PhuuLHW8wKOEm+7FwtnoT1VU4TwBFeB
         r2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hbX6ChgF1/7zCe8TRq2mAwsHjDZd1Mp8/GA16/PwtSw=;
        b=7Ax53Y5iOXEgyaN9N3dGi/BeyDKXEhciydnXx/DyNBeKwC6nquO3r76XAStn5AZ/Wp
         fk8rVGhsnqCUd3YC5J4NVJLYmTdL6i5pyWLzJRf8tZaqYcHxRQKITEK0kPtHUXz3fWD+
         t06DYXcFmRY4uSnScr9ALOiQnSJKr854ic3x4oP3FbnwN/9++B79mHmCenQeIpR4OV6R
         d2hcOHX1sLoWtdsO8lvX1MNlE0htm9m96TlX6Xdbgcm+HcGzK+4tzQb9JwzW0JCoRsXl
         ZIO/DAEzN5luW5lKmMVoZa6be5Z+HWADMAO6zvOQpi7X/oaKI07dkUSBH58wf/CPwHbF
         ENeg==
X-Gm-Message-State: AOAM531OXoqk2kLPHbVX314gu+kjjRZOsmlU7jf43za3vRtbI9P1jQvu
        JC5hEHOV8wEXIHkbuEgVTf3XciaK7XE=
X-Google-Smtp-Source: ABdhPJxp4xHZJmo2wgKPLZfLHHzjitz4g4nZES5olS7iWmB8u0ntGnEQVqqi5gr5bhlrMDJunvUCjw==
X-Received: by 2002:a05:6000:252:: with SMTP id m18mr7606539wrz.117.1637056188996;
        Tue, 16 Nov 2021 01:49:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm17259333wrt.81.2021.11.16.01.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:49:48 -0800 (PST)
Message-Id: <ec329e7946df27e978f6966c6ab23d7db6414ede.1637056179.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 09:49:35 +0000
Subject: [PATCH v4 12/15] diff --color-moved: stop clearing potential moved
 blocks
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

moved_block_clear() was introduced in 74d156f4a1 ("diff
--color-moved-ws: fix double free crash", 2018-10-04) to free the
memory that was allocated when initializing a potential moved
block. However since 21536d077f ("diff --color-moved-ws: modify
allow-indentation-change", 2018-11-23) initializing a potential moved
block no longer allocates any memory. Up until the last commit we were
relying on moved_block_clear() to set the `match` pointer to NULL when
a block stopped matching, but since that commit we do not clear a
moved block that does not match so it does not make sense to clear
them elsewhere.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/diff.c b/diff.c
index 626fd47aa0e..ffbe09937bc 100644
--- a/diff.c
+++ b/diff.c
@@ -807,11 +807,6 @@ struct moved_block {
 	int wsd; /* The whitespace delta of this block */
 };
 
-static void moved_block_clear(struct moved_block *b)
-{
-	memset(b, 0, sizeof(*b));
-}
-
 #define INDENT_BLANKLINE INT_MIN
 
 static void fill_es_indent_data(struct emitted_diff_symbol *es)
@@ -1128,8 +1123,6 @@ static void mark_color_as_moved(struct diff_options *o,
 		}
 
 		if (pmb_nr && (!match || l->s != moved_symbol)) {
-			int i;
-
 			if (!adjust_last_block(o, n, block_length) &&
 			    block_length > 1) {
 				/*
@@ -1139,8 +1132,6 @@ static void mark_color_as_moved(struct diff_options *o,
 				match = NULL;
 				n -= block_length;
 			}
-			for(i = 0; i < pmb_nr; i++)
-				moved_block_clear(&pmb[i]);
 			pmb_nr = 0;
 			block_length = 0;
 			flipped_block = 0;
@@ -1193,8 +1184,6 @@ static void mark_color_as_moved(struct diff_options *o,
 	}
 	adjust_last_block(o, n, block_length);
 
-	for(n = 0; n < pmb_nr; n++)
-		moved_block_clear(&pmb[n]);
 	free(pmb);
 }
 
-- 
gitgitgadget

