Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE48C433E9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A655A64FEF
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhCKRkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:40:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57095 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhCKRkI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:40:08 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 18D411214AB;
        Thu, 11 Mar 2021 12:40:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EllWy7bRgdgk
        xPoe6ugg7O4W028=; b=WemRBbJZvXytxMLYozrF69cvMzhn3PNvxbaU488jfyRC
        HX50mVtE9P7shjI8sVawrk+GQPWfPlql2q6pQkQy8xz9mwB78oxQ3BA9D2pupiWa
        rOpSeaSQz+Wj9KxriHR7iwEwo3CHDe0OuVXEf++fIrDZVs1Hzy2PCZj38RhyN6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KAHnVJ
        Of/yYqVdIvVR4jqu+/rs2dc98mO8Mn7hMKhc1NZHh9NblA9npc4scI99JXgmdWla
        r3BXQvuX1/ZwxkPZmh1ik2ewlXJAHCpwdL/sHhc68prZgy6WYjcZzaILxG1O92Kr
        d9L7RXya3LLTuM8Az3BmkqxcjJXW3ecxBxYSc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 105D91214A9;
        Thu, 11 Mar 2021 12:40:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4F57D1214A5;
        Thu, 11 Mar 2021 12:40:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH 4/4] tests: get rid of $_x05 from the test suite
References: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
        <20210311001447.28254-5-avarab@gmail.com> <xmqq8s6uh4a2.fsf@gitster.g>
        <87tupigf02.fsf@evledraar.gmail.com>
Date:   Thu, 11 Mar 2021 09:40:03 -0800
In-Reply-To: <87tupigf02.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 11 Mar 2021 11:29:33 +0100")
Message-ID: <xmqqsg51egi4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D0B5FB1E-8290-11EB-BF2F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>>  test_expect_success 'ls-tree --abbrev=3D5' '
>>>  	git ls-tree --abbrev=3D5 $tree >current &&
>>> -	sed -e "s/ $_x05[0-9a-f]*	/ X	/" <current >check &&
>>> +	sed -e "s/ [0-9a-f]*	/ X	/" <current >check &&
>>>  	cat >expected <<\EOF &&
>>>  100644 blob X	1.txt
>>>  100644 blob X	2.txt
>>
>> This one is particularly iffy.  The --abbrev=3D5 test is designed to
>> ensure that the resulting abbreviated object names are at least 5
>> hexdigits long, even when the repository is so small that only 4
>> hexdigits are sufficient to avoid ambiguity, while allowing the
>> output to be longer than specified 5 (when 5 turns out to be
>> insufficient for disambiguation).
>>
>> So, I dunno.
>
> Yes, I think this patch should be dropped. Do you mind just dropping th=
e
> 4/4 and having it be a 3-patch series? I can also re-submit a v2 like
> that if it's easier...

As long as the earlier three are good to go, I can just cut the tip
of the branch, or just drop it all now and send a three-patch series
after the release.  Either is fine.

> My assumption in writing this patch was that it was fine because we tes=
t
> the details of abbrev behavior somewhere else, surely...

I expected that the test whose title is "ls-tree --abbrev=3D5" is
targetted towards testing the details of abbrev behaviour.  Isn't
that the case?

Is the same assumption brought silent breakages to the other two
patches to the tests, by chance?  I only gave cursory look on them
and don't think anybody else looked at them carefully.
