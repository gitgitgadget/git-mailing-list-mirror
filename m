Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC849C433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 20:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5FE6195A
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 20:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCSUfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 16:35:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56498 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCSUeg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 16:34:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 625F81181F7;
        Fri, 19 Mar 2021 16:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C7Z8cSSQu/aXJkzCwJhuv+je2sw=; b=g0aEoF
        mLPTqoCWYZ6GHZyaQX05jVlY3t1v5McooxGBsbBkJJYdlOkh3F+gO24GbJZI9Wgs
        lbsu3lnBkeKQKCHP1zMVDmRN0yrlBDuyXW60vYBQkSPdsF9oL21TMeYKfDExcMze
        5ebMeXC5h8cuhofPykI7M/YZm1JQF9F2OIFCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tugfOZc7lIF62HCwH8T2xBxAVK+rQXsk
        3fE6KyKRYxqfWgj12Vu7TX6ATU/X0CK4kWJGv1JSHr4a46Mjw3V1V0N/9GttPHWD
        tIzyh2gGT2VitCk2T4ktrNvk4clzbJju7tJFe703gya+0HFA5YAtCz25Mxy0L8Wt
        Yvf011FJMAc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 598E61181F6;
        Fri, 19 Mar 2021 16:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8756C1181F5;
        Fri, 19 Mar 2021 16:34:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "krush11 via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Krushnal Patel <krushnalpatel11@gmail.com>
Subject: Re: [PATCH v2 2/2] replaced test -f and test ! -f
References: <pull.982.git.git.1616147527082.gitgitgadget@gmail.com>
        <pull.982.v2.git.git.1616181893.gitgitgadget@gmail.com>
        <a31a147a34f809cb1eaa973890c7d50eb5a3ffb8.1616181893.git.gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 13:34:31 -0700
In-Reply-To: <a31a147a34f809cb1eaa973890c7d50eb5a3ffb8.1616181893.git.gitgitgadget@gmail.com>
        (krush's message of "Fri, 19 Mar 2021 19:24:53 +0000")
Message-ID: <xmqq5z1mnaqw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 839085BC-88F2-11EB-8E95-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"krush11 via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: krush11 <krushnalpatel11@gmail.com>
>
> test -f relates to 'must exist as a file' and similarly,
> test ! -f relates to 'must not exist as a file'.
> So, test -f can be replaced with test_path_exists and test ! -f can be replaced by test_path_is_missing.
>
> Signed-off-by: Krushnal Patel <krushnalpatel11@gmail.com>
> ---
>  t/t7300-clean.sh | 376 +++++++++++++++++++++++------------------------
>  1 file changed, 188 insertions(+), 188 deletions(-)

A few comments.

 * Your "From:" authorship and "Signed-off-by:" authorship should
   match.  As Documentation/SubmittingPatches states, we require
   real name for sign-off, you'd need to correct the "From:" side.

 * I do not think it makes sense for this topic to be two-patch
   series.  We do nto want to first go from "test -f" to
   "test_path_is_file" and then to "test_path_exists", while doing
   nothing to "! test -f" in the first step and later to "missing".
   Perhaps squash them into a single patch with an updated message
   and force push before re-submitting the GitHub PR?

 * The rationale given for this step does not make much sense.  The
   first two sentences are not wrong per-se, but we should make it
   clear that we are NOT claiming that "test -f" is used for "must
   not be missing" in general.  E.g.

	The tests in this script use "test -f" when it wants to make
	sure a path that "git clean" should not remove is still
	there, and "! test -f" (or "test ! -f") when it wants to
	make sure a path that should be removed is indeed gone.

	Replace them with test_path_exists and test_path_is_missing
	to clarify the expectation.  It also makes any failed
	expectation stand out and easier to spot to se these test
	helpers.

   or something like that, perhaps.

Thanks.

> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index a599c4210085..d1777ff084e6 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -28,15 +28,15 @@ test_expect_success 'git clean with skip-worktree .gitignore' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test_path_is_file obj.o &&
> -	test_path_is_file build/lib.so &&
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_exists obj.o &&
> +	test_path_exists build/lib.so &&
>  	git update-index --no-skip-worktree .gitignore &&
>  	git checkout .gitignore
>  '
> @@ -46,15 +46,15 @@ test_expect_success 'git clean' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test_path_is_file obj.o &&
> -	test_path_is_file build/lib.so
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_exists obj.o &&
> +	test_path_exists build/lib.so
>  
>  '
>  
> @@ -63,15 +63,15 @@ test_expect_success 'git clean src/' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean src/ &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test_path_is_file a.out &&
> -	test ! -f src/part3.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test_path_is_file obj.o &&
> -	test_path_is_file build/lib.so
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_exists a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_exists obj.o &&
> +	test_path_exists build/lib.so
>  
>  '
>  
> @@ -80,15 +80,15 @@ test_expect_success 'git clean src/ src/' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean src/ src/ &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test_path_is_file a.out &&
> -	test ! -f src/part3.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test_path_is_file obj.o &&
> -	test_path_is_file build/lib.so
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_exists a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_exists obj.o &&
> +	test_path_exists build/lib.so
>  
>  '
>  
> @@ -97,16 +97,16 @@ test_expect_success 'git clean with prefix' '
>  	mkdir -p build docs src/test &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so src/test/1.c &&
>  	(cd src/ && git clean) &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test_path_is_file a.out &&
> -	test ! -f src/part3.c &&
> -	test_path_is_file src/test/1.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test_path_is_file obj.o &&
> -	test_path_is_file build/lib.so
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_exists a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_exists src/test/1.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_exists obj.o &&
> +	test_path_exists build/lib.so
>  
>  '
>  
> @@ -162,16 +162,16 @@ test_expect_success 'git clean -d with prefix and path' '
>  	mkdir -p build docs src/feature &&
>  	touch a.out src/part3.c src/feature/file.c docs/manual.txt obj.o build/lib.so &&
>  	(cd src/ && git clean -d feature/) &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test_path_is_file a.out &&
> -	test_path_is_file src/part3.c &&
> -	test ! -f src/feature/file.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test_path_is_file obj.o &&
> -	test_path_is_file build/lib.so
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_exists a.out &&
> +	test_path_exists src/part3.c &&
> +	test_path_is_missing src/feature/file.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_exists obj.o &&
> +	test_path_exists build/lib.so
>  
>  '
>  
> @@ -181,16 +181,16 @@ test_expect_success SYMLINKS 'git clean symbolic link' '
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	ln -s docs/manual.txt src/part4.c &&
>  	git clean &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test ! -f src/part4.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test_path_is_file obj.o &&
> -	test_path_is_file build/lib.so
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_missing src/part4.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_exists obj.o &&
> +	test_path_exists build/lib.so
>  
>  '
>  
> @@ -198,13 +198,13 @@ test_expect_success 'git clean with wildcard' '
>  
>  	touch a.clean b.clean other.c &&
>  	git clean "*.clean" &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test ! -f a.clean &&
> -	test ! -f b.clean &&
> -	test_path_is_file other.c
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_is_missing a.clean &&
> +	test_path_is_missing b.clean &&
> +	test_path_exists other.c
>  
>  '
>  
> @@ -213,15 +213,15 @@ test_expect_success 'git clean -n' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -n &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test_path_is_file a.out &&
> -	test_path_is_file src/part3.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test_path_is_file obj.o &&
> -	test_path_is_file build/lib.so
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_exists a.out &&
> +	test_path_exists src/part3.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_exists obj.o &&
> +	test_path_exists build/lib.so
>  
>  '
>  
> @@ -230,15 +230,15 @@ test_expect_success 'git clean -d' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -d &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
>  	test ! -d docs &&
> -	test_path_is_file obj.o &&
> -	test_path_is_file build/lib.so
> +	test_path_exists obj.o &&
> +	test_path_exists build/lib.so
>  
>  '
>  
> @@ -247,16 +247,16 @@ test_expect_success 'git clean -d src/ examples/' '
>  	mkdir -p build docs examples &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so examples/1.c &&
>  	git clean -d src/ examples/ &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test_path_is_file a.out &&
> -	test ! -f src/part3.c &&
> -	test ! -f examples/1.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test_path_is_file obj.o &&
> -	test_path_is_file build/lib.so
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_exists a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_is_missing examples/1.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_exists obj.o &&
> +	test_path_exists build/lib.so
>  
>  '
>  
> @@ -265,15 +265,15 @@ test_expect_success 'git clean -x' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -x &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test ! -f obj.o &&
> -	test_path_is_file build/lib.so
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_is_missing obj.o &&
> +	test_path_exists build/lib.so
>  
>  '
>  
> @@ -282,14 +282,14 @@ test_expect_success 'git clean -d -x' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -d -x &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
>  	test ! -d docs &&
> -	test ! -f obj.o &&
> +	test_path_is_missing obj.o &&
>  	test ! -d build
>  
>  '
> @@ -299,14 +299,14 @@ test_expect_success 'git clean -d -x with ignored tracked directory' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -d -x -e src &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test ! -f a.out &&
> -	test_path_is_file src/part3.c &&
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_exists src/part3.c &&
>  	test ! -d docs &&
> -	test ! -f obj.o &&
> +	test_path_is_missing obj.o &&
>  	test ! -d build
>  
>  '
> @@ -316,15 +316,15 @@ test_expect_success 'git clean -X' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -X &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test_path_is_file a.out &&
> -	test_path_is_file src/part3.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test ! -f obj.o &&
> -	test_path_is_file build/lib.so
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_exists a.out &&
> +	test_path_exists src/part3.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_is_missing obj.o &&
> +	test_path_exists build/lib.so
>  
>  '
>  
> @@ -333,14 +333,14 @@ test_expect_success 'git clean -d -X' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -d -X &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test_path_is_file a.out &&
> -	test_path_is_file src/part3.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test ! -f obj.o &&
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_exists a.out &&
> +	test_path_exists src/part3.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_is_missing obj.o &&
>  	test ! -d build
>  
>  '
> @@ -350,14 +350,14 @@ test_expect_success 'git clean -d -X with ignored tracked directory' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -d -X -e src &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test_path_is_file a.out &&
> -	test ! -f src/part3.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test ! -f obj.o &&
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_exists a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_is_missing obj.o &&
>  	test ! -d build
>  
>  '
> @@ -381,29 +381,29 @@ test_expect_success 'clean.requireForce and -n' '
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>  	git clean -n &&
> -	test_path_is_file Makefile &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test_path_is_file a.out &&
> -	test_path_is_file src/part3.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test_path_is_file obj.o &&
> -	test_path_is_file build/lib.so
> +	test_path_exists Makefile &&
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_exists a.out &&
> +	test_path_exists src/part3.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_exists obj.o &&
> +	test_path_exists build/lib.so
>  
>  '
>  
>  test_expect_success 'clean.requireForce and -f' '
>  
>  	git clean -f &&
> -	test_path_is_file README &&
> -	test_path_is_file src/part1.c &&
> -	test_path_is_file src/part2.c &&
> -	test ! -f a.out &&
> -	test ! -f src/part3.c &&
> -	test_path_is_file docs/manual.txt &&
> -	test_path_is_file obj.o &&
> -	test_path_is_file build/lib.so
> +	test_path_exists README &&
> +	test_path_exists src/part1.c &&
> +	test_path_exists src/part2.c &&
> +	test_path_is_missing a.out &&
> +	test_path_is_missing src/part3.c &&
> +	test_path_exists docs/manual.txt &&
> +	test_path_exists obj.o &&
> +	test_path_exists build/lib.so
>  
>  '
>  
> @@ -446,10 +446,10 @@ test_expect_success 'nested git work tree' '
>  		test_commit deeply.nested deeper.world
>  	) &&
>  	git clean -f -d &&
> -	test_path_is_file foo/.git/index &&
> -	test_path_is_file foo/hello.world &&
> -	test_path_is_file baz/boo/.git/index &&
> -	test_path_is_file baz/boo/deeper.world &&
> +	test_path_exists foo/.git/index &&
> +	test_path_exists foo/hello.world &&
> +	test_path_exists baz/boo/.git/index &&
> +	test_path_exists baz/boo/deeper.world &&
>  	! test -d bar
>  '
>  
> @@ -488,12 +488,12 @@ test_expect_success 'should not clean submodules' '
>  	git checkout before_sub2 &&
>  	>to_clean/should_clean.this &&
>  	git clean -f -d &&
> -	test_path_is_file repo/.git/index &&
> -	test_path_is_file repo/hello.world &&
> -	test_path_is_file sub1/.git &&
> -	test_path_is_file sub1/hello.world &&
> -	test_path_is_file sub2/.git &&
> -	test_path_is_file sub2/hello.world &&
> +	test_path_exists repo/.git/index &&
> +	test_path_exists repo/hello.world &&
> +	test_path_exists sub1/.git &&
> +	test_path_exists sub1/hello.world &&
> +	test_path_exists sub2/.git &&
> +	test_path_exists sub2/hello.world &&
>  	test_path_is_missing to_clean
>  '
>  
> @@ -506,8 +506,8 @@ test_expect_success POSIXPERM,SANITY 'should avoid cleaning possible submodules'
>  	chmod 0 possible_sub1/.git &&
>  	>to_clean/should_clean.this &&
>  	git clean -f -d &&
> -	test_path_is_file possible_sub1/.git &&
> -	test_path_is_file possible_sub1/hello.world &&
> +	test_path_exists possible_sub1/.git &&
> +	test_path_exists possible_sub1/hello.world &&
>  	test_path_is_missing to_clean
>  '
>  
> @@ -517,7 +517,7 @@ test_expect_success 'nested (empty) git should be kept' '
>  	mkdir to_clean &&
>  	>to_clean/should_clean.this &&
>  	git clean -f -d &&
> -	test_path_is_file empty_repo/.git/HEAD &&
> +	test_path_exists empty_repo/.git/HEAD &&
>  	test_path_is_missing to_clean
>  '
>  
> @@ -559,9 +559,9 @@ test_expect_success 'giving path in nested git work tree will NOT remove it' '
>  		test_commit msg bar/baz/hello.world
>  	) &&
>  	git clean -f -d repo/bar/baz &&
> -	test_path_is_file repo/.git/HEAD &&
> +	test_path_exists repo/.git/HEAD &&
>  	test_path_is_dir repo/bar/ &&
> -	test_path_is_file repo/bar/baz/hello.world
> +	test_path_exists repo/bar/baz/hello.world
>  '
>  
>  test_expect_success 'giving path to nested .git will not remove it' '
> @@ -573,7 +573,7 @@ test_expect_success 'giving path to nested .git will not remove it' '
>  		test_commit msg hello.world
>  	) &&
>  	git clean -f -d repo/.git &&
> -	test_path_is_file repo/.git/HEAD &&
> +	test_path_exists repo/.git/HEAD &&
>  	test_path_is_dir repo/.git/refs &&
>  	test_path_is_dir repo/.git/objects &&
>  	test_path_is_dir untracked/
> @@ -589,7 +589,7 @@ test_expect_success 'giving path to nested .git/ will NOT remove contents' '
>  	) &&
>  	git clean -f -d repo/.git/ &&
>  	test_path_is_dir repo/.git &&
> -	test_path_is_file repo/.git/HEAD &&
> +	test_path_exists repo/.git/HEAD &&
>  	test_path_is_dir untracked/
>  '
>  
> @@ -663,11 +663,11 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
>  	touch foo/bar foo/baz foo/a/aa/ignoreme foo/b/ignoreme foo/b/bb/1 foo/b/bb/2 &&
>  	git clean -df &&
>  	test_path_is_dir foo &&
> -	test_path_is_file foo/bar &&
> +	test_path_exists foo/bar &&
>  	test_path_is_missing foo/baz &&
> -	test_path_is_file foo/a/aa/ignoreme &&
> +	test_path_exists foo/a/aa/ignoreme &&
>  	test_path_is_missing foo/a/aa/aaa &&
> -	test_path_is_file foo/b/ignoreme &&
> +	test_path_exists foo/b/ignoreme &&
>  	test_path_is_missing foo/b/bb
>  '
>  
> @@ -688,9 +688,9 @@ test_expect_success 'git clean -d skips nested repo containing ignored files' '
>  
>  	git clean -fd &&
>  
> -	test_path_is_file nested-repo-with-ignored-file/.git/index &&
> -	test_path_is_file nested-repo-with-ignored-file/ignoreme &&
> -	test_path_is_file nested-repo-with-ignored-file/file
> +	test_path_exists nested-repo-with-ignored-file/.git/index &&
> +	test_path_exists nested-repo-with-ignored-file/ignoreme &&
> +	test_path_exists nested-repo-with-ignored-file/file
>  '
>  
>  test_expect_success 'git clean handles being told what to clean' '
