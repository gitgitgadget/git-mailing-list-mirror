Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A35BC433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 11:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9521C20866
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 11:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFVYN6Co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406867AbgJPLlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 07:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406863AbgJPLlE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 07:41:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5CBC061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 04:41:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e23so2139633wme.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 04:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K5shCBX2iuRdSgMOGF5QtdxyAUPV077CDW0QermwDlQ=;
        b=QFVYN6Co57QJDyS0R47v3+tjhtEhfjfTF0XhRdZqmkZwSYSoMaJUf/C/y9SuFpeeCQ
         XMYMlWqsvRYJj69Pr4EaNiXEsURU+Y6I1qjzIqN4YC1hrNqeKWpM5P2xuDelm4vBYnCG
         ks8DcBLpHf+267ODqeixO5S9wJBIW0zpsAnLgODjXVS++3f46I1ZaA4s8Gov6pqrPGPZ
         +rL9zD0NbtI0MWFSY+2D6hNCl/DSPpVBT4G8PH3C19J/6NsJkohVfwpHI9ZyTLzI2bYd
         7VClAvgEwsF4iAkbxaT1VbeKeUutMGm8dxrjnR8Kk5c1/5D7Bm1kwRoW7ORbmel1rivM
         NOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=K5shCBX2iuRdSgMOGF5QtdxyAUPV077CDW0QermwDlQ=;
        b=fBI4Z5dUEXDts0D9jhpd/XxuKUZY6zUyFSBuAqME8MHbHaUEXqYawsQOSHUES57RhP
         aOh35pBEnkyz7VHXEACHLbI68yQQL6WeXGnoQDfcBUV/medJnKuq4073CN5rWoTM2mN1
         8sHbTGBAI/FOMgDDihVXmx9sPX91gq5z52Lalc483SganGCOItGD81+uc91ErWHG/5Mq
         cf0gr7jBC9n0Z3+1Oc0k44A3p5E6o7IO6y2diMHMytrMLzSWAKhh+Lwz9/9J+ffU/fjZ
         iRvGpwUNWx9VMMr42C9lXyJrWREKuyfyphVhw43Lf0kiKE1JiTwGCnaFIya1yyNgvj4K
         fbBA==
X-Gm-Message-State: AOAM530Bp3KAAyGRft8MzkGYJUt2+1j2q7YPm2wL4CBP0P8ff3Uor5rB
        Dcedf8lCvR66YeRN0QTWSvM=
X-Google-Smtp-Source: ABdhPJzX47fSr8udYGvmQto6gIH6K9AqNblB3bFjQKnmQhdq12lxL2Yd20o4j+5QP8A5g21wJJYfzA==
X-Received: by 2002:a1c:4006:: with SMTP id n6mr3324620wma.46.1602848461488;
        Fri, 16 Oct 2020 04:41:01 -0700 (PDT)
Received: from [192.168.1.240] (48.45.90.146.dyn.plus.net. [146.90.45.48])
        by smtp.gmail.com with ESMTPSA id q5sm3406113wrs.54.2020.10.16.04.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 04:41:00 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/3] test-lib: allow selecting tests by substring/glob
 with --run
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
 <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
 <9c8b6a1a943261635fa09bed22ae36e368686f15.1602710025.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2b757512-793d-a6e0-0a50-368061e122dd@gmail.com>
Date:   Fri, 16 Oct 2020 12:40:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9c8b6a1a943261635fa09bed22ae36e368686f15.1602710025.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 14/10/2020 22:13, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Many of our test scripts have several "setup" tests.  It's a lot easier
> to say
> 
>     ./t0050-filesystem.sh --run=setup,9
> 
> in order to run all the setup tests as well as test #9, than it is to
> track down what all the setup tests are and enter all their numbers in
> the list.  Also, I often find myself wanting to run just one or a couple
> tests from the test file, but I don't know the numbering of any of the
> tests -- to get it I either have to first run the whole test file (or
> start counting by hand or figure out some other clever but non-obvious
> tricks).  It's really convenient to be able to just look at the test
> description(s) and then run
> 
>     ./t6416-recursive-corner-cases.sh --run=symlink
> 
> or
> 
>     ./t6402-merge-rename.sh --run='setup,unnecessary update'

The beginning of match_test_selector_list() looks like

match_test_selector_list () {
	title="$1"
	shift
	arg="$1"
	shift
	test -z "$1" && return 0

	# Both commas and whitespace are accepted as separators.
	OLDIFS=$IFS
	IFS=' 	,'
	set -- $1
	IFS=$OLDIFS

	# If the first selector is negative we include by default.
	include=
	case "$1" in
		!*) include=t ;;
	esac

	for selector
	do

If I'm reading it correctly the selectors are split on commas and 
whitespace which would mean we cannot match on "unnecessary update". I 
think we definitely want the ability to include whitespace in the 
selectors in order to be able to narrow down the tests that are run. I'm 
not sure that there is much value in splitting numbers on whitespace as 
it would mean the user has to quote them on the command line so we can 
probably just do 'IFS=,'. We'd also need to keep IFS as ',' in the case 
statement you add below as well rather than restoring it straight after 
the 'set' statement above.

Best Wishes

Phillip

> Add such an ability to test selection which relies on merely matching
> against the test description.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   t/README         | 29 +++++++++++++++++++----------
>   t/t0000-basic.sh | 41 +++++++++++++++++++++++++----------------
>   t/test-lib.sh    | 16 ++++++++++------
>   3 files changed, 54 insertions(+), 32 deletions(-)
> 
> diff --git a/t/README b/t/README
> index 2adaf7c2d2..0a8b60b5c7 100644
> --- a/t/README
> +++ b/t/README
> @@ -258,16 +258,13 @@ For an individual test suite --run could be used to specify that
>   only some tests should be run or that some tests should be
>   excluded from a run.
>   
> -The argument for --run is a list of individual test numbers or
> -ranges with an optional negation prefix that define what tests in
> -a test suite to include in the run.  A range is two numbers
> -separated with a dash and matches a range of tests with both ends
> -been included.  You may omit the first or the second number to
> -mean "from the first test" or "up to the very last test"
> -respectively.
> -
> -Optional prefix of '!' means that the test or a range of tests
> -should be excluded from the run.
> +The argument for --run, <test-selector>, is a list of description
> +substrings or globs or individual test numbers or ranges with an
> +optional negation prefix (of '!') that define what tests in a test
> +suite to include (or exclude, if negated) in the run.  A range is two
> +numbers separated with a dash and matches a range of tests with both
> +ends been included.  You may omit the first or the second number to
> +mean "from the first test" or "up to the very last test" respectively.
>   
>   If --run starts with an unprefixed number or range the initial
>   set of tests to run is empty. If the first item starts with '!'
> @@ -317,6 +314,18 @@ test in the test suite except from 7 up to 11:
>   
>       $ sh ./t9200-git-cvsexport-commit.sh --run='!7-11'
>   
> +Sometimes there may be multiple tests with e.g. "setup" in their name
> +that are needed and rather than figuring out the number for all of them
> +we can just use "setup" as a substring/glob to match against the test
> +description:
> +
> +    $ sh ./t0050-filesystem.sh --run=setup,9-11
> +
> +or one could select both the setup tests and the rename ones (assuming all
> +relevant tests had those words in their descriptions):
> +
> +    $ sh ./t0050-filesystem.sh --run=setup,rename
> +
>   Some tests in a test suite rely on the previous tests performing
>   certain actions, specifically some tests are designated as
>   "setup" test, so you cannot _arbitrarily_ disable one test and
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 923281af93..07105b2078 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -705,7 +705,31 @@ test_expect_success '--run empty selectors' "
>   	EOF
>   "
>   
> -test_expect_success '--run invalid range start' "
> +test_expect_success '--run substring selector' "
> +	run_sub_test_lib_test run-substring-selector \
> +		'--run empty selectors' \
> +		--run='relevant' <<-\\EOF &&
> +	test_expect_success \"relevant test\" 'true'
> +	for i in 1 2 3 4 5 6
> +	do
> +		test_expect_success \"other test #\$i\" 'true'
> +	done
> +	test_done
> +	EOF
> +	check_sub_test_lib_test run-substring-selector <<-\\EOF
> +	> ok 1 - relevant test
> +	> ok 2 # skip other test #1 (--run)
> +	> ok 3 # skip other test #2 (--run)
> +	> ok 4 # skip other test #3 (--run)
> +	> ok 5 # skip other test #4 (--run)
> +	> ok 6 # skip other test #5 (--run)
> +	> ok 7 # skip other test #6 (--run)
> +	> # passed all 7 test(s)
> +	> 1..7
> +	EOF
> +"
> +
> +test_expect_success '--run keyword selection' "
>   	run_sub_test_lib_test_err run-inv-range-start \
>   		'--run invalid range start' \
>   		--run='a-5' <<-\\EOF &&
> @@ -735,21 +759,6 @@ test_expect_success '--run invalid range end' "
>   	EOF_ERR
>   "
>   
> -test_expect_success '--run invalid selector' "
> -	run_sub_test_lib_test_err run-inv-selector \
> -		'--run invalid selector' \
> -		--run='1?' <<-\\EOF &&
> -	test_expect_success \"passing test #1\" 'true'
> -	test_done
> -	EOF
> -	check_sub_test_lib_test_err run-inv-selector \
> -		<<-\\EOF_OUT 3<<-\\EOF_ERR
> -	> FATAL: Unexpected exit with code 1
> -	EOF_OUT
> -	> error: --run: invalid non-numeric in test selector: '1?'
> -	EOF_ERR
> -"
> -
>   
>   test_set_prereq HAVEIT
>   haveit=no
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ef31f40037..a040d54a76 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -769,6 +769,8 @@ match_pattern_list () {
>   }
>   
>   match_test_selector_list () {
> +	operation="$1"
> +	shift
>   	title="$1"
>   	shift
>   	arg="$1"
> @@ -805,13 +807,13 @@ match_test_selector_list () {
>   			*-*)
>   				if expr "z${selector%%-*}" : "z[0-9]*[^0-9]" >/dev/null
>   				then
> -					echo "error: $title: invalid non-numeric in range" \
> +					echo "error: $operation: invalid non-numeric in range" \
>   						"start: '$orig_selector'" >&2
>   					exit 1
>   				fi
>   				if expr "z${selector#*-}" : "z[0-9]*[^0-9]" >/dev/null
>   				then
> -					echo "error: $title: invalid non-numeric in range" \
> +					echo "error: $operation: invalid non-numeric in range" \
>   						"end: '$orig_selector'" >&2
>   					exit 1
>   				fi
> @@ -819,9 +821,11 @@ match_test_selector_list () {
>   			*)
>   				if expr "z$selector" : "z[0-9]*[^0-9]" >/dev/null
>   				then
> -					echo "error: $title: invalid non-numeric in test" \
> -						"selector: '$orig_selector'" >&2
> -					exit 1
> +					case "$title" in *${selector}*)
> +						include=$positive
> +						;;
> +					esac
> +					continue
>   				fi
>   		esac
>   
> @@ -1031,7 +1035,7 @@ test_skip () {
>   		skipped_reason="GIT_SKIP_TESTS"
>   	fi
>   	if test -z "$to_skip" && test -n "$run_list" &&
> -	   ! match_test_selector_list '--run' $test_count "$run_list"
> +	   ! match_test_selector_list '--run' "$1" $test_count "$run_list"
>   	then
>   		to_skip=t
>   		skipped_reason="--run"
> 
