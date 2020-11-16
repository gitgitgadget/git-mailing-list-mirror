Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339F6C5519F
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA54A221F8
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 11:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKCyDx00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgKPKXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 05:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbgKPKXW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 05:23:22 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49EBC0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:21 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so23080847wmb.5
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 02:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9YVjZ1L8kzbu2itpBCJA99lobPJTsxMd/HON2LJPvg=;
        b=BKCyDx00qmTKFzlsUCmv5cpi54fG1r6m36u0ryge2PtfP2Mw+2EpwPi6PQkV3QO9Py
         jhal0kDXxs2Xh4lnXlyVbgd9M5AmfWGVhnWYD1dIUec0Qk9MjAKkdGAuWo1+6WmAyFfR
         Jshe68x7Si6XoJh92LYW497ladoaNerM1ummG+yLIZIl2gsBCDvwYMnMFydhuO3eMHGu
         3nVcOq2Oj2X8a0u0u5hGbHxQugSLQhT2RAP2eAAffhzRM8NrKUUpUOWVhofTXmT9kz1r
         35VWlnRK2iDBo340qV9Ns7etotX/8pVCzlIdLrJiUjY6yTL1g/mXbVLiav3DhRG+8cNl
         6yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9YVjZ1L8kzbu2itpBCJA99lobPJTsxMd/HON2LJPvg=;
        b=fZBPxGe0Mr3IoWDW8on/w190i+ih3XpdV5tCKtMMhImjXa/TFMG+66jCq+SjJbLSDC
         0QGXZvMlmaz+faMDdEABAuO6WR/ZPd39ANEz4Aq0xENBmf6GOeV/CMnkb3oQ8TCMi24y
         qZiNQeW1b/bvuAhc8R0XrvMFpp8iCSjYFyR5jntjOCMy6hXmZlzorDa9T4G2JlQTGnEa
         1E6y55jNyL1o9h90FWNjdt26aJffHf0YkGc5cIJYZ9zqTqBksredZRCuq2SqfCJ8L5q9
         xSuwtmRZWO13FMACuj5rATK5EdyJYMnXp/1tugHCY6vLQ6kFkakzeiB+oNInyDh0YagH
         0CuQ==
X-Gm-Message-State: AOAM533rW/eOjQmVdZyh5ArzNiL6JMe/7i/aU7f5O6k/WH6awOUUeqkL
        0te3f0Qacmd2M7Qv9i3OkHgrvMJV0oo=
X-Google-Smtp-Source: ABdhPJyp/SBTKnCt16Mu8+WyFwvFUU2KFwXtRC//cXhCVwEjWifSIx9cksPFlmYZBXJxdWitYpPgoA==
X-Received: by 2002:a05:600c:2204:: with SMTP id z4mr14068954wml.57.1605522200431;
        Mon, 16 Nov 2020 02:23:20 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id f5sm22884520wrg.32.2020.11.16.02.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:23:20 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v5 12/12] sequencer: use the "octopus" merge strategy without forking
Date:   Mon, 16 Nov 2020 11:21:58 +0100
Message-Id: <20201116102158.8365-13-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201116102158.8365-1-alban.gruin@gmail.com>
References: <20201113110428.21265-1-alban.gruin@gmail.com>
 <20201116102158.8365-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the sequencer to invoke the "octopus" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index ff411d54af..746afad930 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2005,6 +2005,9 @@ static int do_pick_commit(struct repository *r,
 		if (!strcmp(opts->strategy, "resolve")) {
 			repo_read_index(r);
 			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
+		} else if (!strcmp(opts->strategy, "octopus")) {
+			repo_read_index(r);
+			res |= merge_strategies_octopus(r, common, oid_to_hex(&head), remotes);
 		} else
 			res |= try_merge_command(r, opts->strategy,
 						 opts->xopts_nr, (const char **)opts->xopts,
-- 
2.20.1

