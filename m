Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165C6C433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 00:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350406AbiASAWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 19:22:10 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60719 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244782AbiASAWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 19:22:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F17217F6BF;
        Tue, 18 Jan 2022 19:22:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EWRsjDWgdrKw
        dnXc3MbGynVWHbgPRhesO3F2GOcrvdg=; b=Me3fvmPtFYz4X1QWm10oDz2jUX2A
        lclD6FjV/cSTwHe/IJp2gugn1c8iXBywn1KRdkObaYJuMWctBiU7QCkS1K34szl9
        Ky0JhnYwo3C2sFr0HMo/Pnpdz3NxmWXX9N4thB/YxssGpMD9wYmyevWUGkV2F5LG
        A2E40X3OYWK4owU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 76FB617F6BE;
        Tue, 18 Jan 2022 19:22:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E2DC317F6BD;
        Tue, 18 Jan 2022 19:22:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH] Makefile: FreeBSD cannot do C99-or-below build
References: <xmqq4k7j68eg.fsf@gitster.g>
        <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
        <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
        <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
        <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
        <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
        <xmqqilumayfh.fsf@gitster.g> <xmqqzgny7xo7.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2201181308540.2121@tvgsbejvaqbjf.bet>
        <xmqq1r15szpg.fsf_-_@gitster.g>
        <20220118214720.GA8652@neerajsi-x1.localdomain>
        <220119.861r14pomb.gmgdl@evledraar.gmail.com>
Date:   Tue, 18 Jan 2022 16:22:05 -0800
In-Reply-To: <220119.861r14pomb.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 19 Jan 2022 00:36:21 +0100")
Message-ID: <xmqqzgnspob6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D59A40C6-78BD-11EC-8DB3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jan 18 2022, Neeraj Singh wrote:
>
>> The approach of building with C11 on FreeBSD is a good one
>> compared to trying to hack around the headers.
>
> The "hack around the headers" suggests that you've seen my
> alternate[1]....
>
>> It appears more like a compiler bug that's being worked around
>> here. The FreeBSD header supposedly uses a GCC extension if the
>> C standard version is less than C11.  See:=20
>> https://github.com/freebsd/freebsd-src/blob/1e7b5f950b2d54ddb257d00859=
2563c4d753aa54/sys/sys/cdefs.h#L317
>
> ...which discusses how the line you're linking to here and
> __has_extension() interact, it's not a compiler bug, unless I'm missing
> something.
>
> I.e. it's just a FreeBSD include asking the compiler the wrong question
> and/or not suppressing the warning (e.g. via "#pragma clang
> system_header").

Yup, I do agree with you that this looks more like a bug in the
header files.
