Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3684FC388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA81F22226
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5Su15nH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgKBUod (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgKBUnx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:43:53 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E000C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:43:53 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id m26so13886739otk.11
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gHp7pGdtJLpf4WZA/d366+a7XIvMZibD4On6OHEyQ+U=;
        b=R5Su15nHYCRUXTIywYCEJnFVLogdiqlJHw3lUeUBgs/fujaHtfPh9QcbnDhA5pJBP7
         EmJxTZMhfhMceYuJiqUGEPT4lSTGfwN/KP3TTcK26GtskWE5aL4JQaIg4dtW0EaehrHt
         Dl8YEk3Ceq1mHqY9G4HY75aw62ryEUH0FQqsUqlD0oJtmAr5OMrq/Y8EBMzF8QYUiL/9
         8PD1H8UMgmqdNJws5G29l5CdSX5cR5XDeIJOry3NdxCAkTK4C1RdZf+Cz3M3d4CNbT8R
         /dxX53SbkNWCnZNgvYQbW8R47GXnoTJQrZAXBUQWupqMubRAEy93kwtTQjyiNagtcKp0
         wzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHp7pGdtJLpf4WZA/d366+a7XIvMZibD4On6OHEyQ+U=;
        b=CdA/U58NoyxIKqiURIzKA+1n3QKODyGnzDZQVwRUOF30pOMSpbhmjFKuH260sJVEcM
         77WldJz8WcQ0QHUGG4dPvODHoqMyfJC4MQY/AAsEgBLpk2tzxRJyy2w2feefYYhwkTWK
         1oajcRTY0e3bWgrURb4gq5oN6EzIfDVsY/U7ama9+fZgje7yO9cz7WNVbTB0dgeJuR2y
         20Kzpr6pmLgyWfAfTDu/9ltwgm43Ig2HC0aSVz42EatuS9i53a2tsanSNdTutFsNX3e1
         +a9gJa/ibNmK+7Fdb+F2G6NINWVq3zx8k/INcrYroIoZK1PdkrJCAOo/F5fmrARijasu
         qIWg==
X-Gm-Message-State: AOAM530FGEvLHOty6BdTH8P+h/xpx3thJu5jHrxQnOZes00q+tBXW4iR
        47jdnt/zcXFmSm5n/vVk9bugAwqa8YRU9g==
X-Google-Smtp-Source: ABdhPJyxhadgFaQXawpWYgoqyT4oM9QP2BH/nLmD/lJ9ax9TNKKdMLwgjJDgNfJ50B3LczOueDhsQA==
X-Received: by 2002:a9d:3ef7:: with SMTP id b110mr13021263otc.333.1604349832799;
        Mon, 02 Nov 2020 12:43:52 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:43:52 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 03/20] merge-ort: port merge_start() from merge-recursive
Date:   Mon,  2 Nov 2020 12:43:27 -0800
Message-Id: <20201102204344.342633-4-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

merge_start() basically does a bunch of sanity checks, then allocates
and initializes opt->priv -- a struct merge_options_internal.

Most the sanity checks are usable as-is.  The allocation/intialization
is a bit different since merge-ort has a very different
merge_options_internal than merge-recursive, but the idea is the same.

The weirdest part here is that merge-ort and merge-recursive use the
same struct merge_options, even though merge_options has a number of
fields that are oddly specific to merge-recursive's internal
implementation and don't even make sense with merge-ort's high-level
design (e.g. buffer_output, which merge-ort has to always do).  I reused
the same data structure because:
  * most the fields made sense to both merge algorithms
  * making a new struct would have required making new enums or somehow
    externalizing them, and that was getting messy.
  * it simplifies converting the existing callers by not having to
    have different code paths for merge_options setup.

I also marked detect_renames as ignored.  We can revisit that later, but
in short: merge-recursive allowed turning off rename detection because
it was sometimes glacially slow.  When you speed something up by a few
orders of magnitude, it's worth revisiting whether that justification is
still relevant.  Besides, if folks find it's still too slow, perhaps
they have a better scaling case than I could find and maybe it turns up
some more optimizations we can add.  If it still is needed as an option,
it is easy to add later.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index b53cd80104..f5460a8a52 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -17,6 +17,8 @@
 #include "cache.h"
 #include "merge-ort.h"
 
+#include "diff.h"
+#include "diffcore.h"
 #include "strmap.h"
 #include "tree.h"
 
@@ -107,7 +109,47 @@ void merge_finalize(struct merge_options *opt,
 
 static void merge_start(struct merge_options *opt, struct merge_result *result)
 {
-	die("Not yet implemented.");
+	/* Sanity checks on opt */
+	assert(opt->repo);
+
+	assert(opt->branch1 && opt->branch2);
+
+	assert(opt->detect_directory_renames >= MERGE_DIRECTORY_RENAMES_NONE &&
+	       opt->detect_directory_renames <= MERGE_DIRECTORY_RENAMES_TRUE);
+	assert(opt->rename_limit >= -1);
+	assert(opt->rename_score >= 0 && opt->rename_score <= MAX_SCORE);
+	assert(opt->show_rename_progress >= 0 && opt->show_rename_progress <= 1);
+
+	assert(opt->xdl_opts >= 0);
+	assert(opt->recursive_variant >= MERGE_VARIANT_NORMAL &&
+	       opt->recursive_variant <= MERGE_VARIANT_THEIRS);
+
+	/*
+	 * detect_renames, verbosity, buffer_output, and obuf are ignored
+	 * fields that were used by "recursive" rather than "ort" -- but
+	 * sanity check them anyway.
+	 */
+	assert(opt->detect_renames >= -1 &&
+	       opt->detect_renames <= DIFF_DETECT_COPY);
+	assert(opt->verbosity >= 0 && opt->verbosity <= 5);
+	assert(opt->buffer_output <= 2);
+	assert(opt->obuf.len == 0);
+
+	assert(opt->priv == NULL);
+
+	/* Initialization of opt->priv, our internal merge data */
+	opt->priv = xcalloc(1, sizeof(*opt->priv));
+	/*
+	 * Although we initialize opt->priv->paths with strdup_strings=0,
+	 * that's just to avoid making yet another copy of an allocated
+	 * string.  Putting the entry into paths means we are taking
+	 * ownership, so we will later free it.
+	 *
+	 * In contrast, unmerged just has a subset of keys from paths, so
+	 * we don't want to free those (it'd be a duplicate free).
+	 */
+	strmap_init_with_options(&opt->priv->paths, NULL, 0);
+	strmap_init_with_options(&opt->priv->unmerged, NULL, 0);
 }
 
 /*
-- 
2.29.0.471.ga4f56089c0

