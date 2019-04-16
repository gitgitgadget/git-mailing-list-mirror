Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC88020248
	for <e@80x24.org>; Tue, 16 Apr 2019 13:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfDPN7S (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 09:59:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55171 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPN7R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 09:59:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so25496421wml.4
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dweSFlSqwnafgiL70xT8eLVaKvEZuAvy5SXM1gtUctc=;
        b=GeyMYxCT4ZLMM2CSVl6q0UUiMZqcJf4AlsneQxcpiQ+Kxo4z0BhcgAsyterChem+2Z
         NckevxOA7sktrEB/9DxJODlHJ9D5ynls2TyWbDhx01b96aRqCS+3i6FQ2tYJS6CQhygM
         NLOHIon2Gg1d6HIwDEnu143wA0h51PLvtu4NoFihPagpHMmGMbY4HjK+D0DiwtCKYSRg
         e0UFiDP+0KStbqvf1QIozYrwg0PF2hjUz+ZbK6NLbyXeV46eoziGzUq6R0xWgILYdRQP
         QxuA53+3HpntCtngZ1r/ottrAREs0lMvJd4OjFyQMbPqsPMVSC6Vn1lB0P37heDXFBgD
         FG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dweSFlSqwnafgiL70xT8eLVaKvEZuAvy5SXM1gtUctc=;
        b=mMH/g6qervcVfE2Q3zqVJzyb77o9yNl68nGkUPcvbAetyikACmfEBK3sCBHcZ/jq3v
         r0YhO+SH2BlAO449dQTqH3XdX+piaWyN6L1DXrk8z5AMX+2pvKbDqZhVci3qDkS4gI/W
         5FM10N2Y7j7Sp08y0xfJZT33Id0d3Vq3o2Hja4ACgy2YGlX6G5edjGmMf3dbNdE1L+hh
         LWZ3eSFdmdqlBRJ2LtPOA89/l5h9+4KofvH6dZZYumtG50uaNwAUOhJBi1hWDIJwsHkr
         hGeglqQWuVq07u9KDYKIKVi5pZ1yWrlolBXxhtK7i76wVRaRTPuuzMVvEx54/w8OjCq1
         T6rg==
X-Gm-Message-State: APjAAAXaNYSXvklXvpzDkfZIet95Pv5iEasWaGg4mvvd/DNYsIXNXGwT
        aHepoK9aN9YLIbO1y7TIWS0=
X-Google-Smtp-Source: APXvYqxZJigSN228gr6H/yAlauKuo+dxuTeXZ2nwizbHwd3AkHeTMhsk/L/yFlmgjgTnmgpZwqG33Q==
X-Received: by 2002:a1c:6587:: with SMTP id z129mr27235278wmb.84.1555423155267;
        Tue, 16 Apr 2019 06:59:15 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id y5sm42900622wrw.23.2019.04.16.06.59.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 06:59:14 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 3/5] rebase: fast-forward --onto in more cases
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <cover.1554500051.git.liu.denton@gmail.com>
 <cover.1555366891.git.liu.denton@gmail.com>
 <ec55da07191e7f0a1d31342053c1496405ba7d3a.1555366891.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <216aa032-d28e-79ba-6bc7-c4bd3de4321d@gmail.com>
Date:   Tue, 16 Apr 2019 14:59:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ec55da07191e7f0a1d31342053c1496405ba7d3a.1555366891.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

It's good to see rebase fast-forwarding properly when it should

On 15/04/2019 23:29, Denton Liu wrote:
> Before, when we had the following graph,
> 
> 	A---B---C (master)
> 	    \
> 	     D (side)
> 
> running 'git rebase --onto master... master side' would result in D
> being always rebased, no matter what. However, the desired behavior is
> that rebase should notice that this is fast-forwardable and do that
> instead.
> 
> Add detection to `can_fast_forward` so that this case can be detected
> and a fast-forward will be performed. First of all, rewrite the function
> to use gotos which simplifies the logic. Next, since the
> 
> 	options.upstream &&
> 	!oidcmp(&options.upstream->object.oid, &options.onto->object.oid)
> 
> conditions were removed in `cmd_rebase`, we reintroduce a substitute in
> `can_fast_forward`. In particular, checking the merge bases of
> `upstream` and `head` fixes a failing case in t3416.
> 
> The abbreviated graph for t3416 is as follows:
> 
> 		    F---G topic
> 		   /
> 	  A---B---C---D---E master
> 
> and the failing command was
> 
> 	git rebase --onto master...topic F topic
> 
> Before, Git would see that there was one merge base (C), and the merge
> and onto were the same so it would incorrectly return 1, indicating that
> we could fast-forward. This would cause the rebased graph to be 'ABCFG'
> when we were expecting 'ABCG'.
> 
> With the additional logic, we detect that upstream and head's merge base
> is F. Since onto isn't F, it means we're not rebasing the full set of
> commits from master..topic. Since we're excluding some commits, a
> fast-forward cannot be performed and so we correctly return 0.
> 
> Add '-f' to test cases that failed as a result of this change because
> they were not expecting a fast-forward so that a rebase is forced.
> 
> While we're at it, remove a trailing whitespace from rebase.c.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   builtin/rebase.c               | 40 +++++++++++++++++++++++-----------
>   t/t3400-rebase.sh              |  2 +-
>   t/t3404-rebase-interactive.sh  |  2 +-
>   t/t3432-rebase-fast-forward.sh |  4 ++--
>   4 files changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 77deebc65c..7aa6a090d4 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -895,12 +895,12 @@ static int is_linear_history(struct commit *from, struct commit *to)
>   	return 1;
>   }
>   
> -static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
> -			    struct object_id *merge_base)
> +static int can_fast_forward(struct commit *onto, struct commit *upstream,
> +			    struct object_id *head_oid, struct object_id *merge_base)
>   {
>   	struct commit *head = lookup_commit(the_repository, head_oid);
> -	struct commit_list *merge_bases;
> -	int res;
> +	struct commit_list *merge_bases = NULL;
> +	int res = 0;
>   
>   	if (!head)
>   		return 0;
> @@ -908,12 +908,29 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
>   	merge_bases = get_merge_bases(onto, head);
>   	if (merge_bases && !merge_bases->next) {
>   		oidcpy(merge_base, &merge_bases->item->object.oid);
> -		res = oideq(merge_base, &onto->object.oid);
> +		if (!oideq(merge_base, &onto->object.oid))
> +			goto done;
>   	} else {
>   		oidcpy(merge_base, &null_oid);
> -		res = 0;
> +		goto done;
>   	}
> +
> +	if (!upstream)
> +		goto done;
> +
>   	free_commit_list(merge_bases);
> +	merge_bases = get_merge_bases(upstream, head);
> +	if (merge_bases && !merge_bases->next) {
> +		if (!oideq(&onto->object.oid, &merge_bases->item->object.oid))
> +			goto done;
> +	} else
> +		goto done;
> +
> +	res = 1;
> +
> +done:
> +	if (merge_bases)
> +		free_commit_list(merge_bases);
>   	return res && is_linear_history(onto, head);
>   }
>   

I had a hard time following all those gotos. When you 'goto done' in 
both branches of an if statement it is hard to work out which cases fall 
through to the rest of the code. If I've understood it correctly I think 
it is clearer as

         merge_bases = get_merge_bases(onto, head);
         if (merge_bases && !merge_bases->next) {
                 oidcpy(merge_base, &merge_bases->item->object.oid);
                 if (oideq(merge_base, &onto->object.oid) && upstream) {
                         free_commit_list(merge_bases);
                         merge_bases = get_merge_bases(upstream, head);
                         if (merge_bases && !merge_bases->next)
                                 if (oideq(&onto->object.oid,
                                            &merge_bases->item->object.oid))
                                         res = 1;
                 }
         } else {
                 oidcpy(merge_base, &null_oid);
         }

         if (merge_bases)
                 free_commit_list(merge_bases);
         return res && is_linear_history(onto, head);
}

The nested if's aren't great but I think it is easier to follow

> @@ -1682,13 +1699,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   
>   	/*
>   	 * Check if we are already based on onto with linear history,
> -	 * but this should be done only when upstream and onto are the same
> -	 * and if this is not an interactive rebase.
> +	 * but this should be done if this is not an interactive rebase.
>   	 */
> -	if (can_fast_forward(options.onto, &options.orig_head, &merge_base) &&
> -	    !is_interactive(&options) && !options.restrict_revision &&
> -	    options.upstream &&
> -	    !oidcmp(&options.upstream->object.oid, &options.onto->object.oid)) {
> +	if (can_fast_forward(options.onto, options.upstream, &options.orig_head, &merge_base) &&

This is rather long, perhaps break the argument list

Best Wishes

Phillip
> +	    !is_interactive(&options) && !options.restrict_revision) {
>   		int flag;
>   
>   		if (!(options.flags & REBASE_FORCE)) {
> @@ -1782,7 +1796,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	strbuf_addf(&msg, "%s: checkout %s",
>   		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
>   	if (reset_head(&options.onto->object.oid, "checkout", NULL,
> -		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
> +		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
>   		       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
>   		       NULL, msg.buf))
>   		die(_("Could not detach HEAD"));
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 460d0523be..604d624ff8 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -295,7 +295,7 @@ test_expect_success 'rebase--am.sh and --show-current-patch' '
>   		echo two >>init.t &&
>   		git commit -a -m two &&
>   		git tag two &&
> -		test_must_fail git rebase --onto init HEAD^ &&
> +		test_must_fail git rebase -f --onto init HEAD^ &&
>   		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
>   		grep "show.*$(git rev-parse two)" stderr
>   	)
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index b60b11f9f2..f054186cc7 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1066,7 +1066,7 @@ test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-int
>   	git reset --hard &&
>   	git checkout conflict-branch &&
>   	set_fake_editor &&
> -	test_must_fail git rebase --onto HEAD~2 HEAD~ &&
> +	test_must_fail git rebase -f --onto HEAD~2 HEAD~ &&
>   	test_must_fail git rebase --edit-todo &&
>   	git rebase --abort
>   '
> diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
> index 4f04d67fd7..d0e5b1f3e6 100755
> --- a/t/t3432-rebase-fast-forward.sh
> +++ b/t/t3432-rebase-fast-forward.sh
> @@ -64,9 +64,9 @@ test_expect_success 'add work to upstream' '
>   changes='our and their changes'
>   test_rebase_same_head success --onto B B
>   test_rebase_same_head success --onto B... B
> -test_rebase_same_head failure --onto master... master
> +test_rebase_same_head success --onto master... master
>   test_rebase_same_head failure --fork-point --onto B B
>   test_rebase_same_head failure --fork-point --onto B... B
> -test_rebase_same_head failure --fork-point --onto master... master
> +test_rebase_same_head success --fork-point --onto master... master
>   
>   test_done
> 
