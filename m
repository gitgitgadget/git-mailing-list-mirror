Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3574C61DA4
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 10:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCMKbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 06:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCMKbt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 06:31:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6925849C2
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 03:31:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j3so7565730wms.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678703506;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAor0NaWS8z8Gj116f8wOY3wAI8eQ/NiF/3oCcWpxnY=;
        b=cptGF6pUP2w5dj0IYcGjS6Th1ltJ9viMzGVL/5yZo8NNl5j4QVAgZNbhrjw+z/5WN1
         5VOAvfpH8JNHBuJc/uPTMQ6ENGHPO4+0biRlG8zwuOPr6wBSjO3blB9188s5DXMxgYnc
         BvBWU/XOPTxTU1vAwFGfCu9FerXeOzsx1yGe1i4D/AeQOR9fzmASCWtWSLqlAcbwDGQ2
         w02rMnK76DNV79dqzjfyi4wpUAhYYcD7UX3oSkvx+3kJh305GdcbfliDMCdnbgAMzPcO
         /dSInlBHV+kX4D6VrRWYR6581PfZCU82SZZSiWgCVGZ1ON1YSn/+J3oFqndPTfPSMXtz
         lBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678703506;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAor0NaWS8z8Gj116f8wOY3wAI8eQ/NiF/3oCcWpxnY=;
        b=5jYTDOxV1SX0KaM0J2xH2b7plmcRQDRtaRtnTvNB9ajvutQoGBYVB0jcZwvz4f5Luc
         HZXrjB3kQJNwihW0hkwiZr5R/cqHbN9GJ0u/xnOQDgVCM+2QGql5oD5sv7kRfKMN8aTC
         mz4kJb4WrEpIVwcQfh0lA+GrskW6UbCM0T2BPzeo2BB1eGsG8YY97b/i2fwFRG9kU3Eg
         Gcpc2Tx2JtlP37zbZ0g71wVo7dF5ocf0JE1Fr8BP52BiHYxXVYo2i3jX3qXGaxhKL2U7
         S+jbfJ4uDM/CCvNqd5cJU/X47UiszEqyTjHT9ggCW/j1g14k3DJ/PxLA9botvlwM60jO
         5rPA==
X-Gm-Message-State: AO0yUKVB9N5etp9w0YiUWxak4u95K/NoXWxMv/LOtJjAlPl4YTYyNzBS
        9NZCYPDHm2PCl2rGcLvBf90=
X-Google-Smtp-Source: AK7set+jL4XmILE4c6/NhRz+iK3O6zhmtx6/5SDwS8uT4lPNGFm9m16N0/ghbRktc916oc34rnvYnw==
X-Received: by 2002:a05:600c:4708:b0:3ea:c100:f5e7 with SMTP id v8-20020a05600c470800b003eac100f5e7mr10498800wmo.39.1678703505723;
        Mon, 13 Mar 2023 03:31:45 -0700 (PDT)
Received: from [192.168.1.212] ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc018000000b003e21f959453sm8654013wmb.32.2023.03.13.03.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 03:31:45 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <6badb697-aa74-cc2f-ba43-0bbf54b10973@dunelm.org.uk>
Date:   Mon, 13 Mar 2023 10:31:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/8] for-each-ref: add --stdin option
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <a1d9e0f6ff6660c9264673be18bc24956f74eb9c.1678468864.git.gitgitgadget@gmail.com>
In-Reply-To: <a1d9e0f6ff6660c9264673be18bc24956f74eb9c.1678468864.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 10/03/2023 17:20, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> When a user wishes to input a large list of patterns to 'git
> for-each-ref' (likely a long list of exact refs) there are frequently
> system limits on the number of command-line arguments.
> 
> Add a new --stdin option to instead read the patterns from standard
> input. Add tests that check that any unrecognized arguments are
> considered an error when --stdin is provided. Also, an empty pattern
> list is interpreted as the complete ref set.
> 
> When reading from stdin, we populate the filter.name_patterns array
> dynamically as opposed to pointing to the 'argv' array directly. This
> requires a careful cast while freeing the individual strings,
> conditioned on the --stdin option.

I think what you've got here is fine, but if you wanted you could 
simplify it by using an strvec. Something like

	struct strvec vec = STRVEC_INIT;

	...

	if (from_stdin) {
		struct strbuf buf = STRBUF_INIT;

		if (argv[0])
			die(_("unknown arguments supplied with --stdin"));

		while (strbuf_getline(&line, stdin) != EOF)
			strvec_push(&vec, buf.buf);

		filter.name_patters = vec.v;
	} else {
		filter.name_patterns = argv;
	}

	...

	strvec_clear(&vec);

gets rid of the manual memory management with ALLOC_GROW() and the need 
to cast filter.name_patterns when free()ing. It is not immediately 
obvious from the name but struct strvec keeps the array NULL terminated.

Best Wishes

Phillip

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>   Documentation/git-for-each-ref.txt |  7 +++++-
>   builtin/for-each-ref.c             | 29 ++++++++++++++++++++++-
>   t/t6300-for-each-ref.sh            | 37 ++++++++++++++++++++++++++++++
>   3 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 6da899c6296..ccdc2911bb9 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -9,7 +9,8 @@ SYNOPSIS
>   --------
>   [verse]
>   'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
> -		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
> +		   [(--sort=<key>)...] [--format=<format>]
> +		   [ --stdin | <pattern>... ]
>   		   [--points-at=<object>]
>   		   [--merged[=<object>]] [--no-merged[=<object>]]
>   		   [--contains[=<object>]] [--no-contains[=<object>]]
> @@ -32,6 +33,10 @@ OPTIONS
>   	literally, in the latter case matching completely or from the
>   	beginning up to a slash.
>   
> +--stdin::
> +	If `--stdin` is supplied, then the list of patterns is read from
> +	standard input instead of from the argument list.
> +
>   --count=<count>::
>   	By default the command shows all refs that match
>   	`<pattern>`.  This option makes it stop after showing
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 6f62f40d126..e005a7ef3ce 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -25,6 +25,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>   	struct ref_format format = REF_FORMAT_INIT;
>   	struct strbuf output = STRBUF_INIT;
>   	struct strbuf err = STRBUF_INIT;
> +	int from_stdin = 0;
>   
>   	struct option opts[] = {
>   		OPT_BIT('s', "shell", &format.quote_style,
> @@ -49,6 +50,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>   		OPT_CONTAINS(&filter.with_commit, N_("print only refs which contain the commit")),
>   		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
>   		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
> +		OPT_BOOL(0, "stdin", &from_stdin, N_("read reference patterns from stdin")),
>   		OPT_END(),
>   	};
>   
> @@ -75,7 +77,27 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>   	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
>   	filter.ignore_case = icase;
>   
> -	filter.name_patterns = argv;
> +	if (from_stdin) {
> +		struct strbuf line = STRBUF_INIT;
> +		size_t nr = 0, alloc = 16;
> +
> +		if (argv[0])
> +			die(_("unknown arguments supplied with --stdin"));
> +
> +		CALLOC_ARRAY(filter.name_patterns, alloc);
> +
> +		while (strbuf_getline(&line, stdin) != EOF) {
> +			ALLOC_GROW(filter.name_patterns, nr + 1, alloc);
> +			filter.name_patterns[nr++] = strbuf_detach(&line, NULL);
> +		}
> +
> +		/* Add a terminating NULL string. */
> +		ALLOC_GROW(filter.name_patterns, nr + 1, alloc);
> +		filter.name_patterns[nr + 1] = NULL;
> +	} else {
> +		filter.name_patterns = argv;
> +	}
> +
>   	filter.match_as_path = 1;
>   	filter_refs(&array, &filter, FILTER_REFS_ALL);
>   	ref_array_sort(sorting, &array);
> @@ -97,5 +119,10 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>   	free_commit_list(filter.with_commit);
>   	free_commit_list(filter.no_commit);
>   	ref_sorting_release(sorting);
> +	if (from_stdin) {
> +		for (size_t i = 0; filter.name_patterns[i]; i++)
> +			free((char *)filter.name_patterns[i]);
> +		free(filter.name_patterns);
> +	}
>   	return 0;
>   }
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index c466fd989f1..a58053a54c5 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -1464,4 +1464,41 @@ sig_crlf="$(printf "%s" "$sig" | append_cr; echo dummy)"
>   sig_crlf=${sig_crlf%dummy}
>   test_atom refs/tags/fake-sig-crlf contents:signature "$sig_crlf"
>   
> +test_expect_success 'git for-each-ref --stdin: empty' '
> +	>in &&
> +	git for-each-ref --format="%(refname)" --stdin <in >actual &&
> +	git for-each-ref --format="%(refname)" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git for-each-ref --stdin: fails if extra args' '
> +	>in &&
> +	test_must_fail git for-each-ref --format="%(refname)" \
> +		--stdin refs/heads/extra <in 2>err &&
> +	grep "unknown arguments supplied with --stdin" err
> +'
> +
> +test_expect_success 'git for-each-ref --stdin: matches' '
> +	cat >in <<-EOF &&
> +	refs/tags/multi*
> +	refs/heads/amb*
> +	EOF
> +
> +	cat >expect <<-EOF &&
> +	refs/heads/ambiguous
> +	refs/tags/multi-ref1-100000-user1
> +	refs/tags/multi-ref1-100000-user2
> +	refs/tags/multi-ref1-200000-user1
> +	refs/tags/multi-ref1-200000-user2
> +	refs/tags/multi-ref2-100000-user1
> +	refs/tags/multi-ref2-100000-user2
> +	refs/tags/multi-ref2-200000-user1
> +	refs/tags/multi-ref2-200000-user2
> +	refs/tags/multiline
> +	EOF
> +
> +	git for-each-ref --format="%(refname)" --stdin <in >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_done
