Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DC8C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D863264EB6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhCQTjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 15:39:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62518 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhCQTio (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 15:38:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DADD1A9248;
        Wed, 17 Mar 2021 15:38:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CZwpugM0qVZ6YuItr6SyAinvr3s=; b=tlD7LZ
        vyjoSoHH2SZO5/LUk52OepPt87+xyD71QuZwae00hgGBjvSZe6Ik1sm5ZgghLvwy
        Ts7oO7yZn6UczORj4f7B8F7Ft7S9Stf6WeeTu0vcUrbDNDmVKWclnY1g6nOAQ3jn
        E3aLdT6iI7I/inlWr4eeNt/qZ4f++przElqz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oiFLfnjD8YE5b8T9IYGD/2A+wH3aJXwA
        6ftHnr/IR1eBsPGujBh4R9ju48wWp6J/+giikKsC/Q2bXeHir9KRBxFYTU8DIMGV
        ul5ra7pG57zNO1xHiqcXCPnsFMbTjgWBKNGdNqj0QRe8rG2uErMqJ9eJuINw6yps
        3SGIz+iSK6s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2E34A9247;
        Wed, 17 Mar 2021 15:38:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 546CAA9246;
        Wed, 17 Mar 2021 15:38:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pete Boere <pete@duel.me>
Cc:     git@vger.kernel.org, John Lin <johnlinp@gmail.com>
Subject: Re: Extra blank lines in "git status" output have been reduced
References: <CAF8W_bFzE8strSWc0_eABdyfCxA+0CA6ph_uXgSyT7YRU-jO6A@mail.gmail.com>
Date:   Wed, 17 Mar 2021 12:38:42 -0700
In-Reply-To: <CAF8W_bFzE8strSWc0_eABdyfCxA+0CA6ph_uXgSyT7YRU-jO6A@mail.gmail.com>
        (Pete Boere's message of "Wed, 17 Mar 2021 10:22:50 +0000")
Message-ID: <xmqqo8fhtvst.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61DC7854-8758-11EB-8EBB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pete Boere <pete@duel.me> writes:

> With the release of v2.23 I have noticed from the commit:
> 7b098429355bb3271f9ffdf73b97f2ef82794fea
> ...
> Is there any chance of adding them back? The changed layout has been
> throwing me off ever since upgrading.

Sorry, but it is way too late to complain, generally after a change
hits a release, and especially after it got buried under 8 new major
releases.  Unless a change was an unintended side-effect that we did
not mean to make, in which case we would likely to fix it as a bug.

And the change in question b2f5171e (status: remove the empty line
after hints, 2019-06-04) quite deliberately targets at removing
these extra lines [*], so no, I do not think it is reasonable to
expect reverting that commit that is more than a year old.

You may want to join the list discussion and stop whatever UI change
you find undesirable before it materializes next time.


[Reference]

commit b2f5171ecc2feb4192acd80f5a6b05c06e099e97
Author: John Lin <johnlinp@gmail.com>
Date:   Tue Jun 4 07:02:21 2019 -0700

    status: remove the empty line after hints
    
    Before this patch, there is inconsistency between the status
    messages with hints and the ones without hints: there is an
    empty line between the title and the file list if hints are
    presented, but there isn't one if there are no hints.
    
    This patch remove the inconsistency by removing the empty
    lines even if hints are presented.
