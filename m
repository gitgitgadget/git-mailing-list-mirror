Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A71C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 06:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3542A613FA
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 06:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFOGX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 02:23:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52046 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhFOGX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 02:23:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F99413CC5A;
        Tue, 15 Jun 2021 02:21:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AI1PniTDRQ78bqLpQ3B+kBcHsFbqQtrtL7DJD4
        LUBms=; b=ugJYYE/GrSCMJDZFyH4pw8yZpywsLmleyFOj1ifkF5VJokmbwT/7ve
        ga+0lgsaXXUzJbO/cmnt1nOkLX14dczFTDNEfI8R4NgetnVvX45xD5tZXh8CjM7V
        kohUqBlhgbnbQUyyITXbDPQW4b4YxXVQZJpuyfI3x0ZiHGXaCwd/E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 643E913CC59;
        Tue, 15 Jun 2021 02:21:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ADF2E13CC58;
        Tue, 15 Jun 2021 02:21:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] update documentation for new zdiff3 conflictStyle
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
        <50e82a7a32c1cc5c1d2282f6f5b2b32a8ce7444f.1623734171.git.gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 15:21:19 +0900
In-Reply-To: <50e82a7a32c1cc5c1d2282f6f5b2b32a8ce7444f.1623734171.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 15 Jun 2021
        05:16:10 +0000")
Message-ID: <xmqqr1h3veao.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E69B07BA-CDA1-11EB-9BDF-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	marker and the original text before the `=======` marker.  The
> +	"merge" style tends to produce smaller conflict regions than diff3,
> +	both because of the exclusion of the original text, and because
> +	when a subset of lines match on the two sides they are just pulled
> +	out of the conflict region.  Another alternate style, "zdiff3", is
> +	similar to diff3 but removes matching lines on the two sides from
> +	the conflict region when those matching lines appear near the
> +	beginning or ending of a conflict region.

I am not a native speaker, but contrast between "beginning" and
"ending" felt funny (I usually see "beginning" vs "end").

> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 3819fadac1f1..259e1ac2cf0c 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> +while in "zdiff3" style, it may look like this:
> +
> +------------
> +Here are lines that are either unchanged from the common
> +ancestor, or cleanly resolved because only one side changed,
> +or cleanly resolved because both sides changed the same way.
> +<<<<<<< yours:sample.txt
> +Conflict resolution is hard;
> +let's go shopping.
> +||||||| base:sample.txt
> +or cleanly resolved because both sides changed identically.
>  Conflict resolution is hard.
>  =======
>  Git makes conflict resolution easy.

OK, the text in the updated example clearly says what it is ;-)  The
base is not necessarily "unchanged from the common ancestor", but
now includes "both sides changed the same way".

Nicely described.

Will queue.

