Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9885C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 16:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1AD20637
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 16:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/LaCkdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgCOQYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 12:24:25 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41052 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgCOQYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 12:24:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id s11so10536824qks.8
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 09:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6EaLdCKYQ7m/dLZ+Z5rJAHfp7rmBZ4iHV4S/Z+0tRXk=;
        b=B/LaCkdk5J7zvCcbfZyeH6fuBPv+pYG/zLky9SEsizWwCbqshbPdnaKmigT/cTCEEW
         nvAGu1/A8Sj1s1W6Ps9yjg+bEH8AwNbKPPOQNzkNYJMr9VWsEeW1EOBAiZlJDGDm4PT8
         qfnXuvEzrd25fD+tsQyhkcLO/eq3FP2WXCFTX3G8cGrlmd6BIPABySGVWy3BLiOijM2r
         JkmTGBq26RrmjL92eNlbOFH5lamz4NICpooXDlDP3EHmWwuMM/8UQWE1DPOAaD6BZ+5S
         HYrkAUcj8DuexlkQ+Ljw3sXTOkbgCOSDl5/11JwASmSm4xsKH15GAHrwCY81WU9NbQbu
         FrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6EaLdCKYQ7m/dLZ+Z5rJAHfp7rmBZ4iHV4S/Z+0tRXk=;
        b=H6Fqc+TyRYScxnjN+5m/fPMzPxFizGtl2SS5tyUHM41QXo2fkOzzkxgtPpqCP/dfb6
         HF8IQwOL18MOE2zYJVyDWrWBVimE36PvtTJafKbI+1WL6Kimg1VPxgcXJ8gOyIRvt1qn
         4O2eB3dMDGVEMa729nxafdKDGD+ecK/Kv0JpLLLw//DQNvNiAEiwOMoNEEc5FUtjNMWD
         Fk7mNqloiJ0piaY5fdr9Pg77zQR4ALR2jPsddGkJWXCeHE0UbJdyejYCxiTxI0sN3wxq
         WH+gmOCLWZG+gAl4DoVxN6ZFkWvQiTWcWg7LSlwmQTaoX9LRZMK3F4LJYiNkCq5wC4DC
         /ang==
X-Gm-Message-State: ANhLgQ3wY4e9VKWAGELzZImoh/A7QceobbejRiUBBHFr/Wj/JSkVSbk9
        xQXYyOyflKbtCjaQKxOX8dUceLXhH/Y=
X-Google-Smtp-Source: ADFU+vshGiVW8zCTdJe2W1QygLzGneCvOlr/nik1CT0MDalLODDSz9G7mHuLD7YqS75n6cZVVCxSAw==
X-Received: by 2002:a37:a90a:: with SMTP id s10mr10359045qke.90.1584289463794;
        Sun, 15 Mar 2020 09:24:23 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j50sm4041071qta.42.2020.03.15.09.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2020 09:24:23 -0700 (PDT)
Subject: Re: [PATCH 7/7] sparse-checkout: provide a new update subcommand
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <650db6863426ae2b324ba717f898247f44279cb8.1584169893.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ee9e8bc6-252f-8ac5-e769-26302f3eb1eb@gmail.com>
Date:   Sun, 15 Mar 2020 12:24:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <650db6863426ae2b324ba717f898247f44279cb8.1584169893.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/14/2020 3:11 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> If commands like merge or rebase materialize files as part of their work,
> or a previous sparse-checkout command failed to update individual files
> due to dirty changes, users may want a command to simply 'reapply' the
> sparsity rules.  Provide one.

I was actually thinking "refresh" would be a better name, but also you
use "reapply" which is good, too. I'm concerned that "update" may imply
that the sparse-checkout patterns can change, but you really mean to
re-do the work from a previous "git sparse-checkout (set|add)".

I also thought of "reset" but that would be a confusing overload.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-sparse-checkout.txt | 10 ++++++++++
>  builtin/sparse-checkout.c             | 10 +++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index c0342e53938..27f4392489f 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -70,6 +70,16 @@ C-style quoted strings.
>  	`core.sparseCheckoutCone` is enabled, the given patterns are interpreted
>  	as directory names as in the 'set' subcommand.
>  
> +'update'::
> +	Update the sparseness of paths in the working tree based on the
> +	existing patterns.  Commands like merge or rebase can materialize
> +	paths to do their work (e.g. in order to show you a conflict), and
> +	other sparse-checkout commands might fail to sparsify an individual
> +	file (e.g. because it has unstaged changes or conflicts).  In such
> +	cases, it can make sense to run `git sparse-checkout update` later
> +	after cleaning up affected paths (e.g. resolving conflicts, undoing
> +	or committing changes, etc.).
> +
>  'disable'::
>  	Disable the `core.sparseCheckout` config setting, and restore the
>  	working directory to include all files. Leaves the sparse-checkout
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 5d3ec2e6be9..2ae21011dfd 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -18,7 +18,7 @@
>  static const char *empty_base = "";
>  
>  static char const * const builtin_sparse_checkout_usage[] = {
> -	N_("git sparse-checkout (init|list|set|add|disable) <options>"),
> +	N_("git sparse-checkout (init|list|set|add|update|disable) <options>"),
>  	NULL
>  };
>  
> @@ -552,6 +552,12 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
>  	return modify_pattern_list(argc, argv, m);
>  }
>  
> +static int sparse_checkout_update(int argc, const char **argv)
> +{
> +	repo_read_index(the_repository);
> +	return update_working_directory(NULL);
> +}
> +

Short and sweet! I suppose my earlier comment about whether
repo_read_index() was necessary is answered here. Perhaps it
should be part of update_working_directory()? (And pass a
repository pointer to it?)

>  static int sparse_checkout_disable(int argc, const char **argv)
>  {
>  	struct pattern_list pl;
> @@ -601,6 +607,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>  			return sparse_checkout_set(argc, argv, prefix, REPLACE);
>  		if (!strcmp(argv[0], "add"))
>  			return sparse_checkout_set(argc, argv, prefix, ADD);
> +		if (!strcmp(argv[0], "update"))
> +			return sparse_checkout_update(argc, argv);
>  		if (!strcmp(argv[0], "disable"))
>  			return sparse_checkout_disable(argc, argv);
>  	}

Thanks,
-Stolee


