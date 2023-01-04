Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF3CC53210
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 23:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbjADXsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 18:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjADXs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 18:48:28 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC76443183
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 15:48:26 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id z12so28737101qtv.5
        for <git@vger.kernel.org>; Wed, 04 Jan 2023 15:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x+wUxSpscqJk5B16qaiyZQdpS6D93Sd5FYI+HFzN6F8=;
        b=KooHFJh75QYCdFab8NZ7nDr54m5G4mTxTcoEpLXWjTMUCbt5mGralbxLrZau8GNxyz
         16+UmqaLBX2f8D5SBgiI+iBbNZL0IBAxB1Yie/6HEXukQHKybw20h7TpMykxjWZDJkuy
         /PciVrtJiJ/bPlAcQuTCRiQ95eiaXOSlgkdYgYMohr2wE9eEr7ddi/gDyWKdMF9FX8yq
         0fv5gRGYpLIto8xiR/VAVLD415U29Qw34WKGrPwgKWNORrsFks69wQ9SW7+ycoRv4JZu
         QyJ6nCG2NwDFVWDgdno/mJ9jVbjgl+sO6T+dmCy0QmYFOYdEcoyYedWy14XEQs/FBVwl
         fxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+wUxSpscqJk5B16qaiyZQdpS6D93Sd5FYI+HFzN6F8=;
        b=k9Uj6zmXUVzeOsHNBEF4ezrKnpBIbknZK/lwrrMvuMmdvXoKqL1zVxhMaeVUyDrc+W
         0/EG/m2eDAoHXKCxjyJNHu+P4dzAJzP9WfbDKkH1s8pg/hQALXky9qZhgnNcQctQVz7L
         35L0ulpsgzzrCAM9t4QVaPEuLmLZs31+XaFV+kapQBN4ghJAzmY4gPNyLwAW6gk/P37A
         caUtLOdmcC2qBESKC0hTmixIqS1rukm5W7b80HRikFQFfEp/bAO/mTZo0j55PrErG68u
         DC43S9/jJ54Z/KQaMNkw5POScmLfj5ia5lfnE8pgtFlBL04Z3Pm9/UExleH0f63zHQQs
         DgSw==
X-Gm-Message-State: AFqh2kpTil2qyytNXjUNLrpvKM8lR/LSo03/T/lw7qCYta5ZV23cYbrf
        TF58SZ1vQXxlxbm3wbSZBwgA
X-Google-Smtp-Source: AMrXdXtT9S/OcD1e2GiGdksBgW/y/yqbJfCYU0ydvCieedMRwsnlKVCYavWrcA8qTwdI6a9zNXTcOQ==
X-Received: by 2002:a05:622a:5810:b0:3a8:15d2:6e8b with SMTP id fg16-20020a05622a581000b003a815d26e8bmr76094134qtb.33.1672876105748;
        Wed, 04 Jan 2023 15:48:25 -0800 (PST)
Received: from [192.168.1.45] (ool-182f5e1b.dyn.optonline.net. [24.47.94.27])
        by smtp.gmail.com with ESMTPSA id x3-20020ac87303000000b003a97a71c906sm20661981qto.78.2023.01.04.15.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 15:48:25 -0800 (PST)
Message-ID: <99e3c0f9-ecfa-7c26-eea5-685bc324f674@github.com>
Date:   Wed, 4 Jan 2023 18:48:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] dir: check for single file cone patterns
To:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        William Sprent <williams@unity3d.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1446.git.1671546459151.gitgitgadget@gmail.com>
 <pull.1446.v2.git.1672734059938.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1446.v2.git.1672734059938.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Sprent via GitGitGadget wrote:
> From: William Sprent <williams@unity3d.com>
> 
> The sparse checkout documentation states that the cone mode pattern set
> is limited to patterns that either recursively include directories or
> patterns that match all files in a directory. In the sparse checkout
> file, the former manifest in the form:
> 
>     /A/B/C/
> 
> while the latter become a pair of patterns either in the form:
> 
>     /A/B/
>     !/A/B/*/
> 
> or in the special case of matching the toplevel files:
> 
>     /*
>     !/*/
> 
> The 'add_pattern_to_hashsets()' function contains checks which serve to
> disable cone-mode when non-cone patterns are encountered. However, these
> do not catch when the pattern list attempts to match a single file or
> directory, e.g. a pattern in the form:
> 
>     /A/B/C
> 
> This causes sparse-checkout to exhibit unexpected behaviour when such a
> pattern is in the sparse-checkout file and cone mode is enabled.
> Concretely, with the pattern like the above, sparse-checkout, in
> non-cone mode, will only include the directory or file located at
> '/A/B/C'. However, with cone mode enabled, sparse-checkout will instead
> just manifest the toplevel files but not any file located at '/A/B/C'.
> 
> Relatedly, issues occur when supplying the same kind of filter when
> partial cloning with '--filter=sparse:oid=<oid>'. 'upload-pack' will
> correctly just include the objects that match the non-cone pattern
> matching. Which means that checking out the newly cloned repo with the
> same filter, but with cone mode enabled, fails due to missing objects.

This clearly explains the issue you're trying to fix: cone mode
sparse-checkout requires patterns like '/A/B/', !/A/B/*/', '/A/B/C/', etc.,
but invalid patterns like '/A/B/C' (no trailing slash) currently don't force
the switch to non-cone mode, leading to unexpected behavior.

> 
> To fix these issues, add a cone mode pattern check that asserts that
> every pattern is either a directory match or the pattern '/*'. Add a
> test to verify the new pattern check and modify another to reflect that
> non-directory patterns are caught earlier.

I think this is the best way to maintain the current intended behavior of
cone mode sparse-checkout. While the idea of single file "exceptions" to
cone patterns has been brought up in the past (I think most recently at the
Contributor's Summit this past September [1]), it'd be a substantial change
that's definitely out-of-scope of this small bugfix.

[1] https://lore.kernel.org/git/YzXwOsaoCdBhHsX1@nand.local/

> 
> Signed-off-by: William Sprent <williams@unity3d.com>
> ---
>     dir: check for single file cone patterns
>     
>     Resubmitting this without the superfluous double negation of the
>     'strcmp' output.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1446%2Fwilliams-unity%2Fws%2Fsparse-checkout-pattern-match-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1446/williams-unity/ws/sparse-checkout-pattern-match-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1446
> 
> Range-diff vs v1:
> 
>  1:  cfb4b75c378 ! 1:  d5406e62f6f dir: check for single file cone patterns
>      @@ dir.c: static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_
>        	}
>        
>       +	if (!(given->flags & PATTERN_FLAG_MUSTBEDIR) &&
>      -+	    !!strcmp(given->pattern, "/*")) {
>      ++	    strcmp(given->pattern, "/*")) {
>       +		/* Not a cone pattern. */
>       +		warning(_("unrecognized pattern: '%s'"), given->pattern);
>       +		goto clear_hashmaps;
> 
> 
>  dir.c                              |  7 +++++++
>  t/t1091-sparse-checkout-builtin.sh | 11 ++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/dir.c b/dir.c
> index fbdb24fc819..4e99f0c868f 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -732,6 +732,13 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
>  		goto clear_hashmaps;
>  	}
>  
> +	if (!(given->flags & PATTERN_FLAG_MUSTBEDIR) &&
> +	    strcmp(given->pattern, "/*")) {

This condition is only entered if:

- the pattern *does not* end in a trailing slash 
  ('!(given->flags & PATTERN_FLAG_MUSTBEDIR)'), AND
- the pattern *does not* start with '/*' ('strcmp(given->pattern, "/*")')

The '/*'-like patterns are already handled by other parts of
'add_pattern_to_hashsets()', so only the '/A/B/C'-like patterns will trigger
the "unrecognized" warning. Looks good!


> +		/* Not a cone pattern. */
> +		warning(_("unrecognized pattern: '%s'"), given->pattern);
> +		goto clear_hashmaps;
> +	}
> +
>  	prev = given->pattern;
>  	cur = given->pattern + 1;
>  	next = given->pattern + 2;
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index b563d6c263e..627267be153 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -238,7 +238,7 @@ test_expect_success 'cone mode: match patterns' '
>  test_expect_success 'cone mode: warn on bad pattern' '
>  	test_when_finished mv sparse-checkout repo/.git/info/ &&
>  	cp repo/.git/info/sparse-checkout . &&
> -	echo "!/deep/deeper/*" >>repo/.git/info/sparse-checkout &&
> +	echo "!/deep/deeper/*/" >>repo/.git/info/sparse-checkout &&

This test changes because, without the trailing slash on the pattern, the
error would become "unrecognized pattern: !/deep/deeper/*" due to the new
check in 'add_pattern_to_hashsets()'. Changing the test pattern ensures
we're still exercising what the test was originally intended to exercise,
and doesn't indicate a regression.

>  	git -C repo read-tree -mu HEAD 2>err &&
>  	test_i18ngrep "unrecognized negative pattern" err
>  '
> @@ -667,6 +667,15 @@ test_expect_success 'pattern-checks: starting "*"' '
>  	check_read_tree_errors repo "a deep" "disabling cone pattern matching"
>  '
>  
> +test_expect_success 'pattern-checks: non directory pattern' '
> +	cat >repo/.git/info/sparse-checkout <<-\EOF &&
> +	/deep/deeper1/a
> +	EOF
> +	check_read_tree_errors repo deep "disabling cone pattern matching" &&
> +	check_files repo/deep deeper1 &&
> +	check_files repo/deep/deeper1 a
> +'

And this test ensures the new check is working for the appropriate patterns.

This patch looks good to me, thanks for finding & fixing the bug!

> +
>  test_expect_success 'pattern-checks: contained glob characters' '
>  	for c in "[a]" "\\" "?" "*"
>  	do
> 
> base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7

