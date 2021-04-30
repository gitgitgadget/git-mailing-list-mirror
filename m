Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A35C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E6F761476
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhD3Vlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 17:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhD3Vlg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 17:41:36 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2237C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:47 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d12so14640466qtr.4
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GiHs2SetS2X46DqvIh4n7daDBre+E0yyC9Qq4Ip+lB8=;
        b=MKOilUpaouvy9mn9guznTd/k3aq5BgUFgqrKm2Wp97WIz2qbqlAmkY7ic8pLWYP6fK
         Gcyj7zH1S+2jnIO6D2VeePvbWUnPGtXLRyUwZBhT8dCD7iKmIqbJ6Qk8dwEdaJ1NywCV
         2z9j7F4PybCmuvQKaBDu2GnFMrXUqDUfdWpHxwANEYnIwoodUcT0T1lvHbF3Mqx8NtBb
         /kRzvuIBbams8OlvPCrv/nRj5ybrEixNsiEXwWN01dYMo+k1Pf/OogQw8Az3d7gV2nBr
         JB/vn/+jsZMjW77SexmdF/ym0drRHCaaqoFzvIfBaCadWUR0RlkSKuazf+cIszGZvwwk
         9j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GiHs2SetS2X46DqvIh4n7daDBre+E0yyC9Qq4Ip+lB8=;
        b=a6Vr/6pzIOTDXz+pLUXP9KpWP+7AVG1y4PCDBl96RM0c6VjMy4gWn1NFRzTTVlYr2C
         uV8M2TJp6NYieO+UG5Wdvl9OHRRNJmlrp+PmZooJjv4Tjklpm2h4oFiJhaJ7kIT95xiK
         TiJeIAoVfToLYNnXrJZcbE36NOEmxD43lWmlClgfJwSfqvf99AqslkwBFzK4PlgWD0KB
         Occb6AWdJ7yPhUBZ3qTU1JpKE7fe7Si0VUS80eeHUe9eXF8W1wfOYD8YpLoABJ8jDfH/
         dmgyL9r7K/cQrJFvRYRIRWKyXzzbr0A+pXxljS4JiANBstj4S60ejgAIyD4mK+eSBcMn
         fdnQ==
X-Gm-Message-State: AOAM532wVEvvOMTp8z7QJOT7/SqWwZiFLZOMw8KkQ7PP17yVpiQO3kg6
        EaZhRQSWPa6xV/ftDovYbbfP4p+isN7xPg==
X-Google-Smtp-Source: ABdhPJwsKUEW8Wcl+aNU9pmyqLJPY3Yo7JWFLWYrcpj49Dv7gSpHflosiJSPnxGv3kQw7OFZG8w+gQ==
X-Received: by 2002:ac8:4d92:: with SMTP id a18mr6549857qtw.312.1619818846658;
        Fri, 30 Apr 2021 14:40:46 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j13sm3123718qth.57.2021.04.30.14.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:40:46 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com, stolee@gmail.com
Subject: [PATCH v2 2/8] builtin/checkout.c: complete parallel checkout support
Date:   Fri, 30 Apr 2021 18:40:29 -0300
Message-Id: <e2d82c4337dc002d7296454c59d4006c3bb43c27.1619818517.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1619818517.git.matheus.bernardino@usp.br>
References: <cover.1619818517.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pathspec-limited checkouts (like `git checkout *.txt`) are performed by
a code path that doesn't yet support parallel checkout because it calls
checkout_entry() directly, instead of unpack_trees(). Let's add parallel
checkout support for this code path too.

Note: the transient cache entries allocated in checkout_merged() are now
allocated in a mem_pool which is only discarded after parallel checkout
finishes. This is done because the entries need to be valid when
run_parallel_checkout() is called.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/checkout.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index db667d0267..b71dc08430 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -27,6 +27,7 @@
 #include "wt-status.h"
 #include "xdiff-interface.h"
 #include "entry.h"
+#include "parallel-checkout.h"
 
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
@@ -230,7 +231,8 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 		return error(_("path '%s' does not have their version"), ce->name);
 }
 
-static int checkout_merged(int pos, const struct checkout *state, int *nr_checkouts)
+static int checkout_merged(int pos, const struct checkout *state,
+			   int *nr_checkouts, struct mem_pool *ce_mem_pool)
 {
 	struct cache_entry *ce = active_cache[pos];
 	const char *path = ce->name;
@@ -291,11 +293,10 @@ static int checkout_merged(int pos, const struct checkout *state, int *nr_checko
 	if (write_object_file(result_buf.ptr, result_buf.size, blob_type, &oid))
 		die(_("Unable to add merge result for '%s'"), path);
 	free(result_buf.ptr);
-	ce = make_transient_cache_entry(mode, &oid, path, 2, NULL);
+	ce = make_transient_cache_entry(mode, &oid, path, 2, ce_mem_pool);
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL, nr_checkouts);
-	discard_cache_entry(ce);
 	return status;
 }
 
@@ -359,16 +360,22 @@ static int checkout_worktree(const struct checkout_opts *opts,
 	int nr_checkouts = 0, nr_unmerged = 0;
 	int errs = 0;
 	int pos;
+	int pc_workers, pc_threshold;
+	struct mem_pool ce_mem_pool;
 
 	state.force = 1;
 	state.refresh_cache = 1;
 	state.istate = &the_index;
 
+	mem_pool_init(&ce_mem_pool, 0);
+	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
 	init_checkout_metadata(&state.meta, info->refname,
 			       info->commit ? &info->commit->object.oid : &info->oid,
 			       NULL);
 
 	enable_delayed_checkout(&state);
+	if (pc_workers > 1)
+		init_parallel_checkout();
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
@@ -384,10 +391,15 @@ static int checkout_worktree(const struct checkout_opts *opts,
 						       &nr_checkouts, opts->overlay_mode);
 			else if (opts->merge)
 				errs |= checkout_merged(pos, &state,
-							&nr_unmerged);
+							&nr_unmerged,
+							&ce_mem_pool);
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
+	if (pc_workers > 1)
+		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold,
+					      NULL, NULL);
+	mem_pool_discard(&ce_mem_pool, should_validate_cache_entries());
 	remove_marked_cache_entries(&the_index, 1);
 	remove_scheduled_dirs();
 	errs |= finish_delayed_checkout(&state, &nr_checkouts);
-- 
2.30.1

