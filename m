Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DBB71F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfFXSzd (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:55:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56294 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbfFXSzd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:55:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0D5765F88;
        Mon, 24 Jun 2019 14:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X3wBPiS/eoThx48IwwLFiVOdxv8=; b=Ny9U9o
        SZ1Ys6c6/2RI7qxmfpW2rWdljXwY2DyBo5zCGrMRtzi/MfoFG+e66R1ShuFkeF3j
        2hOMgsvielxBL2v/1nQMrQcyewbpPVHnle4ScOFjzx4B7l7LGaHhxFWoIlyfNsuK
        5t+KWLVtly7psNfi0mcqZ9S8XkrMjlow9jX24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V/55yPgJWR0oA0IUBgUfzDLEoTKrc/Z4
        DZgw6r/P2upb3qSEX6jRYROAPMKHxf5DYdywJXTg4+cO4h0wR5Wv+7eRxikc2KEz
        kkurEQNfm5ySLn1EyWfufYoe8dKV74/s7kA4a1iYP3J4cRDIi480ykCB5eyy4V4S
        F27DBf1ZA18=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C3D2A65F86;
        Mon, 24 Jun 2019 14:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E639A65F85;
        Mon, 24 Jun 2019 14:55:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 1/1] t0001: fix on case-insensitive filesystems
References: <pull.151.v2.git.gitgitgadget@gmail.com>
        <pull.151.v3.git.gitgitgadget@gmail.com>
        <1f0ceee8687e9032a7777f764b34b1c9ccc68f38.1561379363.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1906241938450.44@tvgsbejvaqbjf.bet>
Date:   Mon, 24 Jun 2019 11:55:21 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906241938450.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 24 Jun 2019 19:40:05 +0200 (CEST)")
Message-ID: <xmqqftnyhkyu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F6C85EA-96B1-11E9-B9DA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On a case-insensitive filesystem, such as HFS+ or NTFS, it is possible
> that the idea Bash has of the current directory differs in case from
> what Git thinks it is. That's totally okay, though, and we should not
> expect otherwise.
>
> On Windows, for example, when you call
>
> 	cd C:\GIT-SDK-64
>
> in a PowerShell and there exists a directory called `C:\git-sdk-64`, the
> current directory will be reported in all upper-case. Even in a Bash
> that you might call from that PowerShell. Git, however, will have
> normalized this via `GetFinalPathByHandle()`, and the expectation in
> t0001 that the recorded gitdir will match what `pwd` says will be
> violated.
>
> Let's address this by comparing these paths in a case-insensitive
> manner when `core.ignoreCase` is `true`.
>
> Reported by Jameson Miller.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	Again, re-sending, as something in the mail (my guess is the
> 	non-ASCII character in Martin's surname) seems to upset vger so
> 	much that it drops the mail unceremoniously.

Hmph, but in the copy I am responding to, I can see non-ASCII
Martin's surname in the CC: header just fine, so vger may not
be at fault, perhaps?

In any case, cmp-fspath looks nicely implemented.  Will queue.

Thanks.

>
>  t/t0001-init.sh         | 22 ++++++++--------------
>  t/test-lib-functions.sh | 15 +++++++++++++++
>  2 files changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 42a263cada..b796fa25ac 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -310,8 +310,8 @@ test_expect_success 'init prefers command line to GIT_DIR' '
>  test_expect_success 'init with separate gitdir' '
>  	rm -rf newdir &&
>  	git init --separate-git-dir realgitdir newdir &&
> -	echo "gitdir: $(pwd)/realgitdir" >expected &&
> -	test_cmp expected newdir/.git &&
> +	newdir_git="$(cat newdir/.git)" &&
> +	test_cmp_fspath "$(pwd)/realgitdir" "${newdir_git#gitdir: }" &&
>  	test_path_is_dir realgitdir/refs
>  '
>
> @@ -360,12 +360,9 @@ test_expect_success 're-init on .git file' '
>  '
>
>  test_expect_success 're-init to update git link' '
> -	(
> -	cd newdir &&
> -	git init --separate-git-dir ../surrealgitdir
> -	) &&
> -	echo "gitdir: $(pwd)/surrealgitdir" >expected &&
> -	test_cmp expected newdir/.git &&
> +	git -C newdir init --separate-git-dir ../surrealgitdir &&
> +	newdir_git="$(cat newdir/.git)" &&
> +	test_cmp_fspath "$(pwd)/surrealgitdir" "${newdir_git#gitdir: }" &&
>  	test_path_is_dir surrealgitdir/refs &&
>  	test_path_is_missing realgitdir/refs
>  '
> @@ -373,12 +370,9 @@ test_expect_success 're-init to update git link' '
>  test_expect_success 're-init to move gitdir' '
>  	rm -rf newdir realgitdir surrealgitdir &&
>  	git init newdir &&
> -	(
> -	cd newdir &&
> -	git init --separate-git-dir ../realgitdir
> -	) &&
> -	echo "gitdir: $(pwd)/realgitdir" >expected &&
> -	test_cmp expected newdir/.git &&
> +	git -C newdir init --separate-git-dir ../realgitdir &&
> +	newdir_git="$(cat newdir/.git)" &&
> +	test_cmp_fspath "$(pwd)/realgitdir" "${newdir_git#gitdir: }" &&
>  	test_path_is_dir realgitdir/refs
>  '
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 80402a428f..26218a6c53 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -879,6 +879,21 @@ test_cmp_rev () {
>  	fi
>  }
>
> +# Compare paths respecting core.ignoreCase
> +test_cmp_fspath () {
> +	if test "x$1" = "x$2"
> +	then
> +		return 0
> +	fi
> +
> +	if test true != "$(git config --get --type=bool core.ignorecase)"
> +	then
> +		return 1
> +	fi
> +
> +	test "x$(echo "$1" | tr A-Z a-z)" =  "x$(echo "$2" | tr A-Z a-z)"
> +}
> +
>  # Print a sequence of integers in increasing order, either with
>  # two arguments (start and end):
>  #
> --
> gitgitgadget
