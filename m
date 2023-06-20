Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8135EB64D8
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjFTToR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjFTToI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:44:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C581728
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f9b4a71623so18557885e9.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687290239; x=1689882239;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgqhSBKdkAiKU1/4jAHBGs1xHtJHUQYLXomRkKYyFWQ=;
        b=IBhdotJ9eQY+4wJ+dc/3yjFzkhUUK3gCYNp25Gk+rP/W8K9EV0l67+LQfwE7H322rg
         LudOSbJknInlN3g5oT8VzPj0SwNqnGvqZiJwygXWOSoC3K25gFw+LHIKxcZV7ePYr010
         Cy79jhA5KHyOX2kOZAhWuBGoPDSCzdfQGE9/WKDHFLSrcA4yjggF84/at1CTUXfcJqWM
         I8t43RxAvUNia9Y5xjZBYOVz9smDUPZySLoffHapubEihTOl1Txtwe9hT18Ih/vxKq2w
         IgV3VZ9V1jSuXlkaOBnVv6bmUNyUpN4oG51PgGh2EudhhJqB1x9kOela//eoV9qGoerr
         jqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290239; x=1689882239;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgqhSBKdkAiKU1/4jAHBGs1xHtJHUQYLXomRkKYyFWQ=;
        b=VYmiC9I171XtX6SznPJka+hG8er425ti+5XSybp0ypnGW9CYOuC7qQngQI5IbXMpj3
         D+XDXjcmIZrGk8sgbVAICVvqQgO0WFW4ebF+ze2LJBaxOcKHnNjB8QEBxXlii10QC0jX
         b8t+dUzFjFPBXov6pSiaLolkEqLz3x7EUWhAJKZcZYzyigefE+EirFzycjndgf4JF8Yo
         hAAw+k4k6DO5ILe+ki2N5ULKlbIhPE9BmltGhW1cQI/XgezNM7H2/n2/FFx+bKJW6R95
         JibMl5XNxjy5E803c39k7L/1Pot5Vvk3IoOsfs7tXFHf2yRoaavIjamqjoDcnmETZQvu
         ny/g==
X-Gm-Message-State: AC+VfDxYAmSEtwQijmcmsZI1RumhcS26hDQGIG7Y7i4iduUaaCkj403x
        RJ3oNnHLZJl50mf9AHsHaiEhFfTjR7k=
X-Google-Smtp-Source: ACHHUZ4F5IE2pIO9OGSSSJSze3DOiXr7TesQK+A/ODokvTHAqdMGmF9WLVTnjyF3o+wIAGoazC+/ng==
X-Received: by 2002:a5d:6348:0:b0:311:1763:8607 with SMTP id b8-20020a5d6348000000b0031117638607mr8467756wrw.29.1687290237496;
        Tue, 20 Jun 2023 12:43:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4-20020adff784000000b0030aec5e020fsm2648034wrp.86.2023.06.20.12.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:43:56 -0700 (PDT)
Message-Id: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 19:43:39 +0000
Subject: [PATCH v3 00/12] config: remove global state from config iteration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio: I rebased this onto a newer "master". I assume this is a noop for
you - I noticed that the RFC versions weren't applied anyway (good).

Thanks for the thoughtful review on the last round, all. This is the
first non-RFC reroll, and hopefully the last ;) This is basically the
RFC v2 with the post-RFC cleanups I've been talking about, plus review
comments. I did a decent amount of experimentation with Phillip's
alternative config_fn_t signatures, and while I think they make sense in
the long term (when we add additional helpers, make structs opaque,
etc), they introduce a lot of distracting churn but don't really change
the status quo, so I've left them out of this series.

A major departure from the RFC is that the large refactoring patches
have now been squashed together. If you'd would like to meaningfully
range-diff those commits against v2, you can use:

  git fetch https://github.com/chooglen/git/ config/no-global-unsquashed-cocci

which uses the same base as v1 and v2.

= Changes since v2

* Rebase onto a newer version of "master"

* To accomodate future changes to config_fn_t, use "const struct
  config_context *ctx" (which has a .kvi member) instead of directly
  referencing "kvi".

* Add appropriate comments to config.h.

* .kvi is now const.

* Introduce KVI_INIT as a safer default to "= { 0 }".

* Incorporate wording suggestions

= Description

This series removes all global state from config iteration, i.e. parsing
config and iterating configsets, by passing config metadata as a "struct
key_value_info" to the "config_fn_t" callbacks. This allows us to
get rid of:

 * "the_reader" (formerly "cf", "current_parsing_scope",
   "current_config_kvi"), and the config.c machinery that maintained it.
   This only needed to be global because it was read by...
 * The "current_*" functions that read metadata about the 'current'
   config value ("current_config_scope", "current_config_name", etc),
   which are replaced by reading values from the "struct key_value_info"
   passed to the callbacks.

As a result:

 * Config iterating code can be moved to into its own library with few
   modifications. C.f. libification efforts [1].
 * The config iterating code can be safely called in parallel.
 * We expose and fix instances where the "current_*" functions were being
   called outside of config callbacks.

We've had this idea of doing this "config_fn_t" refactor for a long time
[2], but we've never attempted it because we wanted to avoid churn. After
attempting it, though, I'm quite convinced that this is the right way
forward for config, since the lack of global state makes things much easier
to reason about. The churn is also quite manageable:

 * The vast majority of changes can be handled with cocci.
 * The few cases that aren't covered by cocci have obvious fixes.
 * The change is simple enough for in-flight topics to perform and conflicts
   will be caught at build time anyway.

To avoid _future_ churn (if we want to change config_fn_t again), I
opted to pass a config_context arg instead of using key_value_info
directly. We can make changes we want to that arg while leaving the
signature untouched.

= Patch overview

* 1-3/12 add the "ctx" parameter to the config_fn_t signature.

* 4-9/12 converts the config.c machinery off "config_reader.config_kvi"
  and "config_reader.source" and onto ctx->kvi. We convert the config.c
  machinery from "config_reader" to "kvi" one-by-one: configsets, then
  files, then CLI. To exercise the "kvi" arg as soon as possible, we
  convert from current_*() to "kvi" as soon as it is available. For
  example, in 4/12 "kvi" is available only in configsets, so we convert
  the current_*() call sites that are only reached via configsets and
  leave the others untouched. This means that we have a mix of
  current_*() and "kvi" in the middle, but auditing the changes is
  relatively easy, since you only need to verify that a callback isn't
  relying on the "kvi" arg before it is available, and that current_*()
  and "kvi" give the same value.

  * 6-7/12 squashes some bugs where builtin/config.c was calling the
    current_*() API outside of config callbacks. The "kvi" plumbing
    doesn't just make the bugs apparent, it also provides an obvious way
    to fix the bugs (by injecting "kvi" into the right places in
    builtin/config.c). These would have been nontrivial to fix if we
    were still using global state.

* 10-12/12 remove config_reader by taking advantage of "kvi" and doing
  some other light plumbing.

= Alternatives considered

Ævar suggested in [3] that we might be able to do the refactor incrementally
by having both the old "config_fn_t" and the new "config_fn_t with kvi",
which lets us convert some of config iterating (e.g. configsets) without
touching the others (e.g. config parsing). I experimented with that for a
bit, and it turned out that doing it all at once is actually less work
because we don't have to worry about the case where the same "config_fn_t"
is used in both git_config() and git_config_from_file().

Jonathan Tan suggested in [4] that to reduce churn, we might be able to
convert many of the config_fn_t-s to the config set API before attempting
this refactor. But (hopefully), these patches show that the churn is
manageable even without this preparatory step.

[1]
https://lore.kernel.org/git/CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com/
[2]
https://lore.kernel.org/git/CAPc5daV6bdUKS-ExHmpT4Ppy2S832NXoyPw7aOLP7fG=WrBPgg@mail.gmail.com/
[3]
https://lore.kernel.org/git/RFC-patch-5.5-2b80d293c83-20230317T042408Z-avarab@gmail.com
[4]
https://lore.kernel.org/git/20230306195756.3399115-1-jonathantanmy@google.com/


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
 builtin/add.c                                 |   5 +-
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
 config.c                                      | 551 +++++++-----------
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
 103 files changed, 956 insertions(+), 638 deletions(-)
 create mode 100644 contrib/coccinelle/config_fn_ctx.pending.cocci
 create mode 100644 contrib/coccinelle/git_config_number.cocci


base-commit: d7d8841f67f29e6ecbad85a11805c907d0f00d5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1497%2Fchooglen%2Fconfig%2Fno-global-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1497/chooglen/config/no-global-v3
Pull-Request: https://github.com/git/git/pull/1497

Range-diff vs v2:

  1:  d5edf7e3fdd =  1:  26109b65142 config: inline git_color_default_config
  2:  821f0b90580 =  2:  1aeffcb1395 urlmatch.h: use config_fn_t type
  3:  6834e37066e <  -:  ----------- (RFC-only) config: add kvi arg to config_fn_t
  4:  bd52c6232ec !  3:  d3eb439aad2 (RFC-only) config: apply cocci to config_fn_t implementations
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    (RFC-only) config: apply cocci to config_fn_t implementations
     -
     -    Pass "struct key_value_info" to *most* functions that are invoked as
     -    "config_fn_t" callbacks by applying
     -    contrib/coccinelle/config_fn_kvi.pending.cocci. None of the functions
     -    actually use the "kvi" arg yet (besides propagating it to a function
     -    that now expects "kvi"), but this will be addressed in a later commit.
     -    When deciding whether or not to propagate "kvi" to an inner function,
     -    only propagate the "kvi" arg if the inner function is actually invoked
     -    elsewhere as a config callback; it does not matter whether the function
     -    happens have the same signature as config_fn_t.
     -
     -    This commit does not build and has several style issues (e.g. a lack of
     -    spacing around the "kvi" arg), but I've split this out for the RFC so
     -    that it's more obvious which changes are automatic vs manual. Post-RFC I
     -    will squash this with the rest of the refactor + cocci changes.
     +    config: add ctx arg to config_fn_t
     +
     +    Add a new "const struct config_context *ctx" arg to config_fn_t to hold
     +    additional information about the config iteration operation.
     +    config_context has a "struct key_value_info kvi" member that holds
     +    metadata about the config source being read (e.g. what kind of config
     +    source it is, the filename, etc). In this series, we're only interested
     +    in .kvi, so we could have just used "struct key_value_info" as an arg,
     +    but config_context makes it possible to add/adjust members in the future
     +    without changing the config_fn_t signature. We could also consider other
     +    ways of organizing the args (e.g. moving the config name and value into
     +    config_context or key_value_info), but in my experiments, the
     +    incremental benefit doesn't justify the added complexity (e.g. a
     +    config_fn_t will sometimes invoke another config_fn_t but with a
     +    different config value).
     +
     +    In subsequent commits, the .kvi member will replace the global "struct
     +    config_reader" in config.c, making config iteration a global-free
     +    operation. It requires much more work for the machinery to provide
     +    meaningful values of .kvi, so for now, merely change the signature and
     +    call sites, pass NULL as a placeholder value, and don't rely on the arg
     +    in any meaningful way.
     +
     +    Most of the changes are performed by
     +    contrib/coccinelle/config_fn_ctx.pending.cocci, which, for every
     +    config_fn_t:
     +
     +    - Modifies the signature to accept "const struct config_context *ctx"
     +    - Passes "ctx" to any inner config_fn_t, if needed
     +    - Adds UNUSED attributes to "ctx", if needed
     +
     +    Most config_fn_t instances are easily identified by seeing if they are
     +    called by the various config functions. Most of the remaining ones are
     +    manually named in the .cocci patch. Manual cleanups are still needed,
     +    but the majority of it is trivial; it's either adjusting config_fn_t
     +    that the .cocci patch didn't catch, or adding forward declarations of
     +    "struct config_context ctx" to make the signatures make sense.
     +
     +    The non-trivial changes are in cases where we are invoking a config_fn_t
     +    outside of config machinery, and we now need to decide what value of
     +    "ctx" to pass. These cases are:
     +
     +    - trace2/tr2_cfg.c:tr2_cfg_set_fl()
     +
     +      This is indirectly called by git_config_set() so that the trace2
     +      machinery can notice the new config values and update its settings
     +      using the tr2 config parsing function, i.e. tr2_cfg_cb().
     +
     +    - builtin/checkout.c:checkout_main()
     +
     +      This calls git_xmerge_config() as a shorthand for parsing a CLI arg.
     +      This might be worth refactoring away in the future, since
     +      git_xmerge_config() can call git_default_config(), which can do much
     +      more than just parsing.
     +
     +    Handle them by creating a KVI_INIT macro that initializes "struct
     +    key_value_info" to a reasonable default, and use that to construct the
     +    "ctx" arg.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     @@ alias.c: struct config_alias_data {
       
      -static int config_alias_cb(const char *key, const char *value, void *d)
      +static int config_alias_cb(const char *key, const char *value,
     -+			   struct key_value_info *kvi UNUSED, void *d)
     ++			   const struct config_context *ctx UNUSED, void *d)
       {
       	struct config_alias_data *data = d;
       	const char *p;
     @@ archive-tar.c: static int tar_filter_config(const char *var, const char *value,
       
      -static int git_tar_config(const char *var, const char *value, void *cb)
      +static int git_tar_config(const char *var, const char *value,
     -+			  struct key_value_info *kvi UNUSED, void *cb)
     ++			  const struct config_context *ctx UNUSED, void *cb)
       {
       	if (!strcmp(var, "tar.umask")) {
       		if (value && !strcmp(value, "user")) {
     @@ archive-zip.c: static void dos_time(timestamp_t *timestamp, int *dos_date, int *
       }
       
       static int archive_zip_config(const char *var, const char *value,
     -+			      struct key_value_info *kvi UNUSED,
     ++			      const struct config_context *ctx UNUSED,
       			      void *data UNUSED)
       {
       	return userdiff_config(var, value);
     @@ builtin/add.c: static struct option builtin_add_options[] = {
       
      -static int add_config(const char *var, const char *value, void *cb)
      +static int add_config(const char *var, const char *value,
     -+		      struct key_value_info *kvi, void *cb)
     ++		      const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "add.ignoreerrors") ||
       	    !strcmp(var, "add.ignore-errors")) {
     @@ builtin/add.c: static int add_config(const char *var, const char *value, void *c
       	}
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       static const char embedded_advice[] = N_(
     @@ builtin/blame.c: static const char *add_prefix(const char *prefix, const char *p
       
      -static int git_blame_config(const char *var, const char *value, void *cb)
      +static int git_blame_config(const char *var, const char *value,
     -+			    struct key_value_info *kvi, void *cb)
     ++			    const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "blame.showroot")) {
       		show_root = git_config_bool(var, value);
     @@ builtin/blame.c: static int git_blame_config(const char *var, const char *value,
       		return -1;
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       static int blame_copy_callback(const struct option *option, const char *arg, int unset)
     @@ builtin/branch.c: static unsigned int colopts;
       
      -static int git_branch_config(const char *var, const char *value, void *cb)
      +static int git_branch_config(const char *var, const char *value,
     -+			     struct key_value_info *kvi, void *cb)
     ++			     const struct config_context *ctx, void *cb)
       {
       	const char *slot_name;
       
     @@ builtin/branch.c: static int git_branch_config(const char *var, const char *valu
       		return -1;
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       static const char *branch_get_color(enum color_branch ix)
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
       
      -static int git_cat_file_config(const char *var, const char *value, void *cb)
      +static int git_cat_file_config(const char *var, const char *value,
     -+			       struct key_value_info *kvi, void *cb)
     ++			       const struct config_context *ctx, void *cb)
       {
       	if (userdiff_config(var, value) < 0)
       		return -1;
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       static int batch_option_callback(const struct option *opt,
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       
      -static int git_checkout_config(const char *var, const char *value, void *cb)
      +static int git_checkout_config(const char *var, const char *value,
     -+			       struct key_value_info *kvi, void *cb)
     ++			       const struct config_context *ctx, void *cb)
       {
       	struct checkout_opts *opts = cb;
       
     @@ builtin/checkout.c: static int git_checkout_config(const char *var, const char *
       		return git_default_submodule_config(var, value, NULL);
       
      -	return git_xmerge_config(var, value, NULL);
     -+	return git_xmerge_config(var, value,kvi, NULL);
     ++	return git_xmerge_config(var, value, ctx, NULL);
       }
       
       static void setup_new_branch_info_and_source_tree(
     +@@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
     + 	}
     + 
     + 	if (opts->conflict_style) {
     ++		struct key_value_info kvi = KVI_INIT;
     ++		struct config_context ctx = {
     ++			.kvi = &kvi,
     ++		};
     + 		opts->merge = 1; /* implied */
     +-		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
     ++		git_xmerge_config("merge.conflictstyle", opts->conflict_style,
     ++				  &ctx, NULL);
     + 	}
     + 	if (opts->force) {
     + 		opts->discard_changes = 1;
      
       ## builtin/clean.c ##
      @@ builtin/clean.c: struct menu_stuff {
     @@ builtin/clean.c: struct menu_stuff {
       
      -static int git_clean_config(const char *var, const char *value, void *cb)
      +static int git_clean_config(const char *var, const char *value,
     -+			    struct key_value_info *kvi, void *cb)
     ++			    const struct config_context *ctx, void *cb)
       {
       	const char *slot_name;
       
     @@ builtin/clean.c: static int git_clean_config(const char *var, const char *value,
       		return -1;
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       static const char *clean_get_color(enum color_clean ix)
     @@ builtin/clone.c: static int checkout(int submodule_progress, int filter_submodul
       
      -static int git_clone_config(const char *k, const char *v, void *cb)
      +static int git_clone_config(const char *k, const char *v,
     -+			    struct key_value_info *kvi, void *cb)
     ++			    const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(k, "clone.defaultremotename")) {
       		free(remote_name);
     @@ builtin/clone.c: static int git_clone_config(const char *k, const char *v, void
       		config_filter_submodules = git_config_bool(k, v);
       
      -	return git_default_config(k, v, cb);
     -+	return git_default_config(k, v,kvi, cb);
     ++	return git_default_config(k, v, ctx, cb);
       }
       
      -static int write_one_config(const char *key, const char *value, void *data)
      +static int write_one_config(const char *key, const char *value,
     -+			    struct key_value_info *kvi UNUSED, void *data)
     ++			    const struct config_context *ctx,
     ++			    void *data)
       {
       	/*
       	 * give git_clone_config a chance to write config values back to the
     + 	 * environment, since git_config_set_multivar_gently only deals with
     + 	 * config-file writes
     + 	 */
     +-	int apply_failed = git_clone_config(key, value, data);
     ++	int apply_failed = git_clone_config(key, value, ctx, data);
     + 	if (apply_failed)
     + 		return apply_failed;
     + 
      
       ## builtin/column.c ##
      @@ builtin/column.c: static const char * const builtin_column_usage[] = {
     @@ builtin/column.c: static const char * const builtin_column_usage[] = {
       
      -static int column_config(const char *var, const char *value, void *cb)
      +static int column_config(const char *var, const char *value,
     -+			 struct key_value_info *kvi UNUSED, void *cb)
     ++			 const struct config_context *ctx UNUSED, void *cb)
       {
       	return git_column_config(var, value, cb, &colopts);
       }
     @@ builtin/commit-graph.c: static int write_option_max_new_filters(const struct opt
       }
       
       static int git_commit_graph_write_config(const char *var, const char *value,
     -+					 struct key_value_info *kvi UNUSED,
     ++					 const struct config_context *ctx UNUSED,
       					 void *cb UNUSED)
       {
       	if (!strcmp(var, "commitgraph.maxnewfilters"))
     @@ builtin/commit.c: static int parse_status_slot(const char *slot)
       
      -static int git_status_config(const char *k, const char *v, void *cb)
      +static int git_status_config(const char *k, const char *v,
     -+			     struct key_value_info *kvi, void *cb)
     ++			     const struct config_context *ctx, void *cb)
       {
       	struct wt_status *s = cb;
       	const char *slot_name;
     @@ builtin/commit.c: static int git_status_config(const char *k, const char *v, voi
       		return 0;
       	}
      -	return git_diff_ui_config(k, v, NULL);
     -+	return git_diff_ui_config(k, v,kvi, NULL);
     ++	return git_diff_ui_config(k, v, ctx, NULL);
       }
       
       int cmd_status(int argc, const char **argv, const char *prefix)
     @@ builtin/commit.c: int cmd_status(int argc, const char **argv, const char *prefix
       
      -static int git_commit_config(const char *k, const char *v, void *cb)
      +static int git_commit_config(const char *k, const char *v,
     -+			     struct key_value_info *kvi, void *cb)
     ++			     const struct config_context *ctx, void *cb)
       {
       	struct wt_status *s = cb;
       
     @@ builtin/commit.c: static int git_commit_config(const char *k, const char *v, voi
       	}
       
      -	return git_status_config(k, v, s);
     -+	return git_status_config(k, v,kvi, s);
     ++	return git_status_config(k, v, ctx, s);
       }
       
       int cmd_commit(int argc, const char **argv, const char *prefix)
     @@ builtin/config.c: static void show_config_scope(struct strbuf *buf)
       }
       
       static int show_all_config(const char *key_, const char *value_,
     --			   void *cb UNUSED)
     -+			   struct key_value_info *kvi UNUSED, void *cb UNUSED)
     ++			   const struct config_context *ctx UNUSED,
     + 			   void *cb UNUSED)
       {
       	if (show_origin || show_scope) {
     - 		struct strbuf buf = STRBUF_INIT;
      @@ builtin/config.c: static int format_config(struct strbuf *buf, const char *key_, const char *value
       	return 0;
       }
       
      -static int collect_config(const char *key_, const char *value_, void *cb)
      +static int collect_config(const char *key_, const char *value_,
     -+			  struct key_value_info *kvi UNUSED, void *cb)
     ++			  const struct config_context *ctx UNUSED, void *cb)
       {
       	struct strbuf_list *values = cb;
       
     @@ builtin/config.c: static const char *get_colorbool_slot;
       static char parsed_color[COLOR_MAXLEN];
       
       static int git_get_color_config(const char *var, const char *value,
     -+				struct key_value_info *kvi UNUSED,
     ++				const struct config_context *ctx UNUSED,
       				void *cb UNUSED)
       {
       	if (!strcmp(var, get_color_slot)) {
     @@ builtin/config.c: static int get_colorbool_found;
       static int get_diff_color_found;
       static int get_color_ui_found;
       static int git_get_colorbool_config(const char *var, const char *value,
     -+				    struct key_value_info *kvi UNUSED,
     ++				    const struct config_context *ctx UNUSED,
       				    void *data UNUSED)
       {
       	if (!strcmp(var, get_colorbool_slot))
     @@ builtin/config.c: struct urlmatch_current_candidate_value {
       
      -static int urlmatch_collect_fn(const char *var, const char *value, void *cb)
      +static int urlmatch_collect_fn(const char *var, const char *value,
     -+			       struct key_value_info *kvi UNUSED, void *cb)
     ++			       const struct config_context *ctx UNUSED,
     ++			       void *cb)
       {
       	struct string_list *values = cb;
       	struct string_list_item *item = string_list_insert(values, var);
     @@ builtin/difftool.c: static const char *const builtin_difftool_usage[] = {
       
      -static int difftool_config(const char *var, const char *value, void *cb)
      +static int difftool_config(const char *var, const char *value,
     -+			   struct key_value_info *kvi, void *cb)
     ++			   const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "difftool.trustexitcode")) {
       		trust_exit_code = git_config_bool(var, value);
     @@ builtin/difftool.c: static const char *const builtin_difftool_usage[] = {
       	}
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       static int print_tool_help(void)
      
       ## builtin/fetch.c ##
     -@@ builtin/fetch.c: static int fetch_write_commit_graph = -1;
     - static int stdin_refspecs = 0;
     - static int negotiate_only;
     +@@ builtin/fetch.c: struct fetch_config {
     + 	enum display_format display_format;
     + };
       
      -static int git_fetch_config(const char *k, const char *v, void *cb)
      +static int git_fetch_config(const char *k, const char *v,
     -+			    struct key_value_info *kvi, void *cb)
     ++			    const struct config_context *ctx, void *cb)
       {
     - 	if (!strcmp(k, "fetch.prune")) {
     - 		fetch_prune_config = git_config_bool(k, v);
     + 	struct fetch_config *fetch_config = cb;
     + 
      @@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v, void *cb)
     - 		return 0;
     + 			    "fetch.output", v);
       	}
       
      -	return git_default_config(k, v, cb);
     -+	return git_default_config(k, v,kvi, cb);
     ++	return git_default_config(k, v, ctx, cb);
       }
       
       static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
     @@ builtin/fetch.c: struct remote_group_data {
       
      -static int get_remote_group(const char *key, const char *value, void *priv)
      +static int get_remote_group(const char *key, const char *value,
     -+			    struct key_value_info *kvi UNUSED, void *priv)
     ++			    const struct config_context *ctx UNUSED,
     ++			    void *priv)
       {
       	struct remote_group_data *g = priv;
       
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor__start_timeout_sec = 60;
       
      -static int fsmonitor_config(const char *var, const char *value, void *cb)
      +static int fsmonitor_config(const char *var, const char *value,
     -+			    struct key_value_info *kvi, void *cb)
     ++			    const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
       		int i = git_config_int(var, value);
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_config(const char *var, const
       	}
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       /*
     @@ builtin/grep.c: static int wait_all(void)
       
      -static int grep_cmd_config(const char *var, const char *value, void *cb)
      +static int grep_cmd_config(const char *var, const char *value,
     -+			   struct key_value_info *kvi, void *cb)
     ++			   const struct config_context *ctx, void *cb)
       {
     - 	int st = grep_config(var, value, cb);
     +-	int st = grep_config(var, value, cb);
     ++	int st = grep_config(var, value, ctx, cb);
       
       	if (git_color_config(var, value, cb) < 0)
       		st = -1;
      -	else if (git_default_config(var, value, cb) < 0)
     -+	else if (git_default_config(var, value,kvi, cb) < 0)
     ++	else if (git_default_config(var, value, ctx, cb) < 0)
       		st = -1;
       
       	if (!strcmp(var, "grep.threads")) {
     @@ builtin/help.c: static int add_man_viewer_info(const char *var, const char *valu
       
      -static int git_help_config(const char *var, const char *value, void *cb)
      +static int git_help_config(const char *var, const char *value,
     -+			   struct key_value_info *kvi, void *cb)
     ++			   const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "help.format")) {
       		if (!value)
     @@ builtin/help.c: static int git_help_config(const char *var, const char *value, v
       		return add_man_viewer_info(var, value);
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       static struct cmdnames main_cmds, other_cmds;
     @@ builtin/index-pack.c: static void final(const char *final_pack_name, const char
       
      -static int git_index_pack_config(const char *k, const char *v, void *cb)
      +static int git_index_pack_config(const char *k, const char *v,
     -+				 struct key_value_info *kvi, void *cb)
     ++				 const struct config_context *ctx, void *cb)
       {
       	struct pack_idx_option *opts = cb;
       
     @@ builtin/index-pack.c: static int git_index_pack_config(const char *k, const char
       			opts->flags &= ~WRITE_REV;
       	}
      -	return git_default_config(k, v, cb);
     -+	return git_default_config(k, v,kvi, cb);
     ++	return git_default_config(k, v, ctx, cb);
       }
       
       static int cmp_uint32(const void *a_, const void *b_)
     @@ builtin/log.c: static int cmd_log_walk(struct rev_info *rev)
       
      -static int git_log_config(const char *var, const char *value, void *cb)
      +static int git_log_config(const char *var, const char *value,
     -+			  struct key_value_info *kvi, void *cb)
     ++			  const struct config_context *ctx, void *cb)
       {
       	const char *slot_name;
       
     @@ builtin/log.c: static int git_log_config(const char *var, const char *value, voi
       	}
       
      -	return git_diff_ui_config(var, value, cb);
     -+	return git_diff_ui_config(var, value,kvi, cb);
     ++	return git_diff_ui_config(var, value, ctx, cb);
       }
       
       int cmd_whatchanged(int argc, const char **argv, const char *prefix)
     @@ builtin/log.c: static enum cover_from_description parse_cover_from_description(c
       
      -static int git_format_config(const char *var, const char *value, void *cb)
      +static int git_format_config(const char *var, const char *value,
     -+			     struct key_value_info *kvi, void *cb)
     ++			     const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "format.headers")) {
       		if (!value)
     @@ builtin/log.c: static int git_format_config(const char *var, const char *value,
       		return 0;
       
      -	return git_log_config(var, value, cb);
     -+	return git_log_config(var, value,kvi, cb);
     ++	return git_log_config(var, value, ctx, cb);
       }
       
       static const char *output_directory = NULL;
     @@ builtin/merge.c: static void parse_branch_merge_options(char *bmo)
       
      -static int git_merge_config(const char *k, const char *v, void *cb)
      +static int git_merge_config(const char *k, const char *v,
     -+			    struct key_value_info *kvi, void *cb)
     ++			    const struct config_context *ctx, void *cb)
       {
       	int status;
       	const char *str;
     @@ builtin/merge.c: static int git_merge_config(const char *k, const char *v, void
       	}
       
      -	status = fmt_merge_msg_config(k, v, cb);
     -+	status = fmt_merge_msg_config(k, v,kvi, cb);
     ++	status = fmt_merge_msg_config(k, v, ctx, cb);
       	if (status)
       		return status;
      -	return git_diff_ui_config(k, v, cb);
     -+	return git_diff_ui_config(k, v,kvi, cb);
     ++	return git_diff_ui_config(k, v, ctx, cb);
       }
       
       static int read_tree_trivial(struct object_id *common, struct object_id *head,
     @@ builtin/multi-pack-index.c: static struct option *add_common_options(struct opti
       }
       
       static int git_multi_pack_index_write_config(const char *var, const char *value,
     -+					     struct key_value_info *kvi UNUSED,
     ++					     const struct config_context *ctx UNUSED,
       					     void *cb UNUSED)
       {
       	if (!strcmp(var, "pack.writebitmaphashcache")) {
     @@ builtin/pack-objects.c: static void prepare_pack(int window, int depth)
       
      -static int git_pack_config(const char *k, const char *v, void *cb)
      +static int git_pack_config(const char *k, const char *v,
     -+			   struct key_value_info *kvi, void *cb)
     ++			   const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(k, "pack.window")) {
       		window = git_config_int(k, v);
     @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
       		oidmap_put(&configured_exclusions, ex);
       	}
      -	return git_default_config(k, v, cb);
     -+	return git_default_config(k, v,kvi, cb);
     ++	return git_default_config(k, v, ctx, cb);
       }
       
       /* Counters for trace2 output when in --stdin-packs mode. */
     @@ builtin/patch-id.c: struct patch_id_opts {
       
      -static int git_patch_id_config(const char *var, const char *value, void *cb)
      +static int git_patch_id_config(const char *var, const char *value,
     -+			       struct key_value_info *kvi, void *cb)
     ++			       const struct config_context *ctx, void *cb)
       {
       	struct patch_id_opts *opts = cb;
       
     @@ builtin/patch-id.c: static int git_patch_id_config(const char *var, const char *
       	}
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       int cmd_patch_id(int argc, const char **argv, const char *prefix)
     @@ builtin/pull.c: static enum rebase_type config_get_rebase(int *rebase_unspecifie
        */
      -static int git_pull_config(const char *var, const char *value, void *cb)
      +static int git_pull_config(const char *var, const char *value,
     -+			   struct key_value_info *kvi, void *cb)
     ++			   const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "rebase.autostash")) {
       		config_autostash = git_config_bool(var, value);
     @@ builtin/pull.c: static int git_pull_config(const char *var, const char *value, v
       	}
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       /**
     @@ builtin/push.c: static void set_push_cert_flags(int *flags, int v)
       
      -static int git_push_config(const char *k, const char *v, void *cb)
      +static int git_push_config(const char *k, const char *v,
     -+			   struct key_value_info *kvi, void *cb)
     ++			   const struct config_context *ctx, void *cb)
       {
       	const char *slot_name;
       	int *flags = cb;
     @@ builtin/push.c: static int git_push_config(const char *k, const char *v, void *c
       	}
       
      -	return git_default_config(k, v, NULL);
     -+	return git_default_config(k, v,kvi, NULL);
     ++	return git_default_config(k, v, ctx, NULL);
       }
       
       int cmd_push(int argc, const char **argv, const char *prefix)
     @@ builtin/read-tree.c: static int debug_merge(const struct cache_entry * const *st
       
      -static int git_read_tree_config(const char *var, const char *value, void *cb)
      +static int git_read_tree_config(const char *var, const char *value,
     -+				struct key_value_info *kvi, void *cb)
     ++				const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "submodule.recurse"))
       		return git_default_submodule_config(var, value, cb);
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
     @@ builtin/rebase.c: static void parse_rebase_merges_value(struct rebase_options *o
       
      -static int rebase_config(const char *var, const char *value, void *data)
      +static int rebase_config(const char *var, const char *value,
     -+			 struct key_value_info *kvi, void *data)
     ++			 const struct config_context *ctx, void *data)
       {
       	struct rebase_options *opts = data;
       
     @@ builtin/rebase.c: static int rebase_config(const char *var, const char *value, v
       	}
       
      -	return git_default_config(var, value, data);
     -+	return git_default_config(var, value,kvi, data);
     ++	return git_default_config(var, value, ctx, data);
       }
       
       static int checkout_up_to_date(struct rebase_options *options)
     @@ builtin/receive-pack.c: static enum deny_action parse_deny_action(const char *va
       
      -static int receive_pack_config(const char *var, const char *value, void *cb)
      +static int receive_pack_config(const char *var, const char *value,
     -+			       struct key_value_info *kvi, void *cb)
     ++			       const struct config_context *ctx, void *cb)
       {
       	int status = parse_hide_refs_config(var, value, "receive", &hidden_refs);
       
     @@ builtin/receive-pack.c: static int receive_pack_config(const char *var, const ch
       	}
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       static void show_ref(const char *path, const struct object_id *oid)
     @@ builtin/reflog.c: static struct reflog_expire_cfg *find_cfg_ent(const char *patt
       
      -static int reflog_expire_config(const char *var, const char *value, void *cb)
      +static int reflog_expire_config(const char *var, const char *value,
     -+				struct key_value_info *kvi, void *cb)
     ++				const struct config_context *ctx, void *cb)
       {
       	const char *pattern, *key;
       	size_t pattern_len;
     @@ builtin/reflog.c: static int reflog_expire_config(const char *var, const char *v
       
       	if (parse_config_key(var, "gc", &pattern, &pattern_len, &key) < 0)
      -		return git_default_config(var, value, cb);
     -+		return git_default_config(var, value,kvi, cb);
     ++		return git_default_config(var, value, ctx, cb);
       
       	if (!strcmp(key, "reflogexpire")) {
       		slot = EXPIRE_TOTAL;
     @@ builtin/reflog.c: static int reflog_expire_config(const char *var, const char *v
       			return -1;
       	} else
      -		return git_default_config(var, value, cb);
     -+		return git_default_config(var, value,kvi, cb);
     ++		return git_default_config(var, value, ctx, cb);
       
       	if (!pattern) {
       		switch (slot) {
     @@ builtin/remote.c: static const char *abbrev_ref(const char *name, const char *pr
       #define abbrev_branch(name) abbrev_ref((name), "refs/heads/")
       
       static int config_read_branches(const char *key, const char *value,
     -+				struct key_value_info *kvi UNUSED,
     ++				const struct config_context *ctx UNUSED,
       				void *data UNUSED)
       {
       	const char *orig_key = key;
     @@ builtin/remote.c: struct push_default_info
       
       static int config_read_push_default(const char *key, const char *value,
      -	void *cb)
     -+	struct key_value_info *kvi UNUSED, void *cb)
     ++	const struct config_context *ctx UNUSED, void *cb)
       {
       	struct push_default_info* info = cb;
       	if (strcmp(key, "remote.pushdefault") ||
     @@ builtin/remote.c: static int prune(int argc, const char **argv, const char *pref
       
      -static int get_remote_default(const char *key, const char *value UNUSED, void *priv)
      +static int get_remote_default(const char *key, const char *value UNUSED,
     -+			      struct key_value_info *kvi UNUSED, void *priv)
     ++			      const struct config_context *ctx UNUSED,
     ++			      void *priv)
       {
       	if (strcmp(key, "remotes.default") == 0) {
       		int *found = priv;
     @@ builtin/repack.c: struct pack_objects_args {
       
      -static int repack_config(const char *var, const char *value, void *cb)
      +static int repack_config(const char *var, const char *value,
     -+			 struct key_value_info *kvi, void *cb)
     ++			 const struct config_context *ctx, void *cb)
       {
       	struct pack_objects_args *cruft_po_args = cb;
       	if (!strcmp(var, "repack.usedeltabaseoffset")) {
     @@ builtin/repack.c: static int repack_config(const char *var, const char *value, v
       	if (!strcmp(var, "repack.cruftthreads"))
       		return git_config_string(&cruft_po_args->threads, var, value);
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       /*
     @@ builtin/reset.c: static int reset_refs(const char *rev, const struct object_id *
       
      -static int git_reset_config(const char *var, const char *value, void *cb)
      +static int git_reset_config(const char *var, const char *value,
     -+			    struct key_value_info *kvi, void *cb)
     ++			    const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "submodule.recurse"))
       		return git_default_submodule_config(var, value, cb);
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       int cmd_reset(int argc, const char **argv, const char *prefix)
     @@ builtin/send-pack.c: static void print_helper_status(struct ref *ref)
       
      -static int send_pack_config(const char *k, const char *v, void *cb)
      +static int send_pack_config(const char *k, const char *v,
     -+			    struct key_value_info *kvi, void *cb)
     ++			    const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(k, "push.gpgsign")) {
       		const char *value;
     @@ builtin/send-pack.c: static int send_pack_config(const char *k, const char *v, v
       		}
       	}
      -	return git_default_config(k, v, cb);
     -+	return git_default_config(k, v,kvi, cb);
     ++	return git_default_config(k, v, ctx, cb);
       }
       
       int cmd_send_pack(int argc, const char **argv, const char *prefix)
     @@ builtin/show-branch.c: static void append_one_rev(const char *av)
       
      -static int git_show_branch_config(const char *var, const char *value, void *cb)
      +static int git_show_branch_config(const char *var, const char *value,
     -+				  struct key_value_info *kvi, void *cb)
     ++				  const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "showbranch.default")) {
       		if (!value)
     @@ builtin/show-branch.c: static int git_show_branch_config(const char *var, const
       		return -1;
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       static int omit_in_dense(struct commit *commit, struct commit **rev, int n)
     @@ builtin/stash.c: static int show_stat = 1;
       
      -static int git_stash_config(const char *var, const char *value, void *cb)
      +static int git_stash_config(const char *var, const char *value,
     -+			    struct key_value_info *kvi, void *cb)
     ++			    const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "stash.showstat")) {
       		show_stat = git_config_bool(var, value);
     @@ builtin/stash.c: static int git_stash_config(const char *var, const char *value,
       		return 0;
       	}
      -	return git_diff_basic_config(var, value, cb);
     -+	return git_diff_basic_config(var, value,kvi, cb);
     ++	return git_diff_basic_config(var, value, ctx, cb);
       }
       
       static void diff_include_untracked(const struct stash_info *info, struct diff_options *diff_opt)
     @@ builtin/submodule--helper.c: static int update_clone_task_finished(int result,
       }
       
       static int git_update_clone_config(const char *var, const char *value,
     -+				   struct key_value_info *kvi UNUSED,
     ++				   const struct config_context *ctx UNUSED,
       				   void *cb)
       {
       	int *max_jobs = cb;
     @@ builtin/tag.c: static const char tag_template_nocleanup[] =
       
      -static int git_tag_config(const char *var, const char *value, void *cb)
      +static int git_tag_config(const char *var, const char *value,
     -+			  struct key_value_info *kvi, void *cb)
     ++			  const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "tag.gpgsign")) {
       		config_sign_tag = git_config_bool(var, value);
     @@ builtin/tag.c: static int git_tag_config(const char *var, const char *value, voi
       		return -1;
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       static void write_tag_body(int fd, const struct object_id *oid)
     @@ builtin/var.c: static const struct git_var *get_git_var(const char *var)
       
      -static int show_config(const char *var, const char *value, void *cb)
      +static int show_config(const char *var, const char *value,
     -+		       struct key_value_info *kvi, void *cb)
     ++		       const struct config_context *ctx, void *cb)
       {
       	if (value)
       		printf("%s=%s\n", var, value);
       	else
       		printf("%s\n", var);
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       int cmd_var(int argc, const char **argv, const char *prefix UNUSED)
     @@ builtin/worktree.c: static int verbose;
       
      -static int git_worktree_config(const char *var, const char *value, void *cb)
      +static int git_worktree_config(const char *var, const char *value,
     -+			       struct key_value_info *kvi, void *cb)
     ++			       const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "worktree.guessremote")) {
       		guess_remote = git_config_bool(var, value);
     @@ builtin/worktree.c: static int verbose;
       	}
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       static int delete_git_dir(const char *id)
     @@ bundle-uri.c: static int bundle_list_update(const char *key, const char *value,
       
      -static int config_to_bundle_list(const char *key, const char *value, void *data)
      +static int config_to_bundle_list(const char *key, const char *value,
     -+				 struct key_value_info *kvi UNUSED,
     ++				 const struct config_context *ctx UNUSED,
      +				 void *data)
       {
       	struct bundle_list *list = data;
     @@ bundle-uri.c: cached:
       
      -static int config_to_packet_line(const char *key, const char *value, void *data)
      +static int config_to_packet_line(const char *key, const char *value,
     -+				 struct key_value_info *kvi UNUSED,
     ++				 const struct config_context *ctx UNUSED,
      +				 void *data)
       {
       	struct packet_reader *writer = data;
       
      
     + ## compat/mingw.c ##
     +@@ compat/mingw.c: static int core_restrict_inherited_handles = -1;
     + static enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
     + static char *unset_environment_variables;
     + 
     +-int mingw_core_config(const char *var, const char *value, void *cb)
     ++int mingw_core_config(const char *var, const char *value,
     ++		      const struct config_context *ctx, void *cb)
     + {
     + 	if (!strcmp(var, "core.hidedotfiles")) {
     + 		if (value && !strcasecmp(value, "dotgitonly"))
     +
     + ## compat/mingw.h ##
     +@@ compat/mingw.h: typedef _sigset_t sigset_t;
     + #undef _POSIX_THREAD_SAFE_FUNCTIONS
     + #endif
     + 
     +-int mingw_core_config(const char *var, const char *value, void *cb);
     ++struct config_context;
     ++int mingw_core_config(const char *var, const char *value,
     ++		      const struct config_context *ctx, void *cb);
     + #define platform_core_config mingw_core_config
     + 
     + /*
     +
       ## config.c ##
      @@ config.c: struct config_include_data {
       };
     @@ config.c: struct config_include_data {
       
      -static int git_config_include(const char *var, const char *value, void *data);
      +static int git_config_include(const char *var, const char *value,
     -+			      struct key_value_info *kvi, void *data);
     ++			      const struct config_context *ctx, void *data);
       
       #define MAX_INCLUDE_DEPTH 10
       static const char include_depth_advice[] = N_(
     @@ config.c: static int include_by_branch(const char *cond, size_t cond_len)
       
      -static int add_remote_url(const char *var, const char *value, void *data)
      +static int add_remote_url(const char *var, const char *value,
     -+			  struct key_value_info *kvi UNUSED, void *data)
     ++			  const struct config_context *ctx UNUSED, void *data)
       {
       	struct string_list *remote_urls = data;
       	const char *remote_name;
     @@ config.c: static void populate_remote_urls(struct config_include_data *inc)
       }
       
       static int forbid_remote_url(const char *var, const char *value UNUSED,
     -+			     struct key_value_info *kvi UNUSED,
     ++			     const struct config_context *ctx UNUSED,
       			     void *data UNUSED)
       {
       	const char *remote_name;
     @@ config.c: static int include_condition_is_true(struct config_source *cs,
       
      -static int git_config_include(const char *var, const char *value, void *data)
      +static int git_config_include(const char *var, const char *value,
     -+			      struct key_value_info *kvi UNUSED, void *data)
     ++			      const struct config_context *ctx,
     ++			      void *data)
       {
       	struct config_include_data *inc = data;
       	struct config_source *cs = inc->config_reader->source;
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
     + 	return ret;
     + }
     +@@ config.c: static int get_value(struct config_source *cs, config_fn_t fn, void *data,
     + 	 * accurate line number in error messages.
     + 	 */
     + 	cs->linenr--;
     +-	ret = fn(name->buf, value, data);
     ++	ret = fn(name->buf, value, NULL, data);
     + 	if (ret >= 0)
     + 		cs->linenr++;
     + 	return ret;
      @@ config.c: int git_config_color(char *dest, const char *var, const char *value)
       	return 0;
       }
       
      -static int git_default_core_config(const char *var, const char *value, void *cb)
      +static int git_default_core_config(const char *var, const char *value,
     -+				   struct key_value_info *kvi, void *cb)
     ++				   const struct config_context *ctx, void *cb)
       {
       	/* This needs a better name */
       	if (!strcmp(var, "core.filemode")) {
     @@ config.c: static int git_default_core_config(const char *var, const char *value,
       
       	/* Add other config variables here and to Documentation/config.txt. */
      -	return platform_core_config(var, value, cb);
     -+	return platform_core_config(var, value,kvi, cb);
     ++	return platform_core_config(var, value, ctx, cb);
       }
       
       static int git_default_sparse_config(const char *var, const char *value)
     @@ config.c: static int git_default_mailmap_config(const char *var, const char *val
       
      -int git_default_config(const char *var, const char *value, void *cb)
      +int git_default_config(const char *var, const char *value,
     -+		       struct key_value_info *kvi, void *cb)
     ++		       const struct config_context *ctx, void *cb)
       {
       	if (starts_with(var, "core."))
      -		return git_default_core_config(var, value, cb);
     -+		return git_default_core_config(var, value,kvi, cb);
     ++		return git_default_core_config(var, value, ctx, cb);
       
       	if (starts_with(var, "user.") ||
       	    starts_with(var, "author.") ||
       	    starts_with(var, "committer."))
      -		return git_ident_config(var, value, cb);
     -+		return git_ident_config(var, value,kvi, cb);
     ++		return git_ident_config(var, value, ctx, cb);
       
       	if (starts_with(var, "i18n."))
       		return git_default_i18n_config(var, value);
     +@@ config.c: static void configset_iter(struct config_reader *reader, struct config_set *set,
     + 
     + 		config_reader_set_kvi(reader, values->items[value_index].util);
     + 
     +-		if (fn(entry->key, values->items[value_index].string, data) < 0)
     ++		if (fn(entry->key, values->items[value_index].string, NULL, data) < 0)
     + 			git_die_config_linenr(entry->key,
     + 					      reader->config_kvi->filename,
     + 					      reader->config_kvi->linenr);
      @@ config.c: struct configset_add_data {
       };
       #define CONFIGSET_ADD_INIT { 0 }
       
      -static int config_set_callback(const char *key, const char *value, void *cb)
      +static int config_set_callback(const char *key, const char *value,
     -+			       struct key_value_info *kvi UNUSED, void *cb)
     ++			       const struct config_context *ctx UNUSED,
     ++			       void *cb)
       {
       	struct configset_add_data *data = cb;
       	configset_add_value(data->config_reader, data->config_set, key, value);
     @@ config.c: static int store_aux_event(enum config_event_t type,
       
      -static int store_aux(const char *key, const char *value, void *cb)
      +static int store_aux(const char *key, const char *value,
     -+		     struct key_value_info *kvi UNUSED, void *cb)
     ++		     const struct config_context *ctx UNUSED, void *cb)
       {
       	struct config_store_data *store = cb;
       
      
       ## config.h ##
     -@@ config.h: struct key_value_info {
     +@@ config.h: struct config_options {
     + 	} error_action;
     + };
     + 
     ++/* Config source metadata for a given config key-value pair */
     ++struct key_value_info {
     ++	const char *filename;
     ++	int linenr;
     ++	enum config_origin_type origin_type;
     ++	enum config_scope scope;
     ++};
     ++#define KVI_INIT { \
     ++	.filename = NULL, \
     ++	.linenr = -1, \
     ++	.origin_type = CONFIG_ORIGIN_UNKNOWN, \
     ++	.scope = CONFIG_SCOPE_UNKNOWN, \
     ++}
     ++
     ++/* Captures additional information that a config callback can use. */
     ++struct config_context {
     ++	/* Config source metadata for key and value. */
     ++	const struct key_value_info *kvi;
     ++};
     ++#define CONFIG_CONTEXT_INIT { 0 }
     ++
     + /**
     +- * A config callback function takes three parameters:
     ++ * A config callback function takes four parameters:
     +  *
     +  * - the name of the parsed variable. This is in canonical "flat" form: the
     +  *   section, subsection, and variable segments will be separated by dots,
     +@@ config.h: struct config_options {
     +  *   value specified, the value will be NULL (typically this means it
     +  *   should be interpreted as boolean true).
     +  *
     ++ * - the 'config context', that is, additional information about the config
     ++ *   iteration operation provided by the config machinery. For example, this
     ++ *   includes information about the config source being parsed (e.g. the
     ++ *   filename).
     ++ *
     +  * - a void pointer passed in by the caller of the config API; this can
     +  *   contain callback-specific data
     +  *
     +  * A config callback should return 0 for success, or -1 if the variable
     +  * could not be parsed properly.
        */
     - typedef int (*config_fn_t)(const char *, const char *, struct key_value_info *, void *);
     +-typedef int (*config_fn_t)(const char *, const char *, void *);
     ++typedef int (*config_fn_t)(const char *, const char *,
     ++			   const struct config_context *, void *);
       
      -int git_default_config(const char *, const char *, void *);
     -+int git_default_config(const char *, const char *, struct key_value_info *,
     -+		       void *);
     ++int git_default_config(const char *, const char *,
     ++		       const struct config_context *, void *);
       
       /**
        * Read a specific file in git-config format.
     +@@ config.h: int git_config_get_expiry(const char *key, const char **output);
     + /* parse either "this many days" integer, or "5.days.ago" approxidate */
     + int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestamp_t now);
     + 
     +-struct key_value_info {
     +-	const char *filename;
     +-	int linenr;
     +-	enum config_origin_type origin_type;
     +-	enum config_scope scope;
     +-};
     +-
     + /**
     +  * First prints the error message specified by the caller in `err` and then
     +  * dies printing the line number and the file name of the highest priority
      
       ## connect.c ##
      @@ connect.c: static struct child_process *git_tcp_connect(int fd[2], char *host, int flags)
     @@ connect.c: static struct child_process *git_tcp_connect(int fd[2], char *host, i
       
       static int git_proxy_command_options(const char *var, const char *value,
      -		void *cb)
     -+		struct key_value_info *kvi, void *cb)
     ++		const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "core.gitproxy")) {
       		const char *for_pos;
     @@ connect.c: static int git_proxy_command_options(const char *var, const char *val
       	}
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       static int git_use_proxy(const char *host)
      
     + ## contrib/coccinelle/config_fn_ctx.pending.cocci (new) ##
     +@@
     ++@ get_fn @
     ++identifier fn, R;
     ++@@
     ++(
     ++(
     ++git_config_from_file
     ++|
     ++git_config_from_file_with_options
     ++|
     ++git_config_from_mem
     ++|
     ++git_config_from_blob_oid
     ++|
     ++read_early_config
     ++|
     ++read_very_early_config
     ++|
     ++config_with_options
     ++|
     ++git_config
     ++|
     ++git_protected_config
     ++|
     ++config_from_gitmodules
     ++)
     ++  (fn, ...)
     ++|
     ++repo_config(R, fn, ...)
     ++)
     ++
     ++@ extends get_fn @
     ++identifier C1, C2, D;
     ++@@
     ++int fn(const char *C1, const char *C2,
     +++ const struct config_context *ctx,
     ++  void *D);
     ++
     ++@ extends get_fn @
     ++@@
     ++int fn(const char *, const char *,
     +++ const struct config_context *,
     ++  void *);
     ++
     ++@ extends get_fn @
     ++// Don't change fns that look like callback fns but aren't
     ++identifier fn2 != tar_filter_config && != git_diff_heuristic_config &&
     ++  != git_default_submodule_config && != git_color_config &&
     ++  != bundle_list_update && != parse_object_filter_config;
     ++identifier C1, C2, D1, D2, S;
     ++attribute name UNUSED;
     ++@@
     ++int fn(const char *C1, const char *C2,
     +++ const struct config_context *ctx,
     ++  void *D1) {
     ++<+...
     ++(
     ++fn2(C1, C2
     +++ , ctx
     ++, D2);
     ++|
     ++if(fn2(C1, C2
     +++ , ctx
     ++, D2) < 0) { ... }
     ++|
     ++return fn2(C1, C2
     +++ , ctx
     ++, D2);
     ++|
     ++S = fn2(C1, C2
     +++ , ctx
     ++, D2);
     ++)
     ++...+>
     ++  }
     ++
     ++@ extends get_fn@
     ++identifier C1, C2, D;
     ++attribute name UNUSED;
     ++@@
     ++int fn(const char *C1, const char *C2,
     +++ const struct config_context *ctx UNUSED,
     ++  void *D) {...}
     ++
     ++
     ++// The previous rules don't catch all callbacks, especially if they're defined
     ++// in a separate file from the git_config() call. Fix these manually.
     ++@@
     ++identifier C1, C2, D;
     ++attribute name UNUSED;
     ++@@
     ++int
     ++(
     ++git_ident_config
     ++|
     ++urlmatch_collect_fn
     ++|
     ++write_one_config
     ++|
     ++forbid_remote_url
     ++|
     ++credential_config_callback
     ++)
     ++  (const char *C1, const char *C2,
     +++ const struct config_context *ctx UNUSED,
     ++  void *D) {...}
     ++
     ++@@
     ++identifier C1, C2, D, D2, S, fn2;
     ++@@
     ++int
     ++(
     ++http_options
     ++|
     ++git_status_config
     ++|
     ++git_commit_config
     ++|
     ++git_default_core_config
     ++|
     ++grep_config
     ++)
     ++  (const char *C1, const char *C2,
     +++ const struct config_context *ctx,
     ++  void *D) {
     ++<+...
     ++(
     ++fn2(C1, C2
     +++ , ctx
     ++, D2);
     ++|
     ++if(fn2(C1, C2
     +++ , ctx
     ++, D2) < 0) { ... }
     ++|
     ++return fn2(C1, C2
     +++ , ctx
     ++, D2);
     ++|
     ++S = fn2(C1, C2
     +++ , ctx
     ++, D2);
     ++)
     ++...+>
     ++  }
     +
       ## convert.c ##
      @@ convert.c: static int apply_filter(const char *path, const char *src, size_t len,
       	return 0;
     @@ convert.c: static int apply_filter(const char *path, const char *src, size_t len
       
      -static int read_convert_config(const char *var, const char *value, void *cb UNUSED)
      +static int read_convert_config(const char *var, const char *value,
     -+			       struct key_value_info *kvi UNUSED,
     ++			       const struct config_context *ctx UNUSED,
      +			       void *cb UNUSED)
       {
       	const char *key, *name;
     @@ credential.c: static int credential_from_potentially_partial_url(struct credenti
       						   const char *url);
       
       static int credential_config_callback(const char *var, const char *value,
     -+				      struct key_value_info *kvi UNUSED,
     ++				      const struct config_context *ctx UNUSED,
       				      void *data)
       {
       	struct credential *c = data;
     @@ delta-islands.c: static void free_remote_islands(kh_str_t *remote_islands)
       
      -static int island_config_callback(const char *k, const char *v, void *cb)
      +static int island_config_callback(const char *k, const char *v,
     -+				  struct key_value_info *kvi UNUSED, void *cb)
     ++				  const struct config_context *ctx UNUSED,
     ++				  void *cb)
       {
       	struct island_load_data *ild = cb;
       
     @@ diff.c: static unsigned parse_color_moved_ws(const char *arg)
       
      -int git_diff_ui_config(const char *var, const char *value, void *cb)
      +int git_diff_ui_config(const char *var, const char *value,
     -+		       struct key_value_info *kvi, void *cb)
     ++		       const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
       		diff_use_color_default = git_config_colorbool(var, value);
     @@ diff.c: int git_diff_ui_config(const char *var, const char *value, void *cb)
       		return -1;
       
      -	return git_diff_basic_config(var, value, cb);
     -+	return git_diff_basic_config(var, value,kvi, cb);
     ++	return git_diff_basic_config(var, value, ctx, cb);
       }
       
      -int git_diff_basic_config(const char *var, const char *value, void *cb)
      +int git_diff_basic_config(const char *var, const char *value,
     -+			  struct key_value_info *kvi, void *cb)
     ++			  const struct config_context *ctx, void *cb)
       {
       	const char *name;
       
     @@ diff.c: int git_diff_basic_config(const char *var, const char *value, void *cb)
       		return -1;
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       static char *quote_two(const char *one, const char *two)
     @@ diff.h: void free_diffstat_info(struct diffstat_t *diffstat);
       		   const char **optarg);
       
      -int git_diff_basic_config(const char *var, const char *value, void *cb);
     ++struct config_context;
      +int git_diff_basic_config(const char *var, const char *value,
     -+			  struct key_value_info *kvi, void *cb);
     ++			  const struct config_context *ctx, void *cb);
       int git_diff_heuristic_config(const char *var, const char *value, void *cb);
       void init_diff_ui_defaults(void);
      -int git_diff_ui_config(const char *var, const char *value, void *cb);
      +int git_diff_ui_config(const char *var, const char *value,
     -+		       struct key_value_info *kvi, void *cb);
     ++		       const struct config_context *ctx, void *cb);
       void repo_diff_setup(struct repository *, struct diff_options *);
       struct option *add_diff_options(const struct option *, struct diff_options *);
       int diff_opt_parse(struct diff_options *, const char **, int, const char *);
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
       
      -static int fetch_pack_config_cb(const char *var, const char *value, void *cb)
      +static int fetch_pack_config_cb(const char *var, const char *value,
     -+				struct key_value_info *kvi, void *cb)
     ++				const struct config_context *ctx, void *cb)
       {
       	if (strcmp(var, "fetch.fsck.skiplist") == 0) {
       		const char *path;
     @@ fetch-pack.c: static int fetch_pack_config_cb(const char *var, const char *value
       	}
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       static void fetch_pack_config(void)
     @@ fmt-merge-msg.c: static int use_branch_desc;
       
      -int fmt_merge_msg_config(const char *key, const char *value, void *cb)
      +int fmt_merge_msg_config(const char *key, const char *value,
     -+			 struct key_value_info *kvi, void *cb)
     ++			 const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
       		int is_bool;
     @@ fmt-merge-msg.c: int fmt_merge_msg_config(const char *key, const char *value, vo
       		suppress_dest_pattern_seen = 1;
       	} else {
      -		return git_default_config(key, value, cb);
     -+		return git_default_config(key, value,kvi, cb);
     ++		return git_default_config(key, value, ctx, cb);
       	}
       	return 0;
       }
     @@ fmt-merge-msg.h: struct fmt_merge_msg_opts {
       extern int merge_log_config;
      -int fmt_merge_msg_config(const char *key, const char *value, void *cb);
      +int fmt_merge_msg_config(const char *key, const char *value,
     -+			 struct key_value_info *kvi, void *cb);
     ++			 const struct config_context *ctx, void *cb);
       int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
       		  struct fmt_merge_msg_opts *);
       
     @@ fsck.c: struct fsck_gitmodules_data {
       
      -static int fsck_gitmodules_fn(const char *var, const char *value, void *vdata)
      +static int fsck_gitmodules_fn(const char *var, const char *value,
     -+			      struct key_value_info *kvi UNUSED, void *vdata)
     ++			      const struct config_context *ctx UNUSED,
     ++			      void *vdata)
       {
       	struct fsck_gitmodules_data *data = vdata;
       	const char *subsection, *key;
     @@ fsck.c: int fsck_finish(struct fsck_options *options)
       
      -int git_fsck_config(const char *var, const char *value, void *cb)
      +int git_fsck_config(const char *var, const char *value,
     -+		    struct key_value_info *kvi, void *cb)
     ++		    const struct config_context *ctx, void *cb)
       {
       	struct fsck_options *options = cb;
       	if (strcmp(var, "fsck.skiplist") == 0) {
     @@ fsck.c: int git_fsck_config(const char *var, const char *value, void *cb)
       	}
       
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
       
       /*
      
       ## fsck.h ##
     -@@ fsck.h: const char *fsck_describe_object(struct fsck_options *options,
     +@@ fsck.h: void fsck_put_object_name(struct fsck_options *options,
     + const char *fsck_describe_object(struct fsck_options *options,
     + 				 const struct object_id *oid);
     + 
     ++struct key_value_info;
     + /*
        * git_config() callback for use by fsck-y tools that want to support
        * fsck.<msg> fsck.skipList etc.
        */
      -int git_fsck_config(const char *var, const char *value, void *cb);
      +int git_fsck_config(const char *var, const char *value,
     -+		    struct key_value_info *kvi, void *cb);
     ++		    const struct config_context *ctx, void *cb);
       
       #endif
      
     + ## git-compat-util.h ##
     +@@ git-compat-util.h: typedef uintmax_t timestamp_t;
     + #endif
     + 
     + #ifndef platform_core_config
     ++struct config_context;
     + static inline int noop_core_config(const char *var UNUSED,
     + 				   const char *value UNUSED,
     ++				   const struct config_context *ctx UNUSED,
     + 				   void *cb UNUSED)
     + {
     + 	return 0;
     +
       ## gpg-interface.c ##
      @@
       #include "alias.h"
       #include "wrapper.h"
       
      -static int git_gpg_config(const char *, const char *, void *);
     -+static int git_gpg_config(const char *, const char *, struct key_value_info *,
     -+			  void *);
     ++static int git_gpg_config(const char *, const char *,
     ++			  const struct config_context *, void *);
       
       static void gpg_interface_lazy_init(void)
       {
     @@ gpg-interface.c: void set_signing_key(const char *key)
       
      -static int git_gpg_config(const char *var, const char *value, void *cb UNUSED)
      +static int git_gpg_config(const char *var, const char *value,
     -+			  struct key_value_info *kvi UNUSED, void *cb UNUSED)
     ++			  const struct config_context *ctx UNUSED,
     ++			  void *cb UNUSED)
       {
       	struct gpg_format *fmt = NULL;
       	char *fmtname = NULL;
     @@ grep.c: define_list_config_array_extra(color_grep_slots, {"match"});
        */
      -int grep_config(const char *var, const char *value, void *cb)
      +int grep_config(const char *var, const char *value,
     -+		struct key_value_info *kvi UNUSED, void *cb)
     ++		const struct config_context *ctx, void *cb)
       {
       	struct grep_opt *opt = cb;
       	const char *slot;
     +@@ grep.c: int grep_config(const char *var, const char *value, void *cb)
     + 	if (!strcmp(var, "color.grep"))
     + 		opt->color = git_config_colorbool(var, value);
     + 	if (!strcmp(var, "color.grep.match")) {
     +-		if (grep_config("color.grep.matchcontext", value, cb) < 0)
     ++		if (grep_config("color.grep.matchcontext", value, ctx, cb) < 0)
     + 			return -1;
     +-		if (grep_config("color.grep.matchselected", value, cb) < 0)
     ++		if (grep_config("color.grep.matchselected", value, ctx, cb) < 0)
     + 			return -1;
     + 	} else if (skip_prefix(var, "color.grep.", &slot)) {
     + 		int i = LOOKUP_CONFIG(color_grep_slots, slot);
     +
     + ## grep.h ##
     +@@ grep.h: struct grep_opt {
     + 	.output = std_output, \
     + }
     + 
     +-int grep_config(const char *var, const char *value, void *);
     ++struct config_context;
     ++int grep_config(const char *var, const char *value,
     ++		const struct config_context *ctx, void *data);
     + void grep_init(struct grep_opt *, struct repository *repo);
     + 
     + void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
      
       ## help.c ##
      @@ help.c: void load_command_list(const char *prefix,
     @@ help.c: void load_command_list(const char *prefix,
       
      -static int get_colopts(const char *var, const char *value, void *data)
      +static int get_colopts(const char *var, const char *value,
     -+		       struct key_value_info *kvi UNUSED, void *data)
     ++		       const struct config_context *ctx UNUSED, void *data)
       {
       	unsigned int *colopts = data;
       
     @@ help.c: void list_developer_interfaces_help(void)
       
      -static int get_alias(const char *var, const char *value, void *data)
      +static int get_alias(const char *var, const char *value,
     -+		     struct key_value_info *kvi UNUSED, void *data)
     ++		     const struct config_context *ctx UNUSED, void *data)
       {
       	struct string_list *list = data;
       
     @@ help.c: static struct cmdnames aliases;
       #define AUTOCORRECT_IMMEDIATELY (-1)
       
       static int git_unknown_cmd_config(const char *var, const char *value,
     -+				  struct key_value_info *kvi UNUSED,
     ++				  const struct config_context *ctx UNUSED,
       				  void *cb UNUSED)
       {
       	const char *p;
      
     + ## http.c ##
     +@@ http.c: static void process_curl_messages(void)
     + 	}
     + }
     + 
     +-static int http_options(const char *var, const char *value, void *cb)
     ++static int http_options(const char *var, const char *value,
     ++			const struct config_context *ctx, void *data)
     + {
     + 	if (!strcmp("http.version", var)) {
     + 		return git_config_string(&curl_http_version, var, value);
     +@@ http.c: static int http_options(const char *var, const char *value, void *cb)
     + 	}
     + 
     + 	/* Fall back on the default ones */
     +-	return git_default_config(var, value, cb);
     ++	return git_default_config(var, value, ctx, data);
     + }
     + 
     + static int curl_empty_auth_enabled(void)
     +
       ## ident.c ##
      @@ ident.c: static int set_ident(const char *var, const char *value)
       	return 0;
     @@ ident.c: static int set_ident(const char *var, const char *value)
       
      -int git_ident_config(const char *var, const char *value, void *data UNUSED)
      +int git_ident_config(const char *var, const char *value,
     -+		     struct key_value_info *kvi UNUSED, void *data UNUSED)
     ++		     const struct config_context *ctx UNUSED,
     ++		     void *data UNUSED)
       {
       	if (!strcmp(var, "user.useconfigonly")) {
       		ident_use_config_only = git_config_bool(var, value);
     @@ ident.h: const char *fmt_name(enum want_ident);
       int author_ident_sufficiently_given(void);
       
      -int git_ident_config(const char *, const char *, void *);
     -+int git_ident_config(const char *, const char *,
     -+		     struct key_value_info *UNUSED, void *);
     ++struct config_context;
     ++int git_ident_config(const char *, const char *, const struct config_context *,
     ++		     void *);
       
       #endif
      
     @@ imap-send.c: static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, i
       
      -static int git_imap_config(const char *var, const char *val, void *cb)
      +static int git_imap_config(const char *var, const char *val,
     -+			   struct key_value_info *kvi, void *cb)
     ++			   const struct config_context *ctx, void *cb)
       {
       
       	if (!strcmp("imap.sslverify", var))
     @@ imap-send.c: static int git_imap_config(const char *var, const char *val, void *
       		}
       	} else
      -		return git_default_config(var, val, cb);
     -+		return git_default_config(var, val,kvi, cb);
     ++		return git_default_config(var, val, ctx, cb);
       
       	return 0;
       }
     @@ ll-merge.c: static struct ll_merge_driver *ll_user_merge, **ll_user_merge_tail;
       static const char *default_ll_merge;
       
       static int read_merge_config(const char *var, const char *value,
     -+			     struct key_value_info *kvi UNUSED,
     ++			     const struct config_context *ctx UNUSED,
       			     void *cb UNUSED)
       {
       	struct ll_merge_driver *fn;
     @@ ls-refs.c: static void send_possibly_unborn_head(struct ls_refs_data *data)
       }
       
       static int ls_refs_config(const char *var, const char *value,
     --			  void *cb_data)
     -+			  struct key_value_info *kvi UNUSED, void *cb_data)
     ++			  const struct config_context *ctx UNUSED,
     + 			  void *cb_data)
       {
       	struct ls_refs_data *data = cb_data;
     - 	/*
      
       ## mailinfo.c ##
      @@ mailinfo.c: int mailinfo_parse_quoted_cr_action(const char *actionstr, int *action)
     @@ mailinfo.c: int mailinfo_parse_quoted_cr_action(const char *actionstr, int *acti
       
      -static int git_mailinfo_config(const char *var, const char *value, void *mi_)
      +static int git_mailinfo_config(const char *var, const char *value,
     -+			       struct key_value_info *kvi, void *mi_)
     ++			       const struct config_context *ctx, void *mi_)
       {
       	struct mailinfo *mi = mi_;
       
       	if (!starts_with(var, "mailinfo."))
      -		return git_default_config(var, value, NULL);
     -+		return git_default_config(var, value,kvi, NULL);
     ++		return git_default_config(var, value, ctx, NULL);
       	if (!strcmp(var, "mailinfo.scissors")) {
       		mi->use_scissors = git_config_bool(var, value);
       		return 0;
     @@ notes-utils.c: static combine_notes_fn parse_combine_notes_fn(const char *v)
       
      -static int notes_rewrite_config(const char *k, const char *v, void *cb)
      +static int notes_rewrite_config(const char *k, const char *v,
     -+				struct key_value_info *kvi UNUSED, void *cb)
     ++				const struct config_context *ctx UNUSED,
     ++				void *cb)
       {
       	struct notes_rewrite_cfg *c = cb;
       	if (starts_with(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
     @@ notes.c: void string_list_add_refs_from_colon_sep(struct string_list *list,
       
      -static int notes_display_config(const char *k, const char *v, void *cb)
      +static int notes_display_config(const char *k, const char *v,
     -+				struct key_value_info *kvi UNUSED, void *cb)
     ++				const struct config_context *ctx UNUSED,
     ++				void *cb)
       {
       	int *load_refs = cb;
       
     @@ pager.c: static void wait_for_pager_signal(int signo)
       }
       
       static int core_pager_config(const char *var, const char *value,
     -+			     struct key_value_info *kvi UNUSED,
     ++			     const struct config_context *ctx UNUSED,
       			     void *data UNUSED)
       {
       	if (!strcmp(var, "core.pager"))
     @@ pager.c: struct pager_command_config_data {
       
      -static int pager_command_config(const char *var, const char *value, void *vdata)
      +static int pager_command_config(const char *var, const char *value,
     -+				struct key_value_info *kvi UNUSED,
     ++				const struct config_context *ctx UNUSED,
      +				void *vdata)
       {
       	struct pager_command_config_data *data = vdata;
     @@ pretty.c: static void save_user_format(struct rev_info *rev, const char *cp, int
       }
       
       static int git_pretty_formats_config(const char *var, const char *value,
     -+				     struct key_value_info *kvi UNUSED,
     ++				     const struct config_context *ctx UNUSED,
       				     void *cb UNUSED)
       {
       	struct cmt_fmt_map *commit_format = NULL;
     @@ promisor-remote.c: static void promisor_remote_move_to_tail(struct promisor_remo
       
      -static int promisor_remote_config(const char *var, const char *value, void *data)
      +static int promisor_remote_config(const char *var, const char *value,
     -+				  struct key_value_info *kvi UNUSED,
     ++				  const struct config_context *ctx UNUSED,
      +				  void *data)
       {
       	struct promisor_remote_config *config = data;
     @@ remote.c: static void read_branches_file(struct remote_state *remote_state,
       
      -static int handle_config(const char *key, const char *value, void *cb)
      +static int handle_config(const char *key, const char *value,
     -+			 struct key_value_info *kvi UNUSED, void *cb)
     ++			 const struct config_context *ctx UNUSED, void *cb)
       {
       	const char *name;
       	size_t namelen;
     @@ revision.c: struct exclude_hidden_refs_cb {
       
      -static int hide_refs_config(const char *var, const char *value, void *cb_data)
      +static int hide_refs_config(const char *var, const char *value,
     -+			    struct key_value_info *kvi UNUSED, void *cb_data)
     ++			    const struct config_context *ctx UNUSED,
     ++			    void *cb_data)
       {
       	struct exclude_hidden_refs_cb *cb = cb_data;
       	cb->exclusions->hidden_refs_configured = 1;
     @@ scalar.c: static int cmd_register(int argc, const char **argv)
       
      -static int get_scalar_repos(const char *key, const char *value, void *data)
      +static int get_scalar_repos(const char *key, const char *value,
     -+			    struct key_value_info *kvi UNUSED, void *data)
     ++			    const struct config_context *ctx UNUSED,
     ++			    void *data)
       {
       	struct string_list *list = data;
       
     @@ sequencer.c: static struct update_ref_record *init_update_ref_record(const char
       
      -static int git_sequencer_config(const char *k, const char *v, void *cb)
      +static int git_sequencer_config(const char *k, const char *v,
     -+				struct key_value_info *kvi, void *cb)
     ++				const struct config_context *ctx, void *cb)
       {
       	struct replay_opts *opts = cb;
       	int status;
     @@ sequencer.c: static int git_sequencer_config(const char *k, const char *v, void
       		opts->commit_use_reference = git_config_bool(k, v);
       
      -	return git_diff_basic_config(k, v, NULL);
     -+	return git_diff_basic_config(k, v,kvi, NULL);
     ++	return git_diff_basic_config(k, v, ctx, NULL);
       }
       
       void sequencer_init_config(struct replay_opts *opts)
     @@ sequencer.c: static int git_config_string_dup(char **dest,
       
      -static int populate_opts_cb(const char *key, const char *value, void *data)
      +static int populate_opts_cb(const char *key, const char *value,
     -+			    struct key_value_info *kvi UNUSED, void *data)
     ++			    const struct config_context *ctx UNUSED,
     ++			    void *data)
       {
       	struct replay_opts *opts = data;
       	int error_flag = 1;
     @@ setup.c: no_prevention_needed:
       
      -static int read_worktree_config(const char *var, const char *value, void *vdata)
      +static int read_worktree_config(const char *var, const char *value,
     -+				struct key_value_info *kvi UNUSED,
     ++				const struct config_context *ctx UNUSED,
      +				void *vdata)
       {
       	struct repository_format *data = vdata;
     @@ setup.c: static enum extension_result handle_extension(const char *var,
       
      -static int check_repo_format(const char *var, const char *value, void *vdata)
      +static int check_repo_format(const char *var, const char *value,
     -+			     struct key_value_info *kvi, void *vdata)
     ++			     const struct config_context *ctx, void *vdata)
       {
       	struct repository_format *data = vdata;
       	const char *ext;
     @@ setup.c: static int check_repo_format(const char *var, const char *value, void *
       	}
       
      -	return read_worktree_config(var, value, vdata);
     -+	return read_worktree_config(var, value,kvi, vdata);
     ++	return read_worktree_config(var, value, ctx, vdata);
       }
       
       static int check_repository_format_gently(const char *gitdir, struct repository_format *candidate, int *nongit_ok)
     @@ setup.c: struct safe_directory_data {
       
      -static int safe_directory_cb(const char *key, const char *value, void *d)
      +static int safe_directory_cb(const char *key, const char *value,
     -+			     struct key_value_info *kvi UNUSED, void *d)
     ++			     const struct config_context *ctx UNUSED, void *d)
       {
       	struct safe_directory_data *data = d;
       
     @@ setup.c: static int ensure_valid_ownership(const char *gitfile,
       
      -static int allowed_bare_repo_cb(const char *key, const char *value, void *d)
      +static int allowed_bare_repo_cb(const char *key, const char *value,
     -+				struct key_value_info *kvi UNUSED, void *d)
     ++				const struct config_context *ctx UNUSED,
     ++				void *d)
       {
       	enum allowed_bare_repo *allowed_bare_repo = d;
       
     @@ submodule-config.c: struct parse_config_parameter {
        */
      -static int parse_config(const char *var, const char *value, void *data)
      +static int parse_config(const char *var, const char *value,
     -+			struct key_value_info *kvi UNUSED, void *data)
     ++			const struct config_context *ctx UNUSED, void *data)
       {
       	struct parse_config_parameter *me = data;
       	struct submodule *submodule;
     @@ submodule-config.c: out:
       
      -static int gitmodules_cb(const char *var, const char *value, void *data)
      +static int gitmodules_cb(const char *var, const char *value,
     -+			 struct key_value_info *kvi UNUSED, void *data)
     ++			 const struct config_context *ctx, void *data)
       {
       	struct repository *repo = data;
       	struct parse_config_parameter parameter;
     +@@ submodule-config.c: static int gitmodules_cb(const char *var, const char *value, void *data)
     + 	parameter.gitmodules_oid = null_oid();
     + 	parameter.overwrite = 1;
     + 
     +-	return parse_config(var, value, &parameter);
     ++	return parse_config(var, value, ctx, &parameter);
     + }
     + 
     + void repo_read_gitmodules(struct repository *repo, int skip_if_read)
      @@ submodule-config.c: void submodule_free(struct repository *r)
       		submodule_cache_clear(r->submodule_cache);
       }
       
      -static int config_print_callback(const char *var, const char *value, void *cb_data)
      +static int config_print_callback(const char *var, const char *value,
     -+				 struct key_value_info *kvi UNUSED,
     ++				 const struct config_context *ctx UNUSED,
      +				 void *cb_data)
       {
       	char *wanted_key = cb_data;
     @@ submodule-config.c: struct fetch_config {
       
      -static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
      +static int gitmodules_fetch_config(const char *var, const char *value,
     -+				   struct key_value_info *kvi UNUSED,
     ++				   const struct config_context *ctx UNUSED,
      +				   void *cb)
       {
       	struct fetch_config *config = cb;
     @@ submodule-config.c: void fetch_config_from_gitmodules(int *max_children, int *re
       }
       
       static int gitmodules_update_clone_config(const char *var, const char *value,
     -+					  struct key_value_info *kvi UNUSED,
     ++					  const struct config_context *ctx UNUSED,
       					  void *cb)
       {
       	int *max_jobs = cb;
     @@ t/helper/test-config.c
       
      -static int iterate_cb(const char *var, const char *value, void *data UNUSED)
      +static int iterate_cb(const char *var, const char *value,
     -+		      struct key_value_info *kvi UNUSED, void *data UNUSED)
     ++		      const struct config_context *ctx UNUSED,
     ++		      void *data UNUSED)
       {
       	static int nr;
       
     @@ t/helper/test-config.c: static int iterate_cb(const char *var, const char *value
       
      -static int parse_int_cb(const char *var, const char *value, void *data)
      +static int parse_int_cb(const char *var, const char *value,
     -+			struct key_value_info *kvi UNUSED, void *data)
     ++			const struct config_context *ctx UNUSED, void *data)
       {
       	const char *key_to_match = data;
       
     @@ t/helper/test-config.c: static int parse_int_cb(const char *var, const char *val
       
      -static int early_config_cb(const char *var, const char *value, void *vdata)
      +static int early_config_cb(const char *var, const char *value,
     -+			   struct key_value_info *kvi UNUSED, void *vdata)
     ++			   const struct config_context *ctx UNUSED,
     ++			   void *vdata)
       {
       	const char *key = vdata;
       
     @@ t/helper/test-userdiff.c: static int driver_cb(struct userdiff_driver *driver,
       
      -static int cmd__userdiff_config(const char *var, const char *value, void *cb UNUSED)
      +static int cmd__userdiff_config(const char *var, const char *value,
     -+				struct key_value_info *kvi UNUSED,
     ++				const struct config_context *ctx UNUSED,
      +				void *cb UNUSED)
       {
       	if (userdiff_config(var, value) < 0)
     @@ trace2/tr2_cfg.c: struct tr2_cfg_data {
        */
      -static int tr2_cfg_cb(const char *key, const char *value, void *d)
      +static int tr2_cfg_cb(const char *key, const char *value,
     -+		      struct key_value_info *kvi UNUSED, void *d)
     ++		      const struct config_context *ctx UNUSED, void *d)
       {
       	struct strbuf **s;
       	struct tr2_cfg_data *data = (struct tr2_cfg_data *)d;
     +@@ trace2/tr2_cfg.c: void tr2_list_env_vars_fl(const char *file, int line)
     + void tr2_cfg_set_fl(const char *file, int line, const char *key,
     + 		    const char *value)
     + {
     ++	struct key_value_info kvi = KVI_INIT;
     ++	struct config_context ctx = {
     ++		.kvi = &kvi,
     ++	};
     + 	struct tr2_cfg_data data = { file, line };
     + 
     + 	if (tr2_cfg_load_patterns() > 0)
     +-		tr2_cfg_cb(key, value, &data);
     ++		tr2_cfg_cb(key, value, &ctx, &data);
     + }
      
       ## trace2/tr2_sysenv.c ##
      @@ trace2/tr2_sysenv.c: static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
     @@ trace2/tr2_sysenv.c: static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
       
      -static int tr2_sysenv_cb(const char *key, const char *value, void *d)
      +static int tr2_sysenv_cb(const char *key, const char *value,
     -+			 struct key_value_info *kvi UNUSED, void *d)
     ++			 const struct config_context *ctx UNUSED, void *d)
       {
       	int k;
       
     @@ trailer.c: static struct {
       };
       
       static int git_trailer_default_config(const char *conf_key, const char *value,
     -+				      struct key_value_info *kvi UNUSED,
     ++				      const struct config_context *ctx UNUSED,
       				      void *cb UNUSED)
       {
       	const char *trailer_item, *variable_name;
     @@ trailer.c: static int git_trailer_default_config(const char *conf_key, const cha
       }
       
       static int git_trailer_config(const char *conf_key, const char *value,
     -+			      struct key_value_info *kvi UNUSED,
     ++			      const struct config_context *ctx UNUSED,
       			      void *cb UNUSED)
       {
       	const char *trailer_item, *variable_name;
     @@ upload-pack.c: static int parse_object_filter_config(const char *var, const char
       
      -static int upload_pack_config(const char *var, const char *value, void *cb_data)
      +static int upload_pack_config(const char *var, const char *value,
     -+			      struct key_value_info *kvi UNUSED,
     ++			      const struct config_context *ctx UNUSED,
      +			      void *cb_data)
       {
       	struct upload_pack_data *data = cb_data;
     @@ upload-pack.c: static int upload_pack_config(const char *var, const char *value,
       
      -static int upload_pack_protected_config(const char *var, const char *value, void *cb_data)
      +static int upload_pack_protected_config(const char *var, const char *value,
     -+					struct key_value_info *kvi UNUSED,
     ++					const struct config_context *ctx UNUSED,
      +					void *cb_data)
       {
       	struct upload_pack_data *data = cb_data;
     @@ urlmatch.c: static int cmp_matches(const struct urlmatch_item *a,
       
      -int urlmatch_config_entry(const char *var, const char *value, void *cb)
      +int urlmatch_config_entry(const char *var, const char *value,
     -+			  struct key_value_info *kvi UNUSED, void *cb)
     ++			  const struct config_context *ctx, void *cb)
       {
       	struct string_list_item *item;
       	struct urlmatch_config *collect = cb;
     +@@ urlmatch.c: int urlmatch_config_entry(const char *var, const char *value, void *cb)
     + 
     + 	if (!skip_prefix(var, collect->section, &key) || *(key++) != '.') {
     + 		if (collect->cascade_fn)
     +-			return collect->cascade_fn(var, value, cb);
     ++			return collect->cascade_fn(var, value, ctx, cb);
     + 		return 0; /* not interested */
     + 	}
     + 	dot = strrchr(key, '.');
     +@@ urlmatch.c: int urlmatch_config_entry(const char *var, const char *value, void *cb)
     + 	strbuf_addstr(&synthkey, collect->section);
     + 	strbuf_addch(&synthkey, '.');
     + 	strbuf_addstr(&synthkey, key);
     +-	retval = collect->collect_fn(synthkey.buf, value, collect->cb);
     ++	retval = collect->collect_fn(synthkey.buf, value, ctx, collect->cb);
     + 
     + 	strbuf_release(&synthkey);
     + 	return retval;
      
       ## urlmatch.h ##
      @@ urlmatch.h: struct urlmatch_config {
     @@ urlmatch.h: struct urlmatch_config {
       
      -int urlmatch_config_entry(const char *var, const char *value, void *cb);
      +int urlmatch_config_entry(const char *var, const char *value,
     -+			  struct key_value_info *kvi, void *cb);
     ++			  const struct config_context *ctx, void *cb);
       void urlmatch_config_release(struct urlmatch_config *config);
       
       #endif /* URL_MATCH_H */
     @@ xdiff-interface.c: int xdiff_compare_lines(const char *l1, long s1,
       
      -int git_xmerge_config(const char *var, const char *value, void *cb)
      +int git_xmerge_config(const char *var, const char *value,
     -+		      struct key_value_info *kvi, void *cb)
     ++		      const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "merge.conflictstyle")) {
       		if (!value)
     @@ xdiff-interface.c: int git_xmerge_config(const char *var, const char *value, voi
       		return 0;
       	}
      -	return git_default_config(var, value, cb);
     -+	return git_default_config(var, value,kvi, cb);
     ++	return git_default_config(var, value, ctx, cb);
       }
      
       ## xdiff-interface.h ##
     @@ xdiff-interface.h: int buffer_is_binary(const char *ptr, unsigned long size);
       void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
       void xdiff_clear_find_func(xdemitconf_t *xecfg);
      -int git_xmerge_config(const char *var, const char *value, void *cb);
     ++struct config_context;
      +int git_xmerge_config(const char *var, const char *value,
     -+		      struct key_value_info *kvi, void *cb);
     ++		      const struct config_context *ctx, void *cb);
       extern int git_xmerge_style;
       
       /*
  5:  f363b160259 <  -:  ----------- (RFC-only) config: finish config_fn_t refactor
  6:  f57c1007cad !  4:  c5051ddc10d config.c: pass kvi in configsets
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    config.c: pass kvi in configsets
     +    config.c: pass ctx in configsets
      
     -    Trivially pass "struct key_value_info" to config callbacks in
     -    configset_iter(). Then, in config callbacks that are only used with
     -    configsets, use the "kvi" arg to replace calls to current_config_*(),
     -    and delete current_config_line() because it has no remaining callers.
     +    Pass config_context to config callbacks in configset_iter(), trivially
     +    setting the .kvi member to the cached key_value_info. Then, in config
     +    callbacks that are only used with configsets, use the .kvi member to
     +    replace calls to current_config_*(), and delete current_config_line()
     +    because it has no remaining callers.
      
          This leaves builtin/config.c and config.c as the only remaining users of
          current_config_*().
     @@ builtin/remote.c: struct push_default_info
       };
       
       static int config_read_push_default(const char *key, const char *value,
     --	struct key_value_info *kvi UNUSED, void *cb)
     -+	struct key_value_info *kvi, void *cb)
     +-	const struct config_context *ctx UNUSED, void *cb)
     ++	const struct config_context *ctx, void *cb)
       {
     ++	const struct key_value_info *kvi = ctx->kvi;
     ++
       	struct push_default_info* info = cb;
       	if (strcmp(key, "remote.pushdefault") ||
       	    !value || strcmp(value, info->old_name))
     @@ config.c: static void configset_iter(struct config_reader *reader, struct config
       	struct string_list *values;
       	struct config_set_element *entry;
       	struct configset_list *list = &set->list;
     -+	struct key_value_info *kvi;
     ++	struct config_context ctx = CONFIG_CONTEXT_INIT;
       
       	for (i = 0; i < list->nr; i++) {
       		entry = list->items[i].e;
     - 		value_index = list->items[i].value_index;
     +@@ config.c: static void configset_iter(struct config_reader *reader, struct config_set *set,
       		values = &entry->value_list;
     -+		kvi = values->items[value_index].util;
       
       		config_reader_set_kvi(reader, values->items[value_index].util);
     - 
     +-
      -		if (fn(entry->key, values->items[value_index].string, NULL, data) < 0)
     --			git_die_config_linenr(entry->key,
     ++		ctx.kvi = values->items[value_index].util;
     ++		if (fn(entry->key, values->items[value_index].string, &ctx, data) < 0)
     + 			git_die_config_linenr(entry->key,
      -					      reader->config_kvi->filename,
      -					      reader->config_kvi->linenr);
      -
     -+		if (fn(entry->key, values->items[value_index].string, kvi, data) < 0)
     -+			git_die_config_linenr(entry->key, kvi->filename, kvi->linenr);
     ++					      ctx.kvi->filename,
     ++					      ctx.kvi->linenr);
       		config_reader_set_kvi(reader, NULL);
       	}
       }
     @@ remote.c: static void read_branches_file(struct remote_state *remote_state,
       }
       
       static int handle_config(const char *key, const char *value,
     --			 struct key_value_info *kvi UNUSED, void *cb)
     -+			 struct key_value_info *kvi, void *cb)
     +-			 const struct config_context *ctx UNUSED, void *cb)
     ++			 const struct config_context *ctx, void *cb)
       {
       	const char *name;
       	size_t namelen;
     +@@ remote.c: static int handle_config(const char *key, const char *value,
     + 	struct remote *remote;
     + 	struct branch *branch;
     + 	struct remote_state *remote_state = cb;
     ++	const struct key_value_info *kvi = ctx->kvi;
     + 
     + 	if (parse_config_key(key, "branch", &name, &namelen, &subkey) >= 0) {
     + 		/* There is no subsection. */
      @@ remote.c: static int handle_config(const char *key, const char *value,
       	}
       	remote = make_remote(remote_state, name, namelen);
     @@ t/helper/test-config.c
        */
       
       static int iterate_cb(const char *var, const char *value,
     --		      struct key_value_info *kvi UNUSED, void *data UNUSED)
     -+		      struct key_value_info *kvi, void *data UNUSED)
     +-		      const struct config_context *ctx UNUSED,
     ++		      const struct config_context *ctx,
     + 		      void *data UNUSED)
       {
     ++	const struct key_value_info *kvi = ctx->kvi;
       	static int nr;
       
     + 	if (nr++)
      @@ t/helper/test-config.c: static int iterate_cb(const char *var, const char *value,
       
       	printf("key=%s\n", var);
  7:  641a56f0b40 !  5:  595e7d2e163 config: provide kvi with config files
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    config: provide kvi with config files
     +    config: pass ctx with config files
      
     -    Refactor out the configset logic that caches "struct config_source" and
     -    "enum config_scope" as a "struct key_value_info", and use it to pass the
     -    "kvi" arg to config callbacks when parsing config files. Get the "enum
     -    config_scope" value by plumbing an additional arg through
     -    git_config_from_file_with_options() and the underlying machinery.
     +    Pass config_context to config_callbacks when parsing config files. To
     +    provide the .kvi member, refactor out the configset logic that caches
     +    "struct config_source" and "enum config_scope" as a "struct
     +    key_value_info". Make the "enum config_scope" available to the config
     +    file machinery by plumbing an additional arg through
     +    git_config_from_file_with_options().
      
     -    We do not exercise the "kvi" arg yet because the remaining
     -    current_config_*() callers may be used with config_with_options(), which
     -    may read config from parameters, but parameters don't pass "kvi" yet.
     +    We do not exercise ctx yet because the remaining current_config_*()
     +    callers may be used with config_with_options(), which may read config
     +    from parameters, but parameters don't pass ctx yet.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     @@ config.c: static int handle_path_include(struct config_source *cs, const char *p
       		inc->depth--;
       	}
       cleanup:
     -@@ config.c: static int include_condition_is_true(struct config_source *cs,
     - }
     - 
     - static int git_config_include(const char *var, const char *value,
     --			      struct key_value_info *kvi UNUSED, void *data)
     -+			      struct key_value_info *kvi, void *data)
     - {
     - 	struct config_include_data *inc = data;
     - 	struct config_source *cs = inc->config_reader->source;
      @@ config.c: static int git_config_include(const char *var, const char *value,
       	 * Pass along all values, including "include" directives; this makes it
       	 * possible to query information on the includes themselves.
       	 */
      -	ret = inc->fn(var, value, NULL, inc->data);
     -+	ret = inc->fn(var, value, kvi, inc->data);
     ++	ret = inc->fn(var, value, ctx, inc->data);
       	if (ret < 0)
       		return ret;
       
     @@ config.c: static char *parse_value(struct config_source *cs)
       {
       	int c;
       	char *value;
     + 	int ret;
     ++	struct config_context ctx = {
     ++		.kvi = kvi,
     ++	};
     + 
     + 	/* Get the full name */
     + 	for (;;) {
      @@ config.c: static int get_value(struct config_source *cs, config_fn_t fn, void *data,
       	 * accurate line number in error messages.
       	 */
       	cs->linenr--;
      -	ret = fn(name->buf, value, NULL, data);
      +	kvi->linenr = cs->linenr;
     -+	ret = fn(name->buf, value, kvi, data);
     ++	ret = fn(name->buf, value, &ctx, data);
       	if (ret >= 0)
       		cs->linenr++;
       	return ret;
     @@ config.c: int git_default_config(const char *var, const char *value,
      +			  void *data, enum config_scope scope,
       			  const struct config_options *opts)
       {
     -+	struct key_value_info kvi = { 0 };
     ++	struct key_value_info kvi = KVI_INIT;
       	int ret;
       
       	/* push config-file parsing state stack */
     @@ config.c: int git_config_set_multivar_in_file_gently(const char *config_filename
       			goto out_free;
      
       ## config.h ##
     -@@ config.h: int git_default_config(const char *, const char *, struct key_value_info *,
     +@@ config.h: int git_default_config(const char *, const char *,
       int git_config_from_file(config_fn_t fn, const char *, void *);
       
       int git_config_from_file_with_options(config_fn_t fn, const char *,
  8:  74f43fc727e =  6:  a2a891a069f builtin/config.c: test misuse of format_config()
  9:  3760015d2c0 !  7:  1fb1708bbd9 config.c: provide kvi with CLI config
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    config.c: provide kvi with CLI config
     +    config.c: pass ctx with CLI config
      
     -    Refactor out kvi_from_param() from the logic that caches CLI config in
     -    configsets, and use it to pass the "kvi" arg to config callbacks when
     -    parsing CLI config. Now that "kvi" is always present when config
     -    machinery calls config callbacks, plumb "kvi" so that we can replace
     -    nearly all calls to current_config_*(). (The exception is an edge case
     -    where trace2/*.c calls current_config_scope(). That will be handled in a
     -    later commit.) Note that this results in "kvi" containing a different,
     -    more complete set of information than the mocked up "struct
     -    config_source" in git_config_from_parameters().
     +    Pass config_context when parsing CLI config. To provide the .kvi member,
     +    refactor out kvi_from_param() from the logic that caches CLI config in
     +    configsets. Now that config_context and config_context.kvi is always
     +    present when config machinery calls config callbacks, plumb "kvi" so
     +    that we can remove all calls of current_config_scope() except for
     +    trace2/*.c (which will be handled in a later commit), and remove all
     +    other current_config_*() (the functions themselves and their calls).
     +    Note that this results in .kvi containing a different, more complete
     +    set of information than the mocked up "struct config_source" in
     +    git_config_from_parameters().
      
          Plumbing "kvi" reveals a few places where we've been doing the wrong
          thing:
     @@ Commit message
      
          * "git config --get-urlmatch --show-scope" iterates config to collect
            values, but then attempts to display the scope after config iteration.
     -      Fix this by copying the "kvi" arg in the collection phase so that it
     +      Fix this by copying the "kvi" value in the collection phase so that it
            can be read back later. This means that we can now support "git config
            --get-urlmatch --show-origin" (we don't allow this combination of args
            because of this bug), but that is left unchanged for now.
     @@ builtin/config.c: static void check_argc(int argc, int min, int max)
       }
       
      -static void show_config_origin(struct strbuf *buf)
     -+static void show_config_origin(struct key_value_info *kvi, struct strbuf *buf)
     ++static void show_config_origin(const struct key_value_info *kvi,
     ++			       struct strbuf *buf)
       {
       	const char term = end_nul ? '\0' : '\t';
       
     @@ builtin/config.c: static void check_argc(int argc, int min, int max)
       }
       
      -static void show_config_scope(struct strbuf *buf)
     -+static void show_config_scope(struct key_value_info *kvi, struct strbuf *buf)
     ++static void show_config_scope(const struct key_value_info *kvi,
     ++			      struct strbuf *buf)
       {
       	const char term = end_nul ? '\0' : '\t';
      -	const char *scope = config_scope_name(current_config_scope());
     @@ builtin/config.c: static void check_argc(int argc, int min, int max)
       }
       
       static int show_all_config(const char *key_, const char *value_,
     --			   struct key_value_info *kvi UNUSED, void *cb UNUSED)
     -+			   struct key_value_info *kvi, void *cb UNUSED)
     +-			   const struct config_context *ctx UNUSED,
     ++			   const struct config_context *ctx,
     + 			   void *cb UNUSED)
       {
     ++	const struct key_value_info *kvi = ctx->kvi;
     ++
       	if (show_origin || show_scope) {
       		struct strbuf buf = STRBUF_INIT;
       		if (show_scope)
     @@ builtin/config.c: struct strbuf_list {
       
      -static int format_config(struct strbuf *buf, const char *key_, const char *value_)
      +static int format_config(struct strbuf *buf, const char *key_,
     -+			 const char *value_, struct key_value_info *kvi)
     ++			 const char *value_, const struct key_value_info *kvi)
       {
       	if (show_scope)
      -		show_config_scope(buf);
     @@ builtin/config.c: static int format_config(struct strbuf *buf, const char *key_,
       }
       
       static int collect_config(const char *key_, const char *value_,
     --			  struct key_value_info *kvi UNUSED, void *cb)
     -+			  struct key_value_info *kvi, void *cb)
     +-			  const struct config_context *ctx UNUSED, void *cb)
     ++			  const struct config_context *ctx, void *cb)
       {
       	struct strbuf_list *values = cb;
     ++	const struct key_value_info *kvi = ctx->kvi;
       
     + 	if (!use_key_regexp && strcmp(key_, key))
     + 		return 0;
      @@ builtin/config.c: static int collect_config(const char *key_, const char *value_,
       	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
       	strbuf_init(&values->items[values->nr], 0);
     @@ builtin/config.c: static int get_value(const char *key_, const char *regex_, uns
       			    &given_config_source, &config_options);
       
       	if (!values.nr && default_value) {
     -+		struct key_value_info kvi = { 0 };
     ++		struct key_value_info kvi = KVI_INIT;
       		struct strbuf *item;
      +
      +		kvi_from_param(&kvi);
     @@ builtin/config.c: static void check_write(void)
       };
       
       static int urlmatch_collect_fn(const char *var, const char *value,
     --			       struct key_value_info *kvi UNUSED, void *cb)
     -+			       struct key_value_info *kvi, void *cb)
     +-			       const struct config_context *ctx UNUSED,
     ++			       const struct config_context *ctx,
     + 			       void *cb)
       {
       	struct string_list *values = cb;
       	struct string_list_item *item = string_list_insert(values, var);
     + 	struct urlmatch_current_candidate_value *matched = item->util;
     ++	const struct key_value_info *kvi = ctx->kvi;
     + 
     + 	if (!matched) {
     + 		matched = xmalloc(sizeof(*matched));
      @@ builtin/config.c: static int urlmatch_collect_fn(const char *var, const char *value,
       	} else {
       		strbuf_reset(&matched->value);
       	}
     -+	memcpy(&matched->kvi, kvi, sizeof(struct key_value_info));
     ++	matched->kvi = *kvi;
       
       	if (value) {
       		strbuf_addstr(&matched->value, value);
     @@ config.c: static const char include_depth_advice[] = N_(
       "This might be due to circular includes.");
      -static int handle_path_include(struct config_source *cs, const char *path,
      +static int handle_path_include(struct config_source *cs,
     -+			       struct key_value_info *kvi,
     ++			       const struct key_value_info *kvi,
      +			       const char *path,
       			       struct config_include_data *inc)
       {
     @@ config.c: static int git_config_include(const char *var, const char *value,
       
       	if (!strcmp(var, "include.path"))
      -		ret = handle_path_include(cs, value, inc);
     -+		ret = handle_path_include(cs, kvi, value, inc);
     ++		ret = handle_path_include(cs, ctx->kvi, value, inc);
       
       	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
       	    cond && include_condition_is_true(cs, inc, cond, cond_len) &&
     @@ config.c: static int git_config_include(const char *var, const char *value,
       		if (inc->opts->unconditional_remote_url)
       			inc->fn = forbid_remote_url;
      -		ret = handle_path_include(cs, value, inc);
     -+		ret = handle_path_include(cs, kvi, value, inc);
     ++		ret = handle_path_include(cs, ctx->kvi, value, inc);
       		inc->fn = old_fn;
       	}
       
     @@ config.c: out_free_ret_1:
       {
       	char *canonical_name;
       	int ret;
     -@@ config.c: static int config_parse_pair(const char *key, const char *value,
     ++	struct config_context ctx = {
     ++		.kvi = kvi,
     ++	};
     + 
     + 	if (!strlen(key))
     + 		return error(_("empty config key"));
       	if (git_config_parse_key(key, &canonical_name, NULL))
       		return -1;
       
      -	ret = (fn(canonical_name, value, NULL, data) < 0) ? -1 : 0;
     -+	ret = (fn(canonical_name, value, kvi, data) < 0) ? -1 : 0;
     ++	ret = (fn(canonical_name, value, &ctx, data) < 0) ? -1 : 0;
       	free(canonical_name);
       	return ret;
       }
     @@ config.c: static int config_parse_pair(const char *key, const char *value,
       	const char *value;
       	struct strbuf **pair;
       	int ret;
     -+	struct key_value_info kvi = { 0 };
     ++	struct key_value_info kvi = KVI_INIT;
      +
      +	kvi_from_param(&kvi);
       
     @@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
       	int ret = 0;
       	char *envw = NULL;
       	struct config_source source = CONFIG_SOURCE_INIT;
     -+	struct key_value_info kvi = { 0 };
     ++	struct key_value_info kvi = KVI_INIT;
       
       	source.origin_type = CONFIG_ORIGIN_CMDLINE;
       	config_reader_push_source(&the_reader, &source);
     @@ config.c: static int configset_find_element(struct config_set *set, const char *
       }
       
      -static int configset_add_value(struct config_reader *reader,
     -+static int configset_add_value(struct key_value_info *kvi_p,
     ++static int configset_add_value(const struct key_value_info *kvi_p,
      +			       struct config_reader *reader,
       			       struct config_set *set, const char *key,
       			       const char *value)
     @@ config.c: struct configset_add_data {
       #define CONFIGSET_ADD_INIT { 0 }
       
       static int config_set_callback(const char *key, const char *value,
     --			       struct key_value_info *kvi UNUSED, void *cb)
     -+			       struct key_value_info *kvi, void *cb)
     +-			       const struct config_context *ctx UNUSED,
     ++			       const struct config_context *ctx,
     + 			       void *cb)
       {
       	struct configset_add_data *data = cb;
      -	configset_add_value(data->config_reader, data->config_set, key, value);
     -+	configset_add_value(kvi, data->config_reader, data->config_set, key, value);
     ++	configset_add_value(ctx->kvi, data->config_reader, data->config_set,
     ++			    key, value);
       	return 0;
       }
       
 10:  7dc0c46b864 !  8:  66572df7beb trace2: plumb config kvi
     @@ Commit message
          trace2_def_param_fl(), which gets called by two code paths:
      
          - Through tr2_cfg_cb(), which is a config callback, so it trivially
     -      receives "kvi".
     +      receives "kvi" via the "struct config_context ctx" parameter.
      
          - Through tr2_list_env_vars_fl(), which is a high level function that
            lists environment variables for tracing. This has been secretly
     @@ trace2.c: void trace2_thread_exit_fl(const char *file, int line)
       
       void trace2_def_param_fl(const char *file, int line, const char *param,
      -			 const char *value)
     -+			 const char *value, struct key_value_info *kvi)
     ++			 const char *value, const struct key_value_info *kvi)
       {
       	struct tr2_tgt *tgt_j;
       	int j;
     @@ trace2.h: void trace2_thread_exit_fl(const char *file, int line);
        */
       void trace2_def_param_fl(const char *file, int line, const char *param,
      -			 const char *value);
     -+			 const char *value, struct key_value_info *kvi);
     ++			 const char *value, const struct key_value_info *kvi);
       
       #define trace2_def_param(param, value) \
       	trace2_def_param_fl(__FILE__, __LINE__, (param), (value))
      
       ## trace2/tr2_cfg.c ##
     -@@ trace2/tr2_cfg.c: struct tr2_cfg_data {
     -  * See if the given config key matches any of our patterns of interest.
     -  */
     - static int tr2_cfg_cb(const char *key, const char *value,
     --		      struct key_value_info *kvi UNUSED, void *d)
     -+		      struct key_value_info *kvi, void *d)
     - {
     - 	struct strbuf **s;
     - 	struct tr2_cfg_data *data = (struct tr2_cfg_data *)d;
      @@ trace2/tr2_cfg.c: static int tr2_cfg_cb(const char *key, const char *value,
       		struct strbuf *buf = *s;
       		int wm = wildmatch(buf->buf, key, WM_CASEFOLD);
       		if (wm == WM_MATCH) {
      -			trace2_def_param_fl(data->file, data->line, key, value);
      +			trace2_def_param_fl(data->file, data->line, key, value,
     -+					    kvi);
     ++					    ctx->kvi);
       			return 0;
       		}
       	}
     @@ trace2/tr2_cfg.c: void tr2_cfg_list_config_fl(const char *file, int line)
       
       void tr2_list_env_vars_fl(const char *file, int line)
       {
     -+	struct key_value_info kvi = { 0 };
     ++	struct key_value_info kvi = KVI_INIT;
       	struct strbuf **s;
       
      +	kvi_from_param(&kvi);
     @@ trace2/tr2_tgt.h: typedef void(tr2_tgt_evt_exec_result_fl_t)(const char *file, i
       typedef void(tr2_tgt_evt_param_fl_t)(const char *file, int line,
      -				     const char *param, const char *value);
      +				     const char *param, const char *value,
     -+				     struct key_value_info *kvi);
     ++				     const struct key_value_info *kvi);
       
       typedef void(tr2_tgt_evt_repo_fl_t)(const char *file, int line,
       				    const struct repository *repo);
     @@ trace2/tr2_tgt_event.c: static void fn_exec_result_fl(const char *file, int line
       
       static void fn_param_fl(const char *file, int line, const char *param,
      -			const char *value)
     -+			const char *value, struct key_value_info *kvi)
     ++			const char *value, const struct key_value_info *kvi)
       {
       	const char *event_name = "def_param";
       	struct json_writer jw = JSON_WRITER_INIT;
     @@ trace2/tr2_tgt_normal.c: static void fn_exec_result_fl(const char *file, int lin
       
       static void fn_param_fl(const char *file, int line, const char *param,
      -			const char *value)
     -+			const char *value, struct key_value_info *kvi)
     ++			const char *value, const struct key_value_info *kvi)
       {
       	struct strbuf buf_payload = STRBUF_INIT;
      -	enum config_scope scope = current_config_scope();
     @@ trace2/tr2_tgt_perf.c: static void fn_exec_result_fl(const char *file, int line,
       
       static void fn_param_fl(const char *file, int line, const char *param,
      -			const char *value)
     -+			const char *value, struct key_value_info *kvi)
     ++			const char *value, const struct key_value_info *kvi)
       {
       	const char *event_name = "def_param";
       	struct strbuf buf_payload = STRBUF_INIT;
 11:  504eb206b5a !  9:  123e19dda4a config: pass kvi to die_bad_number()
     @@ Commit message
      
          In config.c, this requires changing the signature of
          git_configset_get_value() to 'return' "kvi" in an out parameter so that
     -    git_configset_get_<type>() can pass it to git_config_<type>().
     +    git_configset_get_<type>() can pass it to git_config_<type>(). Only
     +    numeric types will use "kvi", so for non-numeric types (e.g.
     +    git_configset_get_string()), pass NULL to indicate that the out
     +    parameter isn't needed.
      
     -    Outside of config.c, config callbacks now need to pass "kvi" to any of
     -    the git_config_<type>() functions that parse a config string into a
     -    number type. Included is a .cocci patch to make that refactor. In cases
     -    where "kvi" would never be used, pass NULL, e.g.:
     +    Outside of config.c, config callbacks now need to pass "ctx->kvi" to any
     +    of the git_config_<type>() functions that parse a config string into a
     +    number type. Included is a .cocci patch to make that refactor.
      
     -    - In config.c, when we are parsing a boolean instead of a number
     -    - In builtin/config.c, when calling normalize_value() before setting
     -      config to something the user gave us.
     +    The only exceptional case is builtin/config.c, where git_config_<type>()
     +    is called outside of a config callback (namely, on user-provided input),
     +    so config source information has never been available. In this case,
     +    die_bad_number() defaults to a generic, but perfectly descriptive
     +    message. Let's provide a safe, non-NULL for "kvi" anyway, but make sure
     +    not to change the message.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     @@ archive-tar.c: static int tar_filter_config(const char *var, const char *value,
       }
       
       static int git_tar_config(const char *var, const char *value,
     --			  struct key_value_info *kvi UNUSED, void *cb)
     -+			  struct key_value_info *kvi, void *cb)
     +-			  const struct config_context *ctx UNUSED, void *cb)
     ++			  const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, "tar.umask")) {
       		if (value && !strcmp(value, "user")) {
     @@ archive-tar.c: static int tar_filter_config(const char *var, const char *value,
       			umask(tar_umask);
       		} else {
      -			tar_umask = git_config_int(var, value);
     -+			tar_umask = git_config_int(var, value, kvi);
     ++			tar_umask = git_config_int(var, value, ctx->kvi);
       		}
       		return 0;
       	}
     @@ builtin/commit-graph.c: static int write_option_max_new_filters(const struct opt
       }
       
       static int git_commit_graph_write_config(const char *var, const char *value,
     --					 struct key_value_info *kvi UNUSED,
     -+					 struct key_value_info *kvi,
     +-					 const struct config_context *ctx UNUSED,
     ++					 const struct config_context *ctx,
       					 void *cb UNUSED)
       {
       	if (!strcmp(var, "commitgraph.maxnewfilters"))
      -		write_opts.max_new_filters = git_config_int(var, value);
     -+		write_opts.max_new_filters = git_config_int(var, value, kvi);
     ++		write_opts.max_new_filters = git_config_int(var, value, ctx->kvi);
       	/*
       	 * No need to fall-back to 'git_default_config', since this was already
       	 * called in 'cmd_commit_graph()'.
     @@ builtin/commit.c: static int git_status_config(const char *k, const char *v,
       	if (!strcmp(k, "status.submodulesummary")) {
       		int is_bool;
      -		s->submodule_summary = git_config_bool_or_int(k, v, &is_bool);
     -+		s->submodule_summary = git_config_bool_or_int(k, v, kvi,
     ++		s->submodule_summary = git_config_bool_or_int(k, v, ctx->kvi,
      +							      &is_bool);
       		if (is_bool && s->submodule_summary)
       			s->submodule_summary = -1;
     @@ builtin/commit.c: static int git_status_config(const char *k, const char *v,
       	if (!strcmp(k, "diff.renamelimit")) {
       		if (s->rename_limit == -1)
      -			s->rename_limit = git_config_int(k, v);
     -+			s->rename_limit = git_config_int(k, v, kvi);
     ++			s->rename_limit = git_config_int(k, v, ctx->kvi);
       		return 0;
       	}
       	if (!strcmp(k, "status.renamelimit")) {
      -		s->rename_limit = git_config_int(k, v);
     -+		s->rename_limit = git_config_int(k, v, kvi);
     ++		s->rename_limit = git_config_int(k, v, ctx->kvi);
       		return 0;
       	}
       	if (!strcmp(k, "diff.renames")) {
     @@ builtin/commit.c: static int git_commit_config(const char *k, const char *v,
       	if (!strcmp(k, "commit.verbose")) {
       		int is_bool;
      -		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
     -+		config_commit_verbose = git_config_bool_or_int(k, v, kvi,
     ++		config_commit_verbose = git_config_bool_or_int(k, v, ctx->kvi,
      +							       &is_bool);
       		return 0;
       	}
     @@ builtin/config.c: static char *normalize_value(const char *key, const char *valu
       		if (!is_bool)
       			return xstrfmt("%d", v);
       		else
     +@@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix)
     + 	char *value = NULL;
     + 	int flags = 0;
     + 	int ret = 0;
     ++	struct key_value_info default_kvi = KVI_INIT;
     + 
     + 	given_config_source.file = xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
     + 
      @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix)
       	else if (actions == ACTION_SET) {
       		check_write();
       		check_argc(argc, 2, 2);
      -		value = normalize_value(argv[0], argv[1]);
     -+		value = normalize_value(argv[0], argv[1], NULL);
     ++		value = normalize_value(argv[0], argv[1], &default_kvi);
       		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], value);
       		if (ret == CONFIG_NOTHING_SET)
       			error(_("cannot overwrite multiple values with a single value\n"
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix
       		check_write();
       		check_argc(argc, 2, 3);
      -		value = normalize_value(argv[0], argv[1]);
     -+		value = normalize_value(argv[0], argv[1], NULL);
     ++		value = normalize_value(argv[0], argv[1], &default_kvi);
       		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
       							     argv[0], value, argv[2],
       							     flags);
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix
       		check_write();
       		check_argc(argc, 2, 2);
      -		value = normalize_value(argv[0], argv[1]);
     -+		value = normalize_value(argv[0], argv[1], NULL);
     ++		value = normalize_value(argv[0], argv[1], &default_kvi);
       		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
       							     argv[0], value,
       							     CONFIG_REGEX_NONE,
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix
       		check_write();
       		check_argc(argc, 2, 3);
      -		value = normalize_value(argv[0], argv[1]);
     -+		value = normalize_value(argv[0], argv[1], NULL);
     ++		value = normalize_value(argv[0], argv[1], &default_kvi);
       		ret = git_config_set_multivar_in_file_gently(given_config_source.file,
       							     argv[0], value, argv[2],
       							     flags | CONFIG_FLAGS_MULTI_REPLACE);
     @@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v,
       
       	if (!strcmp(k, "submodule.fetchjobs")) {
      -		submodule_fetch_jobs_config = parse_submodule_fetchjobs(k, v);
     -+		submodule_fetch_jobs_config = parse_submodule_fetchjobs(k, v, kvi);
     ++		submodule_fetch_jobs_config = parse_submodule_fetchjobs(k, v, ctx->kvi);
       		return 0;
       	} else if (!strcmp(k, "fetch.recursesubmodules")) {
       		recurse_submodules = parse_fetch_recurse_submodules_arg(k, v);
     @@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v,
       
       	if (!strcmp(k, "fetch.parallel")) {
      -		fetch_parallel_config = git_config_int(k, v);
     -+		fetch_parallel_config = git_config_int(k, v, kvi);
     ++		fetch_parallel_config = git_config_int(k, v, ctx->kvi);
       		if (fetch_parallel_config < 0)
       			die(_("fetch.parallel cannot be negative"));
       		if (!fetch_parallel_config)
      
       ## builtin/fsmonitor--daemon.c ##
      @@ builtin/fsmonitor--daemon.c: static int fsmonitor_config(const char *var, const char *value,
     - 			    struct key_value_info *kvi, void *cb)
     + 			    const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(var, FSMONITOR__IPC_THREADS)) {
      -		int i = git_config_int(var, value);
     -+		int i = git_config_int(var, value, kvi);
     ++		int i = git_config_int(var, value, ctx->kvi);
       		if (i < 1)
       			return error(_("value of '%s' out of range: %d"),
       				     FSMONITOR__IPC_THREADS, i);
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_config(const char *var, const
       
       	if (!strcmp(var, FSMONITOR__START_TIMEOUT)) {
      -		int i = git_config_int(var, value);
     -+		int i = git_config_int(var, value, kvi);
     ++		int i = git_config_int(var, value, ctx->kvi);
       		if (i < 0)
       			return error(_("value of '%s' out of range: %d"),
       				     FSMONITOR__START_TIMEOUT, i);
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_config(const char *var, const
       	if (!strcmp(var, FSMONITOR__ANNOUNCE_STARTUP)) {
       		int is_bool;
      -		int i = git_config_bool_or_int(var, value, &is_bool);
     -+		int i = git_config_bool_or_int(var, value, kvi, &is_bool);
     ++		int i = git_config_bool_or_int(var, value, ctx->kvi, &is_bool);
       		if (i < 0)
       			return error(_("value of '%s' not bool or int: %d"),
       				     var, i);
     @@ builtin/grep.c: static int grep_cmd_config(const char *var, const char *value,
       
       	if (!strcmp(var, "grep.threads")) {
      -		num_threads = git_config_int(var, value);
     -+		num_threads = git_config_int(var, value, kvi);
     ++		num_threads = git_config_int(var, value, ctx->kvi);
       		if (num_threads < 0)
       			die(_("invalid number of threads specified (%d) for %s"),
       			    num_threads, var);
     @@ builtin/index-pack.c: static int git_index_pack_config(const char *k, const char
       
       	if (!strcmp(k, "pack.indexversion")) {
      -		opts->version = git_config_int(k, v);
     -+		opts->version = git_config_int(k, v, kvi);
     ++		opts->version = git_config_int(k, v, ctx->kvi);
       		if (opts->version > 2)
       			die(_("bad pack.indexVersion=%"PRIu32), opts->version);
       		return 0;
       	}
       	if (!strcmp(k, "pack.threads")) {
      -		nr_threads = git_config_int(k, v);
     -+		nr_threads = git_config_int(k, v, kvi);
     ++		nr_threads = git_config_int(k, v, ctx->kvi);
       		if (nr_threads < 0)
       			die(_("invalid number of threads specified (%d)"),
       			    nr_threads);
     @@ builtin/log.c: static int git_log_config(const char *var, const char *value,
       		return git_config_string(&fmt_patch_subject_prefix, var, value);
       	if (!strcmp(var, "format.filenamemaxlength")) {
      -		fmt_patch_name_max = git_config_int(var, value);
     -+		fmt_patch_name_max = git_config_int(var, value, kvi);
     ++		fmt_patch_name_max = git_config_int(var, value, ctx->kvi);
       		return 0;
       	}
       	if (!strcmp(var, "format.encodeemailheaders")) {
      
       ## builtin/pack-objects.c ##
      @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
     - 			   struct key_value_info *kvi, void *cb)
     + 			   const struct config_context *ctx, void *cb)
       {
       	if (!strcmp(k, "pack.window")) {
      -		window = git_config_int(k, v);
     -+		window = git_config_int(k, v, kvi);
     ++		window = git_config_int(k, v, ctx->kvi);
       		return 0;
       	}
       	if (!strcmp(k, "pack.windowmemory")) {
      -		window_memory_limit = git_config_ulong(k, v);
     -+		window_memory_limit = git_config_ulong(k, v, kvi);
     ++		window_memory_limit = git_config_ulong(k, v, ctx->kvi);
       		return 0;
       	}
       	if (!strcmp(k, "pack.depth")) {
      -		depth = git_config_int(k, v);
     -+		depth = git_config_int(k, v, kvi);
     ++		depth = git_config_int(k, v, ctx->kvi);
       		return 0;
       	}
       	if (!strcmp(k, "pack.deltacachesize")) {
      -		max_delta_cache_size = git_config_int(k, v);
     -+		max_delta_cache_size = git_config_int(k, v, kvi);
     ++		max_delta_cache_size = git_config_int(k, v, ctx->kvi);
       		return 0;
       	}
       	if (!strcmp(k, "pack.deltacachelimit")) {
      -		cache_max_small_delta_size = git_config_int(k, v);
     -+		cache_max_small_delta_size = git_config_int(k, v, kvi);
     ++		cache_max_small_delta_size = git_config_int(k, v, ctx->kvi);
       		return 0;
       	}
       	if (!strcmp(k, "pack.writebitmaphashcache")) {
     @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
       	}
       	if (!strcmp(k, "pack.threads")) {
      -		delta_search_threads = git_config_int(k, v);
     -+		delta_search_threads = git_config_int(k, v, kvi);
     ++		delta_search_threads = git_config_int(k, v, ctx->kvi);
       		if (delta_search_threads < 0)
       			die(_("invalid number of threads specified (%d)"),
       			    delta_search_threads);
     @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
       	}
       	if (!strcmp(k, "pack.indexversion")) {
      -		pack_idx_opts.version = git_config_int(k, v);
     -+		pack_idx_opts.version = git_config_int(k, v, kvi);
     ++		pack_idx_opts.version = git_config_int(k, v, ctx->kvi);
       		if (pack_idx_opts.version > 2)
       			die(_("bad pack.indexVersion=%"PRIu32),
       			    pack_idx_opts.version);
     @@ builtin/receive-pack.c: static int receive_pack_config(const char *var, const ch
       
       	if (strcmp(var, "receive.unpacklimit") == 0) {
      -		receive_unpack_limit = git_config_int(var, value);
     -+		receive_unpack_limit = git_config_int(var, value, kvi);
     ++		receive_unpack_limit = git_config_int(var, value, ctx->kvi);
       		return 0;
       	}
       
       	if (strcmp(var, "transfer.unpacklimit") == 0) {
      -		transfer_unpack_limit = git_config_int(var, value);
     -+		transfer_unpack_limit = git_config_int(var, value, kvi);
     ++		transfer_unpack_limit = git_config_int(var, value, ctx->kvi);
       		return 0;
       	}
       
     @@ builtin/receive-pack.c: static int receive_pack_config(const char *var, const ch
       
       	if (strcmp(var, "receive.certnonceslop") == 0) {
      -		nonce_stamp_slop_limit = git_config_ulong(var, value);
     -+		nonce_stamp_slop_limit = git_config_ulong(var, value, kvi);
     ++		nonce_stamp_slop_limit = git_config_ulong(var, value, ctx->kvi);
       		return 0;
       	}
       
     @@ builtin/receive-pack.c: static int receive_pack_config(const char *var, const ch
       
       	if (strcmp(var, "receive.keepalive") == 0) {
      -		keepalive_in_sec = git_config_int(var, value);
     -+		keepalive_in_sec = git_config_int(var, value, kvi);
     ++		keepalive_in_sec = git_config_int(var, value, ctx->kvi);
       		return 0;
       	}
       
       	if (strcmp(var, "receive.maxinputsize") == 0) {
      -		max_input_size = git_config_int64(var, value);
     -+		max_input_size = git_config_int64(var, value, kvi);
     ++		max_input_size = git_config_int64(var, value, ctx->kvi);
       		return 0;
       	}
       
     @@ builtin/submodule--helper.c: static int update_clone_task_finished(int result,
       }
       
       static int git_update_clone_config(const char *var, const char *value,
     --				   struct key_value_info *kvi UNUSED,
     -+				   struct key_value_info *kvi,
     +-				   const struct config_context *ctx UNUSED,
     ++				   const struct config_context *ctx,
       				   void *cb)
       {
       	int *max_jobs = cb;
       
       	if (!strcmp(var, "submodule.fetchjobs"))
      -		*max_jobs = parse_submodule_fetchjobs(var, value);
     -+		*max_jobs = parse_submodule_fetchjobs(var, value, kvi);
     ++		*max_jobs = parse_submodule_fetchjobs(var, value, ctx->kvi);
       	return 0;
       }
       
     @@ config.c: int git_parse_ssize_t(const char *value, ssize_t *ret)
      -static void die_bad_number(struct config_reader *reader, const char *name,
      -			   const char *value)
      +static void die_bad_number(const char *name, const char *value,
     -+			   struct key_value_info *kvi)
     ++			   const struct key_value_info *kvi)
       {
       	const char *error_type = (errno == ERANGE) ?
       		N_("out of range") : N_("invalid unit");
       	const char *bad_numeric = N_("bad numeric config value '%s' for '%s': %s");
      -	const char *config_name = NULL;
      -	enum config_origin_type config_origin = CONFIG_ORIGIN_UNKNOWN;
     ++
     ++	if (!kvi)
     ++		BUG("kvi should not be NULL");
       
       	if (!value)
       		value = "";
     @@ config.c: int git_parse_ssize_t(const char *value, ssize_t *ret)
      -	reader_origin_type(reader, &config_origin);
      -
      -	if (!config_name)
     -+	if (!kvi || !kvi->filename)
     ++	if (!kvi->filename)
       		die(_(bad_numeric), value, name, _(error_type));
       
      -	switch (config_origin) {
     @@ config.c: int git_parse_ssize_t(const char *value, ssize_t *ret)
       
      -int git_config_int(const char *name, const char *value)
      +int git_config_int(const char *name, const char *value,
     -+		   struct key_value_info *kvi)
     ++		   const struct key_value_info *kvi)
       {
       	int ret;
       	if (!git_parse_int(value, &ret))
     @@ config.c: int git_parse_ssize_t(const char *value, ssize_t *ret)
       }
       
      -int64_t git_config_int64(const char *name, const char *value)
     -+int64_t git_config_int64(const char *name, const char *value, struct key_value_info *kvi)
     ++int64_t git_config_int64(const char *name, const char *value,
     ++			 const struct key_value_info *kvi)
       {
       	int64_t ret;
       	if (!git_parse_int64(value, &ret))
     @@ config.c: int git_parse_ssize_t(const char *value, ssize_t *ret)
       
      -unsigned long git_config_ulong(const char *name, const char *value)
      +unsigned long git_config_ulong(const char *name, const char *value,
     -+			       struct key_value_info *kvi)
     ++			       const struct key_value_info *kvi)
       {
       	unsigned long ret;
       	if (!git_parse_ulong(value, &ret))
     @@ config.c: int git_parse_ssize_t(const char *value, ssize_t *ret)
       
      -ssize_t git_config_ssize_t(const char *name, const char *value)
      +ssize_t git_config_ssize_t(const char *name, const char *value,
     -+			   struct key_value_info *kvi)
     ++			   const struct key_value_info *kvi)
       {
       	ssize_t ret;
       	if (!git_parse_ssize_t(value, &ret))
     @@ config.c: int git_parse_maybe_bool(const char *value)
       
      -int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
      +int git_config_bool_or_int(const char *name, const char *value,
     -+			   struct key_value_info *kvi, int *is_bool)
     ++			   const struct key_value_info *kvi, int *is_bool)
       {
       	int v = git_parse_maybe_bool_text(value);
       	if (0 <= v) {
     @@ config.c: static int git_default_core_config(const char *var, const char *value,
       			default_abbrev = the_hash_algo->hexsz;
       		else {
      -			int abbrev = git_config_int(var, value);
     -+			int abbrev = git_config_int(var, value, kvi);
     ++			int abbrev = git_config_int(var, value, ctx->kvi);
       			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)
       				return error(_("abbrev length out of range: %d"), abbrev);
       			default_abbrev = abbrev;
     @@ config.c: static int git_default_core_config(const char *var, const char *value,
       
       	if (!strcmp(var, "core.loosecompression")) {
      -		int level = git_config_int(var, value);
     -+		int level = git_config_int(var, value, kvi);
     ++		int level = git_config_int(var, value, ctx->kvi);
       		if (level == -1)
       			level = Z_DEFAULT_COMPRESSION;
       		else if (level < 0 || level > Z_BEST_COMPRESSION)
     @@ config.c: static int git_default_core_config(const char *var, const char *value,
       
       	if (!strcmp(var, "core.compression")) {
      -		int level = git_config_int(var, value);
     -+		int level = git_config_int(var, value, kvi);
     ++		int level = git_config_int(var, value, ctx->kvi);
       		if (level == -1)
       			level = Z_DEFAULT_COMPRESSION;
       		else if (level < 0 || level > Z_BEST_COMPRESSION)
     @@ config.c: static int git_default_core_config(const char *var, const char *value,
       	if (!strcmp(var, "core.packedgitwindowsize")) {
       		int pgsz_x2 = getpagesize() * 2;
      -		packed_git_window_size = git_config_ulong(var, value);
     -+		packed_git_window_size = git_config_ulong(var, value, kvi);
     ++		packed_git_window_size = git_config_ulong(var, value, ctx->kvi);
       
       		/* This value must be multiple of (pagesize * 2) */
       		packed_git_window_size /= pgsz_x2;
     @@ config.c: static int git_default_core_config(const char *var, const char *value,
       
       	if (!strcmp(var, "core.bigfilethreshold")) {
      -		big_file_threshold = git_config_ulong(var, value);
     -+		big_file_threshold = git_config_ulong(var, value, kvi);
     ++		big_file_threshold = git_config_ulong(var, value, ctx->kvi);
       		return 0;
       	}
       
       	if (!strcmp(var, "core.packedgitlimit")) {
      -		packed_git_limit = git_config_ulong(var, value);
     -+		packed_git_limit = git_config_ulong(var, value, kvi);
     ++		packed_git_limit = git_config_ulong(var, value, ctx->kvi);
       		return 0;
       	}
       
       	if (!strcmp(var, "core.deltabasecachelimit")) {
      -		delta_base_cache_limit = git_config_ulong(var, value);
     -+		delta_base_cache_limit = git_config_ulong(var, value, kvi);
     ++		delta_base_cache_limit = git_config_ulong(var, value, ctx->kvi);
       		return 0;
       	}
       
     @@ config.c: int git_default_config(const char *var, const char *value,
       
       	if (!strcmp(var, "pack.packsizelimit")) {
      -		pack_size_limit_cfg = git_config_ulong(var, value);
     -+		pack_size_limit_cfg = git_config_ulong(var, value, kvi);
     ++		pack_size_limit_cfg = git_config_ulong(var, value, ctx->kvi);
       		return 0;
       	}
       
       	if (!strcmp(var, "pack.compression")) {
      -		int level = git_config_int(var, value);
     -+		int level = git_config_int(var, value, kvi);
     ++		int level = git_config_int(var, value, ctx->kvi);
       		if (level == -1)
       			level = Z_DEFAULT_COMPRESSION;
       		else if (level < 0 || level > Z_BEST_COMPRESSION)
      @@ config.c: static void configset_iter(struct config_reader *reader, struct config_set *set,
     + 		value_index = list->items[i].value_index;
       		values = &entry->value_list;
     - 		kvi = values->items[value_index].util;
       
      -		config_reader_set_kvi(reader, values->items[value_index].util);
     --
     - 		if (fn(entry->key, values->items[value_index].string, kvi, data) < 0)
     - 			git_die_config_linenr(entry->key, kvi->filename, kvi->linenr);
     + 		ctx.kvi = values->items[value_index].util;
     + 		if (fn(entry->key, values->items[value_index].string, &ctx, data) < 0)
     + 			git_die_config_linenr(entry->key,
     + 					      ctx.kvi->filename,
     + 					      ctx.kvi->linenr);
      -		config_reader_set_kvi(reader, NULL);
       	}
       }
     @@ config.h: int git_parse_maybe_bool(const char *);
        * otherwise, returns the parsed result.
        */
      -int git_config_int(const char *, const char *);
     -+int git_config_int(const char *, const char *, struct key_value_info *);
     ++int git_config_int(const char *, const char *, const struct key_value_info *);
       
      -int64_t git_config_int64(const char *, const char *);
     -+int64_t git_config_int64(const char *, const char *, struct key_value_info *);
     ++int64_t git_config_int64(const char *, const char *,
     ++			 const struct key_value_info *);
       
       /**
        * Identical to `git_config_int`, but for unsigned longs.
        */
      -unsigned long git_config_ulong(const char *, const char *);
     -+unsigned long git_config_ulong(const char *, const char *, struct key_value_info *);
     ++unsigned long git_config_ulong(const char *, const char *,
     ++			       const struct key_value_info *);
       
      -ssize_t git_config_ssize_t(const char *, const char *);
     -+ssize_t git_config_ssize_t(const char *, const char *, struct key_value_info *);
     ++ssize_t git_config_ssize_t(const char *, const char *,
     ++			   const struct key_value_info *);
       
       /**
        * Same as `git_config_bool`, except that integers are returned as-is, and
        * an `is_bool` flag is unset.
        */
      -int git_config_bool_or_int(const char *, const char *, int *);
     -+int git_config_bool_or_int(const char *, const char *, struct key_value_info *,
     -+			   int *);
     ++int git_config_bool_or_int(const char *, const char *,
     ++			   const struct key_value_info *, int *);
       
       /**
        * Parse a string into a boolean value, respecting keywords like "true" and
     @@ contrib/coccinelle/git_config_number.cocci (new)
      +git_config_ssize_t
      +)
      +  (C1, C2
     -++ , kvi
     +++ , ctx->kvi
      +  )
      +|
      +(
     @@ contrib/coccinelle/git_config_number.cocci (new)
      +|
      +git_config_bool_or_int
      +)
     -+  (C1, C2,
     -++ kvi,
     -+  C3
     ++  (C1, C2
     +++ , ctx->kvi
     ++ , C3
      +  )
      +)
      
     @@ diff.c: int git_diff_ui_config(const char *var, const char *value,
       	}
       	if (!strcmp(var, "diff.context")) {
      -		diff_context_default = git_config_int(var, value);
     -+		diff_context_default = git_config_int(var, value, kvi);
     ++		diff_context_default = git_config_int(var, value, ctx->kvi);
       		if (diff_context_default < 0)
       			return -1;
       		return 0;
     @@ diff.c: int git_diff_ui_config(const char *var, const char *value,
       	if (!strcmp(var, "diff.interhunkcontext")) {
      -		diff_interhunk_context_default = git_config_int(var, value);
      +		diff_interhunk_context_default = git_config_int(var, value,
     -+								kvi);
     ++								ctx->kvi);
       		if (diff_interhunk_context_default < 0)
       			return -1;
       		return 0;
     @@ diff.c: int git_diff_ui_config(const char *var, const char *value,
       	}
       	if (!strcmp(var, "diff.statgraphwidth")) {
      -		diff_stat_graph_width = git_config_int(var, value);
     -+		diff_stat_graph_width = git_config_int(var, value, kvi);
     ++		diff_stat_graph_width = git_config_int(var, value, ctx->kvi);
       		return 0;
       	}
       	if (!strcmp(var, "diff.external"))
     @@ diff.c: int git_diff_basic_config(const char *var, const char *value,
       
       	if (!strcmp(var, "diff.renamelimit")) {
      -		diff_rename_limit_default = git_config_int(var, value);
     -+		diff_rename_limit_default = git_config_int(var, value, kvi);
     ++		diff_rename_limit_default = git_config_int(var, value, ctx->kvi);
       		return 0;
       	}
       
     @@ fmt-merge-msg.c: int fmt_merge_msg_config(const char *key, const char *value,
       	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
       		int is_bool;
      -		merge_log_config = git_config_bool_or_int(key, value, &is_bool);
     -+		merge_log_config = git_config_bool_or_int(key, value, kvi, &is_bool);
     ++		merge_log_config = git_config_bool_or_int(key, value, ctx->kvi, &is_bool);
       		if (!is_bool && merge_log_config < 0)
       			return error("%s: negative length %s", key, value);
       		if (is_bool && merge_log_config)
     @@ help.c: static struct cmdnames aliases;
       #define AUTOCORRECT_IMMEDIATELY (-1)
       
       static int git_unknown_cmd_config(const char *var, const char *value,
     --				  struct key_value_info *kvi UNUSED,
     --				  void *cb UNUSED)
     -+				  struct key_value_info *kvi, void *cb UNUSED)
     +-				  const struct config_context *ctx UNUSED,
     ++				  const struct config_context *ctx,
     + 				  void *cb UNUSED)
       {
       	const char *p;
     - 
      @@ help.c: static int git_unknown_cmd_config(const char *var, const char *value,
       		} else if (!strcmp(value, "prompt")) {
       			autocorrect = AUTOCORRECT_PROMPT;
       		} else {
      -			int v = git_config_int(var, value);
     -+			int v = git_config_int(var, value, kvi);
     ++			int v = git_config_int(var, value, ctx->kvi);
       			autocorrect = (v < 0)
       				? AUTOCORRECT_IMMEDIATELY : v;
       		}
     @@ http.c: static int http_options(const char *var, const char *value,
       
       	if (!strcmp("http.minsessions", var)) {
      -		min_curl_sessions = git_config_int(var, value);
     -+		min_curl_sessions = git_config_int(var, value, kvi);
     ++		min_curl_sessions = git_config_int(var, value, ctx->kvi);
       		if (min_curl_sessions > 1)
       			min_curl_sessions = 1;
       		return 0;
       	}
       	if (!strcmp("http.maxrequests", var)) {
      -		max_requests = git_config_int(var, value);
     -+		max_requests = git_config_int(var, value, kvi);
     ++		max_requests = git_config_int(var, value, ctx->kvi);
       		return 0;
       	}
       	if (!strcmp("http.lowspeedlimit", var)) {
      -		curl_low_speed_limit = (long)git_config_int(var, value);
     -+		curl_low_speed_limit = (long)git_config_int(var, value, kvi);
     ++		curl_low_speed_limit = (long)git_config_int(var, value, ctx->kvi);
       		return 0;
       	}
       	if (!strcmp("http.lowspeedtime", var)) {
      -		curl_low_speed_time = (long)git_config_int(var, value);
     -+		curl_low_speed_time = (long)git_config_int(var, value, kvi);
     ++		curl_low_speed_time = (long)git_config_int(var, value, ctx->kvi);
       		return 0;
       	}
       
     @@ http.c: static int http_options(const char *var, const char *value,
       
       	if (!strcmp("http.postbuffer", var)) {
      -		http_post_buffer = git_config_ssize_t(var, value);
     -+		http_post_buffer = git_config_ssize_t(var, value, kvi);
     ++		http_post_buffer = git_config_ssize_t(var, value, ctx->kvi);
       		if (http_post_buffer < 0)
       			warning(_("negative value for http.postBuffer; defaulting to %d"), LARGE_PACKET_MAX);
       		if (http_post_buffer < LARGE_PACKET_MAX)
     @@ imap-send.c: static int git_imap_config(const char *var, const char *val,
       		return git_config_string(&server.auth_method, var, val);
       	else if (!strcmp("imap.port", var))
      -		server.port = git_config_int(var, val);
     -+		server.port = git_config_int(var, val, kvi);
     ++		server.port = git_config_int(var, val, ctx->kvi);
       	else if (!strcmp("imap.host", var)) {
       		if (!val) {
       			git_die_config("imap.host", "Missing value for 'imap.host'");
     @@ sequencer.c: static int git_config_string_dup(char **dest,
       }
       
       static int populate_opts_cb(const char *key, const char *value,
     --			    struct key_value_info *kvi UNUSED, void *data)
     -+			    struct key_value_info *kvi, void *data)
     +-			    const struct config_context *ctx UNUSED,
     ++			    const struct config_context *ctx,
     + 			    void *data)
       {
       	struct replay_opts *opts = data;
     - 	int error_flag = 1;
      @@ sequencer.c: static int populate_opts_cb(const char *key, const char *value,
       	if (!value)
       		error_flag = 0;
       	else if (!strcmp(key, "options.no-commit"))
      -		opts->no_commit = git_config_bool_or_int(key, value, &error_flag);
     -+		opts->no_commit = git_config_bool_or_int(key, value, kvi, &error_flag);
     ++		opts->no_commit = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
       	else if (!strcmp(key, "options.edit"))
      -		opts->edit = git_config_bool_or_int(key, value, &error_flag);
     -+		opts->edit = git_config_bool_or_int(key, value, kvi, &error_flag);
     ++		opts->edit = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
       	else if (!strcmp(key, "options.allow-empty"))
       		opts->allow_empty =
      -			git_config_bool_or_int(key, value, &error_flag);
     -+			git_config_bool_or_int(key, value, kvi, &error_flag);
     ++			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
       	else if (!strcmp(key, "options.allow-empty-message"))
       		opts->allow_empty_message =
      -			git_config_bool_or_int(key, value, &error_flag);
     -+			git_config_bool_or_int(key, value, kvi, &error_flag);
     ++			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
       	else if (!strcmp(key, "options.keep-redundant-commits"))
       		opts->keep_redundant_commits =
      -			git_config_bool_or_int(key, value, &error_flag);
     -+			git_config_bool_or_int(key, value, kvi, &error_flag);
     ++			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
       	else if (!strcmp(key, "options.signoff"))
      -		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
     -+		opts->signoff = git_config_bool_or_int(key, value, kvi, &error_flag);
     ++		opts->signoff = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
       	else if (!strcmp(key, "options.record-origin"))
      -		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
     -+		opts->record_origin = git_config_bool_or_int(key, value, kvi, &error_flag);
     ++		opts->record_origin = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
       	else if (!strcmp(key, "options.allow-ff"))
      -		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
     -+		opts->allow_ff = git_config_bool_or_int(key, value, kvi, &error_flag);
     ++		opts->allow_ff = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
       	else if (!strcmp(key, "options.mainline"))
      -		opts->mainline = git_config_int(key, value);
     -+		opts->mainline = git_config_int(key, value, kvi);
     ++		opts->mainline = git_config_int(key, value, ctx->kvi);
       	else if (!strcmp(key, "options.strategy"))
       		git_config_string_dup(&opts->strategy, key, value);
       	else if (!strcmp(key, "options.gpg-sign"))
      @@ sequencer.c: static int populate_opts_cb(const char *key, const char *value,
     - 		opts->xopts[opts->xopts_nr++] = xstrdup(value);
     + 		strvec_push(&opts->xopts, value);
       	} else if (!strcmp(key, "options.allow-rerere-auto"))
       		opts->allow_rerere_auto =
      -			git_config_bool_or_int(key, value, &error_flag) ?
     -+			git_config_bool_or_int(key, value, kvi, &error_flag) ?
     ++			git_config_bool_or_int(key, value, ctx->kvi, &error_flag) ?
       				RERERE_AUTOUPDATE : RERERE_NOAUTOUPDATE;
       	else if (!strcmp(key, "options.default-msg-cleanup")) {
       		opts->explicit_cleanup = 1;
     @@ setup.c: static int check_repo_format(const char *var, const char *value,
       
       	if (strcmp(var, "core.repositoryformatversion") == 0)
      -		data->version = git_config_int(var, value);
     -+		data->version = git_config_int(var, value, kvi);
     ++		data->version = git_config_int(var, value, ctx->kvi);
       	else if (skip_prefix(var, "extensions.", &ext)) {
       		switch (handle_extension_v0(var, value, ext, data)) {
       		case EXTENSION_ERROR:
     @@ submodule-config.c: static int parse_fetch_recurse(const char *opt, const char *
       
      -int parse_submodule_fetchjobs(const char *var, const char *value)
      +int parse_submodule_fetchjobs(const char *var, const char *value,
     -+			      struct key_value_info *kvi)
     ++			      const struct key_value_info *kvi)
       {
      -	int fetchjobs = git_config_int(var, value);
      +	int fetchjobs = git_config_int(var, value, kvi);
     @@ submodule-config.c: struct fetch_config {
       };
       
       static int gitmodules_fetch_config(const char *var, const char *value,
     --				   struct key_value_info *kvi UNUSED,
     --				   void *cb)
     -+				   struct key_value_info *kvi, void *cb)
     +-				   const struct config_context *ctx UNUSED,
     ++				   const struct config_context *ctx,
     + 				   void *cb)
       {
       	struct fetch_config *config = cb;
       	if (!strcmp(var, "submodule.fetchjobs")) {
       		if (config->max_children)
       			*(config->max_children) =
      -				parse_submodule_fetchjobs(var, value);
     -+				parse_submodule_fetchjobs(var, value, kvi);
     ++				parse_submodule_fetchjobs(var, value, ctx->kvi);
       		return 0;
       	} else if (!strcmp(var, "fetch.recursesubmodules")) {
       		if (config->recurse_submodules)
     @@ submodule-config.c: void fetch_config_from_gitmodules(int *max_children, int *re
       }
       
       static int gitmodules_update_clone_config(const char *var, const char *value,
     --					  struct key_value_info *kvi UNUSED,
     --					  void *cb)
     -+					  struct key_value_info *kvi, void *cb)
     +-					  const struct config_context *ctx UNUSED,
     ++					  const struct config_context *ctx,
     + 					  void *cb)
       {
       	int *max_jobs = cb;
       	if (!strcmp(var, "submodule.fetchjobs"))
      -		*max_jobs = parse_submodule_fetchjobs(var, value);
     -+		*max_jobs = parse_submodule_fetchjobs(var, value, kvi);
     ++		*max_jobs = parse_submodule_fetchjobs(var, value, ctx->kvi);
       	return 0;
       }
       
     @@ submodule-config.h: struct repository;
       
      -int parse_submodule_fetchjobs(const char *var, const char *value);
      +int parse_submodule_fetchjobs(const char *var, const char *value,
     -+			      struct key_value_info *kvi);
     ++			      const struct key_value_info *kvi);
       int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
       struct option;
       int option_fetch_parse_recurse_submodules(const struct option *opt,
     @@ t/helper/test-config.c: static int iterate_cb(const char *var, const char *value
       }
       
       static int parse_int_cb(const char *var, const char *value,
     --			struct key_value_info *kvi UNUSED, void *data)
     -+			struct key_value_info *kvi, void *data)
     +-			const struct config_context *ctx UNUSED, void *data)
     ++			const struct config_context *ctx, void *data)
       {
       	const char *key_to_match = data;
       
       	if (!strcmp(key_to_match, var)) {
      -		int parsed = git_config_int(value, value);
     -+		int parsed = git_config_int(value, value, kvi);
     ++		int parsed = git_config_int(value, value, ctx->kvi);
       		printf("%d\n", parsed);
       	}
       	return 0;
     @@ t/helper/test-config.c: int cmd__config(int argc, const char **argv)
       				printf("(NULL)\n");
       			else
      
     + ## trace2/tr2_cfg.c ##
     +@@ trace2/tr2_cfg.c: struct tr2_cfg_data {
     +  * See if the given config key matches any of our patterns of interest.
     +  */
     + static int tr2_cfg_cb(const char *key, const char *value,
     +-		      const struct config_context *ctx UNUSED, void *d)
     ++		      const struct config_context *ctx, void *d)
     + {
     + 	struct strbuf **s;
     + 	struct tr2_cfg_data *data = (struct tr2_cfg_data *)d;
     +
       ## upload-pack.c ##
      @@ upload-pack.c: static int find_symref(const char *refname,
       }
       
       static int parse_object_filter_config(const char *var, const char *value,
      -				       struct upload_pack_data *data)
     -+				      struct key_value_info *kvi,
     ++				      const struct key_value_info *kvi,
      +				      struct upload_pack_data *data)
       {
       	struct strbuf buf = STRBUF_INIT;
     @@ upload-pack.c: static int parse_object_filter_config(const char *var, const char
       }
       
       static int upload_pack_config(const char *var, const char *value,
     --			      struct key_value_info *kvi UNUSED,
     -+			      struct key_value_info *kvi,
     +-			      const struct config_context *ctx UNUSED,
     ++			      const struct config_context *ctx,
       			      void *cb_data)
       {
       	struct upload_pack_data *data = cb_data;
     @@ upload-pack.c: static int upload_pack_config(const char *var, const char *value,
       			data->allow_uor &= ~ALLOW_ANY_SHA1;
       	} else if (!strcmp("uploadpack.keepalive", var)) {
      -		data->keepalive = git_config_int(var, value);
     -+		data->keepalive = git_config_int(var, value, kvi);
     ++		data->keepalive = git_config_int(var, value, ctx->kvi);
       		if (!data->keepalive)
       			data->keepalive = -1;
       	} else if (!strcmp("uploadpack.allowfilter", var)) {
     @@ upload-pack.c: static int upload_pack_config(const char *var, const char *value,
       	}
       
      -	if (parse_object_filter_config(var, value, data) < 0)
     -+	if (parse_object_filter_config(var, value, kvi, data) < 0)
     ++	if (parse_object_filter_config(var, value, ctx->kvi, data) < 0)
       		return -1;
       
       	return parse_hide_refs_config(var, value, "uploadpack", &data->hidden_refs);
 12:  52db0d3be82 ! 10:  8ec24b018e9 config.c: remove config_reader from configsets
     @@ config.c: int config_with_options(config_fn_t fn, void *data,
      @@ config.c: static int configset_find_element(struct config_set *set, const char *key,
       }
       
     - static int configset_add_value(struct key_value_info *kvi_p,
     + static int configset_add_value(const struct key_value_info *kvi_p,
      -			       struct config_reader *reader,
       			       struct config_set *set, const char *key,
       			       const char *value)
       {
     -@@ config.c: static int configset_add_value(struct key_value_info *kvi_p,
     +@@ config.c: static int configset_add_value(const struct key_value_info *kvi_p,
       	l_item->e = e;
       	l_item->value_index = e->value_list.nr - 1;
       
     @@ config.c: void git_configset_clear(struct config_set *set)
      -#define CONFIGSET_ADD_INIT { 0 }
      -
       static int config_set_callback(const char *key, const char *value,
     - 			       struct key_value_info *kvi, void *cb)
     + 			       const struct config_context *ctx,
     + 			       void *cb)
       {
      -	struct configset_add_data *data = cb;
     --	configset_add_value(kvi, data->config_reader, data->config_set, key, value);
     +-	configset_add_value(ctx->kvi, data->config_reader, data->config_set,
     +-			    key, value);
      +	struct config_set *set = cb;
     -+	configset_add_value(kvi, set, key, value);
     ++	configset_add_value(ctx->kvi, set, key, value);
       	return 0;
       }
       
 13:  7d9b9eefc78 ! 11:  8ae115cff88 config: add kvi.path, use it to evaluate includes
     @@ Commit message
          Include directives are evaluated using the path of the config file. To
          reduce the dependence on "config_reader.source", add a new
          "key_value_info.path" member and use that instead of
     -    "config_source.path".
     +    "config_source.path". This allows us to remove a "struct config_reader
     +    *" field from "struct config_include_data", which will subsequently
     +    allow us to remove "struct config_reader" entirely.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     @@ config.c: static const char include_depth_advice[] = N_(
       "	%s\n"
       "This might be due to circular includes.");
      -static int handle_path_include(struct config_source *cs,
     --			       struct key_value_info *kvi,
     --			       const char *path,
     -+static int handle_path_include(struct key_value_info *kvi, const char *path,
     +-			       const struct key_value_info *kvi,
     ++static int handle_path_include(const struct key_value_info *kvi,
     + 			       const char *path,
       			       struct config_include_data *inc)
       {
     - 	int ret = 0;
      @@ config.c: static int handle_path_include(struct config_source *cs,
       	if (!is_absolute_path(path)) {
       		char *slash;
     @@ config.c: static void add_trailing_starstar_for_dir(struct strbuf *pat)
       }
       
      -static int prepare_include_condition_pattern(struct config_source *cs,
     -+static int prepare_include_condition_pattern(struct key_value_info *kvi,
     ++static int prepare_include_condition_pattern(const struct key_value_info *kvi,
       					     struct strbuf *pat)
       {
       	struct strbuf path = STRBUF_INIT;
     @@ config.c: static int prepare_include_condition_pattern(struct config_source *cs,
       }
       
      -static int include_by_gitdir(struct config_source *cs,
     -+static int include_by_gitdir(struct key_value_info *kvi,
     ++static int include_by_gitdir(const struct key_value_info *kvi,
       			     const struct config_options *opts,
       			     const char *cond, size_t cond_len, int icase)
       {
     @@ config.c: static int include_by_remote_url(struct config_include_data *inc,
       }
       
      -static int include_condition_is_true(struct config_source *cs,
     -+static int include_condition_is_true(struct key_value_info *kvi,
     ++static int include_condition_is_true(const struct key_value_info *kvi,
       				     struct config_include_data *inc,
       				     const char *cond, size_t cond_len)
       {
     @@ config.c: static int include_by_remote_url(struct config_include_data *inc,
       		return include_by_branch(cond, cond_len);
       	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
      @@ config.c: static int git_config_include(const char *var, const char *value,
     - 			      struct key_value_info *kvi, void *data)
     + 			      void *data)
       {
       	struct config_include_data *inc = data;
      -	struct config_source *cs = inc->config_reader->source;
     @@ config.c: static int git_config_include(const char *var, const char *value,
       		return ret;
       
       	if (!strcmp(var, "include.path"))
     --		ret = handle_path_include(cs, kvi, value, inc);
     -+		ret = handle_path_include(kvi, value, inc);
     +-		ret = handle_path_include(cs, ctx->kvi, value, inc);
     ++		ret = handle_path_include(ctx->kvi, value, inc);
       
       	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
      -	    cond && include_condition_is_true(cs, inc, cond, cond_len) &&
     -+	    cond && include_condition_is_true(kvi, inc, cond, cond_len) &&
     ++	    cond && include_condition_is_true(ctx->kvi, inc, cond, cond_len) &&
       	    !strcmp(key, "path")) {
       		config_fn_t old_fn = inc->fn;
       
       		if (inc->opts->unconditional_remote_url)
       			inc->fn = forbid_remote_url;
     --		ret = handle_path_include(cs, kvi, value, inc);
     -+		ret = handle_path_include(kvi, value, inc);
     +-		ret = handle_path_include(cs, ctx->kvi, value, inc);
     ++		ret = handle_path_include(ctx->kvi, value, inc);
       		inc->fn = old_fn;
       	}
       
     @@ config.h: struct key_value_info {
       	enum config_scope scope;
      +	const char *path;
       };
     + #define KVI_INIT { \
     + 	.filename = NULL, \
     + 	.linenr = -1, \
     + 	.origin_type = CONFIG_ORIGIN_UNKNOWN, \
     + 	.scope = CONFIG_SCOPE_UNKNOWN, \
     ++	.path = NULL, \
     + }
       
     - /**
     + /* Captures additional information that a config callback can use. */
 14:  9e35b5b1f4d ! 12:  484d553cc7d config: pass source to config_parser_event_fn_t
     @@ Commit message
      
          ..so that the callback can use a "struct config_source" parameter
          instead of "config_reader.source". "struct config_source" is internal to
     -    config.c, but this refactor is okay because this function has only ever
     -    been (and probably ever will be) used internally by config.c.
     +    config.c, so we are adding a pointer to a struct defined in config.c
     +    into a public function signature defined in config.h, but this is okay
     +    because this function has only ever been (and probably ever will be)
     +    used internally by config.c.
      
          As a result, the_reader isn't used anywhere, so "struct config_reader"
          is obsolete (it was only intended to be used with the_reader). Remove
     @@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
       	int ret = 0;
       	char *envw = NULL;
      -	struct config_source source = CONFIG_SOURCE_INIT;
     - 	struct key_value_info kvi = { 0 };
     + 	struct key_value_info kvi = KVI_INIT;
       
      -	source.origin_type = CONFIG_ORIGIN_CMDLINE;
      -	config_reader_push_source(&the_reader, &source);

-- 
gitgitgadget
