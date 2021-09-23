Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9262C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE05761242
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhIWV4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:56:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63206 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238517AbhIWV4T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 17:56:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A28E4160C75;
        Thu, 23 Sep 2021 17:54:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pP27btCtN710C9yDSjO+KGE7og28LDvnsYX8CN
        ZHSDs=; b=TEHgPlek5Xg1vrYP/SXTvXhLjWHI8JxFMyjXHZNKQmG6AOkivt+iHo
        qMGVw5qrka/gOE4CH8wIz9bTyOS2/8yOV7eOnLtUT+kNSezKI4vUeXJ0qGgcQlNU
        tLJRyToH5BSpTnVPAdJeTJbYKc+X+t9DToIDtIeh6Oenc6b86+tRc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B81F160C74;
        Thu, 23 Sep 2021 17:54:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E4FE4160C73;
        Thu, 23 Sep 2021 17:54:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     The Grey Wolf <greywolf@starwolf.com>, git@vger.kernel.org
Subject: Re: ANSI sequences produced on non-ANSI terminal
References: <20210923052122.2F655CE@eddie.starwolf.com>
        <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
Date:   Thu, 23 Sep 2021 14:54:43 -0700
In-Reply-To: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 23 Sep 2021 17:20:04 -0400")
Message-ID: <xmqqmto3x8ik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD087F78-1CB8-11EC-8178-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Sep 22, 2021 at 10:21:22PM -0700, The Grey Wolf wrote:
>
>> Anything else you want to add:
>> 	I searched google and the documentation as best I was able for
>> 	this, but I am unable to find anywhere that will let me disable
>> 	(or enable) colour for a particular term type.  Sometimes I'm on
>> 	an xterm, for which this is GREAT.  Sometimes I'm on a Wyse WY60,
>> 	for which this is sub-optimal.  My workaround is to disable colour
>> 	completely, which is reluctantly acceptable, but it would be nice
>> 	to say "If I'm on an xterm/aterm/urxvt/ansi terminal, enable
>> 	colour or cursor-positioning, otherwise shut it off."  If this
>> 	seems too much of a one-off to handle, fine, but most things that
>> 	talk fancy to screens are kind enough to allow an opt-out based on
>> 	terminal type. :)
>
> Git doesn't have any kind of list of terminals, beyond knowing that
> "dumb" should disable auto-color. It's possible we could expand that if
> there are known terminals that don't understand ANSI colors. I'm a bit
> wary of having a laundry list of obscure terminals, though.
>
> If we built against ncurses or some other terminfo-aware library we
> could outsource that, but that would be a new dependency. I'm hesitant
> to do that even as an optional dependency given the bang-for-the-buck
> (and certainly making it require would be right out).

I was wondering if Gray Wolf can run screen on the Wyse, and then
wouldn't git see TERM=screen which is pretty much ANSI if I am not
mistaken ;-)?
