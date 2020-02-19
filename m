Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AA0C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 10:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB82621D56
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 10:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KIgVCRsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgBSKo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:44:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50288 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgBSKo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 05:44:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2641BE12F;
        Wed, 19 Feb 2020 05:44:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kDity66cyUdw4Ue/u8XBVy4GNQw=; b=KIgVCR
        sz7UaxNxXjyT9Phyy81f83igC4rsJuthNAtDToycxrJw09FRWwDPbQSuQ5iNQI5Q
        KecadTyKqymRpHM0XDafUaXBbXWvuX4OVIS180vKvPnWKHmnx1F38lO2FRCA2D1+
        44JN5W+0MwF8UWhBJk4Sv8ETrWf1OggufGPPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gprfcCwRcS4dTTICWTXUj2MuCuU14m9q
        BGbNjSXh65P7c+/Kka9K7JaQhfKZ9VQUzj2K2WJttwj6HbMNYE9QMGt+C6lCDbQY
        1LMzGPellvrWFj2yJjFsQcI9oe5v3zCgzUlpb0diHbt4yyqS7s/50oBuORjDcbls
        MU50Zbydtm8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC136BE12E;
        Wed, 19 Feb 2020 05:44:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 06EE8BE12D;
        Wed, 19 Feb 2020 05:44:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robear Selwans <rwagih.rw@gmail.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Pratik Karki <predatoramigo@gmail.com>
Subject: Re: [GSoC][RFC][PATCH 2/2] STRBUF_INIT_CONST: Adapting strbuf_* functions
References: <CAHk66fskrfcJ0YFDhfimVBTJZB4um7r=GdQuM8heJdZtF8D7UQ@mail.gmail.com>
        <xmqq36b7k4i6.fsf@gitster-ct.c.googlers.com>
        <CALH1-Xr3HVZzDn2-9EvmdiBWmxWQ-zfExM2LNJyR1wR+dgxRSQ@mail.gmail.com>
        <xmqqv9o3gthb.fsf@gitster-ct.c.googlers.com>
        <CALH1-XoXdpAxYj7r1ouc-v4KrVuYDocBFFC++7eFiRwdHFxmUA@mail.gmail.com>
Date:   Wed, 19 Feb 2020 02:44:50 -0800
In-Reply-To: <CALH1-XoXdpAxYj7r1ouc-v4KrVuYDocBFFC++7eFiRwdHFxmUA@mail.gmail.com>
        (Robear Selwans's message of "Wed, 19 Feb 2020 06:34:19 +0200")
Message-ID: <xmqqmu9ehn4t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC5F8A96-5304-11EA-8737-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robear Selwans <rwagih.rw@gmail.com> writes:

> On Wed, Feb 19, 2020 at 5:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Yes, but the case that matters to _your_ use is sb->alloc == 0.  You
>> do not want to let a broken strbuf (presumably broken by changes
>> other than your own) to pass, when you can detect it.  And for that,
>> paying attention to sb->len _might_ make sense, but then the check
>> won't be
>>
>>         if (sb->alloc < sb->len)
>>                 make it mutable;
>>
>> you'd rather be writing something like
>>
>>         if (!sb->alloc)
>>                 make it mutable;
>>         else if (sb->alloc < sb->len)
>>                 BUG("somebody fed a corrupt strbuf to me");
>
> Ooh so what you meant, is that corrupt `strbuf`s need to be
> anticipated even if they
> don't make much sense. Smart.

I don't know if that is smart, but the point is that sb->alloc is
the only thing you need to care about if you want to see if the
strbuf is borrowing from a const string, and it does not make much
sense not to catch a corruption, _if_ you are to check the value of
sb->len as well.

