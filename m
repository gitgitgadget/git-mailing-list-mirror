Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AC4C388F9
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1188821534
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjHirYOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJ3Dme (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgJ3Dme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:34 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0721FC0613D4
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:46 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id b2so4454373ots.5
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MX5gbFs9WmJ5onWHsU9fnxyaMe1kENiKiYIypZLfQh8=;
        b=FjHirYOEHcChC/tfHwSBN/ZDcIo76WaUBJuxxAkDoRtDzJhAr4OyhaF1N5YczONRJT
         tlxml4t7bkfjt7vkDr+vY2FC313MoQ1VtKGB/KARETcZ3NVi2ChjF6F74+p6BumKzQbP
         mYnF6q8MZ73KgeQ0XEYArN9ISZvdI9NqM3+Dd7xsJH7ZqlUy5XW3ZbghdTqOxjZgUuSP
         N5PVOnsDZs6aCeo8Q0wnV5VpGOucV328VUT9shKxSs8RUjzzg10aaKBgTlLlQycccXXt
         goWFXJSGG9Q+7OtcfDQi0kBH4FaNzfiP1uOPs0Sw2jdekyoAi3QuBsp6PFQFroYsavjc
         WWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MX5gbFs9WmJ5onWHsU9fnxyaMe1kENiKiYIypZLfQh8=;
        b=Ii8kJvpOn+7lI+wk+0oTPR+saGBjOLtdBYEXn0wjyq6zeo0Mb2yQiKQToUYWr3bwBL
         wbXr0d+aqbriSrLDS1unGJlS73LOINtZYLRVXS5DmQqiDosc2nw7q86e5Vrppj3Kbk3c
         kCl+hklJ5UEnAGyarM/bxvet443tHQDWi8PONvqmaYF30PyKnm6WIVYe1I/Xu2GVa8lL
         dEVvHyoMT4mQcHaoKnUX4jmBQTWtg9NDcpzWJFqsa9RCSjHDckR442a/uAlqkwctSU4v
         5YV4JfpJpPcjOEwWoGx6+rJhK69i0ZAJIXEAXEuQDJUoXIA1kjJI6bLmSfnP9La0eJWt
         /law==
X-Gm-Message-State: AOAM530/B0c6PAMISVfMRFBiVssL+6ogpOKKzRR6bbBezcuLRPZ2K1tW
        thoRRLjF7FyMVANXUC2kKfrtEAVjyyQ07g==
X-Google-Smtp-Source: ABdhPJyxjICFMSiaf2TsIfBDu8OISbi0cPSnC3a+N2w/B6bCtH6kuhb8dmixFYdLJJs28jJ6aGUaKw==
X-Received: by 2002:a9d:67c8:: with SMTP id c8mr171426otn.211.1604029305195;
        Thu, 29 Oct 2020 20:41:45 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:44 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 03/20] merge-ort: port merge_start() from merge-recursive
Date:   Thu, 29 Oct 2020 20:41:14 -0700
Message-Id: <20201030034131.1479968-4-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
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
index b53cd80104..bee9507319 100644
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
+	strmap_ocd_init(&opt->priv->paths, NULL, 0);
+	strmap_ocd_init(&opt->priv->unmerged, NULL, 0);
 }
 
 /*
-- 
2.29.1.56.ga287c268e6.dirty

