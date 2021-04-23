Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFABC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1C4611C2
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhDWTSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWTSx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:18:53 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643E3C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 12:18:16 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id o2so23777162qtr.4
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HYq9661nXM314E9jNktr9Bn8rvPh/8VILzZAJJpscBY=;
        b=lS5vZiEhds4zqx2TOc8tVce3D/4gOKnqnbeXG52k5Vkb0mkqdlK52CNQFZZQuj41BN
         rvizeV1hpMwGeblTZIqsUwrmGCiQTf5tQkpL8+yN5ilgy3cKi9AivINdC0HwyouM3rwe
         YF42f3sKXJ5qu/2KY20J6CyPbUiFfnR9R22ciXozeCg1RXMZBN1Jxq8S4MPMNIEhSEMV
         2tzUe+KFQgwSxZFN8TPwwC2yCthzoiRUq0KAQGPbi0oJ7jRduXIbXxgwP6XX95MdORiM
         qlKNJ3FIQIRxA3PZ2D1sOuLI7A6LLKV/6xYGDZ4YBkabYNYdzUNPHU39ZCNqX9Aw4xND
         bMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HYq9661nXM314E9jNktr9Bn8rvPh/8VILzZAJJpscBY=;
        b=t2ZogkbXw9W74A3OcT5OKuztlx+7S89ZZ0xAwjTdCD32bi1No725SGSU97VBA8rJ8I
         XLpYYKoO1Q20m88Xh7l0i/CLfXNMVkjKng8gy57lHePQdaynxBMNDSbdwarL8/jvGw4G
         4gk/CI55cUY3vpKH4VPDnXNR6sCoodOugfJzzMW5xLHLdTdcEyGmcD5YPVLAzIpk18Oh
         +PwSSTHzLA/4g3Kmito7RdthRcWNN2BA/Mq/0X4MY4f/S5SRDLBrQzvXRtkCvqu6KStU
         /Stx1bce4w0OGSEP2nQRWazU+pJcQMzGOZ4cNr6pPKIxYw0fBj5BRsrEhkdmYmbH39/k
         k2IA==
X-Gm-Message-State: AOAM533FzLIzxGHvCFDc5mCtMG72EoGsr8rdwXRhQ551FFsvMn9cG1v/
        iv5TSXwr8c8ANAUcMSH4428=
X-Google-Smtp-Source: ABdhPJxihWLW83xC9xQdIJW0zlcUxnTsiDodwrQdRYB0Ap5FoMrMmeyyaaXCHtLbZLXk3H31NJ/GMg==
X-Received: by 2002:ac8:7ed1:: with SMTP id x17mr5290043qtj.192.1619205495490;
        Fri, 23 Apr 2021 12:18:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3de1:cfe2:170e:4cb9? ([2600:1700:e72:80a0:3de1:cfe2:170e:4cb9])
        by smtp.gmail.com with ESMTPSA id b20sm4932194qkn.111.2021.04.23.12.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 12:18:14 -0700 (PDT)
Subject: Re: [PATCH 4/7] parallel-checkout: add tests for basic operations
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com,
        Jonathan Nieder <jrnieder@gmail.com>
References: <cover.1619104091.git.matheus.bernardino@usp.br>
 <6379b8df6a59361dd44733e379880a11c6cd977c.1619104091.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1b1cdef5-7d90-c6f3-ea8d-e1c9d472ffff@gmail.com>
Date:   Fri, 23 Apr 2021 15:18:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <6379b8df6a59361dd44733e379880a11c6cd977c.1619104091.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/22/2021 11:17 AM, Matheus Tavares wrote:
> Add tests to populate the working tree during clone and checkout using
> sequential and parallel mode, to confirm that they produce identical
> results. Also test basic checkout mechanics, such as checking for
> symlinks in the leading directories and the abidance to --force.
> 
> Note: some helper functions are added to a common lib file which is only
> included by t2080 for now. But they will also be used by other
> parallel-checkout tests in the following patches.
> 
> Original-patch-by: Jeff Hostetler <jeffhost@microsoft.com>

Is this a standard thing? Or, did you change the patch significantly
enough that "Co-authored-by:" is no longer appropriate?

> +++ b/t/lib-parallel-checkout.sh
> @@ -0,0 +1,37 @@
> +# Helpers for t208* tests

I could see tests outside of the t208* range possibly having
value in interacting with parallel checkout in the future.

Perhaps:

	# Helpers for tests invoking parallel-checkout

> +
> +set_checkout_config () {
> +	if test $# -ne 2
> +	then
> +		BUG "set_checkout_config() requires two arguments"
> +	fi &&

A usage comment is typically helpful for these helpers:

# set_checkout_config <workers> <threshold>
# sets global config values to use the given number of
# workers when the given threshold is met.

> +
> +	test_config_global checkout.workers $1 &&
> +	test_config_global checkout.thresholdForParallelism $2
> +}
> +
> +# Run "${@:2}" and check that $1 checkout workers were used
> +test_checkout_workers () {

This simpler doc style works, too.

> +	if test $# -lt 2
> +	then
> +		BUG "too few arguments to test_checkout_workers()"
> +	fi &&
> +
> +	expected_workers=$1 &&
> +	shift &&
> +
> +	rm -f trace &&
> +	GIT_TRACE2="$(pwd)/trace" "$@" &&
> +
> +	workers=$(grep "child_start\[..*\] git checkout--worker" trace | wc -l) &&
> +	test $workers -eq $expected_workers &&
> +	rm -f trace

I wonder if this should be a "test_when_finished rm -f trace" being
recorded earlier in the step. It would also benefit from using a more
specific name than "trace". Something like "trace-test-checkout-workers"
would be unlikely to collide with someone else's trace.

> +# Verify that both the working tree and the index were created correctly
> +verify_checkout () {

Add usage of a repo in $1?

> +	git -C "$1" diff-index --quiet HEAD -- &&
> +	git -C "$1" diff-index --quiet --cached HEAD -- &&
> +	git -C "$1" status --porcelain >"$1".status &&
> +	test_must_be_empty "$1".status
> +}


> +TEST_NO_CREATE_REPO=1
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
> +
> +# Test parallel-checkout with a branch switch containing file creations,
> +# deletions, and modification; with different entry types. Switching from B1 to
> +# B2 will have the following changes:
> +#
> +# - a (file):      modified
> +# - e/x (file):    deleted
> +# - b (symlink):   deleted
> +# - b/f (file):    created
> +# - e (symlink):   created
> +# - d (submodule): created
> +#

An interesting set of changes. What about a directory/file conflict?

Something like this might be useful:

 # - f/t (file):   deleted
 # - f (file):     created

in fact, it could be interesting to have a file conflict with each
of these types, such as the symlink 'e' and the submodule 'd'.

While we are at it, what about a symlink/submodule conflict? I know
it makes the test bigger, but doing everything simultaneously through
a carefully designed repository helps prevent test case bloat.

> +test_expect_success SYMLINKS 'setup repo for checkout with various types of changes' '

Could we split this setup step into two parts? Once could
set up everything except the symlinks and would not require
the SYMLINKS prereq. We could then have another test with
the SYMLINKS prereq that extends B1 and B2 to have symlinks
and their conflicts. The remaining tests would work on any
platform without needing the SYMLINKS prereq.

> +test_expect_success SYMLINKS 'sequential checkout' '
> +	cp -R various various_sequential &&
> +	set_checkout_config 1 0 &&
> +	test_checkout_workers 0 \
> +		git -C various_sequential checkout --recurse-submodules B2 &&
> +	verify_checkout various_sequential
> +'

I see all these tests are very similar. Perhaps group
them to demonstrate their differences?

parallel_test_case () {
	test_expect_success "$1" "
		cp -R various $2 &&
		set_checkout_config $3 $4 &&
		test_checkout_workers $5 \
			git -C $2 checkout --recurse-submodules B2 &&
		verify_checkout $2
	"
}

parallel_test_case 'sequential checkout' \
	various_sequential 1 0 0
parallel_test_case 'parallel checkout' \
	various_parallel 2 0 2
parallel_test_case 'fallback to sequential checkout (threshold)' \
	various_sequential_fallback 2 100 0

> +test_expect_success SYMLINKS 'parallel checkout on clone' '
> +	git -C various checkout --recurse-submodules B2 &&
> +	set_checkout_config 2 0 &&
> +	test_checkout_workers 2 \
> +		git clone --recurse-submodules various various_parallel_clone &&
> +	verify_checkout various_parallel_clone
> +'
> +
> +test_expect_success SYMLINKS 'fallback to sequential checkout on clone (threshold)' '
> +	git -C various checkout --recurse-submodules B2 &&
> +	set_checkout_config 2 100 &&
> +	test_checkout_workers 0 \
> +		git clone --recurse-submodules various various_sequential_fallback_clone &&
> +	verify_checkout various_sequential_fallback_clone
> +'

Doing a similar grouping for the clone case might be interesting,
if only for the possible future where more customization might be
necessary.

Since the clone case is only caring about the contents at B2, it
is good that B2 contains one of each type of entry.

> +# Just to be paranoid, actually compare the working trees' contents directly.
> +test_expect_success SYMLINKS 'compare the working trees' '
> +	rm -rf various_*/.git &&
> +	rm -rf various_*/d/.git &&
> +
> +	diff -r various_sequential various_parallel &&
> +	diff -r various_sequential various_sequential_fallback &&
> +	diff -r various_sequential various_parallel_clone &&
> +	diff -r various_sequential various_sequential_fallback_clone
> +'
> +
> +test_expect_success 'parallel checkout respects --[no]-force' '
> +	set_checkout_config 2 0 &&
> +	git init dirty &&
> +	(
> +		cd dirty &&
> +		mkdir D &&
> +		test_commit D/F &&
> +		test_commit F &&
> +
> +		rm -rf D &&
> +		echo changed >D &&
> +		echo changed >F.t &&
> +
> +		# We expect 0 workers because there is nothing to be done
> +		test_checkout_workers 0 git checkout HEAD &&
> +		test_path_is_file D &&
> +		grep changed D &&
> +		grep changed F.t &&
> +
> +		test_checkout_workers 2 git checkout --force HEAD &&
> +		test_path_is_dir D &&
> +		grep D/F D/F.t &&
> +		grep F F.t
> +	)
> +'

I see SYMLINKS is not necessary here due to creating a new repo.
Still better to not have the prereq when not necessary.

> +test_expect_success SYMLINKS 'parallel checkout checks for symlinks in leading dirs' '
> +	set_checkout_config 2 0 &&
> +	git init symlinks &&
> +	(
> +		cd symlinks &&
> +		mkdir D untracked &&
> +		# Commit 2 files to have enough work for 2 parallel workers
> +		test_commit D/A &&
> +		test_commit D/B &&
> +		rm -rf D &&
> +		ln -s untracked D &&
> +
> +		test_checkout_workers 2 git checkout --force HEAD &&
> +		! test -h D &&
> +		grep D/A D/A.t &&
> +		grep D/B D/B.t
> +	)
> +'

This test can continue to require SYMLINKS.

Thanks,
-Stolee
