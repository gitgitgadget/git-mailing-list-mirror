Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FCCC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E68A6108D
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 18:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhHRSYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 14:24:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55345 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHRSYU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 14:24:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 98E4615E58E;
        Wed, 18 Aug 2021 14:23:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fznPuUFF8TuA
        mnCXNDKPXJH0Lo+H3wfRUwlM6TvPVLw=; b=BgJSlWwh5yDtcRceQMSUR2OapL25
        CoxbC3VPwXeHc6P9Si0Jz3CTpvbBKvOlYcIs2aKOj79GTGamPTA4+nDQInoX12Dr
        0+QIgMwFn2GGlJM5Xt9HX79a7JQVVt366CNSZLWzTQEL73OoVAoLEtcsJxm2ODZi
        1atF5R26EIUQ+Rs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FF2E15E58D;
        Wed, 18 Aug 2021 14:23:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D74B015E58A;
        Wed, 18 Aug 2021 14:23:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 0/3] add support for systemd timers on Linux
References: <20210524071538.46862-1-lenaic@lhuard.fr>
        <20210608134000.663398-1-lenaic@lhuard.fr>
        <8eb18679-f6d5-b97e-f417-3747bb8309c3@gmail.com>
        <1931213.f5cRXtTDAC@coruscant.lhuard.fr>
        <64e595d5-3492-2d3a-eef9-bc6ae881db1c@gmail.com>
Date:   Wed, 18 Aug 2021 11:23:41 -0700
In-Reply-To: <64e595d5-3492-2d3a-eef9-bc6ae881db1c@gmail.com> (Derrick
        Stolee's message of "Wed, 18 Aug 2021 09:28:43 -0400")
Message-ID: <xmqqsfz6628i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6AFE1CCC-0051-11EC-99F0-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 8/18/2021 1:56 AM, L=C3=A9na=C3=AFc Huard wrote:
>> Le mardi 17 ao=C3=BBt 2021, 19:22:05 CEST Derrick Stolee a =C3=A9crit =
:
>>> None of that is important if you plan to submit a v6 that responds to=
 the
>>> remaining feedback (summarized in [1]).
>>>
>>> I'll hold off for a couple days to give you a chance to read and resp=
ond.
> ...
>> Hello,
>>=20
>> Sorry for the silence. I just happened to be in holiday for the past f=
ew weeks=20
>> and did not have access to my mails.
>> I can catch up the discussions I missed and try to address the remaini=
ng=20
>> concerns in a new re-roll.
>
> Perfect! Welcome back!

Thanks, both.  Looking forward to see this topic reignited and see
its happy ending ;-)


