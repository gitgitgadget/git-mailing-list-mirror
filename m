Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF64C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D508722244
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/cewYGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390069AbgJTBgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 21:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390044AbgJTBgC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 21:36:02 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE92C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 18:36:02 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d23so74457pll.7
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 18:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Zi+dr3CoJr4SF5d61RRvIYpTNCqVXXtbmwEDGiME7w=;
        b=P/cewYGdpTgTaeEay5lefZKEE2QfJX0xJn6MIY4n/gkEFpUipVzx2iIrQvVSzEEM6q
         IiK8QUUpm3aOSLFZwI5GveUoa/QeorTvhAoyu9AwLZBArCw5RFUFcJCiyC//+9pYAfn+
         nKK+0JNtnv0tY0Qe6OHSGvfzKAPR5/LrjLBwSB7I+FoBZjNUsTW5bFSE+gEt80rLCNWw
         vWGOu4I078BT+DcrhAq+CYUsUw2anAvhLbQJNKnFqkIAmW4Z9IGCrNZrleURZYRPTIG3
         tFOSyyGOEZ5OKkroHUhW4mqQEwkXBcV7hHaWyz59LlO0Tbv4jS7s/KrG4U+Vfw2GO2Js
         o1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Zi+dr3CoJr4SF5d61RRvIYpTNCqVXXtbmwEDGiME7w=;
        b=sfWT3WArRgfXk3OVFEKqkSYTB90xakF0uGVal1pHghNG+fNmVYlFzTKof1NfOrhKPx
         fjMSb/mddJMNlskdO8Qw8M+uLT9IXh3UXL1JaS9vL8OR9s6uhe8K8PdpNA4STu9zhK6w
         YQ/gY9Jaf8vsFrSFwRagH0x7yJotzfi7xWiZmk6vceXQILQbqUXBy/mxfsWNJXJ1FijP
         Y27VrZMQwru+DXsoTB2k/82Kc7oYZw3YPLMd03HYVg2EgybIbceySV7XJRH6Jhiht54c
         mys43T31f8LfOHoek9fEWn0U0dTE5sc0MhtqrJAhsEr2MBSX859KvaurWGEoQThoDI18
         9zdw==
X-Gm-Message-State: AOAM530M/2c8ppZjgLqU3zNC8p0uc23+kM7AbnMkh6447rCqibSOZe76
        SAeQSpz3qgX6GexZJio+EOyq8J0wta0=
X-Google-Smtp-Source: ABdhPJyr1kTbWxadYUDmF+hwIFmvHNiL1I/rTmlTtrj4rbpWlTJSJjqtA4jVeVfOm5qktHrgjs5f/g==
X-Received: by 2002:a17:90b:891:: with SMTP id bj17mr561377pjb.219.1603157761689;
        Mon, 19 Oct 2020 18:36:01 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id y13sm186656pfl.166.2020.10.19.18.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:36:00 -0700 (PDT)
Date:   Mon, 19 Oct 2020 18:35:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        chriscool@tuxfamily.org, peff@peff.net, t.gummerer@gmail.com,
        newren@gmail.com
Subject: Re: [PATCH v2 16/19] parallel-checkout: add tests for basic
 operations
Message-ID: <20201020013558.GA15198@google.com>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
 <64b41d537e68a45f2bb0a0c3078f2cd314b5a57d.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64b41d537e68a45f2bb0a0c3078f2cd314b5a57d.1600814153.git.matheus.bernardino@usp.br>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Matheus Tavares wrote:

> Add tests to populate the working tree during clone and checkout using
> the sequential and parallel modes, to confirm that they produce
> identical results. Also test basic checkout mechanics, such as checking
> for symlinks in the leading directories and the abidance to --force.

Thanks for implementing parallel checkout!  I'm excited about the
feature.  And thanks for including these tests.

[...]
> --- /dev/null
> +++ b/t/lib-parallel-checkout.sh
> @@ -0,0 +1,39 @@
[...]
> +# Runs `git -c checkout.workers=$1 -c checkout.thesholdForParallelism=$2 ${@:4}`
> +# and checks that the number of workers spawned is equal to $3.
> +git_pc()

nit: what does git_pc mean?  Can this spell it out more verbosely, or
could callers take on more of the burden?  (Perhaps it would make sense
to use a helper that uses test_config to set the relevant configuration,
and then the caller can use plain "git clone"?)

[...]
> +	GIT_TRACE2="$(pwd)/trace" git \
> +		-c checkout.workers=$workers \
> +		-c checkout.thresholdForParallelism=$threshold \
> +		-c advice.detachedHead=0 \
> +		$@ &&

$@ needs to be quoted, or else it will act like $* (and in particular it
won't handle parameters with embedded spaces).

> +
> +	# Check that the expected number of workers has been used. Note that it
> +	# can be different than the requested number in two cases: when the
> +	# quantity of entries to be checked out is less than the number of
> +	# workers; and when the threshold has not been reached.
> +	#
> +	local workers_in_trace=$(grep "child_start\[.\+\] git checkout--helper" trace | wc -l) &&

Do we use grep's \+ operator in other tests?  I thought we preferred to
use the more portable *, but it may be that I'm out of date.

[...]
> +# Verify that both the working tree and the index were created correctly
> +verify_checkout()
> +{
> +	git -C $1 diff-index --quiet HEAD -- &&
> +	git -C $1 diff-index --quiet --cached HEAD -- &&
> +	git -C $1 status --porcelain >$1.status &&
> +	test_must_be_empty $1.status
> +}

Like git_pc, this is not easy to take in at a glance.

"$1" needs to be quoted if we are to handle paths with spaces.

[...]
> --- /dev/null
> +++ b/t/t2080-parallel-checkout-basics.sh
> @@ -0,0 +1,197 @@
> +#!/bin/sh
> +
> +test_description='parallel-checkout basics
> +
> +Ensure that parallel-checkout basically works on clone and checkout, spawning
> +the required number of workers and correctly populating both the index and
> +working tree.
> +'
> +
> +TEST_NO_CREATE_REPO=1
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
> +
> +# NEEDSWORK: cloning a SHA1 repo with GIT_TEST_DEFAULT_HASH set to "sha256"
> +# currently produces a wrong result (See
> +# https://lore.kernel.org/git/20200911151717.43475-1-matheus.bernardino@usp.br/).
> +# So we skip the "parallel-checkout during clone" tests when this test flag is
> +# set to "sha256". Remove this when the bug is fixed.
> +#
> +if test "$GIT_TEST_DEFAULT_HASH" = "sha256"
> +then
> +	skip_all="t2080 currently don't work with GIT_TEST_DEFAULT_HASH=sha256"
> +	test_done
> +fi
> +
> +R_BASE=$GIT_BUILD_DIR
> +
> +test_expect_success 'sequential clone' '
> +	git_pc 1 0 0 clone --quiet -- $R_BASE r_sequential &&

This fails when I run it when building from a tarball, which is
presenting me from releasing this patch series to Debian experimental.

Can we use an artificial repo instead of git.git?  Using git.git as
test data seems like a recipe for hard-to-reproduce test failures.

Thanks and hope that helps,
Jonathan
