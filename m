Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73831C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 20:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCFUM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 15:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCFUM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 15:12:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0459964225
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 12:12:26 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x64-20020a25ce43000000b00ae6d5855d78so11731189ybe.12
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 12:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678133545;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AuhkN/NYb1YPMLARrfYBK1SIPAxL1korgMazM9WYS6M=;
        b=ha1gwB0lGmdOhYzA8YouOmoj+wixz0QRs3xLlclQdEaCmCDzfMtgPrU7Ieb02lY4TD
         J1a8K3pYjGtcD7vP7Ho6P3gIqDD6q5cgUXnowUwuxsFVjIyvyIE6+4oOJgHtK6YHAxcz
         xck7pCgSFNj2H8TZAofvk+c/iAvng2W+GQeHoD2TezAShKyz5clHvQ61pTW1xH7lf+nI
         edoCl/sqI9vAPgpNQMYPgvXN+uaXRYSWoR8GnmILdBytYr/xfpPkIx4Ll27zsktfH925
         MNUyAJ0R37wNU+g/K3p9Stz9/Hvz09dAmnqofsBifz29aC9GeT9DHhq7gyCNxiq6pZLs
         xjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678133545;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuhkN/NYb1YPMLARrfYBK1SIPAxL1korgMazM9WYS6M=;
        b=sHYrvVdBPkWBcKAZea5Qi6u35Ybzc8b8QULOZoPWIgBkuZ2JDUhoXjNdQvtVWrzE1I
         Mjt5mlpAOPw0JZE0ZRq/04KerO8adgYA0a37OZgJ8ySUbjNlx3ctKZoB4flqn5C1x2SH
         kMJSnf1Y+sNQuqNeKfp2G6l76ffFfUjM7YRtZhc8Bc0l+WsR65uLRAh6MhoduZxD4Czv
         FmYFU/Sw8j7ZCtXzqBn8ktqdqu1RYMiXTL32QdazPBPmGbw57FlI+cnuC4KcbyXmke4j
         /pdcv0Po3e8hKxxp6W+1MLk+wn8tWV6tm3C/nsygowNI6bGDXfkNqde3yImu+NDyb6TT
         XoUg==
X-Gm-Message-State: AO0yUKUpJHW3amW+poyHRwwnQwiJXCeNqBsi/HOi0iGCkNjXxVTymRuk
        BcYebRiywsRM0wwtgxBsXOQ20UPyNwDRUeM=
X-Google-Smtp-Source: AK7set8Ub+W4uLZkf6epUvYPlpW92nSc+BTl3fKkmkoMWKXB+lhOfq5WhQbS7LkzBDCgxUWyXV3fxlr4XCEsGG4=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a0d:d8ce:0:b0:52f:ec4:3ad6 with SMTP id
 a197-20020a0dd8ce000000b0052f0ec43ad6mr3ywe.304.1678133544983; Mon, 06 Mar
 2023 12:12:24 -0800 (PST)
Date:   Mon,  6 Mar 2023 20:12:18 +0000
In-Reply-To: <c05b33ab29dbce931f9d0ad968fe9eeedc653456.1677631097.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306201218.2834756-1-calvinwan@google.com>
Subject: Re: [PATCH 5/6] config.c: remove current_config_kvi
From:   Calvin Wan <calvinwan@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Glen Choo <chooglen@google.com>
> 
> Add ".config_kvi" to "struct config_reader" and replace
> "current_config_kvi" with "the_reader.config_kvi", either in-place (in
> public functions) or by passing "the_reader" to the "*data" arg of
> callback functions.
> 
> Also, introduce a setter function for ".config_kvi", which allows us to
> enforce the contraint that only one of ".source" and ".config_kvi" can
> be set at a time (as documented in the comments). Because of this
> constraint, we know that "populate_remote_urls()" was never touching
> "current_config_kvi" when iterating through config files, so it doesn't
> need to store and restore that value.
> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  config.c | 103 ++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 61 insertions(+), 42 deletions(-)
> 
> diff --git a/config.c b/config.c
> index 9676734b1b7..c7995148165 100644
> --- a/config.c
> +++ b/config.c
> @@ -52,32 +52,28 @@ struct config_source {
>  #define CONFIG_SOURCE_INIT { 0 }
>  
>  struct config_reader {
> +	/*
> +	 * These members record the "current" config source, which can be
> +	 * accessed by parsing callbacks.
> +	 *
> +	 * The "source" variable will be non-NULL only when we are actually
> +	 * parsing a real config source (file, blob, cmdline, etc).
> +	 *
> +	 * The "config_kvi" variable will be non-NULL only when we are feeding
> +	 * cached config from a configset into a callback.
> +	 *
> +	 * They cannot be non-NULL at the same time. If they are both NULL, then
> +	 * we aren't parsing anything (and depending on the function looking at
> +	 * the variables, it's either a bug for it to be called in the first
> +	 * place, or it's a function which can be reused for non-config
> +	 * purposes, and should fall back to some sane behavior).
> +	 */
>  	struct config_source *source;
> +	struct key_value_info *config_kvi;
>  };
>  /* Only public functions should reference the_reader. */
>  static struct config_reader the_reader;
>  
> -/*
> - * FIXME The comments are temporarily out of date since "cf" been moved to
> - * the_reader, but not current_*.
> - *
> - * These variables record the "current" config source, which
> - * can be accessed by parsing callbacks.
> - *
> - * The "cf" variable will be non-NULL only when we are actually parsing a real
> - * config source (file, blob, cmdline, etc).
> - *
> - * The "current_config_kvi" variable will be non-NULL only when we are feeding
> - * cached config from a configset into a callback.
> - *
> - * They should generally never be non-NULL at the same time. If they are both
> - * NULL, then we aren't parsing anything (and depending on the function looking
> - * at the variables, it's either a bug for it to be called in the first place,
> - * or it's a function which can be reused for non-config purposes, and should
> - * fall back to some sane behavior).
> - */
> -static struct key_value_info *current_config_kvi;
> -
>  /*
>   * Similar to the variables above, this gives access to the "scope" of the
>   * current value (repo, global, etc). For cached values, it can be found via
> @@ -90,6 +86,8 @@ static enum config_scope current_parsing_scope;
>  static inline void config_reader_push_source(struct config_reader *reader,
>  					     struct config_source *top)
>  {
> +	if (reader->config_kvi)
> +		BUG("source should only be set when parsing a config source");
>  	if (reader->source)
>  		top->prev = reader->source;
>  	reader->source = top;

A developer who accidentally sets config_kvi probably has the right
intention of trying to push source. I think a clearer BUG message here
(which also doubly functions as a useful comment) would be something
along the lines of: "configset should not be set when parsing a config
source".

> @@ -105,6 +103,14 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
>  	return ret;
>  }
>  
> +static inline void config_reader_set_kvi(struct config_reader *reader,
> +					 struct key_value_info *kvi)
> +{
> +	if (kvi && reader->source)
> +		BUG("kvi should only be set when iterating through configset");
> +	reader->config_kvi = kvi;
> +}
> +

ditto

>  static int pack_compression_seen;
>  static int zlib_compression_seen;
>  
> @@ -373,20 +379,17 @@ static void populate_remote_urls(struct config_include_data *inc)
>  {
>  	struct config_options opts;
>  
> -	struct key_value_info *store_kvi = current_config_kvi;
>  	enum config_scope store_scope = current_parsing_scope;
>  
>  	opts = *inc->opts;
>  	opts.unconditional_remote_url = 1;
>  
> -	current_config_kvi = NULL;
>  	current_parsing_scope = 0;
>  
>  	inc->remote_urls = xmalloc(sizeof(*inc->remote_urls));
>  	string_list_init_dup(inc->remote_urls);
>  	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
>  
> -	current_config_kvi = store_kvi;
>  	current_parsing_scope = store_scope;
>  }
>  
> @@ -2253,26 +2256,34 @@ int config_with_options(config_fn_t fn, void *data,
>  	return ret;
>  }
>  
> +struct configset_iter_data {
> +	struct config_reader *config_reader;
> +	void *inner;
> +};
> +#define CONFIGSET_ITER_INIT { 0 }
> +
>  static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
>  {
>  	int i, value_index;
>  	struct string_list *values;
>  	struct config_set_element *entry;
>  	struct configset_list *list = &cs->list;
> +	struct configset_iter_data *iter_data = data;
>  
>  	for (i = 0; i < list->nr; i++) {
> +		struct key_value_info *kvi;
>  		entry = list->items[i].e;
>  		value_index = list->items[i].value_index;
>  		values = &entry->value_list;
>  
> -		current_config_kvi = values->items[value_index].util;
> +		kvi = values->items[value_index].util;
> +		config_reader_set_kvi(iter_data->config_reader, kvi);
>  
> -		if (fn(entry->key, values->items[value_index].string, data) < 0)
> -			git_die_config_linenr(entry->key,
> -					      current_config_kvi->filename,
> -					      current_config_kvi->linenr);
> +		if (fn(entry->key, values->items[value_index].string, iter_data->inner) < 0)
> +			git_die_config_linenr(entry->key, kvi->filename,
> +					      kvi->linenr);
>  
> -		current_config_kvi = NULL;
> +		config_reader_set_kvi(iter_data->config_reader, NULL);
>  	}
>  }
>  
> @@ -2607,10 +2618,14 @@ static void repo_config_clear(struct repository *repo)
>  	git_configset_clear(repo->config);
>  }
>  
> -void repo_config(struct repository *repo, config_fn_t fn, void *data)
> +void repo_config(struct repository *repo, config_fn_t fn, void *data_inner)
>  {
> +	struct configset_iter_data data = CONFIGSET_ITER_INIT;
> +	data.inner = data_inner;
> +	data.config_reader = &the_reader;
> +
>  	git_config_check_init(repo);
> -	configset_iter(repo->config, fn, data);
> +	configset_iter(repo->config, fn, &data);
>  }

I'm not sure I agree with changing *data to *data_inner. An API caller
would be wondering why this function has a *data_inner signature vs
*data for other functions in config. You could instead change `struct
configset_iter_data data` to `struct configset_iter_data data_outer` to
preserve the function signature.

>  
>  int repo_config_get_value(struct repository *repo,
> @@ -2712,11 +2727,15 @@ static void read_protected_config(void)
>  	config_with_options(config_set_callback, &data, NULL, &opts);
>  }
>  
> -void git_protected_config(config_fn_t fn, void *data)
> +void git_protected_config(config_fn_t fn, void *data_inner)
>  {
> +	struct configset_iter_data data = CONFIGSET_ITER_INIT;
>  	if (!protected_config.hash_initialized)
>  		read_protected_config();
> -	configset_iter(&protected_config, fn, data);
> +	data.inner = data_inner;
> +	data.config_reader = &the_reader;
> +
> +	configset_iter(&protected_config, fn, &data);
>  }

ditto

>  
>  /* Functions used historically to read configuration from 'the_repository' */
> @@ -3823,8 +3842,8 @@ int parse_config_key(const char *var,
>  const char *current_config_origin_type(void)
>  {
>  	int type;
> -	if (current_config_kvi)
> -		type = current_config_kvi->origin_type;
> +	if (the_reader.config_kvi)
> +		type = the_reader.config_kvi->origin_type;
>  	else if(the_reader.source)
>  		type = the_reader.source->origin_type;
>  	else
> @@ -3869,8 +3888,8 @@ const char *config_scope_name(enum config_scope scope)
>  const char *current_config_name(void)
>  {
>  	const char *name;
> -	if (current_config_kvi)
> -		name = current_config_kvi->filename;
> +	if (the_reader.config_kvi)
> +		name = the_reader.config_kvi->filename;
>  	else if (the_reader.source)
>  		name = the_reader.source->name;
>  	else
> @@ -3880,16 +3899,16 @@ const char *current_config_name(void)
>  
>  enum config_scope current_config_scope(void)
>  {
> -	if (current_config_kvi)
> -		return current_config_kvi->scope;
> +	if (the_reader.config_kvi)
> +		return the_reader.config_kvi->scope;
>  	else
>  		return current_parsing_scope;
>  }
>  
>  int current_config_line(void)
>  {
> -	if (current_config_kvi)
> -		return current_config_kvi->linenr;
> +	if (the_reader.config_kvi)
> +		return the_reader.config_kvi->linenr;
>  	else
>  		return the_reader.source->linenr;
>  }
> -- 
> gitgitgadget
> 
> 
> 
