Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2C3C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BA62063A
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AASMaVaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410028AbgDOP6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:58:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51945 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410018AbgDOP6N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 11:58:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4FF8D1EB7;
        Wed, 15 Apr 2020 11:58:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=epAEB5aaJ6JK7sYTmX3VOJM3sHE=; b=AASMaV
        aByrVe3S8bLPx8WkL/kARurbZa7OFNgdnb4YX9HCTgym1zrs7zI9mHKCOSIDpaAK
        A9pvDzxPYts905sfS3zIxHAyIsnVSnC7fkVqbk0Za4F9XMoK31AAxP2c17FMxKOh
        ZSEGIgbomTJ2ggI4vnhir47cNfDC0JnMC+jGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hX5m5f1o7yCAYzTDNc+1mcZbJz1RfMot
        9CpI33e0cVC7pRuxr7zhBkYmT4h8C1Zu36fzQNhyOGEacN1MZqMkwkhCS2gbZs0q
        fPU1GB9IO4vXzsAcvdq/aZ/7pv5Gee0ov5j7ieOKwED0IRgKiDPNFtw8Et2/ir9Y
        6Ay6PozyLKk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D277D1EB5;
        Wed, 15 Apr 2020 11:58:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DA708D1EB4;
        Wed, 15 Apr 2020 11:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] date.c: allow compact version of ISO-8601 datetime
References: <20200414000324.GA2751707@camp.crustytoothpaste.net>
        <cover.1586856398.git.congdanhqx@gmail.com>
        <06e62c58d5accad7bbebbc51f9fb38fda83a73f6.1586856398.git.congdanhqx@gmail.com>
        <20200414202401.GC1879688@coredump.intra.peff.net>
        <xmqq5ze094gg.fsf@gitster.c.googlers.com>
        <20200415154157.GC2464307@coredump.intra.peff.net>
Date:   Wed, 15 Apr 2020 08:58:05 -0700
In-Reply-To: <20200415154157.GC2464307@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 15 Apr 2020 11:41:57 -0400")
Message-ID: <xmqqk12g7nci.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E585E774-7F31-11EA-AFF5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But I wonder if the new patch breaks the example from that commit
> message, which does work now:
>
>   [current version; the 17 attaches to "days ago"]
>   $ t/helper/test-tool date approxidate 12:43:50.17.days.ago
>   12:43:50.17.days.ago -> 2020-03-29 16:43:50 +0000
>
> It looks like the answer is yes:
>
>   [with patch 1/2 applied; now it's a fractional second]
>   $ t/helper/test-tool date approxidate 12:43:50.17.days.ago
>   12:43:50.17.days.ago -> 2020-04-15 16:43:50 +0000
>
> TBH I'm not sure how big a deal it is. The input is rather ambiguous for
> a strict left-to-right parser, and I'm not sure this case is worth doing
> more look-ahead parsing. But it's worth making a conscious decision
> about it.

True.  I do agree that this would qualify as a regression, but I do
not think we are breaking an important use case here.

> One alternative would be to restrict the fractional second handling only
> to the parse_date_basic(), which is quite a bit stricter. It shares
> match_digit() with approxidate(), so we'd probably have to pass in an
> extra flag to match_digit() to change the rules. It also means that:
>
>   2020-04-14T12:43:50.17
>
> would parse a fractional second, but:
>
>   yesterday at 12:43:50.17
>
> wouldn't.

That sounds less useful.  Somehow "yesterday at 12.43:50.17" looks a
lot more plausible real-user input that we would want to support
better than "12:43:50.17.day.ago".

> I do agree that year bounds are a questionable restriction. Right now
> Git's date code can only handle dates between 1970 and 2099, but it
> would be nice to change that.

Sure.  In both directions.
