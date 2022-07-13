Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3293EC433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 11:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbiGMLQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 07:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbiGMLQT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 07:16:19 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0670D10273D
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 04:15:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l23so19250071ejr.5
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 04:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ul9q1JyjsfQMh5qgY7oY+cqJZaCDo1FFF9gLG3L6PQo=;
        b=jpQaDh9bNC/Q/v7iqqECKSivX5jx52JrNHJ8hXblPi4dx8yM/l81hoAwzC++Xtw+X9
         nLBlJUlXALnvzU6iGJSULnr/zKSn/w6/p9IGSg1s9TR3+LYM+/w3IWKB8rs2ybZXgPIc
         VInZNcTNSSpVBKrJf7jDJxQ77oCE9FCDL3SIRGl5anCgX4plke1N8wK3sK4FXXGEn4RD
         t8uO9m+xj/ib2Uzaiz3xvOhQopx1V2/JeZoBPDra3xHnb+BHp837VNL4EkaPpaYop7VA
         zDWC1sf/7J0oITISx1MJxTBV2bwEUtoJhgAMvDhSzNrmK5XioK7hco/YO2JjOnvhgBMi
         8QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ul9q1JyjsfQMh5qgY7oY+cqJZaCDo1FFF9gLG3L6PQo=;
        b=7Ak28nLA2qPPAnL96Weu/pST2tMr88qn8sMZFlxYcUXPM8ajJv5L0z2UHEcANeeR+c
         4279sUbbMO5nqS34tbQuRLLHF+W5gD/TMm4TQzRjBg387RgRneYgKnX4YamV2gEDzOVk
         IPQZhf9RZcDhhgBXE5w2HJRqtaI0bT1JC+Ixu1owHrsQhEyrvKra7s+4McVNgBWwon1c
         0fEE7HPXhsqHLqWrf0b9aKpYKSaJ0tTATZX5UMwm4x7HBPWC72Z4COKXPfESl7BEV3o7
         EFcYCO3CxoWgAPhSZePWtek1MIT9lUbIYGSQpd+ROCDkO4JrNGMApUjPPXMhUSzMuw7J
         B8MQ==
X-Gm-Message-State: AJIora+zWd1MLpWkP32yHTbyEhC//XmzIMlYPK8YPcKVscpcJbKla4bP
        n5H13Pq5Zg2YPIf/AEhPCm2bfCQZEMB3FQ==
X-Google-Smtp-Source: AGRyM1tjtCRdKGwJ/I5KgfqkA/4/dZddnDTJPmjmulPsfYjI95AaDWKicH76Cgb+d/EIPIUXVR7G/w==
X-Received: by 2002:a17:906:84f0:b0:72b:5cf4:465d with SMTP id zp16-20020a17090684f000b0072b5cf4465dmr2943266ejb.705.1657710957557;
        Wed, 13 Jul 2022 04:15:57 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ky24-20020a170907779800b0072abb95eaa4sm4829457ejc.215.2022.07.13.04.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 04:15:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBaLU-001hOE-4I;
        Wed, 13 Jul 2022 13:15:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] checkout: show bug about failed entries being
 included in final report
Date:   Wed, 13 Jul 2022 13:14:55 +0200
References: <cover.1657685948.git.matheus.bernardino@usp.br>
 <8da18a0a8c34a1c10d55bcdda725817db586f763.1657685948.git.matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <8da18a0a8c34a1c10d55bcdda725817db586f763.1657685948.git.matheus.bernardino@usp.br>
Message-ID: <220713.86a69d461f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 13 2022, Matheus Tavares wrote:

> After checkout, git usually reports how many entries were updated at
> that operation. However, because we count the entries too soon during
> the checkout process, we may actually include entries that do not get
> properly checked out in the end. This can lead to an inaccurate final
> report if the user expects it to show only the *successful* updates.
> This will be fixed in the next commit, but for now let's document it
> with a test that cover all checkout modes.
>
> Note that `test_checkout_workers` have to be slightly adjusted in order
> to use the construct `test_checkout_workers ...  test_must_fail git
> checkout`. The function runs the command given to it with an assignment
> prefix to set the GIT_TRACE2 variable. However, this this assignment has
> an undefined behavior when the command is a shell function (like
> `test_must_fail`). As POSIX specifies:
>
>   If the command name is a function that is not a standard utility
>   implemented as a function, variable assignments shall affect the
>   current execution environment during the execution of the function. It
>   is unspecified:
>
>     - Whether or not the variable assignments persist after the
>       completion of the function
>
>     - Whether or not the variables gain the export attribute during the
>       execution of the function
>
> Thus, in order to make sure the GIT_TRACE2 value gets visible to the git
> command executed by `test_must_fail`, export the variable and run git in
> a subshell.
>
> [1]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
>      (Section 2.9.1: Simple Commands)
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  t/lib-parallel-checkout.sh          |  6 +++-
>  t/t2080-parallel-checkout-basics.sh | 50 +++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
> index 83b279a846..acaee9cbb6 100644
> --- a/t/lib-parallel-checkout.sh
> +++ b/t/lib-parallel-checkout.sh
> @@ -25,7 +25,11 @@ test_checkout_workers () {
>  
>  	local trace_file=trace-test-checkout-workers &&
>  	rm -f "$trace_file" &&
> -	GIT_TRACE2="$(pwd)/$trace_file" "$@" 2>&8 &&
> +	(
> +		GIT_TRACE2="$(pwd)/$trace_file" &&
> +		export GIT_TRACE2 &&
> +		"$@" 2>&8
> +	) &&
>  
>  	local workers="$(grep "child_start\[..*\] git checkout--worker" "$trace_file" | wc -l)" &&
>  	test $workers -eq $expected_workers &&
> diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
> index 3e0f8c675f..6fd7e4c4b2 100755
> --- a/t/t2080-parallel-checkout-basics.sh
> +++ b/t/t2080-parallel-checkout-basics.sh
> @@ -226,4 +226,54 @@ test_expect_success SYMLINKS 'parallel checkout checks for symlinks in leading d
>  	)
>  '
>  
> +# This test is here (and not in e.g. t2022-checkout-paths.sh), because we
> +# check the final report including sequential, parallel, and delayed entries
> +# all at the same time. So we must have finer control of the parallel checkout
> +# variables.
> +test_expect_failure PERL '"git checkout ." report should not include failed entries' '
> +	write_script rot13-filter.pl "$PERL_PATH" \
> +		<"$TEST_DIRECTORY"/t0021/rot13-filter.pl &&
> +
> +	test_config_global filter.delay.process \
> +		"\"$(pwd)/rot13-filter.pl\" --always-delay delayed.log clean smudge delay" &&
> +	test_config_global filter.delay.required true &&
> +	test_config_global filter.cat.clean cat  &&
> +	test_config_global filter.cat.smudge cat  &&
> +	test_config_global filter.cat.required true  &&
> +
> +	set_checkout_config 2 0 &&
> +	git init failed_entries &&
> +	(
> +		cd failed_entries &&
> +		cat >.gitattributes <<-EOF &&
> +		*delay*              filter=delay
> +		parallel-ineligible* filter=cat
> +		EOF
> +		echo a >missing-delay.a &&
> +		echo a >parallel-ineligible.a &&
> +		echo a >parallel-eligible.a &&
> +		echo b >success-delay.b &&
> +		echo b >parallel-ineligible.b &&
> +		echo b >parallel-eligible.b &&
> +		git add -A &&
> +		git commit -m files &&
> +
> +		a_blob="$(git rev-parse :parallel-ineligible.a)" &&
> +		dir="$(echo "$a_blob" | cut -c 1-2)" &&
> +		file="$(echo "$a_blob" | cut -c 3-)" &&

Can't this use test_oid_to_path?
> +		rm ".git/objects/$dir/$file" &&
> +		rm *.a *.b &&
> +
> +		test_checkout_workers 2 test_must_fail git checkout . 2>err &&
> +
> +		# All *.b entries should succeed and all *.a entries should fail:
> +		#  - missing-delay.a: the delay filter will drop this path
> +		#  - parallel-*.a: the blob will be missing
> +		#
> +		grep "Updated 3 paths from the index" err &&
> +		test "$(ls *.b | wc -l)" -eq 3 &&
> +		test "$(ls *.a | wc -l)" -eq 0

And this test_stdout_line_count?
