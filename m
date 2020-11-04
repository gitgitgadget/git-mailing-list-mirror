Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FBCC61DD8
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 18:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DA7206CB
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 18:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rwg3YXjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbgKDSI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 13:08:28 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58313 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbgKDSIV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 13:08:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE4FEF7176;
        Wed,  4 Nov 2020 13:08:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=lnGcwwkGUvMjCfgflSNmXOlDCKk=; b=Rwg3YXjldB3gvc3Dmljv
        oT1iGUa/VmUK5sKWitXaWmSzOKVzTASlNDMZEg/itFBVdRbnSE5BOk0QQ4egfeYR
        v/n7iGpXYumu6e/HbYawrc4D5Eoq8GBWrQzAr875cwVuzRaeikB/FAHAiOnz1Whh
        LSB8cXW4HHFvFxYZx4NvfE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=rPcu2CI21EjThJCk9xHFGLgiRvqGHGM1KcZDFZjsc7r8ZN
        M5ROsFdv0CFMjOveyNgjMSYJTj8MG2dwuEcEKVmwYoVxDrjUv7PC4tLeWYfpo+bi
        H07Xi5B7FWcr1Y987TrVOmZ6PGZ93lQV7CGPZWbR+aguKPvnFl+i9SaNqgNEE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C78E1F7174;
        Wed,  4 Nov 2020 13:08:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1B5CBF7173;
        Wed,  4 Nov 2020 13:08:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
        <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
        <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
        <xmqqk0vbbep5.fsf@gitster.c.googlers.com>
        <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
        <xmqqr1pj9rf0.fsf@gitster.c.googlers.com>
        <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
        <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de>
        <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
        <xmqqeelh7y23.fsf@gitster.c.googlers.com>
        <xmqq361x7xj5.fsf@gitster.c.googlers.com>
        <CAMP44s2bgZbKde-UFL7+sR-7QgEv5Oiho2LTi3RG7S4BD0iuaw@mail.gmail.com>
        <xmqq7dr3nr9h.fsf@gitster.c.googlers.com>
        <CAMP44s1RS2-8rOvZLidRjkB=dkBGRpPzhpwpQByDRObP7UMLFw@mail.gmail.com>
Date:   Wed, 04 Nov 2020 10:08:15 -0800
Message-ID: <xmqqsg9pm1v4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6A1C4C8-1EC8-11EB-827A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> To state the opinion of a person is not a derogatory statement. This
> is literally what they said:
>
>> > > Now, how about you make a compromise between "correctness" and
>> > > usability?
>> >
>> > No.
>
> I'm not doing anything but repeating their stated opinion. It is a
> fact. If you don't like their stated opinion, feel free to talk to
> them.

I had to read the exchange three times to be reasonably confident
that the party that was asking the question was you and Zsh folks
was who said "No.", as there were so little in the context to go by,
in order to tell what was being discussed (I initially even thought
they asked the question and you gave a short "no", before realizing
it probably is the other way around).

In the short quote given without enough context, I cannot see
anything more than a disagreement of the degree of "correctness" and
"usability" expected by the two parties in the discussion.

Even if I knew what exact "incorrectness" and "usability" were on
topic back when you two argued, I know people strike balance at
different place.  Even though I may agree with your argument in that
particular case, I can understand (if not accept) if Zsh folks
thought differently.  And it does not matter if I agree with you
that they are better off taking a small "incorrectness" to gain
"usability"---the Zsh show is run over there by Zsh folks, and I am
not a participant.

But the take-away I got from your short quote was that I see no
evidence that Zsh folks do not care about usability.
