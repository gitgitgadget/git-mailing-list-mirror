Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C45C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 17:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiAJRva (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:51:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55445 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbiAJRv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 12:51:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15F25111B00;
        Mon, 10 Jan 2022 12:51:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tU2Z90Y1j4be/7REWxcMZ1S9rBE4AJi7X5uPYd
        9TXDY=; b=mlRKFmsxK9drnArdU4TtInJXLEROtAO8ImpQTXYhICN79Ma2UTx1Uc
        YBVm54P2g19NfZvutnVtLDnbYMrc5bssYOeTsMCvFB0AG4OYzzYkagM1UMEimXHB
        E0oX2upjdyfnXakFiR1jz9PKAwBCP6SFfaywrD5jxOU27YJzGkUdk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AD4C111AFF;
        Mon, 10 Jan 2022 12:51:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 709A7111AFD;
        Mon, 10 Jan 2022 12:51:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Pedro Martelletto <pedro@yubico.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] gpg-interface: trim CR from ssh-keygen
References: <20220103095337.600536-1-fs@gigacodes.de>
        <20220107090735.580225-1-fs@gigacodes.de>
        <YdtVrT4gBvnXfNr6@flurp.local> <20220110125901.apxqy7tzrc3edjwa@fs>
Date:   Mon, 10 Jan 2022 09:51:26 -0800
In-Reply-To: <20220110125901.apxqy7tzrc3edjwa@fs> (Fabian Stelzer's message of
        "Mon, 10 Jan 2022 13:59:01 +0100")
Message-ID: <xmqqczkz1ntt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF4966C2-723D-11EC-B598-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> On 09.01.2022 16:37, Eric Sunshine wrote:
>>On Fri, Jan 07, 2022 at 10:07:35AM +0100, Fabian Stelzer wrote:
>>> We need to trim \r from the output of 'ssh-keygen -Y find-principals' on
>>> Windows, or we end up calling 'ssh-keygen -Y verify' with a bogus signer
>>> identity. ssh-keygen.c:2841 contains a call to puts(3), which confirms
>>> this hypothesis. Signature verification passes with the fix.
>>>
>>> Helped-by: Pedro Martelletto <pedro@yubico.com>
>>> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
>>
>>Should this also have a "Helped-by: Junio" since this code was heavily
>>inspired by his suggestion[1]?
>
> Yeah, this should have a "Written-by: Junio" ^^
> I'm never sure when to add these headers (except the signed-off).

Heh, helped-by might be OK but I certainly didn't write it.  I
merely translated what you wrote without knowing exactly what's
on these lines (and what I knew, like the lines are the unit of
processing and empty lines are to be skipped, I all learned from
your original without knowing why) ;-)

So if anything, Helped-by: is good enough, but I do not need more
credit or blame ;-)
