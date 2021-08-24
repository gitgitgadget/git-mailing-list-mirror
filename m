Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD6BC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E81961246
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 15:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbhHXPNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbhHXPNN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 11:13:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37FFC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 08:12:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e21so29137528ejz.12
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=BfMwh4w54t1BFrjEZGohOWmGovTXkI7Z9gwfpata1ZI=;
        b=WT3dOJZ9gBPnA0GvOdKpy+td9sUIP2PCVn4w4xX1n8WXglma3K0MxG2ZkW47hJ8lNL
         Ayd1TEEIJ+OKVXi6IvsSbJ+ztf+ZWAvuLy7cquS2ubyFZeItJQVDssiNAvlDSgEbMZFP
         /CZJDsaVEzCec16jw+gIMX47KRMLZkPKErXGu9x11UFX4yeY9UXSTW5CKItxnjupN0If
         hajKXnzG2nJfNTZruC7fmg4iGTYt09SHAGPhrLpC8OFq6bBoM3COYvaK0eypsGdaJUH1
         mn7sapLESQNBpBnw13r0ZlTb0NICucDeE1HUYzulf2xXkZpDv2KnEWKSjtTZGe6+D5zb
         2LfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=BfMwh4w54t1BFrjEZGohOWmGovTXkI7Z9gwfpata1ZI=;
        b=D5+7na/JwSiLtGeqQW5rfT6WEwCpGjhjDNMLOZR+RE5RTG2c7bb09FX+CkjqsANLMY
         pRBAdsOjZ3xACbk+gb+CBNW1+CUI9GXebqMMKWBSuvzZTLHzPt9w06CZyptGVG69kcMl
         XLCoWkthwyg7qCIzbLpjNVsjAZcKTXezqSLEYAPpBRHl8Kum2m3CM9qnlGZ4HiPq5Rle
         ib46hrWEHY5u1ifBdkl7zXc6l5BlPtx1D2VcB4mVuuVIXlZy9+B9TmAjhLsi55bp4wi1
         t9ZdwCYw/8jhibXooqFY3biQ7P47Yy2FO7i4rK8yMVGI0M8C1qwk+TbtRDG89NV+ffPQ
         10Qg==
X-Gm-Message-State: AOAM530/SyBEAuIqJ2XwdR/wFEtZyVfs52t/BVRHWrcHX2B8P7xBOoaL
        gft8VPBA/NWlJ3zLvAkyoXo=
X-Google-Smtp-Source: ABdhPJztkU7amOw44ImvsHkcbp5IyaRfoVNTpSMIl4k0ZCN/pug80eYDwJQdmb4BUNPCmrzTgwN7oA==
X-Received: by 2002:a17:906:3159:: with SMTP id e25mr41319997eje.549.1629817947257;
        Tue, 24 Aug 2021 08:12:27 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b15sm3509708ejq.83.2021.08.24.08.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 08:12:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/6] hook: introduce "git hook list"
Date:   Tue, 24 Aug 2021 17:08:25 +0200
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-4-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210819033450.3382652-4-emilyshaffer@google.com>
Message-ID: <87tujeev1h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 18 2021, Emily Shaffer wrote:

> +static int list(int argc, const char **argv, const char *prefix)
> +{
> +	struct list_head *head, *pos;
> +	const char *hookname = NULL;
> +	struct strbuf hookdir_annotation = STRBUF_INIT;
> +
> +	struct option list_options[] = {
> +		OPT_END(),
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, list_options,
> +			     builtin_hook_list_usage, 0);
> +
> +	if (argc < 1)
> +		usage_msg_opt(_("You must specify a hook event name to list."),
> +			      builtin_hook_list_usage, list_options);

Untested, but aren't we silently ignoring:

    git hook list pre-receive some extra gar bage here

I.e. shouldn't this be an "argc != 1" check?

> +
> +	hookname = argv[0];
> +
> +	head = hook_list(hookname);
> +
> +	if (list_empty(head))
> +		return 1;
> +
> +	list_for_each(pos, head) {
> +		struct hook *item = list_entry(pos, struct hook, list);
> +		item = list_entry(pos, struct hook, list);
> +		if (item)
> +			printf("%s\n", item->hook_path);

Nit/suggestion: use puts(x) instead of printf("%s\n", x), but that's
also a bikeshedding/style preference, so ignore if you disagree...

> +	}
> +
> +	clear_hook_list(head);

Nit/API suggestion: Maybe s/list_for_each/list_for_each_safe/ and
remove_hook() in the loop would make more sense for this one-shot caller
than iterating over the list twice?

Anyway, currently remove_hook() is static, and it's probably good to not
peek behind the curtain here, so on second thought clear_hook_list() is
probably best...

> +	strbuf_release(&hookdir_annotation);

This function did nothing with hookdir_annotation. Looks like leftover
WIP code, but maybe it's used in (and should be moved to) a later
commit, let's keep reading...

> [...]
>  	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
>  
> +
>  	INIT_LIST_HEAD(hook_head);

..ditto...
>  
>  	if (!hookname)
> @@ -103,8 +104,6 @@ struct list_head *list_hooks(const char *hookname)
>  
>  	if (have_git_dir()) {
>  		const char *hook_path = find_hook(hookname);
> -

... earlier notes about whitespace churn...

> -		/* Add the hook from the hookdir */
>  		if (hook_path) {
>  			struct hook *to_add = xmalloc(sizeof(*to_add));
>  			to_add->hook_path = hook_path;

