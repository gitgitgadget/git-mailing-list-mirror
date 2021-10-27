Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5423C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D63160E8B
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241819AbhJ0MHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbhJ0MHC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:07:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7B3C061233
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 192so848532wme.3
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hbX6ChgF1/7zCe8TRq2mAwsHjDZd1Mp8/GA16/PwtSw=;
        b=W2ulqUE+EJkhFBDa3rmmKgp7BtGoIlTtfQKL3jUKRBgZUZD1Ub/C4faF4KFFSqmEmI
         ECp6KtOvjVUxSCfSGmlMrFqPDWGyk/xybgjyXGZdZ/SylUJwyfnTSrzzziC/asUG0+aG
         GyXMKzIon0JLWgvRqpq/eF/nZZtZodekuJapsySqedPdqp5q15UdEqXlb2y1GX7AAqTa
         tuSbGHNDSOr+oxeIFKpVEIIH/HU2tfxd5g93LB2gr7327BNQkTRUnKewxT4J+VibcMDU
         cHI1X8vlKPTQm/knJKdSKfR6bpTji9qFZBvnNlD+CnmqDvQtk4GT6pj3poMNR5yJkq1e
         2qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hbX6ChgF1/7zCe8TRq2mAwsHjDZd1Mp8/GA16/PwtSw=;
        b=e2RMJkg81kb/IVRcYJfs5339VVYnYiscCeABie2uZiQVnYp9+Cgx10L3RPSY/gqnbe
         pVdmVUonnrTM70O35TvUZor2LWYwnlyxGiEw0QP2wKgxU9QTlKc24YG+VHdnKGxfkEpA
         t1dg8lz3T0vkpXHfyHW5QMwTpSh8WDnB23BZX91aYJbD5IQLtTK7s9nERWfNAt15cDR3
         rnT1d1sT1HYKOVWVOpkV/pFtiNc3GY//YbIHg7VOW8uLjRPpjw1PA2aDMTIwZo9uZBh5
         HJD0SYrr72t4pnk4k+l91eO05b52wyH2HwFP7jwxZbkUVrZpfdpnMZWCYCq90E/fdmc6
         PzYQ==
X-Gm-Message-State: AOAM53113TleUVfo5lTfCW7KpAuhgpRkoj37LQPOaPureKerbXo+c5ne
        uffh8hRmDoIo0WS/1PmS+8jwag3IFOg=
X-Google-Smtp-Source: ABdhPJynoM3N/EyjKcKN48a44ToTddhZDYQuUuAJ4Oz5iAeb+8aD7E3IQ6Rry711t9kCVVP3MmYNwA==
X-Received: by 2002:a05:600c:2909:: with SMTP id i9mr5311442wmd.74.1635336275719;
        Wed, 27 Oct 2021 05:04:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17sm15022657wrv.22.2021.10.27.05.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:04:35 -0700 (PDT)
Message-Id: <618371471a0effd4ad2d69105a7e4495ad46c350.1635336263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
        <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 12:04:19 +0000
Subject: [PATCH v3 12/15] diff --color-moved: stop clearing potential moved
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

