Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 884E920248
	for <e@80x24.org>; Wed, 17 Apr 2019 19:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfDQT7O (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 15:59:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52675 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQT7O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 15:59:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so103636wma.2
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D22IepyNN0QeaSjSRfUxPw9lwE5antfgg1F38lJxvlI=;
        b=g/Nfr85eN6xnWMSjNwuiKSlfeeBobb0UqojPkxYovDy1U3b4ehUkLGB9Oz1/fQrj+t
         MEjOj5xvzBPB9K3/9XjIlhRKungg2R4yNYzoPX/RThORu0e/oLYTwaKGHt01oLLbAywV
         EPXtGtu9Vl5Fs7Lp+saY7vfc1E1brplFwupi+Z+9o3ggX0JQNpYyO+z7swQMFNpy+hxM
         HBUR49XR2yKTCca/V+j+CLcpNnH6o/J80vFjzrdrXHHFovCJqx80ry1ss0ZNi9xz6GqV
         9di/8bmpsOBwXmCtyEIbg9BALfFrl9tJjNIWhE+laREZ2/EaY6IfYNCLwKcz+6mRWCQ1
         mz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=D22IepyNN0QeaSjSRfUxPw9lwE5antfgg1F38lJxvlI=;
        b=dniukXFjBVMeEzZZVOPBXBb/jcYxmTWMHk23e+9Lsuy26oLTimutd4hPP5eBm9yWEr
         ZOhVhc6vM6QD2ngp1Qi22rjoSyVfYEFsEg9kpVG5NbldntZU2CwRWgKNgdg9GOWVPVqC
         uCLOh09OmZ/UwDT6r/qngQhEB8VdC9cgcIdSzfjQM58FSUL4ZZU62nfVeSLYuvqmRTuO
         CKsEvfRc0NlBAktHb/vLg7ms8R1SCH+G6fALOJc+1xnwDFmiHT3gJjsTtbNqEZHIAdZT
         XmO/2nN9f4961lkwdu+jISjOY9MEYuuUA2PCmATUWlRvZpmYbv6cAWHF3/KTKDj+TZqt
         DWJA==
X-Gm-Message-State: APjAAAUDUP8b/4klFKLAvy5sEs8jsjjTYtRckGDROQNRCCIoaX7MqxIh
        D2T1SX/KuAAhQUb4auryV8g=
X-Google-Smtp-Source: APXvYqwki0BUYvF0848eLebVgdOctIM39+3ywuntbhsxVzJ5Quqi4vpz2+LTe2ElQliAS6vnO7shnQ==
X-Received: by 2002:a1c:9ad6:: with SMTP id c205mr250630wme.46.1555531151477;
        Wed, 17 Apr 2019 12:59:11 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id q3sm74210897wrr.75.2019.04.17.12.59.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 12:59:10 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 4/6] rebase: fast-forward --onto in more cases
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <cover.1554500051.git.liu.denton@gmail.com>
 <cover.1555523176.git.liu.denton@gmail.com>
 <2559ab54a2c6e5544595e0d66a431e249bf73ca8.1555523176.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <da5b0efb-1245-7f34-be4e-4e936e9d1d20@gmail.com>
Date:   Wed, 17 Apr 2019 20:59:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2559ab54a2c6e5544595e0d66a431e249bf73ca8.1555523176.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 17/04/2019 19:01, Denton Liu wrote:
> Before, when we had the following graph,
> 
> 	A---B---C (master)
> 	     \
> 	      D (side)
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
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   builtin/rebase.c               | 28 +++++++++++++++++++---------
>   t/t3400-rebase.sh              |  2 +-
>   t/t3404-rebase-interactive.sh  |  2 +-
>   t/t3432-rebase-fast-forward.sh |  4 ++--
>   4 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index de10b6f5ad..f5aca1eee0 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -895,8 +895,8 @@ static int is_linear_history(struct commit *from, struct commit *to)
>   	return 1;
>   }
>   
> -static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
> -			    struct object_id *merge_base)
> +static int can_fast_forward(struct commit *onto, struct commit *upstream,
> +			    struct object_id *head_oid, struct object_id *merge_base)
>   {
>   	struct commit *head = lookup_commit(the_repository, head_oid);
>   	struct commit_list *merge_bases = NULL;
> @@ -915,6 +915,18 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
>   	if (!oideq(merge_base, &onto->object.oid))
>   		goto done;
>   
> +	if (!upstream)
> +		goto done;
> +
> +	free_commit_list(merge_bases);
> +	merge_bases = get_merge_bases(upstream, head);
> +	if (!merge_bases || merge_bases->next) {
> +		goto done;
> +	}

Thanks for changing the ifs in this patch and the previous one, I find 
it much easier to follow now. Just one style nit (probably not worth a 
reroll) - we don't put braces around a single conditional statement like 
this unless another branch of the same if requires them (then all 
branches should have them).

Best Wishes

Phillip


> +
> +	if (!oideq(&onto->object.oid, &merge_bases->item->object.oid))
> +		goto done;
> +
>   	res = 1;
>   
>   done:
> @@ -1688,13 +1700,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
> +	if (can_fast_forward(options.onto, options.upstream, &options.orig_head,
> +		    &merge_base) &&
> +	    !is_interactive(&options) && !options.restrict_revision) {
>   		int flag;
>   
>   		if (!(options.flags & REBASE_FORCE)) {
> @@ -1788,7 +1798,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
