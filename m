Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB13B20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 00:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLIALd (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 19:11:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56309 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLIALd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 19:11:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7841B117C6C;
        Sat,  8 Dec 2018 19:11:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pc1Gg+s9Is64s48M2HhEVcQCmRA=; b=ppkyVP
        FHmCYI4FvxHDx6ZGlBptgugRXkP8IGvCW5rPMkE0ag01CNK+a6u7mXvwngTD24wK
        wG9oGadg59sbyVb323r5uZ4kbMRqSTsm8nfoY8XsMwu6Nlx9B6VdENA++oKJXSER
        SjjYt7QiVdgKvggS0T9XGCCzmTIYljtGy3JJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wMKBr69u7fzXaXVO/Yh4oooTuHUvMj+P
        MR5/D7kAZp5wc/4Sr22D4arrA7ZlC3E5r12hBCtMVzNaAmSpUQ4BzjDtVLYf5aQO
        +zzoLQ0bybh3M5uss9k6OYkXLX0JH7gC4TpRng/CCNwiGMxxnncmgaqX50ip/VsB
        or/Ml0PJDx4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70B89117C6B;
        Sat,  8 Dec 2018 19:11:31 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5D6A117C6A;
        Sat,  8 Dec 2018 19:11:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] submodule update: add regression test with old style setups
References: <20181207235425.128568-1-sbeller@google.com>
        <20181207235425.128568-2-sbeller@google.com>
Date:   Sun, 09 Dec 2018 09:11:29 +0900
In-Reply-To: <20181207235425.128568-2-sbeller@google.com> (Stefan Beller's
        message of "Fri, 7 Dec 2018 15:54:22 -0800")
Message-ID: <xmqqk1kj7e4u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAD7B4BA-FB46-11E8-81C2-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> As f178c13fda (Revert "Merge branch 'sb/submodule-core-worktree'",
> 2018-09-07) was produced shortly before a release, nobody asked for
> a regression test to be included. Add a regression test that makes sure
> that the invocation of `git submodule update` on old setups doesn't
> produce errors as pointed out in f178c13fda.
>
> The place to add such a regression test may look odd in t7412, but
> that is the best place as there we setup old style submodule setups
> explicitly.

Very good first step.  Thanks.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t7412-submodule-absorbgitdirs.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
> index ce74c12da2..1cfa150768 100755
> --- a/t/t7412-submodule-absorbgitdirs.sh
> +++ b/t/t7412-submodule-absorbgitdirs.sh
> @@ -75,7 +75,12 @@ test_expect_success 're-setup nested submodule' '
>  	GIT_WORK_TREE=../../../nested git -C sub1/.git/modules/nested config \
>  		core.worktree "../../../nested" &&
>  	# make sure this re-setup is correct
> -	git status --ignore-submodules=none
> +	git status --ignore-submodules=none &&
> +
> +	# also make sure this old setup does not regress
> +	git submodule update --init --recursive >out 2>err &&
> +	test_must_be_empty out &&
> +	test_must_be_empty err
>  '
>  
>  test_expect_success 'absorb the git dir in a nested submodule' '
