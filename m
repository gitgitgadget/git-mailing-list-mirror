Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E430FEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 18:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjFZSLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 14:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjFZSLd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 14:11:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0FA9F
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 11:11:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f9c2913133so46797405e9.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687803089; x=1690395089;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffMNYU9t9mT94oGwmf1VYgtHxCG+c9WsxavKsVTyB4Q=;
        b=Q5g/iLYMAUguIZEuhl548gIsR1LYCqdQydqxtAs8H46PF0mz6+ONNkXDr9EtT+QkeX
         cpOn1ZBjWU81xLXt/iNjGRa77O22jgtbXljEbEdBXsmV3qUeRNJXMsNc0+uwgAnM+Qah
         v6m6rrAhpPTvJJixpGQBfHQ30+Hp1mhNYTsGEHtpZ4a9XDU6Z7t8IEYZPatID7Yuf148
         t8NiNTkCEomWAyMZzozuOraKqWSkefhDHZ4MhPL4+cbHnyPrNa4OI1+xM3YO4IJ8Z0yt
         dHAphPjWUMJ9Egk49Ekkd99c48o9mmxvYzbm9wvMHx6viiIbulXra+Gghx5aUEpgGyxQ
         dz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803089; x=1690395089;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffMNYU9t9mT94oGwmf1VYgtHxCG+c9WsxavKsVTyB4Q=;
        b=lPDVNswZ7Qh2k9Bsd/CDBqTBSn76rkExsS1I8k+afmo2TRXUHmwPasF10WTqdmeMvN
         3sBwVQf/kUlsN0/EjnbGI0IOwmT0OT4pYHvr2x9mK3ESFxtbN9oxrUSmpyH1bRfJiGw1
         PZTo4Luye3lJefqiS/fM0RAZJMSYZEYxO8cBODT0n/CcCQZr83p8bVqAci3yJgUAb2M5
         q2aJVwG/OyqfDk0EDdNOo7prE+i13NjjCcrQvDkRCPcRiEemHfViHIOz6ke2sKqP60OC
         UKt12oX3/LawbXW1cUG7+Ur4oYSAyw09Fi/Jr5u+HtNs0PeHDQtcTIudkakv3qkt/8No
         dQkg==
X-Gm-Message-State: AC+VfDz4LGOIVT8CoAprczzJpdi3YNGV+r3zLi9+Qk8exrZFRFAwjnSZ
        JhS6PuhEVBsZRqAI8cmaw6Hz8ZPpg4o=
X-Google-Smtp-Source: ACHHUZ7AT3+Zyw0lOQTPLgkjppUQKJ5BKtxOuxKH+eki8jGzae/nzQF27ncnHd8S45SciBsbxoBh1Q==
X-Received: by 2002:a7b:cb85:0:b0:3fb:9ef2:157 with SMTP id m5-20020a7bcb85000000b003fb9ef20157mr44393wmi.28.1687803089238;
        Mon, 26 Jun 2023 11:11:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bcbd4000000b003fb739d27aesm362866wmi.35.2023.06.26.11.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:11:28 -0700 (PDT)
Message-Id: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
References: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 18:11:11 +0000
Subject: [PATCH v4 00/12] config: remove global state from config iteration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the careful reread of the previous round and the helpful suggestions.
This version is _mostly_ just the previous one rebased onto a newer 'master'
with the conflicting topics applied, per Jonathan's and Junio's suggestions, and
I plan to address Jonathan's comments in the next version.

Junio: There is now a minor conflict with the bugfix I sent in [1] (the
resolution is to just pick this series). It seemed small enough that I didn't
think it was worth basing this series on top of that, but let me know if you
feel otherwise. If both series happen to go through the same release cycle, we
could also drop that one-patch.

I also tested these patches on top of 'seen', and the only conflict I found was
with en/header-split-cache-h-part-3, where ll-merge.c got renamed to merge-ll.c,
so we need to apply the config refactor there (should work with .cocci).

= Changes since v3

- Rebase onto newer 'master'
- Move the 'remove UNUSED from tr2_cfg_cb' hunk from 9/12 -> 8/12. It should
  have been there all along; v3 8/12 didn't build at all.

[1] https://lore.kernel.org/git/pull.1535.git.git.1687801297404.gitgitgadget@gmail.com/


Glen Choo (12):
  config: inline git_color_default_config
  urlmatch.h: use config_fn_t type
  config: add ctx arg to config_fn_t
  config.c: pass ctx in configsets
  config: pass ctx with config files
  builtin/config.c: test misuse of format_config()
  config.c: pass ctx with CLI config
  trace2: plumb config kvi
  config: pass kvi to die_bad_number()
  config.c: remove config_reader from configsets
  config: add kvi.path, use it to evaluate includes
  config: pass source to config_parser_event_fn_t

 alias.c                                       |   3 +-
 archive-tar.c                                 |   5 +-
 archive-zip.c                                 |   1 +
 builtin/add.c                                 |   8 +-
 builtin/blame.c                               |   5 +-
 builtin/branch.c                              |   8 +-
 builtin/cat-file.c                            |   5 +-
 builtin/checkout.c                            |  12 +-
 builtin/clean.c                               |   9 +-
 builtin/clone.c                               |  11 +-
 builtin/column.c                              |   3 +-
 builtin/commit-graph.c                        |   3 +-
 builtin/commit.c                              |  20 +-
 builtin/config.c                              |  72 ++-
 builtin/difftool.c                            |   5 +-
 builtin/fetch.c                               |  13 +-
 builtin/fsmonitor--daemon.c                   |  11 +-
 builtin/grep.c                                |  12 +-
 builtin/help.c                                |   5 +-
 builtin/index-pack.c                          |   9 +-
 builtin/log.c                                 |  12 +-
 builtin/merge.c                               |   7 +-
 builtin/multi-pack-index.c                    |   1 +
 builtin/pack-objects.c                        |  19 +-
 builtin/patch-id.c                            |   5 +-
 builtin/pull.c                                |   5 +-
 builtin/push.c                                |   5 +-
 builtin/read-tree.c                           |   5 +-
 builtin/rebase.c                              |   5 +-
 builtin/receive-pack.c                        |  15 +-
 builtin/reflog.c                              |   7 +-
 builtin/remote.c                              |  15 +-
 builtin/repack.c                              |   5 +-
 builtin/reset.c                               |   5 +-
 builtin/send-pack.c                           |   5 +-
 builtin/show-branch.c                         |   8 +-
 builtin/stash.c                               |   5 +-
 builtin/submodule--helper.c                   |   3 +-
 builtin/tag.c                                 |   9 +-
 builtin/var.c                                 |   5 +-
 builtin/worktree.c                            |   5 +-
 bundle-uri.c                                  |   9 +-
 color.c                                       |   8 -
 color.h                                       |   6 +-
 compat/mingw.c                                |   3 +-
 compat/mingw.h                                |   4 +-
 config.c                                      | 552 +++++++-----------
 config.h                                      |  80 ++-
 connect.c                                     |   4 +-
 .../coccinelle/config_fn_ctx.pending.cocci    | 144 +++++
 contrib/coccinelle/git_config_number.cocci    |  27 +
 convert.c                                     |   4 +-
 credential.c                                  |   1 +
 delta-islands.c                               |   4 +-
 diff.c                                        |  19 +-
 diff.h                                        |   7 +-
 fetch-pack.c                                  |   5 +-
 fmt-merge-msg.c                               |   7 +-
 fmt-merge-msg.h                               |   3 +-
 fsck.c                                        |  12 +-
 fsck.h                                        |   4 +-
 git-compat-util.h                             |   2 +
 gpg-interface.c                               |   7 +-
 grep.c                                        |   7 +-
 grep.h                                        |   4 +-
 help.c                                        |   9 +-
 http.c                                        |  15 +-
 ident.c                                       |   4 +-
 ident.h                                       |   4 +-
 imap-send.c                                   |   7 +-
 ll-merge.c                                    |   1 +
 ls-refs.c                                     |   1 +
 mailinfo.c                                    |   5 +-
 notes-utils.c                                 |   4 +-
 notes.c                                       |   4 +-
 pager.c                                       |   5 +-
 pretty.c                                      |   1 +
 promisor-remote.c                             |   4 +-
 remote.c                                      |   8 +-
 revision.c                                    |   4 +-
 scalar.c                                      |   4 +-
 sequencer.c                                   |  29 +-
 setup.c                                       |  18 +-
 submodule-config.c                            |  31 +-
 submodule-config.h                            |   3 +-
 t/helper/test-config.c                        |  24 +-
 t/helper/test-userdiff.c                      |   4 +-
 t/t1300-config.sh                             |  27 +
 trace2.c                                      |   4 +-
 trace2.h                                      |   3 +-
 trace2/tr2_cfg.c                              |  16 +-
 trace2/tr2_sysenv.c                           |   3 +-
 trace2/tr2_tgt.h                              |   4 +-
 trace2/tr2_tgt_event.c                        |   4 +-
 trace2/tr2_tgt_normal.c                       |   4 +-
 trace2/tr2_tgt_perf.c                         |   4 +-
 trailer.c                                     |   2 +
 upload-pack.c                                 |  18 +-
 urlmatch.c                                    |   7 +-
 urlmatch.h                                    |   8 +-
 worktree.c                                    |   2 +-
 xdiff-interface.c                             |   5 +-
 xdiff-interface.h                             |   4 +-
 103 files changed, 960 insertions(+), 638 deletions(-)
 create mode 100644 contrib/coccinelle/config_fn_ctx.pending.cocci
 create mode 100644 contrib/coccinelle/git_config_number.cocci


base-commit: 6ff334181cfb6485d3ba50843038209a2a253907
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1497%2Fchooglen%2Fconfig%2Fno-global-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1497/chooglen/config/no-global-v4
Pull-Request: https://github.com/git/git/pull/1497

Range-diff vs v3:

  1:  26109b65142 !  1:  7bfffb454c5 config: inline git_color_default_config
     @@ Commit message
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     + ## builtin/add.c ##
     +@@ builtin/add.c: static int add_config(const char *var, const char *value, void *cb)
     + 		return 0;
     + 	}
     + 
     +-	return git_color_default_config(var, value, cb);
     ++	if (git_color_config(var, value, cb) < 0)
     ++		return -1;
     ++
     ++	return git_default_config(var, value, cb);
     + }
     + 
     + static const char embedded_advice[] = N_(
     +
       ## builtin/branch.c ##
      @@ builtin/branch.c: static int git_branch_config(const char *var, const char *value, void *cb)
       		return 0;
  2:  1aeffcb1395 =  2:  739c519ce62 urlmatch.h: use config_fn_t type
  3:  d3eb439aad2 !  3:  a9a0a50f32a config: add ctx arg to config_fn_t
     @@ builtin/add.c: static struct option builtin_add_options[] = {
       	if (!strcmp(var, "add.ignoreerrors") ||
       	    !strcmp(var, "add.ignore-errors")) {
      @@ builtin/add.c: static int add_config(const char *var, const char *value, void *cb)
     - 		return 0;
     - 	}
     + 	if (git_color_config(var, value, cb) < 0)
     + 		return -1;
       
      -	return git_default_config(var, value, cb);
      +	return git_default_config(var, value, ctx, cb);
     @@ builtin/difftool.c: static const char *const builtin_difftool_usage[] = {
      
       ## builtin/fetch.c ##
      @@ builtin/fetch.c: struct fetch_config {
     - 	enum display_format display_format;
     + 	int submodule_fetch_jobs;
       };
       
      -static int git_fetch_config(const char *k, const char *v, void *cb)
  4:  c5051ddc10d =  4:  39b2e291f86 config.c: pass ctx in configsets
  5:  595e7d2e163 !  5:  bfc6d2833c5 config: pass ctx with config files
     @@ config.c: static int do_git_config_sequence(struct config_reader *reader,
      +							 CONFIG_SCOPE_LOCAL, NULL);
       
       	config_reader_set_scope(reader, CONFIG_SCOPE_WORKTREE);
     - 	if (!opts->ignore_worktree && repository_format_worktree_config) {
     - 		char *path = git_pathdup("config.worktree");
     - 		if (!access_or_die(path, R_OK, 0))
     --			ret += git_config_from_file(fn, path, data);
     -+			ret += git_config_from_file_with_options(fn, path, data,
     + 	if (!opts->ignore_worktree && worktree_config &&
     + 	    repo && repo->repository_format_worktree_config &&
     + 	    !access_or_die(worktree_config, R_OK, 0)) {
     +-		ret += git_config_from_file(fn, worktree_config, data);
     ++			ret += git_config_from_file_with_options(fn, worktree_config, data,
      +								 CONFIG_SCOPE_WORKTREE,
      +								 NULL);
     - 		free(path);
       	}
       
     + 	config_reader_set_scope(reader, CONFIG_SCOPE_COMMAND);
      @@ config.c: int config_with_options(config_fn_t fn, void *data,
       	 * regular lookup sequence.
       	 */
     @@ config.c: int config_with_options(config_fn_t fn, void *data,
      +							data, config_source->scope,
      +							NULL);
       	} else if (config_source && config_source->blob) {
     - 		struct repository *repo = config_source->repo ?
     - 			config_source->repo : the_repository;
       		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
      -						data);
      +					       data, config_source->scope);
       	} else {
     - 		ret = do_git_config_sequence(&the_reader, opts, fn, data);
     + 		ret = do_git_config_sequence(&the_reader, opts, repo, fn, data);
       	}
      @@ config.c: static int configset_add_value(struct config_reader *reader,
       	if (!reader->source)
  6:  a2a891a069f =  6:  897bdc759b5 builtin/config.c: test misuse of format_config()
  7:  1fb1708bbd9 !  7:  33e4437737d config.c: pass ctx with CLI config
     @@ builtin/config.c: static int collect_config(const char *key_, const char *value_
       
       static int get_value(const char *key_, const char *regex_, unsigned flags)
      @@ builtin/config.c: static int get_value(const char *key_, const char *regex_, unsigned flags)
     - 			    &given_config_source, &config_options);
     + 			    &config_options);
       
       	if (!values.nr && default_value) {
      +		struct key_value_info kvi = KVI_INIT;
  8:  66572df7beb !  8:  9bd5f60282c trace2: plumb config kvi
     @@ config.c: static void populate_remote_urls(struct config_include_data *inc)
      -
       	inc->remote_urls = xmalloc(sizeof(*inc->remote_urls));
       	string_list_init_dup(inc->remote_urls);
     - 	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
     + 	config_with_options(add_remote_url, inc->remote_urls,
     + 			    inc->config_source, inc->repo, &opts);
      -
      -	config_reader_set_scope(inc->config_reader, store_scope);
       }
       
       static int forbid_remote_url(const char *var, const char *value UNUSED,
      @@ config.c: static int do_git_config_sequence(struct config_reader *reader,
     - 	char *xdg_config = NULL;
       	char *user_config = NULL;
       	char *repo_config;
     + 	char *worktree_config;
      -	enum config_scope prev_parsing_scope = reader->parsing_scope;
       
     - 	if (opts->commondir)
     - 		repo_config = mkpathdup("%s/config", opts->commondir);
     + 	/*
     + 	 * Ensure that either:
      @@ config.c: static int do_git_config_sequence(struct config_reader *reader,
     - 	else
     - 		repo_config = NULL;
     + 		worktree_config = NULL;
     + 	}
       
      -	config_reader_set_scope(reader, CONFIG_SCOPE_SYSTEM);
       	if (git_config_system() && system_config &&
     @@ config.c: static int do_git_config_sequence(struct config_reader *reader,
       							 CONFIG_SCOPE_LOCAL, NULL);
       
      -	config_reader_set_scope(reader, CONFIG_SCOPE_WORKTREE);
     - 	if (!opts->ignore_worktree && repository_format_worktree_config) {
     - 		char *path = git_pathdup("config.worktree");
     - 		if (!access_or_die(path, R_OK, 0))
     + 	if (!opts->ignore_worktree && worktree_config &&
     + 	    repo && repo->repository_format_worktree_config &&
     + 	    !access_or_die(worktree_config, R_OK, 0)) {
      @@ config.c: static int do_git_config_sequence(struct config_reader *reader,
     - 		free(path);
     + 								 NULL);
       	}
       
      -	config_reader_set_scope(reader, CONFIG_SCOPE_COMMAND);
     @@ trace2.h: void trace2_thread_exit_fl(const char *file, int line);
       	trace2_def_param_fl(__FILE__, __LINE__, (param), (value))
      
       ## trace2/tr2_cfg.c ##
     +@@ trace2/tr2_cfg.c: struct tr2_cfg_data {
     +  * See if the given config key matches any of our patterns of interest.
     +  */
     + static int tr2_cfg_cb(const char *key, const char *value,
     +-		      const struct config_context *ctx UNUSED, void *d)
     ++		      const struct config_context *ctx, void *d)
     + {
     + 	struct strbuf **s;
     + 	struct tr2_cfg_data *data = (struct tr2_cfg_data *)d;
      @@ trace2/tr2_cfg.c: static int tr2_cfg_cb(const char *key, const char *value,
       		struct strbuf *buf = *s;
       		int wm = wildmatch(buf->buf, key, WM_CASEFOLD);
  9:  123e19dda4a !  9:  114723ee4a7 config: pass kvi to die_bad_number()
     @@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v,
       	}
       
       	if (!strcmp(k, "submodule.fetchjobs")) {
     --		submodule_fetch_jobs_config = parse_submodule_fetchjobs(k, v);
     -+		submodule_fetch_jobs_config = parse_submodule_fetchjobs(k, v, ctx->kvi);
     +-		fetch_config->submodule_fetch_jobs = parse_submodule_fetchjobs(k, v);
     ++		fetch_config->submodule_fetch_jobs = parse_submodule_fetchjobs(k, v, ctx->kvi);
       		return 0;
       	} else if (!strcmp(k, "fetch.recursesubmodules")) {
     - 		recurse_submodules = parse_fetch_recurse_submodules_arg(k, v);
     + 		fetch_config->recurse_submodules = parse_fetch_recurse_submodules_arg(k, v);
      @@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v,
       	}
       
       	if (!strcmp(k, "fetch.parallel")) {
     --		fetch_parallel_config = git_config_int(k, v);
     -+		fetch_parallel_config = git_config_int(k, v, ctx->kvi);
     - 		if (fetch_parallel_config < 0)
     +-		fetch_config->parallel = git_config_int(k, v);
     ++		fetch_config->parallel = git_config_int(k, v, ctx->kvi);
     + 		if (fetch_config->parallel < 0)
       			die(_("fetch.parallel cannot be negative"));
     - 		if (!fetch_parallel_config)
     + 		if (!fetch_config->parallel)
      
       ## builtin/fsmonitor--daemon.c ##
      @@ builtin/fsmonitor--daemon.c: static int fsmonitor_config(const char *var, const char *value,
     @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
       				printf("(NULL)\n");
       			else
      
     - ## trace2/tr2_cfg.c ##
     -@@ trace2/tr2_cfg.c: struct tr2_cfg_data {
     -  * See if the given config key matches any of our patterns of interest.
     -  */
     - static int tr2_cfg_cb(const char *key, const char *value,
     --		      const struct config_context *ctx UNUSED, void *d)
     -+		      const struct config_context *ctx, void *d)
     - {
     - 	struct strbuf **s;
     - 	struct tr2_cfg_data *data = (struct tr2_cfg_data *)d;
     -
       ## upload-pack.c ##
      @@ upload-pack.c: static int find_symref(const char *refname,
       }
 10:  8ec24b018e9 ! 10:  807057b6d7f config.c: remove config_reader from configsets
     @@ config.c: static void repo_read_config(struct repository *repo)
      -	data.config_set = repo->config;
      -	data.config_reader = &the_reader;
      -
     --	if (config_with_options(config_set_callback, &data, NULL, &opts) < 0)
     +-	if (config_with_options(config_set_callback, &data, NULL, repo, &opts) < 0)
      +	if (config_with_options(config_set_callback, repo->config, NULL,
     -+				&opts) < 0)
     ++				repo, &opts) < 0)
       		/*
       		 * config_with_options() normally returns only
       		 * zero, as most errors are fatal, and
     @@ config.c: static void read_protected_config(void)
       	git_configset_init(&protected_config);
      -	data.config_set = &protected_config;
      -	data.config_reader = &the_reader;
     --	config_with_options(config_set_callback, &data, NULL, &opts);
     -+	config_with_options(config_set_callback, &protected_config, NULL, &opts);
     +-	config_with_options(config_set_callback, &data, NULL, NULL, &opts);
     ++	config_with_options(config_set_callback, &protected_config, NULL,
     ++			    NULL, &opts);
       }
       
       void git_protected_config(config_fn_t fn, void *data)
 11:  8ae115cff88 ! 11:  3f0f84df972 config: add kvi.path, use it to evaluate includes
     @@ Commit message
      
       ## config.c ##
      @@ config.c: struct config_include_data {
     - 	void *data;
       	const struct config_options *opts;
       	struct git_config_source *config_source;
     + 	struct repository *repo;
      -	struct config_reader *config_reader;
       
       	/*
     @@ config.c: static void kvi_from_source(struct config_source *cs,
       
       static int git_parse_source(struct config_source *cs, config_fn_t fn,
      @@ config.c: int config_with_options(config_fn_t fn, void *data,
     - 		inc.data = data;
       		inc.opts = opts;
     + 		inc.repo = repo;
       		inc.config_source = config_source;
      -		inc.config_reader = &the_reader;
       		fn = git_config_include;
 12:  484d553cc7d ! 12:  fe2f154fe8b config: pass source to config_parser_event_fn_t
     @@ config.c: int git_config_system(void)
      -static int do_git_config_sequence(struct config_reader *reader,
      -				  const struct config_options *opts,
      +static int do_git_config_sequence(const struct config_options *opts,
     + 				  const struct repository *repo,
       				  config_fn_t fn, void *data)
       {
     - 	int ret = 0;
      @@ config.c: int config_with_options(config_fn_t fn, void *data,
       		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
       					       data, config_source->scope);
       	} else {
     --		ret = do_git_config_sequence(&the_reader, opts, fn, data);
     -+		ret = do_git_config_sequence(opts, fn, data);
     +-		ret = do_git_config_sequence(&the_reader, opts, repo, fn, data);
     ++		ret = do_git_config_sequence(opts, repo, fn, data);
       	}
       
       	if (inc.remote_urls) {

-- 
gitgitgadget
