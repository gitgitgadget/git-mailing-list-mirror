Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70B5C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67FBC64E74
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhCQUnh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhCQUnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:43:16 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D27C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:43:16 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so3097685otk.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9srzRZIjHbwzwqDN+4jYHxKTAD3Hg84HpSZcABHbgqM=;
        b=jgudZVyee61FyOQASBR9Rp5OqcP9V1xs4kwTbLGH/Lucyp/94NArA2/mM8R6kh2VFx
         raIG2m1Z8ln729U+mfSvHAs7K9kQG+4CaMS7MdcYt9qFJ15CO9YdDBuWIND9q9i2BiGm
         +X9HbeycLEoLZZUJgjjGnE/1OlZ/JCNZgKjYw0L/Jx622HRrIBfI2J8ECr29i22m2ryc
         YoXsKHdNQtZyLam0fKmRvUvtLFBxqAuV0MfY6L6RhFQIfc2e6GoYWLwjsoLr80urFQ5G
         Zamzfca1q/o4JLNVEIAkljGdset2ljNfYceoLT78M9ekqqMd56gspMNXoMh+Z+WGa4vo
         YLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9srzRZIjHbwzwqDN+4jYHxKTAD3Hg84HpSZcABHbgqM=;
        b=nEFCrW56Ql+D5jXh/e5xMHXh9QKkrKRbO0KJvK2L/C6rbKWqkld6LVgW7YqDpGnFFq
         oTN9mT2qwive9t5WfaLgXHM51SECnWy4iby9j0wJcZVD5xvWGrBrWGf1m1Gsi2G6yReU
         0VEzb1CwvPAXZsxfbEjc9Fw1Ijq6P51nGwDsszqEoRnGY+9IsHkaxxNp+GZXyG7LJKIk
         JyUKtF0vVX1ooLidTaelUWk9gQczQWX/VxQfn7NSbEPTq6Kd2hlBV3cnXOznng9tWFdX
         2wfQb85iZ4/RexCa+gVsSr1C/0o1zllFa8bYOmo8/UQAGBxTdzFnDGZTb7LXQtBcGMAt
         VwsQ==
X-Gm-Message-State: AOAM533IjTFzmMd4rg+xkcCGgDV2kcqSSmIY3pQU1gV3wZ+JJC87YcI+
        h+5pqlISuvr07PDnuhRJbkQ=
X-Google-Smtp-Source: ABdhPJwkLW/yyxhNnggt/LkK99xderr3nXdV9TUS+WuD+xsJMF/afeAWPriMzqnwys24/RwNrQ+lbA==
X-Received: by 2002:a9d:68d7:: with SMTP id i23mr4939840oto.133.1616013795991;
        Wed, 17 Mar 2021 13:43:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5df9:6440:37ca:197f? ([2600:1700:e72:80a0:5df9:6440:37ca:197f])
        by smtp.gmail.com with ESMTPSA id r22sm9106302otg.4.2021.03.17.13.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 13:43:15 -0700 (PDT)
Subject: Re: [RFC/PATCH 3/5] ls-files: add and use a new --sparse option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        dstolee@microsoft.com
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
 <20210317132814.30175-4-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <028fb838-f012-e8c7-eb8b-53c810802243@gmail.com>
Date:   Wed, 17 Mar 2021 16:43:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210317132814.30175-4-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 9:28 AM, Ævar Arnfjörð Bjarmason wrote:
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh

I want to learn from your suggested changes to the test, here,
so forgive my questions here:
  
> +test_index_entry_like () {
> +	dir=$1
> +	shift
> +	fmt=$1
> +	shift
> +	rev=$1
> +	shift
> +	entry=$1
> +	shift
> +	file=$1
> +	shift

Why all the shifts? Why not just use $1, $2, $3,...? My
guess is that you want to be able to insert a new parameter
in the middle in the future without changing the later
numbers, but that seems unlikely, and we could just add
the parameter at the end.

> +	hash=$(git -C "$dir" rev-parse "$rev") &&
> +	printf "$fmt\n" "$hash" "$entry" >expected &&
> +	if grep "$entry" "$file" >line
> +	then
> +		test_cmp expected line
> +	else
> +		cat cache &&
> +		false
> +	fi
> +}
> +
>  test_expect_success 'sparse-index contents' '
>  	init_repos &&
>  
> -	test-tool -C sparse-index read-cache --table >cache &&
> +	git -C sparse-index ls-files --sparse >cache &&
>  	for dir in folder1 folder2 x
>  	do
> -		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
> -		grep "040000 tree $TREE	$dir/" cache \
> -			|| return 1
> +		test_index_entry_like sparse-index "040000 %s 0\t%s" "HEAD:$dir" "$dir/" cache || return 1

I see how this uses only one line, but it seems like the
test_index_entry_like is too generic to make it not a
complicated mess of format strings that need to copy
over and over again.

Perhaps instead it could be a "test_entry_is_tree"
and it only passes "$dir" and "cache"? Then we could drop the loop and
just have

	test_entry_is_tree cache folder1 &&
	test_entry_is_tree cache folder2 &&
	test_entry_is_tree cache x &&

or we could still use the loop, especially when we test for four trees.

> -	test-tool -C sparse-index read-cache --table >cache &&
> +	git -C sparse-index ls-files --sparse >cache &&
>  	for dir in deep/deeper2 folder1 folder2 x
>  	do
> -		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
> -		grep "040000 tree $TREE	$dir/" cache \
> -			|| return 1
> +		test_index_entry_like sparse-index "040000 %s 0\t%s" "HEAD:$dir" "$dir/" cache || return 1
>  	done &&
>  
> +	grep 040000 cache >lines &&
> +	test_line_count = 4 lines &&
> +

The point here is to check that no other entries are trees? We know
that this number will be _at least_ 4 based on the loop above.

Thanks,
-Stolee
