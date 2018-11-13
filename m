Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65F231F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeKNE1Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:27:24 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42997 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeKNE1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:27:24 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so3535422lja.9
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cFmP+O49h262L4+4wQvbT05RMqAfGfvSK9Be19bBVo=;
        b=oqz4no52rIYbD+SE+YcxdflVISuj6clEmSm8Jr5Cg0cHF/A8OMYBPJr2QyGoEeicWH
         2+VawfH6uDJNXXeRtRFl0RMJBE78gKcDki1rKQ5I/6hBCkhyWh95twjomiIKfgTg6//k
         qXXku3T40ARJJQB5AJVx+PQHL7gy6xEp2TPn2s/qpa2n36p3dZ2rPeHiZOVs6ZLQUWYI
         Q10kXjs0FbbklCDCLESVPQhDSl7XI7JkmOdsHLyqfNFzXxESmHvCk69AKGJlOa8gSZRN
         c8SGWLeZ/3Q5oi3BKlYHc7lCunnz/vTHnBWASuni1l9pBssWLKzkmNKYOYDNrInnMjvB
         65pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cFmP+O49h262L4+4wQvbT05RMqAfGfvSK9Be19bBVo=;
        b=YzILkiuai/iYCIvgX9s3w4marMoUNXgCt2KIPgf3/e3bR5cP1qk/ZNuhdKHmWo4r4u
         o4/Y9hSNx+1gmZsyByqZfYKwS/xbELgVgaT73Xy0zliBjNNUuOJnes1oRug1X1boNwO2
         DU6NRxD0PSZx/ztpFS9x3AReQTYjTEqT8GZgi5/t88QabvA9bjcTOugXZd0Ajqvyt6p/
         M1FaM67FrPQx7TD/qS3N8svvdz4Ys7EsODVqvZEKrEkwLqGN9fdM6k5rXNuoXvNxePri
         RhOCoAx1ZVSSSUxPRCUu1Mq+yV3nuGxYilby2tz+i8jQov0ZQMHnEbhfESa6lxgH6xtN
         KTrw==
X-Gm-Message-State: AGRZ1gLZ9EJH/GSeek6/vwwgDfrs6HSv5NF+JEPPbxEIAQruFuVEao5r
        5DgiophgSBK9xU3cC7+sFaZ5mTtb
X-Google-Smtp-Source: AJdET5ft8ZZq7arWG5rBuq9+FRt5/Hzoxam1FBAI3ZmEIQTIhCA9+ENqTaJGtxu61wD8iXBHl2Zw3Q==
X-Received: by 2002:a2e:1551:: with SMTP id 17-v6mr3771583ljv.68.1542133684322;
        Tue, 13 Nov 2018 10:28:04 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t7-v6sm3459105ljh.1.2018.11.13.10.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:28:03 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] checkout: print something when checking out paths
Date:   Tue, 13 Nov 2018 19:28:00 +0100
Message-Id: <20181113182800.26984-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1318.g5295c6727d
In-Reply-To: <20181110133525.17538-1-pclouds@gmail.com>
References: <20181110133525.17538-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the problems with "git checkout" is that it does so many
different things and could confuse people specially when we fail to
handle ambiguation correctly.

One way to help with that is tell the user what sort of operation is
actually carried out. When switching branches, we always print
something unless --quiet, either

 - "HEAD is now at ..."
 - "Reset branch ..."
 - "Already on ..."
 - "Switched to and reset ..."
 - "Switched to a new branch ..."
 - "Switched to branch ..."

Checking out paths however is silent. Print something so that if we
got the user intention wrong, they won't waste too much time to find
that out. For the remaining cases of checkout we now print either

 - "Checked out ... paths out of the index"
 - "Checked out ... paths out of <abbrev hash>"

Since the purpose of printing this is to help disambiguate. Only do it
when "--" is missing.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 updates the messages a bit but it does not check isatty or add
 --count-paths, for consistency reason with how messages are printed
 in the branch switching case.
 
 Consistency is not always a good reason to follow. But I haven't
 seen a strong reason to go against it.

 apply.c                  |  3 ++-
 builtin/checkout-index.c |  6 ++++--
 builtin/checkout.c       | 39 +++++++++++++++++++++++++++++++--------
 builtin/difftool.c       |  2 +-
 cache.h                  |  4 ++--
 entry.c                  | 10 ++++++----
 unpack-trees.c           |  6 +++---
 7 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/apply.c b/apply.c
index 073d5f0451..5876b02197 100644
--- a/apply.c
+++ b/apply.c
@@ -3352,7 +3352,8 @@ static int checkout_target(struct index_state *istate,
 
 	costate.refresh_cache = 1;
 	costate.istate = istate;
-	if (checkout_entry(ce, &costate, NULL) || lstat(ce->name, st))
+	if (checkout_entry(ce, &costate, NULL, NULL) ||
+	    lstat(ce->name, st))
 		return error(_("cannot checkout %s"), ce->name);
 	return 0;
 }
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 88b86c8d9f..bada491f58 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -67,7 +67,8 @@ static int checkout_file(const char *name, const char *prefix)
 			continue;
 		did_checkout = 1;
 		if (checkout_entry(ce, &state,
-		    to_tempfile ? topath[ce_stage(ce)] : NULL) < 0)
+				   to_tempfile ? topath[ce_stage(ce)] : NULL,
+				   NULL) < 0)
 			errs++;
 	}
 
@@ -111,7 +112,8 @@ static void checkout_all(const char *prefix, int prefix_length)
 				write_tempfile_record(last_ce->name, prefix);
 		}
 		if (checkout_entry(ce, &state,
-		    to_tempfile ? topath[ce_stage(ce)] : NULL) < 0)
+				   to_tempfile ? topath[ce_stage(ce)] : NULL,
+				   NULL) < 0)
 			errs++;
 		last_ce = ce;
 	}
diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..3a0b86ec1c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -44,6 +44,7 @@ struct checkout_opts {
 	int ignore_skipworktree;
 	int ignore_other_worktrees;
 	int show_progress;
+	int count_checkout_paths;
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
 	 * should be updated accordingly.
@@ -165,12 +166,13 @@ static int check_stages(unsigned stages, const struct cache_entry *ce, int pos)
 }
 
 static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
-			  const struct checkout *state)
+			  const struct checkout *state, int *nr_checkouts)
 {
 	while (pos < active_nr &&
 	       !strcmp(active_cache[pos]->name, ce->name)) {
 		if (ce_stage(active_cache[pos]) == stage)
-			return checkout_entry(active_cache[pos], state, NULL);
+			return checkout_entry(active_cache[pos], state,
+					      NULL, nr_checkouts);
 		pos++;
 	}
 	if (stage == 2)
@@ -179,7 +181,7 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 		return error(_("path '%s' does not have their version"), ce->name);
 }
 
-static int checkout_merged(int pos, const struct checkout *state)
+static int checkout_merged(int pos, const struct checkout *state, int *nr_checkouts)
 {
 	struct cache_entry *ce = active_cache[pos];
 	const char *path = ce->name;
@@ -242,7 +244,7 @@ static int checkout_merged(int pos, const struct checkout *state)
 	ce = make_transient_cache_entry(mode, &oid, path, 2);
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
-	status = checkout_entry(ce, state, NULL);
+	status = checkout_entry(ce, state, NULL, nr_checkouts);
 	discard_cache_entry(ce);
 	return status;
 }
@@ -257,6 +259,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	struct commit *head;
 	int errs = 0;
 	struct lock_file lock_file = LOCK_INIT;
+	int nr_checkouts = 0;
 
 	if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 		die(_("'%s' cannot be used with updating paths"), "--track");
@@ -371,17 +374,36 @@ static int checkout_paths(const struct checkout_opts *opts,
 		struct cache_entry *ce = active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
 			if (!ce_stage(ce)) {
-				errs |= checkout_entry(ce, &state, NULL);
+				errs |= checkout_entry(ce, &state,
+						       NULL, &nr_checkouts);
 				continue;
 			}
 			if (opts->writeout_stage)
-				errs |= checkout_stage(opts->writeout_stage, ce, pos, &state);
+				errs |= checkout_stage(opts->writeout_stage,
+						       ce, pos,
+						       &state, &nr_checkouts);
 			else if (opts->merge)
-				errs |= checkout_merged(pos, &state);
+				errs |= checkout_merged(pos, &state,
+							&nr_checkouts);
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
-	errs |= finish_delayed_checkout(&state);
+	errs |= finish_delayed_checkout(&state, &nr_checkouts);
+
+	if (opts->count_checkout_paths) {
+		if (opts->source_tree)
+			fprintf_ln(stderr, Q_("Checked out %d path out of %s",
+					      "Checked out %d paths out of %s",
+					      nr_checkouts),
+				   nr_checkouts,
+				   find_unique_abbrev(&opts->source_tree->object.oid,
+						      DEFAULT_ABBREV));
+		else
+			fprintf_ln(stderr, Q_("Checked out %d path out of the index",
+					      "Checked out %d paths out of the index",
+					      nr_checkouts),
+				   nr_checkouts);
+	}
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
@@ -1064,6 +1086,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		has_dash_dash = 1; /* case (3) or (1) */
 	else if (dash_dash_pos >= 2)
 		die(_("only one reference expected, %d given."), dash_dash_pos);
+	opts->count_checkout_paths = !opts->quiet && !has_dash_dash;
 
 	if (!strcmp(arg, "-"))
 		arg = "@{-1}";
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 544b0e8639..71318c26e1 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -323,7 +323,7 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 	int ret;
 
 	ce = make_transient_cache_entry(mode, oid, path, 0);
-	ret = checkout_entry(ce, state, NULL);
+	ret = checkout_entry(ce, state, NULL, NULL);
 
 	discard_cache_entry(ce);
 	return ret;
diff --git a/cache.h b/cache.h
index 8b1ee42ae9..52fb6ba148 100644
--- a/cache.h
+++ b/cache.h
@@ -1540,9 +1540,9 @@ struct checkout {
 #define CHECKOUT_INIT { NULL, "" }
 
 #define TEMPORARY_FILENAME_LENGTH 25
-extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
+extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath, int *nr_checkouts);
 extern void enable_delayed_checkout(struct checkout *state);
-extern int finish_delayed_checkout(struct checkout *state);
+extern int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
 
 struct cache_def {
 	struct strbuf path;
diff --git a/entry.c b/entry.c
index 5d136c5d55..5f213c30fe 100644
--- a/entry.c
+++ b/entry.c
@@ -161,7 +161,7 @@ static int remove_available_paths(struct string_list_item *item, void *cb_data)
 	return !available;
 }
 
-int finish_delayed_checkout(struct checkout *state)
+int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
 {
 	int errs = 0;
 	unsigned delayed_object_count;
@@ -226,7 +226,7 @@ int finish_delayed_checkout(struct checkout *state)
 				ce = index_file_exists(state->istate, path->string,
 						       strlen(path->string), 0);
 				if (ce) {
-					errs |= checkout_entry(ce, state, NULL);
+					errs |= checkout_entry(ce, state, NULL, nr_checkouts);
 					filtered_bytes += ce->ce_stat_data.sd_size;
 					display_throughput(progress, filtered_bytes);
 				} else
@@ -435,8 +435,8 @@ static void mark_colliding_entries(const struct checkout *state,
  * its name is returned in topath[], which must be able to hold at
  * least TEMPORARY_FILENAME_LENGTH bytes long.
  */
-int checkout_entry(struct cache_entry *ce,
-		   const struct checkout *state, char *topath)
+int checkout_entry(struct cache_entry *ce, const struct checkout *state,
+		   char *topath, int *nr_checkouts)
 {
 	static struct strbuf path = STRBUF_INIT;
 	struct stat st;
@@ -506,5 +506,7 @@ int checkout_entry(struct cache_entry *ce,
 		return 0;
 
 	create_directories(path.buf, path.len, state);
+	if (nr_checkouts)
+		(*nr_checkouts)++;
 	return write_entry(ce, path.buf, state, 0);
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index 7570df481b..17f1e601da 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -294,7 +294,7 @@ static void load_gitmodules_file(struct index_state *index,
 			repo_read_gitmodules(the_repository);
 		} else if (state && (ce->ce_flags & CE_UPDATE)) {
 			submodule_free(the_repository);
-			checkout_entry(ce, state, NULL);
+			checkout_entry(ce, state, NULL, NULL);
 			repo_read_gitmodules(the_repository);
 		}
 	}
@@ -450,12 +450,12 @@ static int check_updates(struct unpack_trees_options *o)
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
-				errs |= checkout_entry(ce, &state, NULL);
+				errs |= checkout_entry(ce, &state, NULL, NULL);
 			}
 		}
 	}
 	stop_progress(&progress);
-	errs |= finish_delayed_checkout(&state);
+	errs |= finish_delayed_checkout(&state, NULL);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN);
 
-- 
2.19.1.1318.g5295c6727d

