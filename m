Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B65C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 20:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09CC60C51
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 20:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhHWUZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:25:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59178 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhHWUZE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 16:25:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 556A6139C6A;
        Mon, 23 Aug 2021 16:24:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wTcncueAVoAX
        JmCqfG5OU/R0LM+3nFW6Ydxn5JeKgHA=; b=egUBYCYVlkViOPU5TTnEPu4RnwcN
        kUSmHZJh5vZH8lx8bJAYQNYGMkl0A4CX2vqCSB6AfudfF9VNImsVnN+0NRweQu/j
        igUVIwA2+pJUfIbfI6kNRa0uw5qYX44g0ufhyziktPD1INUtGCGPr0NTBHTaJ5Of
        7hS30njGSsEmDqY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D26A139C67;
        Mon, 23 Aug 2021 16:24:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 94239139C64;
        Mon, 23 Aug 2021 16:24:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>
Subject: Re: [PATCH] test: fix for COLUMNS and bash 5
References: <20210805194825.1796765-1-felipe.contreras@gmail.com>
        <20210806144911.GA1388237@szeder.dev> <xmqqmtpuik5m.fsf@gitster.g>
        <87sfz0fh8o.fsf@evledraar.gmail.com>
Date:   Mon, 23 Aug 2021 13:24:13 -0700
In-Reply-To: <87sfz0fh8o.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 23 Aug 2021 14:59:10 +0200")
Message-ID: <xmqqwnobq58y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 16188B36-0450-11EC-85BF-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Now that we're post-release are you interested in a re-roll of
> https://lore.kernel.org/git/cover-v3-0.3-00000000000-20210804T230335Z-a=
varab@gmail.com/
> + removal of the bash-specific checkwinsize added here, or would you

Let's wait until we see a concrete breakage report that shows that
checkwinsize is insufficient.  Even if such a second shell calls its
facility differently, as long as it works in a similar way and
another single liner like

    test -n "$BASH_VERSION" && shopt -u checkwinsize 2>/dev/null

we can keep piling such a single-liner next to each other, as the
number of shells we need to cater to would be less than a handful
anyway.

Thanks.
