Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C7BF20401
	for <e@80x24.org>; Thu, 15 Jun 2017 21:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbdFOVHV (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 17:07:21 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36143 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdFOVHS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 17:07:18 -0400
Received: by mail-wm0-f43.google.com with SMTP id m125so10080855wmm.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 14:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dOYg03S1H3WW8HXNZIxz2FBu9uFyeV+zZcV4IlhlJYE=;
        b=irpwWiApy8r5bpce+FPRp8FascFYIf3rqRw+9GQLq94Lgs4LGPfMKckOpsxIyA6v3H
         HKBQPLA+64zrA8JF5zK3JYZ1IghWcrEOhZJdPZFjamEuQ9PPVb1WmwG0U9SY1Oxev6NR
         YlUChmHWgQxxqAQ9l4M+I+2wDJs0HNV1xetUguSgnz3b2tWu5iGQbLKGEJcDdts8jQGH
         BBACLabfaznYpb2JrvgPc5WJz0IUdJvLyIF9Rv9iZDz1Fehk4wHU55TV86LL7P0CebT6
         fzhYP7EWEK9n+NEbKT3WutGiJdnUBg+UIvzxe54QmEYK4p9eBy94kJGSXWhrVamBCEJK
         bkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dOYg03S1H3WW8HXNZIxz2FBu9uFyeV+zZcV4IlhlJYE=;
        b=cHZ7neANonIywG9X0v4TSa0p25N2Wrtp14pOclVIWbgcn7mbRneKkv+2/NxudSCR30
         X+kTpZ+wVVlQvnsR4lgfjpoC9UZEWo+erXOQgW30XWDYiCzFQGtoR00K2QB8tnaeIVdP
         vyALFo+TrZYTm14BLBThkE9ll3ZdzintD/l/5nncV6CbKyItjnrPWQkDt2kM/btC3H9d
         5CIRtM9Zl9jIUq8Mqtga/yU6cxTaT2oa7XX22RXOaByqKYfv6zrWCEiBFIjdW9dWd7eQ
         iM9gK36sWGIl1rRmUyeBvghT2rVfRXHEO885TbY+we7ZEz3cI8t5EbPXp3s8L1f88aJZ
         2/hw==
X-Gm-Message-State: AKS2vOzd9HQsVJORdYbswkNH+cF0apZY2ZvyXiUXFG9CDX2LD756Lywt
        AP/kIwxdh46hHDKabQc=
X-Received: by 10.80.152.22 with SMTP id g22mr5042822edb.10.1497560835539;
        Thu, 15 Jun 2017 14:07:15 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o1sm267230edc.22.2017.06.15.14.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jun 2017 14:07:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/2] *.[ch] refactoring: make use of the FREE_AND_NULL() macro
Date:   Thu, 15 Jun 2017 21:07:00 +0000
Message-Id: <20170615210700.16310-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc
In-Reply-To: <20170615210700.16310-1-avarab@gmail.com>
References: <20170615210700.16310-1-avarab@gmail.com>
In-Reply-To: <CACBZZX7S9A=mPSgqtmVyZbLdR3GVH+ux3tGN1QXBMEzbg8Ffog@mail.gmail.com>
References: <CACBZZX7S9A=mPSgqtmVyZbLdR3GVH+ux3tGN1QXBMEzbg8Ffog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace occurrences of `free(ptr); ptr = NULL` with
`FREE_AND_NULL(ptr)`. This introduces no functional changes, but
reduces the line count and establishes this pattern as a common idiom
with a wrapper macro.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 alias.c                  |  6 ++----
 apply.c                  |  3 +--
 attr.c                   |  6 ++----
 blame.c                  |  3 +--
 branch.c                 |  3 +--
 builtin/am.c             | 18 +++++-------------
 builtin/clean.c          |  6 ++----
 builtin/config.c         |  6 ++----
 builtin/index-pack.c     |  6 ++----
 builtin/pack-objects.c   | 12 ++++--------
 builtin/unpack-objects.c |  3 +--
 builtin/worktree.c       |  6 ++----
 commit-slab.h            |  3 +--
 commit.c                 |  3 +--
 config.c                 |  3 +--
 credential.c             |  9 +++------
 diff-lib.c               |  3 +--
 diff.c                   |  6 ++----
 diffcore-rename.c        |  6 ++----
 dir.c                    |  9 +++------
 fast-import.c            |  6 ++----
 gpg-interface.c          | 15 +++++----------
 grep.c                   | 12 ++++--------
 help.c                   |  3 +--
 http-push.c              | 24 ++++++++----------------
 http.c                   | 15 +++++----------
 imap-send.c              |  3 +--
 line-log.c               |  6 ++----
 ll-merge.c               |  3 +--
 mailinfo.c               |  3 +--
 object.c                 |  3 +--
 pathspec.c               |  3 +--
 prio-queue.c             |  3 +--
 read-cache.c             |  6 ++----
 ref-filter.c             |  3 +--
 refs/files-backend.c     |  3 +--
 refs/ref-cache.c         |  3 +--
 remote-testsvn.c         |  3 +--
 rerere.c                 |  3 +--
 sequencer.c              |  3 +--
 sha1-array.c             |  3 +--
 sha1_file.c              |  3 +--
 split-index.c            |  3 +--
 transport-helper.c       | 27 +++++++++------------------
 transport.c              |  3 +--
 tree-diff.c              |  6 ++----
 tree-walk.c              |  3 +--
 tree.c                   |  3 +--
 48 files changed, 97 insertions(+), 197 deletions(-)

diff --git a/alias.c b/alias.c
index 3b90397a99..911481855f 100644
--- a/alias.c
+++ b/alias.c
@@ -47,8 +47,7 @@ int split_cmdline(char *cmdline, const char ***argv)
 				src++;
 				c = cmdline[src];
 				if (!c) {
-					free(*argv);
-					*argv = NULL;
+					FREE_AND_NULL(*argv);
 					return -SPLIT_CMDLINE_BAD_ENDING;
 				}
 			}
@@ -60,8 +59,7 @@ int split_cmdline(char *cmdline, const char ***argv)
 	cmdline[dst] = 0;
 
 	if (quoted) {
-		free(*argv);
-		*argv = NULL;
+		FREE_AND_NULL(*argv);
 		return -SPLIT_CMDLINE_UNCLOSED_QUOTE;
 	}
 
diff --git a/apply.c b/apply.c
index 854faa6779..e78de0affa 100644
--- a/apply.c
+++ b/apply.c
@@ -3705,8 +3705,7 @@ static int check_preimage(struct apply_state *state,
  is_new:
 	patch->is_new = 1;
 	patch->is_delete = 0;
-	free(patch->old_name);
-	patch->old_name = NULL;
+	FREE_AND_NULL(patch->old_name);
 	return 0;
 }
 
diff --git a/attr.c b/attr.c
index 821203e2a9..ebdcfb0b8a 100644
--- a/attr.c
+++ b/attr.c
@@ -638,13 +638,11 @@ void attr_check_reset(struct attr_check *check)
 
 void attr_check_clear(struct attr_check *check)
 {
-	free(check->items);
-	check->items = NULL;
+	FREE_AND_NULL(check->items);
 	check->alloc = 0;
 	check->nr = 0;
 
-	free(check->all_attrs);
-	check->all_attrs = NULL;
+	FREE_AND_NULL(check->all_attrs);
 	check->all_attrs_nr = 0;
 
 	drop_attr_stack(&check->stack);
diff --git a/blame.c b/blame.c
index 843c845cba..1183943960 100644
--- a/blame.c
+++ b/blame.c
@@ -314,8 +314,7 @@ static void fill_origin_blob(struct diff_options *opt,
 static void drop_origin_blob(struct blame_origin *o)
 {
 	if (o->file.ptr) {
-		free(o->file.ptr);
-		o->file.ptr = NULL;
+		FREE_AND_NULL(o->file.ptr);
 	}
 }
 
diff --git a/branch.c b/branch.c
index 985316eb76..2347cb8649 100644
--- a/branch.c
+++ b/branch.c
@@ -24,8 +24,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 		} else {
 			free(tracking->spec.src);
 			if (tracking->src) {
-				free(tracking->src);
-				tracking->src = NULL;
+				FREE_AND_NULL(tracking->src);
 			}
 		}
 		tracking->spec.src = NULL;
diff --git a/builtin/am.c b/builtin/am.c
index 8881d73615..80368b6fe6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -483,8 +483,7 @@ static int run_applypatch_msg_hook(struct am_state *state)
 	ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
 
 	if (!ret) {
-		free(state->msg);
-		state->msg = NULL;
+		FREE_AND_NULL(state->msg);
 		if (read_commit_msg(state) < 0)
 			die(_("'%s' was deleted by the applypatch-msg hook"),
 				am_path(state, "final-commit"));
@@ -1073,17 +1072,10 @@ static void am_next(struct am_state *state)
 {
 	struct object_id head;
 
-	free(state->author_name);
-	state->author_name = NULL;
-
-	free(state->author_email);
-	state->author_email = NULL;
-
-	free(state->author_date);
-	state->author_date = NULL;
-
-	free(state->msg);
-	state->msg = NULL;
+	FREE_AND_NULL(state->author_name);
+	FREE_AND_NULL(state->author_email);
+	FREE_AND_NULL(state->author_date);
+	FREE_AND_NULL(state->msg);
 	state->msg_len = 0;
 
 	unlink(am_path(state, "author-script"));
diff --git a/builtin/clean.c b/builtin/clean.c
index 142bf668cf..bff5a07330 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -837,8 +837,7 @@ static void interactive_main_loop(void)
 			int ret;
 			ret = menus[*chosen].fn();
 			if (ret != MENU_RETURN_NO_LOOP) {
-				free(chosen);
-				chosen = NULL;
+				FREE_AND_NULL(chosen);
 				if (!del_list.nr) {
 					clean_print_color(CLEAN_COLOR_ERROR);
 					printf_ln(_("No more files to clean, exiting."));
@@ -851,8 +850,7 @@ static void interactive_main_loop(void)
 			quit_cmd();
 		}
 
-		free(chosen);
-		chosen = NULL;
+		FREE_AND_NULL(chosen);
 		break;
 	}
 }
diff --git a/builtin/config.c b/builtin/config.c
index 7f6c25d4d9..18c2158630 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -214,8 +214,7 @@ static int get_value(const char *key_, const char *regex_)
 		key_regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
 			error("invalid key pattern: %s", key_);
-			free(key_regexp);
-			key_regexp = NULL;
+			FREE_AND_NULL(key_regexp);
 			ret = CONFIG_INVALID_PATTERN;
 			goto free_strings;
 		}
@@ -235,8 +234,7 @@ static int get_value(const char *key_, const char *regex_)
 		regexp = (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(regexp, regex_, REG_EXTENDED)) {
 			error("invalid pattern: %s", regex_);
-			free(regexp);
-			regexp = NULL;
+			FREE_AND_NULL(regexp);
 			ret = CONFIG_INVALID_PATTERN;
 			goto free_strings;
 		}
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 04b9dcaf0f..f3b16520c2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -388,8 +388,7 @@ static struct base_data *alloc_base_data(void)
 static void free_base_data(struct base_data *c)
 {
 	if (c->data) {
-		free(c->data);
-		c->data = NULL;
+		FREE_AND_NULL(c->data);
 		get_thread_data()->base_cache_used -= c->size;
 	}
 }
@@ -605,8 +604,7 @@ static void *unpack_data(struct object_entry *obj,
 	git_inflate_end(&stream);
 	free(inbuf);
 	if (consume) {
-		free(data);
-		data = NULL;
+		FREE_AND_NULL(data);
 	}
 	return data;
 }
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f672225def..790615b2c3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -264,8 +264,7 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 		 * make sure no cached delta data remains from a
 		 * previous attempt before a pack split occurred.
 		 */
-		free(entry->delta_data);
-		entry->delta_data = NULL;
+		FREE_AND_NULL(entry->delta_data);
 		entry->z_delta_size = 0;
 	} else if (entry->delta_data) {
 		size = entry->delta_size;
@@ -1375,12 +1374,10 @@ static void cleanup_preferred_base(void)
 		if (!pbase_tree_cache[i])
 			continue;
 		free(pbase_tree_cache[i]->tree_data);
-		free(pbase_tree_cache[i]);
-		pbase_tree_cache[i] = NULL;
+		FREE_AND_NULL(pbase_tree_cache[i]);
 	}
 
-	free(done_pbase_paths);
-	done_pbase_paths = NULL;
+	FREE_AND_NULL(done_pbase_paths);
 	done_pbase_paths_num = done_pbase_paths_alloc = 0;
 }
 
@@ -1970,8 +1967,7 @@ static unsigned long free_unpacked(struct unpacked *n)
 	n->index = NULL;
 	if (n->data) {
 		freed_mem += n->entry->size;
-		free(n->data);
-		n->data = NULL;
+		FREE_AND_NULL(n->data);
 	}
 	n->entry = NULL;
 	n->depth = 0;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 8bc9997767..60bfe48789 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -112,8 +112,7 @@ static void *get_data(unsigned long size)
 			break;
 		if (ret != Z_OK) {
 			error("inflate returned %d", ret);
-			free(buf);
-			buf = NULL;
+			FREE_AND_NULL(buf);
 			if (!recover)
 				exit(1);
 			has_errors = 1;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 793306ea51..41d1c007a4 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -299,10 +299,8 @@ static int add_worktree(const char *path, const char *refname,
 	}
 
 	is_junk = 0;
-	free(junk_work_tree);
-	free(junk_git_dir);
-	junk_work_tree = NULL;
-	junk_git_dir = NULL;
+	FREE_AND_NULL(junk_work_tree);
+	FREE_AND_NULL(junk_git_dir);
 
 done:
 	if (ret || !opts->keep_locked) {
diff --git a/commit-slab.h b/commit-slab.h
index 42d16dcded..3286c3581b 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -82,8 +82,7 @@ static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
 	for (i = 0; i < s->slab_count; i++)				\
 		free(s->slab[i]);					\
 	s->slab_count = 0;						\
-	free(s->slab);							\
-	s->slab = NULL;							\
+	FREE_AND_NULL(s->slab);							\
 }									\
 									\
 static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
diff --git a/commit.c b/commit.c
index 99846d9bf4..cbfd689939 100644
--- a/commit.c
+++ b/commit.c
@@ -287,8 +287,7 @@ void free_commit_buffer(struct commit *commit)
 {
 	struct commit_buffer *v = buffer_slab_peek(&buffer_slab, commit);
 	if (v) {
-		free(v->buffer);
-		v->buffer = NULL;
+		FREE_AND_NULL(v->buffer);
 		v->size = 0;
 	}
 }
diff --git a/config.c b/config.c
index 34a139c40b..0501a60dd2 100644
--- a/config.c
+++ b/config.c
@@ -395,8 +395,7 @@ static int git_config_parse_key_1(const char *key, char **store_key, int *basele
 
 out_free_ret_1:
 	if (store_key) {
-		free(*store_key);
-		*store_key = NULL;
+		FREE_AND_NULL(*store_key);
 	}
 	return -CONFIG_INVALID_KEY;
 }
diff --git a/credential.c b/credential.c
index aa996669fc..924ab58538 100644
--- a/credential.c
+++ b/credential.c
@@ -93,8 +93,7 @@ static void credential_apply_config(struct credential *c)
 	c->configured = 1;
 
 	if (!c->use_http_path && proto_is_http(c->protocol)) {
-		free(c->path);
-		c->path = NULL;
+		FREE_AND_NULL(c->path);
 	}
 }
 
@@ -314,10 +313,8 @@ void credential_reject(struct credential *c)
 	for (i = 0; i < c->helpers.nr; i++)
 		credential_do(c, c->helpers.items[i].string, "erase");
 
-	free(c->username);
-	c->username = NULL;
-	free(c->password);
-	c->password = NULL;
+	FREE_AND_NULL(c->username);
+	FREE_AND_NULL(c->password);
 	c->approved = 0;
 }
 
diff --git a/diff-lib.c b/diff-lib.c
index 76c8f185cd..7528f4163f 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -179,8 +179,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				free(dpath);
 				continue;
 			}
-			free(dpath);
-			dpath = NULL;
+			FREE_AND_NULL(dpath);
 
 			/*
 			 * Show the diff for the 'ce' if we found the one
diff --git a/diff.c b/diff.c
index e35cf6c704..3561adf49f 100644
--- a/diff.c
+++ b/diff.c
@@ -1218,8 +1218,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 			regfree(ecbdata->diff_words->word_regex);
 			free(ecbdata->diff_words->word_regex);
 		}
-		free(ecbdata->diff_words);
-		ecbdata->diff_words = NULL;
+		FREE_AND_NULL(ecbdata->diff_words);
 	}
 }
 
@@ -2951,8 +2950,7 @@ void diff_free_filespec_blob(struct diff_filespec *s)
 void diff_free_filespec_data(struct diff_filespec *s)
 {
 	diff_free_filespec_blob(s);
-	free(s->cnt_data);
-	s->cnt_data = NULL;
+	FREE_AND_NULL(s->cnt_data);
 }
 
 static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
diff --git a/diffcore-rename.c b/diffcore-rename.c
index f7444c86bd..6d8daf9c00 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -667,11 +667,9 @@ void diffcore_rename(struct diff_options *options)
 	for (i = 0; i < rename_dst_nr; i++)
 		free_filespec(rename_dst[i].two);
 
-	free(rename_dst);
-	rename_dst = NULL;
+	FREE_AND_NULL(rename_dst);
 	rename_dst_nr = rename_dst_alloc = 0;
-	free(rename_src);
-	rename_src = NULL;
+	FREE_AND_NULL(rename_src);
 	rename_src_nr = rename_src_alloc = 0;
 	return;
 }
diff --git a/dir.c b/dir.c
index 1759063817..7dc168b806 100644
--- a/dir.c
+++ b/dir.c
@@ -2117,8 +2117,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		for (i = j = 0; j < dir->nr; j++) {
 			if (i &&
 			    check_dir_entry_contains(dir->entries[i - 1], dir->entries[j])) {
-				free(dir->entries[j]);
-				dir->entries[j] = NULL;
+				FREE_AND_NULL(dir->entries[j]);
 			} else {
 				dir->entries[i++] = dir->entries[j];
 			}
@@ -2144,8 +2143,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		     dir->untracked->dir_invalidated))
 			istate->cache_changed |= UNTRACKED_CHANGED;
 		if (dir->untracked != istate->untracked) {
-			free(dir->untracked);
-			dir->untracked = NULL;
+			FREE_AND_NULL(dir->untracked);
 		}
 	}
 	return dir->nr;
@@ -2488,8 +2486,7 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	strbuf_addbuf(out, &untracked->ident);
 
 	strbuf_add(out, ouc, ouc_size(len));
-	free(ouc);
-	ouc = NULL;
+	FREE_AND_NULL(ouc);
 
 	if (!untracked->root) {
 		varint_len = encode_varint(0, varbuf);
diff --git a/fast-import.c b/fast-import.c
index 9a22fc92c0..eeab927d5a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1063,8 +1063,7 @@ static void end_packfile(void)
 		close(pack_data->pack_fd);
 		unlink_or_warn(pack_data->pack_name);
 	}
-	free(pack_data);
-	pack_data = NULL;
+	FREE_AND_NULL(pack_data);
 	running = 0;
 
 	/* We can't carry a delta across packfiles. */
@@ -1149,8 +1148,7 @@ static int store_object(
 
 		/* We cannot carry a delta into the new pack. */
 		if (delta) {
-			free(delta);
-			delta = NULL;
+			FREE_AND_NULL(delta);
 
 			git_deflate_init(&s, pack_compression_level);
 			s.next_in = (void *)dat->buf;
diff --git a/gpg-interface.c b/gpg-interface.c
index e44cc27da1..3f377f89d0 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -13,16 +13,11 @@ static const char *gpg_program = "gpg";
 
 void signature_check_clear(struct signature_check *sigc)
 {
-	free(sigc->payload);
-	free(sigc->gpg_output);
-	free(sigc->gpg_status);
-	free(sigc->signer);
-	free(sigc->key);
-	sigc->payload = NULL;
-	sigc->gpg_output = NULL;
-	sigc->gpg_status = NULL;
-	sigc->signer = NULL;
-	sigc->key = NULL;
+	FREE_AND_NULL(sigc->payload);
+	FREE_AND_NULL(sigc->gpg_output);
+	FREE_AND_NULL(sigc->gpg_status);
+	FREE_AND_NULL(sigc->signer);
+	FREE_AND_NULL(sigc->key);
 }
 
 static struct {
diff --git a/grep.c b/grep.c
index d03d424e5c..909f35a984 100644
--- a/grep.c
+++ b/grep.c
@@ -1763,12 +1763,9 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 
 void grep_source_clear(struct grep_source *gs)
 {
-	free(gs->name);
-	gs->name = NULL;
-	free(gs->path);
-	gs->path = NULL;
-	free(gs->identifier);
-	gs->identifier = NULL;
+	FREE_AND_NULL(gs->name);
+	FREE_AND_NULL(gs->path);
+	FREE_AND_NULL(gs->identifier);
 	grep_source_clear_data(gs);
 }
 
@@ -1778,8 +1775,7 @@ void grep_source_clear_data(struct grep_source *gs)
 	case GREP_SOURCE_FILE:
 	case GREP_SOURCE_SHA1:
 	case GREP_SOURCE_SUBMODULE:
-		free(gs->buf);
-		gs->buf = NULL;
+		FREE_AND_NULL(gs->buf);
 		gs->size = 0;
 		break;
 	case GREP_SOURCE_BUF:
diff --git a/help.c b/help.c
index db7f3d79a0..a2f48c0df3 100644
--- a/help.c
+++ b/help.c
@@ -267,9 +267,8 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 
 	for (i = 0; i < old->cnt; i++)
 		cmds->names[cmds->cnt++] = old->names[i];
-	free(old->names);
+	FREE_AND_NULL(old->names);
 	old->cnt = 0;
-	old->names = NULL;
 }
 
 /* An empirically derived magic number */
diff --git a/http-push.c b/http-push.c
index 67c4d4b472..c91f40a610 100644
--- a/http-push.c
+++ b/http-push.c
@@ -291,8 +291,7 @@ static void start_mkcol(struct transfer_request *request)
 		request->state = RUN_MKCOL;
 	} else {
 		request->state = ABORTED;
-		free(request->url);
-		request->url = NULL;
+		FREE_AND_NULL(request->url);
 	}
 }
 #endif
@@ -409,8 +408,7 @@ static void start_put(struct transfer_request *request)
 		request->state = RUN_PUT;
 	} else {
 		request->state = ABORTED;
-		free(request->url);
-		request->url = NULL;
+		FREE_AND_NULL(request->url);
 	}
 }
 
@@ -432,8 +430,7 @@ static void start_move(struct transfer_request *request)
 		request->state = RUN_MOVE;
 	} else {
 		request->state = ABORTED;
-		free(request->url);
-		request->url = NULL;
+		FREE_AND_NULL(request->url);
 	}
 }
 
@@ -526,8 +523,7 @@ static void finish_request(struct transfer_request *request)
 
 	/* URL is reused for MOVE after PUT */
 	if (request->state != RUN_PUT) {
-		free(request->url);
-		request->url = NULL;
+		FREE_AND_NULL(request->url);
 	}
 
 	if (request->state == RUN_MKCOL) {
@@ -803,8 +799,7 @@ xml_start_tag(void *userData, const char *name, const char **atts)
 	}
 	xsnprintf(ctx->name + old_namelen, ctx->len - old_namelen, ".%s", c);
 
-	free(ctx->cdata);
-	ctx->cdata = NULL;
+	FREE_AND_NULL(ctx->cdata);
 
 	ctx->userFunc(ctx, 0);
 }
@@ -932,8 +927,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 		free(lock->token);
 		free(lock->owner);
 		free(url);
-		free(lock);
-		lock = NULL;
+		FREE_AND_NULL(lock);
 	} else {
 		lock->url = url;
 		lock->start_time = time(NULL);
@@ -1105,8 +1099,7 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 			ls->dentry_flags |= IS_DIR;
 		}
 	} else if (!strcmp(ctx->name, DAV_PROPFIND_RESP)) {
-		free(ls->dentry_name);
-		ls->dentry_name = NULL;
+		FREE_AND_NULL(ls->dentry_name);
 		ls->dentry_flags = 0;
 	}
 }
@@ -1547,8 +1540,7 @@ static void fetch_symref(const char *path, char **symref, struct object_id *oid)
 		    curl_errorstr);
 	free(url);
 
-	free(*symref);
-	*symref = NULL;
+	FREE_AND_NULL(*symref);
 	oidclr(oid);
 
 	if (buffer.len == 0)
diff --git a/http.c b/http.c
index d2e11ec6f0..77f46bef0f 100644
--- a/http.c
+++ b/http.c
@@ -1026,8 +1026,7 @@ void http_cleanup(void)
 
 	if (proxy_auth.password) {
 		memset(proxy_auth.password, 0, strlen(proxy_auth.password));
-		free(proxy_auth.password);
-		proxy_auth.password = NULL;
+		FREE_AND_NULL(proxy_auth.password);
 	}
 
 	free((void *)curl_proxyuserpwd);
@@ -1038,13 +1037,11 @@ void http_cleanup(void)
 
 	if (cert_auth.password != NULL) {
 		memset(cert_auth.password, 0, strlen(cert_auth.password));
-		free(cert_auth.password);
-		cert_auth.password = NULL;
+		FREE_AND_NULL(cert_auth.password);
 	}
 	ssl_cert_password_required = 0;
 
-	free(cached_accept_language);
-	cached_accept_language = NULL;
+	FREE_AND_NULL(cached_accept_language);
 }
 
 struct active_request_slot *get_active_slot(void)
@@ -1896,8 +1893,7 @@ static char *fetch_pack_index(unsigned char *sha1, const char *base_url)
 
 	if (http_get_file(url, tmp, NULL) != HTTP_OK) {
 		error("Unable to get pack index %s", url);
-		free(tmp);
-		tmp = NULL;
+		FREE_AND_NULL(tmp);
 	}
 
 	free(url);
@@ -2328,8 +2324,7 @@ void release_http_object_request(struct http_object_request *freq)
 		freq->localfile = -1;
 	}
 	if (freq->url != NULL) {
-		free(freq->url);
-		freq->url = NULL;
+		FREE_AND_NULL(freq->url);
 	}
 	if (freq->slot != NULL) {
 		freq->slot->callback_func = NULL;
diff --git a/imap-send.c b/imap-send.c
index 857591660f..40ddb496e6 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -776,8 +776,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 			       offsetof(struct imap_cmd, next));
 			if (cmdp->cb.data) {
 				n = socket_write(&imap->buf.sock, cmdp->cb.data, cmdp->cb.dlen);
-				free(cmdp->cb.data);
-				cmdp->cb.data = NULL;
+				FREE_AND_NULL(cmdp->cb.data);
 				if (n != (int)cmdp->cb.dlen)
 					return RESP_BAD;
 			} else if (cmdp->cb.cont) {
diff --git a/line-log.c b/line-log.c
index b9087814b8..2d60c347ca 100644
--- a/line-log.c
+++ b/line-log.c
@@ -34,9 +34,8 @@ void range_set_init(struct range_set *rs, size_t prealloc)
 
 void range_set_release(struct range_set *rs)
 {
-	free(rs->ranges);
+	FREE_AND_NULL(rs->ranges);
 	rs->alloc = rs->nr = 0;
-	rs->ranges = NULL;
 }
 
 /* dst must be uninitialized! */
@@ -610,8 +609,7 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
 		line_log_data_insert(&ranges, full_name, begin, end);
 
 		free_filespec(spec);
-		free(ends);
-		ends = NULL;
+		FREE_AND_NULL(ends);
 	}
 
 	for (p = ranges; p; p = p->next)
diff --git a/ll-merge.c b/ll-merge.c
index ac0d4a5d78..91ff519cef 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -209,8 +209,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 	result->size = st.st_size;
 	result->ptr = xmallocz(result->size);
 	if (read_in_full(fd, result->ptr, result->size) != result->size) {
-		free(result->ptr);
-		result->ptr = NULL;
+		FREE_AND_NULL(result->ptr);
 		result->size = 0;
 	}
  close_bad:
diff --git a/mailinfo.c b/mailinfo.c
index f92cb9f729..44f829edb1 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -919,8 +919,7 @@ static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
 		/* we hit an end boundary */
 		/* pop the current boundary off the stack */
 		strbuf_release(*(mi->content_top));
-		free(*(mi->content_top));
-		*(mi->content_top) = NULL;
+		FREE_AND_NULL(*(mi->content_top));
 
 		/* technically won't happen as is_multipart_boundary()
 		   will fail first.  But just in case..
diff --git a/object.c b/object.c
index 06ba3a11d8..f818777412 100644
--- a/object.c
+++ b/object.c
@@ -377,8 +377,7 @@ void object_array_clear(struct object_array *array)
 	int i;
 	for (i = 0; i < array->nr; i++)
 		object_array_release_entry(&array->objects[i]);
-	free(array->objects);
-	array->objects = NULL;
+	FREE_AND_NULL(array->objects);
 	array->nr = array->alloc = 0;
 }
 
diff --git a/pathspec.c b/pathspec.c
index 828405021f..54aab8bc01 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -662,7 +662,6 @@ void clear_pathspec(struct pathspec *pathspec)
 			attr_check_free(pathspec->items[i].attr_check);
 	}
 
-	free(pathspec->items);
-	pathspec->items = NULL;
+	FREE_AND_NULL(pathspec->items);
 	pathspec->nr = 0;
 }
diff --git a/prio-queue.c b/prio-queue.c
index fc3860fdcb..126d096727 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -27,10 +27,9 @@ void prio_queue_reverse(struct prio_queue *queue)
 
 void clear_prio_queue(struct prio_queue *queue)
 {
-	free(queue->array);
+	FREE_AND_NULL(queue->array);
 	queue->nr = 0;
 	queue->alloc = 0;
-	queue->array = NULL;
 	queue->insertion_ctr = 0;
 }
 
diff --git a/read-cache.c b/read-cache.c
index bc156a133e..66c413657e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1888,8 +1888,7 @@ int discard_index(struct index_state *istate)
 	free_name_hash(istate);
 	cache_tree_free(&(istate->cache_tree));
 	istate->initialized = 0;
-	free(istate->cache);
-	istate->cache = NULL;
+	FREE_AND_NULL(istate->cache);
 	istate->cache_alloc = 0;
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
@@ -2603,8 +2602,7 @@ void *read_blob_data_from_index(const struct index_state *istate,
 
 void stat_validity_clear(struct stat_validity *sv)
 {
-	free(sv->sd);
-	sv->sd = NULL;
+	FREE_AND_NULL(sv->sd);
 }
 
 int stat_validity_check(struct stat_validity *sv, const char *path)
diff --git a/ref-filter.c b/ref-filter.c
index ab32bc9c31..72e6cb8ecc 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1891,8 +1891,7 @@ void ref_array_clear(struct ref_array *array)
 
 	for (i = 0; i < array->nr; i++)
 		free_array_item(array->items[i]);
-	free(array->items);
-	array->items = NULL;
+	FREE_AND_NULL(array->items);
 	array->nr = array->alloc = 0;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d8b3f73147..c1bd99d60f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2944,8 +2944,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 				       head_oid.hash, &head_type);
 
 	if (head_ref && !(head_type & REF_ISSYMREF)) {
-		free(head_ref);
-		head_ref = NULL;
+		FREE_AND_NULL(head_ref);
 	}
 
 	/*
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index af2fcb2c12..76bb723c86 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -82,9 +82,8 @@ static void clear_ref_dir(struct ref_dir *dir)
 	int i;
 	for (i = 0; i < dir->nr; i++)
 		free_ref_entry(dir->entries[i]);
-	free(dir->entries);
+	FREE_AND_NULL(dir->entries);
 	dir->sorted = dir->nr = dir->alloc = 0;
-	dir->entries = NULL;
 }
 
 struct ref_entry *create_dir_entry(struct ref_cache *cache,
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 50404ef343..078b0c3139 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -66,8 +66,7 @@ static char *read_ref_note(const unsigned char sha1[20])
 	else if (!msglen || type != OBJ_BLOB) {
 		error("Note contains unusable content. "
 			"Is something else using this notes tree? %s", notes_ref);
-		free(msg);
-		msg = NULL;
+		FREE_AND_NULL(msg);
 	}
 	free_notes(NULL);
 	return msg;
diff --git a/rerere.c b/rerere.c
index c26c29f87a..61f3804a1e 100644
--- a/rerere.c
+++ b/rerere.c
@@ -39,9 +39,8 @@ static void free_rerere_dirs(void)
 		free(rerere_dir[i]->status);
 		free(rerere_dir[i]);
 	}
-	free(rerere_dir);
+	FREE_AND_NULL(rerere_dir);
 	rerere_dir_nr = rerere_dir_alloc = 0;
-	rerere_dir = NULL;
 }
 
 static void free_rerere_id(struct string_list_item *item)
diff --git a/sequencer.c b/sequencer.c
index 5282fb849c..070b42f240 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1211,8 +1211,7 @@ struct todo_list {
 static void todo_list_release(struct todo_list *todo_list)
 {
 	strbuf_release(&todo_list->buf);
-	free(todo_list->items);
-	todo_list->items = NULL;
+	FREE_AND_NULL(todo_list->items);
 	todo_list->nr = todo_list->alloc = 0;
 }
 
diff --git a/sha1-array.c b/sha1-array.c
index 7d646ab5b8..838b3bf847 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -35,8 +35,7 @@ int oid_array_lookup(struct oid_array *array, const struct object_id *oid)
 
 void oid_array_clear(struct oid_array *array)
 {
-	free(array->oid);
-	array->oid = NULL;
+	FREE_AND_NULL(array->oid);
 	array->nr = 0;
 	array->alloc = 0;
 	array->sorted = 0;
diff --git a/sha1_file.c b/sha1_file.c
index 59a4ed2ed3..d67c88bb8d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -610,8 +610,7 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 
 out:
 	if (seen_error) {
-		free(ref_git);
-		ref_git = NULL;
+		FREE_AND_NULL(ref_git);
 	}
 
 	return ref_git;
diff --git a/split-index.c b/split-index.c
index 49bd197f71..20477c6a48 100644
--- a/split-index.c
+++ b/split-index.c
@@ -174,10 +174,9 @@ void merge_base_index(struct index_state *istate)
 
 	ewah_free(si->delete_bitmap);
 	ewah_free(si->replace_bitmap);
-	free(si->saved_cache);
+	FREE_AND_NULL(si->saved_cache);
 	si->delete_bitmap  = NULL;
 	si->replace_bitmap = NULL;
-	si->saved_cache	   = NULL;
 	si->saved_cache_nr = 0;
 }
 
diff --git a/transport-helper.c b/transport-helper.c
index 36408046eb..33cff38cc0 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -242,8 +242,7 @@ static int disconnect_helper(struct transport *transport)
 		close(data->helper->out);
 		fclose(data->out);
 		res = finish_command(data->helper);
-		free(data->helper);
-		data->helper = NULL;
+		FREE_AND_NULL(data->helper);
 	}
 	return res;
 }
@@ -711,43 +710,35 @@ static int push_update_ref_status(struct strbuf *buf,
 
 		if (!strcmp(msg, "no match")) {
 			status = REF_STATUS_NONE;
-			free(msg);
-			msg = NULL;
+			FREE_AND_NULL(msg);
 		}
 		else if (!strcmp(msg, "up to date")) {
 			status = REF_STATUS_UPTODATE;
-			free(msg);
-			msg = NULL;
+			FREE_AND_NULL(msg);
 		}
 		else if (!strcmp(msg, "non-fast forward")) {
 			status = REF_STATUS_REJECT_NONFASTFORWARD;
-			free(msg);
-			msg = NULL;
+			FREE_AND_NULL(msg);
 		}
 		else if (!strcmp(msg, "already exists")) {
 			status = REF_STATUS_REJECT_ALREADY_EXISTS;
-			free(msg);
-			msg = NULL;
+			FREE_AND_NULL(msg);
 		}
 		else if (!strcmp(msg, "fetch first")) {
 			status = REF_STATUS_REJECT_FETCH_FIRST;
-			free(msg);
-			msg = NULL;
+			FREE_AND_NULL(msg);
 		}
 		else if (!strcmp(msg, "needs force")) {
 			status = REF_STATUS_REJECT_NEEDS_FORCE;
-			free(msg);
-			msg = NULL;
+			FREE_AND_NULL(msg);
 		}
 		else if (!strcmp(msg, "stale info")) {
 			status = REF_STATUS_REJECT_STALE;
-			free(msg);
-			msg = NULL;
+			FREE_AND_NULL(msg);
 		}
 		else if (!strcmp(msg, "forced update")) {
 			forced = 1;
-			free(msg);
-			msg = NULL;
+			FREE_AND_NULL(msg);
 		}
 	}
 
diff --git a/transport.c b/transport.c
index 9bfcf870f9..cf35088001 100644
--- a/transport.c
+++ b/transport.c
@@ -1145,8 +1145,7 @@ void transport_unlock_pack(struct transport *transport)
 {
 	if (transport->pack_lockfile) {
 		unlink_or_warn(transport->pack_lockfile);
-		free(transport->pack_lockfile);
-		transport->pack_lockfile = NULL;
+		FREE_AND_NULL(transport->pack_lockfile);
 	}
 }
 
diff --git a/tree-diff.c b/tree-diff.c
index e164e532b2..1e1b393d08 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -140,8 +140,7 @@ static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 	/* if last->next is !NULL - it is a pre-allocated memory, we can reuse */
 	p = last->next;
 	if (p && (alloclen > (intptr_t)p->next)) {
-		free(p);
-		p = NULL;
+		FREE_AND_NULL(p);
 	}
 
 	if (!p) {
@@ -559,8 +558,7 @@ struct combine_diff_path *diff_tree_paths(
 	 * (see path_appendnew() for details about why)
 	 */
 	if (p->next) {
-		free(p->next);
-		p->next = NULL;
+		FREE_AND_NULL(p->next);
 	}
 
 	return p;
diff --git a/tree-walk.c b/tree-walk.c
index 6a42e402b0..9f67b89c87 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -479,8 +479,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 	for (i = 0; i < n; i++)
 		free_extended_entry(tx + i);
 	free(tx);
-	free(traverse_path);
-	info->traverse_path = NULL;
+	FREE_AND_NULL(traverse_path);
 	strbuf_release(&base);
 	return error;
 }
diff --git a/tree.c b/tree.c
index 603b29ee80..614f91586d 100644
--- a/tree.c
+++ b/tree.c
@@ -226,8 +226,7 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 
 void free_tree_buffer(struct tree *tree)
 {
-	free(tree->buffer);
-	tree->buffer = NULL;
+	FREE_AND_NULL(tree->buffer);
 	tree->size = 0;
 	tree->object.parsed = 0;
 }
-- 
2.13.1.508.gb3defc5cc

