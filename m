Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D93EC6FA83
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 12:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIGMUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 08:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIGMUh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 08:20:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3161A99E5
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 05:20:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e18so19424782edj.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 05:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=uSf5rLVDaWeD7j05pjOuEa3cj8x1n2nmE8LG0Ooazfk=;
        b=kXNtPcWsva1pmqGsBo6ZMHeUq/69jTSDg9spXoRxDDfSwEYIW1rJUJpPuN/rlf4lJg
         iJKQg59bI3yS2+yJyMxaI/9V+kfL4Ac09TYQPE6eMTyIx0614XmWKL2kfJE0XsFRmJl7
         a7qt7FGx9F4hv4xCm67qxcymqa7L2wVBgocj7RNL/UAwO/gE6+A9JIDSwSL5DyC2VQc3
         SeAcXgcM2Ql1wXP7hfSNGslIa/FqMR0gwzpuFzpY4dBHZBgPHRjBI9FFRz1fWFUpzRpI
         B8t9BhmE+P9uCUO6Oys20ygyJhtLleMcBpqfG/PWKJOAt2Z3ovLjNnlfYucbfKbrin/q
         KwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uSf5rLVDaWeD7j05pjOuEa3cj8x1n2nmE8LG0Ooazfk=;
        b=ovY4oR/yqxOy5XnImk//T6l0GxtdfreVT516B5BwxpYGQDwi9WaPMaDoUMF+y2lK6N
         qC3IDEPEledm40WtoDWK78UnxKpK1G24uDogBtBC3VfAOQc5330ZAYrfL6eG/x4TOmqj
         lCkD0ZM8mqjHqwrx7tX7bO8xmp5n3qcPTGV/45Qgh4IRUvf9cdHP0y1GON+I/3U+ODz8
         H1Wni+NVTsZVVmcl1A9A3p667eE/qVV2qPXj4x5TcAY+GC94KqJczxm2/wnuG05LZTeu
         Xeqlf4Z6kIR8vnGimmDCT83dq8vRD9r0gEzuVwnKKsoqIA1lIC4BSj2sj37ImVlOf5u6
         L0QA==
X-Gm-Message-State: ACgBeo0/GWHmMpPzIY5iLOvbYE4hrdh3FXVVUZmRPOoJ9pFd7dunz4O4
        PIamw51halmKqdJlHCN2tJ/h0/G/+hq/DA==
X-Google-Smtp-Source: AA6agR4xt4K/O+OmdjYfb6z2kED2PBWWG0ZjiOXTbfDo+7Fo7vTTTfNncmvqrLLvMD6pNu7vVwWvFg==
X-Received: by 2002:a05:6402:254a:b0:448:b73d:a96f with SMTP id l10-20020a056402254a00b00448b73da96fmr2894689edb.199.1662553234240;
        Wed, 07 Sep 2022 05:20:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906538800b006fe0abb00f0sm8184657ejo.209.2022.09.07.05.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 05:20:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oVu2i-000lQv-3A;
        Wed, 07 Sep 2022 14:20:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] tests: replace mingw_test_cmp with a helper in C
Date:   Wed, 07 Sep 2022 13:57:59 +0200
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
 <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
 <1f5366f137967cbec30041b40eedd86ce5f6e953.1662469859.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <1f5366f137967cbec30041b40eedd86ce5f6e953.1662469859.git.gitgitgadget@gmail.com>
Message-ID: <220907.86v8pzl6jz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 06 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
> +++ b/t/helper/test-text-cmp.c
> @@ -0,0 +1,78 @@
> +#include "test-tool.h"
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +#include "gettext.h"

Superflous header? Compiles without gettext.h for me (and we shouldn't
use i18n in test helpers).

> [...]
> +int cmd__text_cmp(int argc, const char **argv)
> +{
> +	FILE *f0, *f1;
> +	struct strbuf b0 = STRBUF_INIT, b1 = STRBUF_INIT;
> +
> +	if (argc != 3)
> +		die("Require exactly 2 arguments, got %d", argc);

Here you conflate the argc v.s. arguments minus the "text-cmp",
resulting in:

	helper/test-tool text-cmp 2
        fatal: Require exactly 2 arguments, got 2

An argc-- argv++ at the beginning seems like the easiest way out of
this. Also s/Require/require/ per CodingGuidelines.

> +	if (!strcmp(argv[1], "-") && !strcmp(argv[2], "-"))
> +		die("only one parameter can refer to `stdin` but not both");
> +
> +	if (!(f0 = !strcmp(argv[1], "-") ? stdin : fopen(argv[1], "r")))
> +		return error_errno("could not open '%s'", argv[1]);
> +	if (!(f1 = !strcmp(argv[2], "-") ? stdin : fopen(argv[2], "r"))) {
> +		fclose(f0);
> +		return error_errno("could not open '%s'", argv[2]);
> +	}

Faithfully emulating the old version. I do wonder if we couldn't simply
adjust the handful of tests that actually make use of the "-" diff(1)
feature. AFAICT there's around 10 of those at most, and they all seem
like cases where it would be easy to change:

	(echo foo) | test_cmp - actual

Or whatever, to:

	echo foo >expected &&
	test_cmp expected actual

...

> +			if (!strcmp(argv[1], "-") || !strcmp(argv[2], "-"))
> +				warning("cannot show diff because `stdin` was already consumed");

...

Which means we wouldn't need to punt on this.

> +			else if (!run_diff(argv[1], argv[2]))
> +				die("Huh? 'diff --no-index %s %s' succeeded",
> +				    argv[1], argv[2]);

I tried manually testing this with:

	GIT_TRACE=1 GIT_TEST_CMP="/home/avar/g/git/git diff --no-index --" ./t0021-conversion.sh  -vixd

v.s.:

	GIT_TRACE=1 GIT_TEST_CMP="$PWD/helper/test-tool text-cmp" ./t0021-conversion.sh  -vixd

Your version doesn't get confused by the same, but AFAICT this is by
fragile accident.

I.e. you run your own equivalent of "cmp", so because the files are the
same in that case we don't run the "diff --no-index".

But the "diff --no-index" in that t0021*.sh case *would* report
differences, even though the files are byte-for-byte identical.

So the "cmp"-a-like here isn't just an optimization to avoid forking the
"git diff" process, it's an entirely different comparison method in
cases where we have a "filter".

It just so happens that our test suite doesn't currently combine them in
a way that causes a current failure.

>  test_cmp () {
>  	test "$#" -ne 2 && BUG "2 param"
> -	eval "$GIT_TEST_CMP" '"$@"'
> +	GIT_ALLOC_LIMIT=0 eval "$GIT_TEST_CMP" '"$@"'
>  }

Further, we have a clear boundary in the test suite between "git" and
"test-tool" things we invoke, and third party tools. The former we put
in "test_must_fail_acceptable".

When using this new helper we'd hide potential segfaults and BUGs in any
"! test_cmp" invocation..

To avoid the introduction of such a blindspot we'd need to change
"test_cmp" to take an optional "!" as the 1st argument, and convert the
existing "! test_cmp" to "test_cmp !", then carry some flag to indicate
that our "GIT_TEST_CMP" is a git or test-tool invocation, and check it
appropriately.

> [...]
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 7726d1da88a..0be25ecbd59 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1546,7 +1546,7 @@ case $uname_s in
>  	test_set_prereq SED_STRIPS_CR
>  	test_set_prereq GREP_STRIPS_CR
>  	test_set_prereq WINDOWS
> -	GIT_TEST_CMP=mingw_test_cmp
> +	GIT_TEST_CMP="test-tool text-cmp"
>  	;;
>  *CYGWIN*)
>  	test_set_prereq POSIXPERM

Not a new problem, but this is incompatible with
GIT_TEST_CMP_USE_COPIED_CONTEXT.

What is new though is that with this series there's no longer a good
reason AFAICT to carry GIT_TEST_CMP_USE_COPIED_CONTEXT at all. I.e. we
have it for a "diff" that doesn't understand "-u".

If (after getting past tho caveats noted above) we could simply invoke
our own test-tool we could drop that special-casing & just always invoke
our own test_cmp helper.

