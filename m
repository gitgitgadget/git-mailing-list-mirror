Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FC3C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 22:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C0B60524
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 22:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhJ2Wb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 18:31:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51709 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ2Wbz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 18:31:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D61E7E24E4;
        Fri, 29 Oct 2021 18:29:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BSADbrYKNeXf
        7mCFLQSBTERa0aXlHKxTUSujuw030A0=; b=VJuvkgih580B5VgFy2+pYNepMJsT
        ntrCQLRkg+EK6fr2SeR47mf+dz1iI/v+wRS9ObNeI1sxX+9y2HzWt2wv/X8sblqL
        A5fE96u2NVD6HC3m3TztLUWN3Upc00yxGhtQ7ol33jBs6ZUhMsIbYAgd/GmMx6CS
        ZJCuzADwWdIcMs4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE623E24E3;
        Fri, 29 Oct 2021 18:29:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4380EE24E2;
        Fri, 29 Oct 2021 18:29:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Jeff King'" <peff@peff.net>,
        =?utf-8?Q?'Carlo_Marcelo_Arenas_Bel?= =?utf-8?Q?=C3=B3n'?= 
        <carenas@gmail.com>, <git@vger.kernel.org>, <avarab@gmail.com>
Subject: Re: [PATCH] wrapper: remove xunsetenv()
References: <20211029212705.31721-1-carenas@gmail.com>
        <YXxpjLhiguq4HY6g@coredump.intra.peff.net>
        <YXxs4NZmpjhRkoYA@coredump.intra.peff.net>
        <xmqqbl37ijc7.fsf@gitster.g>
        <015801d7cd10$8d404810$a7c0d830$@nexbridge.com>
Date:   Fri, 29 Oct 2021 15:29:24 -0700
In-Reply-To: <015801d7cd10$8d404810$a7c0d830$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Fri, 29 Oct 2021 18:01:34
        -0400")
Message-ID: <xmqq35ojihx7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ABE21128-3907-11EC-8BAA-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> On October 29, 2021 5:59 PM, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>=20
>> > However, according to the unsetenv() manpage:
>> >
>> >   Prior to glibc 2.2.2, unsetenv() was prototyped as returning void;
>> >   more recent glibc versions follow the POSIX.1-compliant prototype
>> >   shown in the SYNOPSIS.
>> >
>> > So it is POSIX to return an int, but that gives us at least one
>> > platform where unsetenv() returns void (or used to). glibc 2.2.2 is
>> > 2001-era, so that may be old enough that we don't care. But it makes
>> > me wonder if other older or obscure platforms will run into this.
>>=20
>> Ahh, OK.  Well, we will hear from them soon enough.  It is not like th=
is is
>> anything urgent.
>
> Well... maybe for some of us =F0=9F=98=89

Heh, but we all know you are capable of locally patching ;-).

