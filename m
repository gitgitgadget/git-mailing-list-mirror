Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B536C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 09:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhLMJMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 04:12:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64677 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhLMJMm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 04:12:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FAF415AA29;
        Mon, 13 Dec 2021 04:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=DVxADQ0QKXTnObHjHfwhnzyql
        vYApnHLYd45jbRho2s=; b=w57s+i8OxLTyqdousXF+Zq0dCbflUijuZxqBzJYID
        IAswnp5nfpAFv3Sz/FthH9TI0eSwiql7x/gjmZt3v8rI94V5XYSP5C4VVlBT/t8j
        XvhlbaX7A1UcmECI6fHeiHtylmZCUFLJD2+b3Z9Y+SPwX1BdtowI3lms5mNzQye9
        Qg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 275B515AA27;
        Mon, 13 Dec 2021 04:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 84F1D15AA26;
        Mon, 13 Dec 2021 04:12:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
        <xmqq4k7nmksi.fsf@gitster.g>
        <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
        <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g>
        <211209.86fsr2l8vn.gmgdl@evledraar.gmail.com>
        <xmqq4k7htzpk.fsf@gitster.g>
        <CABPp-BHbOwXcV-FqNLpCVhLPpw3yWLV0J1MQEB++D_SHb9j7Bw@mail.gmail.com>
Date:   Mon, 13 Dec 2021 01:12:37 -0800
Message-ID: <xmqqzgp4eum2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D1706358-5BF4-11EC-B5EF-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Dec 9, 2021 at 10:12 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> >> So, how about doing it this way?  This is based on 'master' and doe=
s
>> >> not cover contrib/scalar, but if we want to go this route, it shoul=
d
>> >> be trivial to do it on top of a merge of ab/ci-updates and js/scala=
r
>> >> into 'master'.  Good idea?  Terrible idea?  Not good enough?
>> >
>> > With the caveat that I think the greater direction here makes no sen=
se,
>> > i.e. scalar didn't need its own build system etc. in the first place=
, so
>> > having hack-upon-hack to fix various integration issues is clearly w=
orse
>> > than just having it behave like everything else....
>>
>> We decided to start Scalar in contrib/, as it hasn't been proven
>> that Scalar is in a good enough shape to deserve to be in this tree,
>> and we are giving it a chance by adding it to contrib/ first, hoping
>> that it may graduate to the more official status someday [*].
>
> Is that the hope?  I thought the wish was for it to eventually
> "disappear" rather than "graduate", as per the following bits of
> Dscho's cover letter:
>
> """
> The Scalar project was designed to be a self-destructing vehicle...For
> example, partial clone, sparse-checkout, and scheduled background
> maintenance have already been upstreamed and removed from Scalar
> proper...[Adding Scalar to contrib will] make it substantially easier
> to experiment with moving functionality from Scalar into core Git.
> """

I can go either way, but my impression from Dscho's messages has
always been that there is no strong reason to switch existing scalar
users to say "git clone <options that give behaviour like scalar>"
when their fingers and scripts are used to say "scalar <this>", and
a very thin shell may remain in some form in the ideal world.


