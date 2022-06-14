Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DA1C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 10:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbiFNKJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 06:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbiFNKJU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 06:09:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016D230573
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 03:09:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k19so10543229wrd.8
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 03:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DZL87WmC1orsNXxGQoblbbDnqbll/a5VycUR4h3uZAY=;
        b=aEOW05zKMfEbSY7GSt6aXGvPdY7kAHVg4zARBhrznN46qhO7SijHA4RopQa4v10yvF
         w71otEH5GPQgOpxzRaKSDYCoPxcaNDNihKQmHW9erLeCKlb1Rb6L+DZDMnxkOCoJ8W7c
         s8ddu/15v/mGv++E6PSYMRtHIGqeniRuH/9rIKX9CtNDojpsv2TfopGSRNQg8gCMy5yO
         epstogA1/Kb4FWxup0A+OzckuVQvIJNO6roma27pCYKVbSewFxMXzk/jiXO0iRLxX3ET
         VOSu7gdC+dMizL2RRjrxovyg/HjB1mZ9PqRmghh1FF49EXTwEVXgfDfkxk4LVZGKhkSm
         wuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DZL87WmC1orsNXxGQoblbbDnqbll/a5VycUR4h3uZAY=;
        b=myfzYlmYsfmLNEiu/CeZhe9Na3v0HaoHopet5wxA22EQO1OdkyU+LM5K/xqKFXnR5W
         or026DUS4VkqnsedlOFwH70KimmkoZS/pp1rfkvEJwS1sOt+a3IzHk4FKMd3FoA7Jx2Z
         Su7jEOWDBC56KCCZ8M/3o86EsJH+z4mW3wcoi0maFWI1dY1TBLSw3eUVsVcng3FRYtnJ
         xZWhPinXkLWJJBwg3liVDUWFhX1V2qAMx+9YDOiZEA7KbgfzEjBNbduOwrx1TC/q78aO
         VQy88Qv+cq3cv1ISSo9GpXfMnoOeNn4S0I0Txb83hBrlsVjBlrigVfVqajevQN0Brmf/
         iVwQ==
X-Gm-Message-State: AJIora+BwnRrqjlrDUI1nw3eH20+zmf6TRWYo4puwJldGdsgXhsLFK/V
        CwAdK4oOpp0h4Uei9PdwP50=
X-Google-Smtp-Source: AGRyM1sZ/AZj3JCyiZ9cewO8bHxowXKyjWTRoeUwDy+bH3XM3RSLdyP29Oimz57sOZWL14n1cEWN8A==
X-Received: by 2002:adf:e902:0:b0:213:a337:92ae with SMTP id f2-20020adfe902000000b00213a33792aemr4142723wrm.84.1655201357443;
        Tue, 14 Jun 2022 03:09:17 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id w5-20020a5d6805000000b002119c1a03e4sm11216132wru.31.2022.06.14.03.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 03:09:16 -0700 (PDT)
Message-ID: <42ada1a3-adc2-2c43-9aa1-7854858865ae@gmail.com>
Date:   Tue, 14 Jun 2022 11:09:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] branch: add branch_checked_out() helper
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
 <dbb7eae390c90d4b710f48d8875bd7db0409aea3.1654718942.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <dbb7eae390c90d4b710f48d8875bd7db0409aea3.1654718942.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 08/06/2022 21:08, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The validate_new_branchname() method contains a check to see if a branch
> is checked out in any non-bare worktree. This is intended to prevent a
> force push that will mess up an existing checkout. This helper is not
> suitable to performing just that check, because the method will die()
> when the branch is checked out instead of returning an error code.
> 
> Create a new branch_checked_out() helper that performs the most basic
> form of this check. To ensure we can call branch_checked_out() in a loop
> with good performance, do a single preparation step that iterates over
> all worktrees and stores their current HEAD branches in a strmap. The
> branch_checked_out() helper can then discover these branches using a
> hash lookup.
> 
> This helper is currently missing some key functionality. Namely: it
> doesn't look for active rebases or bisects which mean that the branch is
> "checked out" even though HEAD doesn't point to that ref. This
> functionality will be added in a coming change.
> 
> We could use branch_checked_out() in validate_new_branchname(), but this
> missing functionality would be a regression. However, we have no tests
> that cover this case!
> 
> Add a new test script that will be expanded with these cross-worktree
> ref updates. The current tests would still pass if we refactored
> validate_new_branchname() to use this version of branch_checked_out().
> The next change will fix that functionality and add the proper test
> coverage.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>   branch.c                  | 42 +++++++++++++++++++++++++++++++++++++++
>   branch.h                  |  8 ++++++++
>   t/t2407-worktree-heads.sh | 24 ++++++++++++++++++++++
>   3 files changed, 74 insertions(+)
>   create mode 100755 t/t2407-worktree-heads.sh
> 
> diff --git a/branch.c b/branch.c
> index 2d6569b0c62..061a11f3415 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -10,6 +10,7 @@
>   #include "worktree.h"
>   #include "submodule-config.h"
>   #include "run-command.h"
> +#include "strmap.h"
>   
>   struct tracking {
>   	struct refspec_item spec;
> @@ -369,6 +370,47 @@ int validate_branchname(const char *name, struct strbuf *ref)
>   	return ref_exists(ref->buf);
>   }
>   
> +static int initialized_checked_out_branches;
> +static struct strmap current_checked_out_branches = STRMAP_INIT;

I looks like this map is never freed which I think makes sense but makes 
me wonder about the relevance of patch 5. I think it would probably be 
worth marking the map with UNLEAK() in prepare_checked_out_branches().

> +static void prepare_checked_out_branches(void)
> +{
> +	int i = 0;
> +	struct worktree **worktrees;
> +
> +	if (initialized_checked_out_branches)
> +		return;
> +	initialized_checked_out_branches = 1;
> +
> +	worktrees = get_worktrees();
> +
> +	while (worktrees[i]) {
> +		struct worktree *wt = worktrees[i++];
> +
> +		if (wt->is_bare)
> +			continue;
> +
> +		if (wt->head_ref)
> +			strmap_put(&current_checked_out_branches,
> +				   wt->head_ref,
> +				   xstrdup(wt->path));

STRMAP_INIT sets .strdup_strings = 1, so the xstrdup() is unnecessary.

> +	}
> +
> +	free_worktrees(worktrees);
> +}
> +
> +int branch_checked_out(const char *refname, char **path)
> +{
> +	const char *path_in_set;
> +	prepare_checked_out_branches();
> +
> +	path_in_set = strmap_get(&current_checked_out_branches, refname);
> +	if (path_in_set && path)
> +		*path = xstrdup(path_in_set);
> +
> +	return !!path_in_set;
> +}

I like the idea of having a specific function to see if a branch is 
checkout out rather than Ævar's suggestion of forcing all callers to do
     strmap_get(get_worktree_refs_strmap(), ref)
which will quickly get tiresome. I do wonder though if we'd be better 
off with a thin wrapper around strmap_get() such as

const char* branch_checked_out(const char *refname)
{
	prepare_checked_out_branches();
	return strmap_get(&current_checked_out_branches, refname);
}

so that the user can choose whether to copy the path or not.

Best Wishes

Phillip

>   /*
>    * Check if a branch 'name' can be created as a new branch; die otherwise.
>    * 'force' can be used when it is OK for the named branch already exists.
> diff --git a/branch.h b/branch.h
> index 560b6b96a8f..5ea93d217b1 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -101,6 +101,14 @@ void create_branches_recursively(struct repository *r, const char *name,
>   				 const char *tracking_name, int force,
>   				 int reflog, int quiet, enum branch_track track,
>   				 int dry_run);
> +
> +/*
> + * Returns true if the branch at 'refname' is checked out at any
> + * non-bare worktree. The path of the worktree is stored in the
> + * given 'path', if provided.
> + */
> +int branch_checked_out(const char *refname, char **path);
> +
>   /*
>    * Check if 'name' can be a valid name for a branch; die otherwise.
>    * Return 1 if the named branch already exists; return 0 otherwise.
> diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
> new file mode 100755
> index 00000000000..dd905dc1a5c
> --- /dev/null
> +++ b/t/t2407-worktree-heads.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +
> +test_description='test operations trying to overwrite refs at worktree HEAD'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	for i in 1 2 3 4
> +	do
> +		test_commit $i &&
> +		git branch wt-$i &&
> +		git worktree add wt-$i wt-$i || return 1
> +	done
> +'
> +
> +test_expect_success 'refuse to overwrite: checked out in worktree' '
> +	for i in 1 2 3 4
> +	do
> +		test_must_fail git branch -f wt-$i HEAD 2>err
> +		grep "cannot force update the branch" err || return 1
> +	done
> +'
> +
> +test_done

