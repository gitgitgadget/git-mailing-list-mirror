Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9397DC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE3161244
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhFNNIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:08:18 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:43615 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbhFNNIO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 09:08:14 -0400
Received: by mail-wr1-f53.google.com with SMTP id r9so14476170wrz.10
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P792OCTN1CeAgO2b7hqLZt7xDjU0IG1sftD1YJbGH8E=;
        b=vKN2c5xfTSSR2tLYfwzjPBF4cBLcbQJuAzq7ACmGYJBJfSc5UNsESgIT218FQxsbjf
         s028DJPUqc68pTThRtO/3+NFawRwGR/pV6yrn3lv7MhG7dQ8D6x8P0sBKEW0ce5H+Hf6
         N3HV8vRbTgwBJc3XCRpb9DQhGLPJdH8rpgE5ipjcceVdB0wb03C/R70cOzQns1dW/M/s
         TuFjycezzy0etTp9WZCzm25pLwm2WjT/+i9ZzgyFXwyjX9PZW42UJln9lrjSR+ZcSSxi
         n82wP2lm1bndAkcK21V645JxYyac43YIO4WojH3QisGnERAZ9vhhknZJdLLRksw0cPCE
         N1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P792OCTN1CeAgO2b7hqLZt7xDjU0IG1sftD1YJbGH8E=;
        b=jux610SgQ0NW9cmDl+cYw8fZkAf7dpLen5XZp077tzwS3ueg2cR8wm6Lt/JnBg1cCz
         D9+n42u9+TtGV/qQkh8S/Baziohm2NEgoI1i8wiAwg0ptSHR8ppSn8WAOYQQakYy6NgC
         z51lP8/3xTUoRl+jjxdohysHXn/VuTnB+ODabbBad3FwNjJUCYez8tU0WjMq2CZAx62R
         z23PZIWz+1BjWfQDvnUYK6rSqQRcCfBa0X24rDulI3JL2IyoEWDbJ3rI0qaIBlHAmNgP
         UncUPsYtZgECG9/hgslGp6eb1Ykv+rqgfuMYihV2bmdjmPofby7RrRL8AZI4ij/Hely2
         kqHQ==
X-Gm-Message-State: AOAM531XUHC6EJGafo7JXXn3nv5OjhN6wME3fJTB1miczAPp6guhNLmn
        ZCs6XvEFm1ivDdAsFq6b+E+Yun2Ayw4=
X-Google-Smtp-Source: ABdhPJwkc63PBzKHAJOlZ3vYLEIzT/lfvm6YRY7heb/WZTq4YqDzg3xVyB4oSSrsCYuIhIGvgUp63g==
X-Received: by 2002:adf:f78d:: with SMTP id q13mr18545595wrp.191.1623675894977;
        Mon, 14 Jun 2021 06:04:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12sm18543187wrr.90.2021.06.14.06.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 06:04:54 -0700 (PDT)
Message-Id: <1de99ac2bc3c60bc4639687d5ad2e2638aa9cadb.1623675889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.git.1623675888.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 13:04:46 +0000
Subject: [PATCH 08/10] diff --color-moved: stop clearing potential moved
 blocks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
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
index f60cce654c14..ee58373f55f8 100644
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
@@ -1093,11 +1088,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		}
 
 		if (pmb_nr && (!match || l->s != moved_symbol)) {
-			int i;
-
 			adjust_last_block(o, n, block_length);
-			for(i = 0; i < pmb_nr; i++)
-				moved_block_clear(&pmb[i]);
 			pmb_nr = 0;
 			block_length = 0;
 			flipped_block = 0;
@@ -1155,8 +1146,6 @@ static void mark_color_as_moved(struct diff_options *o,
 	}
 	adjust_last_block(o, n, block_length);
 
-	for(n = 0; n < pmb_nr; n++)
-		moved_block_clear(&pmb[n]);
 	free(pmb);
 }
 
-- 
gitgitgadget

