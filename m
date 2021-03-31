Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BD4C433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EBBB606A5
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhCaSpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 14:45:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52958 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbhCaSpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 14:45:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6807AB7C77;
        Wed, 31 Mar 2021 14:45:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=M/1qxp3f+291
        HfyQj6ZT4r8ijyI=; b=fUuP/LB/zQa4VbxS8BpNRPQOzyEXxsY6lvwTWpc0UYFl
        FZMZM5ulAf/eyrqyyQUKWlPUSG6yHOO4ahv8ts6aQCMldRj62AeCERxxu7kz8tI9
        PRNKeutWsmXTo0jlLblwwoEdY1SwKt6T99xheMTKj5o8i79gFnLv2kk7dIRDaT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=BiLa9Z
        GzWGM1brhey6+Spy7XRCcZKyhsG1Vxw0r9fVa1U28IaJFgcIhzaUoIMVTcWXV+Bn
        +JxebEUmI5UTLsL1E4qxFywTwBkn3/DrPq/Qs0dS88/O7+WTyyMqTdgzqSUz+RYV
        XdufPeNdm15OwxwNvWjtHJ4muyN7o7bS8Icsg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60BBCB7C75;
        Wed, 31 Mar 2021 14:45:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDEE4B7C73;
        Wed, 31 Mar 2021 14:45:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andreas =?utf-8?Q?F?= =?utf-8?Q?=C3=A4rber?= 
        <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] Makefile: add a INSTALL_FALLBACK_LN_CP mode
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
        <patch-6.7-9ada8979890-20210329T162327Z-avarab@gmail.com>
        <xmqqeefxh8rl.fsf@gitster.g> <87v997l8sl.fsf@evledraar.gmail.com>
Date:   Wed, 31 Mar 2021 11:45:13 -0700
In-Reply-To: <87v997l8sl.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 31 Mar 2021 16:03:38 +0200")
Message-ID: <xmqqr1jv6u2u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3AAB9E82-9251-11EB-8E41-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> So I would understand if there are two orthogonal knobs
>>
>>  - the order of preference (e.g. hardlink > symlink > copy)
>>  - which ones are allowed (e.g. "no symlinks please")
>>
>> but I cannot quite imagine how a system without any fallback would
>> be useful.
>
> Because with explicit knobs I'd like to tell it what to do and not have
> it auto-guess.

So how would I explicitly tell "I want hardlinks for everything
else, but use cp when going between /usr/bin and /usr/libexec"
(because /usr/bin and /usr/libexec is not on the same filesystem
on this particular box---I'll tell you to use hardlink everywhere
on another box of mine where they reside on the same filesystem)?

Your argument or analogy with openssl does not make much sense to me
in this case.
