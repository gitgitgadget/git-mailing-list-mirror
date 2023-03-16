Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5CBC61DA4
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 00:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjCPAMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 20:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjCPAL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 20:11:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B313645B
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 17:11:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so2379848wmq.1
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 17:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678925509;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c+l9Q77CFHFPmd+H3MGqM7u2zWlCDJUneyS0it8qzI=;
        b=BQDQ0NpaT+j+fPG57EaBYOnJZMBpZ9hqaWDpQmpdrQrY5493y8Ju/a3Ecis7p8EMvL
         6LB+B+YbJhF95FkDJJ2uQef2bXmqsoSedOOx9VjGlEHtsZB+lHYpl/yQtP5N3ZzAJlMR
         pLHKLFbKjDhfZzGCd3bPfkaItDcyNKvWc/C0XO2V7QRphUuiW5zts1d3SCNiLhMOPLcC
         iSpamgxm4N9xD5iiJMBtvjPzW4eQB93+j921uvsyWww9Y31iqv4Zg6uH5tN5udke2Sbz
         hiSEG9/ws6sXC+X5RY7TTu15PvU0R7LzOVkWgU4s4OD2baCEwnXZKIAE0VEHWaAbFXUS
         K8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678925509;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5c+l9Q77CFHFPmd+H3MGqM7u2zWlCDJUneyS0it8qzI=;
        b=XAL/H3NCpUHC491Z156lD9B9vSfp5mz5RMgTPnchC5AEbYP0SrimBHXPXbeiOLQDTh
         Y6k8qsHUomZsJY2KjYo4oj8TNSHRbjQefg+JY5Ap3QrYkqRbw6ZYlwPmPqUkXx6dImat
         REN13Q9n4bHUDVxSo1SKosWvogphV6knH8Ya2h8BHawmdb9apcu6N354XTtk3H804edH
         4MComB0tPGRnZF5VGfE39Yd3KpfYmG8RBrp4yFdjbsQ/dRvDI6pvUsgo3mMfl4DHLxBY
         oISCW0KuVmQ6q4KrClEhaOpHws95VlgOPBeMB8tItU4/skJnP7JutHjnVrvpjQJTKIYN
         Hu7w==
X-Gm-Message-State: AO0yUKX9q8F4nZAC1bjNJFzBrzIUPoAzYwlkXsYtM9Zfec31Tf2V72Mi
        ypgqrjnpMnlK+fGI/j5vgco2IRCELA8=
X-Google-Smtp-Source: AK7set+OUB2fopRboUGxt1kYORdrhcIdplZNtMOs6vMr7PgwJRJPGM3C4hnwR0nZwmskkrTzabENsw==
X-Received: by 2002:a05:600c:4f86:b0:3ed:29d9:56ae with SMTP id n6-20020a05600c4f8600b003ed29d956aemr10002233wmq.6.1678925508250;
        Wed, 15 Mar 2023 17:11:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3-20020a1ced03000000b003ed29f5616dsm3159506wmh.4.2023.03.15.17.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 17:11:47 -0700 (PDT)
Message-Id: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Mar 2023 00:11:38 +0000
Subject: [PATCH v2 0/8] config.c: use struct for config reading state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note to Junio: 8/8 (which renames "cs" -> "set") conflicts with
ab/config-multi-and-nonbool. The resolution is to rename "cs" -> "set" in
the conflicted hunks. This leaves a few "struct config_set cs" in
unconflicted hunks, but since 8/8 might be controversial, I don't think it's
worth your time to fix these. I'll reroll this and base it on top of
ab/config-multi-and-nonbool instead (since that is pretty stable and close
to being merged).

Thanks for the thoughtful review on v1, all. I'm sending this as a regular
series, not an RFC.

After reflecting on Ævar's responses on v1, I'm fairly convinced that
"struct config_reader" shouldn't exist in the long term. I've written my
thoughts on a good long term direction in the "Leftover bits" section. Based
on that, I've also updated my WIP libification patches [1] to remove "struct
config_reader" from the library interface, and think it looks a lot better
as a result.

= Changes in v2

 * To reduce churn, don't rename "struct config_source cf" to "cs" early in
   the series. Instead, rename the global "cf" to "cf_global", and leave the
   existing "cf"s untouched.
   
   Introduce 8/8 to get rid of the confusing acronym "struct config_source
   cf", but I don't mind ejecting it if it's too much churn.

 * Adjust 5/8 so to pass "struct config_reader" through args instead of
   "*data". v1 made the mistake of thinking "*data" was being passed to a
   callback, but it wasn't.

 * Add a 7/8 to fix a bug in die_bad_number(). I included this because it
   overlaps a little bit with the refactor here, but I don't mind ejecting
   this either.

 * Assorted BUG() message clarifications.

As a result of moving the rename, the range-diff is quite noisy. The diff
between the final commits is might be helpful instead [2] (I'll also send a
diff to the ML).

= Description

This series prepares for config.[ch] to be libified as as part of the
libification effort that Emily described in [3]. One of the first goals is
to read config from a file, but the trouble with how config.c is written
today is that all reading operations rely on global state, so before turning
that into a library, we'd want to make that state non-global.

This series doesn't remove all of the global state, but it gets us closer to
that goal by extracting the global config reading state into "struct
config_reader" and plumbing it through the config reading machinery. This
makes it possible to reuse the config machinery without global state, and to
enforce some constraints on "struct config_reader", which makes it more
predictable and easier to remove in the long run.

This process is very similar to how we've plumbed "struct repository" and
other 'context objects' in the past, except:

 * The global state (named "the_reader") for the git process lives in a
   config.c static variable, and not on "the_repository". See 3/6 for the
   rationale.

 * I've stopped short of adding "struct config_reader" to config.h public
   functions, since that would affect non-config.c callers.

Additionally, I've included a bugfix for die_bad_number() that became clear
as I did this refactor.

= Leftover bits

We still need a global "the_reader" because config callbacks are reading
auxiliary information about the config (e.g. line number, file name) via
global functions (e.g. current_config_line(), current_config_name()). This
is either because the callback uses this info directly (like
builtin/config.c printing the filename and scope of the value) or for error
reporting (like git_parse_int() reporting the filename of the value it
failed to parse).

If we had a way to plumb the state from "struct config_reader" to the config
callback functions, we could initialize "struct config_reader" in the config
machinery whenever we read config (instead of asking the caller to
initialize "struct config_reader" themselves), and config reading could
become a thread-safe operation. There isn't an obvious way to plumb this
state to config callbacks without adding an additional arg to config_fn_t
and incurring a lot of churn, but if we start replacing "config_fn_t" with
the configset API (which we've independently wanted for some time), this may
become feasible.

And if we do this, "struct config_reader" itself will probably become
obsolete, because we'd be able to plumb only the relevant state for the
current operation, e.g. if we are parsing a config file, we'd pass only the
config file parsing state, instead of "struct config_reader", which also
contains config set iterating state. In such a scenario, we'd probably want
to pass "struct key_value_info" to the config callback, since that's all the
callback should be interested in anyway. Interestingly, this was proposed by
Junio back in [4], and we didn't do this back then out of concern for the
churn (just like in v1).

[1]
https://github.com/git/git/compare/master...chooglen:git:config-lib-parsing
[2]
https://github.com/gitgitgadget/git/compare/pr-git-1463/chooglen/config/structify-reading-v1..chooglen:git:config/structify-reading
[3]
https://lore.kernel.org/git/CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com
[4]
https://lore.kernel.org/git/CAPc5daV6bdUKS-ExHmpT4Ppy2S832NXoyPw7aOLP7fG=WrBPgg@mail.gmail.com/

Glen Choo (8):
  config.c: plumb config_source through static fns
  config.c: don't assign to "cf_global" directly
  config.c: create config_reader and the_reader
  config.c: plumb the_reader through callbacks
  config.c: remove current_config_kvi
  config.c: remove current_parsing_scope
  config: report cached filenames in die_bad_number()
  config.c: rename "struct config_source cf"

 config.c               | 585 ++++++++++++++++++++++++-----------------
 config.h               |   1 +
 t/helper/test-config.c |  17 ++
 t/t1308-config-set.sh  |   9 +
 4 files changed, 369 insertions(+), 243 deletions(-)


base-commit: dadc8e6dacb629f46aee39bde90b6f09b73722eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1463%2Fchooglen%2Fconfig%2Fstructify-reading-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1463/chooglen/config/structify-reading-v2
Pull-Request: https://github.com/git/git/pull/1463

Range-diff vs v1:

 -:  ----------- > 1:  75d0f0efb79 config.c: plumb config_source through static fns
 2:  9f72cbb8d78 ! 2:  7555da0b0e0 config.c: don't assign to "cf" directly
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    config.c: don't assign to "cf" directly
     +    config.c: don't assign to "cf_global" directly
      
     -    To make "cf" easier to remove, replace all direct assignments to it with
     -    function calls. This refactor has an additional maintainability benefit:
     -    all of these functions were manually implementing stack pop/push
     -    semantics on "struct config_source", so replacing them with function
     -    calls allows us to only implement this logic once.
     +    To make "cf_global" easier to remove, replace all direct assignments to
     +    it with function calls. This refactor has an additional maintainability
     +    benefit: all of these functions were manually implementing stack
     +    pop/push semantics on "struct config_source", so replacing them with
     +    function calls allows us to only implement this logic once.
      
          In this process, perform some now-obvious clean ups:
      
     -    - Drop some unnecessary "cf" assignments in populate_remote_urls().
     -      Since it was introduced in 399b198489 (config: include file if remote
     -      URL matches a glob, 2022-01-18), it has stored and restored the value
     -      of "cf" to ensure that it doesn't get accidentally mutated. However,
     -      this was never necessary since "do_config_from()" already pushes/pops
     -      "cf" further down the call chain.
     +    - Drop some unnecessary "cf_global" assignments in
     +      populate_remote_urls(). Since it was introduced in 399b198489 (config:
     +      include file if remote URL matches a glob, 2022-01-18), it has stored
     +      and restored the value of "cf_global" to ensure that it doesn't get
     +      accidentally mutated. However, this was never necessary since
     +      "do_config_from()" already pushes/pops "cf_global" further down the
     +      call chain.
      
          - Zero out every "struct config_source" with a dedicated initializer.
     -      This matters because the "struct config_source" is assigned to "cf"
     -      and we later 'pop the stack' by assigning "cf = cf->prev", but
     -      "cf->prev" could be pointing to uninitialized garbage.
     +      This matters because the "struct config_source" is assigned to
     +      "cf_global" and we later 'pop the stack' by assigning "cf_global =
     +      cf_global->prev", but "cf_global->prev" could be pointing to
     +      uninitialized garbage.
      
            Fortunately, this has never bothered us since we never try to read
     -      "cf" except while iterating through config, in which case, "cf" is
     -      either set to a sensible value (when parsing a file), or it is ignored
     -      (when iterating a configset). Later in the series, zero-ing out memory
     -      will also let us enforce the constraint that "cf" and
     -      "current_config_kvi" are never non-NULL together.
     +      "cf_global" except while iterating through config, in which case,
     +      "cf_global" is either set to a sensible value (when parsing a file),
     +      or it is ignored (when iterating a configset). Later in the series,
     +      zero-ing out memory will also let us enforce the constraint that
     +      "cf_global" and "current_config_kvi" are never non-NULL together.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     @@ config.c: static struct key_value_info *current_config_kvi;
        */
       static enum config_scope current_parsing_scope;
       
     -+static inline void config_state_push_source(struct config_source *top)
     ++static inline void config_reader_push_source(struct config_source *top)
      +{
     -+	if (cf)
     -+		top->prev = cf;
     -+	cf = top;
     ++	if (cf_global)
     ++		top->prev = cf_global;
     ++	cf_global = top;
      +}
      +
     -+static inline struct config_source *config_state_pop_source()
     ++static inline struct config_source *config_reader_pop_source()
      +{
      +	struct config_source *ret;
     -+	if (!cf)
     ++	if (!cf_global)
      +		BUG("tried to pop config source, but we weren't reading config");
     -+	ret = cf;
     -+	cf = cf->prev;
     ++	ret = cf_global;
     ++	cf_global = cf_global->prev;
      +	return ret;
      +}
      +
     @@ config.c: static void populate_remote_urls(struct config_include_data *inc)
       {
       	struct config_options opts;
       
     --	struct config_source *store_cf = cf;
     +-	struct config_source *store_cf = cf_global;
       	struct key_value_info *store_kvi = current_config_kvi;
       	enum config_scope store_scope = current_parsing_scope;
       
       	opts = *inc->opts;
       	opts.unconditional_remote_url = 1;
       
     --	cf = NULL;
     +-	cf_global = NULL;
       	current_config_kvi = NULL;
       	current_parsing_scope = 0;
       
     @@ config.c: static void populate_remote_urls(struct config_include_data *inc)
       	string_list_init_dup(inc->remote_urls);
       	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
       
     --	cf = store_cf;
     +-	cf_global = store_cf;
       	current_config_kvi = store_kvi;
       	current_parsing_scope = store_scope;
       }
     @@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
      +	struct config_source source = CONFIG_SOURCE_INIT;
       
      -	memset(&source, 0, sizeof(source));
     --	source.prev = cf;
     +-	source.prev = cf_global;
       	source.origin_type = CONFIG_ORIGIN_CMDLINE;
     --	cf = &source;
     -+	config_state_push_source(&source);
     +-	cf_global = &source;
     ++	config_reader_push_source(&source);
       
       	env = getenv(CONFIG_COUNT_ENVIRONMENT);
       	if (env) {
     @@ config.c: out:
       	strbuf_release(&envvar);
       	strvec_clear(&to_free);
       	free(envw);
     --	cf = source.prev;
     -+	config_state_pop_source();
     +-	cf_global = source.prev;
     ++	config_reader_pop_source();
       	return ret;
       }
       
     @@ config.c: static int do_config_from(struct config_source *top, config_fn_t fn, v
       	int ret;
       
       	/* push config-file parsing state stack */
     --	top->prev = cf;
     +-	top->prev = cf_global;
       	top->linenr = 1;
       	top->eof = 0;
       	top->total_len = 0;
       	strbuf_init(&top->value, 1024);
       	strbuf_init(&top->var, 1024);
     --	cf = top;
     -+	config_state_push_source(top);
     +-	cf_global = top;
     ++	config_reader_push_source(top);
       
     --	ret = git_parse_source(cf, fn, data, opts);
     -+	ret = git_parse_source(top, fn, data, opts);
     + 	ret = git_parse_source(top, fn, data, opts);
       
       	/* pop config-file parsing state stack */
       	strbuf_release(&top->value);
       	strbuf_release(&top->var);
     --	cf = top->prev;
     -+	config_state_pop_source();
     +-	cf_global = top->prev;
     ++	config_reader_pop_source();
       
       	return ret;
       }
 3:  751ce3e927d ! 3:  4347896f0a4 config.c: create config_reader and the_reader
     @@ Commit message
      
          Create "struct config_reader" to hold the state of the config source
          currently being read. Then, create a static instance of it,
     -    "the_reader", and use "the_reader.source" to replace references to "cf"
     -    in public functions.
     +    "the_reader", and use "the_reader.source" to replace references to
     +    "cf_global" in public functions.
      
          This doesn't create much immediate benefit (since we're mostly replacing
          static variables with a bigger static variable), but it prepares us for
     -    a future where this state doesn't have to be global; the "struct
     -    config_reader" could be provided by the caller, or constructed
     -    internally by a function like "do_config_from()".
     +    a future where this state doesn't have to be global; "struct
     +    config_reader" (or a similar struct) could be provided by the caller, or
     +    constructed internally by a function like "do_config_from()".
      
          A more typical approach would be to put this struct on "the_repository",
          but that's a worse fit for this use case since config reading is not
     @@ Commit message
          t9210, where test-tool and scalar parse config but don't fully
          initialize "the_repository".
      
     -    We could have also replaced the references to "cf" in callback functions
     -    (which are the only ones left), but we'll eventually plumb "the_reader"
     -    through the callback "*data" arg, which will allow us to rename "cf" to
     -    "cs" without changing line lengths. Until we remove "cf" altogether,
     -    add logic to "config_reader_*_source()" to keep "cf" and
     -    "the_reader.source" in sync.
     +    We could have also replaced the references to "cf_global" in callback
     +    functions (which are the only ones left), but we'll eventually plumb
     +    "the_reader" through the callback "*data" arg, so that would be
     +    unnecessary churn. Until we remove "cf_global" altogether, add logic to
     +    "config_reader_*_source()" to keep "cf_global" and "the_reader.source"
     +    in sync.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     @@ config.c: struct config_source {
      +struct config_reader {
      +	struct config_source *source;
      +};
     -+/* Only public functions should reference the_reader. */
     ++/*
     ++ * Where possible, prefer to accept "struct config_reader" as an arg than to use
     ++ * "the_reader". "the_reader" should only be used if that is infeasible, e.g. in
     ++ * a public function.
     ++ */
      +static struct config_reader the_reader;
      +
       /*
     @@ config.c: struct config_source {
        * or it's a function which can be reused for non-config purposes, and should
        * fall back to some sane behavior).
      + *
     -+ * FIXME "cf" has been replaced by "the_reader.source", remove
     -+ * "cf" once we plumb "the_reader" through all of the callback functions.
     ++ * FIXME "cf_global" has been replaced by "the_reader.source", remove
     ++ * "cf_global" once we plumb "the_reader" through all of the callback functions.
        */
     - static struct config_source *cf;
     + static struct config_source *cf_global;
       static struct key_value_info *current_config_kvi;
      @@ config.c: static struct key_value_info *current_config_kvi;
        */
       static enum config_scope current_parsing_scope;
       
     --static inline void config_state_push_source(struct config_source *top)
     +-static inline void config_reader_push_source(struct config_source *top)
      +static inline void config_reader_push_source(struct config_reader *reader,
      +					     struct config_source *top)
       {
     --	if (cf)
     --		top->prev = cf;
     --	cf = top;
     +-	if (cf_global)
     +-		top->prev = cf_global;
     +-	cf_global = top;
      +	if (reader->source)
      +		top->prev = reader->source;
      +	reader->source = top;
     -+	/* FIXME remove this when cf is removed. */
     -+	cf = reader->source;
     ++	/* FIXME remove this when cf_global is removed. */
     ++	cf_global = reader->source;
       }
       
     --static inline struct config_source *config_state_pop_source()
     +-static inline struct config_source *config_reader_pop_source()
      +static inline struct config_source *config_reader_pop_source(struct config_reader *reader)
       {
       	struct config_source *ret;
     --	if (!cf)
     +-	if (!cf_global)
      +	if (!reader->source)
       		BUG("tried to pop config source, but we weren't reading config");
     --	ret = cf;
     --	cf = cf->prev;
     +-	ret = cf_global;
     +-	cf_global = cf_global->prev;
      +	ret = reader->source;
      +	reader->source = reader->source->prev;
      +	/* FIXME remove this when cf is removed. */
     -+	cf = reader->source;
     ++	cf_global = reader->source;
       	return ret;
       }
       
     @@ config.c: int git_config_from_parameters(config_fn_t fn, void *data)
       	struct config_source source = CONFIG_SOURCE_INIT;
       
       	source.origin_type = CONFIG_ORIGIN_CMDLINE;
     --	config_state_push_source(&source);
     +-	config_reader_push_source(&source);
      +	config_reader_push_source(&the_reader, &source);
       
       	env = getenv(CONFIG_COUNT_ENVIRONMENT);
     @@ config.c: out:
       	strbuf_release(&envvar);
       	strvec_clear(&to_free);
       	free(envw);
     --	config_state_pop_source();
     +-	config_reader_pop_source();
      +	config_reader_pop_source(&the_reader);
       	return ret;
       }
     @@ config.c: int git_config_int(const char *name, const char *value)
       {
       	int ret;
       	if (!git_parse_int(value, &ret))
     --		die_bad_number(cf, name, value);
     +-		die_bad_number(cf_global, name, value);
      +		die_bad_number(the_reader.source, name, value);
       	return ret;
       }
     @@ config.c: int64_t git_config_int64(const char *name, const char *value)
       {
       	int64_t ret;
       	if (!git_parse_int64(value, &ret))
     --		die_bad_number(cf, name, value);
     +-		die_bad_number(cf_global, name, value);
      +		die_bad_number(the_reader.source, name, value);
       	return ret;
       }
     @@ config.c: unsigned long git_config_ulong(const char *name, const char *value)
       {
       	unsigned long ret;
       	if (!git_parse_ulong(value, &ret))
     --		die_bad_number(cf, name, value);
     +-		die_bad_number(cf_global, name, value);
      +		die_bad_number(the_reader.source, name, value);
       	return ret;
       }
     @@ config.c: ssize_t git_config_ssize_t(const char *name, const char *value)
       {
       	ssize_t ret;
       	if (!git_parse_ssize_t(value, &ret))
     --		die_bad_number(cf, name, value);
     +-		die_bad_number(cf_global, name, value);
      +		die_bad_number(the_reader.source, name, value);
       	return ret;
       }
     @@ config.c: static int do_config_from(struct config_source *top, config_fn_t fn, v
       	top->total_len = 0;
       	strbuf_init(&top->value, 1024);
       	strbuf_init(&top->var, 1024);
     --	config_state_push_source(top);
     +-	config_reader_push_source(top);
      +	config_reader_push_source(reader, top);
       
       	ret = git_parse_source(top, fn, data, opts);
     @@ config.c: static int do_config_from(struct config_source *top, config_fn_t fn, v
       	/* pop config-file parsing state stack */
       	strbuf_release(&top->value);
       	strbuf_release(&top->var);
     --	config_state_pop_source();
     +-	config_reader_pop_source();
      +	config_reader_pop_source(reader);
       
       	return ret;
     @@ config.c: const char *current_config_origin_type(void)
       	int type;
       	if (current_config_kvi)
       		type = current_config_kvi->origin_type;
     --	else if(cf)
     --		type = cf->origin_type;
     +-	else if(cf_global)
     +-		type = cf_global->origin_type;
      +	else if(the_reader.source)
      +		type = the_reader.source->origin_type;
       	else
     @@ config.c: const char *current_config_name(void)
       	const char *name;
       	if (current_config_kvi)
       		name = current_config_kvi->filename;
     --	else if (cf)
     --		name = cf->name;
     +-	else if (cf_global)
     +-		name = cf_global->name;
      +	else if (the_reader.source)
      +		name = the_reader.source->name;
       	else
     @@ config.c: int current_config_line(void)
       	if (current_config_kvi)
       		return current_config_kvi->linenr;
       	else
     --		return cf->linenr;
     +-		return cf_global->linenr;
      +		return the_reader.source->linenr;
       }
       
 4:  74a63fed705 ! 4:  22b69971749 config.c: plumb the_reader through callbacks
     @@ Metadata
       ## Commit message ##
          config.c: plumb the_reader through callbacks
      
     -    The remaining references to "cf" are in config callback functions.
     -    Remove them by plumbing "struct config_reader" via the "*data" arg.
     +    The remaining references to "cf_global" are in config callback
     +    functions. Remove them by plumbing "struct config_reader" via the
     +    "*data" arg.
      
     -    **RFC NOTE** If we had a way to expose "struct config_reader" to the
     -    config callback functions (the 'extra work' in the cover letter), we
     -    wouldn't need to also pass it via the "*data" arg. This is more of a
     -    hack to avoid doing that work now.
     +    In both of the callbacks here, we are only reading from
     +    "reader->source". So in the long run, if we had a way to expose readonly
     +    information from "reader->source" (probably in the form of "struct
     +    key_value_info"), we could undo this patch (i.e. remove "struct
     +    config_reader" fom "*data").
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     @@ config.c: struct config_reader {
       static struct config_reader the_reader;
       
       /*
     -+ * FIXME The comments are temporarily out of date since "cf" been moved to
     -+ * the_reader, but not current_*.
     ++ * FIXME The comments are temporarily out of date since "cf_global" has been
     ++ * moved to the_reader, but not current_*.
      + *
        * These variables record the "current" config source, which
        * can be accessed by parsing callbacks.
     @@ config.c: static struct config_reader the_reader;
        * or it's a function which can be reused for non-config purposes, and should
        * fall back to some sane behavior).
      - *
     -- * FIXME "cf" has been replaced by "the_reader.source", remove
     -- * "cf" once we plumb "the_reader" through all of the callback functions.
     +- * FIXME "cf_global" has been replaced by "the_reader.source", remove
     +- * "cf_global" once we plumb "the_reader" through all of the callback functions.
        */
     --static struct config_source *cf;
     +-static struct config_source *cf_global;
       static struct key_value_info *current_config_kvi;
       
       /*
     @@ config.c: static inline void config_reader_push_source(struct config_reader *rea
       	if (reader->source)
       		top->prev = reader->source;
       	reader->source = top;
     --	/* FIXME remove this when cf is removed. */
     --	cf = reader->source;
     +-	/* FIXME remove this when cf_global is removed. */
     +-	cf_global = reader->source;
       }
       
       static inline struct config_source *config_reader_pop_source(struct config_reader *reader)
     @@ config.c: static inline struct config_source *config_reader_pop_source(struct co
       	ret = reader->source;
       	reader->source = reader->source->prev;
      -	/* FIXME remove this when cf is removed. */
     --	cf = reader->source;
     +-	cf_global = reader->source;
       	return ret;
       }
       
     @@ config.c: struct config_include_data {
       
       	/*
       	 * All remote URLs discovered when reading all config files.
     -@@ config.c: static int include_condition_is_true(struct config_source *cs,
     +@@ config.c: static int include_condition_is_true(struct config_source *cf,
       static int git_config_include(const char *var, const char *value, void *data)
       {
       	struct config_include_data *inc = data;
     -+	struct config_source *cs = inc->config_reader->source;
     ++	struct config_source *cf = inc->config_reader->source;
       	const char *cond, *key;
       	size_t cond_len;
       	int ret;
     @@ config.c: static int git_config_include(const char *var, const char *value, void
       		return ret;
       
       	if (!strcmp(var, "include.path"))
     --		ret = handle_path_include(cf, value, inc);
     -+		ret = handle_path_include(cs, value, inc);
     +-		ret = handle_path_include(cf_global, value, inc);
     ++		ret = handle_path_include(cf, value, inc);
       
       	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
     --	    cond && include_condition_is_true(cf, inc, cond, cond_len) &&
     -+	    cond && include_condition_is_true(cs, inc, cond, cond_len) &&
     +-	    cond && include_condition_is_true(cf_global, inc, cond, cond_len) &&
     ++	    cond && include_condition_is_true(cf, inc, cond, cond_len) &&
       	    !strcmp(key, "path")) {
       		config_fn_t old_fn = inc->fn;
       
       		if (inc->opts->unconditional_remote_url)
       			inc->fn = forbid_remote_url;
     --		ret = handle_path_include(cf, value, inc);
     -+		ret = handle_path_include(cs, value, inc);
     +-		ret = handle_path_include(cf_global, value, inc);
     ++		ret = handle_path_include(cf, value, inc);
       		inc->fn = old_fn;
       	}
       
     @@ config.c: static int configset_add_value(struct config_set *cs, const char *key,
       	l_item->e = e;
       	l_item->value_index = e->value_list.nr - 1;
       
     --	if (!cf)
     +-	if (!cf_global)
      +	if (!reader->source)
       		BUG("configset_add_value has no source");
     --	if (cf->name) {
     --		kv_info->filename = strintern(cf->name);
     --		kv_info->linenr = cf->linenr;
     --		kv_info->origin_type = cf->origin_type;
     +-	if (cf_global->name) {
     +-		kv_info->filename = strintern(cf_global->name);
     +-		kv_info->linenr = cf_global->linenr;
     +-		kv_info->origin_type = cf_global->origin_type;
      +	if (reader->source->name) {
      +		kv_info->filename = strintern(reader->source->name);
      +		kv_info->linenr = reader->source->linenr;
     @@ config.c: static int store_aux_event(enum config_event_t type,
       			   size_t begin, size_t end, void *data)
       {
       	struct config_store_data *store = data;
     -+	struct config_source *cs = store->config_reader->source;
     +-	/*
     +-	 * FIXME Keep using "cf" so that we can avoid rewrapping a
     +-	 * really long line below. Remove this when "cf" gets plumbed
     +-	 * correctly.
     +-	 */
     +-	struct config_source *cf = cf_global;
     ++	struct config_source *cf = store->config_reader->source;
       
       	ALLOC_GROW(store->parsed, store->parsed_nr + 1, store->parsed_alloc);
       	store->parsed[store->parsed_nr].begin = begin;
     -@@ config.c: static int store_aux_event(enum config_event_t type,
     - 	if (type == CONFIG_EVENT_SECTION) {
     - 		int (*cmpfn)(const char *, const char *, size_t);
     - 
     --		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
     --			return error(_("invalid section name '%s'"), cf->var.buf);
     -+		if (cs->var.len < 2 || cs->var.buf[cs->var.len - 1] != '.')
     -+			return error(_("invalid section name '%s'"), cs->var.buf);
     - 
     --		if (cf->subsection_case_sensitive)
     -+		if (cs->subsection_case_sensitive)
     - 			cmpfn = strncasecmp;
     - 		else
     - 			cmpfn = strncmp;
     -@@ config.c: static int store_aux_event(enum config_event_t type,
     - 		/* Is this the section we were looking for? */
     - 		store->is_keys_section =
     - 			store->parsed[store->parsed_nr].is_keys_section =
     --			cf->var.len - 1 == store->baselen &&
     --			!cmpfn(cf->var.buf, store->key, store->baselen);
     -+			cs->var.len - 1 == store->baselen &&
     -+			!cmpfn(cs->var.buf, store->key, store->baselen);
     - 		if (store->is_keys_section) {
     - 			store->section_seen = 1;
     - 			ALLOC_GROW(store->seen, store->seen_nr + 1,
      @@ config.c: int git_config_set_multivar_in_file_gently(const char *config_filename,
       	char *filename_buf = NULL;
       	char *contents = NULL;
 5:  c05b33ab29d ! 5:  afb6e3e318d config.c: remove current_config_kvi
     @@ Commit message
          config.c: remove current_config_kvi
      
          Add ".config_kvi" to "struct config_reader" and replace
     -    "current_config_kvi" with "the_reader.config_kvi", either in-place (in
     -    public functions) or by passing "the_reader" to the "*data" arg of
     -    callback functions.
     +    "current_config_kvi" with "the_reader.config_kvi", plumbing "struct
     +    config_reader" where necesssary.
      
          Also, introduce a setter function for ".config_kvi", which allows us to
          enforce the contraint that only one of ".source" and ".config_kvi" can
     @@ config.c: struct config_source {
       	struct config_source *source;
      +	struct key_value_info *config_kvi;
       };
     - /* Only public functions should reference the_reader. */
     + /*
     +  * Where possible, prefer to accept "struct config_reader" as an arg than to use
     +@@ config.c: struct config_reader {
     +  */
       static struct config_reader the_reader;
       
      -/*
     -- * FIXME The comments are temporarily out of date since "cf" been moved to
     -- * the_reader, but not current_*.
     +- * FIXME The comments are temporarily out of date since "cf_global" has been
     +- * moved to the_reader, but not current_*.
      - *
      - * These variables record the "current" config source, which
      - * can be accessed by parsing callbacks.
      - *
     -- * The "cf" variable will be non-NULL only when we are actually parsing a real
     -- * config source (file, blob, cmdline, etc).
     +- * The "cf_global" variable will be non-NULL only when we are actually
     +- * parsing a real config source (file, blob, cmdline, etc).
      - *
      - * The "current_config_kvi" variable will be non-NULL only when we are feeding
      - * cached config from a configset into a callback.
     @@ config.c: static enum config_scope current_parsing_scope;
       					     struct config_source *top)
       {
      +	if (reader->config_kvi)
     -+		BUG("source should only be set when parsing a config source");
     ++		BUG("source should not be set while iterating a config set");
       	if (reader->source)
       		top->prev = reader->source;
       	reader->source = top;
     @@ config.c: static inline struct config_source *config_reader_pop_source(struct co
      +					 struct key_value_info *kvi)
      +{
      +	if (kvi && reader->source)
     -+		BUG("kvi should only be set when iterating through configset");
     ++		BUG("kvi should not be set while parsing a config source");
      +	reader->config_kvi = kvi;
      +}
      +
     @@ config.c: int config_with_options(config_fn_t fn, void *data,
       	return ret;
       }
       
     -+struct configset_iter_data {
     -+	struct config_reader *config_reader;
     -+	void *inner;
     -+};
     -+#define CONFIGSET_ITER_INIT { 0 }
     -+
     - static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
     +-static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
     ++static void configset_iter(struct config_reader *reader, struct config_set *cs,
     ++			   config_fn_t fn, void *data)
       {
       	int i, value_index;
       	struct string_list *values;
     - 	struct config_set_element *entry;
     - 	struct configset_list *list = &cs->list;
     -+	struct configset_iter_data *iter_data = data;
     - 
     - 	for (i = 0; i < list->nr; i++) {
     -+		struct key_value_info *kvi;
     - 		entry = list->items[i].e;
     +@@ config.c: static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
       		value_index = list->items[i].value_index;
       		values = &entry->value_list;
       
      -		current_config_kvi = values->items[value_index].util;
     -+		kvi = values->items[value_index].util;
     -+		config_reader_set_kvi(iter_data->config_reader, kvi);
     ++		config_reader_set_kvi(reader, values->items[value_index].util);
       
     --		if (fn(entry->key, values->items[value_index].string, data) < 0)
     --			git_die_config_linenr(entry->key,
     + 		if (fn(entry->key, values->items[value_index].string, data) < 0)
     + 			git_die_config_linenr(entry->key,
      -					      current_config_kvi->filename,
      -					      current_config_kvi->linenr);
     -+		if (fn(entry->key, values->items[value_index].string, iter_data->inner) < 0)
     -+			git_die_config_linenr(entry->key, kvi->filename,
     -+					      kvi->linenr);
     ++					      reader->config_kvi->filename,
     ++					      reader->config_kvi->linenr);
       
      -		current_config_kvi = NULL;
     -+		config_reader_set_kvi(iter_data->config_reader, NULL);
     ++		config_reader_set_kvi(reader, NULL);
       	}
       }
       
      @@ config.c: static void repo_config_clear(struct repository *repo)
     - 	git_configset_clear(repo->config);
     - }
     - 
     --void repo_config(struct repository *repo, config_fn_t fn, void *data)
     -+void repo_config(struct repository *repo, config_fn_t fn, void *data_inner)
     + void repo_config(struct repository *repo, config_fn_t fn, void *data)
       {
     -+	struct configset_iter_data data = CONFIGSET_ITER_INIT;
     -+	data.inner = data_inner;
     -+	data.config_reader = &the_reader;
     -+
       	git_config_check_init(repo);
      -	configset_iter(repo->config, fn, data);
     -+	configset_iter(repo->config, fn, &data);
     ++	configset_iter(&the_reader, repo->config, fn, data);
       }
       
       int repo_config_get_value(struct repository *repo,
     -@@ config.c: static void read_protected_config(void)
     - 	config_with_options(config_set_callback, &data, NULL, &opts);
     - }
     - 
     --void git_protected_config(config_fn_t fn, void *data)
     -+void git_protected_config(config_fn_t fn, void *data_inner)
     +@@ config.c: void git_protected_config(config_fn_t fn, void *data)
       {
     -+	struct configset_iter_data data = CONFIGSET_ITER_INIT;
       	if (!protected_config.hash_initialized)
       		read_protected_config();
      -	configset_iter(&protected_config, fn, data);
     -+	data.inner = data_inner;
     -+	data.config_reader = &the_reader;
     -+
     -+	configset_iter(&protected_config, fn, &data);
     ++	configset_iter(&the_reader, &protected_config, fn, data);
       }
       
       /* Functions used historically to read configuration from 'the_repository' */
 6:  b1e866f9216 ! 6:  a57e35163ae config.c: remove current_parsing_scope
     @@ config.c: struct config_reader {
      +	 */
      +	enum config_scope parsing_scope;
       };
     - /* Only public functions should reference the_reader. */
     + /*
     +  * Where possible, prefer to accept "struct config_reader" as an arg than to use
     +@@ config.c: struct config_reader {
     +  */
       static struct config_reader the_reader;
       
      -/*
      - * Similar to the variables above, this gives access to the "scope" of the
      - * current value (repo, global, etc). For cached values, it can be found via
      - * the current_config_kvi as above. During parsing, the current value can be
     -- * found in this variable. It's not part of "cf" because it transcends a single
     -- * file (i.e., a file included from .git/config is still in "repo" scope).
     +- * found in this variable. It's not part of "cf_global" because it transcends a
     +- * single file (i.e., a file included from .git/config is still in "repo"
     +- * scope).
      - */
      -static enum config_scope current_parsing_scope;
      -
     @@ config.c: static inline struct config_source *config_reader_pop_source(struct co
       {
      -	if (kvi && reader->source)
      +	if (kvi && (reader->source || reader->parsing_scope))
     - 		BUG("kvi should only be set when iterating through configset");
     + 		BUG("kvi should not be set while parsing a config source");
       	reader->config_kvi = kvi;
       }
       
 -:  ----------- > 7:  3c83d9535a0 config: report cached filenames in die_bad_number()
 1:  ad513d832d8 ! 8:  9aec9092fdf config.c: plumb config_source through static fns
     @@ Metadata
      Author: Glen Choo <chooglen@google.com>
      
       ## Commit message ##
     -    config.c: plumb config_source through static fns
     +    config.c: rename "struct config_source cf"
      
     -    This reduces the direct dependence on the "cf" static variable, which
     -    will make it easier to remove in a later commit. The plumbed arg is
     -    named "cs" to differentiate between it and the static variable.
     -
     -    In some cases (public functions and config callback functions), there
     -    isn't an obvious way to plumb "struct config_source" through function
     -    args. As a workaround, add references to "cf" that we'll address in
     -    later commits.
     -
     -    The remaining references to "cf" are direct assignments to "cf", which
     -    we'll also address in a later commit.
     +    The "cf" name is a holdover from before 4d8dd1494e (config: make parsing
     +    stack struct independent from actual data source, 2013-07-12), when the
     +    struct was named config_file. Since that acronym no longer makes sense,
     +    rename "cf" to "cs". In some places, we have "struct config_set cs", so
     +    to avoid conflict, rename those "cs" to "set" ("config_set" would be
     +    more descriptive, but it's much longer and would require us to rewrap
     +    several lines).
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
     @@ config.c: static const char include_depth_advice[] = N_(
       "from\n"
       "	%s\n"
       "This might be due to circular includes.");
     --static int handle_path_include(const char *path, struct config_include_data *inc)
     +-static int handle_path_include(struct config_source *cf, const char *path,
      +static int handle_path_include(struct config_source *cs, const char *path,
     -+			       struct config_include_data *inc)
     + 			       struct config_include_data *inc)
       {
       	int ret = 0;
     - 	struct strbuf buf = STRBUF_INIT;
     -@@ config.c: static int handle_path_include(const char *path, struct config_include_data *inc
     +@@ config.c: static int handle_path_include(struct config_source *cf, const char *path,
       	if (!is_absolute_path(path)) {
       		char *slash;
       
     @@ config.c: static int handle_path_include(const char *path, struct config_include
       		strbuf_addstr(&buf, path);
       		path = buf.buf;
       	}
     -@@ config.c: static int handle_path_include(const char *path, struct config_include_data *inc
     +@@ config.c: static int handle_path_include(struct config_source *cf, const char *path,
       	if (!access_or_die(path, R_OK, 0)) {
       		if (++inc->depth > MAX_INCLUDE_DEPTH)
       			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
     @@ config.c: static void add_trailing_starstar_for_dir(struct strbuf *pat)
       		strbuf_addstr(pat, "**");
       }
       
     --static int prepare_include_condition_pattern(struct strbuf *pat)
     +-static int prepare_include_condition_pattern(struct config_source *cf,
      +static int prepare_include_condition_pattern(struct config_source *cs,
     -+					     struct strbuf *pat)
     + 					     struct strbuf *pat)
       {
       	struct strbuf path = STRBUF_INIT;
     - 	char *expanded;
     -@@ config.c: static int prepare_include_condition_pattern(struct strbuf *pat)
     +@@ config.c: static int prepare_include_condition_pattern(struct config_source *cf,
       	if (pat->buf[0] == '.' && is_dir_sep(pat->buf[1])) {
       		const char *slash;
       
     @@ config.c: static int prepare_include_condition_pattern(struct strbuf *pat)
       		slash = find_last_dir_sep(path.buf);
       		if (!slash)
       			BUG("how is this possible?");
     -@@ config.c: static int prepare_include_condition_pattern(struct strbuf *pat)
     +@@ config.c: static int prepare_include_condition_pattern(struct config_source *cf,
       	return prefix;
       }
       
     --static int include_by_gitdir(const struct config_options *opts,
     +-static int include_by_gitdir(struct config_source *cf,
      +static int include_by_gitdir(struct config_source *cs,
     -+			     const struct config_options *opts,
     + 			     const struct config_options *opts,
       			     const char *cond, size_t cond_len, int icase)
       {
     - 	struct strbuf text = STRBUF_INIT;
     -@@ config.c: static int include_by_gitdir(const struct config_options *opts,
     +@@ config.c: static int include_by_gitdir(struct config_source *cf,
       
       	strbuf_realpath(&text, git_dir, 1);
       	strbuf_add(&pattern, cond, cond_len);
     --	prefix = prepare_include_condition_pattern(&pattern);
     +-	prefix = prepare_include_condition_pattern(cf, &pattern);
      +	prefix = prepare_include_condition_pattern(cs, &pattern);
       
       again:
     @@ config.c: static int include_by_remote_url(struct config_include_data *inc,
       					     inc->remote_urls);
       }
       
     --static int include_condition_is_true(struct config_include_data *inc,
     +-static int include_condition_is_true(struct config_source *cf,
      +static int include_condition_is_true(struct config_source *cs,
     -+				     struct config_include_data *inc,
     + 				     struct config_include_data *inc,
       				     const char *cond, size_t cond_len)
       {
       	const struct config_options *opts = inc->opts;
       
       	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
     --		return include_by_gitdir(opts, cond, cond_len, 0);
     +-		return include_by_gitdir(cf, opts, cond, cond_len, 0);
      +		return include_by_gitdir(cs, opts, cond, cond_len, 0);
       	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
     --		return include_by_gitdir(opts, cond, cond_len, 1);
     +-		return include_by_gitdir(cf, opts, cond, cond_len, 1);
      +		return include_by_gitdir(cs, opts, cond, cond_len, 1);
       	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
       		return include_by_branch(cond, cond_len);
       	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
     +@@ config.c: static int include_condition_is_true(struct config_source *cf,
     + static int git_config_include(const char *var, const char *value, void *data)
     + {
     + 	struct config_include_data *inc = data;
     +-	struct config_source *cf = inc->config_reader->source;
     ++	struct config_source *cs = inc->config_reader->source;
     + 	const char *cond, *key;
     + 	size_t cond_len;
     + 	int ret;
      @@ config.c: static int git_config_include(const char *var, const char *value, void *data)
       		return ret;
       
       	if (!strcmp(var, "include.path"))
     --		ret = handle_path_include(value, inc);
     -+		ret = handle_path_include(cf, value, inc);
     +-		ret = handle_path_include(cf, value, inc);
     ++		ret = handle_path_include(cs, value, inc);
       
       	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
     --	    cond && include_condition_is_true(inc, cond, cond_len) &&
     -+	    cond && include_condition_is_true(cf, inc, cond, cond_len) &&
     +-	    cond && include_condition_is_true(cf, inc, cond, cond_len) &&
     ++	    cond && include_condition_is_true(cs, inc, cond, cond_len) &&
       	    !strcmp(key, "path")) {
       		config_fn_t old_fn = inc->fn;
       
       		if (inc->opts->unconditional_remote_url)
       			inc->fn = forbid_remote_url;
     --		ret = handle_path_include(value, inc);
     -+		ret = handle_path_include(cf, value, inc);
     +-		ret = handle_path_include(cf, value, inc);
     ++		ret = handle_path_include(cs, value, inc);
       		inc->fn = old_fn;
       	}
       
     @@ config.c: out:
       	return ret;
       }
       
     --static int get_next_char(void)
     +-static int get_next_char(struct config_source *cf)
      +static int get_next_char(struct config_source *cs)
       {
      -	int c = cf->do_fgetc(cf);
     @@ config.c: out:
       		/*
       		 * This is an absurdly long config file; refuse to parse
       		 * further in order to protect downstream code from integer
     -@@ config.c: static int get_next_char(void)
     +@@ config.c: static int get_next_char(struct config_source *cf)
       		 * but we can mark EOF and put trash in the return value,
       		 * which will trigger a parse error.
       		 */
     @@ config.c: static int get_next_char(void)
       	return c;
       }
       
     --static char *parse_value(void)
     +-static char *parse_value(struct config_source *cf)
      +static char *parse_value(struct config_source *cs)
       {
       	int quote = 0, comment = 0, space = 0;
     @@ config.c: static int get_next_char(void)
      -	strbuf_reset(&cf->value);
      +	strbuf_reset(&cs->value);
       	for (;;) {
     --		int c = get_next_char();
     +-		int c = get_next_char(cf);
      +		int c = get_next_char(cs);
       		if (c == '\n') {
       			if (quote) {
     @@ config.c: static int get_next_char(void)
       				space++;
       			continue;
       		}
     -@@ config.c: static char *parse_value(void)
     +@@ config.c: static char *parse_value(struct config_source *cf)
       			}
       		}
       		for (; space; space--)
      -			strbuf_addch(&cf->value, ' ');
      +			strbuf_addch(&cs->value, ' ');
       		if (c == '\\') {
     --			c = get_next_char();
     +-			c = get_next_char(cf);
      +			c = get_next_char(cs);
       			switch (c) {
       			case '\n':
       				continue;
     -@@ config.c: static char *parse_value(void)
     +@@ config.c: static char *parse_value(struct config_source *cf)
       			default:
       				return NULL;
       			}
     @@ config.c: static char *parse_value(void)
       	}
       }
       
     --static int get_value(config_fn_t fn, void *data, struct strbuf *name)
     +-static int get_value(struct config_source *cf, config_fn_t fn, void *data,
      +static int get_value(struct config_source *cs, config_fn_t fn, void *data,
     -+		     struct strbuf *name)
     + 		     struct strbuf *name)
       {
       	int c;
     - 	char *value;
     -@@ config.c: static int get_value(config_fn_t fn, void *data, struct strbuf *name)
     +@@ config.c: static int get_value(struct config_source *cf, config_fn_t fn, void *data,
       
       	/* Get the full name */
       	for (;;) {
     --		c = get_next_char();
     +-		c = get_next_char(cf);
      -		if (cf->eof)
      +		c = get_next_char(cs);
      +		if (cs->eof)
       			break;
       		if (!iskeychar(c))
       			break;
     -@@ config.c: static int get_value(config_fn_t fn, void *data, struct strbuf *name)
     +@@ config.c: static int get_value(struct config_source *cf, config_fn_t fn, void *data,
       	}
       
       	while (c == ' ' || c == '\t')
     --		c = get_next_char();
     +-		c = get_next_char(cf);
      +		c = get_next_char(cs);
       
       	value = NULL;
       	if (c != '\n') {
       		if (c != '=')
       			return -1;
     --		value = parse_value();
     +-		value = parse_value(cf);
      +		value = parse_value(cs);
       		if (!value)
       			return -1;
       	}
     -@@ config.c: static int get_value(config_fn_t fn, void *data, struct strbuf *name)
     +@@ config.c: static int get_value(struct config_source *cf, config_fn_t fn, void *data,
       	 * the line we just parsed during the call to fn to get
       	 * accurate line number in error messages.
       	 */
     @@ config.c: static int get_value(config_fn_t fn, void *data, struct strbuf *name)
       	return ret;
       }
       
     --static int get_extended_base_var(struct strbuf *name, int c)
     +-static int get_extended_base_var(struct config_source *cf, struct strbuf *name,
      +static int get_extended_base_var(struct config_source *cs, struct strbuf *name,
     -+				 int c)
     + 				 int c)
       {
      -	cf->subsection_case_sensitive = 0;
      +	cs->subsection_case_sensitive = 0;
       	do {
       		if (c == '\n')
       			goto error_incomplete_line;
     --		c = get_next_char();
     +-		c = get_next_char(cf);
      +		c = get_next_char(cs);
       	} while (isspace(c));
       
       	/* We require the format to be '[base "extension"]' */
     -@@ config.c: static int get_extended_base_var(struct strbuf *name, int c)
     +@@ config.c: static int get_extended_base_var(struct config_source *cf, struct strbuf *name,
       	strbuf_addch(name, '.');
       
       	for (;;) {
     --		int c = get_next_char();
     +-		int c = get_next_char(cf);
      +		int c = get_next_char(cs);
       		if (c == '\n')
       			goto error_incomplete_line;
       		if (c == '"')
       			break;
       		if (c == '\\') {
     --			c = get_next_char();
     +-			c = get_next_char(cf);
      +			c = get_next_char(cs);
       			if (c == '\n')
       				goto error_incomplete_line;
       		}
     -@@ config.c: static int get_extended_base_var(struct strbuf *name, int c)
     +@@ config.c: static int get_extended_base_var(struct config_source *cf, struct strbuf *name,
       	}
       
       	/* Final ']' */
     --	if (get_next_char() != ']')
     +-	if (get_next_char(cf) != ']')
      +	if (get_next_char(cs) != ']')
       		return -1;
       	return 0;
     @@ config.c: static int get_extended_base_var(struct strbuf *name, int c)
       	return -1;
       }
       
     --static int get_base_var(struct strbuf *name)
     +-static int get_base_var(struct config_source *cf, struct strbuf *name)
      +static int get_base_var(struct config_source *cs, struct strbuf *name)
       {
      -	cf->subsection_case_sensitive = 1;
      +	cs->subsection_case_sensitive = 1;
       	for (;;) {
     --		int c = get_next_char();
     +-		int c = get_next_char(cf);
      -		if (cf->eof)
      +		int c = get_next_char(cs);
      +		if (cs->eof)
     @@ config.c: static int get_extended_base_var(struct strbuf *name, int c)
       		if (c == ']')
       			return 0;
       		if (isspace(c))
     --			return get_extended_base_var(name, c);
     +-			return get_extended_base_var(cf, name, c);
      +			return get_extended_base_var(cs, name, c);
       		if (!iskeychar(c) && c != '.')
       			return -1;
     @@ config.c: struct parse_event_data {
       	const struct config_options *opts;
       };
       
     --static int do_event(enum config_event_t type, struct parse_event_data *data)
     +-static int do_event(struct config_source *cf, enum config_event_t type,
      +static int do_event(struct config_source *cs, enum config_event_t type,
     -+		    struct parse_event_data *data)
     + 		    struct parse_event_data *data)
       {
       	size_t offset;
     - 
     -@@ config.c: static int do_event(enum config_event_t type, struct parse_event_data *data)
     +@@ config.c: static int do_event(struct config_source *cf, enum config_event_t type,
       	    data->previous_type == type)
       		return 0;
       
     @@ config.c: static int do_event(enum config_event_t type, struct parse_event_data
       	/*
       	 * At EOF, the parser always "inserts" an extra '\n', therefore
       	 * the end offset of the event is the current file position, otherwise
     -@@ config.c: static int do_event(enum config_event_t type, struct parse_event_data *data)
     +@@ config.c: static int do_event(struct config_source *cf, enum config_event_t type,
       	return 0;
       }
       
     --static int git_parse_source(config_fn_t fn, void *data,
     --			    const struct config_options *opts)
     +-static int git_parse_source(struct config_source *cf, config_fn_t fn,
      +static int git_parse_source(struct config_source *cs, config_fn_t fn,
     -+			    void *data, const struct config_options *opts)
     + 			    void *data, const struct config_options *opts)
       {
       	int comment = 0;
       	size_t baselen = 0;
     @@ config.c: static int do_event(enum config_event_t type, struct parse_event_data
       	int error_return = 0;
       	char *error_msg = NULL;
       
     -@@ config.c: static int git_parse_source(config_fn_t fn, void *data,
     +@@ config.c: static int git_parse_source(struct config_source *cf, config_fn_t fn,
       	for (;;) {
       		int c;
       
     --		c = get_next_char();
     +-		c = get_next_char(cf);
      +		c = get_next_char(cs);
       		if (bomptr && *bomptr) {
       			/* We are at the file beginning; skip UTF8-encoded BOM
       			 * if present. Sane editors won't put this in on their
     -@@ config.c: static int git_parse_source(config_fn_t fn, void *data,
     +@@ config.c: static int git_parse_source(struct config_source *cf, config_fn_t fn,
       			}
       		}
       		if (c == '\n') {
      -			if (cf->eof) {
     --				if (do_event(CONFIG_EVENT_EOF, &event_data) < 0)
     +-				if (do_event(cf, CONFIG_EVENT_EOF, &event_data) < 0)
      +			if (cs->eof) {
      +				if (do_event(cs, CONFIG_EVENT_EOF, &event_data) < 0)
       					return -1;
       				return 0;
       			}
     --			if (do_event(CONFIG_EVENT_WHITESPACE, &event_data) < 0)
     +-			if (do_event(cf, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
      +			if (do_event(cs, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
       				return -1;
       			comment = 0;
       			continue;
     -@@ config.c: static int git_parse_source(config_fn_t fn, void *data,
     +@@ config.c: static int git_parse_source(struct config_source *cf, config_fn_t fn,
       		if (comment)
       			continue;
       		if (isspace(c)) {
     --			if (do_event(CONFIG_EVENT_WHITESPACE, &event_data) < 0)
     +-			if (do_event(cf, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
      +			if (do_event(cs, CONFIG_EVENT_WHITESPACE, &event_data) < 0)
       					return -1;
       			continue;
       		}
       		if (c == '#' || c == ';') {
     --			if (do_event(CONFIG_EVENT_COMMENT, &event_data) < 0)
     +-			if (do_event(cf, CONFIG_EVENT_COMMENT, &event_data) < 0)
      +			if (do_event(cs, CONFIG_EVENT_COMMENT, &event_data) < 0)
       					return -1;
       			comment = 1;
       			continue;
       		}
       		if (c == '[') {
     --			if (do_event(CONFIG_EVENT_SECTION, &event_data) < 0)
     +-			if (do_event(cf, CONFIG_EVENT_SECTION, &event_data) < 0)
      +			if (do_event(cs, CONFIG_EVENT_SECTION, &event_data) < 0)
       					return -1;
       
       			/* Reset prior to determining a new stem */
       			strbuf_reset(var);
     --			if (get_base_var(var) < 0 || var->len < 1)
     +-			if (get_base_var(cf, var) < 0 || var->len < 1)
      +			if (get_base_var(cs, var) < 0 || var->len < 1)
       				break;
       			strbuf_addch(var, '.');
       			baselen = var->len;
     -@@ config.c: static int git_parse_source(config_fn_t fn, void *data,
     +@@ config.c: static int git_parse_source(struct config_source *cf, config_fn_t fn,
       		if (!isalpha(c))
       			break;
       
     --		if (do_event(CONFIG_EVENT_ENTRY, &event_data) < 0)
     +-		if (do_event(cf, CONFIG_EVENT_ENTRY, &event_data) < 0)
      +		if (do_event(cs, CONFIG_EVENT_ENTRY, &event_data) < 0)
       			return -1;
       
       		/*
     -@@ config.c: static int git_parse_source(config_fn_t fn, void *data,
     +@@ config.c: static int git_parse_source(struct config_source *cf, config_fn_t fn,
       		 */
       		strbuf_setlen(var, baselen);
       		strbuf_addch(var, tolower(c));
     --		if (get_value(fn, data, var) < 0)
     +-		if (get_value(cf, fn, data, var) < 0)
      +		if (get_value(cs, fn, data, var) < 0)
       			break;
       	}
       
     --	if (do_event(CONFIG_EVENT_ERROR, &event_data) < 0)
     +-	if (do_event(cf, CONFIG_EVENT_ERROR, &event_data) < 0)
      +	if (do_event(cs, CONFIG_EVENT_ERROR, &event_data) < 0)
       		return -1;
       
     @@ config.c: static int git_parse_source(config_fn_t fn, void *data,
       	case CONFIG_ERROR_DIE:
       		die("%s", error_msg);
       		break;
     -@@ config.c: int git_parse_ssize_t(const char *value, ssize_t *ret)
     +@@ config.c: int config_with_options(config_fn_t fn, void *data,
     + 	return ret;
       }
       
     - NORETURN
     --static void die_bad_number(const char *name, const char *value)
     -+static void die_bad_number(struct config_source *cs, const char *name,
     -+			   const char *value)
     +-static void configset_iter(struct config_reader *reader, struct config_set *cs,
     ++static void configset_iter(struct config_reader *reader, struct config_set *set,
     + 			   config_fn_t fn, void *data)
       {
     - 	const char *error_type = (errno == ERANGE) ?
     - 		N_("out of range") : N_("invalid unit");
     -@@ config.c: static void die_bad_number(const char *name, const char *value)
     - 	if (!value)
     - 		value = "";
     + 	int i, value_index;
     + 	struct string_list *values;
     + 	struct config_set_element *entry;
     +-	struct configset_list *list = &cs->list;
     ++	struct configset_list *list = &set->list;
     + 
     + 	for (i = 0; i < list->nr; i++) {
     + 		entry = list->items[i].e;
     +@@ config.c: void read_very_early_config(config_fn_t cb, void *data)
     + 	config_with_options(cb, data, NULL, &opts);
     + }
       
     --	if (!(cf && cf->name))
     -+	if (!(cs && cs->name))
     - 		die(_(bad_numeric), value, name, _(error_type));
     +-static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
     ++static struct config_set_element *configset_find_element(struct config_set *set, const char *key)
     + {
     + 	struct config_set_element k;
     + 	struct config_set_element *found_entry;
     +@@ config.c: static struct config_set_element *configset_find_element(struct config_set *cs,
     + 
     + 	hashmap_entry_init(&k.ent, strhash(normalized_key));
     + 	k.key = normalized_key;
     +-	found_entry = hashmap_get_entry(&cs->config_hash, &k, ent, NULL);
     ++	found_entry = hashmap_get_entry(&set->config_hash, &k, ent, NULL);
     + 	free(normalized_key);
     + 	return found_entry;
     + }
       
     --	switch (cf->origin_type) {
     -+	switch (cs->origin_type) {
     - 	case CONFIG_ORIGIN_BLOB:
     - 		die(_("bad numeric config value '%s' for '%s' in blob %s: %s"),
     --		    value, name, cf->name, _(error_type));
     -+		    value, name, cs->name, _(error_type));
     - 	case CONFIG_ORIGIN_FILE:
     - 		die(_("bad numeric config value '%s' for '%s' in file %s: %s"),
     --		    value, name, cf->name, _(error_type));
     -+		    value, name, cs->name, _(error_type));
     - 	case CONFIG_ORIGIN_STDIN:
     - 		die(_("bad numeric config value '%s' for '%s' in standard input: %s"),
     - 		    value, name, _(error_type));
     - 	case CONFIG_ORIGIN_SUBMODULE_BLOB:
     - 		die(_("bad numeric config value '%s' for '%s' in submodule-blob %s: %s"),
     --		    value, name, cf->name, _(error_type));
     -+		    value, name, cs->name, _(error_type));
     - 	case CONFIG_ORIGIN_CMDLINE:
     - 		die(_("bad numeric config value '%s' for '%s' in command line %s: %s"),
     --		    value, name, cf->name, _(error_type));
     -+		    value, name, cs->name, _(error_type));
     - 	default:
     - 		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
     --		    value, name, cf->name, _(error_type));
     -+		    value, name, cs->name, _(error_type));
     + static int configset_add_value(struct config_reader *reader,
     +-			       struct config_set *cs, const char *key,
     ++			       struct config_set *set, const char *key,
     + 			       const char *value)
     + {
     + 	struct config_set_element *e;
     +@@ config.c: static int configset_add_value(struct config_reader *reader,
     + 	struct configset_list_item *l_item;
     + 	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
     + 
     +-	e = configset_find_element(cs, key);
     ++	e = configset_find_element(set, key);
     + 	/*
     + 	 * Since the keys are being fed by git_config*() callback mechanism, they
     + 	 * are already normalized. So simply add them without any further munging.
     +@@ config.c: static int configset_add_value(struct config_reader *reader,
     + 		hashmap_entry_init(&e->ent, strhash(key));
     + 		e->key = xstrdup(key);
     + 		string_list_init_dup(&e->value_list);
     +-		hashmap_add(&cs->config_hash, &e->ent);
     ++		hashmap_add(&set->config_hash, &e->ent);
       	}
     + 	si = string_list_append_nodup(&e->value_list, xstrdup_or_null(value));
     + 
     +-	ALLOC_GROW(cs->list.items, cs->list.nr + 1, cs->list.alloc);
     +-	l_item = &cs->list.items[cs->list.nr++];
     ++	ALLOC_GROW(set->list.items, set->list.nr + 1, set->list.alloc);
     ++	l_item = &set->list.items[set->list.nr++];
     + 	l_item->e = e;
     + 	l_item->value_index = e->value_list.nr - 1;
     + 
     +@@ config.c: static int config_set_element_cmp(const void *cmp_data UNUSED,
     + 	return strcmp(e1->key, e2->key);
       }
       
     -@@ config.c: int git_config_int(const char *name, const char *value)
     +-void git_configset_init(struct config_set *cs)
     ++void git_configset_init(struct config_set *set)
       {
     - 	int ret;
     - 	if (!git_parse_int(value, &ret))
     --		die_bad_number(name, value);
     -+		die_bad_number(cf, name, value);
     - 	return ret;
     +-	hashmap_init(&cs->config_hash, config_set_element_cmp, NULL, 0);
     +-	cs->hash_initialized = 1;
     +-	cs->list.nr = 0;
     +-	cs->list.alloc = 0;
     +-	cs->list.items = NULL;
     ++	hashmap_init(&set->config_hash, config_set_element_cmp, NULL, 0);
     ++	set->hash_initialized = 1;
     ++	set->list.nr = 0;
     ++	set->list.alloc = 0;
     ++	set->list.items = NULL;
       }
       
     -@@ config.c: int64_t git_config_int64(const char *name, const char *value)
     +-void git_configset_clear(struct config_set *cs)
     ++void git_configset_clear(struct config_set *set)
       {
     - 	int64_t ret;
     - 	if (!git_parse_int64(value, &ret))
     --		die_bad_number(name, value);
     -+		die_bad_number(cf, name, value);
     - 	return ret;
     + 	struct config_set_element *entry;
     + 	struct hashmap_iter iter;
     +-	if (!cs->hash_initialized)
     ++	if (!set->hash_initialized)
     + 		return;
     + 
     +-	hashmap_for_each_entry(&cs->config_hash, &iter, entry,
     ++	hashmap_for_each_entry(&set->config_hash, &iter, entry,
     + 				ent /* member name */) {
     + 		free(entry->key);
     + 		string_list_clear(&entry->value_list, 1);
     + 	}
     +-	hashmap_clear_and_free(&cs->config_hash, struct config_set_element, ent);
     +-	cs->hash_initialized = 0;
     +-	free(cs->list.items);
     +-	cs->list.nr = 0;
     +-	cs->list.alloc = 0;
     +-	cs->list.items = NULL;
     ++	hashmap_clear_and_free(&set->config_hash, struct config_set_element, ent);
     ++	set->hash_initialized = 0;
     ++	free(set->list.items);
     ++	set->list.nr = 0;
     ++	set->list.alloc = 0;
     ++	set->list.items = NULL;
     + }
     + 
     + struct configset_add_data {
     +@@ config.c: static int config_set_callback(const char *key, const char *value, void *cb)
     + 	return 0;
       }
       
     -@@ config.c: unsigned long git_config_ulong(const char *name, const char *value)
     +-int git_configset_add_file(struct config_set *cs, const char *filename)
     ++int git_configset_add_file(struct config_set *set, const char *filename)
       {
     - 	unsigned long ret;
     - 	if (!git_parse_ulong(value, &ret))
     --		die_bad_number(name, value);
     -+		die_bad_number(cf, name, value);
     - 	return ret;
     + 	struct configset_add_data data = CONFIGSET_ADD_INIT;
     + 	data.config_reader = &the_reader;
     +-	data.config_set = cs;
     ++	data.config_set = set;
     + 	return git_config_from_file(config_set_callback, filename, &data);
       }
       
     -@@ config.c: ssize_t git_config_ssize_t(const char *name, const char *value)
     +-int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
     ++int git_configset_get_value(struct config_set *set, const char *key, const char **value)
       {
     - 	ssize_t ret;
     - 	if (!git_parse_ssize_t(value, &ret))
     --		die_bad_number(name, value);
     -+		die_bad_number(cf, name, value);
     - 	return ret;
     + 	const struct string_list *values = NULL;
     + 	/*
     +@@ config.c: int git_configset_get_value(struct config_set *cs, const char *key, const char *
     + 	 * queried key in the files of the configset, the value returned will be the last
     + 	 * value in the value list for that key.
     + 	 */
     +-	values = git_configset_get_value_multi(cs, key);
     ++	values = git_configset_get_value_multi(set, key);
     + 
     + 	if (!values)
     + 		return 1;
     +@@ config.c: int git_configset_get_value(struct config_set *cs, const char *key, const char *
     + 	return 0;
       }
       
     -@@ config.c: static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
     - 	strbuf_init(&top->var, 1024);
     - 	cf = top;
     +-const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
     ++const struct string_list *git_configset_get_value_multi(struct config_set *set, const char *key)
     + {
     +-	struct config_set_element *e = configset_find_element(cs, key);
     ++	struct config_set_element *e = configset_find_element(set, key);
     + 	return e ? &e->value_list : NULL;
     + }
       
     --	ret = git_parse_source(fn, data, opts);
     -+	ret = git_parse_source(cf, fn, data, opts);
     +-int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
     ++int git_configset_get_string(struct config_set *set, const char *key, char **dest)
     + {
     + 	const char *value;
     +-	if (!git_configset_get_value(cs, key, &value))
     ++	if (!git_configset_get_value(set, key, &value))
     + 		return git_config_string((const char **)dest, key, value);
     + 	else
     + 		return 1;
     + }
       
     - 	/* pop config-file parsing state stack */
     - 	strbuf_release(&top->value);
     +-static int git_configset_get_string_tmp(struct config_set *cs, const char *key,
     ++static int git_configset_get_string_tmp(struct config_set *set, const char *key,
     + 					const char **dest)
     + {
     + 	const char *value;
     +-	if (!git_configset_get_value(cs, key, &value)) {
     ++	if (!git_configset_get_value(set, key, &value)) {
     + 		if (!value)
     + 			return config_error_nonbool(key);
     + 		*dest = value;
     +@@ config.c: static int git_configset_get_string_tmp(struct config_set *cs, const char *key,
     + 	}
     + }
     + 
     +-int git_configset_get_int(struct config_set *cs, const char *key, int *dest)
     ++int git_configset_get_int(struct config_set *set, const char *key, int *dest)
     + {
     + 	const char *value;
     +-	if (!git_configset_get_value(cs, key, &value)) {
     ++	if (!git_configset_get_value(set, key, &value)) {
     + 		*dest = git_config_int(key, value);
     + 		return 0;
     + 	} else
     + 		return 1;
     + }
     + 
     +-int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest)
     ++int git_configset_get_ulong(struct config_set *set, const char *key, unsigned long *dest)
     + {
     + 	const char *value;
     +-	if (!git_configset_get_value(cs, key, &value)) {
     ++	if (!git_configset_get_value(set, key, &value)) {
     + 		*dest = git_config_ulong(key, value);
     + 		return 0;
     + 	} else
     + 		return 1;
     + }
     + 
     +-int git_configset_get_bool(struct config_set *cs, const char *key, int *dest)
     ++int git_configset_get_bool(struct config_set *set, const char *key, int *dest)
     + {
     + 	const char *value;
     +-	if (!git_configset_get_value(cs, key, &value)) {
     ++	if (!git_configset_get_value(set, key, &value)) {
     + 		*dest = git_config_bool(key, value);
     + 		return 0;
     + 	} else
     + 		return 1;
     + }
     + 
     +-int git_configset_get_bool_or_int(struct config_set *cs, const char *key,
     ++int git_configset_get_bool_or_int(struct config_set *set, const char *key,
     + 				int *is_bool, int *dest)
     + {
     + 	const char *value;
     +-	if (!git_configset_get_value(cs, key, &value)) {
     ++	if (!git_configset_get_value(set, key, &value)) {
     + 		*dest = git_config_bool_or_int(key, value, is_bool);
     + 		return 0;
     + 	} else
     + 		return 1;
     + }
     + 
     +-int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest)
     ++int git_configset_get_maybe_bool(struct config_set *set, const char *key, int *dest)
     + {
     + 	const char *value;
     +-	if (!git_configset_get_value(cs, key, &value)) {
     ++	if (!git_configset_get_value(set, key, &value)) {
     + 		*dest = git_parse_maybe_bool(value);
     + 		if (*dest == -1)
     + 			return -1;
     +@@ config.c: int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *de
     + 		return 1;
     + }
     + 
     +-int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest)
     ++int git_configset_get_pathname(struct config_set *set, const char *key, const char **dest)
     + {
     + 	const char *value;
     +-	if (!git_configset_get_value(cs, key, &value))
     ++	if (!git_configset_get_value(set, key, &value))
     + 		return git_config_pathname(dest, key, value);
     + 	else
     + 		return 1;
     +@@ config.c: static int store_aux_event(enum config_event_t type,
     + 			   size_t begin, size_t end, void *data)
     + {
     + 	struct config_store_data *store = data;
     +-	struct config_source *cf = store->config_reader->source;
     ++	struct config_source *cs = store->config_reader->source;
     + 
     + 	ALLOC_GROW(store->parsed, store->parsed_nr + 1, store->parsed_alloc);
     + 	store->parsed[store->parsed_nr].begin = begin;
     +@@ config.c: static int store_aux_event(enum config_event_t type,
     + 	if (type == CONFIG_EVENT_SECTION) {
     + 		int (*cmpfn)(const char *, const char *, size_t);
     + 
     +-		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
     +-			return error(_("invalid section name '%s'"), cf->var.buf);
     ++		if (cs->var.len < 2 || cs->var.buf[cs->var.len - 1] != '.')
     ++			return error(_("invalid section name '%s'"), cs->var.buf);
     + 
     +-		if (cf->subsection_case_sensitive)
     ++		if (cs->subsection_case_sensitive)
     + 			cmpfn = strncasecmp;
     + 		else
     + 			cmpfn = strncmp;
     +@@ config.c: static int store_aux_event(enum config_event_t type,
     + 		/* Is this the section we were looking for? */
     + 		store->is_keys_section =
     + 			store->parsed[store->parsed_nr].is_keys_section =
     +-			cf->var.len - 1 == store->baselen &&
     +-			!cmpfn(cf->var.buf, store->key, store->baselen);
     ++			cs->var.len - 1 == store->baselen &&
     ++			!cmpfn(cs->var.buf, store->key, store->baselen);
     + 		if (store->is_keys_section) {
     + 			store->section_seen = 1;
     + 			ALLOC_GROW(store->seen, store->seen_nr + 1,

-- 
gitgitgadget
