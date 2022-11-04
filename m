Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19FDC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 20:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiKDUMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 16:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiKDUM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 16:12:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5F72CCAA
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 13:12:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g12so8475397wrs.10
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hDAd8KClQUywP0i+148c/6fhsLxi7S7Yymbum5YKSk=;
        b=ZMP6YnhAvvTHnv+Z8y2OyabHsA1Doz1cvuDQq8KF2G0rS2IZw6ru64ahNKt7ic7LX+
         XAsryvHScI2TcCTUq6/FBz/gQLgMktGQ0DA9OxVpHtCNBEqc9XUOg7koVuaNI3x06KgQ
         AigD/bVz6Jt8DVZI9sBuudhU3cgeAQqcUpTOPjuEMJrQiEFN5iasScbAhyTWzPLCnGZw
         4F2+MTn9KuQUi/mZGUrjaPSqnqyhfAdZ7sAsOTJS1Ef2uiH2EtYV5xxn1ZMX1ARqZ5Rv
         apW2ZIoXTi0j8OfiIvsWHw+RNxcr2TBU9u7TZ7e8/p1+G3YFKFWfNywjdl1EE4N6+oqn
         SYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hDAd8KClQUywP0i+148c/6fhsLxi7S7Yymbum5YKSk=;
        b=Rj2y3a2vlWvgwWZvXkhuK/NgTXQyo6OCARLCq98aWqkyT8FhOuHRbq4zYu3IRv493L
         v6l4t6Ber8VYtgNj9Z9XFpv3vmVdVfCi7TtpCK+n0sxb1aG2KJ3qt7EDgQmg04kWM2+u
         nkSpZRAn4ojdEBBgP0J26905hJ/PNbKlvFibzRWWR0r+zngd6SSqm0uWJlGEQcy5n2Ep
         ei3sZRs5enIZgnx21sMw1LY9HD9Lrcz90zjuH18s1cjWjxKQwcDJRA/6/mQpdLK3aJRY
         sOBCKn4Jc2VZSZXBuh/OPZ2jqsHEOQwcpW3XrbgB52DkLLueEyKEWBWNZsQebL7AIfVH
         CMPg==
X-Gm-Message-State: ACrzQf2c1fgkJanKxOvS7OObtIRicQ/mOhK5uVjiHkx/rU/B0R2GQEjr
        8Qq8J/5Hp4kuQUNKqZqGxKc=
X-Google-Smtp-Source: AMsMyM6IqxAMsEsyAd3ohmqnh8RXVKC6bRfBr8bSfbkMSTGTyMFX9B+xq6cuz4Ea/iF2QbvQ/FS1rQ==
X-Received: by 2002:a5d:4a0c:0:b0:236:5d98:1be4 with SMTP id m12-20020a5d4a0c000000b002365d981be4mr23716182wrq.590.1667592746125;
        Fri, 04 Nov 2022 13:12:26 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id x15-20020a1c7c0f000000b003cf537ec2efsm282329wmc.36.2022.11.04.13.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 13:12:25 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <6c022318-afc0-2ad7-b29c-ccb87f2f2e94@dunelm.org.uk>
Date:   Fri, 4 Nov 2022 20:12:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase --update-refs: avoid unintended ref deletion
To:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        "herr . kaste" <herr.kaste@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
References: <bf5bc739-cb88-61ff-ed6b-09b1316f2f35@github.com>
 <20221104165735.68899-1-vdye@github.com>
Content-Language: en-US
In-Reply-To: <20221104165735.68899-1-vdye@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

On 04/11/2022 16:57, Victoria Dye wrote:
> In b3b1a21d1a5 (sequencer: rewrite update-refs as user edits todo list,
> 2022-07-19), the 'todo_list_filter_update_refs()' step was added to handle
> the removal of 'update-ref' lines from a 'rebase-todo'. Specifically, it
> removes potential ref updates from the "update refs state" if a ref does not
> have a corresponding 'update-ref' line.
> 
> However, because 'write_update_refs_state()' will not update the state if
> the 'refs_to_oids' list was empty, removing *all* 'update-ref' lines will
> result in the state remaining unchanged from how it was initialized (with
> all refs' "after" OID being null). Then, when the ref update is applied, all
> refs will be updated to null and consequently deleted.

Thanks for taking the time to track down the cause of this bug and fix it.

> To fix this, add a 'force_if_empty' flag to allow writing the update refs
> state even if 'refs_to_oids' is empty. The three usages of
> 'write_update_refs_state()' are updated as follows:
> 
> - in 'todo_list_filter_update_refs()': force_if_empty is 1 because update
>    ref entries are removed here. This setting fixes the ref deletion issue.
> - in 'do_update_ref()': force_if_empty is 0, since this method only modifies
>    (does not add or delete) ref update entries.
> - in 'todo_list_add_update_ref_commands()': force_if_empty is 0, since this
>    method strictly adds ref update entries.

I think not writing the list if it is empty is just an optimization to 
avoid creating an empty file. I wonder if it would be simpler to 
unlink() any existing file if write_update_refs_state() is called with 
an empty list rather than adding the force flag.

> Additionally, add a test covering the "all update-ref lines removed" case.

That's great

Best Wishes

Phillip

> Reported-by: herr.kaste <herr.kaste@gmail.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
> This fixes the issue reported in [1]. I initially misinterpreted the root
> cause (thought that 'todo_list_filter_update_refs()' was only applied in the
> case of '--edit-todo'). After looking into it a bit more, it appears that
> the actual failure case is much narrower, occurring only when *all*
> 'update-ref' lines were deleted from the 'rebase-todo'.
> 
> Thanks!
> - Victoria
> 
> [1] https://lore.kernel.org/git/CAFzd1+5F4zqQ1CNeY2xaaf0r__JmE4ECiBt5h5OdiJHbaE78VA@mail.gmail.com/
> 
>   sequencer.c                   | 15 ++++++++++-----
>   t/t3404-rebase-interactive.sh | 24 ++++++++++++++++++++++++
>   2 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index e658df7e8ff..4d99a4fd6ca 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4122,7 +4122,7 @@ static int do_merge(struct repository *r,
>   	return ret;
>   }
> 
> -static int write_update_refs_state(struct string_list *refs_to_oids)
> +static int write_update_refs_state(struct string_list *refs_to_oids, int force_if_empty)
>   {
>   	int result = 0;
>   	struct lock_file lock = LOCK_INIT;
> @@ -4130,7 +4130,12 @@ static int write_update_refs_state(struct string_list *refs_to_oids)
>   	struct string_list_item *item;
>   	char *path;
> 
> -	if (!refs_to_oids->nr)
> +	/*
> +	 * If 'force' is specified, we want to write the updated refs even if
> +	 * the list is empty. This is only needed for callers that may have
> +	 * deleted items from 'refs_to_oids'.
> +	 */
> +	if (!refs_to_oids->nr && !force_if_empty)
>   		return 0;
> 
>   	path = rebase_path_update_refs(the_repository->gitdir);
> @@ -4260,7 +4265,7 @@ void todo_list_filter_update_refs(struct repository *r,
>   	}
> 
>   	if (updated)
> -		write_update_refs_state(&update_refs);
> +		write_update_refs_state(&update_refs, 1);
>   	string_list_clear(&update_refs, 1);
>   }
> 
> @@ -4281,7 +4286,7 @@ static int do_update_ref(struct repository *r, const char *refname)
>   		}
>   	}
> 
> -	write_update_refs_state(&list);
> +	write_update_refs_state(&list, 0);
>   	string_list_clear(&list, 1);
>   	return 0;
>   }
> @@ -6015,7 +6020,7 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
>   		}
>   	}
> 
> -	res = write_update_refs_state(&ctx.refs_to_oids);
> +	res = write_update_refs_state(&ctx.refs_to_oids, 0);
> 
>   	string_list_clear(&ctx.refs_to_oids, 1);
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 4f5abb5ad25..e7d3721ece8 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1964,6 +1964,30 @@ test_expect_success 'respect user edits to update-ref steps' '
>   	test_cmp_rev HEAD refs/heads/no-conflict-branch
>   '
> 
> +test_expect_success '--update-refs: do not delete refs if all update-ref are removed' '
> +	git checkout -b test-refs-not-removed no-conflict-branch &&
> +	git branch -f base HEAD~4 &&
> +	git branch -f first HEAD~3 &&
> +	git branch -f second HEAD~3 &&
> +	git branch -f third HEAD~1 &&
> +	git branch -f tip &&
> +	(
> +		set_cat_todo_editor &&
> +		test_must_fail git rebase -i --update-refs base >todo.raw &&
> +		sed -e "/^update-ref/d" <todo.raw >todo
> +	) &&
> +	(
> +		set_replace_editor todo &&
> +		git rebase -i --update-refs base
> +	) &&
> +
> +	test_cmp_rev HEAD~3 refs/heads/first &&
> +	test_cmp_rev HEAD~3 refs/heads/second &&
> +	test_cmp_rev HEAD~1 refs/heads/third &&
> +	test_cmp_rev HEAD refs/heads/tip &&
> +	test_cmp_rev HEAD refs/heads/no-conflict-branch
> +'
> +
>   test_expect_success '--update-refs: check failed ref update' '
>   	git checkout -B update-refs-error no-conflict-branch &&
>   	git branch -f base HEAD~4 &&
> --
> 2.38.0
> 
