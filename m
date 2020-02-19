Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC53EC34022
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 03:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB462176D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 03:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xxuw3nUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgBSDNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:13:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55410 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgBSDNL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 22:13:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E36ABBD9E;
        Tue, 18 Feb 2020 22:13:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JIBdwwdrY4uXsT8E09dqfGvL49A=; b=Xxuw3n
        UXzQaj4+aAzTn8C6tt9aqTKEQ29Vb44HmCxJFOC6f9iolEAeYVGo63iVUzp2EYsy
        remIeNb8oNQf02aF3s5nqunccr6WDyFGi7sUZWJA4zjtN7auPriWbWOVc2bOC0HV
        o5AbWIHBnaun9iykqsB/VyXCTDAGBhkNn6aOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yKt702uSMXJQuhBMCCv+CnkNQ99xuul9
        nASaNqNeF4pbBAhr3YrKLvWuCXxSyzsRLWXvlJbaBSoF6QMRughtNLrqNr9WwiYz
        4tEfU+yDIhISrIABiWawO2NK5QGuKg2heYGPvLNJIUyZSvPsHTFBbLkddTxyoQ4s
        34+KQBb5MvU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36340BBD9D;
        Tue, 18 Feb 2020 22:13:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6837CBBD9C;
        Tue, 18 Feb 2020 22:13:06 -0500 (EST)
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
Date:   Tue, 18 Feb 2020 19:13:04 -0800
In-Reply-To: <CALH1-Xr3HVZzDn2-9EvmdiBWmxWQ-zfExM2LNJyR1wR+dgxRSQ@mail.gmail.com>
        (Robear Selwans's message of "Wed, 19 Feb 2020 03:43:26 +0200")
Message-ID: <xmqqv9o3gthb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF946128-52C5-11EA-816B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robear Selwans <rwagih.rw@gmail.com> writes:

>> Also, isn't "if (sb->alloc < sb->len)" too loose a check for the new
>> feature?  AFAICS in 1/2, a strbuf that is still borrowing a const
>> string always has sb->alloc==0.  Other instances of strbuf that
>> happens to satisify the above condition, e.g. (sb->len == 5 &&
>> sb->alloc == 1), is an error.  If we are to check the condition
>> about sb->len, shouldn't we diagnose such a case as an error, no?
> AFAIK after reading the documentation for `strbuf`, there is no other
> case where `sb->len > sb->alloc` as `alloc` needs to always be more
> than `len`. I'd like to be corrected if mistaken, though.

Yes, but the case that matters to _your_ use is sb->alloc == 0.  You
do not want to let a broken strbuf (presumably broken by changes
other than your own) to pass, when you can detect it.  And for that,
paying attention to sb->len _might_ make sense, but then the check
won't be 

	if (sb->alloc < sb->len)
		make it mutable;

you'd rather be writing something like

	if (!sb->alloc)
		make it mutable;
	else if (sb->alloc < sb->len)
		BUG("somebody fed a corrupt strbuf to me");

If the primary purpose of make_mutable() is *not* about catching
random strbuf corruption, then the whole "else if" part is not
needed, and the check should become a equation only about sb->alloc,
not a comparison between alloc and len (which would trigger for *both*
your const-initialized strbuf *and* a corrupt one you did not anticipate
to see).
