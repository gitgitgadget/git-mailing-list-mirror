Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564A1C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 09:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiF3Jcc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 05:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiF3JcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 05:32:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B4842ED7
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 02:32:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id fd6so25711505edb.5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K5CI8XVSjdXwVp7ScQbWL71hWR6bP9ei+dIgf5SF1j4=;
        b=V8duiDj1HTwstH6mS7BGUqI/bx3M/uyU84J3blygeBYJprxNlqG4pNzPMg/V3nCEGz
         SfdYaCRAly9Gvkn3Wz8SZ0ZbEqNyxXcYgm8TOcq1ixfWP6cuvlajXlR78Ims3ovVMvHW
         twr0ZfSqLkQHUfPTIfmuslwuhpVUpEE1Nghsh090YSJR3XeWBg7o+q+1YtlKH4vFaLzk
         Y0yOUC4XDOE3xGT21ZWd8iTzq2ZH2kUfYz7dE0rmZn5Upxq96AS382xTh/z06IHxmXOm
         Ja88Y088+RPjss7ftU36BW9P2ueMZPrz+TQ4wcTcyK1z16nhsM9ctEj+iwVhNmNfAXbl
         24BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K5CI8XVSjdXwVp7ScQbWL71hWR6bP9ei+dIgf5SF1j4=;
        b=bD757y1R2NXxEAF/Pada+M0/jv46UhjE9H/ZS2achvPWSqlXj6uh1q1hwS44H493e3
         ygQjtwIGiR//GnWAwVK9BHhEYiHB/dJBFoVA4lEwjCWlZDGZKBnonGKiJuCKNGrMAqLX
         DgIqhJlQgSWx3yVQ5NE123BoEF7tU3wboSz2TOJXGs7oHS5J1wxJ8gIMcrIcVGJkxG3B
         c4W6XjTEuRcOl0dFLVV/hVHB72xy7vyw0PPN9kmEUCvk0B8FSVoQM2/NfuAiyJxFRfGW
         PwVyKHgHE+YiiGSeh3VXq7NRpiqtH2HODVrE6Kui/evxWRXPCbh2iBV/0zBjKRaNW1B4
         n8Aw==
X-Gm-Message-State: AJIora8BYJT2uS3pnMh7Qc9TMIZZvu6K5Q/7VXzHqpcB8Z8qbxApop6y
        xA/aZAXImknskzPwoX6/W1g=
X-Google-Smtp-Source: AGRyM1sx4Jt306am0ktkjzU4/D0GqyKf+5TWykz/Jwy6sp1TIXT4/nqzC7Wb/Kx4c74OutXGiWZKCQ==
X-Received: by 2002:a05:6402:1d53:b0:437:9737:24f3 with SMTP id dz19-20020a0564021d5300b00437973724f3mr9944694edb.397.1656581543268;
        Thu, 30 Jun 2022 02:32:23 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id da26-20020a056402177a00b004359a690905sm13032271edb.78.2022.06.30.02.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 02:32:22 -0700 (PDT)
Message-ID: <f27d563b-d011-9983-8f7d-52232b052608@gmail.com>
Date:   Thu, 30 Jun 2022 10:32:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/8] branch: consider refs under 'update-refs'
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <2bc647b6fcd6032a1e97e67739ced31117bfbfce.1656422759.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <2bc647b6fcd6032a1e97e67739ced31117bfbfce.1656422759.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/06/2022 14:25, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The branch_checked_out() helper helps commands like 'git branch' and
> 'git fetch' from overwriting refs that are currently checked out in
> other worktrees.
> 
> A future update to 'git rebase' will introduce a new '--update-refs'
> option which will update the local refs that point to commits that are
> being rebased. To avoid collisions as the rebase completes, we want to
> make the future data store for these refs to be considered by
> branch_checked_out().
> 
> The data store is a plaintext file inside the 'rebase-merge' directory
> for that worktree. The file alternates refnames and OIDs. The OIDs will
> be used to store the to-be-written values as the rebase progresses, but
> can be ignored at the moment.
> 
> Create a new sequencer_get_update_refs_state() method that parses this
> file and populates a struct string_list with the ref-OID pairs. We can
> then use this list to add to the current_checked_out_branches strmap
> used by branch_checked_out().
> 
> To properly navigate to the rebase directory for a given worktree,
> extract the static strbuf_worktree_gitdir() method to a public API
> method.
> 
> We can test that this works without having Git write this file by
> artificially creating one in our test script.

This looks good apart from a couple of small nits

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>   branch.c                  | 13 ++++++++++++
>   sequencer.c               | 42 +++++++++++++++++++++++++++++++++++++++
>   sequencer.h               |  9 +++++++++
>   t/t2407-worktree-heads.sh | 22 ++++++++++++++++----
>   4 files changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/branch.c b/branch.c
> index 526e8237673..f252c4eef6c 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -365,6 +365,7 @@ static void prepare_checked_out_branches(void)
>   		char *old;
>   		struct wt_status_state state = { 0 };
>   		struct worktree *wt = worktrees[i++];
> +		struct string_list update_refs = STRING_LIST_INIT_DUP;
>   
>   		if (wt->is_bare)
>   			continue;
> @@ -400,6 +401,18 @@ static void prepare_checked_out_branches(void)
>   			strbuf_release(&ref);
>   		}
>   		wt_status_state_free_buffers(&state);
> +
> +		if (!sequencer_get_update_refs_state(get_worktree_git_dir(wt),
> +						     &update_refs)) {
> +			struct string_list_item *item;
> +			for_each_string_list_item(item, &update_refs) {
> +				old = strmap_put(&current_checked_out_branches,
> +						 item->string,
> +						 xstrdup(wt->path));
> +				free(old);
> +			}
> +			string_list_clear(&update_refs, 1);
> +		}
>   	}
>   
>   	free_worktrees(worktrees);
> diff --git a/sequencer.c b/sequencer.c
> index 8c3ed3532ac..1094e146b99 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5901,3 +5901,45 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
>   
>   	return 0;
>   }
> +
> +int sequencer_get_update_refs_state(const char *wt_dir,
> +				    struct string_list *refs)
> +{
> +	int result = 0;
> +	struct stat st;
> +	FILE *fp = NULL;
> +	struct strbuf ref = STRBUF_INIT;
> +	struct strbuf hash = STRBUF_INIT;
> +	char *path = xstrfmt("%s/rebase-merge/update-refs", wt_dir);

I think it would make sense to introduce rebase_path_update_refs() in 
this patch rather than later in the series

> +
> +	if (stat(path, &st))
> +		goto cleanup;

What's the reason for stating the file first, rather than just letting 
fopen() fail if it does not exist?

Best Wishes

Phillip
