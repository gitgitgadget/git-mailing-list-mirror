Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DEF11F461
	for <e@80x24.org>; Tue, 23 Jul 2019 21:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbfGWVLA (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 17:11:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59421 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbfGWVLA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 17:11:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22BFC76F94;
        Tue, 23 Jul 2019 17:10:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xdt6iqLoYZT8erOtxtA5kvHemU8=; b=MwNGlM
        pNpm/yjQEI3VslT382WDLM2+2TbdUQiID3q4OoshcP6WrPtWU5NZ5Krqcue0bcZe
        37YbtT7B183/Z5GXuiqYIIT7iETCKomzIWzojBugRbLgvzW3llfxsI4bwGZ+g8IJ
        +SBP7rj/ZtcRMi8f0kacKjstCT36O5NDKxhwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JLBHTTdvxbaPnAQOkL/0VrhfgN2o2G5a
        oLWiHPaxYvtUhsJvZOchf2dvclhPA3QAH+hMYMkS/Y2KY1IWo8FCrmL08YrL7HKw
        FRHMqFH8NyEctGJftn3805oZ4Z+FB5gVM0hK+Ate781BO4sIrpinMCCzRDsX6N2S
        Gmd7098C1MU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 19D1976F93;
        Tue, 23 Jul 2019 17:10:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3DEE076F88;
        Tue, 23 Jul 2019 17:10:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     thibault.jamet@gmail.com, git@vger.kernel.org,
        thibault.jamet@adevinta.com
Subject: Re: [PATCH] Close transport helper on protocol error
References: <20190722212250.44011-1-thibault.jamet@gmail.com>
        <xmqq5znsu04p.fsf@gitster-ct.c.googlers.com>
        <20190723194009.GB3879@sigill.intra.peff.net>
Date:   Tue, 23 Jul 2019 14:10:53 -0700
In-Reply-To: <20190723194009.GB3879@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 23 Jul 2019 15:40:10 -0400")
Message-ID: <xmqqimrssbhe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C0AE10E-AD8E-11E9-9480-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...
> At which point I do wonder if this is better handled by a wrapper
> process which simply reaps everything. And indeed, people have already
> come up with similar solutions for containers:
>
>   https://github.com/Yelp/dumb-init
>
> So I dunno. I am not really opposed to this patch, as it is just adding
> some extra cleanup. But it seems like it is really hitting the tip of
> the iceberg, and I'm not sure it's an iceberg I'd like to get to the
> bottom of.

Thanks for stating what I had on mind a lot better than I said ;-)
