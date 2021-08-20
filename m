Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E44FC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E357260EBC
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhHTAjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhHTAjA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 20:39:00 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4699AC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:38:23 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r17-20020a0568302371b0290504f3f418fbso10912231oth.12
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EbHVlJ6ugIe8dmRPkPoFItXY3157x9LKDowZl7So9r8=;
        b=c0iwvuvoGlOWN817nZ5izS7YGD+fWgQ5DoFGB5dGjiQIGCuqO5Eq1+W/FSU5+JrJ/a
         Bn2tVDZE3gj25QdHmqb6Whv/2NC7dyX78uv/q/6XAEpbiwxXivl5dp5St0lWRpsAXiYu
         ftrfJu28Z1LNdu3vwjWDCLWLsm64bbEsfnKiZ/VV1ms++QX7JgHzla0nK2nqVDjL1gKN
         YWn2mfmYpkthlc0L9RpcRnhxjlpPypEssOD0skFufEx4750H8Q3fJiQOB5fR64SW/FWD
         5EyG/SUGkZmjz7zz33PcgXJCVey8CcZZFxrK3vN4rFGFQhPo8JGNtkB9BOa5T18olAM2
         zV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EbHVlJ6ugIe8dmRPkPoFItXY3157x9LKDowZl7So9r8=;
        b=U76TW3HxBU3jbkpQmgvufbzZ8jwt+5EmFOf1fPtbS8fA4/cXaXmM+ac5GUrql/55to
         FRzZ2PjEqnspAe/8U5x1ePnIOwBD++8pMOAkioxTrSrwIeirclfF/W9B3/WonfLXQhC3
         +pjjVCgN8LRx2MQrkorHufnFxKu8d/+rEc0C0UMxjIX8T0G14yW4xfdYRna9pZcZq+Et
         APYTxYY86akR0IIsO+F1GW2Nur7c4Nzi0BVOYwt1TEpSifvtBO+B+ku8iYKD4rQ/rA8G
         KHjqLLDmJWOXZUcbq0N9/MFUhUFDS4TYs7BdtF3f3byqCApCwhNpCu8ETlsDyhgag+Ww
         Ig+g==
X-Gm-Message-State: AOAM5320GrIoYctbTChH3u1FqrR+EG8gYOUvb4OefJOgwQa7H2l9epxp
        xDtthWaOHIbIt7kSNrCocag=
X-Google-Smtp-Source: ABdhPJxdS9rakcFrC+saL9DQNOQV6x/QpTIBssuG2LSFgiJQ03OLQ/xLl1OGpuoBjTDyKo+kMI3uag==
X-Received: by 2002:a9d:4f12:: with SMTP id d18mr14251879otl.6.1629419902542;
        Thu, 19 Aug 2021 17:38:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:2127:20ac:7d67:3e01? ([2600:1700:e72:80a0:2127:20ac:7d67:3e01])
        by smtp.gmail.com with ESMTPSA id f132sm727951oia.48.2021.08.19.17.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 17:38:21 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] introduce submodule.superprojectGitDir record
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20210819200953.2105230-1-emilyshaffer@google.com>
 <20210819200953.2105230-3-emilyshaffer@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9fecf160-9646-7e56-478c-aa5f8defa6a9@gmail.com>
Date:   Thu, 19 Aug 2021 20:38:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819200953.2105230-3-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2021 4:09 PM, Emily Shaffer wrote:
...
> +submodule.superprojectGitDir::
> +	The relative path from the submodule's worktree to its superproject's
> +	gitdir. When Git is run in a repository, it usually makes no difference
> +	whether this repository is standalone or a submodule, but if this
> +	configuration variable is present, additional behavior may be possible,
> +	such as "git status" printing additional information about this
> +	submodule's status with respect to its superproject. This config should
> +	only be present in projects which are submodules, but is not guaranteed
> +	to be present in every submodule, so only optional value-added behavior
> +	should be linked to it. It is set automatically during
> +	submodule creation.
> ++
> +	Because of this configuration variable, it is forbidden to use the
> +	same submodule worktree shared by multiple superprojects.

nit: this paragraph linked with the "+" line should have no tabbing.

Also, could we use the same submodule worktree for multiple superprojects
_before_ this configuration variable? That seems wild to me. Or, is that
not a new requirement?

Perhaps you mean something like this instead:

	It is forbidden to use the same submodule worktree for multiple
	superprojects, so this configuration variable stores the unique
	superproject and is not multi-valued.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d55f6262e9..d60fcd2c7d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1910,6 +1910,10 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
>  					   error_strategy);
>  
> +	git_config_set_in_file(p, "submodule.superprojectGitdir",
> +			       relative_path(absolute_path(get_git_dir()),
> +					     path, &sb));
> +

I see that all new submodules will have this configuration set. But we will
also live in a world where some existing submodules do not have this variable
set. I'll look elsewhere for compatibility checks.

>  inspect() {
> -	dir=$1 &&
> -
> -	git -C "$dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
> -	{ git -C "$dir" symbolic-ref HEAD || :; } >head &&
> -	git -C "$dir" rev-parse HEAD >head-sha1 &&
> -	git -C "$dir" update-index --refresh &&
> -	git -C "$dir" diff-files --exit-code &&
> -	git -C "$dir" clean -n -d -x >untracked
> +	sub_dir=$1 &&
> +	super_dir=$2 &&
> +
> +	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
> +	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
> +	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
> +	git -C "$sub_dir" update-index --refresh &&
> +	git -C "$sub_dir" diff-files --exit-code &&
> +	cached_super_dir="$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" &&
> +	[ "$(git -C "$super_dir" rev-parse --absolute-git-dir)" \
> +		-ef "$sub_dir/$cached_super_dir" ] &&
> +	git -C "$sub_dir" clean -n -d -x >untracked

You rewrote this test in the previous patch, and now every line is changed
because you renamed 'dir' to 'sub_dir'. Could the previous patch use
'sub_dir' from the start so this change only shows the new lines instead of
many edited lines?

>  }
>  
>  test_expect_success 'submodule add' '
> @@ -138,7 +142,7 @@ test_expect_success 'submodule add' '
>  	) &&
>  
>  	rm -f heads head untracked &&
> -	inspect addtest/submod &&
> +	inspect addtest/submod addtest &&

Similarly, I would not be upset to see these lines be changed just the
once, even if the second argument is ignored for a single commit. But
this nitpick is definitely less important since I could see taste
swaying things either way.

Thanks,
-Stolee
