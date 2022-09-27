Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9279C54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 16:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiI0Q0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiI0Q0L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 12:26:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE9071BCE
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:25:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dv25so21759959ejb.12
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=HwZN/+AUGeHI+88bADFgcVylaIucWLCL+sOcBzi7Lp4=;
        b=P7XVu9pjiZc51JA1ZqvJFg9YCklZhO0Sk2UALEtyjtIR6b93W79w5veimf8HUN55mE
         HwtGh7NW6IUEfH9SfeyTkeuWpR4CFz6/+gebP0ZyotRaGtVNPlMnIVtVB2vOwM7z8/Qv
         C5LU9v3o46vm+UGY3ADgRAYS91eZJ782YFaLDmYqg5YNWlA+bffwNm5EDbTLc7xQG2Fo
         tCmEIsDX/mBaXvn+oi8kB+UQA6iiRiELDvLJrezZFOlT3hKy+ToZYQ9429xX1oAIXZF4
         J2Odf3ohlquLvkzJmBK78QbkCtgREOEuKo/AOG4GE1MPRLU0smrbZm1XUusYCgZRvkCL
         AJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HwZN/+AUGeHI+88bADFgcVylaIucWLCL+sOcBzi7Lp4=;
        b=X2g4hQLj/0alwSodZDjYDMdvsoVHDi7RRHp2AggCkJOo/FIf6dCl4GXx5m5sdqWJhU
         wNU6sQ8rNNGS2fRtj6l8DffVgVzyjnctv7dQIPoBB/PzrLT/okSh/dQhDJKdkem5bOvt
         t6jPh9IrPLAB1vwP8fz8MVcQJ5XzPIIkk8xs3g540etdOMOOxIoUYYMWaPny3TUPa6Dh
         +qrQRP64ovfoRtC0H7seGuuNouQ0z8tSnJcSsO5dj/ahgib438Bl0qGzGe3MwH2cJhWO
         J0/yUtz3FPcJ1bBqNaXIt1bNJH5a9dFVGk+9RzXtKYPmvL34Na8HAnuQ99b0whEsq3WZ
         /6fA==
X-Gm-Message-State: ACrzQf0VpW/0408i//6lTB/RFzD/4dFJDXUzoKKltvjR80OwcKkw9mVQ
        W5WNbhsyNNu0tX71l8F4HQJx1N+Arp4=
X-Google-Smtp-Source: AMsMyM5sJHEih8xh1XyZR7yYNE4FkXL1BzRTklimh7YqxQRXEB/jBcFW8MktTqkfUjxDi7MV+aXzZA==
X-Received: by 2002:a17:906:794b:b0:783:8db0:95a5 with SMTP id l11-20020a170906794b00b007838db095a5mr9744827ejo.728.1664295941923;
        Tue, 27 Sep 2022 09:25:41 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090631d400b007877ad05b32sm252364ejf.208.2022.09.27.09.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:25:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odDOu-000SPL-0w;
        Tue, 27 Sep 2022 18:25:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 4/5] config: return an empty list, not NULL
Date:   Tue, 27 Sep 2022 18:21:31 +0200
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
 <396343ce7dd17f86bbbc66197c6f0b4012caf445.1664287711.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <396343ce7dd17f86bbbc66197c6f0b4012caf445.1664287711.git.gitgitgadget@gmail.com>
Message-ID: <220927.86sfkcyebf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 27 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> For the multi-valued config API methods, Git previously returned a NULL
> list instead of an empty list. Previous changes adjusted all callers to
> instead expect an empty, non-NULL list, making this a safe change.
>
> The next change will remove the NULL checks from all callers.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  config.c | 3 ++-
>  config.h | 6 +++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/config.c b/config.c
> index 0c41606c7d4..2d4ca1ae6dc 100644
> --- a/config.c
> +++ b/config.c
> @@ -2415,8 +2415,9 @@ int git_configset_get_value(struct config_set *cs, const char *key, const char *
>  
>  const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
>  {
> +	static struct string_list empty_list = STRING_LIST_INIT_NODUP;
>  	struct config_set_element *e = configset_find_element(cs, key);
> -	return e ? &e->value_list : NULL;
> +	return e ? &e->value_list : &empty_list;
>  }
>  
>  int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
> diff --git a/config.h b/config.h
> index ca994d77147..9897b97c0b9 100644
> --- a/config.h
> +++ b/config.h
> @@ -458,7 +458,7 @@ int git_configset_add_parameters(struct config_set *cs);
>  /**
>   * Finds and returns the value list, sorted in order of increasing priority
>   * for the configuration variable `key` and config set `cs`. When the
> - * configuration variable `key` is not found, returns NULL. The caller
> + * configuration variable `key` is not found, returns an empty list. The caller
>   * should not free or modify the returned pointer, as it is owned by the cache.
>   */
>  const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
> @@ -543,8 +543,8 @@ int git_config_get_value(const char *key, const char **value);
>  /**
>   * Finds and returns the value list, sorted in order of increasing priority
>   * for the configuration variable `key`. When the configuration variable
> - * `key` is not found, returns NULL. The caller should not free or modify
> - * the returned pointer, as it is owned by the cache.
> + * `key` is not found, returns an empty list. The caller should not free or
> + * modify the returned pointer, as it is owned by the cache.
>   */
>  const struct string_list *git_config_get_value_multi(const char *key);

Aside from the "DWIM API" aspect of this (which I don't mind) I think
this is really taking the low-level function in the wrong direction, and
that we should just add a new simple wrapper instead.

I.e. both the pre-image API docs & this series gloss over the fact that
we'd not just return NULL here if the config wasn't there, but also if
git_config_parse_key() failed.

So it seems to me that a better direction would be starting with
something like the WIP below (which doesn't compile the whole code, I
stopped at config.[ch] and pack-bitmap.c). I.e. the same "int" return
and "dest" pattern that most other things in the config API have.

The functionality you want in this series would then just be a wrapper
for that which wouldn't care about the difference between "bad key" and
"no such config entry".

But I really think the low-level config API should care about the
difference, granted before your change it's rather crappy, and would
return NULL for both, but I think we can do better...

diff --git a/config.c b/config.c
index cbb5a3bab74..a9536d3a9e8 100644
--- a/config.c
+++ b/config.c
@@ -2275,23 +2275,28 @@ void read_very_early_config(config_fn_t cb, void *data)
 	config_with_options(cb, data, NULL, &opts);
 }
 
-static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
+static int configset_find_element(struct config_set *cs, const char *key,
+				  struct config_set_element **dest)
 {
 	struct config_set_element k;
 	struct config_set_element *found_entry;
 	char *normalized_key;
+	int ret;
+
 	/*
 	 * `key` may come from the user, so normalize it before using it
 	 * for querying entries from the hashmap.
 	 */
-	if (git_config_parse_key(key, &normalized_key, NULL))
-		return NULL;
+	ret = git_config_parse_key(key, &normalized_key, NULL);
+	if (ret < 0)
+		return ret;
 
 	hashmap_entry_init(&k.ent, strhash(normalized_key));
 	k.key = normalized_key;
 	found_entry = hashmap_get_entry(&cs->config_hash, &k, ent, NULL);
 	free(normalized_key);
-	return found_entry;
+	*dest = found_entry;
+	return 0;
 }
 
 static int configset_add_value(struct config_set *cs, const char *key, const char *value)
@@ -2300,8 +2305,11 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 	struct string_list_item *si;
 	struct configset_list_item *l_item;
 	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
+	int ret;
 
-	e = configset_find_element(cs, key);
+	ret = configset_find_element(cs, key, &e);
+	if (ret < 0)
+		return ret;
 	/*
 	 * Since the keys are being fed by git_config*() callback mechanism, they
 	 * are already normalized. So simply add them without any further munging.
@@ -2400,24 +2408,34 @@ int git_configset_add_parameters(struct config_set *cs)
 int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
 {
 	const struct string_list *values = NULL;
+	int ret;
+
 	/*
 	 * Follows "last one wins" semantic, i.e., if there are multiple matches for the
 	 * queried key in the files of the configset, the value returned will be the last
 	 * value in the value list for that key.
 	 */
-	values = git_configset_get_value_multi(cs, key);
+	ret = git_configset_get_value_multi(cs, key, &values);
+
+	if (ret < 0)
+		return ret;
 
-	if (!values)
-		return 1;
 	assert(values->nr > 0);
 	*value = values->items[values->nr - 1].string;
 	return 0;
 }
 
-const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key)
+int git_configset_get_value_multi(struct config_set *cs, const char *key,
+				  const struct string_list **dest)
 {
-	struct config_set_element *e = configset_find_element(cs, key);
-	return e ? &e->value_list : NULL;
+	struct config_set_element *e = NULL;
+	int ret;
+
+	ret = configset_find_element(cs, key, &e);
+	if (ret < 0)
+		return ret;
+	*dest = &e->value_list;
+	return 0;
 }
 
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
@@ -2563,11 +2581,12 @@ int repo_config_get_value(struct repository *repo,
 	return git_configset_get_value(repo->config, key, value);
 }
 
-const struct string_list *repo_config_get_value_multi(struct repository *repo,
-						      const char *key)
+int repo_config_get_value_multi(struct repository *repo,
+				const char *key,
+				const struct string_list **dest)
 {
 	git_config_check_init(repo);
-	return git_configset_get_value_multi(repo->config, key);
+	return git_configset_get_value_multi(repo->config, key, dest);
 }
 
 int repo_config_get_string(struct repository *repo,
@@ -2684,9 +2703,9 @@ int git_config_get_value(const char *key, const char **value)
 	return repo_config_get_value(the_repository, key, value);
 }
 
-const struct string_list *git_config_get_value_multi(const char *key)
+int git_config_get_value_multi(const char *key, const struct string_list **dest)
 {
-	return repo_config_get_value_multi(the_repository, key);
+	return repo_config_get_value_multi(the_repository, key, dest);
 }
 
 int git_config_get_string(const char *key, char **dest)
@@ -2826,6 +2845,7 @@ void git_die_config(const char *key, const char *err, ...)
 	const struct string_list *values;
 	struct key_value_info *kv_info;
 	report_fn error_fn = get_error_routine();
+	int ret;
 
 	if (err) {
 		va_list params;
@@ -2833,7 +2853,9 @@ void git_die_config(const char *key, const char *err, ...)
 		error_fn(err, params);
 		va_end(params);
 	}
-	values = git_config_get_value_multi(key);
+	ret = git_config_get_value_multi(key, &values);
+	if (ret < 0)
+		BUG("...");
 	kv_info = values->items[values->nr - 1].util;
 	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
 }
diff --git a/config.h b/config.h
index ca994d77147..99b8dc1944c 100644
--- a/config.h
+++ b/config.h
@@ -461,7 +461,8 @@ int git_configset_add_parameters(struct config_set *cs);
  * configuration variable `key` is not found, returns NULL. The caller
  * should not free or modify the returned pointer, as it is owned by the cache.
  */
-const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
+int git_configset_get_value_multi(struct config_set *cs, const char *key,
+				  const struct string_list **dest);
 
 /**
  * Clears `config_set` structure, removes all saved variable-value pairs.
@@ -495,8 +496,9 @@ struct repository;
 void repo_config(struct repository *repo, config_fn_t fn, void *data);
 int repo_config_get_value(struct repository *repo,
 			  const char *key, const char **value);
-const struct string_list *repo_config_get_value_multi(struct repository *repo,
-						      const char *key);
+int repo_config_get_value_multi(struct repository *repo,
+				const char *key,
+				const struct string_list **dest);
 int repo_config_get_string(struct repository *repo,
 			   const char *key, char **dest);
 int repo_config_get_string_tmp(struct repository *repo,
@@ -546,7 +548,8 @@ int git_config_get_value(const char *key, const char **value);
  * `key` is not found, returns NULL. The caller should not free or modify
  * the returned pointer, as it is owned by the cache.
  */
-const struct string_list *git_config_get_value_multi(const char *key);
+int git_config_get_value_multi(const char *key,
+			       const struct string_list **dest);
 
 /**
  * Resets and invalidates the config cache.
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 440407f1be7..0d704dc76ef 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2301,7 +2301,13 @@ int bitmap_is_midx(struct bitmap_index *bitmap_git)
 
 const struct string_list *bitmap_preferred_tips(struct repository *r)
 {
-	return repo_config_get_value_multi(r, "pack.preferbitmaptips");
+	const struct string_list *dest;
+	int ret;
+
+	ret = repo_config_get_value_multi(r, "pack.preferbitmaptips", &dest);
+	if (ret < 0)
+		BUG("got %d from repo_config_get_value_multi()", ret);
+	return dest;
 }
 
 int bitmap_is_preferred_refname(struct repository *r, const char *refname)
