Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA2D1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 22:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760324AbcLAW0l (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 17:26:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63821 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932167AbcLAWZs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 17:25:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C93653BB5;
        Thu,  1 Dec 2016 17:25:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PsthLejX7Pwd6qCUIx67dn/bgjw=; b=oUrVM6
        /urSYjnxVLvaCk+5vpmqbBX/TXJ91Mv2jG//1AmFfSia8as2/X0hnNtuM4UyC0zt
        m0iGpU9GGVmWltegiEY6fWZhQRyx176141y9Dnc6vgp7pN/iuCE7L/BAqaitQ23k
        WYt4GsP51q2cQToJCH30m1dDzOWIF+LvpD4ms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eU6svk5EUP72d87vtt5OqMBBfYOmtlMK
        q80FuHxkDAfn8wBqsZAPLxJweSc4e3Hv/3d9S3pb3UEuriDI9vN9AtvRy7yw16mH
        cddpPREJEIgDXuHsfRKW3VJKPfxUy1CxnwXvO4ERKTBzhRKLhkErK3wot2kScJDD
        wm+FYNKdnaA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 154A853BB4;
        Thu,  1 Dec 2016 17:25:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88C1153BB3;
        Thu,  1 Dec 2016 17:25:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to is_transport_allowed
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
        <1480623959-126129-1-git-send-email-bmwill@google.com>
        <1480623959-126129-5-git-send-email-bmwill@google.com>
        <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
Date:   Thu, 01 Dec 2016 14:25:45 -0800
In-Reply-To: <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 1 Dec 2016 16:40:04 -0500")
Message-ID: <xmqqpolb70d2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AE485A2-B815-11E6-8B65-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Dec 01, 2016 at 12:25:59PM -0800, Brandon Williams wrote:
>
>> Add the from_user parameter to the 'is_transport_allowed' function.
>> This allows callers to query if a transport protocol is allowed, given
>> that the caller knows that the protocol is coming from the user (1) or
>> not from the user (0), such as redirects in libcurl.  If unknown, a -1
>> should be provided which falls back to reading `GIT_PROTOCOL_FROM_USER`
>> to determine if the protocol came from the user.
>
> Patches 3 and 4 look good to me (1 and 2 are unchanged, right? They are
> already in 'next' anyway, though I guess we are due for a post-release
> reset of 'next').

Yes.  I am planning to take a day off tomorrow, and probably will
rewind 'next' sometime this the weekend.

I agree with the comments you made in the remainder of the message I
am responding to, so I'll snip it.

>> diff --git a/http.c b/http.c
>> index fee128b..e74c0f0 100644
>> --- a/http.c
>> +++ b/http.c
>> ...
>
> This is better, but I think we still need to deal with http-alternates
> on top.
> ...
