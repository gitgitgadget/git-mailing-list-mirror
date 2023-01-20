Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A100C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 16:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjATQqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 11:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjATQqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 11:46:09 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B3479EB3
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 08:46:07 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x10so7430184edd.10
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 08:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBp1v5ADoNzPxf4oWynO+CwFliUvw3ixA+sX5xxSkh8=;
        b=qsLYFTlJrOy0isBrtB48V/m2vgxkRBNSRUDIM4YE+B+Rax7TmvL+F7XmnHf9uxn1ea
         K9adVRPS3nkAsvoN4qGLRouqxTs10bdEbL/0JDGE/i7XQPDV6iLTFzJdNQWpYn/EgfdK
         rnx0t1oe1yXaxB7wV/uI4C5Izop6wOTpN70h+B/DVSy9YMq2E7jzRBshuGfYb6kQwR/w
         NAWL71EauiPx6085JW8GrD3LxjFWN9l90mCBKSZ1y8n8solqaez8+D0QaDmycU4ysQ9f
         phCtn4ex56tpPk6o/PPNtw0LuyT5hvzq4hpa1IulS1T+Fon25vGhBSX4+3aMJFaXRnhW
         PjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBp1v5ADoNzPxf4oWynO+CwFliUvw3ixA+sX5xxSkh8=;
        b=DDj42vz/AQdDpWpe0Djl4ZpbgwILIivfZek+PV6h0mB//l5EOQmmnC8+nPRZIBaZ03
         ij2fb/70I41SdBxFa2RuqOkg5Xc1KTWFVmsrr85Ty52snLqyrA/qPuhuJdMXWyz+8J79
         TWSiQXAjw0USF7PkNCacJBfsTimV2AZYGedXUjdbiyPwvd/cDi4fpsqDWnPSEySvu6S4
         ab0ATFfpxuwbPJkAnGqe+pOpgSVs2aF/alef70iGEOL+40LvLyYfaL83ZBKK9JAsuSfe
         9JW81FDWSIR3n5YvI5HPd+zWoiYs5k3nUemDq8NCA8RS8pWBL7E2uqMXxOzTGkPyuAoq
         Ae3Q==
X-Gm-Message-State: AFqh2kpOWRUhW8PPN4CmNtM46BrhTn6lo/ond9Aiw71Khz0bEnPbwCTt
        Gua0vXrRyq93EhBxiY5vQaQ=
X-Google-Smtp-Source: AMrXdXuoEdYFx3C7f+vtXO7AawR49wB8JGMhrj/kLZZg4VEJRaBM+7vnR8jaZs+sDUZdKHY976pPFA==
X-Received: by 2002:aa7:d701:0:b0:49a:d3c2:c76f with SMTP id t1-20020aa7d701000000b0049ad3c2c76fmr16884689edq.13.1674233165898;
        Fri, 20 Jan 2023 08:46:05 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402150600b0049622a61f8fsm17605423edw.30.2023.01.20.08.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 08:46:05 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <bb75c8e1-05d3-1359-e06a-ee013ae677da@dunelm.org.uk>
Date:   Fri, 20 Jan 2023 16:46:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] rebase: mark --update-refs as requiring the merge
 backend
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
 <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
 <2e44d0b7e571cfac2a25d00f3fe3d143c895793b.1674190573.git.gitgitgadget@gmail.com>
In-Reply-To: <2e44d0b7e571cfac2a25d00f3fe3d143c895793b.1674190573.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

Thanks for working on this

On 20/01/2023 04:56, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> --update-refs is built in terms of the sequencer, which requires the
> merge backend.  It was already marked as incompatible with the apply
> backend in the git-rebase manual, but the code didn't check for this
> incompatibility and warn the user.  Check and warn now.

Strictly speaking we die rather than warn but I don't think that 
warrants a re-roll. I just had a quick look to see how easy it would be 
to add the advice Stolee's patch had if the user has set 
rebase.updaterefs but does not pass "--no-update-refs" when using the 
apply backend but it looks a bit fiddly unfortunately as we could die in 
imply_merge() or later on.

Thinking more generally, imply_merge() does a good job of telling the 
user which option is incompatible with "--apply" but if the user passes 
a merge option with "--whitespace=fix" and omits "--apply" then we just 
print a generic message saying "apply options and merge options cannot 
be used together" which isn't terribly helpful to the user (doubly so 
when the merge option come from a config setting).

I've also noticed that "--autosquash" is ignored if we end up using the 
apply backend. That's a separate issue but shares the "this may have 
come from a config setting rather than a command line argument" problem.

All in all I'm not sure if it is friendlier to die when the user has 
rebsase.updaterefs set and they try to rebase with "--whitespace=fix" or 
if it is better just to ignore the config in that case. If we can find a 
way to print some help when we die in that case it would be nicer for 
the user.

Best Wishes

Phillip

> While at it, fix a typo in t3422...and fix some misleading wording (all
> useful options other than --whitespace=fix have long since been
> implemented in the merge backend).
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   builtin/rebase.c                       |  3 +++
>   t/t3422-rebase-incompatible-options.sh | 15 ++++++++++-----
>   2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index ace8bd4a41c..e8bcdbf9fcd 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1507,6 +1507,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		}
>   	}
>   
> +	if (options.update_refs)
> +		imply_merge(&options, "--update-refs");
> +
>   	if (options.type == REBASE_UNSPECIFIED) {
>   		if (!strcmp(options.default_backend, "merge"))
>   			imply_merge(&options, "--merge");
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index ebcbd79ab8a..d72c863b21b 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -25,11 +25,11 @@ test_expect_success 'setup' '
>   '
>   
>   #
> -# Rebase has lots of useful options like --whitepsace=fix, which are
> -# actually all built in terms of flags to git-am.  Since neither
> -# --merge nor --interactive (nor any options that imply those two) use
> -# git-am, using them together will result in flags like --whitespace=fix
> -# being ignored.  Make sure rebase warns the user and aborts instead.
> +# Rebase has a useful option, --whitespace=fix, which is actually
> +# built in terms of flags to git-am.  Since neither --merge nor
> +# --interactive (nor any options that imply those two) use git-am,
> +# using them together will result in --whitespace=fix being ignored.
> +# Make sure rebase warns the user and aborts instead.
>   #
>   
>   test_rebase_am_only () {
> @@ -60,6 +60,11 @@ test_rebase_am_only () {
>   		test_must_fail git rebase $opt --exec 'true' A
>   	"
>   
> +	test_expect_success "$opt incompatible with --update-refs" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --update-refs A
> +	"
> +
>   }
>   
>   test_rebase_am_only --whitespace=fix
