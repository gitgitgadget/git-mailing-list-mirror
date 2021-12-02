Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D633C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 19:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376741AbhLBTUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 14:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376699AbhLBTUD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 14:20:03 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE0BC061758
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 11:16:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o29so589193wms.2
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 11:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zAlCpDVYujli+GY1dVyEtcdTFLG0UM1VMq4xENkphRs=;
        b=ThIMQtvjFvyy1rnraHTiVFK+SqTHR3u26IAFjX2Uxdf/e/mFV197vmi6Y3Sgc905Vj
         mw6hZWrEiNPrfTGYac+JDI0eh+Ftmwhah2q9tnjMaihsLQvLHesIj0jG4J5a7ZbkNrKi
         HRyvKbbb6KehSWwSIqQSWZnyn0uBP2DqBYCVBM3o5MQO573T469bomxbRGgJ2IhvrT7P
         KTvVB9tHngNNa116cJ7BiB5HLbCveqwSPBbNCXvrfWO3O+JeRtJvgrtBcSNT0LoevYth
         F79tQsqSst71KWJ8ik00dQ7vKYge960upXF6ByagH0eBREJi8+ZHD5qkZs2Ar04dog+q
         LSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zAlCpDVYujli+GY1dVyEtcdTFLG0UM1VMq4xENkphRs=;
        b=dBKY3vWxuUwtOtjNVJfIALEyFX8QmxajSq92DmpRz6uiptPEMY0SaM8yyDBiqnVjwz
         o/5ES5UKsdCkO8bov89lOrd95pS8POm/jaPAVEwS6+asidShdAP1SGivMKjfraWxU96s
         hr+e0rpDoEmJ0C0RLsVn1Etunte37hA2wITvqgvMAEorIG56ivxM8OswFkB7H0fmP3Lx
         3joPp6p+I88iQa5X6sdlbxlMw3nagC9z/sEd3l2Z5lYTj53FnNCWJ8h2P6Bg3jmR08M+
         ukaK2dQtj6NIBQSXY4m39vlSPHvkIqqlhwYQDfyDH/N57A5yXcnnCfdP59QSQUPhaSyc
         ee5g==
X-Gm-Message-State: AOAM532a8CMCpkai5RUKVZgVKF05qgGndRTlFlc34gkIA1pA8nEHdsUf
        plYn9L6/4RKcXMuSw8B5AYQ=
X-Google-Smtp-Source: ABdhPJzlqsl2+R2qhhOTZin/tMeBXpqS87J0/uBWqNovcVHKiOdsjjGk/XHeFp7DDjeefErsisAZ+w==
X-Received: by 2002:a7b:c8d5:: with SMTP id f21mr8790739wml.146.1638472597865;
        Thu, 02 Dec 2021 11:16:37 -0800 (PST)
Received: from szeder.dev (78-131-17-57.pool.digikabel.hu. [78.131.17.57])
        by smtp.gmail.com with ESMTPSA id b188sm458150wmd.45.2021.12.02.11.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:16:37 -0800 (PST)
Date:   Thu, 2 Dec 2021 20:16:35 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/2] t1510: remove need for "test_untraceable", retain
 coverage
Message-ID: <20211202191635.GB1991@szeder.dev>
References: <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
 <patch-v2-1.2-91402624777-20211201T200801Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-1.2-91402624777-20211201T200801Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 01, 2021 at 09:11:41PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Amend the tests checking whether stderr is empty added in
> 4868b2ea17b (Subject: setup: officially support --work-tree without
> --git-dir, 2011-01-19) work portably on all POSIX shells, instead
> suppressing the trace output with "test_untraceable" on shells that
> aren't bash.
> 
> The tests that used the "try_repo" helper wanted to check whether git
> commands invoked therein would emit anything on stderr. To do this
> they invoked the function and redirected the stderr to a "message"
> file.
> 
> In 58275069288 (t1510-repo-setup: mark as untraceable with '-x',
> 2018-02-24) these were made to use "test_untraceable" introduced in
> 5fc98e79fc0 (t: add means to disable '-x' tracing for individual test
> scripts, 2018-02-24).
> 
> It is better to have the "try_repo" function itself start with a
> "test_when_finished 'rm stderr'", and then redirect the stderr output
> from git commands it invokes via its helpers to a "stderr" file.
> 
> This means that if we have a failure it'll be closer to the source of
> the problem, and most importantly isn't incompatible with "-x" on
> shells that aren't "bash".
> 
> We also need to split those tests that had two "try_repo" invocations
> into different tests, which'll further help to narrow down any
> potential failures. This wasn't strictly necessary (an artifact of the
> use of "test_when_finished"), but the pattern enforces better test
> hygiene.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t1510-repo-setup.sh | 83 +++++++++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 43 deletions(-)
> 
> diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
> index 591505a39c0..f1748ac4a19 100755
> --- a/t/t1510-repo-setup.sh
> +++ b/t/t1510-repo-setup.sh
> @@ -40,9 +40,6 @@ A few rules for repo setup:
>      prefix is NULL.
>  "
>  
> -# This test heavily relies on the standard error of nested function calls.
> -test_untraceable=UnfortunatelyYes
> -
>  TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
> @@ -62,7 +59,7 @@ test_repo () {
>  			export GIT_WORK_TREE
>  		fi &&
>  		rm -f trace &&
> -		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
> +		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null 2>>stderr &&

I suspect that it's lines like this that make Peff argue for
BASH_XTRACEFD :)

While this is not a compound command, it does contain a command
substitution, and the trace generated when executing the command in
that command substitution goes to the command's stderr, and then,
because of the redirection, to the 'stderr' file.

I find it suspicious that this doesn't trigger a failure in a
'test_must_be_empty stderr' later on.

>  		grep '^setup: ' trace >result &&
>  		test_cmp expected result
>  	)
> @@ -72,7 +69,7 @@ maybe_config () {
>  	file=$1 var=$2 value=$3 &&
>  	if test "$value" != unset
>  	then
> -		git config --file="$file" "$var" "$value"
> +		git config --file="$file" "$var" "$value" 2>>stderr
>  	fi
>  }
>  
> @@ -80,7 +77,7 @@ setup_repo () {
>  	name=$1 worktreecfg=$2 gitfile=$3 barecfg=$4 &&
>  	sane_unset GIT_DIR GIT_WORK_TREE &&
>  
> -	git -c init.defaultBranch=initial init "$name" &&
> +	git -c init.defaultBranch=initial init "$name" 2>>stderr &&
>  	maybe_config "$name/.git/config" core.worktree "$worktreecfg" &&
>  	maybe_config "$name/.git/config" core.bare "$barecfg" &&
>  	mkdir -p "$name/sub/sub" &&
> @@ -210,10 +207,12 @@ run_wt_tests () {
>  #	(git dir) (work tree) (cwd) (prefix)	<-- from subdir
>  try_repo () {
>  	name=$1 worktreeenv=$2 gitdirenv=$3 &&
> +	test_when_finished "rm stderr" &&
>  	setup_repo "$name" "$4" "$5" "$6" &&
>  	shift 6 &&
>  	try_case "$name" "$worktreeenv" "$gitdirenv" \
>  		"$1" "$2" "$3" "$4" &&
> +	test_must_be_empty stderr &&
>  	shift 4 &&
>  	case "$gitdirenv" in
>  	/* | ?:/* | unset) ;;
> @@ -221,7 +220,8 @@ try_repo () {
>  		gitdirenv=../$gitdirenv ;;
>  	esac &&
>  	try_case "$name/sub" "$worktreeenv" "$gitdirenv" \
> -		"$1" "$2" "$3" "$4"
> +		"$1" "$2" "$3" "$4" &&
> +	test_must_be_empty stderr
>  }
>  
>  # Bit 0 = GIT_WORK_TREE
> @@ -234,15 +234,13 @@ try_repo () {
>  test_expect_success '#0: nonbare repo, no explicit configuration' '
>  	try_repo 0 unset unset unset "" unset \
>  		.git "$here/0" "$here/0" "(null)" \
> -		.git "$here/0" "$here/0" sub/ 2>message &&
> -	test_must_be_empty message
> +		.git "$here/0" "$here/0" sub/
>  '
>  
>  test_expect_success '#1: GIT_WORK_TREE without explicit GIT_DIR is accepted' '
>  	try_repo 1 "$here" unset unset "" unset \
>  		"$here/1/.git" "$here" "$here" 1/ \
> -		"$here/1/.git" "$here" "$here" 1/sub/ 2>message &&
> -	test_must_be_empty message
> +		"$here/1/.git" "$here" "$here" 1/sub/
>  '
>  
>  test_expect_success '#2: worktree defaults to cwd with explicit GIT_DIR' '
> @@ -268,19 +266,20 @@ test_expect_success '#4: core.worktree without GIT_DIR set is accepted' '
>  	mkdir -p 4/sub sub &&
>  	try_case 4 unset unset \
>  		.git "$here/4/sub" "$here/4" "(null)" \
> -		"$here/4/.git" "$here/4/sub" "$here/4/sub" "(null)" 2>message &&
> -	test_must_be_empty message
> +		"$here/4/.git" "$here/4/sub" "$here/4/sub" "(null)"
>  '
>  
> -test_expect_success '#5: core.worktree + GIT_WORK_TREE is accepted' '
> +test_expect_success '#5.1: core.worktree + GIT_WORK_TREE is accepted' '
>  	# or: you cannot intimidate away the lack of GIT_DIR setting
>  	try_repo 5 "$here" unset "$here/5" "" unset \
>  		"$here/5/.git" "$here" "$here" 5/ \
> -		"$here/5/.git" "$here" "$here" 5/sub/ 2>message &&
> +		"$here/5/.git" "$here" "$here" 5/sub/
> +'
> +
> +test_expect_success '#5.2: core.worktree + GIT_WORK_TREE is accepted' '
>  	try_repo 5a .. unset "$here/5a" "" unset \
>  		"$here/5a/.git" "$here" "$here" 5a/ \
> -		"$here/5a/.git" "$here/5a" "$here/5a" sub/ &&
> -	test_must_be_empty message
> +		"$here/5a/.git" "$here/5a" "$here/5a" sub/
>  '
>  
>  test_expect_success '#6: setting GIT_DIR brings core.worktree to life' '
> @@ -376,8 +375,7 @@ test_expect_success '#9: GIT_WORK_TREE accepted with gitfile' '
>  	mkdir -p 9/wt &&
>  	try_repo 9 wt unset unset gitfile unset \
>  		"$here/9.git" "$here/9/wt" "$here/9" "(null)" \
> -		"$here/9.git" "$here/9/sub/wt" "$here/9/sub" "(null)" 2>message &&
> -	test_must_be_empty message
> +		"$here/9.git" "$here/9/sub/wt" "$here/9/sub" "(null)"
>  '
>  
>  test_expect_success '#10: GIT_DIR can point to gitfile' '
> @@ -402,16 +400,14 @@ run_wt_tests 11 gitfile
>  test_expect_success '#12: core.worktree with gitfile is accepted' '
>  	try_repo 12 unset unset "$here/12" gitfile unset \
>  		"$here/12.git" "$here/12" "$here/12" "(null)" \
> -		"$here/12.git" "$here/12" "$here/12" sub/ 2>message &&
> -	test_must_be_empty message
> +		"$here/12.git" "$here/12" "$here/12" sub/
>  '
>  
>  test_expect_success '#13: core.worktree+GIT_WORK_TREE accepted (with gitfile)' '
>  	# or: you cannot intimidate away the lack of GIT_DIR setting
>  	try_repo 13 non-existent-too unset non-existent gitfile unset \
>  		"$here/13.git" "$here/13/non-existent-too" "$here/13" "(null)" \
> -		"$here/13.git" "$here/13/sub/non-existent-too" "$here/13/sub" "(null)" 2>message &&
> -	test_must_be_empty message
> +		"$here/13.git" "$here/13/sub/non-existent-too" "$here/13/sub" "(null)"
>  '
>  
>  # case #14.
> @@ -549,8 +545,7 @@ test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is accepted (ba
>  	mkdir -p 17b/.git/wt/sub &&
>  
>  	try_case 17a/.git "$here/17a" unset \
> -		"$here/17a/.git" "$here/17a" "$here/17a" .git/ \
> -		2>message &&
> +		"$here/17a/.git" "$here/17a" "$here/17a" .git/ &&
>  	try_case 17a/.git/wt "$here/17a" unset \
>  		"$here/17a/.git" "$here/17a" "$here/17a" .git/wt/ &&
>  	try_case 17a/.git/wt/sub "$here/17a" unset \
> @@ -565,14 +560,16 @@ test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is accepted (ba
>  
>  	try_repo 17c "$here/17c" unset unset "" true \
>  		.git "$here/17c" "$here/17c" "(null)" \
> -		"$here/17c/.git" "$here/17c" "$here/17c" sub/ 2>message &&
> -	test_must_be_empty message
> +		"$here/17c/.git" "$here/17c" "$here/17c" sub/
>  '
>  
> -test_expect_success '#18: bare .git named by GIT_DIR has no worktree' '
> +test_expect_success '#18.1: bare .git named by GIT_DIR has no worktree' '
>  	try_repo 18 unset .git unset "" true \
>  		.git "(null)" "$here/18" "(null)" \
> -		../.git "(null)" "$here/18/sub" "(null)" &&
> +		../.git "(null)" "$here/18/sub" "(null)"
> +'
> +
> +test_expect_success '#18.2: bare .git named by GIT_DIR has no worktree' '
>  	try_repo 18b unset "$here/18b/.git" unset "" true \
>  		"$here/18b/.git" "(null)" "$here/18b" "(null)" \
>  		"$here/18b/.git" "(null)" "$here/18b/sub" "(null)"
> @@ -590,12 +587,11 @@ test_expect_success '#20a: core.worktree without GIT_DIR accepted (inside .git)'
>  	setup_repo 20a "$here/20a" "" unset &&
>  	mkdir -p 20a/.git/wt/sub &&
>  	try_case 20a/.git unset unset \
> -		"$here/20a/.git" "$here/20a" "$here/20a" .git/ 2>message &&
> +		"$here/20a/.git" "$here/20a" "$here/20a" .git/ &&
>  	try_case 20a/.git/wt unset unset \
>  		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/ &&
>  	try_case 20a/.git/wt/sub unset unset \
> -		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/sub/ &&
> -	test_must_be_empty message
> +		"$here/20a/.git" "$here/20a" "$here/20a" .git/wt/sub/
>  '
>  
>  test_expect_success '#20b/c: core.worktree and core.bare conflict' '
> @@ -625,10 +621,9 @@ test_expect_success '#21: setup, core.worktree warns before overriding core.bare
>  		cd 21/.git &&
>  		GIT_WORK_TREE="$here/21" &&
>  		export GIT_WORK_TREE &&
> -		git status >/dev/null
> -	) 2>message &&
> -	test_must_be_empty message
> -
> +		git status 2>message &&
> +		test_must_be_empty message
> +	)
>  '
>  run_wt_tests 21
>  
> @@ -742,14 +737,16 @@ test_expect_success '#24: bare repo has no worktree (gitfile case)' '
>  test_expect_success '#25: GIT_WORK_TREE accepted if GIT_DIR unset (bare gitfile case)' '
>  	try_repo 25 "$here/25" unset unset gitfile true \
>  		"$here/25.git" "$here/25" "$here/25" "(null)"  \
> -		"$here/25.git" "$here/25" "$here/25" "sub/" 2>message &&
> -	test_must_be_empty message
> +		"$here/25.git" "$here/25" "$here/25" "sub/"
>  '
>  
> -test_expect_success '#26: bare repo has no worktree (GIT_DIR -> gitfile case)' '
> +test_expect_success '#26.1: bare repo has no worktree (GIT_DIR -> gitfile case)' '
>  	try_repo 26 unset "$here/26/.git" unset gitfile true \
>  		"$here/26.git" "(null)" "$here/26" "(null)" \
> -		"$here/26.git" "(null)" "$here/26/sub" "(null)" &&
> +		"$here/26.git" "(null)" "$here/26/sub" "(null)"
> +'
> +
> +test_expect_success '#26.2: bare repo has no worktree (GIT_DIR -> gitfile case)' '
>  	try_repo 26b unset .git unset gitfile true \
>  		"$here/26b.git" "(null)" "$here/26b" "(null)" \
>  		"$here/26b.git" "(null)" "$here/26b/sub" "(null)"
> @@ -779,9 +776,9 @@ test_expect_success '#29: setup' '
>  		cd 29 &&
>  		GIT_WORK_TREE="$here/29" &&
>  		export GIT_WORK_TREE &&
> -		git status
> -	) 2>message &&
> -	test_must_be_empty message
> +		git status 2>message &&
> +		test_must_be_empty message
> +	)
>  '
>  run_wt_tests 29 gitfile
>  
> -- 
> 2.34.1.876.gdb91009a90c
> 
