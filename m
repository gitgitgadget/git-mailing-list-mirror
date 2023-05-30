Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A033AC77B73
	for <git@archiver.kernel.org>; Tue, 30 May 2023 18:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjE3Smf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 14:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjE3Sm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 14:42:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBE710E
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30af86a966eso614343f8f.2
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685472139; x=1688064139;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hGdQkWYKwWnOb9Q0riFrIuomD5s/jBuNVRMAKwWrGs=;
        b=HXKhT9xNOjt+4iuVEChy256IVywYXpQKKvGvEAftP1cQr/iLj6OjhIE0ASCOFrR3Y3
         MBQRUmzlAuiZFh9JmPrcUY8OmoIr2XyAkfKgpSOTFi5c0imU0/THBJ9wjRgfy1Miz5UG
         Z/yi0ymC1/0WXwaJUC2aNDjeYu2oMjGnML/syumSbYIjhEMA9O3znEh4Pl5AD4ko4CeB
         YLMYiJ8sGzAQa6v8+zVqhLvSa/XTUz/o+dHSq6lRNJB1MbvPypVzWcTTjkKNLSbXvpff
         7DBkwBMvlB72CmSQHUSmrLDKtswTsIcEzlaSDDmgcU1wM/QhMGxwOb4ey+pkiK5sRwJ2
         YPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472139; x=1688064139;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hGdQkWYKwWnOb9Q0riFrIuomD5s/jBuNVRMAKwWrGs=;
        b=Ych99oGpjt0SICAvgwIa5iUuBdNagosjPyN/E1EeQ1/O1bPXLvrDLCx+uEbIJI/kIv
         18fZvwTuYBKSlxgc0cW/8mhaMDG1lZMKhcDMs0t0RKe/EuxIRhENhXGRn8CkE6y1A6oX
         N01foyu7My4IQnGAxRy+hjAUgpBHWwrBxBExVLd9FoeQxhNsXhSUepPP9kK/ijwcAaae
         nmjUI+ESKbWuYJ7WFK7tqal1Q2rACDF4IuouIaH4b1kl4h3jV+4X1KF61OxXQh7ursyb
         FPJD43fNEOit5aLiJh6oqgsGV/Haa7DBPSdbPUHJaBI2fm5ZdN3fkUp9gFaKPsIbw/wQ
         xwSA==
X-Gm-Message-State: AC+VfDxtlsef+5HY+1XGIIcFpR4Mh4IfkQnXM3ltOeY75m81S/+eisKb
        pNk8cDdGEPJ9yfits2ENfLNP5ZpRwhE=
X-Google-Smtp-Source: ACHHUZ5A4lNWgq8mO7lylOY3t7mIi17QuwQUZyF4RTbjRNSYaGpHBmdXb85TpxJ/yTUvJtcLaKjLuA==
X-Received: by 2002:adf:dec9:0:b0:30a:e378:76e with SMTP id i9-20020adfdec9000000b0030ae378076emr2169492wrn.64.1685472137711;
        Tue, 30 May 2023 11:42:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000180700b003062d815fa6sm4136415wrh.85.2023.05.30.11.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:42:17 -0700 (PDT)
Message-Id: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 May 2023 18:41:58 +0000
Subject: [PATCH v2 00/14] [RFC] config: remove global state from config iteration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review on the previous round!

This v2 is mostly a reorganization of v1, largely based off Jonathan's
feedback in [1]. As such, nearly all of v1's cover letter still applies
(except for the "Patch Overview" section [2]) so this cover letter omits
those bits that have already been covered. The first non-RFC version will
get rerolled with full cover letter.

Since a lot of this series removes the config_reader stuff from
gc/config-parsing-cleanup, it might be useful to diff this with "master"
right before that:

git diff 0a8c337394 HEAD -- config.c

= Changes since v1

 * Reorganize patches in a (hopefully) easier-to-review way.

 * Squash bugs in builtin/config.c that became apparent during the refactor.
   These could have been fixed in v1, but they dropped off my radar.

= Patch overview

 * 1-5/14 add the "kvi" parameter to the config_fn_t signature. These are
   mostly unchanged from v1.

 * 6-11/14 converts the config.c machinery off "config_reader.config_kvi"
   and "config_reader.source" and onto the new "kvi" arg. Most of the
   changes from v1 are here.
   
   In v1, we converted all of the config.c machinery first, making the "kvi"
   arg available everywhere before the refactor. Thus we could convert all
   callers of the current_*() API to the "kvi" arg in a single step. However
   (as Jonathan rightfully pointed out), some of the changes to the
   machinery are non-trivial, and it's quite difficult to spot bugs in the
   intermediate patches.
   
   In v2, we convert the config.c machinery from "config_reader" to "kvi"
   one-by-one: configsets, then files, then CLI. To exercise the "kvi" arg
   as soon as possible, we convert from current_*() to "kvi" as soon as it
   is available. For example, in 6/14 "kvi" is available only in configsets,
   so we convert the current_*() call sites that are only reached via
   configsets and leave the others untouched. This means that we have a mix
   of current_*() and "kvi" in the middle, but auditing the changes is
   relatively easy (compared to v1's machinery changes), since you only need
   to verify that a callback isn't relying on the "kvi" arg before it is
   available, and that current_*() and "kvi" give the same value.
   
   * 8-9/14 squashes some bugs where builtin/config.c was calling the
     current_*() API outside of config callbacks. The "kvi" plumbing doesn't
     just make the bugs apparent, it also provides an obvious way to fix the
     bugs (by injecting "kvi" into the right places in builtin/config.c).
     These would have been nontrivial to fix if we were still using global
     state.

 * 12-14/14 remove config_reader by taking advantage of the "kvi" parameter
   and doing some other light plumbing.

[1]
https://lore.kernel.org/git/20230505210702.3359841-1-jonathantanmy@google.com
[2]
https://lore.kernel.org/pull.1497.git.git.1682104398.gitgitgadget@gmail.com

Glen Choo (14):
  config: inline git_color_default_config
  urlmatch.h: use config_fn_t type
  (RFC-only) config: add kvi arg to config_fn_t
  (RFC-only) config: apply cocci to config_fn_t implementations
  (RFC-only) config: finish config_fn_t refactor
  config.c: pass kvi in configsets
  config: provide kvi with config files
  builtin/config.c: test misuse of format_config()
  config.c: provide kvi with CLI config
  trace2: plumb config kvi
  config: pass kvi to die_bad_number()
  config.c: remove config_reader from configsets
  config: add kvi.path, use it to evaluate includes
  config: pass source to config_parser_event_fn_t

 alias.c                                       |   3 +-
 archive-tar.c                                 |   5 +-
 archive-zip.c                                 |   1 +
 builtin/add.c                                 |   5 +-
 builtin/blame.c                               |   5 +-
 builtin/branch.c                              |   8 +-
 builtin/cat-file.c                            |   5 +-
 builtin/checkout.c                            |   7 +-
 builtin/clean.c                               |   9 +-
 builtin/clone.c                               |  10 +-
 builtin/column.c                              |   3 +-
 builtin/commit-graph.c                        |   3 +-
 builtin/commit.c                              |  20 +-
 builtin/config.c                              |  65 ++-
 builtin/difftool.c                            |   5 +-
 builtin/fetch.c                               |  12 +-
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
 builtin/remote.c                              |  12 +-
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
 config.c                                      | 538 +++++++-----------
 config.h                                      |  54 +-
 connect.c                                     |   4 +-
 .../coccinelle/config_fn_kvi.pending.cocci    | 146 +++++
 contrib/coccinelle/git_config_number.cocci    |  27 +
 convert.c                                     |   4 +-
 credential.c                                  |   1 +
 delta-islands.c                               |   3 +-
 diff.c                                        |  19 +-
 diff.h                                        |   7 +-
 fetch-pack.c                                  |   5 +-
 fmt-merge-msg.c                               |   7 +-
 fmt-merge-msg.h                               |   3 +-
 fsck.c                                        |  11 +-
 fsck.h                                        |   4 +-
 git-compat-util.h                             |   2 +
 gpg-interface.c                               |   6 +-
 grep.c                                        |   7 +-
 grep.h                                        |   4 +-
 help.c                                        |  10 +-
 http.c                                        |  15 +-
 ident.c                                       |   3 +-
 ident.h                                       |   4 +-
 imap-send.c                                   |   7 +-
 ll-merge.c                                    |   1 +
 ls-refs.c                                     |   2 +-
 mailinfo.c                                    |   5 +-
 notes-utils.c                                 |   3 +-
 notes.c                                       |   3 +-
 pager.c                                       |   5 +-
 pretty.c                                      |   1 +
 promisor-remote.c                             |   4 +-
 remote.c                                      |   7 +-
 revision.c                                    |   3 +-
 scalar.c                                      |   3 +-
 sequencer.c                                   |  28 +-
 setup.c                                       |  17 +-
 submodule-config.c                            |  31 +-
 submodule-config.h                            |   3 +-
 t/helper/test-config.c                        |  21 +-
 t/helper/test-userdiff.c                      |   4 +-
 t/t1300-config.sh                             |  27 +
 trace2.c                                      |   4 +-
 trace2.h                                      |   3 +-
 trace2/tr2_cfg.c                              |  12 +-
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
 xdiff-interface.h                             |   5 +-
 103 files changed, 883 insertions(+), 642 deletions(-)
 create mode 100644 contrib/coccinelle/config_fn_kvi.pending.cocci
 create mode 100644 contrib/coccinelle/git_config_number.cocci


base-commit: 9857273be005833c71e2d16ba48e193113e12276
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1497%2Fchooglen%2Fconfig%2Fno-global-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1497/chooglen/config/no-global-v2
Pull-Request: https://github.com/git/git/pull/1497

Range-diff vs v1:

  1:  49bc2f6eedc <  -:  ----------- config.c: introduce kvi_fn(), use it for configsets
  6:  cb021810688 =  1:  d5edf7e3fdd config: inline git_color_default_config
  7:  e0f43eafa07 =  2:  821f0b90580 urlmatch.h: use config_fn_t type
  8:  961d06f89cb !  3:  6834e37066e (RFC-only) config: add kvi arg to config_fn_t
     @@ Commit message
          Signed-off-by: Glen Choo <chooglen@google.com>
      
       ## config.c ##
     -@@ config.c: static int kvi_fn(config_fn_t fn, const char *key, const char *value,
     - {
     - 	int ret;
     - 	config_reader_push_kvi(&the_reader, kvi);
     --	ret = fn(key, value, data);
     -+	ret = fn(key, value, kvi, data);
     - 	config_reader_pop_kvi(&the_reader);
     +@@ config.c: static int git_config_include(const char *var, const char *value, void *data)
     + 	 * Pass along all values, including "include" directives; this makes it
     + 	 * possible to query information on the includes themselves.
     + 	 */
     +-	ret = inc->fn(var, value, inc->data);
     ++	ret = inc->fn(var, value, NULL, inc->data);
     + 	if (ret < 0)
     + 		return ret;
     + 
     +@@ config.c: static int config_parse_pair(const char *key, const char *value,
     + 	if (git_config_parse_key(key, &canonical_name, NULL))
     + 		return -1;
     + 
     +-	ret = (fn(canonical_name, value, data) < 0) ? -1 : 0;
     ++	ret = (fn(canonical_name, value, NULL, data) < 0) ? -1 : 0;
     + 	free(canonical_name);
       	return ret;
       }
     +@@ config.c: static int get_value(struct config_source *cs, config_fn_t fn, void *data,
     + 	 * accurate line number in error messages.
     + 	 */
     + 	cs->linenr--;
     +-	ret = fn(name->buf, value, data);
     ++	ret = fn(name->buf, value, NULL, data);
     + 	if (ret >= 0)
     + 		cs->linenr++;
     + 	return ret;
     +@@ config.c: static void configset_iter(struct config_reader *reader, struct config_set *set,
     + 
     + 		config_reader_set_kvi(reader, values->items[value_index].util);
     + 
     +-		if (fn(entry->key, values->items[value_index].string, data) < 0)
     ++		if (fn(entry->key, values->items[value_index].string, NULL, data) < 0)
     + 			git_die_config_linenr(entry->key,
     + 					      reader->config_kvi->filename,
     + 					      reader->config_kvi->linenr);
      
       ## config.h ##
      @@ config.h: struct config_options {
     @@ config.h: struct config_options {
      +	int linenr;
      +	enum config_origin_type origin_type;
      +	enum config_scope scope;
     -+	const char *path;
     -+	struct key_value_info *prev;
      +};
      +
       /**
     @@ config.h: int git_config_get_expiry(const char *key, const char **output);
      -	int linenr;
      -	enum config_origin_type origin_type;
      -	enum config_scope scope;
     --	const char *path;
     --	struct key_value_info *prev;
      -};
      -
       /**
  9:  5eb3874b494 !  4:  bd52c6232ec (RFC-only) config: apply cocci to config_fn_t implementations
     @@ config.c: static void populate_remote_urls(struct config_include_data *inc)
       			     void *data UNUSED)
       {
       	const char *remote_name;
     -@@ config.c: static int include_condition_is_true(struct key_value_info *kvi,
     +@@ config.c: static int include_condition_is_true(struct config_source *cs,
     + 	return 0;
     + }
       
     - static int kvi_fn(config_fn_t fn, const char *key, const char *value,
     - 		  struct key_value_info *kvi, void *data);
      -static int git_config_include(const char *var, const char *value, void *data)
      +static int git_config_include(const char *var, const char *value,
      +			      struct key_value_info *kvi UNUSED, void *data)
       {
       	struct config_include_data *inc = data;
     - 	struct key_value_info *kvi = inc->config_reader->config_kvi;
     + 	struct config_source *cs = inc->config_reader->source;
      @@ config.c: int git_config_color(char *dest, const char *var, const char *value)
       	return 0;
       }
     @@ config.c: struct configset_add_data {
       {
       	struct configset_add_data *data = cb;
       	configset_add_value(data->config_reader, data->config_set, key, value);
     -@@ config.c: static int store_aux_event(enum config_event_t type, size_t begin, size_t end,
     +@@ config.c: static int store_aux_event(enum config_event_t type,
       	return 0;
       }
       
 10:  1071e70c928 !  5:  f363b160259 (RFC-only) config: finish config_fn_t refactor
     @@ Commit message
              refactoring away, since git_xmerge_config() can call
              git_default_config().
      
     -      - config.c:git_config_include()
     -
     -        Replace the local "kvi" variable with the "kvi" parameter. This
     -        makes config_include_data.config_reader obsolete, so remove it.
     -
          * Hard for cocci to catch
      
            - urlmatch.c
     @@ compat/mingw.h: typedef _sigset_t sigset_t;
       
       /*
      
     - ## config.c ##
     -@@ config.c: struct config_include_data {
     - 	void *data;
     - 	const struct config_options *opts;
     - 	struct git_config_source *config_source;
     --	struct config_reader *config_reader;
     - 
     - 	/*
     - 	 * All remote URLs discovered when reading all config files.
     -@@ config.c: static int include_condition_is_true(struct key_value_info *kvi,
     - static int kvi_fn(config_fn_t fn, const char *key, const char *value,
     - 		  struct key_value_info *kvi, void *data);
     - static int git_config_include(const char *var, const char *value,
     --			      struct key_value_info *kvi UNUSED, void *data)
     -+			      struct key_value_info *kvi, void *data)
     - {
     - 	struct config_include_data *inc = data;
     --	struct key_value_info *kvi = inc->config_reader->config_kvi;
     - 	const char *cond, *key;
     - 	size_t cond_len;
     - 	int ret;
     -@@ config.c: int config_with_options(config_fn_t fn, void *data,
     - 		inc.data = data;
     - 		inc.opts = opts;
     - 		inc.config_source = config_source;
     --		inc.config_reader = &the_reader;
     - 		fn = git_config_include;
     - 		data = &inc;
     - 	}
     -
       ## diff.h ##
      @@ diff.h: void free_diffstat_info(struct diffstat_t *diffstat);
       int parse_long_opt(const char *opt, const char **argv,
 11:  b38653477c7 !  6:  f57c1007cad config: remove current_config_(line|name|origin_type)
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    config: remove current_config_(line|name|origin_type)
     +    config.c: pass kvi in configsets
      
     -    Trivially replace current_config_(line|name|origin_type) by reading the
     -    corresponding values from "struct key_value_info". This includes some
     -    light "kvi" plumbing for builtin/config.c, and for *origin_type,
     -    splitting out a function that turns "enum config_origin_type" into the
     -    human-readable string that callbacks actually want.
     +    Trivially pass "struct key_value_info" to config callbacks in
     +    configset_iter(). Then, in config callbacks that are only used with
     +    configsets, use the "kvi" arg to replace calls to current_config_*(),
     +    and delete current_config_line() because it has no remaining callers.
      
     -    Signed-off-by: Glen Choo <chooglen@google.com>
     +    This leaves builtin/config.c and config.c as the only remaining users of
     +    current_config_*().
      
     - ## builtin/config.c ##
     -@@ builtin/config.c: static void check_argc(int argc, int min, int max)
     - 	usage_builtin_config();
     - }
     - 
     --static void show_config_origin(struct strbuf *buf)
     -+static void show_config_origin(struct key_value_info *kvi, struct strbuf *buf)
     - {
     - 	const char term = end_nul ? '\0' : '\t';
     - 
     --	strbuf_addstr(buf, current_config_origin_type());
     -+	strbuf_addstr(buf, config_origin_type_name(kvi->origin_type));
     - 	strbuf_addch(buf, ':');
     - 	if (end_nul)
     --		strbuf_addstr(buf, current_config_name());
     -+		strbuf_addstr(buf, kvi->filename ? kvi->filename : "");
     - 	else
     --		quote_c_style(current_config_name(), buf, NULL, 0);
     -+		quote_c_style(kvi->filename ? kvi->filename : "", buf, NULL, 0);
     - 	strbuf_addch(buf, term);
     - }
     - 
     -@@ builtin/config.c: static void show_config_scope(struct strbuf *buf)
     - }
     - 
     - static int show_all_config(const char *key_, const char *value_,
     --			   struct key_value_info *kvi UNUSED, void *cb UNUSED)
     -+			   struct key_value_info *kvi, void *cb UNUSED)
     - {
     - 	if (show_origin || show_scope) {
     - 		struct strbuf buf = STRBUF_INIT;
     - 		if (show_scope)
     - 			show_config_scope(&buf);
     - 		if (show_origin)
     --			show_config_origin(&buf);
     -+			show_config_origin(kvi, &buf);
     - 		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
     - 		fwrite(buf.buf, 1, buf.len, stdout);
     - 		strbuf_release(&buf);
     -@@ builtin/config.c: struct strbuf_list {
     - 	int alloc;
     - };
     - 
     --static int format_config(struct strbuf *buf, const char *key_, const char *value_)
     -+static int format_config(struct strbuf *buf, const char *key_, const char *value_,
     -+			 struct key_value_info *kvi)
     - {
     - 	if (show_scope)
     - 		show_config_scope(buf);
     - 	if (show_origin)
     --		show_config_origin(buf);
     -+		show_config_origin(kvi, buf);
     - 	if (show_keys)
     - 		strbuf_addstr(buf, key_);
     - 	if (!omit_values) {
     -@@ builtin/config.c: static int format_config(struct strbuf *buf, const char *key_, const char *value
     - }
     - 
     - static int collect_config(const char *key_, const char *value_,
     --			  struct key_value_info *kvi UNUSED, void *cb)
     -+			  struct key_value_info *kvi, void *cb)
     - {
     - 	struct strbuf_list *values = cb;
     - 
     -@@ builtin/config.c: static int collect_config(const char *key_, const char *value_,
     - 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
     - 	strbuf_init(&values->items[values->nr], 0);
     - 
     --	return format_config(&values->items[values->nr++], key_, value_);
     -+	return format_config(&values->items[values->nr++], key_, value_, kvi);
     - }
     - 
     - static int get_value(const char *key_, const char *regex_, unsigned flags)
     -@@ builtin/config.c: static int get_value(const char *key_, const char *regex_, unsigned flags)
     - 		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
     - 		item = &values.items[values.nr++];
     - 		strbuf_init(item, 0);
     --		if (format_config(item, key_, default_value) < 0)
     -+		if (format_config(item, key_, default_value, NULL) < 0)
     - 			die(_("failed to format default config value: %s"),
     - 				default_value);
     - 	}
     -@@ builtin/config.c: static int get_urlmatch(const char *var, const char *url)
     - 		struct strbuf buf = STRBUF_INIT;
     - 
     - 		format_config(&buf, item->string,
     --			      matched->value_is_null ? NULL : matched->value.buf);
     -+			      matched->value_is_null ? NULL : matched->value.buf, NULL);
     - 		fwrite(buf.buf, 1, buf.len, stdout);
     - 		strbuf_release(&buf);
     - 
     +    Signed-off-by: Glen Choo <chooglen@google.com>
      
       ## builtin/remote.c ##
      @@ builtin/remote.c: struct push_default_info
     @@ builtin/remote.c: struct push_default_info
       {
       	struct push_default_info* info = cb;
       	if (strcmp(key, "remote.pushdefault") ||
     -@@ builtin/remote.c: static int config_read_push_default(const char *key, const char *value,
     + 	    !value || strcmp(value, info->old_name))
     + 		return 0;
       
     - 	info->scope = current_config_scope();
     +-	info->scope = current_config_scope();
     ++	info->scope = kvi->scope;
       	strbuf_reset(&info->origin);
      -	strbuf_addstr(&info->origin, current_config_name());
      -	info->linenr = current_config_line();
     -+	strbuf_addstr(&info->origin, kvi->filename);
     ++	strbuf_addstr(&info->origin, config_origin_type_name(kvi->origin_type));
      +	info->linenr = kvi->linenr;
       
       	return 0;
       }
      
       ## config.c ##
     +@@ config.c: static void configset_iter(struct config_reader *reader, struct config_set *set,
     + 	struct string_list *values;
     + 	struct config_set_element *entry;
     + 	struct configset_list *list = &set->list;
     ++	struct key_value_info *kvi;
     + 
     + 	for (i = 0; i < list->nr; i++) {
     + 		entry = list->items[i].e;
     + 		value_index = list->items[i].value_index;
     + 		values = &entry->value_list;
     ++		kvi = values->items[value_index].util;
     + 
     + 		config_reader_set_kvi(reader, values->items[value_index].util);
     + 
     +-		if (fn(entry->key, values->items[value_index].string, NULL, data) < 0)
     +-			git_die_config_linenr(entry->key,
     +-					      reader->config_kvi->filename,
     +-					      reader->config_kvi->linenr);
     +-
     ++		if (fn(entry->key, values->items[value_index].string, kvi, data) < 0)
     ++			git_die_config_linenr(entry->key, kvi->filename, kvi->linenr);
     + 		config_reader_set_kvi(reader, NULL);
     + 	}
     + }
      @@ config.c: static int reader_origin_type(struct config_reader *reader,
       	return 0;
       }
     @@ config.c: static int reader_origin_type(struct config_reader *reader,
       	switch (type) {
       	case CONFIG_ORIGIN_BLOB:
       		return "blob";
     -@@ config.c: static int reader_config_name(struct config_reader *reader, const char **out)
     - 	return 0;
     +@@ config.c: const char *current_config_origin_type(void)
     + 	}
       }
       
     --const char *current_config_name(void)
     --{
     --	const char *name;
     --	if (reader_config_name(&the_reader, &name))
     --		BUG("current_config_name called outside config callback");
     --	return name ? name : "";
     --}
     --
     - enum config_scope current_config_scope(void)
     ++const char *current_config_origin_type(void)
     ++{
     ++	enum config_origin_type type = CONFIG_ORIGIN_UNKNOWN;
     ++
     ++	if (reader_origin_type(&the_reader, &type))
     ++		BUG("current_config_origin_type called outside config callback");
     ++
     ++	return config_origin_type_name(type);
     ++}
     ++
     + const char *config_scope_name(enum config_scope scope)
       {
     - 	if (the_reader.config_kvi)
     + 	switch (scope) {
      @@ config.c: enum config_scope current_config_scope(void)
     - 		return CONFIG_SCOPE_UNKNOWN;
     + 		return the_reader.parsing_scope;
       }
       
      -int current_config_line(void)
     @@ config.c: enum config_scope current_config_scope(void)
      -	if (the_reader.config_kvi)
      -		return the_reader.config_kvi->linenr;
      -	else
     --		BUG("current_config_line called outside config callback");
     +-		return the_reader.source->linenr;
      -}
      -
       int lookup_config(const char **mapping, int nr_mapping, const char *var)
     @@ config.c: enum config_scope current_config_scope(void)
       	int i;
      
       ## config.h ##
     -@@ config.h: void git_global_config(char **user, char **xdg);
     - int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
     - 
     +@@ config.h: int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
       enum config_scope current_config_scope(void);
     --const char *current_config_origin_type(void);
     --const char *current_config_name(void);
     + const char *current_config_origin_type(void);
     + const char *current_config_name(void);
      -int current_config_line(void);
      +const char *config_origin_type_name(enum config_origin_type type);
       
       /*
        * Match and parse a config key of the form:
      
     + ## remote.c ##
     +@@ remote.c: static void read_branches_file(struct remote_state *remote_state,
     + }
     + 
     + static int handle_config(const char *key, const char *value,
     +-			 struct key_value_info *kvi UNUSED, void *cb)
     ++			 struct key_value_info *kvi, void *cb)
     + {
     + 	const char *name;
     + 	size_t namelen;
     +@@ remote.c: static int handle_config(const char *key, const char *value,
     + 	}
     + 	remote = make_remote(remote_state, name, namelen);
     + 	remote->origin = REMOTE_CONFIG;
     +-	if (current_config_scope() == CONFIG_SCOPE_LOCAL ||
     +-	    current_config_scope() == CONFIG_SCOPE_WORKTREE)
     ++	if (kvi->scope == CONFIG_SCOPE_LOCAL ||
     ++	    kvi->scope == CONFIG_SCOPE_WORKTREE)
     + 		remote->configured_in_repo = 1;
     + 	if (!strcmp(subkey, "mirror"))
     + 		remote->mirror = git_config_bool(key, value);
     +
       ## t/helper/test-config.c ##
      @@
        */
     @@ t/helper/test-config.c: static int iterate_cb(const char *var, const char *value
      -	printf("origin=%s\n", current_config_origin_type());
      -	printf("name=%s\n", current_config_name());
      -	printf("lno=%d\n", current_config_line());
     +-	printf("scope=%s\n", config_scope_name(current_config_scope()));
      +	printf("origin=%s\n", config_origin_type_name(kvi->origin_type));
      +	printf("name=%s\n", kvi->filename ? kvi->filename : "");
      +	printf("lno=%d\n", kvi->linenr);
     - 	printf("scope=%s\n", config_scope_name(current_config_scope()));
     ++	printf("scope=%s\n", config_scope_name(kvi->scope));
       
       	return 0;
     + }
  3:  8c7a84137c8 !  7:  641a56f0b40 config: use kvi for config files
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    config: use kvi for config files
     +    config: provide kvi with config files
      
     -    Plumb "struct key_value_info" and use "kvi_fn()" when parsing config
     -    files. As a result, "config_reader.kvi" is now always set correctly, so
     -    we can remove "config_reader.scope" (but not the ".source" member since
     -    that's still needed by some non-parsing machinery). This requires
     -    plumbing an additional "enum config_scope" arg through
     -    "git_config_from_file_with_options()" and the underlying machinery to
     -    make up for the fact that "struct key_value_info" has a ".scope" member,
     -    but "struct config_source" does not.
     +    Refactor out the configset logic that caches "struct config_source" and
     +    "enum config_scope" as a "struct key_value_info", and use it to pass the
     +    "kvi" arg to config callbacks when parsing config files. Get the "enum
     +    config_scope" value by plumbing an additional arg through
     +    git_config_from_file_with_options() and the underlying machinery.
      
     -    To handle "include" directives correctly, use push/pop semantics for
     -    "config_reader.config_kvi" (instead of "set" semantics) like we do for
     -    "config_reader.source". Otherwise, "config_reader.config_kvi" won't be
     -    set correctly when we finish parsing an included config file and we want
     -    to "pop" it to resume parsing the original file. This distinction only
     -    matters while there is a global "kvi", i.e. it will be obsolete at the
     -    end of the series.
     +    We do not exercise the "kvi" arg yet because the remaining
     +    current_config_*() callers may be used with config_with_options(), which
     +    may read config from parameters, but parameters don't pass "kvi" yet.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     @@ bundle-uri.c: int bundle_uri_parse_config_format(const char *uri,
       	if (!result && list->mode == BUNDLE_MODE_NONE) {
      
       ## config.c ##
     -@@ config.c: struct config_reader {
     - 	 */
     - 	struct config_source *source;
     - 	struct key_value_info *config_kvi;
     --	/*
     --	 * The "scope" of the current config source being parsed (repo, global,
     --	 * etc). Like "source", this is only set when parsing a config source.
     --	 * It's not part of "source" because it transcends a single file (i.e.,
     --	 * a file included from .git/config is still in "repo" scope).
     --	 *
     --	 * When iterating through a configset, the equivalent value is
     --	 * "config_kvi.scope" (see above).
     --	 */
     --	enum config_scope parsing_scope;
     - };
     - /*
     -  * Where possible, prefer to accept "struct config_reader" as an arg than to use
     -@@ config.c: static inline struct config_source *config_reader_pop_source(struct config_reade
     - 	return ret;
     - }
     - 
     --static inline void config_reader_set_kvi(struct config_reader *reader,
     --					 struct key_value_info *kvi)
     -+static inline void config_reader_push_kvi(struct config_reader *reader,
     -+					  struct key_value_info *kvi)
     - {
     -+	kvi->prev = reader->config_kvi;
     - 	reader->config_kvi = kvi;
     - }
     - 
     --static inline void config_reader_set_scope(struct config_reader *reader,
     --					   enum config_scope scope)
     -+static inline struct key_value_info *config_reader_pop_kvi(struct config_reader *reader)
     - {
     --	reader->parsing_scope = scope;
     -+	struct key_value_info *ret;
     -+	if (!reader->config_kvi)
     -+		BUG("tried to pop config_kvi, but we weren't reading config");
     -+	ret = reader->config_kvi;
     -+	reader->config_kvi = reader->config_kvi->prev;
     -+	return ret;
     - }
     - 
     - static int pack_compression_seen;
      @@ config.c: static int handle_path_include(struct config_source *cs, const char *path,
       			    !cs ? "<unknown>" :
       			    cs->name ? cs->name :
     @@ config.c: static int handle_path_include(struct config_source *cs, const char *p
       		inc->depth--;
       	}
       cleanup:
     -@@ config.c: static void populate_remote_urls(struct config_include_data *inc)
     - {
     - 	struct config_options opts;
     - 
     --	enum config_scope store_scope = inc->config_reader->parsing_scope;
     --
     - 	opts = *inc->opts;
     - 	opts.unconditional_remote_url = 1;
     - 
     --	config_reader_set_scope(inc->config_reader, 0);
     --
     - 	inc->remote_urls = xmalloc(sizeof(*inc->remote_urls));
     - 	string_list_init_dup(inc->remote_urls);
     - 	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
     --
     --	config_reader_set_scope(inc->config_reader, store_scope);
     - }
     - 
     - static int forbid_remote_url(const char *var, const char *value UNUSED,
      @@ config.c: static int include_condition_is_true(struct config_source *cs,
     - 	return 0;
       }
       
     -+static int kvi_fn(config_fn_t fn, const char *key, const char *value,
     -+		  struct key_value_info *kvi, void *data);
     - static int git_config_include(const char *var, const char *value, void *data)
     + static int git_config_include(const char *var, const char *value,
     +-			      struct key_value_info *kvi UNUSED, void *data)
     ++			      struct key_value_info *kvi, void *data)
       {
       	struct config_include_data *inc = data;
       	struct config_source *cs = inc->config_reader->source;
     -+	struct key_value_info *kvi = inc->config_reader->config_kvi;
     - 	const char *cond, *key;
     - 	size_t cond_len;
     - 	int ret;
     -@@ config.c: static int git_config_include(const char *var, const char *value, void *data)
     +@@ config.c: static int git_config_include(const char *var, const char *value,
       	 * Pass along all values, including "include" directives; this makes it
       	 * possible to query information on the includes themselves.
       	 */
     --	ret = inc->fn(var, value, inc->data);
     -+	ret = kvi_fn(inc->fn, var, value, kvi, inc->data);
     +-	ret = inc->fn(var, value, NULL, inc->data);
     ++	ret = inc->fn(var, value, kvi, inc->data);
       	if (ret < 0)
       		return ret;
       
     -@@ config.c: out_free_ret_1:
     - }
     - 
     - static int kvi_fn(config_fn_t fn, const char *key, const char *value,
     --		  struct key_value_info *kvi,
     --		  void *data)
     -+		  struct key_value_info *kvi, void *data)
     - {
     - 	int ret;
     --	config_reader_set_kvi(&the_reader, kvi);
     -+	config_reader_push_kvi(&the_reader, kvi);
     - 	ret = fn(key, value, data);
     --	config_reader_set_kvi(&the_reader, NULL);
     -+	config_reader_pop_kvi(&the_reader);
     - 	return ret;
     - }
     - 
      @@ config.c: static char *parse_value(struct config_source *cs)
       	}
       }
     @@ config.c: static int get_value(struct config_source *cs, config_fn_t fn, void *d
       	 * accurate line number in error messages.
       	 */
       	cs->linenr--;
     --	ret = fn(name->buf, value, data);
     +-	ret = fn(name->buf, value, NULL, data);
      +	kvi->linenr = cs->linenr;
     -+	ret = kvi_fn(fn, name->buf, value, kvi, data);
     ++	ret = fn(name->buf, value, kvi, data);
       	if (ret >= 0)
       		cs->linenr++;
       	return ret;
     @@ config.c: static int git_parse_source(struct config_source *cs, config_fn_t fn,
       			break;
       	}
       
     -@@ config.c: int git_default_config(const char *var, const char *value, void *cb)
     +@@ config.c: int git_default_config(const char *var, const char *value,
        * this function.
        */
       static int do_config_from(struct config_reader *reader,
     @@ config.c: static int do_config_from_file(struct config_reader *reader,
      -	ret = do_config_from(reader, &top, fn, data, opts);
      +	ret = do_config_from(reader, &top, fn, data, scope, opts);
       	funlockfile(f);
     -+
       	return ret;
       }
       
     @@ config.c: int git_config_from_blob_oid(config_fn_t fn,
       }
       
       char *git_system_config(void)
     -@@ config.c: int git_config_system(void)
     - 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
     - }
     - 
     --static int do_git_config_sequence(struct config_reader *reader,
     --				  const struct config_options *opts,
     -+static int do_git_config_sequence(const struct config_options *opts,
     - 				  config_fn_t fn, void *data)
     - {
     - 	int ret = 0;
      @@ config.c: static int do_git_config_sequence(struct config_reader *reader,
     - 	char *xdg_config = NULL;
     - 	char *user_config = NULL;
     - 	char *repo_config;
     --	enum config_scope prev_parsing_scope = reader->parsing_scope;
     - 
     - 	if (opts->commondir)
     - 		repo_config = mkpathdup("%s/config", opts->commondir);
     -@@ config.c: static int do_git_config_sequence(struct config_reader *reader,
     - 	else
     - 		repo_config = NULL;
     - 
     --	config_reader_set_scope(reader, CONFIG_SCOPE_SYSTEM);
       	if (git_config_system() && system_config &&
       	    !access_or_die(system_config, R_OK,
       			   opts->system_gently ? ACCESS_EACCES_OK : 0))
     @@ config.c: static int do_git_config_sequence(struct config_reader *reader,
      +							 data, CONFIG_SCOPE_SYSTEM,
      +							 NULL);
       
     --	config_reader_set_scope(reader, CONFIG_SCOPE_GLOBAL);
     + 	config_reader_set_scope(reader, CONFIG_SCOPE_GLOBAL);
       	git_global_config(&user_config, &xdg_config);
       
       	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
     @@ config.c: static int do_git_config_sequence(struct config_reader *reader,
      +		ret += git_config_from_file_with_options(fn, user_config, data,
      +							 CONFIG_SCOPE_GLOBAL, NULL);
       
     --	config_reader_set_scope(reader, CONFIG_SCOPE_LOCAL);
     + 	config_reader_set_scope(reader, CONFIG_SCOPE_LOCAL);
       	if (!opts->ignore_repo && repo_config &&
       	    !access_or_die(repo_config, R_OK, 0))
      -		ret += git_config_from_file(fn, repo_config, data);
      +		ret += git_config_from_file_with_options(fn, repo_config, data,
      +							 CONFIG_SCOPE_LOCAL, NULL);
       
     --	config_reader_set_scope(reader, CONFIG_SCOPE_WORKTREE);
     + 	config_reader_set_scope(reader, CONFIG_SCOPE_WORKTREE);
       	if (!opts->ignore_worktree && repository_format_worktree_config) {
       		char *path = git_pathdup("config.worktree");
       		if (!access_or_die(path, R_OK, 0))
     @@ config.c: static int do_git_config_sequence(struct config_reader *reader,
       		free(path);
       	}
       
     --	config_reader_set_scope(reader, 0);
     - 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
     - 		die(_("unable to parse command-line config"));
     - 
     --	config_reader_set_scope(reader, prev_parsing_scope);
     - 	free(system_config);
     - 	free(xdg_config);
     - 	free(user_config);
     -@@ config.c: int config_with_options(config_fn_t fn, void *data,
     - 			const struct config_options *opts)
     - {
     - 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
     --	enum config_scope prev_scope = the_reader.parsing_scope;
     - 	int ret;
     - 
     - 	if (opts->respect_includes) {
      @@ config.c: int config_with_options(config_fn_t fn, void *data,
     - 		data = &inc;
     - 	}
     - 
     --	if (config_source)
     --		config_reader_set_scope(&the_reader, config_source->scope);
     --
     - 	/*
     - 	 * If we have a specific filename, use it. Otherwise, follow the
       	 * regular lookup sequence.
       	 */
       	if (config_source && config_source->use_stdin) {
     @@ config.c: int config_with_options(config_fn_t fn, void *data,
      -						data);
      +					       data, config_source->scope);
       	} else {
     --		ret = do_git_config_sequence(&the_reader, opts, fn, data);
     -+		ret = do_git_config_sequence(opts, fn, data);
     - 	}
     - 
     - 	if (inc.remote_urls) {
     - 		string_list_clear(inc.remote_urls, 0);
     - 		FREE_AND_NULL(inc.remote_urls);
     + 		ret = do_git_config_sequence(&the_reader, opts, fn, data);
       	}
     --	config_reader_set_scope(&the_reader, prev_scope);
     - 	return ret;
     - }
     - 
      @@ config.c: static int configset_add_value(struct config_reader *reader,
     - 	l_item->e = e;
     - 	l_item->value_index = e->value_list.nr - 1;
     - 
     --	if (reader->source && reader->source->name) {
     + 	if (!reader->source)
     + 		BUG("configset_add_value has no source");
     + 	if (reader->source->name) {
      -		kv_info->filename = strintern(reader->source->name);
      -		kv_info->linenr = reader->source->linenr;
      -		kv_info->origin_type = reader->source->origin_type;
     --		kv_info->scope = reader->parsing_scope;
     --	} else
     --		kvi_from_param(kv_info);
     -+	memcpy(kv_info, reader->config_kvi, sizeof(struct key_value_info));
     ++		kvi_from_source(reader->source, current_config_scope(), kv_info);
     + 	} else {
     + 		/* for values read from `git_config_from_parameters()` */
     + 		kv_info->filename = NULL;
     + 		kv_info->linenr = -1;
     + 		kv_info->origin_type = CONFIG_ORIGIN_CMDLINE;
     ++		kv_info->scope = reader->parsing_scope;
     + 	}
     +-	kv_info->scope = reader->parsing_scope;
       	si->util = kv_info;
       
       	return 0;
     @@ config.c: int git_config_set_multivar_in_file_gently(const char *config_filename
       			error(_("invalid config file %s"), config_filename);
       			ret = CONFIG_INVALID_FILE;
       			goto out_free;
     -@@ config.c: enum config_scope current_config_scope(void)
     - 	if (the_reader.config_kvi)
     - 		return the_reader.config_kvi->scope;
     - 	else
     --		return the_reader.parsing_scope;
     -+		/*
     -+		 * FIXME This should be a BUG, but tr2_list_env_vars_fl is
     -+		 * calling this outside of a config callback. This will be
     -+		 * easier to fix when we plumb kvi through the config callbacks,
     -+		 * so leave this untouched for now.
     -+		 */
     -+		return CONFIG_SCOPE_UNKNOWN;
     - }
     - 
     - int current_config_line(void)
      
       ## config.h ##
     -@@ config.h: int git_default_config(const char *, const char *, void *);
     +@@ config.h: int git_default_config(const char *, const char *, struct key_value_info *,
       int git_config_from_file(config_fn_t fn, const char *, void *);
       
       int git_config_from_file_with_options(config_fn_t fn, const char *,
     @@ config.h: int git_default_config(const char *, const char *, void *);
       void git_config_push_parameter(const char *text);
       void git_config_push_env(const char *spec);
       int git_config_from_parameters(config_fn_t fn, void *data);
     -@@ config.h: struct key_value_info {
     - 	int linenr;
     - 	enum config_origin_type origin_type;
     - 	enum config_scope scope;
     -+	struct key_value_info *prev;
     - };
     - 
     - /**
      
       ## fsck.c ##
      @@ fsck.c: static int fsck_blob(const struct object_id *oid, const char *buf,
  -:  ----------- >  8:  74f43fc727e builtin/config.c: test misuse of format_config()
  2:  a682612cff2 !  9:  3760015d2c0 config.c: use kvi for CLI config
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    config.c: use kvi for CLI config
     +    config.c: provide kvi with CLI config
      
     -    Plumb "struct key_value_info" and use "kvi_fn()" when parsing CLI
     -    config. Do this by refactoring out and reusing the logic that sets the
     -    "struct key_value_info" members when caching CLI config in a configset.
     +    Refactor out kvi_from_param() from the logic that caches CLI config in
     +    configsets, and use it to pass the "kvi" arg to config callbacks when
     +    parsing CLI config. Now that "kvi" is always present when config
     +    machinery calls config callbacks, plumb "kvi" so that we can replace
     +    nearly all calls to current_config_*(). (The exception is an edge case
     +    where trace2/*.c calls current_config_scope(). That will be handled in a
     +    later commit.) Note that this results in "kvi" containing a different,
     +    more complete set of information than the mocked up "struct
     +    config_source" in git_config_from_parameters().
      
     -    This lets us get rid of the fake "struct config_source" in
     -    "git_config_from_parameters()", so we now only have to maintain one
     -    implementation. Additionally, this plumbing also reveals that
     -    "git_config_parse_parameter()" hasn't been setting either
     -    "the_reader.source" or "the_reader.config_kvi", so any calls to
     -    "current_*" would either BUG() or return *_UNKNOWN values.
     +    Plumbing "kvi" reveals a few places where we've been doing the wrong
     +    thing:
      
     -    Also, get rid of the BUG() checks that forbid setting ".config_kvi" and
     -    ".source" at the same time, since we will run afoul of that check. They
     -    will soon be unnecessary when we remove ".source".
     +    * git_config_parse_parameter() hasn't been setting config source
     +      information, so plumb "kvi" there too.
     +
     +    * "git config --get-urlmatch --show-scope" iterates config to collect
     +      values, but then attempts to display the scope after config iteration.
     +      Fix this by copying the "kvi" arg in the collection phase so that it
     +      can be read back later. This means that we can now support "git config
     +      --get-urlmatch --show-origin" (we don't allow this combination of args
     +      because of this bug), but that is left unchanged for now.
     +
     +    * "git config --default" doesn't have config source metadata when
     +      displaying the default value. Fix this by treating the default value
     +      as if it came from the command line (e.g. like we do with "git -c" or
     +      "git config --file"), using kvi_from_param().
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     - ## config.c ##
     -@@ config.c: static struct config_reader the_reader;
     - static inline void config_reader_push_source(struct config_reader *reader,
     - 					     struct config_source *top)
     + ## builtin/config.c ##
     +@@ builtin/config.c: static void check_argc(int argc, int min, int max)
     + 	usage_builtin_config();
     + }
     + 
     +-static void show_config_origin(struct strbuf *buf)
     ++static void show_config_origin(struct key_value_info *kvi, struct strbuf *buf)
       {
     --	if (reader->config_kvi)
     --		BUG("source should not be set while iterating a config set");
     - 	top->prev = reader->source;
     - 	reader->source = top;
     + 	const char term = end_nul ? '\0' : '\t';
     + 
     +-	strbuf_addstr(buf, current_config_origin_type());
     ++	strbuf_addstr(buf, config_origin_type_name(kvi->origin_type));
     + 	strbuf_addch(buf, ':');
     + 	if (end_nul)
     +-		strbuf_addstr(buf, current_config_name());
     ++		strbuf_addstr(buf, kvi->filename ? kvi->filename : "");
     + 	else
     +-		quote_c_style(current_config_name(), buf, NULL, 0);
     ++		quote_c_style(kvi->filename ? kvi->filename : "", buf, NULL, 0);
     + 	strbuf_addch(buf, term);
       }
     -@@ config.c: static inline struct config_source *config_reader_pop_source(struct config_reade
     - static inline void config_reader_set_kvi(struct config_reader *reader,
     - 					 struct key_value_info *kvi)
     + 
     +-static void show_config_scope(struct strbuf *buf)
     ++static void show_config_scope(struct key_value_info *kvi, struct strbuf *buf)
       {
     --	if (kvi && (reader->source || reader->parsing_scope))
     --		BUG("kvi should not be set while parsing a config source");
     - 	reader->config_kvi = kvi;
     + 	const char term = end_nul ? '\0' : '\t';
     +-	const char *scope = config_scope_name(current_config_scope());
     ++	const char *scope = config_scope_name(kvi->scope);
     + 
     + 	strbuf_addstr(buf, N_(scope));
     + 	strbuf_addch(buf, term);
       }
       
     - static inline void config_reader_set_scope(struct config_reader *reader,
     - 					   enum config_scope scope)
     + static int show_all_config(const char *key_, const char *value_,
     +-			   struct key_value_info *kvi UNUSED, void *cb UNUSED)
     ++			   struct key_value_info *kvi, void *cb UNUSED)
     + {
     + 	if (show_origin || show_scope) {
     + 		struct strbuf buf = STRBUF_INIT;
     + 		if (show_scope)
     +-			show_config_scope(&buf);
     ++			show_config_scope(kvi, &buf);
     + 		if (show_origin)
     +-			show_config_origin(&buf);
     ++			show_config_origin(kvi, &buf);
     + 		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
     + 		fwrite(buf.buf, 1, buf.len, stdout);
     + 		strbuf_release(&buf);
     +@@ builtin/config.c: struct strbuf_list {
     + 	int alloc;
     + };
     + 
     +-static int format_config(struct strbuf *buf, const char *key_, const char *value_)
     ++static int format_config(struct strbuf *buf, const char *key_,
     ++			 const char *value_, struct key_value_info *kvi)
       {
     --	if (scope && reader->config_kvi)
     --		BUG("scope should only be set when iterating through a config source");
     - 	reader->parsing_scope = scope;
     + 	if (show_scope)
     +-		show_config_scope(buf);
     ++		show_config_scope(kvi, buf);
     + 	if (show_origin)
     +-		show_config_origin(buf);
     ++		show_config_origin(kvi, buf);
     + 	if (show_keys)
     + 		strbuf_addstr(buf, key_);
     + 	if (!omit_values) {
     +@@ builtin/config.c: static int format_config(struct strbuf *buf, const char *key_, const char *value
       }
       
     -@@ config.c: static int kvi_fn(config_fn_t fn, const char *key, const char *value,
     + static int collect_config(const char *key_, const char *value_,
     +-			  struct key_value_info *kvi UNUSED, void *cb)
     ++			  struct key_value_info *kvi, void *cb)
     + {
     + 	struct strbuf_list *values = cb;
     + 
     +@@ builtin/config.c: static int collect_config(const char *key_, const char *value_,
     + 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
     + 	strbuf_init(&values->items[values->nr], 0);
     + 
     +-	return format_config(&values->items[values->nr++], key_, value_);
     ++	return format_config(&values->items[values->nr++], key_, value_, kvi);
     + }
     + 
     + static int get_value(const char *key_, const char *regex_, unsigned flags)
     +@@ builtin/config.c: static int get_value(const char *key_, const char *regex_, unsigned flags)
     + 			    &given_config_source, &config_options);
     + 
     + 	if (!values.nr && default_value) {
     ++		struct key_value_info kvi = { 0 };
     + 		struct strbuf *item;
     ++
     ++		kvi_from_param(&kvi);
     + 		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
     + 		item = &values.items[values.nr++];
     + 		strbuf_init(item, 0);
     +-		if (format_config(item, key_, default_value) < 0)
     ++		if (format_config(item, key_, default_value, &kvi) < 0)
     + 			die(_("failed to format default config value: %s"),
     + 				default_value);
     + 	}
     +@@ builtin/config.c: static void check_write(void)
     + struct urlmatch_current_candidate_value {
     + 	char value_is_null;
     + 	struct strbuf value;
     ++	struct key_value_info kvi;
     + };
     + 
     + static int urlmatch_collect_fn(const char *var, const char *value,
     +-			       struct key_value_info *kvi UNUSED, void *cb)
     ++			       struct key_value_info *kvi, void *cb)
     + {
     + 	struct string_list *values = cb;
     + 	struct string_list_item *item = string_list_insert(values, var);
     +@@ builtin/config.c: static int urlmatch_collect_fn(const char *var, const char *value,
     + 	} else {
     + 		strbuf_reset(&matched->value);
     + 	}
     ++	memcpy(&matched->kvi, kvi, sizeof(struct key_value_info));
     + 
     + 	if (value) {
     + 		strbuf_addstr(&matched->value, value);
     +@@ builtin/config.c: static int get_urlmatch(const char *var, const char *url)
     + 		struct strbuf buf = STRBUF_INIT;
     + 
     + 		format_config(&buf, item->string,
     +-			      matched->value_is_null ? NULL : matched->value.buf);
     ++			      matched->value_is_null ? NULL : matched->value.buf,
     ++			      &matched->kvi);
     + 		fwrite(buf.buf, 1, buf.len, stdout);
     + 		strbuf_release(&buf);
     + 
     +
     + ## config.c ##
     +@@ config.c: static const char include_depth_advice[] = N_(
     + "from\n"
     + "	%s\n"
     + "This might be due to circular includes.");
     +-static int handle_path_include(struct config_source *cs, const char *path,
     ++static int handle_path_include(struct config_source *cs,
     ++			       struct key_value_info *kvi,
     ++			       const char *path,
     + 			       struct config_include_data *inc)
     + {
     + 	int ret = 0;
     +@@ config.c: static int handle_path_include(struct config_source *cs, const char *path,
     + 			    cs->name ? cs->name :
     + 			    "the command line");
     + 		ret = git_config_from_file_with_options(git_config_include, path, inc,
     +-							current_config_scope(),
     +-							NULL);
     ++							kvi->scope, NULL);
     + 		inc->depth--;
     + 	}
     + cleanup:
     +@@ config.c: static int git_config_include(const char *var, const char *value,
     + 		return ret;
     + 
     + 	if (!strcmp(var, "include.path"))
     +-		ret = handle_path_include(cs, value, inc);
     ++		ret = handle_path_include(cs, kvi, value, inc);
     + 
     + 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
     + 	    cond && include_condition_is_true(cs, inc, cond, cond_len) &&
     +@@ config.c: static int git_config_include(const char *var, const char *value,
     + 
     + 		if (inc->opts->unconditional_remote_url)
     + 			inc->fn = forbid_remote_url;
     +-		ret = handle_path_include(cs, value, inc);
     ++		ret = handle_path_include(cs, kvi, value, inc);
     + 		inc->fn = old_fn;
     + 	}
     + 
     +@@ config.c: out_free_ret_1:
       }
       
       static int config_parse_pair(const char *key, const char *value,
     @@ config.c: static int config_parse_pair(const char *key, const char *value,
       	if (git_config_parse_key(key, &canonical_name, NULL))
       		return -1;
       
     --	ret = (fn(canonical_name, value, data) < 0) ? -1 : 0;
     -+	ret = (kvi_fn(fn, canonical_name, value, kvi, data) < 0) ? -1 : 0;
     +-	ret = (fn(canonical_name, value, NULL, data) < 0) ? -1 : 0;
     ++	ret = (fn(canonical_name, value, kvi, data) < 0) ? -1 : 0;
       	free(canonical_name);
       	return ret;
       }
       
      +
      +/* for values read from `git_config_from_parameters()` */
     -+static void kvi_from_param(struct key_value_info *out)
     ++void kvi_from_param(struct key_value_info *out)
      +{
      +	out->filename = NULL;
      +	out->linenr = -1;
     @@ config.c: static int parse_config_env_list(char *env, config_fn_t fn, void *data
       		}
       		else {
      @@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
     - 	struct strvec to_free = STRVEC_INIT;
       	int ret = 0;
       	char *envw = NULL;
     --	struct config_source source = CONFIG_SOURCE_INIT;
     --
     --	source.origin_type = CONFIG_ORIGIN_CMDLINE;
     --	config_reader_push_source(&the_reader, &source);
     + 	struct config_source source = CONFIG_SOURCE_INIT;
      +	struct key_value_info kvi = { 0 };
       
     + 	source.origin_type = CONFIG_ORIGIN_CMDLINE;
     + 	config_reader_push_source(&the_reader, &source);
     + 
      +	kvi_from_param(&kvi);
     ++
       	env = getenv(CONFIG_COUNT_ENVIRONMENT);
       	if (env) {
       		unsigned long count;
     @@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
       			ret = -1;
       			goto out;
       		}
     -@@ config.c: out:
     - 	strbuf_release(&envvar);
     - 	strvec_clear(&to_free);
     - 	free(envw);
     --	config_reader_pop_source(&the_reader);
     - 	return ret;
     +@@ config.c: static int configset_find_element(struct config_set *set, const char *key,
     + 	return 0;
       }
       
     -@@ config.c: static int do_git_config_sequence(struct config_reader *reader,
     - 		free(path);
     - 	}
     - 
     --	config_reader_set_scope(reader, CONFIG_SCOPE_COMMAND);
     -+	config_reader_set_scope(reader, 0);
     - 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
     - 		die(_("unable to parse command-line config"));
     - 
     +-static int configset_add_value(struct config_reader *reader,
     ++static int configset_add_value(struct key_value_info *kvi_p,
     ++			       struct config_reader *reader,
     + 			       struct config_set *set, const char *key,
     + 			       const char *value)
     + {
      @@ config.c: static int configset_add_value(struct config_reader *reader,
       	l_item->e = e;
       	l_item->value_index = e->value_list.nr - 1;
       
      -	if (!reader->source)
      -		BUG("configset_add_value has no source");
     --	if (reader->source->name) {
     -+	if (reader->source && reader->source->name) {
     - 		kv_info->filename = strintern(reader->source->name);
     - 		kv_info->linenr = reader->source->linenr;
     - 		kv_info->origin_type = reader->source->origin_type;
     --	} else {
     + 	if (reader->source->name) {
     +-		kvi_from_source(reader->source, current_config_scope(), kv_info);
     ++		kvi_from_source(reader->source, kvi_p->scope, kv_info);
     + 	} else {
      -		/* for values read from `git_config_from_parameters()` */
      -		kv_info->filename = NULL;
      -		kv_info->linenr = -1;
      -		kv_info->origin_type = CONFIG_ORIGIN_CMDLINE;
     --	}
     --	kv_info->scope = reader->parsing_scope;
     -+		kv_info->scope = reader->parsing_scope;
     -+	} else
     +-		kv_info->scope = reader->parsing_scope;
      +		kvi_from_param(kv_info);
     + 	}
       	si->util = kv_info;
       
     +@@ config.c: struct configset_add_data {
     + #define CONFIGSET_ADD_INIT { 0 }
     + 
     + static int config_set_callback(const char *key, const char *value,
     +-			       struct key_value_info *kvi UNUSED, void *cb)
     ++			       struct key_value_info *kvi, void *cb)
     + {
     + 	struct configset_add_data *data = cb;
     +-	configset_add_value(data->config_reader, data->config_set, key, value);
     ++	configset_add_value(kvi, data->config_reader, data->config_set, key, value);
     + 	return 0;
     + }
     + 
     +@@ config.c: const char *config_origin_type_name(enum config_origin_type type)
     + 	}
     + }
     + 
     +-const char *current_config_origin_type(void)
     +-{
     +-	enum config_origin_type type = CONFIG_ORIGIN_UNKNOWN;
     +-
     +-	if (reader_origin_type(&the_reader, &type))
     +-		BUG("current_config_origin_type called outside config callback");
     +-
     +-	return config_origin_type_name(type);
     +-}
     +-
     + const char *config_scope_name(enum config_scope scope)
     + {
     + 	switch (scope) {
     +@@ config.c: static int reader_config_name(struct config_reader *reader, const char **out)
       	return 0;
     + }
     + 
     +-const char *current_config_name(void)
     +-{
     +-	const char *name;
     +-	if (reader_config_name(&the_reader, &name))
     +-		BUG("current_config_name called outside config callback");
     +-	return name ? name : "";
     +-}
     +-
     + enum config_scope current_config_scope(void)
     + {
     + 	if (the_reader.config_kvi)
     +
     + ## config.h ##
     +@@ config.h: void git_global_config(char **user, char **xdg);
     + int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
     + 
     + enum config_scope current_config_scope(void);
     +-const char *current_config_origin_type(void);
     +-const char *current_config_name(void);
     + const char *config_origin_type_name(enum config_origin_type type);
     ++void kvi_from_param(struct key_value_info *out);
     + 
     + /*
     +  * Match and parse a config key of the form:
     +
     + ## t/t1300-config.sh ##
     +@@ t/t1300-config.sh: test_expect_success 'urlmatch with --show-scope' '
     + 	EOF
     + 
     + 	cat >expect <<-EOF &&
     +-	unknown	http.cookiefile /tmp/cookie.txt
     +-	unknown	http.sslverify false
     ++	local	http.cookiefile /tmp/cookie.txt
     ++	local	http.sslverify false
     + 	EOF
     + 	git config --get-urlmatch --show-scope HTTP https://weak.example.com >actual &&
     + 	test_cmp expect actual
     +@@ t/t1300-config.sh: test_expect_success '--show-origin blob ref' '
     + '
     + 
     + test_expect_success '--show-origin with --default' '
     +-	test_must_fail git config --show-origin --default foo some.key
     ++	git config --show-origin --default foo some.key >actual &&
     ++	echo "command line:	foo" >expect &&
     ++	test_cmp expect actual
     + '
     + 
     + test_expect_success '--show-scope with --list' '
     +@@ t/t1300-config.sh: test_expect_success '--show-scope with --show-origin' '
     + 
     + test_expect_success '--show-scope with --default' '
     + 	git config --show-scope --default foo some.key >actual &&
     +-	echo "unknown	foo" >expect &&
     ++	echo "command	foo" >expect &&
     + 	test_cmp expect actual
     + '
     + 
 12:  4723ae3bde6 ! 10:  7dc0c46b864 config: remove current_config_scope()
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    config: remove current_config_scope()
     +    trace2: plumb config kvi
      
     -    Replace current_config_scope() by reading the corresponding value off
     -    "struct key_value_info".
     -
     -    Most instances of this are trivial, except for the trace2/* files. There
     -    is a code path starting from trace2_def_param_fl() that eventually calls
     -    current_config_scope(), and thus it needs to have "kvi" plumbed through
     -    it. Additional plumbing is also needed to get "kvi" to
     +    There is a code path starting from trace2_def_param_fl() that eventually
     +    calls current_config_scope(), and thus it needs to have "kvi" plumbed
     +    through it. Additional plumbing is also needed to get "kvi" to
          trace2_def_param_fl(), which gets called by two code paths:
      
          - Through tr2_cfg_cb(), which is a config callback, so it trivially
     @@ Commit message
            information.
      
            Teach tr2_list_env_vars_fl() to be well-behaved by using
     -      kvi_from_param(), which is already used internally by config.c for
     -      CLI/environment variable-based config.
     +      kvi_from_param(), which is used elsewhere for CLI/environment
     +      variable-based config.
     +
     +    As a result, current_config_scope() has no more callers, so remove it.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     - ## builtin/config.c ##
     -@@ builtin/config.c: static void show_config_origin(struct key_value_info *kvi, struct strbuf *buf)
     - 	strbuf_addch(buf, term);
     + ## config.c ##
     +@@ config.c: struct config_reader {
     + 	 */
     + 	struct config_source *source;
     + 	struct key_value_info *config_kvi;
     +-	/*
     +-	 * The "scope" of the current config source being parsed (repo, global,
     +-	 * etc). Like "source", this is only set when parsing a config source.
     +-	 * It's not part of "source" because it transcends a single file (i.e.,
     +-	 * a file included from .git/config is still in "repo" scope).
     +-	 *
     +-	 * When iterating through a configset, the equivalent value is
     +-	 * "config_kvi.scope" (see above).
     +-	 */
     +-	enum config_scope parsing_scope;
     + };
     + /*
     +  * Where possible, prefer to accept "struct config_reader" as an arg than to use
     +@@ config.c: static inline struct config_source *config_reader_pop_source(struct config_reade
     + static inline void config_reader_set_kvi(struct config_reader *reader,
     + 					 struct key_value_info *kvi)
     + {
     +-	if (kvi && (reader->source || reader->parsing_scope))
     +-		BUG("kvi should not be set while parsing a config source");
     + 	reader->config_kvi = kvi;
       }
       
     --static void show_config_scope(struct strbuf *buf)
     -+static void show_config_scope(struct key_value_info *kvi, struct strbuf *buf)
     - {
     - 	const char term = end_nul ? '\0' : '\t';
     --	const char *scope = config_scope_name(current_config_scope());
     -+	const char *scope = config_scope_name(kvi->scope);
     - 
     - 	strbuf_addstr(buf, N_(scope));
     - 	strbuf_addch(buf, term);
     -@@ builtin/config.c: static int show_all_config(const char *key_, const char *value_,
     - 	if (show_origin || show_scope) {
     - 		struct strbuf buf = STRBUF_INIT;
     - 		if (show_scope)
     --			show_config_scope(&buf);
     -+			show_config_scope(kvi, &buf);
     - 		if (show_origin)
     - 			show_config_origin(kvi, &buf);
     - 		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
     -@@ builtin/config.c: static int format_config(struct strbuf *buf, const char *key_, const char *value
     - 			 struct key_value_info *kvi)
     +-static inline void config_reader_set_scope(struct config_reader *reader,
     +-					   enum config_scope scope)
     +-{
     +-	if (scope && reader->config_kvi)
     +-		BUG("scope should only be set when iterating through a config source");
     +-	reader->parsing_scope = scope;
     +-}
     +-
     + static int pack_compression_seen;
     + static int zlib_compression_seen;
     + 
     +@@ config.c: static void populate_remote_urls(struct config_include_data *inc)
       {
     - 	if (show_scope)
     --		show_config_scope(buf);
     -+		show_config_scope(kvi, buf);
     - 	if (show_origin)
     - 		show_config_origin(kvi, buf);
     - 	if (show_keys)
     -
     - ## builtin/remote.c ##
     -@@ builtin/remote.c: static int config_read_push_default(const char *key, const char *value,
     - 	    !value || strcmp(value, info->old_name))
     - 		return 0;
     - 
     --	info->scope = current_config_scope();
     -+	info->scope = kvi->scope;
     - 	strbuf_reset(&info->origin);
     - 	strbuf_addstr(&info->origin, kvi->filename);
     - 	info->linenr = kvi->linenr;
     -
     - ## config.c ##
     -@@ config.c: static int config_parse_pair(const char *key, const char *value,
     + 	struct config_options opts;
     + 
     +-	enum config_scope store_scope = inc->config_reader->parsing_scope;
     +-
     + 	opts = *inc->opts;
     + 	opts.unconditional_remote_url = 1;
     + 
     +-	config_reader_set_scope(inc->config_reader, 0);
     +-
     + 	inc->remote_urls = xmalloc(sizeof(*inc->remote_urls));
     + 	string_list_init_dup(inc->remote_urls);
     + 	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
     +-
     +-	config_reader_set_scope(inc->config_reader, store_scope);
     + }
     + 
     + static int forbid_remote_url(const char *var, const char *value UNUSED,
     +@@ config.c: static int do_git_config_sequence(struct config_reader *reader,
     + 	char *xdg_config = NULL;
     + 	char *user_config = NULL;
     + 	char *repo_config;
     +-	enum config_scope prev_parsing_scope = reader->parsing_scope;
     + 
     + 	if (opts->commondir)
     + 		repo_config = mkpathdup("%s/config", opts->commondir);
     +@@ config.c: static int do_git_config_sequence(struct config_reader *reader,
     + 	else
     + 		repo_config = NULL;
     + 
     +-	config_reader_set_scope(reader, CONFIG_SCOPE_SYSTEM);
     + 	if (git_config_system() && system_config &&
     + 	    !access_or_die(system_config, R_OK,
     + 			   opts->system_gently ? ACCESS_EACCES_OK : 0))
     +@@ config.c: static int do_git_config_sequence(struct config_reader *reader,
     + 							 data, CONFIG_SCOPE_SYSTEM,
     + 							 NULL);
     + 
     +-	config_reader_set_scope(reader, CONFIG_SCOPE_GLOBAL);
     + 	git_global_config(&user_config, &xdg_config);
       
     + 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
     +@@ config.c: static int do_git_config_sequence(struct config_reader *reader,
     + 		ret += git_config_from_file_with_options(fn, user_config, data,
     + 							 CONFIG_SCOPE_GLOBAL, NULL);
       
     - /* for values read from `git_config_from_parameters()` */
     --static void kvi_from_param(struct key_value_info *out)
     -+void kvi_from_param(struct key_value_info *out)
     +-	config_reader_set_scope(reader, CONFIG_SCOPE_LOCAL);
     + 	if (!opts->ignore_repo && repo_config &&
     + 	    !access_or_die(repo_config, R_OK, 0))
     + 		ret += git_config_from_file_with_options(fn, repo_config, data,
     + 							 CONFIG_SCOPE_LOCAL, NULL);
     + 
     +-	config_reader_set_scope(reader, CONFIG_SCOPE_WORKTREE);
     + 	if (!opts->ignore_worktree && repository_format_worktree_config) {
     + 		char *path = git_pathdup("config.worktree");
     + 		if (!access_or_die(path, R_OK, 0))
     +@@ config.c: static int do_git_config_sequence(struct config_reader *reader,
     + 		free(path);
     + 	}
     + 
     +-	config_reader_set_scope(reader, CONFIG_SCOPE_COMMAND);
     + 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
     + 		die(_("unable to parse command-line config"));
     + 
     +-	config_reader_set_scope(reader, prev_parsing_scope);
     + 	free(system_config);
     + 	free(xdg_config);
     + 	free(user_config);
     +@@ config.c: int config_with_options(config_fn_t fn, void *data,
     + 			const struct config_options *opts)
       {
     - 	out->filename = NULL;
     - 	out->linenr = -1;
     + 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
     +-	enum config_scope prev_scope = the_reader.parsing_scope;
     + 	int ret;
     + 
     + 	if (opts->respect_includes) {
     +@@ config.c: int config_with_options(config_fn_t fn, void *data,
     + 		data = &inc;
     + 	}
     + 
     +-	if (config_source)
     +-		config_reader_set_scope(&the_reader, config_source->scope);
     +-
     + 	/*
     + 	 * If we have a specific filename, use it. Otherwise, follow the
     + 	 * regular lookup sequence.
     +@@ config.c: int config_with_options(config_fn_t fn, void *data,
     + 		string_list_clear(inc.remote_urls, 0);
     + 		FREE_AND_NULL(inc.remote_urls);
     + 	}
     +-	config_reader_set_scope(&the_reader, prev_scope);
     + 	return ret;
     + }
     + 
      @@ config.c: static int reader_config_name(struct config_reader *reader, const char **out)
       	return 0;
       }
     @@ config.c: static int reader_config_name(struct config_reader *reader, const char
      -	if (the_reader.config_kvi)
      -		return the_reader.config_kvi->scope;
      -	else
     --		/*
     --		 * FIXME This should be a BUG, but tr2_list_env_vars_fl is
     --		 * calling this outside of a config callback. This will be
     --		 * easier to fix when we plumb kvi through the config callbacks,
     --		 * so leave this untouched for now.
     --		 */
     --		return CONFIG_SCOPE_UNKNOWN;
     +-		return the_reader.parsing_scope;
      -}
      -
       int lookup_config(const char **mapping, int nr_mapping, const char *var)
     @@ config.h: void git_global_config(char **user, char **xdg);
       
      -enum config_scope current_config_scope(void);
       const char *config_origin_type_name(enum config_origin_type type);
     + void kvi_from_param(struct key_value_info *out);
       
     - /*
     -@@ config.h: NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
     - 	lookup_config(mapping, ARRAY_SIZE(mapping), var)
     - int lookup_config(const char **mapping, int nr_mapping, const char *var);
     - 
     -+void kvi_from_param(struct key_value_info *out);
     -+
     - #endif /* CONFIG_H */
     -
     - ## remote.c ##
     -@@ remote.c: static void read_branches_file(struct remote_state *remote_state,
     - }
     - 
     - static int handle_config(const char *key, const char *value,
     --			 struct key_value_info *kvi UNUSED, void *cb)
     -+			 struct key_value_info *kvi, void *cb)
     - {
     - 	const char *name;
     - 	size_t namelen;
     -@@ remote.c: static int handle_config(const char *key, const char *value,
     - 	}
     - 	remote = make_remote(remote_state, name, namelen);
     - 	remote->origin = REMOTE_CONFIG;
     --	if (current_config_scope() == CONFIG_SCOPE_LOCAL ||
     --	    current_config_scope() == CONFIG_SCOPE_WORKTREE)
     -+	if (kvi->scope == CONFIG_SCOPE_LOCAL ||
     -+	    kvi->scope == CONFIG_SCOPE_WORKTREE)
     - 		remote->configured_in_repo = 1;
     - 	if (!strcmp(subkey, "mirror"))
     - 		remote->mirror = git_config_bool(key, value);
     -
     - ## t/helper/test-config.c ##
     -@@ t/helper/test-config.c: static int iterate_cb(const char *var, const char *value,
     - 	printf("origin=%s\n", config_origin_type_name(kvi->origin_type));
     - 	printf("name=%s\n", kvi->filename ? kvi->filename : "");
     - 	printf("lno=%d\n", kvi->linenr);
     --	printf("scope=%s\n", config_scope_name(current_config_scope()));
     -+	printf("scope=%s\n", config_scope_name(kvi->scope));
     - 
     - 	return 0;
     - }
      
       ## trace2.c ##
      @@ trace2.c: void trace2_thread_exit_fl(const char *file, int line)
 13:  11a32c86203 ! 11:  504eb206b5a config: pass kvi to die_bad_number()
     @@ Commit message
      
          Plumb "struct key_value_info" through all code paths that end in
          die_bad_number(), which lets us remove the helper functions that read
     -    analogous values from "struct config_reader".
     +    analogous values from "struct config_reader". As a result, nothing reads
     +    config_reader.config_kvi any more, so remove that too.
      
          In config.c, this requires changing the signature of
          git_configset_get_value() to 'return' "kvi" in an out parameter so that
     @@ builtin/commit.c: static int git_commit_config(const char *k, const char *v,
       
      
       ## builtin/config.c ##
     -@@ builtin/config.c: static int format_config(struct strbuf *buf, const char *key_, const char *value
     +@@ builtin/config.c: static int format_config(struct strbuf *buf, const char *key_,
       
       		if (type == TYPE_INT)
       			strbuf_addf(buf, "%"PRId64,
     @@ builtin/submodule--helper.c: static int update_clone_task_finished(int result,
       
      
       ## config.c ##
     +@@ config.c: struct config_reader {
     + 	 *
     + 	 * The "source" variable will be non-NULL only when we are actually
     + 	 * parsing a real config source (file, blob, cmdline, etc).
     +-	 *
     +-	 * The "config_kvi" variable will be non-NULL only when we are feeding
     +-	 * cached config from a configset into a callback.
     +-	 *
     +-	 * They cannot be non-NULL at the same time. If they are both NULL, then
     +-	 * we aren't parsing anything (and depending on the function looking at
     +-	 * the variables, it's either a bug for it to be called in the first
     +-	 * place, or it's a function which can be reused for non-config
     +-	 * purposes, and should fall back to some sane behavior).
     + 	 */
     + 	struct config_source *source;
     +-	struct key_value_info *config_kvi;
     + };
     + /*
     +  * Where possible, prefer to accept "struct config_reader" as an arg than to use
     +@@ config.c: static struct config_reader the_reader;
     + static inline void config_reader_push_source(struct config_reader *reader,
     + 					     struct config_source *top)
     + {
     +-	if (reader->config_kvi)
     +-		BUG("source should not be set while iterating a config set");
     + 	top->prev = reader->source;
     + 	reader->source = top;
     + }
     +@@ config.c: static inline struct config_source *config_reader_pop_source(struct config_reade
     + 	return ret;
     + }
     + 
     +-static inline void config_reader_set_kvi(struct config_reader *reader,
     +-					 struct key_value_info *kvi)
     +-{
     +-	reader->config_kvi = kvi;
     +-}
     +-
     + static int pack_compression_seen;
     + static int zlib_compression_seen;
     + 
      @@ config.c: int git_parse_ssize_t(const char *value, ssize_t *ret)
       	return 1;
       }
     @@ config.c: int git_default_config(const char *var, const char *value,
       		if (level == -1)
       			level = Z_DEFAULT_COMPRESSION;
       		else if (level < 0 || level > Z_BEST_COMPRESSION)
     +@@ config.c: static void configset_iter(struct config_reader *reader, struct config_set *set,
     + 		values = &entry->value_list;
     + 		kvi = values->items[value_index].util;
     + 
     +-		config_reader_set_kvi(reader, values->items[value_index].util);
     +-
     + 		if (fn(entry->key, values->items[value_index].string, kvi, data) < 0)
     + 			git_die_config_linenr(entry->key, kvi->filename, kvi->linenr);
     +-		config_reader_set_kvi(reader, NULL);
     + 	}
     + }
     + 
      @@ config.c: int git_configset_add_file(struct config_set *set, const char *filename)
       	return git_config_from_file(config_set_callback, filename, &data);
       }
     @@ config.c: int parse_config_key(const char *var,
      -{
      -	if (the_reader.config_kvi)
      -		*type = reader->config_kvi->origin_type;
     +-	else if(the_reader.source)
     +-		*type = reader->source->origin_type;
      -	else
      -		return 1;
      -	return 0;
     @@ config.c: const char *config_scope_name(enum config_scope scope)
      -{
      -	if (the_reader.config_kvi)
      -		*out = reader->config_kvi->filename;
     +-	else if (the_reader.source)
     +-		*out = reader->source->name;
      -	else
      -		return 1;
      -	return 0;
 14:  33e59152293 ! 12:  52db0d3be82 config: remove config_reader from configset_add_value
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    config: remove config_reader from configset_add_value
     +    config.c: remove config_reader from configsets
      
     -    Since we now get "kvi" from the config callback, we can stop passing it
     -    via "*data". Now "struct config_reader" has no more references, so get
     -    rid of it.
     +    Remove the last usage of "struct config_reader" from configsets by
     +    copying the "kvi" arg instead of recomputing "kvi" from
     +    config_reader.source. Since we no longer need to pass both "struct
     +    config_reader" and "struct config_set" in a single "void *cb", remove
     +    "struct configset_add_data" too.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
       ## config.c ##
     -@@ config.c: struct config_source {
     - };
     - #define CONFIG_SOURCE_INIT { 0 }
     - 
     --struct config_reader {
     --	struct key_value_info *config_kvi;
     --};
     --/*
     -- * Where possible, prefer to accept "struct config_reader" as an arg than to use
     -- * "the_reader". "the_reader" should only be used if that is infeasible, e.g. in
     -- * a public function.
     -- */
     --static struct config_reader the_reader;
     --
     --static inline void config_reader_push_kvi(struct config_reader *reader,
     --					  struct key_value_info *kvi)
     --{
     --	kvi->prev = reader->config_kvi;
     --	reader->config_kvi = kvi;
     --}
     --
     --static inline struct key_value_info *config_reader_pop_kvi(struct config_reader *reader)
     --{
     --	struct key_value_info *ret;
     --	if (!reader->config_kvi)
     --		BUG("tried to pop config_kvi, but we weren't reading config");
     --	ret = reader->config_kvi;
     --	reader->config_kvi = reader->config_kvi->prev;
     --	return ret;
     --}
     --
     - static int pack_compression_seen;
     - static int zlib_compression_seen;
     - 
     -@@ config.c: static int include_condition_is_true(struct key_value_info *kvi,
     - 	return 0;
     - }
     - 
     --static int kvi_fn(config_fn_t fn, const char *key, const char *value,
     --		  struct key_value_info *kvi, void *data);
     - static int git_config_include(const char *var, const char *value,
     - 			      struct key_value_info *kvi, void *data)
     - {
     -@@ config.c: static int git_config_include(const char *var, const char *value,
     - 	 * Pass along all values, including "include" directives; this makes it
     - 	 * possible to query information on the includes themselves.
     - 	 */
     --	ret = kvi_fn(inc->fn, var, value, kvi, inc->data);
     -+	ret = inc->fn(var, value, kvi, inc->data);
     - 	if (ret < 0)
     - 		return ret;
     - 
     -@@ config.c: out_free_ret_1:
     - 	return -CONFIG_INVALID_KEY;
     - }
     - 
     --static int kvi_fn(config_fn_t fn, const char *key, const char *value,
     --		  struct key_value_info *kvi, void *data)
     --{
     --	int ret;
     --	config_reader_push_kvi(&the_reader, kvi);
     --	ret = fn(key, value, kvi, data);
     --	config_reader_pop_kvi(&the_reader);
     --	return ret;
     --}
     --
     - static int config_parse_pair(const char *key, const char *value,
     - 			     struct key_value_info *kvi,
     - 			     config_fn_t fn, void *data)
     -@@ config.c: static int config_parse_pair(const char *key, const char *value,
     - 	if (git_config_parse_key(key, &canonical_name, NULL))
     - 		return -1;
     - 
     --	ret = (kvi_fn(fn, canonical_name, value, kvi, data) < 0) ? -1 : 0;
     -+	ret = (fn(canonical_name, value, kvi, data) < 0) ? -1 : 0;
     - 	free(canonical_name);
     +@@ config.c: int config_with_options(config_fn_t fn, void *data,
       	return ret;
       }
     -@@ config.c: static int get_value(struct config_source *cs, struct key_value_info *kvi,
     - 	 */
     - 	cs->linenr--;
     - 	kvi->linenr = cs->linenr;
     --	ret = kvi_fn(fn, name->buf, value, kvi, data);
     -+	ret = fn(name->buf, value, kvi, data);
     - 	if (ret >= 0)
     - 		cs->linenr++;
     - 	return ret;
     -@@ config.c: static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
     - 		values = &entry->value_list;
     - 		kvi = values->items[value_index].util;
       
     --		if (kvi_fn(fn, entry->key, values->items[value_index].string,
     --			   kvi, data) < 0)
     -+		if (fn(entry->key, values->items[value_index].string, kvi,
     -+		       data) < 0)
     - 			git_die_config_linenr(entry->key, kvi->filename,
     - 					      kvi->linenr);
     - 	}
     +-static void configset_iter(struct config_reader *reader, struct config_set *set,
     +-			   config_fn_t fn, void *data)
     ++static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
     + {
     + 	int i, value_index;
     + 	struct string_list *values;
      @@ config.c: static int configset_find_element(struct config_set *set, const char *key,
     - 	return 0;
       }
       
     --static int configset_add_value(struct config_reader *reader,
     --			       struct config_set *set, const char *key,
     --			       const char *value)
     -+static int configset_add_value(struct config_set *set, const char *key,
     -+			       const char *value, struct key_value_info *kvi_p)
     + static int configset_add_value(struct key_value_info *kvi_p,
     +-			       struct config_reader *reader,
     + 			       struct config_set *set, const char *key,
     + 			       const char *value)
       {
     - 	struct config_set_element *e;
     - 	struct string_list_item *si;
     -@@ config.c: static int configset_add_value(struct config_reader *reader,
     +@@ config.c: static int configset_add_value(struct key_value_info *kvi_p,
       	l_item->e = e;
       	l_item->value_index = e->value_list.nr - 1;
       
     --	memcpy(kv_info, reader->config_kvi, sizeof(struct key_value_info));
     +-	if (reader->source->name) {
     +-		kvi_from_source(reader->source, kvi_p->scope, kv_info);
     +-	} else {
     +-		kvi_from_param(kv_info);
     +-	}
      +	memcpy(kv_info, kvi_p, sizeof(struct key_value_info));
       	si->util = kv_info;
       
     @@ config.c: void git_configset_clear(struct config_set *set)
      -	struct config_set *config_set;
      -	struct config_reader *config_reader;
      -};
     - #define CONFIGSET_ADD_INIT { 0 }
     - 
     +-#define CONFIGSET_ADD_INIT { 0 }
     +-
       static int config_set_callback(const char *key, const char *value,
     --			       struct key_value_info *kvi UNUSED, void *cb)
     -+			       struct key_value_info *kvi, void *cb)
     + 			       struct key_value_info *kvi, void *cb)
       {
      -	struct configset_add_data *data = cb;
     --	configset_add_value(data->config_reader, data->config_set, key, value);
     +-	configset_add_value(kvi, data->config_reader, data->config_set, key, value);
      +	struct config_set *set = cb;
     -+	configset_add_value(set, key, value, kvi);
     ++	configset_add_value(kvi, set, key, value);
       	return 0;
       }
       
     @@ config.c: static void repo_read_config(struct repository *repo)
       	git_configset_init(repo->config);
      -	data.config_set = repo->config;
      -	data.config_reader = &the_reader;
     - 
     +-
      -	if (config_with_options(config_set_callback, &data, NULL, &opts) < 0)
     -+	if (config_with_options(config_set_callback, repo->config, NULL, &opts) < 0)
     ++	if (config_with_options(config_set_callback, repo->config, NULL,
     ++				&opts) < 0)
       		/*
       		 * config_with_options() normally returns only
       		 * zero, as most errors are fatal, and
     +@@ config.c: static void repo_config_clear(struct repository *repo)
     + void repo_config(struct repository *repo, config_fn_t fn, void *data)
     + {
     + 	git_config_check_init(repo);
     +-	configset_iter(&the_reader, repo->config, fn, data);
     ++	configset_iter(repo->config, fn, data);
     + }
     + 
     + int repo_config_get(struct repository *repo, const char *key)
      @@ config.c: static void read_protected_config(void)
       		.ignore_worktree = 1,
       		.system_gently = 1,
     @@ config.c: static void read_protected_config(void)
       }
       
       void git_protected_config(config_fn_t fn, void *data)
     + {
     + 	if (!protected_config.hash_initialized)
     + 		read_protected_config();
     +-	configset_iter(&the_reader, &protected_config, fn, data);
     ++	configset_iter(&protected_config, fn, data);
     + }
     + 
     + /* Functions used historically to read configuration from 'the_repository' */
  4:  b407fe1ed1d ! 13:  7d9b9eefc78 config: add kvi.path, use it to evaluate includes
     @@ Commit message
          Signed-off-by: Glen Choo <chooglen@google.com>
      
       ## config.c ##
     +@@ config.c: struct config_include_data {
     + 	void *data;
     + 	const struct config_options *opts;
     + 	struct git_config_source *config_source;
     +-	struct config_reader *config_reader;
     + 
     + 	/*
     + 	 * All remote URLs discovered when reading all config files.
      @@ config.c: static const char include_depth_advice[] = N_(
       "from\n"
       "	%s\n"
       "This might be due to circular includes.");
     --static int handle_path_include(struct config_source *cs, const char *path,
     +-static int handle_path_include(struct config_source *cs,
     +-			       struct key_value_info *kvi,
     +-			       const char *path,
      +static int handle_path_include(struct key_value_info *kvi, const char *path,
       			       struct config_include_data *inc)
       {
       	int ret = 0;
     -@@ config.c: static int handle_path_include(struct config_source *cs, const char *path,
     +@@ config.c: static int handle_path_include(struct config_source *cs,
       	if (!is_absolute_path(path)) {
       		char *slash;
       
     @@ config.c: static int handle_path_include(struct config_source *cs, const char *p
       		strbuf_addstr(&buf, path);
       		path = buf.buf;
       	}
     -@@ config.c: static int handle_path_include(struct config_source *cs, const char *path,
     +@@ config.c: static int handle_path_include(struct config_source *cs,
       	if (!access_or_die(path, R_OK, 0)) {
       		if (++inc->depth > MAX_INCLUDE_DEPTH)
       			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
     @@ config.c: static int handle_path_include(struct config_source *cs, const char *p
      +			    kvi->filename ? kvi->filename :
       			    "the command line");
       		ret = git_config_from_file_with_options(git_config_include, path, inc,
     --							current_config_scope(),
     --							NULL);
     -+							kvi->scope, NULL);
     - 		inc->depth--;
     - 	}
     - cleanup:
     + 							kvi->scope, NULL);
      @@ config.c: static void add_trailing_starstar_for_dir(struct strbuf *pat)
       		strbuf_addstr(pat, "**");
       }
     @@ config.c: static int include_by_remote_url(struct config_include_data *inc,
       	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
       		return include_by_branch(cond, cond_len);
       	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
     -@@ config.c: static int kvi_fn(config_fn_t fn, const char *key, const char *value,
     - static int git_config_include(const char *var, const char *value, void *data)
     +@@ config.c: static int git_config_include(const char *var, const char *value,
     + 			      struct key_value_info *kvi, void *data)
       {
       	struct config_include_data *inc = data;
      -	struct config_source *cs = inc->config_reader->source;
     - 	struct key_value_info *kvi = inc->config_reader->config_kvi;
       	const char *cond, *key;
       	size_t cond_len;
     -@@ config.c: static int git_config_include(const char *var, const char *value, void *data)
     + 	int ret;
     +@@ config.c: static int git_config_include(const char *var, const char *value,
       		return ret;
       
       	if (!strcmp(var, "include.path"))
     --		ret = handle_path_include(cs, value, inc);
     +-		ret = handle_path_include(cs, kvi, value, inc);
      +		ret = handle_path_include(kvi, value, inc);
       
       	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
     @@ config.c: static int git_config_include(const char *var, const char *value, void
       
       		if (inc->opts->unconditional_remote_url)
       			inc->fn = forbid_remote_url;
     --		ret = handle_path_include(cs, value, inc);
     +-		ret = handle_path_include(cs, kvi, value, inc);
      +		ret = handle_path_include(kvi, value, inc);
       		inc->fn = old_fn;
       	}
       
     -@@ config.c: static void kvi_from_param(struct key_value_info *out)
     +@@ config.c: void kvi_from_param(struct key_value_info *out)
       	out->linenr = -1;
       	out->origin_type = CONFIG_ORIGIN_CMDLINE;
       	out->scope = CONFIG_SCOPE_COMMAND;
     @@ config.c: static void kvi_from_source(struct config_source *cs,
       }
       
       static int git_parse_source(struct config_source *cs, config_fn_t fn,
     +@@ config.c: int config_with_options(config_fn_t fn, void *data,
     + 		inc.data = data;
     + 		inc.opts = opts;
     + 		inc.config_source = config_source;
     +-		inc.config_reader = &the_reader;
     + 		fn = git_config_include;
     + 		data = &inc;
     + 	}
      
       ## config.h ##
      @@ config.h: struct key_value_info {
     @@ config.h: struct key_value_info {
       	enum config_origin_type origin_type;
       	enum config_scope scope;
      +	const char *path;
     - 	struct key_value_info *prev;
       };
       
     + /**
  5:  e80d1b5f483 ! 14:  9e35b5b1f4d config: pass source to config_parser_event_fn_t
     @@ Commit message
          config.c, but this refactor is okay because this function has only ever
          been (and probably ever will be) used internally by config.c.
      
     -    This removes the last user of "config_reader.source", so remove it too.
     +    As a result, the_reader isn't used anywhere, so "struct config_reader"
     +    is obsolete (it was only intended to be used with the_reader). Remove
     +    them.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
       ## config.c ##
      @@ config.c: struct config_source {
     + };
       #define CONFIG_SOURCE_INIT { 0 }
       
     - struct config_reader {
     +-struct config_reader {
      -	/*
      -	 * These members record the "current" config source, which can be
      -	 * accessed by parsing callbacks.
      -	 *
      -	 * The "source" variable will be non-NULL only when we are actually
      -	 * parsing a real config source (file, blob, cmdline, etc).
     --	 *
     --	 * The "config_kvi" variable will be non-NULL only when we are feeding
     --	 * cached config from a configset into a callback.
     --	 *
     --	 * They cannot be non-NULL at the same time. If they are both NULL, then
     --	 * we aren't parsing anything (and depending on the function looking at
     --	 * the variables, it's either a bug for it to be called in the first
     --	 * place, or it's a function which can be reused for non-config
     --	 * purposes, and should fall back to some sane behavior).
      -	 */
      -	struct config_source *source;
     - 	struct key_value_info *config_kvi;
     - };
     - /*
     -@@ config.c: struct config_reader {
     -  */
     - static struct config_reader the_reader;
     - 
     +-};
     +-/*
     +- * Where possible, prefer to accept "struct config_reader" as an arg than to use
     +- * "the_reader". "the_reader" should only be used if that is infeasible, e.g. in
     +- * a public function.
     +- */
     +-static struct config_reader the_reader;
     +-
      -static inline void config_reader_push_source(struct config_reader *reader,
      -					     struct config_source *top)
      -{
     @@ config.c: struct config_reader {
      -	return ret;
      -}
      -
     - static inline void config_reader_push_kvi(struct config_reader *reader,
     - 					  struct key_value_info *kvi)
     - {
     + static int pack_compression_seen;
     + static int zlib_compression_seen;
     + 
     +@@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
     + 	struct strvec to_free = STRVEC_INIT;
     + 	int ret = 0;
     + 	char *envw = NULL;
     +-	struct config_source source = CONFIG_SOURCE_INIT;
     + 	struct key_value_info kvi = { 0 };
     + 
     +-	source.origin_type = CONFIG_ORIGIN_CMDLINE;
     +-	config_reader_push_source(&the_reader, &source);
     +-
     + 	kvi_from_param(&kvi);
     +-
     + 	env = getenv(CONFIG_COUNT_ENVIRONMENT);
     + 	if (env) {
     + 		unsigned long count;
     +@@ config.c: out:
     + 	strbuf_release(&envvar);
     + 	strvec_clear(&to_free);
     + 	free(envw);
     +-	config_reader_pop_source(&the_reader);
     + 	return ret;
     + }
     + 
      @@ config.c: static int do_event(struct config_source *cs, enum config_event_t type,
       
       	if (data->previous_type != CONFIG_EVENT_EOF &&
     @@ config.c: static int do_event(struct config_source *cs, enum config_event_t type
       		return -1;
       
       	data->previous_type = type;
     -@@ config.c: int git_default_config(const char *var, const char *value, void *cb)
     +@@ config.c: int git_default_config(const char *var, const char *value,
        * fgetc, ungetc, ftell of top need to be initialized before calling
        * this function.
        */
     @@ config.c: static int do_config_from_file(struct config_reader *reader,
      -	ret = do_config_from(reader, &top, fn, data, scope, opts);
      +	ret = do_config_from(&top, fn, data, scope, opts);
       	funlockfile(f);
     - 
       	return ret;
     + }
      @@ config.c: static int do_config_from_file(struct config_reader *reader,
       static int git_config_from_stdin(config_fn_t fn, void *data,
       				 enum config_scope scope)
     @@ config.c: int git_config_from_mem(config_fn_t fn,
       }
       
       int git_config_from_blob_oid(config_fn_t fn,
     +@@ config.c: int git_config_system(void)
     + 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
     + }
     + 
     +-static int do_git_config_sequence(struct config_reader *reader,
     +-				  const struct config_options *opts,
     ++static int do_git_config_sequence(const struct config_options *opts,
     + 				  config_fn_t fn, void *data)
     + {
     + 	int ret = 0;
     +@@ config.c: int config_with_options(config_fn_t fn, void *data,
     + 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
     + 					       data, config_source->scope);
     + 	} else {
     +-		ret = do_git_config_sequence(&the_reader, opts, fn, data);
     ++		ret = do_git_config_sequence(opts, fn, data);
     + 	}
     + 
     + 	if (inc.remote_urls) {
      @@ config.c: void git_die_config(const char *key, const char *err, ...)
        */
       
     @@ config.c: int git_config_set_multivar_in_file_gently(const char *config_filename
       	/* parse-key returns negative; flip the sign to feed exit(3) */
       	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
       	if (ret)
     -@@ config.c: static int reader_origin_type(struct config_reader *reader,
     - {
     - 	if (the_reader.config_kvi)
     - 		*type = reader->config_kvi->origin_type;
     --	else if(the_reader.source)
     --		*type = reader->source->origin_type;
     - 	else
     - 		return 1;
     - 	return 0;
     -@@ config.c: static int reader_config_name(struct config_reader *reader, const char **out)
     - {
     - 	if (the_reader.config_kvi)
     - 		*out = reader->config_kvi->filename;
     --	else if (the_reader.source)
     --		*out = reader->source->name;
     - 	else
     - 		return 1;
     - 	return 0;
     -@@ config.c: int current_config_line(void)
     - 	if (the_reader.config_kvi)
     - 		return the_reader.config_kvi->linenr;
     - 	else
     --		return the_reader.source->linenr;
     -+		BUG("current_config_line called outside config callback");
     - }
     - 
     - int lookup_config(const char **mapping, int nr_mapping, const char *var)
      
       ## config.h ##
      @@ config.h: enum config_event_t {

-- 
gitgitgadget
