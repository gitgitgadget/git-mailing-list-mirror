Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A0FC433FE
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241785AbiDAP4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350694AbiDAPoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 11:44:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52082B9A30
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 08:17:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r64so1877901wmr.4
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ti7AzetlB2Ut9M90TQPERLSNfAJzMt1qplII4Sk6szM=;
        b=gCEjSfEVFoVRtCogS3lDESe1U0E+N61nzYb4MCGL+HzgkayIvMLEVBviP+u8Cl7Fzw
         EzwSu6nA0gO0oT7QohTEZ8oiffvxrBXHqvwwBlh8K71YwoNmXWEEvFSxOjiaFayrnTfV
         0EthL6vMDPHjbVS3b5/Y6exHbRp6bypz07BCpLHpbg3XEBz443towWeOrxUsNNSTcTXt
         6N2FRgS3tYjr7e1gGxoe/xHBH73El9cDwr9ySx1UnsEHYOBEf7Tmsao2f+1wKUD0xzZ2
         65vkvQxozm5yZ3pqPtk6O8QYlLSF5wOZrvw0TT4mNvAbQB9zLLslf7wM7/R/6CEXf4es
         SxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ti7AzetlB2Ut9M90TQPERLSNfAJzMt1qplII4Sk6szM=;
        b=c0si5HNJVSj8erHhBHpZ1U8sgi8blcxRrDuPlrDGU9ddJB2Dh5wDwtEMS0Rw98inrf
         eKiS8FNRGPWC7KS3YdAQy+yBl22UIseUAb9RCOud3ek36WTj5bTwVy1JVAR9MMzqvDCw
         Lw3nfq7WlUnHKNX3gmi8p5EULwsHYtEe3RZ5+kLQzkkGRukfPAO5oQzV/pvAwBYU09EQ
         YJ9HkwXrxrherOQ4Pk9QYbaDZvz6NxvpDXDr0RT7ckzgzOF7SWDr7FximfQvWvU43cof
         3iEtcrzjFgTCu9J9PqzNP32/xGuDuaA0QJdy/BK02AulXYnTklwkdU1ssqp5bC++23G2
         dpjw==
X-Gm-Message-State: AOAM530OrdFCXWdaRqxSD7ZCNg14bES3VhMkabadCQ2yRLUYosAfLd+e
        pDdu+8BgRkP4zcQ6CePWBmg=
X-Google-Smtp-Source: ABdhPJzACW8sF+lm3L1s5CuBBVzkfDJt66kBxrAnXDYarMo/Trg0MhHhIfCuWjBvfxfvZ7CmmkXzNA==
X-Received: by 2002:a05:600c:3b86:b0:38c:afdf:66cd with SMTP id n6-20020a05600c3b8600b0038cafdf66cdmr9141829wms.198.1648826245465;
        Fri, 01 Apr 2022 08:17:25 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b0038d0d8f67e5sm10271719wms.16.2022.04.01.08.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 08:17:25 -0700 (PDT)
Message-ID: <fb26835b-c2fe-be3c-a7c4-6ea8b5748969@gmail.com>
Date:   Fri, 1 Apr 2022 16:17:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 06/27] revision.[ch]: provide and start using a
 release_revisions()
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <patch-v4-06.27-b9beaba16bf-20220331T005325Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v4-06.27-b9beaba16bf-20220331T005325Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 31/03/2022 02:11, Ævar Arnfjörð Bjarmason wrote:
> The users of the revision.[ch] API's "struct rev_info" are a major
> source of memory leaks in the test suite under SANITIZE=leak, which in
> turn adds a lot of noise when trying to mark up tests with
> "TEST_PASSES_SANITIZE_LEAK=true".
> 
> The users of that API are largely one-shot, e.g. "git log", so
> arguably freeing the memory is a waste of time, but in many cases
> they've actually been trying to free the memory, and just doing that
> in a buggy manner.

I've not looked that closely at these changes but builtin/log.c is not 
modified so I'm a bit confused by the mention of "git log" above.

Best Wishes

Phillip

> Let's provide a release_revisions() function for these users, and
> start migrating them over per the plan outlined in [1]. Right now this
> only handles the "pending" member of the struct, but more will be
> added in subsequent commits.
> 
> Even though we only clear the "pending" member now, let's not leave a
> trap in code like the pre-image of index_differs_from(), where we'd
> start doing the wrong thing as soon as the release_revisions() learned
> to clear its "diffopt". I.e. we need to call release_revisions() after
> we've inspected any state in "struct rev_info".
> 
> This leaves in place e.g. clear_pathspec(&rev.prune_data) in
> stash_working_tree() in builtin/stash.c, subsequent commits will teach
> release_revisions() to free "prune_data" and other members that in
> some cases are individually cleared by users of "struct rev_info" by
> reaching into its members. Those subsequent commits will remove the
> relevant calls to e.g. clear_pathspec().
> 
> We avoid amending code in index_differs_from() in diff-lib.c as well
> as wt_status_collect_changes_index(), has_unstaged_changes() and
> has_uncommitted_changes() in wt-status.c in a way that assumes that we
> are already clearing the "diffopt" member. That will be handled in a
> subsequent commit.
> 
> 1. https://lore.kernel.org/git/87a6k8daeu.fsf@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/checkout.c | 2 +-
>   builtin/stash.c    | 3 +--
>   diff-lib.c         | 2 +-
>   range-diff.c       | 2 +-
>   revision.c         | 5 +++++
>   revision.h         | 6 ++++++
>   wt-status.c        | 5 +++--
>   7 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 797681481d1..4d9e0bd3ac1 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -629,7 +629,7 @@ static void show_local_changes(struct object *head,
>   	diff_setup_done(&rev.diffopt);
>   	add_pending_object(&rev, head, NULL);
>   	run_diff_index(&rev, 0);
> -	object_array_clear(&rev.pending);
> +	release_revisions(&rev);
>   }
>   
>   static void describe_detached_head(const char *msg, struct commit *commit)
> diff --git a/builtin/stash.c b/builtin/stash.c
> index ccdfdab44be..ad74624c2f7 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1266,9 +1266,8 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
>   
>   done:
>   	discard_index(&istate);
> -	UNLEAK(rev);
> -	object_array_clear(&rev.pending);
>   	clear_pathspec(&rev.prune_data);
> +	release_revisions(&rev);
>   	strbuf_release(&diff_output);
>   	remove_path(stash_index_path.buf);
>   	return ret;
> diff --git a/diff-lib.c b/diff-lib.c
> index ca085a03efc..d6800274bd5 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -662,7 +662,7 @@ int index_differs_from(struct repository *r,
>   		diff_flags_or(&rev.diffopt.flags, flags);
>   	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
>   	run_diff_index(&rev, 1);
> -	object_array_clear(&rev.pending);
> +	release_revisions(&rev);
>   	return (rev.diffopt.flags.has_changes != 0);
>   }
>   
> diff --git a/range-diff.c b/range-diff.c
> index b72eb9fdbee..39cc010c628 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -596,6 +596,6 @@ int is_range_diff_range(const char *arg)
>   	}
>   
>   	free(copy);
> -	object_array_clear(&revs.pending);
> +	release_revisions(&revs);
>   	return negative > 0 && positive > 0;
>   }
> diff --git a/revision.c b/revision.c
> index 29f102cb83d..9a3c05b69a5 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2931,6 +2931,11 @@ static void release_revisions_commit_list(struct rev_info *revs)
>   	}
>   }
>   
> +void release_revisions(struct rev_info *revs)
> +{
> +	object_array_clear(&revs->pending);
> +}
> +
>   static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
>   {
>   	struct commit_list *l = xcalloc(1, sizeof(*l));
> diff --git a/revision.h b/revision.h
> index 5bc59c7bfe1..61c780fc4cd 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -377,6 +377,12 @@ void repo_init_revisions(struct repository *r,
>   int setup_revisions(int argc, const char **argv, struct rev_info *revs,
>   		    struct setup_revision_opt *);
>   
> +/**
> + * Free data allocated in a "struct rev_info" after it's been
> + * initialized with repo_init_revisions().
> + */
> +void release_revisions(struct rev_info *revs);
> +
>   void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
>   			const struct option *options,
>   			const char * const usagestr[]);
> diff --git a/wt-status.c b/wt-status.c
> index d33f9272b72..922cf787f95 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -662,7 +662,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>   
>   	copy_pathspec(&rev.prune_data, &s->pathspec);
>   	run_diff_index(&rev, 1);
> -	object_array_clear(&rev.pending);
> +	release_revisions(&rev);
>   	clear_pathspec(&rev.prune_data);
>   }
>   
> @@ -2545,6 +2545,7 @@ int has_unstaged_changes(struct repository *r, int ignore_submodules)
>   	rev_info.diffopt.flags.quick = 1;
>   	diff_setup_done(&rev_info.diffopt);
>   	result = run_diff_files(&rev_info, 0);
> +	release_revisions(&rev_info);
>   	return diff_result_code(&rev_info.diffopt, result);
>   }
>   
> @@ -2577,7 +2578,7 @@ int has_uncommitted_changes(struct repository *r,
>   
>   	diff_setup_done(&rev_info.diffopt);
>   	result = run_diff_index(&rev_info, 1);
> -	object_array_clear(&rev_info.pending);
> +	release_revisions(&rev_info);
>   	return diff_result_code(&rev_info.diffopt, result);
>   }
>   
