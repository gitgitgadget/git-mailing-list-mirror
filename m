Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AB2C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 20:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5905360EBD
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 20:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhJYUuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbhJYUt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 16:49:58 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2D2C061348
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 13:47:35 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id o184so17323839iof.6
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YD/RvLC3Tb7kV6TFyP9XnHlvqMXdlJ1JOozOMuygt+0=;
        b=XVMHTBYaRxtctxMY4Q/DtnMPFNBgGdPj+kkv9QJIYBsauGWQOZrzizR8buMjAAp6sP
         LkR5qLRuvI+wZb4pzdVxw8Sltq2tv1hFbPy/Q+ERevIbrhY/9jDEgpxOMZcXE9YVOK3M
         oSQHBv2rrNvtB/yaAJgOHnkpz46KM8i9P6zHVgRl0COGGTUQMCWOERvHzVfqrqp/722V
         YOiLgADscft0KS8tjUo8m1RX4GDNwI6bycnL5O1kOsymVy51N0e0GN1rsvuEexCiSpEl
         8uOJF9wJ7ybZR0Mgl93H6a6iZGZz8n9UwFOpVtpo6Y5psVxIbycnJUsIMKI+9HaUeBu/
         dHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YD/RvLC3Tb7kV6TFyP9XnHlvqMXdlJ1JOozOMuygt+0=;
        b=DWGmqVoQXySmZNHtP+TNi7Ex7RihY1XA7ZdsV6eF4qP75jA2OyFXUStgKe/lFJyquT
         5W4QmqTcshKVr8/LRPa6h2gUT5xY8ZkGJ0viboVk4F4bsyvDZfeEds7GyP0c8bvYuMb7
         So/ZaEUwNNONXdvz86ilun+ueajLXYKP8+CGvEVlgo+L91vZjka56uDGtF1Q/NV8kU3/
         ZG4xh5+dt4lH5Gn8rel3S1iFxEq2s9f+aXtAkT48BDIve8XqmB6qFzxvV7blqImvXxBB
         7ftag4KfrYb8OWBKfr0xiBsuBHb7pg6nITqvEjpyWAfLo1hlRJD9+ySCWOidl4aNfIds
         Nq1g==
X-Gm-Message-State: AOAM5318T3e3EnMkYmDE4WtJSN4EkAXPsyQLbiyRH3Q4ni7C1Ryn8Lkz
        vLRQcbI76YVfI7il5rH4wt2Opw==
X-Google-Smtp-Source: ABdhPJwID9XJwbMqASNEewGJGJu4QZyj+LnxwIiHlezcprt+0DbjMRVpCCp5Yxm2UjFRbXxibR2vzA==
X-Received: by 2002:a05:6638:dcf:: with SMTP id m15mr1292579jaj.82.1635194855000;
        Mon, 25 Oct 2021 13:47:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p12sm6207617ilo.25.2021.10.25.13.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 13:47:34 -0700 (PDT)
Date:   Mon, 25 Oct 2021 16:47:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        newren@gmail.com, Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v2 1/2] diff: enable and test the sparse index
Message-ID: <YXcX5QWFQFIFNXo0@nand.local>
References: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
 <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
 <ac33159d020cc0c0f6fbee36eb74fff773cb8f9f.1634332836.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac33159d020cc0c0f6fbee36eb74fff773cb8f9f.1634332836.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 15, 2021 at 09:20:34PM +0000, Lessley Dennington via GitGitGadget wrote:
> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Enable the sparse index within the 'git diff' command. Its implementation
> already safely integrates with the sparse index because it shares code with
> the 'git status' and 'git checkout' commands that were already integrated.

Good, it looks like most of the heavy-lifting to make `git diff` work
with the sparse index was already done elsewhere.

It may be helpful here to include either one of two things to help
readers and reviewers understand what's going on:

  - A summary of what `git status` and/or `git checkout` does to work
    with the sparse index.
  - Or the patches which make those commands work with the sparse index
    so that readers can refer back to them.

Having either of those would help readers who are unfamiliar with
builtin/diff.c convince themselves more easily that setting
'command_requires_full_index = 0' is all that's needed here.

> The most interesting thing to do is to add tests that verify that 'git diff'
> behaves correctly when the sparse index is enabled. These cases are:
>
> 1. The index is not expanded for 'diff' and 'diff --staged'
> 2. 'diff' and 'diff --staged' behave the same in full checkout, sparse
> checkout, and sparse index repositories in the following partially-staged
> scenarios (i.e. the index, HEAD, and working directory differ at a given
> path):
>     1. Path is within sparse-checkout cone
>     2. Path is outside sparse-checkout cone
>     3. A merge conflict exists for paths outside sparse-checkout cone

Nice, these are all of the test cases that I would expect to demonstrate
interesting behavior.

> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index f19c1b3e2eb..e5d15be9d45 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -386,6 +386,46 @@ test_expect_success 'diff --staged' '
>  	test_all_match git diff --staged
>  '
>
> +test_expect_success 'diff partially-staged' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>$1
> +	EOF
> +
> +	# Add file within cone
> +	test_sparse_match git sparse-checkout set deep &&
> +	run_on_all ../edit-contents deep/testfile &&
> +	test_all_match git add deep/testfile &&
> +	run_on_all ../edit-contents deep/testfile &&
> +
> +	test_all_match git diff &&
> +	test_all_match git diff --staged &&
> +
> +	# Add file outside cone
> +	test_all_match git reset --hard &&
> +	run_on_all mkdir newdirectory &&
> +	run_on_all ../edit-contents newdirectory/testfile &&
> +	test_sparse_match git sparse-checkout set newdirectory &&
> +	test_all_match git add newdirectory/testfile &&
> +	run_on_all ../edit-contents newdirectory/testfile &&
> +	test_sparse_match git sparse-checkout set &&
> +
> +	test_all_match git diff &&
> +	test_all_match git diff --staged &&
> +
> +	# Merge conflict outside cone
> +	# The sparse checkout will report a warning that is not in the
> +	# full checkout, so we use `run_on_all` instead of
> +	# `test_all_match`
> +	run_on_all git reset --hard &&
> +	test_all_match git checkout merge-left &&
> +	test_all_match test_must_fail git merge merge-right &&
> +
> +	test_all_match git diff &&
> +	test_all_match git diff --staged
> +'
> +
>  # NEEDSWORK: sparse-checkout behaves differently from full-checkout when
>  # running this test with 'df-conflict-2' after 'df-conflict-1'.
>  test_expect_success 'diff with renames and conflicts' '
> @@ -800,6 +840,11 @@ test_expect_success 'sparse-index is not expanded' '
>  	# Wildcard identifies only full sparse directories, no index expansion
>  	ensure_not_expanded reset deepest -- folder\* &&
>
> +	echo a test change >>sparse-index/README.md &&
> +	ensure_not_expanded diff &&

Thinking aloud here as somebody who is unfamiliar with the sparse-index
tests. ensure_not_expanded relies on the existence of the "sparse-index"
repository, and its top-level README.md is outside of the
sparse-checkout cone.

That makes sense, and when I create a repository with a file outside of
the sparse-checkout cone and then run `git diff`, I see no changes as
expected.

But isn't the top-level directory always part of the cone? If so, I
think that what this (and the below test) is demonstrating is that we
can show changes inside of the cone without expanding the sparse-index.

Having that test makes absolute sense to me. But I think it might also
make sense to have a test that creates some directory structure outside
of the cone, modifies it, and then ensures that both (a) those changes
aren't visible to `git diff` when the sparse-checkout is active and (b)
that running `git diff` doesn't cause the sparse-index to be expanded.

Thanks,
Taylor
