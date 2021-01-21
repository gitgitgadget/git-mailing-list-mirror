Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5597FC433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 03:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C410238D7
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 03:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbhAUDrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:47:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64625 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730787AbhAUCjm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 21:39:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A4D6ACCBD;
        Wed, 20 Jan 2021 21:38:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7TJBYjKWOrnAzw0R9UbFaiFqdas=; b=Qk2w3I
        mFTqKh5cXRJ1VMonNXv6KZMTI1em0ORnkM47RGRPRHBnJCe2iQniR8ZNKmLtalb9
        alb1WFHCPDOvxk1vvxdvxk0ljONpPwqTm7MXgjmQ4aQjlz4pA3aSsu5qcGWZkO0A
        BU84H1I+4Av+DvFvsvKHdh7xrMiLZj+o4V5Uo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cs+oYcIX9lF3nSSYTo/2Q2eFoMSdej1n
        pzzSylN8bDiJy2WB1OiQCQpfjXdCO4ThL6e2yNywj3DxgxBjVu5FHvLBs+woFdZr
        bOUnCCrBDJzbL+p2iq1RecoTg9WvpdBMPPErKd6cUDzZzJLoIsAJAwR2WOWLRP5E
        igNxpSFpac0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90A99ACCBC;
        Wed, 20 Jan 2021 21:38:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13A76ACCBA;
        Wed, 20 Jan 2021 21:38:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/2] t7900: clean up some broken refs
References: <pull.838.git.1610940216.gitgitgadget@gmail.com>
        <pull.838.v2.git.1611060724.gitgitgadget@gmail.com>
        <35038dfd037f6da1e21c1d9f1a24b27cb7100598.1611060724.git.gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 18:38:45 -0800
In-Reply-To: <35038dfd037f6da1e21c1d9f1a24b27cb7100598.1611060724.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 19 Jan 2021
        12:52:04 +0000")
Message-ID: <xmqqczxzdney.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8BAA0A2-5B91-11EB-B1E0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The tests for the 'prefetch' task create remotes and fetch refs into
> 'refs/prefetch/<remote>/' and tags into 'refs/tags/'. These tests use
> the remotes to create objects not intended to be seen by the "local"
> repository.
>
> In that sense, the incrmental-repack tasks did not have these objects
> and refs in mind. That test replaces the object directory with a
> specific pack-file layout for testing the batch-size logic. However,
> this causes some operations to start showing warnings such as:
>
>  error: refs/prefetch/remote1/one does not point to a valid object!
>  error: refs/tags/one does not point to a valid object!

So we use prefetch refs but craft a repacking strategy in such a way
that these prefetch refs do not act as anchors, deliberately
breaking the repository and invalidating the prefetch refs so to
speak?

Wow, that sounds like an evil and brittle test set-up.

> This only shows up if you run the tests verbosely and watch the output.
> It caught my eye and I _thought_ that there was a bug where 'git gc' or
> 'git repack' wouldn't check 'refs/prefetch/' before pruning objects.
> That is incorrect. Those commands do handle 'refs/prefetch/' correctly.

> All that is left is to clean up the tests in t7900-maintenance.sh to
> remove these tags and refs that are not being repacked for the
> incremental-repack tests. Use update-ref to ensure this works with all
> ref backends.
>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t7900-maintenance.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index f9031cbb44b..78ccf4b33f8 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -256,6 +256,13 @@ test_expect_success 'incremental-repack task' '
>  	HEAD
>  	^HEAD~1
>  	EOF
> +
> +	# Delete refs that have not been repacked in these packs.
> +	git for-each-ref --format="delete %(refname)" \
> +		refs/prefetch refs/tags >refs &&
> +	git update-ref --stdin <refs &&
> +
> +	# Replace the object directory with this pack layout.
>  	rm -f $packDir/pack-* &&
>  	rm -f $packDir/loose-* &&
>  	ls $packDir/*.pack >packs-before &&
