Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715711F404
	for <e@80x24.org>; Wed, 28 Feb 2018 20:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934016AbeB1UAY (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 15:00:24 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33868 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934012AbeB1UAU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 15:00:20 -0500
Received: by mail-wr0-f196.google.com with SMTP id m5so3731480wrg.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 12:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zdcO4RQ7h38Xk0To6u7d2JW5Wh/JlQ5U0VvlDf0yr/s=;
        b=h0qUKQ6zMwCN+lyBpuiHq9BwvQo8VMGF9eJtpXtgryVg/AnzFTFR7XZB4Jf70llpZQ
         ovkoXefdk71/vvGGC1rwd7kwplqzlLXkB+3JlZOgQHg1xTXl4gUYprEFz/5F6NdMxf48
         Yw4W8whV4tZV9KKgUUoegGVH2iOgn4G8M7/FPjYvCaCqbwERcMNZ97wvSnWb9v0D6T5m
         EBNOSnHCmVe4sRWz480U5mDLxlOlJrb4XXVICX9qf6Lz5nPX0AObOLJk9V3WqBOTkEMF
         zQS2a7EJVODMy30obAsn3Kpr7iT5jmoBNPCfHv0pS3lHdo/gpy02zebCjO8kVCXzVb1n
         I3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zdcO4RQ7h38Xk0To6u7d2JW5Wh/JlQ5U0VvlDf0yr/s=;
        b=LQLO4QEQZyNbV85mVxWwBNUzQqSwQ/W45gfr4NUNQBzjyqCpDIWeIdm7UaADnP4xUY
         19OBTx2zlvPN0FC5xgXwfKsavZuYC2KnFxcJewffu4Fe+lWD5bbEDfArjsGAj650zwD8
         92I7Em+BSSDic8j0+ptZDu7HNj848nAanNOdrLXz7Hz/hO6xIKRQPdCEjDxMoj4+tNQ/
         5tLo/fNgkp8aVzxvvDNiF9Kn9KRIVeUhpFQxSjsr3Fmg1AXwZ12Im5GMZN7iTp0MJRGf
         qlb4d+jpd6W5LOrqEH6JQnqz/WXhMjWPLBNqQKG581IeuBCwPjm0ZNmjc7QZaAq9G8ZB
         SIOg==
X-Gm-Message-State: APf1xPB2jRRKk4wThPLEUjlvB3XYJmE+V8PyDZsNf0r64qjVxav3qGLN
        PKk9W/Cv1tTGEF+CTnhpfyHcmSw/
X-Google-Smtp-Source: AH8x2255nJf+wLFoIe9ZRCdwQ5plmt+fcEWQQQQ9tRCvCW10THRHpB1cmG2MSAhUm0m5rJQFvvm9iQ==
X-Received: by 10.223.166.106 with SMTP id k97mr16849792wrc.64.1519848018939;
        Wed, 28 Feb 2018 12:00:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id v17sm2328743wrd.5.2018.02.28.12.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Feb 2018 12:00:18 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] roll back locks in various code paths
Date:   Wed, 28 Feb 2018 20:58:09 +0100
Message-Id: <20180228195809.9145-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1519843916.git.martin.agren@gmail.com>
References: <cover.1519843916.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'll follow up with a patch to
> address the confusing pattern which Peff mentioned and which fooled me
> when I prepared v1.

Here is such a patch on top of the others. I'm not particularly proud of the
name SKIP_IF_UNCHANGED, but don't think it's any worse than, e.g.,
IGNORE_UNCHANGED or NO_UNCHANGED_WRITE. :-/ Suggestions welcome.

I think this makes the current users a bit more obvious, and should help future
users get this optimization right.

Martin

-- >8 --
Subject: write_locked_index(): add flag to avoid writing unchanged index

We have several callers like

	if (active_cache_changed && write_locked_index(...))
		handle_error();
	rollback_lock_file(...);

where the final rollback is needed because "!active_cache_changed"
shortcuts the if-expression. There are also a few variants of this,
including some if-else constructs that make it more clear when the
explicit rollback is really needed.

Teach `write_locked_index()` to take a new flag SKIP_IF_UNCHANGED and
simplify the callers. The most complicated of the callers is in
builtin/update-index.c, where we need to check with `force_write` to
decide whether we should pass the new flag or not.

A further upshot of this patch is that `active_cache_changed`, which is
defined as `the_index.cache_changed`, now only has a few users left.

We could have made the new flag behave the other way round
("FORCE_WRITE"), but that could break existing users behind their backs.
Let's take the more conservative approach. We can still migrate existing
callers to use our new flag. Later we might even be able to flip the
default, possibly without entirely ignoring the risk to in-flight or
out-of-tree topics.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 cache.h                |  4 ++++
 builtin/add.c          |  7 +++----
 builtin/commit.c       | 10 +++-------
 builtin/merge.c        | 15 ++++++---------
 builtin/mv.c           |  4 ++--
 builtin/rm.c           |  7 +++----
 builtin/update-index.c | 16 +++++++---------
 merge-recursive.c      |  5 ++---
 read-cache.c           |  6 ++++++
 rerere.c               |  8 +++-----
 sequencer.c            | 11 +++++------
 11 files changed, 44 insertions(+), 49 deletions(-)

diff --git a/cache.h b/cache.h
index d8b975a571..905d8eb6cc 100644
--- a/cache.h
+++ b/cache.h
@@ -622,6 +622,7 @@ extern int read_index_unmerged(struct index_state *);
 
 /* For use with `write_locked_index()`. */
 #define COMMIT_LOCK		(1 << 0)
+#define SKIP_IF_UNCHANGED	(1 << 1)
 
 /*
  * Write the index while holding an already-taken lock. Close the lock,
@@ -638,6 +639,9 @@ extern int read_index_unmerged(struct index_state *);
  * With `COMMIT_LOCK`, the lock is always committed or rolled back.
  * Without it, the lock is closed, but neither committed nor rolled
  * back.
+ *
+ * If `SKIP_IF_UNCHANGED` is given and the index is unchanged, nothing
+ * is written (and the lock is rolled back if `COMMIT_LOCK` is given).
  */
 extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
 
diff --git a/builtin/add.c b/builtin/add.c
index bf01d89e28..9e5a80cc6f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -534,10 +534,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	unplug_bulk_checkin();
 
 finish:
-	if (active_cache_changed) {
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-			die(_("Unable to write new index file"));
-	}
+	if (write_locked_index(&the_index, &lock_file,
+			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+		die(_("Unable to write new index file"));
 
 	UNLEAK(pathspec);
 	UNLEAK(dir);
diff --git a/builtin/commit.c b/builtin/commit.c
index 8a87701414..8d9b4081c3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -423,13 +423,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (active_cache_changed
 		    || !cache_tree_fully_valid(active_cache_tree))
 			update_main_cache_tree(WRITE_TREE_SILENT);
-		if (active_cache_changed) {
-			if (write_locked_index(&the_index, &index_lock,
-					       COMMIT_LOCK))
-				die(_("unable to write new_index file"));
-		} else {
-			rollback_lock_file(&index_lock);
-		}
+		if (write_locked_index(&the_index, &index_lock,
+				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+			die(_("unable to write new_index file"));
 		commit_style = COMMIT_AS_IS;
 		ret = get_index_file();
 		goto out;
diff --git a/builtin/merge.c b/builtin/merge.c
index 30264cfd7c..30c65dfeff 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -651,10 +651,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 	refresh_cache(REFRESH_QUIET);
-	if (active_cache_changed &&
-	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
+	if (write_locked_index(&the_index, &lock,
+			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		return error(_("Unable to write index."));
-	rollback_lock_file(&lock);
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
 		int clean, x;
@@ -691,10 +690,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				remoteheads->item, reversed, &result);
 		if (clean < 0)
 			exit(128);
-		if (active_cache_changed &&
-		    write_locked_index(&the_index, &lock, COMMIT_LOCK))
+		if (write_locked_index(&the_index, &lock,
+				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die (_("unable to write %s"), get_index_file());
-		rollback_lock_file(&lock);
 		return clean ? 0 : 1;
 	} else {
 		return try_merge_command(strategy, xopts_nr, xopts,
@@ -810,10 +808,9 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 
 	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 	refresh_cache(REFRESH_QUIET);
-	if (active_cache_changed &&
-	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
+	if (write_locked_index(&the_index, &lock,
+			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		return error(_("Unable to write index."));
-	rollback_lock_file(&lock);
 
 	write_tree_trivial(&result_tree);
 	printf(_("Wonderful.\n"));
diff --git a/builtin/mv.c b/builtin/mv.c
index cf3684d907..ae013d6d20 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -293,8 +293,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (gitmodules_modified)
 		stage_updated_gitmodules(&the_index);
 
-	if (active_cache_changed &&
-	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (write_locked_index(&the_index, &lock_file,
+			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("Unable to write new index file"));
 
 	return 0;
diff --git a/builtin/rm.c b/builtin/rm.c
index 4a2fcca27b..5d59a0aa65 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -385,10 +385,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 			stage_updated_gitmodules(&the_index);
 	}
 
-	if (active_cache_changed) {
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-			die(_("Unable to write new index file"));
-	}
+	if (write_locked_index(&the_index, &lock_file,
+			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+		die(_("Unable to write new index file"));
 
 	return 0;
 }
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 58d1c2d282..f2581904d0 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1182,17 +1182,15 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		report(_("fsmonitor disabled"));
 	}
 
-	if (active_cache_changed || force_write) {
-		if (newfd < 0) {
-			if (refresh_args.flags & REFRESH_QUIET)
-				exit(128);
-			unable_to_lock_die(get_index_file(), lock_error);
-		}
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-			die("Unable to write new index file");
+	if (newfd < 0 && (active_cache_changed || force_write)) {
+		if (refresh_args.flags & REFRESH_QUIET)
+			exit(128);
+		unable_to_lock_die(get_index_file(), lock_error);
 	}
 
-	rollback_lock_file(&lock_file);
+	if (write_locked_index(&the_index, &lock_file,
+			       COMMIT_LOCK | (force_write ? 0 : SKIP_IF_UNCHANGED)))
+		die("Unable to write new index file");
 
 	return has_errors ? 1 : 0;
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index 002fb82cf1..410cf4dca3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2203,10 +2203,9 @@ int merge_recursive_generic(struct merge_options *o,
 		return clean;
 	}
 
-	if (active_cache_changed &&
-	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
+	if (write_locked_index(&the_index, &lock,
+			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		return err(o, _("Unable to write index."));
-	rollback_lock_file(&lock);
 
 	return clean ? 0 : 1;
 }
diff --git a/read-cache.c b/read-cache.c
index 2eb81a66b9..f46485eb1e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2543,6 +2543,12 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	int new_shared_index, ret;
 	struct split_index *si = istate->split_index;
 
+	if ((flags & SKIP_IF_UNCHANGED) && !istate->cache_changed) {
+		if (flags & COMMIT_LOCK)
+			rollback_lock_file(lock);
+		return 0;
+	}
+
 	if (istate->fsmonitor_last_update)
 		fill_fsmonitor_bitmap(istate);
 
diff --git a/rerere.c b/rerere.c
index 1ce440f4bb..fe47ea50be 100644
--- a/rerere.c
+++ b/rerere.c
@@ -719,11 +719,9 @@ static void update_paths(struct string_list *update)
 			item->string);
 	}
 
-	if (active_cache_changed) {
-		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
-			die("Unable to write new index file");
-	} else
-		rollback_lock_file(&index_lock);
+	if (write_locked_index(&the_index, &index_lock,
+			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+		die("Unable to write new index file");
 }
 
 static void remove_variant(struct rerere_id *id)
diff --git a/sequencer.c b/sequencer.c
index 0e6d04e4ce..1efcf1a2c0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -468,15 +468,14 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 		return clean;
 	}
 
-	if (active_cache_changed &&
-	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
+	if (write_locked_index(&the_index, &index_lock,
+			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		/*
 		 * TRANSLATORS: %s will be "revert", "cherry-pick" or
 		 * "rebase -i".
 		 */
 		return error(_("%s: Unable to write new index file"),
 			_(action_name(opts)));
-	rollback_lock_file(&index_lock);
 
 	if (opts->signoff)
 		append_signoff(msgbuf, 0, 0);
@@ -1191,13 +1190,13 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 			_(action_name(opts)));
 	}
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
-	if (the_index.cache_changed && index_fd >= 0) {
-		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK)) {
+	if (index_fd >= 0) {
+		if (write_locked_index(&the_index, &index_lock,
+				       COMMIT_LOCK | SKIP_IF_UNCHANGED)) {
 			return error(_("git %s: failed to refresh the index"),
 				_(action_name(opts)));
 		}
 	}
-	rollback_lock_file(&index_lock);
 	return 0;
 }
 
-- 
2.16.2.246.ga4ee44448f

