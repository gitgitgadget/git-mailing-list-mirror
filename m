Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E7AC19F2D
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 00:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiHJAYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 20:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHJAYe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 20:24:34 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A2071710
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 17:24:33 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 73so12854032pgb.9
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 17:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=iome366EhqgMJwycvutLIuEncz3vSSjfTTj8/bRPFD8=;
        b=AktLm2ekhkh/NvpsqrYhXBwGtokErVBopiZFPsSoJABEhf1FsA+y2lHBxKOJer6nJ0
         2EEVCjwZ2gmSVM15xoEyw1sli0c6R/gBFGATCJ6iESdfbRF2fn4FwNVU+il6kBt3htqO
         tCXOeoYJ3rrjBDgunCAknSvGepiQhJIS4fgUbAxIkISY9w9m+pp9vi9Yqyr6NLIfvCCU
         azamrJqRorhAYrr0gFdvVKnURz5hij9yk2moPLAGac2uAVIo6OdUgzxfpzl2KlLfj6Te
         j2YbgGVm4Gy95Sz4uJvtzqVvwcsR2ZmEpsi6YquB91FW1Ecf5XOa2ReRMeF9dH9L2+M1
         Km9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iome366EhqgMJwycvutLIuEncz3vSSjfTTj8/bRPFD8=;
        b=4i6599owZbrjQs5x0S7RVQ1IXLCwXDnENsziWaagoIV4mNwZZqyeByVEa/yR7WyDyX
         W9me4/rMduJeXkFP60yjar9Gmeb2s4J5AQFQF3ExUsc/vVeSGTG4+mrqYrHz10wCY0q4
         2geaNI5dkYtkBaODQFG3fC5BbQTkazXaplFI80xfIm10PP7T+udzqmVnZWPD0egciVM0
         mpsMXIMTiQFOSjjBQgvYznOxA1STPTwf/C/HoHJLvGNrAFqxl0UWOChPpM6c3+Tc3+bq
         tIoA2ruc56hm8Dyfy3Rp7F5u/M8+wmugqlRbKtOD4AMs50zmTf+98NoIuXtu2ilRDg/g
         8Tog==
X-Gm-Message-State: ACgBeo3Fb7flApKI87W+eXA0umgVv1QIPPYroQniyx6HpxQlkZAqyHU3
        xi08J9wTqMpqqKq8kRgYUltG
X-Google-Smtp-Source: AA6agR52uxVIyxkdNgeY3otdjRwUzz1R6TkQe4Ajbkha2RER9xTVOQpGWGizeL0qYyzrTFt9BHAlDg==
X-Received: by 2002:a05:6a00:4393:b0:52f:3603:e62f with SMTP id bt19-20020a056a00439300b0052f3603e62fmr12071628pfb.23.1660091073419;
        Tue, 09 Aug 2022 17:24:33 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id jb9-20020a170903258900b001709e3c755fsm6105862plb.230.2022.08.09.17.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 17:24:32 -0700 (PDT)
Message-ID: <2c0cb658-cd5a-420a-d313-6839149b9b40@github.com>
Date:   Tue, 9 Aug 2022 17:24:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 3/4] rm: expand the index only when necessary
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
 <20220807041335.1790658-4-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220807041335.1790658-4-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Remove the `ensure_full_index()` method so `git-rm` does not always
> expand the index when the expansion is unnecessary, i.e. when
> <pathspec> does not have any possibilities to match anything outside
> of sparse-checkout definition.
> 
> Expand the index when the <pathspec> needs an expanded index, i.e. the
> <pathspec> contains wildcard that may need a full-index or the
> <pathspec> is simply outside of sparse-checkout definition.
> 
> Notice that the test 'rm pathspec expands index when necessary' in
> t1092 *is* testing this code change behavior, though it will be marked
> as 'test_expect_success' only in the next patch, where we officially
> mark `command_requires_full_index = 0`, so the index does not expand
> unless we tell it to do so.
> 
> Notice that because we also want `ensure_full_index` to record the
> stdout and stderr from Git command, a corresponding modification
> is also included in this patch. The reason we want the "sparse-index-out"
> and "sparse-index-err", is that we need to make sure there is no error
> from Git command itself, so we can rely on the `test_region` result
> and determine if the index is expanded or not.

I think this patch might make more sense _after_ patch 4. Without the
changes in patch 4, modifying how a sparse index is handled here doesn't
immediately change any functionality. Then, patch 4 effectively makes its
own changes (enable the sparse index) + "turns on" the changes from this
series, all at once.

I usually recommend trying to make the effects of a patch testable in that
patch (as long as it doesn't make a series more complicated/confusing). In
this case, it looks like you could swap the order of the commits and only
need to adjust the 'test_expect_success'/'test_expect_failure' settings on
the tests, making it a good candidate for this kind of reordering.

All that said, I don't think changing this is worth a re-roll on its own -
it's moreso intended as "things to consider for future series". :) 

> 
> Helped-by: Victoria Dye <vdye@github.com>
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/rm.c                             |  5 +++--
>  t/t1092-sparse-checkout-compatibility.sh | 27 ++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 84a935a16e..58ed924f0d 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -296,8 +296,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  
>  	seen = xcalloc(pathspec.nr, 1);
>  
> -	/* TODO: audit for interaction with sparse-index. */
> -	ensure_full_index(&the_index);
> +	if (pathspec_needs_expanded_index(&the_index, &pathspec))
> +		ensure_full_index(&the_index);
> +
>  	for (i = 0; i < active_nr; i++) {
>  		const struct cache_entry *ce = active_cache[i];
>  
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index c9300b77dd..94464cf911 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1340,10 +1340,14 @@ ensure_not_expanded () {
>  		shift &&
>  		test_must_fail env \
>  			GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
> -			git -C sparse-index "$@" || return 1
> +			git -C sparse-index "$@" \
> +			>sparse-index-out \
> +			2>sparse-index-error || return 1
>  	else
>  		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
> -			git -C sparse-index "$@" || return 1
> +			git -C sparse-index "$@" \
> +			>sparse-index-out \
> +			2>sparse-index-error || return 1
>  	fi &&
>  	test_region ! index ensure_full_index trace2.txt
>  }
> @@ -1910,4 +1914,23 @@ test_expect_failure 'rm pathspec outside sparse definition' '
>  	test_sparse_match git status --porcelain=v2
>  '
>  
> +test_expect_failure 'rm pathspec expands index when necessary' '
> +	init_repos &&
> +
> +	# in-cone pathspec (do not expand)
> +	ensure_not_expanded rm "deep/deep*" &&
> +	test_must_be_empty sparse-index-err &&
> +
> +	# out-of-cone pathspec (expand)
> +	! ensure_not_expanded rm --sparse "folder1/a*" &&
> +	test_must_be_empty sparse-index-err &&
> +
> +	# pathspec that should expand index
> +	! ensure_not_expanded rm "*/a" &&
> +	test_must_be_empty sparse-index-err &&
> +
> +	! ensure_not_expanded rm "**a" &&
> +	test_must_be_empty sparse-index-err
> +'
> +
>  test_done

