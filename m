Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE93C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 16:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376406AbiBDQpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 11:45:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53926 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiBDQpD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 11:45:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BFEB1182E2;
        Fri,  4 Feb 2022 11:45:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zwdv5y56M72t
        5G3ngMBd+UwdvFh3SJGBBVfR/yshe6A=; b=eWrWZfkAb8qylDOvbjx2gGp1SsI2
        yY+d7vyz2laIjjgH3iLP/qV+1u78rUZUXertonPx4oriaM6xwxo4qvaOdEAl51at
        kIV/eEtJ0yf6Gqhndzm+GK/J3a4BS88xkr5KwfG7oyXw8CShdqDm0jb1Hx620384
        LRZ9i6WTda97TjQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 026511182DF;
        Fri,  4 Feb 2022 11:45:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D8021182DD;
        Fri,  4 Feb 2022 11:45:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Chen BoJun <bojun.cbj@gmail.com>,
        Robin Jarry <robin.jarry@6wind.com>
Subject: Re: cb/clear-quarantine-early-on-all-ref-update-errors
References: <xmqqr18jnr2t.fsf@gitster.g>
        <220204.86mtj63jg5.gmgdl@evledraar.gmail.com>
Date:   Fri, 04 Feb 2022 08:45:00 -0800
In-Reply-To: <220204.86mtj63jg5.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 04 Feb 2022 13:25:26 +0100")
Message-ID: <xmqqa6f6oa2b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CC353008-85D9-11EC-A28C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Feb 03 2022, Junio C Hamano wrote:
>
>> * cb/clear-quarantine-early-on-all-ref-update-errors (2022-02-01) 1 co=
mmit
>>  - receive-pack: purge temporary data if no command is ready to run
>>
>>  Check if "receive-pack" will do any ref updates (various conditions
>>  could reject a push) before received objects are taken out of the
>>  temporary directory used for quarantine purposes, so that a push
>>  that is known-to-fail will not leave crufts that a future "gc"
>>  needs to clean up.
>>
>>  Will merge to 'next'?
>>  source: <20220129063538.24038-1-bojun.cbj@gmail.com>
>
> Ah, I see it's even in the same function as
> rj/receive-pack-abort-upon-disconnect. That's a very well reasoned &
> sensible isolated change. I think it's ready for "next".

I have a small comment on possible follow-on work, but that wouldn't
be a blocker.  This seems to be a pure improvement.

Thanks.
