Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E14FC388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 22:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A2D206DC
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 22:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iJd/IxaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbgKEWJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 17:09:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59250 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgKEWJM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 17:09:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5994B9180F;
        Thu,  5 Nov 2020 17:09:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0AZ+48zo9FmFI6xawAWLCbp7yPY=; b=iJd/Ix
        aHYacMs2aegNdcN5ZUh3x3EOjbuZ3rIWpesh6+4dGhF+LNzczRiodv0C6KczCn3H
        /iJGr6P0BN/0QNH+pek8PZtXwZxB660DZ6mC0+oopva4z8eZxJc9txO60kdK8TiN
        ji1oO2L8yrRMTmrpDAbTuorFEb1CAvYDpuLIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y6YGroTwUFVXmoa9Y5BGaeTEvfsLvUtV
        JGGXhabCWfA+DC4OYIvgDF+Bvsd3qzlGfkFZkp8RmV9/fBoHzSuAJumZ9t5hLvT4
        2YO6B3Y7dmq9U8gzEo2oXMWoiP+C8OqrwGYGK+i1SAZQVI95sNnI0Bms2CYlYFj2
        efNlNU2hpfM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E1759180D;
        Thu,  5 Nov 2020 17:09:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DAF79180B;
        Thu,  5 Nov 2020 17:09:07 -0500 (EST)
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
        <xmqqsg9pm1v4.fsf@gitster.c.googlers.com>
        <CAMP44s3occuUi2no8JfxPreLouvMsKKBcivKbv8XMTToZowz5w@mail.gmail.com>
Date:   Thu, 05 Nov 2020 14:09:05 -0800
In-Reply-To: <CAMP44s3occuUi2no8JfxPreLouvMsKKBcivKbv8XMTToZowz5w@mail.gmail.com>
        (Felipe Contreras's message of "Wed, 4 Nov 2020 19:09:13 -0600")
Message-ID: <xmqqmtzvh2wu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8631C43C-1FB3-11EB-BC25-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Nov 4, 2020 at 12:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> But the take-away I got from your short quote was that I see no
>> evidence that Zsh folks do not care about usability.
>
> This exchange happened 9 years ago, so I wouldn't place too much of a
> burden on what they actually meant by what they said.

In other words, you are now saying that it does not demonstrate your
earlier claim that they do not care about usability at all?

> Even if my interpretation of what they said at that point of time is
> 100% incorrect; it's not a *derogatory* statement; it would simply be
> an unfactual statement.

So, the short quote given without much context was an attempt to
mislead those who are reading this discussion?  That sounds even
worse to me.

In any case, so far you managed to convince me even less that it
would help the Zsh userbase to carry a "by default has to fall
behind" copy of what they can get, or their distro packagers can
package, the latest and greatest directly from your github
repository as part of the release of this project.

Thanks, and bye for now.
