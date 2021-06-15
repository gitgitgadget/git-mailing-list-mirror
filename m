Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B852C2B9F4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7F8613F9
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFOCgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:36:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55259 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFOCgP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 22:36:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12E55C6774;
        Mon, 14 Jun 2021 21:17:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G8mpYis4ZDVZZnNBdiyUCy+fmg0ln7imkmwtv3
        ITRpM=; b=E5+/r9W5CtKvla17ptl2xeqDgDh35a3JpVNXCrOSSgc8KWh4ktrQtV
        k7yBQbB2lL/1Oh0XCmqQhbNVAMsjjdxCDyvdaApX2P2O5L0A2WojioYN3bNG7blz
        CFVEXsybkw0ck/pPbYSgP7JhOftbt7Nz9b9nG3eJCd5Y6WW+Da+jw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09DD5C6772;
        Mon, 14 Jun 2021 21:17:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B181C6771;
        Mon, 14 Jun 2021 21:17:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] sideband: append suffix for message whose CR in
 next pktline
References: <87im2s5jjm.fsf@evledraar.gmail.com>
        <20210612050711.4057-4-worldhello.net@gmail.com>
        <xmqqim2hyuj1.fsf@gitster.g>
        <CANYiYbGtfgZepnfTWGjbmOh2bxa8tZ7bvgtVTo6qTQpCP9MPag@mail.gmail.com>
Date:   Tue, 15 Jun 2021 10:17:51 +0900
In-Reply-To: <CANYiYbGtfgZepnfTWGjbmOh2bxa8tZ7bvgtVTo6qTQpCP9MPag@mail.gmail.com>
        (Jiang Xin's message of "Mon, 14 Jun 2021 19:51:23 +0800")
Message-ID: <xmqqk0mwylhc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81B4EF70-CD77-11EB-AC59-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

>     /*
>      * Let's insert a suffix to clear the end
>      * of the screen line, but only if current
>      * line data actually contains something.
>      */
>
> So my implementation is to try not to break the original
> implementation, and keep the linelen unchanged.

I knew what you wanted to do from your code---I am questioning if
that "only when something is there" was really sensible, or if it
was just attracting bugs.

Thanks.

