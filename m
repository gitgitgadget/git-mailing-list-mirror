Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC15EC25B4E
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 15:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjAXPaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 10:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjAXPaG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 10:30:06 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ADF213A
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:30:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y19so18680778edc.2
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=od1aXjg2gC1JYzZ/QbamlUlENyzSqerxG/yiMzV9/Bs=;
        b=ViDiNaU61IzmY+gIV0tq5bs206/8xYluyaHHMvWjerAzYjvKCAthf9RO9WvzlP80pM
         J0ab2Uz43IRFsPR6UsO+BX8Qta99SUjLya4YXvdLjFb9d6YiIFMQqOvH2HemP7ZjSs1u
         A5xDab9wtlqWDNQb8U+MibCXmc35MQakJVHR9J8Xd0hhCi7+EZAM8yN09tZzHA7jQQHQ
         gxAYCOu4ke5hcaE6/k/IvTrIlOG9Ky4pjp7jO7sBSeInj2s/3tyutaPx0VSXiHyTyafa
         DE7j8jZWI6LNQ8+/VZmY3V+ZA8z+Ej+MJnoBy9GK26Y0Y/xMCCVnmJb2wwIWzKP3hFcr
         MoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=od1aXjg2gC1JYzZ/QbamlUlENyzSqerxG/yiMzV9/Bs=;
        b=izRDU7SSZzG84Itka2mosWCDgIvWQBCfA+mIy9OTV5fNNspAEk9SAvPGlAhPV8hOku
         wiYuW2+h0EifnGkqltDx6EpgOUgI61JErgx94l053s/FrtOLXrf7geLxs6hXeIS0SE0S
         JAHSogz3rjSwp6cPBhS/ZwPkWj94mlRakZzTubIVIvZvLXQA4gaNv+vanvVjC3/cUuL7
         fOJtqsoxodtSlV5erwqpb8ZHF4FL57LhMjS3DsiIan4sQP9aRyaagcQazyK+9YWfFNoy
         Ozl0cT+L4mPG6U6RfrucEMaq+ecVhrHaSSXA2Xowj8KKjPj4DZY1w2EnIHfqEtNdjMlS
         AtEg==
X-Gm-Message-State: AFqh2kpN97q6oKko1iFLPfih4HvzrU4jq/+rDw0o6fdNkGftO33Ke+wy
        Nyhzr6TaX0yiBm7rXVZnnbg+Xg==
X-Google-Smtp-Source: AMrXdXtbuJEpWsM8gx22G2my8gohM6wKUP7Jc4BJJnU/oWx1jpSi/d02J5TuQaHDfv4xf9jRy2mZ4Q==
X-Received: by 2002:a05:6402:28b5:b0:49e:2681:65b9 with SMTP id eg53-20020a05640228b500b0049e268165b9mr30322262edb.7.1674574203490;
        Tue, 24 Jan 2023 07:30:03 -0800 (PST)
Received: from [10.45.34.243] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id b26-20020a170906491a00b0086edf177209sm1052448ejq.78.2023.01.24.07.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 07:30:03 -0800 (PST)
Message-ID: <996451ae-0d9d-e09c-0fe4-8b037b72ec5c@unity3d.com>
Date:   Tue, 24 Jan 2023 16:30:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ls-tree: add --sparse-filter-oid argument
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
 <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
 <230123.865ycxtn7i.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <230123.865ycxtn7i.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/2023 14.00, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jan 23 2023, William Sprent via GitGitGadget wrote:
> 
>> From: William Sprent <williams@unity3d.com>
>>
>> There is currently no way to ask git the question "which files would be
>> part of a sparse checkout of commit X with sparse checkout patterns Y".
>> One use-case would be that tooling may want know whether sparse checkouts
>> of two commits contain the same content even if the full trees differ.
>> Another interesting use-case would be for tooling to use in conjunction
>> with 'git update-index --index-info'.
> 
> Rather than commenting on individual points, I checked this out and
> produced something squashable on-top, it fixes various issues (some
> aspects of which still remain):

Thanks. The changes all make sense to me. I'll apply them for v3 and
shorten the remaining long lines.

> 
>   * You need to wrap your code at 79 chars (and some of that could be
>     helped by picking less verbose identifiers & variable names,
>     e.g. just use "context" rather than "read_tree_context" in
>     cmd_ls_tree(), it has no other "context"...)>   * You're making the memory management aroind init_sparse_filter_data()
>     needlessly hard, just put it on the stack instead. That also allows
>     for init-ing most of it right away, or via a macro in the assignment.

Fair point. I do think that having all the initialisation of the struct
in one place makes the codes a bit more readable. But I guess it doesn't
make a big difference in this case.

>   * You have a stray refactoring of dir.c in your proposed change, this
>     changes it back, let's leave that sort of thing out.
>   * You're adding a function that returns an enum, but you declare it as
>     returning "int", let's retain that type in the header & declaration.

These were oversights. Thanks for catching them.

> 
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 46a815fc7dc..68d6ef675f2 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -372,36 +372,37 @@ struct sparse_filter_data {
>   	struct ls_tree_options *options;
>   };
>   
> -static void init_sparse_filter_data(struct sparse_filter_data **d, struct ls_tree_options *options,
> -	const char *sparse_oid_name, read_tree_fn_t fn)
> +static void init_sparse_filter_data(struct sparse_filter_data *d,
> +				    const char *sparse_oid_name)
>   {
>   	struct object_id sparse_oid;
>   	struct object_context oc;
>   
> -	(*d) = xcalloc(1, sizeof(**d));
> -	(*d)->fn = fn;
> -	(*d)->pl.use_cone_patterns = core_sparse_checkout_cone;
> -	(*d)->options = options;
> -	strbuf_init(&(*d)->full_path_buf, 0);
> -
>   	if (get_oid_with_context(the_repository, sparse_oid_name, GET_OID_BLOB,
>   			&sparse_oid, &oc))
> -		die(_("unable to access sparse blob in '%s'"), sparse_oid_name);
> -	if (add_patterns_from_blob_to_list(&sparse_oid, "", 0, &(*d)->pl) < 0)
> +		die(_("unable to access sparse blob in '%s'"),
> +		    sparse_oid_name);
> +	if (add_patterns_from_blob_to_list(&sparse_oid, "", 0, &d->pl) < 0)
>   		die(_("unable to parse sparse filter data in %s"),
>   		    oid_to_hex(&sparse_oid));
>   }
>   
> -static void free_sparse_filter_data(struct sparse_filter_data *d)
> +static void release_sparse_filter_data(struct sparse_filter_data *d)
>   {
>   	clear_pattern_list(&d->pl);
>   	strbuf_release(&d->full_path_buf);
> -	free(d);
>   }
>   
> -static int path_matches_sparse_checkout_patterns(struct strbuf *full_path, struct pattern_list *pl, int dtype)
> +static int path_matches_sparse_checkout_patterns(struct strbuf *full_path,
> +						 struct pattern_list *pl,
> +						 int dtype)
>   {
> -	enum pattern_match_result match = recursively_match_path_with_sparse_patterns(full_path->buf, the_repository->index, dtype, pl);
> +	enum pattern_match_result match;
> +
> +	match = recursively_match_path_with_sparse_patterns(full_path->buf,
> +							    the_repository->index,
> +							    dtype, pl);
> +
>   	return match > 0;
>   }
>   
> @@ -436,7 +437,10 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>   	struct ls_tree_options options = { 0 };
>   	char *sparse_oid_name = NULL;
>   	void *read_tree_context = NULL;
> -	struct sparse_filter_data *sparse_filter_data = NULL;
> +	struct sparse_filter_data sparse_filter_data = {
> +		.options = &options,
> +		.full_path_buf = STRBUF_INIT,
> +	};
>   	const struct option ls_tree_options[] = {
>   		OPT_BIT('d', NULL, &options.ls_options, N_("only show trees"),
>   			LS_TREE_ONLY),
> @@ -542,16 +546,17 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>   	}
>   
>   	if (sparse_oid_name) {
> -		init_sparse_filter_data(&sparse_filter_data, &options, sparse_oid_name, fn);
> -		read_tree_context = sparse_filter_data;
> +		sparse_filter_data.fn = fn;
> +		init_sparse_filter_data(&sparse_filter_data, sparse_oid_name);
> +		read_tree_context = &sparse_filter_data;
>   		fn = filter_sparse;
>   	} else
>   		read_tree_context = &options;
>   
> -	ret = !!read_tree(the_repository, tree, &options.pathspec, fn, read_tree_context);
> +	ret = !!read_tree(the_repository, tree, &options.pathspec, fn,
> +			  read_tree_context);
>   	clear_pathspec(&options.pathspec);
> -	if (sparse_filter_data)
> -		free_sparse_filter_data(sparse_filter_data);
> +	release_sparse_filter_data(&sparse_filter_data);
>   
>   	return ret;
>   }
> diff --git a/dir.c b/dir.c
> index 122ebced08e..57ec6404901 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1457,10 +1457,10 @@ int init_sparse_checkout_patterns(struct index_state *istate)
>   	return 0;
>   }
>   
> -int recursively_match_path_with_sparse_patterns(const char *path,
> -						struct index_state *istate,
> -						int dtype,
> -						struct pattern_list *pl)
> +enum pattern_match_result recursively_match_path_with_sparse_patterns(const char *path,
> +								      struct index_state *istate,
> +								      int dtype,
> +								      struct pattern_list *pl)
>   {
>   	enum pattern_match_result match = UNDECIDED;
>   	const char *end, *slash;
> @@ -1470,7 +1470,8 @@ int recursively_match_path_with_sparse_patterns(const char *path,
>   	 * never returns UNDECIDED, so we will execute only one iteration in
>   	 * this case.
>   	 */
> -	for (end = path + strlen(path); end > path && match == UNDECIDED;
> +	for (end = path + strlen(path);
> +	     end > path && match == UNDECIDED;
>   	     end = slash) {
>   		for (slash = end - 1; slash > path && *slash != '/'; slash--)
>   			; /* do nothing */
> diff --git a/dir.h b/dir.h
> index d186d271606..3c65e68ca40 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -403,10 +403,10 @@ int path_in_sparse_checkout(const char *path,
>   int path_in_cone_mode_sparse_checkout(const char *path,
>   				      struct index_state *istate);
>   
> -int recursively_match_path_with_sparse_patterns(const char *path,
> -						struct index_state *istate,
> -						int dtype,
> -						struct pattern_list *pl);
> +enum pattern_match_result recursively_match_path_with_sparse_patterns(const char *path,
> +								      struct index_state *istate,
> +								      int dtype,
> +								      struct pattern_list *pl);
>   
>   struct dir_entry *dir_add_ignored(struct dir_struct *dir,
>   				  struct index_state *istate,

