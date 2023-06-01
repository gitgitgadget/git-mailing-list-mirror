Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237B7C7EE2A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 09:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjFAJvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 05:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjFAJvE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 05:51:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F45018B
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 02:50:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30aa1eb95a0so677490f8f.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 02:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685613057; x=1688205057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rxims8VSO0AmllfZOFO0FOVzExrx8xdqc6b1DJsiA2k=;
        b=qO9RFLz36uh46IlENtWcRP9IZeBQbej8mFXCeFZJowuEU1depjQW5EAWAEWzaEFQzh
         5gI50s/xsorGBWBIaf+iUFvSt41UPAZ/hrZkAVMySOBxXxYfP438W7IiYqU/D0WyGuPx
         pcfdW5SPxWF95+1HIjnNQvC7xTx/y4SAj4MxPBYJ/j//TJ+KREuz4sXT4gbfSCjxDkd0
         5pDXTubiWIFnGPGg0TjK1tljLfu4+zNxdwUHiL0Z6aSKc8vigtsGxs8OxLKgsFa5LUVP
         c3D1ZMGC1xJuZLcKOI8opY4x4YWqgQTvGxHSj1L+EBixFWGe0pfTw1zB6wLYNFqDY9Se
         iZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613057; x=1688205057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rxims8VSO0AmllfZOFO0FOVzExrx8xdqc6b1DJsiA2k=;
        b=fUQixxD0pM3YaE2Geow2hsMDvut37TWnwHU/Xx2IfKvUvWZ98BeAdNFpfjAjitk4Hd
         GD2awK2AOQc0QC+I3SlqreJpLr+tTaYVfNloSmAJILpLk/6WkrujC0DeFmI5m6HSc8I3
         wq7GjJV6y6EOaPDffPD8c/OU3k9pIeIabC1lMIiG825o1EYEfl99T+0n0XGPZEH126N6
         Uc1oHSUfa83erJq+das+dG2C1vjZRW6NyWgEXeTayh64mifMoznOqA3dZ9QLtdyi+0x8
         oDkM6YG0QzaFfnS5CIlNMbHX8PFKWNVt2LyPlMN3fXKDc7FHElMUFXlHzk69jxycC1tI
         FuLQ==
X-Gm-Message-State: AC+VfDxD8klrk6PUORYBdwyxIv3fImfpKgrahM/A4+XF7hvGx3GvctmQ
        xdeAdDfLrCt5f0jdKUlQ3QA=
X-Google-Smtp-Source: ACHHUZ6z7mwyYp1qJNDGcXShxJjGOkC+P5xLPnakn5fMlXBo/ueLDojJHGF2tYqeQV41/BAIMHny5g==
X-Received: by 2002:a05:6000:ce:b0:30a:ebe2:5e44 with SMTP id q14-20020a05600000ce00b0030aebe25e44mr1245888wrx.67.1685613057144;
        Thu, 01 Jun 2023 02:50:57 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id x2-20020adff0c2000000b0030af20aaa3fsm9808615wro.71.2023.06.01.02.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 02:50:56 -0700 (PDT)
Message-ID: <6faf1b17-a1ca-0c22-2e43-aee121c4e36a@gmail.com>
Date:   Thu, 1 Jun 2023 10:50:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 03/14] (RFC-only) config: add kvi arg to config_fn_t
Content-Language: en-US
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
 <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
 <6834e37066e7877646fc7c37aa79704d14381251.1685472133.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <6834e37066e7877646fc7c37aa79704d14381251.1685472133.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen

On 30/05/2023 19:42, Glen Choo via GitGitGadget wrote:
> From: Glen Choo <chooglen@google.com>
> 
> ..without actually changing any of its implementations. This commit does
> not build - I've split this out for readability, but post-RFC I will
> squash this with the rest of the refactor + cocci changes.

While this ends up with a huge amount of churn, I think that is probably 
inevitable if we're going to get rid of global state (I see Ævar 
suggested adding a separate set of callbacks but I'm not sure how that 
would work with chaining up to git_default_config() and it would be nice 
to improve our error messages with filename and line information). I've 
not been following this thread all that closely but a couple of thoughts 
crossed by mind.

  - is it worth making struct key_value_info opaque and provide getters
    for the fields so we can change the implementation in the future
    without having to modify every user. We could rename it
    config_context or something generic like that if we think it might
    grow in scope in the future.

  - (probably impractical) could we stuff the key and value into struct
    key_value_info so config_fn_t becomes
    fn(const struct key_value_info, void *data)
    that would get rid of all the UNUSED annotations but would mean even
    more churn. The advantage is that one could add functions like
    kvi_bool_or_int(kvi, &is_bool) and get good error messages because
    all the config parsing functions would all have access to location
    information.

Best Wishes

Phillip

> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>   config.c                                      |   8 +-
>   config.h                                      |  16 +-
>   .../coccinelle/config_fn_kvi.pending.cocci    | 146 ++++++++++++++++++
>   3 files changed, 158 insertions(+), 12 deletions(-)
>   create mode 100644 contrib/coccinelle/config_fn_kvi.pending.cocci
> 
> diff --git a/config.c b/config.c
> index 493f47df8ae..945f4f3b77e 100644
> --- a/config.c
> +++ b/config.c
> @@ -489,7 +489,7 @@ static int git_config_include(const char *var, const char *value, void *data)
>   	 * Pass along all values, including "include" directives; this makes it
>   	 * possible to query information on the includes themselves.
>   	 */
> -	ret = inc->fn(var, value, inc->data);
> +	ret = inc->fn(var, value, NULL, inc->data);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -671,7 +671,7 @@ static int config_parse_pair(const char *key, const char *value,
>   	if (git_config_parse_key(key, &canonical_name, NULL))
>   		return -1;
>   
> -	ret = (fn(canonical_name, value, data) < 0) ? -1 : 0;
> +	ret = (fn(canonical_name, value, NULL, data) < 0) ? -1 : 0;
>   	free(canonical_name);
>   	return ret;
>   }
> @@ -959,7 +959,7 @@ static int get_value(struct config_source *cs, config_fn_t fn, void *data,
>   	 * accurate line number in error messages.
>   	 */
>   	cs->linenr--;
> -	ret = fn(name->buf, value, data);
> +	ret = fn(name->buf, value, NULL, data);
>   	if (ret >= 0)
>   		cs->linenr++;
>   	return ret;
> @@ -2303,7 +2303,7 @@ static void configset_iter(struct config_reader *reader, struct config_set *set,
>   
>   		config_reader_set_kvi(reader, values->items[value_index].util);
>   
> -		if (fn(entry->key, values->items[value_index].string, data) < 0)
> +		if (fn(entry->key, values->items[value_index].string, NULL, data) < 0)
>   			git_die_config_linenr(entry->key,
>   					      reader->config_kvi->filename,
>   					      reader->config_kvi->linenr);
> diff --git a/config.h b/config.h
> index 247b572b37b..9d052c52c3c 100644
> --- a/config.h
> +++ b/config.h
> @@ -111,6 +111,13 @@ struct config_options {
>   	} error_action;
>   };
>   
> +struct key_value_info {
> +	const char *filename;
> +	int linenr;
> +	enum config_origin_type origin_type;
> +	enum config_scope scope;
> +};
> +
>   /**
>    * A config callback function takes three parameters:
>    *
> @@ -129,7 +136,7 @@ struct config_options {
>    * A config callback should return 0 for success, or -1 if the variable
>    * could not be parsed properly.
>    */
> -typedef int (*config_fn_t)(const char *, const char *, void *);
> +typedef int (*config_fn_t)(const char *, const char *, struct key_value_info *, void *);
>   
>   int git_default_config(const char *, const char *, void *);
>   
> @@ -667,13 +674,6 @@ int git_config_get_expiry(const char *key, const char **output);
>   /* parse either "this many days" integer, or "5.days.ago" approxidate */
>   int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestamp_t now);
>   
> -struct key_value_info {
> -	const char *filename;
> -	int linenr;
> -	enum config_origin_type origin_type;
> -	enum config_scope scope;
> -};
> -
>   /**
>    * First prints the error message specified by the caller in `err` and then
>    * dies printing the line number and the file name of the highest priority
> diff --git a/contrib/coccinelle/config_fn_kvi.pending.cocci b/contrib/coccinelle/config_fn_kvi.pending.cocci
> new file mode 100644
> index 00000000000..d4c84599afa
> --- /dev/null
> +++ b/contrib/coccinelle/config_fn_kvi.pending.cocci
> @@ -0,0 +1,146 @@
> +// These are safe to apply to *.c *.h builtin/*.c
> +
> +@ get_fn @
> +identifier fn, R;
> +@@
> +(
> +(
> +git_config_from_file
> +|
> +git_config_from_file_with_options
> +|
> +git_config_from_mem
> +|
> +git_config_from_blob_oid
> +|
> +read_early_config
> +|
> +read_very_early_config
> +|
> +config_with_options
> +|
> +git_config
> +|
> +git_protected_config
> +|
> +config_from_gitmodules
> +)
> +  (fn, ...)
> +|
> +repo_config(R, fn, ...)
> +)
> +
> +@ extends get_fn @
> +identifier C1, C2, D;
> +@@
> +int fn(const char *C1, const char *C2,
> ++  struct key_value_info *kvi,
> +  void *D);
> +
> +@ extends get_fn @
> +@@
> +int fn(const char *, const char *,
> ++  struct key_value_info *,
> +  void *);
> +
> +@ extends get_fn @
> +// Don't change fns that look like callback fns but aren't
> +identifier fn2 != tar_filter_config && != git_diff_heuristic_config &&
> +  != git_default_submodule_config && != git_color_config &&
> +  != bundle_list_update && != parse_object_filter_config;
> +identifier C1, C2, D1, D2, S;
> +attribute name UNUSED;
> +@@
> +int fn(const char *C1, const char *C2,
> ++  struct key_value_info *kvi,
> +  void *D1) {
> +<+...
> +(
> +fn2(C1, C2,
> ++ kvi,
> +D2);
> +|
> +if(fn2(C1, C2,
> ++ kvi,
> +D2) < 0) { ... }
> +|
> +return fn2(C1, C2,
> ++ kvi,
> +D2);
> +|
> +S = fn2(C1, C2,
> ++ kvi,
> +D2);
> +)
> +...+>
> +  }
> +
> +@ extends get_fn@
> +identifier C1, C2, D;
> +attribute name UNUSED;
> +@@
> +int fn(const char *C1, const char *C2,
> ++  struct key_value_info *kvi UNUSED,
> +  void *D) {...}
> +
> +
> +// The previous rules don't catch all callbacks, especially if they're defined
> +// in a separate file from the git_config() call. Fix these manually.
> +@@
> +identifier C1, C2, D;
> +attribute name UNUSED;
> +@@
> +int
> +(
> +git_ident_config
> +|
> +urlmatch_collect_fn
> +|
> +write_one_config
> +|
> +forbid_remote_url
> +|
> +credential_config_callback
> +)
> +  (const char *C1, const char *C2,
> ++  struct key_value_info *kvi UNUSED,
> +  void *D) {...}
> +
> +@@
> +identifier C1, C2, D, D2, S, fn2;
> +@@
> +int
> +(
> +http_options
> +|
> +git_status_config
> +|
> +git_commit_config
> +|
> +git_default_core_config
> +|
> +grep_config
> +)
> +  (const char *C1, const char *C2,
> ++  struct key_value_info *kvi,
> +  void *D) {
> +<+...
> +(
> +fn2(C1, C2,
> ++ kvi,
> +D2);
> +|
> +if(fn2(C1, C2,
> ++ kvi,
> +D2) < 0) { ... }
> +|
> +return fn2(C1, C2,
> ++ kvi,
> +D2);
> +|
> +S = fn2(C1, C2,
> ++ kvi,
> +D2);
> +)
> +...+>
> +  }
