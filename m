Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A3AC433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 21:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78CE61934
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 21:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhCUVk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 17:40:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62285 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhCUVkz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 17:40:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E58DA9E98;
        Sun, 21 Mar 2021 17:40:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6ZdOP8u2zj/kTh2LhCvKPN4/pII=; b=O3IdY7
        v0b1lh4ggi62wNBmhf1BNtDCLRY+22Yw0I/izBByNspUmIObe3Hp83mdWYVF1Px2
        AAyri/FJz94Xxne9mZqpY9fDxfYruRq02P9sN+Qv7Ol3Qo0j2oEBJgP6Wxorb2DM
        TmkrwFpvSvjNkmJF+5yaVIRhV2lLdnuLRj6Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n3NqkpY9IXn3sRK+UUy44ihBpMaUB4be
        5r/CqYK9ibQnkfwWR/supm98cQIo6U5BfZsHLWNaXwNooZCIdnpHWwt0YPMI1oUK
        2q22YpBxsMl5IqMZ9jWPXHhMp4SWgm8WQ/xadpUplM1X9mUAGlVMLF1ufDzEakkL
        8S3b1SIrvjA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10981A9E95;
        Sun, 21 Mar 2021 17:40:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B828A9E94;
        Sun, 21 Mar 2021 17:40:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH v3 0/9] Fix all leaks in t0001
References: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
        <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 14:40:52 -0700
In-Reply-To: <pull.899.v3.git.1616345918.gitgitgadget@gmail.com> (Andrzej Hunt
        via GitGitGadget's message of "Sun, 21 Mar 2021 16:58:28 +0000")
Message-ID: <xmqq5z1k9od7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CAAD81E-8A8E-11EB-900E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:

> V3:
>
>  * Ensures we don't silently change enum values in "parse-options: convert
>    bitfield values to use binary shift". Instead we retain the original
>    values in that patch, and reuse the unused value in a later patch.
>  * Fixes some silly commit message typos.
>
> Thanks as always for the sharp-eyed reviews.

Thanks, all.  Will replace.

I think this one is ready for 'next'.  Let's merge it immediately
after we rewind the tip of 'next' and rebuild on top of the latest
release.
