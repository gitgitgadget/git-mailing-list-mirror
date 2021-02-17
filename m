Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840D2C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F7664DF3
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhBQTCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:02:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60921 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBQTCS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:02:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 953A21226FA;
        Wed, 17 Feb 2021 14:01:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/+GQxGU7zDMf
        wBqU9AfbV1Rq+VA=; b=WHULUhClnxwX40zW8uC9kaZ5/OoChsJbGacZ0uoKE5hT
        dPY4AEq1TZZkqIpD1aPdFHe00Me1W/x+Tyuu1+JY2YKPB6wa0NToNwgcz8pC54oR
        CflytRF1kObdX8MCBGliJHteFkUaysx/gj/lwxFNqbi5dxfe+W96WV9TsS8RWdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hM8YK6
        fLKN0ZHVGuEoI24mbabEp4gILKgZNMhpC0Mc357+Yj4J+rXiR/lQvRw5Xqmbmnyu
        ZAPuLASI4ZGW6hlSDF0KuGJIKoeRr07tRR8yJ1ZUbWFa7trHAPsyUrwTewsVH4nm
        6ZWtElSEdif0f8jHknV45BD8BndwHe5ap+T/o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D2F11226F9;
        Wed, 17 Feb 2021 14:01:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C895B1226F8;
        Wed, 17 Feb 2021 14:01:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 09/27] userdiff tests: match full hunk headers
References: <20210215005236.11313-1-avarab@gmail.com>
        <20210215154427.32693-10-avarab@gmail.com>
        <4bd7bb84-3b75-258e-b488-f66dff6ba6b5@kdbg.org>
        <xmqqsg5vrhha.fsf@gitster.c.googlers.com>
        <1b2cb670-b49b-b478-7f69-6d4c356c8118@kdbg.org>
        <87h7mba3h3.fsf@evledraar.gmail.com>
Date:   Wed, 17 Feb 2021 11:01:32 -0800
In-Reply-To: <87h7mba3h3.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 17 Feb 2021 02:27:04 +0100")
Message-ID: <xmqqk0r6ldrn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8D65003E-7152-11EB-A4F7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> +		sed -ne "s/^@@[^@]*@@//p" actual |
>>> +		if test -n "$HEAD"
>>> +		then
>>> +			grep -F "$HEAD"
>>> +		else
>>> +			grep "^.*RIGHT"
>>> +		fi
>>> +	'
>>>   done
>>>     test_done
>>
>>> diff --git c/t/t4018/bash-arithmetic-function w/t/t4018/bash-arithmet=
ic-function
>>> index c0b276cb50..935f18d96d 100644
>>> --- c/t/t4018/bash-arithmetic-function
>>> +++ w/t/t4018/bash-arithmetic-function
>>> @@ -2,3 +2,6 @@ RIGHT() ((
>>>         ChangeMe =3D "$x" + "$y"
>>>   ))
>>> +
>>> +
>>> +# HEADER |right()|
>>>=20
>>
>> Clever! Opt-in for those who desire precise tests.
>
> Tests aren't only for testing a subjective "good enough" in the
> estimation of the author of the code in question, but also for others
> who later touch the same area and want to avoid regressions.
>
> Which is why I think it's an anti-pattern to use "grep SOME-SUBSTR" in
> lieu of test_cmp if we can easily do the latter.

Sounds good.  It shouldn't be too hard to satisfy both camps,
i.e. the quoted demonstrates one way to allow test writers to
give expectation in-place in the single test file, and replacing
how it uses "grep" to check the output with test_cmp or whatever
wouldn't make the resulting tests too hard to write and maintain.

