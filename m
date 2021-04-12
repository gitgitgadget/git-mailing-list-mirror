Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387A1C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 23:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3F761042
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 23:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243863AbhDLXTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 19:19:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64531 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243377AbhDLXTo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 19:19:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48ABCAD4C3;
        Mon, 12 Apr 2021 19:19:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L1x8G6NF4V1gcHxsb5Q1bOxRUy4=; b=mJMvGA
        mHKDDeQckpsmfum/cfKe47/mSSWOuvjse24hJw86LDYQnrjIwifAy8MY/u28Z+6h
        0XvASr8hncEfX14E2XWjIOXW6esbH8BMVUfgeBfZRtnifUJ+TFhESdhveHfypdUX
        hAKwF5TVfyBLOoBMgmfnJUD+UARc9aydDAmmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lx0F3Xa9nUnE/cVDZ3flfHbyiSwkgkio
        YSa2w3TTKw9Dd/8zUetVQCyWkOTb29cRLqgdp08cPPS8ls30vwzlroepibS1PaEW
        fgKcCDNBJgkw+zNy99qRuArc9WBasuJGPOSVe0ougrhSoc6s+1/TSG3F5PGdZ++l
        S/KhtF8TxQs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AF96AD4C2;
        Mon, 12 Apr 2021 19:19:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD562AD4C1;
        Mon, 12 Apr 2021 19:19:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] C99: harder dependency on variadic macros
References: <YHOLo36MfuTj6YeD@camp.crustytoothpaste.net>
        <cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com>
        <67645f4b-b320-3ed6-bf5d-552bae0c2688@gmail.com>
        <87r1jfeku8.fsf@evledraar.gmail.com>
        <YHTQZK5ja8Ypja0l@camp.crustytoothpaste.net>
Date:   Mon, 12 Apr 2021 16:19:24 -0700
In-Reply-To: <YHTQZK5ja8Ypja0l@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Mon, 12 Apr 2021 22:57:40 +0000")
Message-ID: <xmqqlf9nm6pv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8511C85A-9BE5-11EB-89F0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If this works on Windows, it will also work on Unix, because POSIX has
> required C99 support since the 2001 revision, and __VA_ARGS__ is C99.
> Unix systems are not the thing preventing us from enabling C99 support
> (or any subset of it) in any meaningful sense.

Yeah, among the list (semi-)regulars, the only ones that may likely
to be broken is the NonStop folks.  Hopefully they are aware of this
discussion?

https://lore.kernel.org/git/xmqqeeffe669.fsf@gitster.g/

