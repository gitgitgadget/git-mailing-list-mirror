Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A54C2BB41
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 15:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiHPPPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 11:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbiHPPPv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 11:15:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577FB5FF45
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 08:15:49 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A27741AA8C9;
        Tue, 16 Aug 2022 11:15:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cn+Nf7N0Mlm1oE+Qo2S/06U6SfbG8HUvdwBSP+
        mU50M=; b=uyzECzCezNY8jvIPajuAi8/jHm4rAQCKX6Xe1hAwRzutOV8No2+nQ5
        +c+5BakA/grMMeBkg0wybifcYb2G6JfKZkTkfpzyTHgAdLZh52jLZhFz6dWU57U5
        ixUXO46TkAaTcn0enHi6dqB2DtKy6+BQ5Mz8lJNhzWgIHxq6MRH+w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B93E1AA8C8;
        Tue, 16 Aug 2022 11:15:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 16AD31AA8C7;
        Tue, 16 Aug 2022 11:15:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] cmake: align CTest definition with Git's CI runs
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
        <9cf14984c0a71b1ccdff7db0699571bf5af1209b.1660143750.git.gitgitgadget@gmail.com>
        <xmqqczd8m1lr.fsf@gitster.g>
        <7ss9r585-14rs-so68-o2n3-9qn9qn530742@tzk.qr>
Date:   Tue, 16 Aug 2022 08:15:42 -0700
In-Reply-To: <7ss9r585-14rs-so68-o2n3-9qn9qn530742@tzk.qr> (Johannes
        Schindelin's message of "Tue, 16 Aug 2022 12:11:40 +0200 (CEST)")
Message-ID: <xmqqmtc4xlr5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C41C26E-1D76-11ED-A5F9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 10 Aug 2022, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>
>> > While at it, enable the command trace via `-x` and verbose output via
>> > `-v`, otherwise it would be near impossible to diagnose any problems.
>>
>> This sounds like a completely unrelated change.
>
> It may sound like it, but it is not. In order to make sense of the broken
> tests, I needed access to more verbose output than our test scripts
> provide by default.
>
> When running the test suite on the command-line, it is easy to tell the
> user "oh, if you need more information, just call the test script with
> these here options: ...".
>
> This is not an option when running the tests within Visual Studio.

I gave an example of "CI environment it is cumbersome to go back and
run only a single one" in the review you are responding to that may
explain why such a change is needed, and you gave us exactly the
context that was lacking here.  The environment does not let users
run the tests as anything but a single monolithic ball of wax.

> Does this clarify the intention and validity of the proposed patch? If so,
> I will gladly try my best to improve the commit message to explain that
> intention better.

It explains why -x -v is needed and needs to be a part of VS+CMake
topic, and it will help readers to have it in the explanation.  It
still does not justify why it has to be a part of a step to omit
bin-warppers and skip chain-lint that has nothing to do it, though.

Thanks.
