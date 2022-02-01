Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F274BC433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 18:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242013AbiBASmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 13:42:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62340 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiBASmC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 13:42:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D94A2F9A17;
        Tue,  1 Feb 2022 13:42:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bRs0RHo+fmx1ciU+WABfj7gztO2xP/BLqmPAoP
        Fg5cA=; b=M79R74IuwV9VwmR87jwM0mmRj5ZzcwUj9Zdsn3QZG+T9UM2lFc9Z6+
        n/I987iEFaM2As/RG3UlgdYOseQRczPs34kby2Sm5NeujQQQps8kG4K8MJxAnMNw
        92gEWAHX4n+vx6umrG2iku2XZyMw6ncFRi7R36t2Xw6Yd5Po0Ypc4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEE79F9A15;
        Tue,  1 Feb 2022 13:42:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6ACBF9A14;
        Tue,  1 Feb 2022 13:42:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] refs.h: make all flags arguments unsigned
References: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com>
        <xmqqa6fbgx85.fsf@gitster.g>
        <CAFQ2z_PtNsrSXdCG_5vr99Fz63GDMpC6j7rzLqOn+cZufi+xfQ@mail.gmail.com>
Date:   Tue, 01 Feb 2022 10:41:59 -0800
In-Reply-To: <CAFQ2z_PtNsrSXdCG_5vr99Fz63GDMpC6j7rzLqOn+cZufi+xfQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 1 Feb 2022 12:47:11 +0100")
Message-ID: <xmqqh79ie8eg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4657F6C-838E-11EC-B85B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Tue, Feb 1, 2022 at 3:02 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: Han-Wen Nienhuys <hanwen@google.com>
>> >
>> > As discussed in
>> > https://lore.kernel.org/git/xmqqbkzrkevo.fsf@gitster.g/ , we don't
>> > want to treat the sign bit specially, so make all flags in refs.h
>> > unsigned.
>>
>> It may be true that we do not want to, but are we sure there is no
>> code that already uses some cleverness to make the topmost bit
>> special by e.g. doing ugly things like "if (flags < 0)" ;-)?
>
> In refs.h, we don't have any bitmasks that accept 32 different bit
> values, so it's hard to see how we would stumble into a case like
> that.
>
>> I haven't had energy to vet the entire codebase for all flag words
>> and that is why I've never produced a patch like this one myself.
>>
>> Thanks for carefully vetting after creating this (presumably
>> mechanically prepared) patch---producing is the easy part, but
>> making sure it does not break unexpectedly is much harder.
>
> I went over the changes once more, uniformizing the naming. I didn't
> see any shenanigans.

Thanks again.
