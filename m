Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A0CC433F5
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 01:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhLYB6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 20:58:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50323 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhLYB6H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 20:58:07 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40DADF9EB9;
        Fri, 24 Dec 2021 20:58:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XOmZc0Y8sIkE
        8Lv4CAJekJMLJpNT2OQ92GZnKi5bXts=; b=UoF4aM04erTGFMo5Ryqn1JRgNCF9
        7JvVMW7JlSIfdQFa5y2oIAcM6e7EutsQTyCZIPb3FycmBth1LS53tyM+xOhIpwoh
        ITyutdHk3SA/QT+hlaZwB1FmTF7ztBc5x4Oc4WDxLj1SuKSGgfuv4i7s5jL6Tg7s
        ewySITB9D//umRs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34335F9EB8;
        Fri, 24 Dec 2021 20:58:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F0D8F9EB7;
        Fri, 24 Dec 2021 20:58:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/13] init: unconditionally create the "info" directory
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
        <patch-03.13-784b7947512-20211212T201308Z-avarab@gmail.com>
        <db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com>
        <211220.86tuf3utv9.gmgdl@evledraar.gmail.com>
        <d2399072-ce9d-b654-42b4-d08d973c488e@gmail.com>
        <xmqq1r27xfi4.fsf@gitster.g>
        <211221.861r26u4b9.gmgdl@evledraar.gmail.com>
        <xmqqr1a6so6c.fsf@gitster.g>
        <211221.86o85asmd1.gmgdl@evledraar.gmail.com>
        <xmqqee66sbsa.fsf@gitster.g>
        <211224.86ilvdhq23.gmgdl@evledraar.gmail.com>
Date:   Fri, 24 Dec 2021 17:58:04 -0800
In-Reply-To: <211224.86ilvdhq23.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 24 Dec 2021 18:26:05 +0100")
Message-ID: <xmqqo8555tub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 19B419CC-6526-11EC-A3CF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Dec 20 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> It seems as though you're saying that any fixes or changes in this ar=
ea
>>> would be incomplete without moving us towards the most pedantic and
>>> minimalist interpretation possible when doing a "git init", is that
>>> right?
>>
>> Not at all.  Belt and suspenders is a good way forward.  I am just
>> saying that on-demand creation is more important than the other one.
>
> So you do agree that we should create .git/info whatever the template
> says (as this series does), or not?

Probably "should" is too strong a word. =20

I do not mind "mkdir -p" existing, but I think it is more important
to spend our engineering effort to make sure there are necessary
on-demand creation of leading paths.
