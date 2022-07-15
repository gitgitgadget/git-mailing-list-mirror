Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95FBC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 10:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiGOKM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 06:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiGOKM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 06:12:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A62220F0
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 03:12:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b6so2008723wmq.5
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AeYAcF8az/63KjLmtvoy3m7R+RKPApaQgYXwdtPDnsw=;
        b=klAM6zdwxK7bsyTxdmQEati5ZrHf+eaLy8qfQQ4jVsw2hR6v4UGlXV8Tg4/GFlAXPJ
         4vKhXT45hfgtivhDNM4ZqlIHTV6wGpEV+14WH2L7wdlojYR4IsG/q2mqGLM8Q9X7Zrzz
         Hu8ir3AKIi+ZGE8zudTKZ9hQdDdOHC07jYMCxVqfx4k9/mmCUfO+ZgJgBWOKKL2uXCXV
         DSoYt4V+bVobLrpDq+gITiCHCOS1FfSJiZFjSXYJ8ByCBN6j8J7nHF2Yq+TZBWfmamn2
         TzlYiin9HAtuJzJ1Zusi70X+BJura5+NJc7yArtF8MtsB+6GlUR2n24SugMnYMEnVyLL
         FKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AeYAcF8az/63KjLmtvoy3m7R+RKPApaQgYXwdtPDnsw=;
        b=lzJpKFxWrUwQYU29WmX1f4OGUpM/dAc4TFADQ51rFu5UO70Lqf8ntXd65NTkrBQlFm
         RJ8kWyLPY3szbPeeXg6bkg/WyrikqNZfpcCtARd8BTFvGBJQRD+M2vaz9b7WobPJzIaG
         fK9SNmM6exjzAO+tHNrj8oWW59361YAlX1h9EuPeVXrTCRMwSu2JEMVVOuEnAP00q4NJ
         Mgnd3W8x53BIC9Xj6a+zMLkDWkQ3wZV3eLje0Xbk9ZJJJBGl/zGpjOdZpnBZFUK6yLJ+
         sox1Xj8y9cPreKIq/BcXeSu4ikFrixuhWonFGHbewnW1B25L+5RiKzP66GPDRB8O+Dbz
         PUQQ==
X-Gm-Message-State: AJIora+fuRICObOfMPjrRfubBga1q4XlFXvmP+Y5DEHTySXWmaHHL2Ux
        s1hc/2e/KUe0uKg8IVpkVaM=
X-Google-Smtp-Source: AGRyM1t5ku2kBfHPSpoRQHwIIUr8jDN42FcDyMIJ40tIzUerhO26ZPfMDmh9Eh6yWBfh92kNOPo4fA==
X-Received: by 2002:a05:600c:4e90:b0:3a0:57d6:4458 with SMTP id f16-20020a05600c4e9000b003a057d64458mr13523229wmq.198.1657879974728;
        Fri, 15 Jul 2022 03:12:54 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id i16-20020a05600c355000b003a2f88b2559sm8368834wmq.44.2022.07.15.03.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 03:12:54 -0700 (PDT)
Message-ID: <11ff21b9-7169-00c5-95c0-130675ffe2ae@gmail.com>
Date:   Fri, 15 Jul 2022 11:12:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 12/12] sequencer: notify user of --update-refs activity
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <d5cd4b49e46bc2c186c6e89333360a975700c99a.1657631226.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <d5cd4b49e46bc2c186c6e89333360a975700c99a.1657631226.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07/2022 14:07, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> When the user runs 'git rebase -i --update-refs', the end message still
> says only
> 
>    Successfully rebased and updated <HEAD-ref>.
> 
> Update the sequencer to collect the successful (and unsuccessful) ref
> updates due to the --update-refs option, so the end message now says
> 
>    Successfully rebased and updated <HEAD-ref>.
>    Updated the following refs with --update-refs:
> 	refs/heads/first
> 	refs/heads/third
>    Failed to update the following refs with --update-refs:
> 	refs/heads/second
> 
> To test this output, we need to be very careful to format the expected
> error to drop the leading tab characters. Also, we need to be aware that
> the verbose output from 'git rebase' is writing progress lines which

s/is writing/writes/ ?

> don't use traditional newlines but clear the line after every progress
> item is complete.

I was a bit confused by the reference to "verbose output" in this 
paragraph. When the user passes --verbose then we do actually use NL, it 
is when the user does not pass verbose that we use CR instead.

> When opening the error file in an editor, these lines
> are visible, but when looking at the diff in a terminal those lines
> disappear because of the characters that delete the previous characters.
> Use 'sed' to clear those progress lines and clear the tabs so we can get
> an exact match on our expected output.

Thanks for the comprehensive commit message and for implementing an 
excellent suggestion from Elijah. I wonder if it makes sense to 
distinguish between the current branch and all the others when writing 
the update message as we do here or if all the refs should just be in a 
single list. I also think it doesn't matter much and we can change it 
later if we want.

 From the last test it looks like we are already printing something when 
we fail to update a ref (possibly this comes from the refs backend code) 
I don't think it hurts to print a summary of them all after that though.

> Reported-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>   sequencer.c                   | 40 +++++++++++++++++++++++++++++------
>   t/t3404-rebase-interactive.sh | 35 +++++++++++++++++++++++++++---
>   2 files changed, 66 insertions(+), 9 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 82ef062d497..bdc67c66f3e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4257,17 +4257,20 @@ static int do_update_ref(struct repository *r, const char *refname)
>   	return 0;
>   }
>   
> -static int do_update_refs(struct repository *r)
> +static int do_update_refs(struct repository *r, int quiet)
>   {
>   	int res = 0;
>   	struct string_list_item *item;
>   	struct string_list refs_to_oids = STRING_LIST_INIT_DUP;
>   	struct ref_store *refs = get_main_ref_store(r);
> +	struct strbuf update_msg = STRBUF_INIT;
> +	struct strbuf error_msg = STRBUF_INIT;
>   
>   	sequencer_get_update_refs_state(r->gitdir, &refs_to_oids);
>   
>   	for_each_string_list_item(item, &refs_to_oids) {
>   		struct update_ref_record *rec = item->util;
> +		int loop_res;
>   
>   		if (oideq(&rec->after, the_hash_algo->null_oid)) {
>   			/*
> @@ -4277,13 +4280,38 @@ static int do_update_refs(struct repository *r)
>   			continue;
>   		}
>   
> -		res |= refs_update_ref(refs, "rewritten during rebase",
> -				       item->string,
> -				       &rec->after, &rec->before,
> -				       0, UPDATE_REFS_MSG_ON_ERR);
> +		loop_res = refs_update_ref(refs, "rewritten during rebase",
> +					   item->string,
> +					   &rec->after, &rec->before,
> +					   0, UPDATE_REFS_MSG_ON_ERR);
> +		res |= loop_res;
> +
> +		if (quiet)
> +			continue;
> +
> +		if (loop_res)
> +			strbuf_addf(&error_msg, "\t%s\n", item->string);
> +		else
> +			strbuf_addf(&update_msg, "\t%s\n", item->string);
> +	}
> +
> +	if (!quiet &&

As you skip adding anything to the strbufs when quiet is true you don't 
really need this test

> +	    (update_msg.len || error_msg.len)) {
> +		fprintf(stderr,
> +			_("Updated the following refs with %s:\n%s"),
> +			"--update-refs",
> +			update_msg.buf);

This will be printed even if all the updates falied

> +
> +		if (res)
> +			fprintf(stderr,
> +				_("Failed to update the following refs with %s:\n%s"),
> +				"--update-refs",
> +				error_msg.buf);
>   	}
>   
>   	string_list_clear(&refs_to_oids, 1);
> +	strbuf_release(&update_msg);
> +	strbuf_release(&error_msg);
>   	return res;
>   }
>   
> @@ -4804,7 +4832,7 @@ cleanup_head_ref:
>   		strbuf_release(&head_ref);
>   	}
>   
> -	do_update_refs(r);
> +	do_update_refs(r, opts->quiet);
>   
>   	/*
>   	 * Sequence of picks finished successfully; cleanup by
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 4b7b77a4123..ef902b5431f 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1836,12 +1836,26 @@ test_expect_success '--update-refs updates refs correctly' '
>   	test_commit extra2 fileX &&
>   	git commit --amend --fixup=L &&
>   
> -	git rebase -i --autosquash --update-refs primary &&
> +	git rebase -i --autosquash --update-refs primary 2>err &&
>   
>   	test_cmp_rev HEAD~3 refs/heads/first &&
>   	test_cmp_rev HEAD~3 refs/heads/second &&
>   	test_cmp_rev HEAD~1 refs/heads/third &&
> -	test_cmp_rev HEAD refs/heads/no-conflict-branch
> +	test_cmp_rev HEAD refs/heads/no-conflict-branch &&
> +
> +	cat >expect <<-\EOF &&
> +	Successfully rebased and updated refs/heads/update-refs.
> +	Updated the following refs with --update-refs:
> +		refs/heads/first
> +		refs/heads/no-conflict-branch
> +		refs/heads/second
> +		refs/heads/third
> +	EOF
> +
> +	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
> +	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
> +		<err >err.trimmed &&
> +	test_cmp expect err.trimmed
>   '
>   
>   test_expect_success 'respect user edits to update-ref steps' '
> @@ -1980,7 +1994,22 @@ test_expect_success '--update-refs: check failed ref update' '
>   	git rev-parse third >.git/refs/heads/second &&
>   
>   	git rebase --continue 2>err &&
> -	grep "update_ref failed for ref '\''refs/heads/second'\''" err
> +	grep "update_ref failed for ref '\''refs/heads/second'\''" err &&
> +
> +	cat >expect <<-\EOF &&
> +	Updated the following refs with --update-refs:
> +		refs/heads/first
> +		refs/heads/no-conflict-branch
> +		refs/heads/third
> +	Failed to update the following refs with --update-refs:
> +		refs/heads/second
> +	EOF
> +
> +	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
> +	tail -n 6 err >err.last &&

I'm curious as to why we need tail here but not in the test above.

This is looking good, I'd be happy enough to see it merged as is.

Best Wishes

Phillip

> +	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
> +		<err.last >err.trimmed &&
> +	test_cmp expect err.trimmed
>   '
>   
>   # This must be the last test in this file

