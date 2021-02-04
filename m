Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DDEC433E6
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 17:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7408664E27
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 17:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbhBDR4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 12:56:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56229 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbhBDRt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 12:49:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 177B71197F6;
        Thu,  4 Feb 2021 12:49:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tMUFvuOIw9EWbJ8m4/flkfPSpoE=; b=oe0di4
        pgLWqkEYTiY/Dl559Hj1yYzTDo+eBFhRuq0sJ/HyTeomkczB2C73RZj+RYL9MvWi
        O46JUpxsgacpTL+PrdxfEsw3WGCz0Clpnc0UPvQwz6q/b6n6MbGwAz4HngadqIaL
        EKkZVkAHw159zirLiEq6nWCd4YeU+8ZMDyf/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B/uwAmRl83NOd9YPZeCcGplH3miZyV1o
        99NIyxu3EDZwMT8AHfp3xbB6BnZnfkWazyF9n3CCJ9z0cxe1e69ucTWxJeLyGlOm
        7X9fmXxDb9SDC4wzNpRaFbae5zDYEBK9wF6MfbisgprLOWLYz3o97xBMnYxtZYeh
        V3h8H9x5FJA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E5501197F5;
        Thu,  4 Feb 2021 12:49:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5548B1197F4;
        Thu,  4 Feb 2021 12:49:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Makefile: add {program,xdiff,test,git}-objs &
 objects targets
References: <20210128182310.26787-1-avarab@gmail.com>
        <20210201111715.10200-1-avarab@gmail.com>
        <xmqqft2edkfg.fsf@gitster.c.googlers.com>
        <YBuc5iOCCHk4fPqs@coredump.intra.peff.net>
Date:   Thu, 04 Feb 2021 09:49:07 -0800
In-Reply-To: <YBuc5iOCCHk4fPqs@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 4 Feb 2021 02:06:14 -0500")
Message-ID: <xmqqo8gz910s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48840032-6711-11EB-91E3-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Feb 02, 2021 at 05:11:47PM -0800, Junio C Hamano wrote:
>
>> I do not see much point in the goal, not quite.  You can do "make
>> git.o" and "make git" and you do not have to build unrelated things.
>> ...
> I do like the cleanups earlier in the series (I have mixed feelings on
> the first patch, though; see my comments there).

Sorry that I forgot to say so, but even though I do not see much
point in the stated goal, I do not mind the clean-up changes in the
earlier parts of the series.  I just didn't see much value in doing
so, as a way to get to git.o (or "objects") target.

