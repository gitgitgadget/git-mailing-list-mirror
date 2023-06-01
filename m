Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7D2C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 16:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjFAQgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 12:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjFAQgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 12:36:16 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF107D1
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 09:36:15 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-54290603887so56205a12.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685637375; x=1688229375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKW+XWVfLHZ7bwHLlCCppE+Sm7ehziRneA0auaYz2r8=;
        b=EclS6m7iu1gtHAlru2VxDy41a7sT6sKIR7P805Cn1Quv/3E0z3Pub2Xx9se0v+DDCH
         pV3KS0HhUg77l4Ejm5Xi0W9ANjDVgPtT3O4effd51asfZDl4iBlaiEwfkg93LybxmYNo
         +7RAL9W3fmgd0ImHMn6Nz/0b4Qqkf8JuR1+mXpMmxgdzINiOZczl98/kkD4mhgTvckyq
         evv3W/I6/+xnFgHt9xn3scwOAbVe08xHaXG5NmRsZidz+2EosLXH99EV1xe3g6b4coiX
         veTGFVgbemyW2ifzDsRfbv2T461C0urbkeaLWhZcXwUlbT0ATJSqbutB8LtSTXdxlwNA
         TiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637375; x=1688229375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKW+XWVfLHZ7bwHLlCCppE+Sm7ehziRneA0auaYz2r8=;
        b=KzqsJA69NtLcpnkRE/PiW4cRhMs8FdDXp2sE5VpEhKUa0vsSwFC8k3lwFL6IY95RXs
         tYKFaLJAWgSeGwbEXO3PnX3hfjRdTMVq1MSWBnZ+5uShvDg6GCkTGa3fsmnfuN1liMAB
         ZzgxPXSVWPKkBvpHo3iZGYIWdFVKCtPTkdVDq37QWNnWdk3vxkChuyT0TE5Gn2lyPzjd
         sxloLPeG5/sG2rbB+ZUxXWjUIOGpi86G/7MzkXjV5F3SZCwFGNKeniJw6XB6nMMUql+L
         fEBlQGXm994IHNWlBAu/dNcIgaB/+5Zm9W7lVKwS1npvQ+F5Aa/N7xDQdPQ3+2ATRNuV
         gyqw==
X-Gm-Message-State: AC+VfDyFtQ5Xo9n7ti80GeZVKdWS5O4oXkEpZXCOI2XXtZt8T/mDHIai
        EAly0+OjRkTsqHQvz8crKNmi
X-Google-Smtp-Source: ACHHUZ5z5hHHcXp0MkdV2nxijBaTRk3i7G7h4cZ5mvZrDOgK+5G/zLj/4LqjBWXKU0O/Mg8maTAYVg==
X-Received: by 2002:a17:902:8341:b0:1b1:9d43:ad4a with SMTP id z1-20020a170902834100b001b19d43ad4amr1223174pln.44.1685637374934;
        Thu, 01 Jun 2023 09:36:14 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id ay9-20020a1709028b8900b001aae909cfbbsm3731411plb.119.2023.06.01.09.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 09:36:14 -0700 (PDT)
Message-ID: <68fd5ca2-a6c2-d742-5d74-ba93c1497169@github.com>
Date:   Thu, 1 Jun 2023 09:36:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] repository: create read_replace_refs setting
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
 <481a81a515efb29bc4eb0b1a09b7d1df3f3c074b.1685126618.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <481a81a515efb29bc4eb0b1a09b7d1df3f3c074b.1685126618.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The 'read_replace_refs' global specifies whether or not we should
> respect the references of the form 'refs/replace/<oid>' to replace which
> object we look up when asking for '<oid>'. This global has caused issues
> when it is not initialized properly, such as in b6551feadfd (merge-tree:
> load default git config, 2023-05-10).
> 
> To make this more robust, move its config-based initialization out of
> git_default_config and into prepare_repo_settings(). This provides a
> repository-scoped version of the 'read_replace_refs' global.

As you noted in [1], this could be clearer. I think the most confusing part
is referring to it as "a repository-scoped version of the...global" because
it implies that the global and repo-scoped setting do the same thing/take
the same precedence (when, in reality, if replace refs are disabled
globally, the config doesn't do anything). Maybe something like this would
make that clearer?

"This provides a repository-scoped configuration that's only used if replace
refs are not already disabled process-wide with the global
'read_replace_refs'."

[1] https://lore.kernel.org/git/ae89feda-0a76-29d7-14ce-662214414638@github.com/

> 
> The global still has its purpose: it is disabled process-wide by the
> GIT_NO_REPLACE_OBJECTS environment variable or by a call to
> disable_replace_refs() in some specific Git commands.
> 
> Since we already encapsulated the use of the constant inside
> replace_refs_enabled(), we can perform the initialization inside that
> method, if necessary. This solves the problem of forgetting to check the
> config, as we will check it before returning this value.
> 
> There is an interesting behavior change possible here: we now have a
> repository-scoped understanding of this config value. Thus, if there was
> a command that recurses into submodules and might follow replace refs,
> then it would now respect the core.useReplaceRefs config value in each
> repository.
> 
> Unfortunately, the existing processes that recurse into submodules do
> not appear to follow object IDs to their contents, so this behavior
> change is not visible in the current implementation. It is something
> valuable for future behavior changes.

AFAIK, the only '--recurse-submodules' commands that recurse in-process are
'ls-files' and 'grep'. However, 'grep' does call 'parse_object_or_die()',
which (further down in the call stack) calls 'lookup_replace_object()'.
Maybe I'm misreading and the replaced object isn't actually used, but could
'git grep --recurse-submodules' be used to test this?

> @@ -94,5 +94,14 @@ void disable_replace_refs(void)
>  
>  int replace_refs_enabled(struct repository *r)
>  {
> -	return read_replace_refs;
> +	if (!read_replace_refs)
> +		return 0;
> +
> +	if (r->gitdir) {
> +		prepare_repo_settings(r);
> +		return r->settings.read_replace_refs;
> +	}
> +
> +	/* repository has no objects or refs. */
> +	return 0;
>  }

This implementation matches the intent outlined in this patch/the cover
letter:

- if replace refs are disabled process-wide, always return 0
- if the gitdir is present, return the value of 'core.usereplacerefs'
- if there's no gitdir, there's no repository set up (and therefore no
  config to read/objects to replace), so return 0

I was a bit unsure about whether 'r->gitdir' was the right check to make,
but it's consistent with other gates to 'prepare_repo_settings()' (e.g.
those added in 059fda19021 (checkout/fetch/pull/pack-objects: allow `-h`
outside a repository, 2022-02-08)), so I'm happy with it.

> diff --git a/repo-settings.c b/repo-settings.c
> index 1df0320bf33..5a7c990300d 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -68,6 +68,7 @@ void prepare_repo_settings(struct repository *r)
>  	repo_cfg_bool(r, "pack.usebitmapboundarytraversal",
>  		      &r->settings.pack_use_bitmap_boundary_traversal,
>  		      r->settings.pack_use_bitmap_boundary_traversal);
> +	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);

This defaults to enabling replace refs, consistent with the (intended)
behavior prior to this series. Good!

>  
>  	/*
>  	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
> diff --git a/repository.h b/repository.h
> index c42f7ab6bdc..13fefa540bc 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -39,6 +39,14 @@ struct repo_settings {
>  	int pack_read_reverse_index;
>  	int pack_use_bitmap_boundary_traversal;
>  
> +	/*
> +	 * Do replace refs need to be checked this run?  This variable is
> +	 * initialized to true unless --no-replace-object is used or
> +	 * $GIT_NO_REPLACE_OBJECTS is set, but is set to false by some
> +	 * commands that do not want replace references to be active.
> +	 */
> +	int read_replace_refs;

I don't think this comment is accurate anymore, since the repo-scoped
'read_replace_refs' value is determined *only* by the 'core.usereplacerefs'
config. It's 'replace_refs_enabled()' that makes the overall determination
(taking into account 'GIT_NO_REPLACE_OBJECTS'/'--no-replace-object').

> +
>  	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
>  
>  	int index_version;

