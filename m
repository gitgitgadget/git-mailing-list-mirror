Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B4AC433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 15:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A7F61052
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 15:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhISPxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 11:53:11 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:30702 "EHLO
        ext-mx-out002.mykolab.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233428AbhISPxI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Sep 2021 11:53:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 95470A46;
        Sun, 19 Sep 2021 17:51:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1632066702; x=1633881103; bh=ph5mHGcAekvdvfUE2bK
        fqPCvwxUDIXdsFHceC8MRnx8=; b=OPzjg2qk43S8Ybbv5O7RGZ6SU4hx2WdZq66
        vnBwNb/7CYlEyYBeNlrKwspU1cU9Ju0dkVoxJOjaL1w6yJBe+aUh584eta9DIPP7
        lsAirF0G3M9f8TstlygnBM2BY4NG3oWDZWKccUNuFbaMS8n+WW7aUbdZznh9CuCD
        EyEv/40GTvck6GdsvutpMMgk4u33GzqzoXEijqr9zm+U+aSaHyW/0td7spkTeUXi
        MrxXf1PdV1QzspRNM6eZHzus6pQ541ReHjlhLGNjmv+DFXdNcu0SnDJjO8nI+ncw
        DCqg1EJTPBjHkOQrblsAKN3hkBCEfzlR2gB1KJvx5Z165qSwbmDjuplAUUKRbD5t
        GOm8wgBTAMw8BbvnuTEHxPuppjXEBzhezX9U8rZhXhn5CHfIMi2uyY6Q2KE+jnjO
        hXRu8J8W8tYKe1DRcoTRtJczd7bADZljIHnyMcSKOdrbm7Qt+Hy/5vuGx6OvVvXv
        LeFLLqsr4GMQVyRa20xjLk2g6NISHoBkUUbHQlLZ+97YrMcJH5MyOQJLMfqBkiFW
        LHnMeJ4j0SaFSgrNpCu/Bbt+NnMnFhT4B49wCOARnp0yt5NDqoY3O2OUB+un7e0f
        u5MXHmzW3GWCS0ZRMcUQKB8xDQD0juNLVXC/Jlyx1cnwZmVplImg1Cxjqb06k53C
        Cbt6+cuc=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from ext-mx-out002.mykolab.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cdD1caZPEF4i; Sun, 19 Sep 2021 17:51:42 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id F00EA3D8;
        Sun, 19 Sep 2021 17:51:41 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id F385CF00;
        Sun, 19 Sep 2021 17:51:40 +0200 (CEST)
Subject: Re: [PATCH 1/2] log: UNLEAK rev to silence a large number of leaks
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <ajrhunt@google.com>
References: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
 <6d54bc264e2f9ce519f32c0673167a00bab55573.1631972978.git.gitgitgadget@gmail.com>
 <YUZG0D5ayEWd7MLP@carlos-mbp.lan>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <fd65fe57-819e-88d5-8ba1-99bb59a980bb@ahunt.org>
Date:   Sun, 19 Sep 2021 17:51:38 +0200
MIME-Version: 1.0
In-Reply-To: <YUZG0D5ayEWd7MLP@carlos-mbp.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 18/09/2021 22:06, Carlo Marcelo Arenas Belón wrote:
> My equivalent version for these fixes is obviously more verbose but IMHO
> not that ugly (and as safe)
> 
> It avoids the need to UNLEAK early by changing the program flow also for
> the early return so the cleanup could be centralized in one single
> function.
> 
> Both, the cmdline and mailmap arrays (and the objects they accumulate)
> are cleaned in a "reusable" way.
> 
> Note that the cleaning of the "name" in the cmdline item throws a warning
> as shown below which I intentionally didn't fix, as it would seem that
> either the use of const there or the need to strdup is wrong.  So hope
> someone that knows this code better could chime in.
> 
> Carlo
> ------ >8 ------
> Subject: [PATCH] builtin/log: leaks from `git show` in t0000
> 
> obviously not ready, since the following will need to be corrected:
> 
>    revision.c:1496:8: warning: passing 'const char *' to parameter of type 'void *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
>                    free(info->rev[i].name);
>                         ^~~~~~~~~~~~~~~~~
> 

Casting the pointer a la "free((void *) ...)" seems to be a common 
pattern in git, and seems like a reasonable option here. AFAIUI the 
const is still needed because clients  of rev_cmdline_info shouldn't be 
changing name. But since we own and created rev_cmdline_info, we also 
know it's safe to clean it up. For comparison, here's an example of 
submodule_entry being cleaned up - all members end up needing a cast:

static void free_one_config(struct submodule_entry *entry)
{
	free((void *) entry->config->path);
	free((void *) entry->config->name);
	free((void *) entry->config->branch);
	free((void *) entry->config->update_strategy.command);
	free(entry->config);
}

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   builtin/log.c |  8 ++++++--
>   revision.c    | 20 ++++++++++++++++++++
>   revision.h    |  5 +++++
>   3 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index f75d87e8d7..1b1c1f53f4 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -645,8 +645,10 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>   	opt.tweak = show_setup_revisions_tweak;
>   	cmd_log_init(argc, argv, prefix, &rev, &opt);
>   
> -	if (!rev.no_walk)
> -		return cmd_log_walk(&rev);
> +	if (!rev.no_walk) {
> +		ret = cmd_log_walk(&rev);
> +		goto done;
> +	}
>   
>   	count = rev.pending.nr;
>   	objects = rev.pending.objects;
> @@ -702,6 +704,8 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>   		}
>   	}
>   	free(objects);
> +done:
> +	repo_clear_revisions(&rev);
>   	return ret;
>   }
>   
> diff --git a/revision.c b/revision.c
> index 0dabb5a0bc..ce62192dd8 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1487,6 +1487,18 @@ static void add_rev_cmdline(struct rev_info *revs,
>   	info->nr++;
>   }
>   
> +static void clear_rev_cmdline(struct rev_info *revs)
> +{
> +	struct rev_cmdline_info *info = &revs->cmdline;
> +	size_t i, nr = info->nr;
> +
> +	for (i = 0; i < nr; i++)
> +		free(info->rev[i].name);
> +
> +	FREE_AND_NULL(info->rev);
> +	info->nr = info->alloc = 0;
> +}
> +
>   static void add_rev_cmdline_list(struct rev_info *revs,
>   				 struct commit_list *commit_list,
>   				 int whence,
> @@ -1845,6 +1857,14 @@ void repo_init_revisions(struct repository *r,
>   	init_display_notes(&revs->notes_opt);
>   }
>   
> +void repo_clear_revisions(struct rev_info *revs)
> +{
> +	if (revs->mailmap)
> +		clear_mailmap(revs->mailmap);
> +	FREE_AND_NULL(revs->mailmap);
> +	clear_rev_cmdline(revs);
> +}
> +
>   static void add_pending_commit_list(struct rev_info *revs,
>   				    struct commit_list *commit_list,
>   				    unsigned int flags)
> diff --git a/revision.h b/revision.h
> index 0c65a760ee..f695c41cee 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -358,6 +358,11 @@ void repo_init_revisions(struct repository *r,
>   			 struct rev_info *revs,
>   			 const char *prefix);
>   
> +/*
> + * Free all structures dynamically allocated for the provided rev_info
> + */
> +void repo_clear_revisions(struct rev_info *revs);
> +
>   /**
>    * Parse revision information, filling in the `rev_info` structure, and
>    * removing the used arguments from the argument list. Returns the number
> 

This patch looks good to me (modulo adding the cast as discussed above), 
and is obviously much better than my approach of using an UNLEAK!

ATB,

Andrzej
