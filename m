Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E30EC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 21:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFBD22D02
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 21:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbhAKVGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 16:06:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53449 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbhAKVGY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 16:06:24 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DCBA126BFC;
        Mon, 11 Jan 2021 16:05:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Es8xxowMDPkw
        nI8ed2jvk4cmDgk=; b=vws1bl9MK1PNhUYiKH4PZRb12I2YPa9t3sraEOEm5Awd
        k8fMr4n1meChuhtcEFxmSkfycljX57QZlqoaTBF3TWQknWOXbvBl07ugn1v5xaIB
        sr0Zn5ZhWFu0JN/Y+mVY/Dx0JyFw3Av9FVwwtf//KpbnVOUJa33JMqrhKcMb4pg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bjLe9n
        QkFZahH/BalVd305rZLBp1klL7zctxUGJKEfJxZKQZ4FbNhpJg3JRO1WG/Gew7XO
        HT6LKos+3Ek+zYV4+W7Jfikp8bgutIPe1Cw3rgxNJWyB5dc1mHosEMzATSLPb2nZ
        BdT96eoiGWY5MUQ980SA0VP8Et03o8Q3RIyLg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52F92126BFB;
        Mon, 11 Jan 2021 16:05:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 895E9126BF8;
        Mon, 11 Jan 2021 16:05:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Should you use test_i18ngrep or GIT_TEST_GETTEXT_POISON=false?
References: <20201223013606.7972-1-avarab@gmail.com>
        <20210105194252.627-13-avarab@gmail.com>
        <20210110132155.GT8396@szeder.dev>
        <87y2h062jd.fsf@evledraar.gmail.com>
        <xmqqczyca6vq.fsf@gitster.c.googlers.com>
        <87pn2b6eyb.fsf@evledraar.gmail.com>
Date:   Mon, 11 Jan 2021 13:05:37 -0800
In-Reply-To: <87pn2b6eyb.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 11 Jan 2021 09:43:56 +0100")
Message-ID: <xmqqim836v6m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C21DD914-5450-11EB-9535-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> What do you think about just removing it? I.e. make setting it a noop?

I have been seeing occasional CI job failures from new tests that
forget to use test_i18ngrep.  I actually think marking such a grep
as "this is looking for a string that is meant for humans" a good
way to document the interface and expected end-user interaction,
so I am not sure about just removing it.

So after all, test_i18ngrep may make more sense than setting
GIT_TEST_GETTEXT_POISON to false.  I dunno.
