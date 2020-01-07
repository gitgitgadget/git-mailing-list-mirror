Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DBBC33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 06:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45BC207E0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 06:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RozMGtHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgAGG6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:58:06 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:56215 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgAGG6C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 01:58:02 -0500
Received: by mail-wm1-f41.google.com with SMTP id q9so17699068wmj.5
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 22:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bScppmrGyxp0EXJMUAcnFyJ+pbW1kR00xpFocgi6OJQ=;
        b=RozMGtHLIdKH9HtA9TRurXbL9ZzdUMOcZi/5VBADbygI4b4gSzCOptGJFRz4ScMPhB
         R+yFfIQOLmZNfMkupdMyiuQWmZqkQUbiufW2CPeWxVUYwW1fUo9v+hRFvou36cEmemd0
         rwkT5fuaXPJXyKXvArkgA3y6OIkYB8EgLQngda/42kWTXUfysXcZnvf2cp2e5i4/3mEj
         E1vUNxFISdW6MGN6MwMOZj9tKoeFx6vsCaht/rh2d2ZWUDdNShuQR01r7gJPm+enh5Oh
         RVMNBQdJMG3EIv+mvkLrO4nr1aJHDGHnkNKVWo+5qpVWa9Q5veiUYSfW2ooW8WvFVTDQ
         roXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bScppmrGyxp0EXJMUAcnFyJ+pbW1kR00xpFocgi6OJQ=;
        b=EVnxR7FOM32GUygei8MYPL+/jBQMOHvMsmOITSZMwwJJCzn2px7WcxpruSekseCH7r
         jLGXXwDh+eVFZwjhSVMHDAAlwXki1Dnf9jtqB2RF5EswHI4LZbmemJ66/3oV2ks//b0v
         c9WySuKmu+kRpVan85da4sPE58E/QjIFowbpM3JL9OX59zudZZqvJB59FW8ILBwnVtEs
         KQh9HNrDwsP+7ixIyeyUCOUiCx1EGekC0tv4CQpNGjP+E929XVI6g3iiFtiIX9AVdYt5
         WoD7tIlAXPSwd3XrM8861kfDgERwioIwgzz41p/+CW07alv+aHo3EiHEgCy9iJvS8zZn
         tTdQ==
X-Gm-Message-State: APjAAAX7js8PmnBMdTcbCyv06kiI31dniTkg+DFiyxToDUh/exx4s4KV
        /WZ+hNJaSwb45GVDTqps0LZ3BHyF
X-Google-Smtp-Source: APXvYqwrJNaKJpIMz7vHz0hgN5bCmZWQbBI35pS5aUT3csOYMBIr9c6LjP/KJ0VGPMSrBc/tJS+sdA==
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr38545170wml.43.1578380280575;
        Mon, 06 Jan 2020 22:58:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18sm6075516wru.50.2020.01.06.22.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 22:57:59 -0800 (PST)
Message-Id: <dd277273324eaba5e1f4a368bf2e4d046033c776.1578380277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.686.v2.git.git.1578380277.gitgitgadget@gmail.com>
References: <pull.686.git.git.1578087730.gitgitgadget@gmail.com>
        <pull.686.v2.git.git.1578380277.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 06:57:57 +0000
Subject: [PATCH v2 1/1] unpack-trees: exit check_updates() early if updates
 are not wanted
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

check_updates() has a lot of code that repeatedly checks whether
o->update or o->dry_run are set.  (Note that o->dry_run is a
near-synonym for !o->update, but not quite as per commit 2c9078d05bf2
("unpack-trees: add the dry_run flag to unpack_trees_options",
2011-05-25).)  In fact, this function almost turns into a no-op whenever
the condition
   !o->update || o->dry_run
is met.  Simplify the code by checking this condition at the beginning
of the function, and when it is true, do the few things that are
relevant and return early.

There are a few things that make the conversion not quite obvious:
  * The fact that check_updates() does not actually turn into a no-op
    when updates are not wanted may be slightly surprising.  However,
    commit 33ecf7eb61 (Discard "deleted" cache entries after using them
    to update the working tree, 2008-02-07) put the discarding of
    unused cache entries in check_updates() so we still need to keep
    the call to remove_marked_cache_entries().  It's possible this
    call belongs in another function, but it is certainly needed as
    tests will fail if it is removed.
  * The original called remove_scheduled_dirs() unconditionally.
    Technically, commit 7847892716 (unlink_entry(): introduce
    schedule_dir_for_removal(), 2009-02-09) should have made that call
    conditional, but it didn't matter in practice because
    remove_scheduled_dirs() becomes a no-op when all the calls to
    unlink_entry() are skipped.  As such, we do not need to call it.
  * When (o->dry_run && o->update), the original would have two calls
    to git_attr_set_direction() surrounding a bunch of skipped updates.
    These two calls to git_attr_set_direction() cancel each other out
    and thus can be omitted when o->dry_run is true just as they
    already are when !o->update.
  * The code would previously call setup_collided_checkout_detection()
    and report_collided_checkout() even when o->dry_run.  However, this
    was just an expensive no-op because
    setup_collided_checkout_detection() merely cleared the CE_MATCHED
    flag for each cache entry, and report_collided_checkout() reported
    which ones had it set.  Since a dry-run would skip all the
    checkout_entry() calls, CE_MATCHED would never get set and thus
    no collisions would be reported.  Since we can't detect the
    collisions anyway without doing updates, skipping the collisions
    detection setup and reporting is an optimization.
  * The code previously would call get_progress() and
    display_progress() even when (!o->update || o->dry_run).  This
    served to show how long it took to skip all the updates, which is
    somewhat useless.  Since we are skipping the updates, we can skip
    showing how long it takes to skip them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 2399b6818b..4c68dbdb43 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -372,15 +372,20 @@ static int check_updates(struct unpack_trees_options *o)
 	state.refresh_cache = 1;
 	state.istate = index;
 
+	if (!o->update || o->dry_run) {
+		remove_marked_cache_entries(index, 0);
+		trace_performance_leave("check_updates");
+		return 0;
+	}
+
 	if (o->clone)
 		setup_collided_checkout_detection(&state, index);
 
 	progress = get_progress(o);
 
-	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKOUT);
+	git_attr_set_direction(GIT_ATTR_CHECKOUT);
 
-	if (should_update_submodules() && o->update && !o->dry_run)
+	if (should_update_submodules())
 		load_gitmodules_file(index, NULL);
 
 	for (i = 0; i < index->cache_nr; i++) {
@@ -388,18 +393,18 @@ static int check_updates(struct unpack_trees_options *o)
 
 		if (ce->ce_flags & CE_WT_REMOVE) {
 			display_progress(progress, ++cnt);
-			if (o->update && !o->dry_run)
-				unlink_entry(ce);
+			unlink_entry(ce);
 		}
 	}
+
 	remove_marked_cache_entries(index, 0);
 	remove_scheduled_dirs();
 
-	if (should_update_submodules() && o->update && !o->dry_run)
+	if (should_update_submodules())
 		load_gitmodules_file(index, &state);
 
 	enable_delayed_checkout(&state);
-	if (has_promisor_remote() && o->update && !o->dry_run) {
+	if (has_promisor_remote()) {
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
@@ -431,15 +436,12 @@ static int check_updates(struct unpack_trees_options *o)
 				    ce->name);
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
-			if (o->update && !o->dry_run) {
-				errs |= checkout_entry(ce, &state, NULL, NULL);
-			}
+			errs |= checkout_entry(ce, &state, NULL, NULL);
 		}
 	}
 	stop_progress(&progress);
 	errs |= finish_delayed_checkout(&state, NULL);
-	if (o->update)
-		git_attr_set_direction(GIT_ATTR_CHECKIN);
+	git_attr_set_direction(GIT_ATTR_CHECKIN);
 
 	if (o->clone)
 		report_collided_checkout(index);
-- 
gitgitgadget
