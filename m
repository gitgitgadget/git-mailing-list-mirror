Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4352EC19F21
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 19:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiG1TzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 15:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiG1TzB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 15:55:01 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EEC6FA00
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 12:55:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BDA5198B2E;
        Thu, 28 Jul 2022 15:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ot9q1Afo7j38
        pL0m3zpRybMyxoDGXwPmt75hjJUvdtw=; b=noSQ5fGnzpJdB05PzqkVqYUJCja0
        qCuo3uFxpxbzjevznIuR+pfjnn6ZMIe0v7RXKccUFElTpWSdyAU2/RcJmoHPtXNG
        UuJ1wtxfOGayM/sC0BJl17m/c2SWedtHS/LJHpGUjN3FhnbJX9rRM7SKXojslR3j
        cwQc/+Jhylo072s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54E2D198B2D;
        Thu, 28 Jul 2022 15:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E40D4198B2C;
        Thu, 28 Jul 2022 15:54:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eugen Konkov <kes-kes@yandex.ru>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re* --creation-factor=100 does not show code
References: <1196830250.20220726145447@yandex.ru>
        <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>
        <xmqqo7x9ch7n.fsf_-_@gitster.g>
        <220728.86k07xjh11.gmgdl@evledraar.gmail.com>
        <xmqqwnbxb092.fsf@gitster.g>
        <220728.86fsilj9w1.gmgdl@evledraar.gmail.com>
Date:   Thu, 28 Jul 2022 12:54:55 -0700
In-Reply-To: <220728.86fsilj9w1.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 28 Jul 2022 21:46:49 +0200")
Message-ID: <xmqqa68tau7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 27E1261A-0EAF-11ED-AE76-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Jul 28 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> That algorithm section also says:
>>>
>>> 	The cost of an edge o--C is the size of C's diff, modified by a
>>> 	fudge factor that should be smaller than 100%.
>>>
>>> Which I find quite confusing to follow, isn't that "fudge factor" the
>>> <percent> (or <factor>) we're accepting with --creation-factor? Doesn=
't
>>> that also need to be adjusted?
>>>
>>> I still find this documentation quicke lacking, if the default is 60 =
and
>>> it's not 0..100 what is it then? Are values of 200 sensible in some
>>> cases, 1k? 10k?
>>
>> I think 90% of your responses are better answered not by me.  Feel
>> free to edit "to:" header field when that happens next time ;-)
>
> It's a comment on your patch: If you're updating the <percent> early in
> the doc, shouldn't the proposed update also update the wording later on
> to refer to "factor?"

Per-cent in "100%" is clearly a unit.  I do not know what to use to
replace the mention of "100%" with.  Rewriting it to "... should be
smaller than 100-factor" does not result in a sensible description.

Without other good questions like "if it is not 0..100 then in what
range does the default 60 fall?" answered, I do not think anybody
can come up with a useful replacement to that part.

