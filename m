Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2C301F453
	for <e@80x24.org>; Tue, 29 Jan 2019 21:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfA2VXQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 16:23:16 -0500
Received: from 0x63.nu ([109.74.10.199]:41914 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbfA2VXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 16:23:16 -0500
Received: from ip6-localhost ([::1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1goaqd-000205-2s; Tue, 29 Jan 2019 22:23:11 +0100
References: <20181028125025.30952-1-anders@0x63.nu> <20181208163647.19538-1-anders@0x63.nu> <20181208163647.19538-3-anders@0x63.nu> <xmqqa7ldkbwr.fsf@gitster-ct.c.googlers.com> <87o99iwmjn.fsf@0x63.nu> <20190129165523.GA7349@sigill.intra.peff.net>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Jeff King <peff@peff.net>
Cc:     Anders Waldenborg <anders@0x63.nu>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v4 2/7] pretty: allow %(trailers) options with explicit value
In-reply-to: <20190129165523.GA7349@sigill.intra.peff.net>
Date:   Tue, 29 Jan 2019 22:23:10 +0100
Message-ID: <87pnsfkvk1.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Jeff King writes:
> There's some small value in leaving
> %X alone if we do not understand "X" (not to mention the backwards
> %compatibility you mentioned), but I think %() is a pretty
> deliberate indication that a placeholder was meant there.

Good point.

> We already do this for ref-filter expansions:
>
>   $ git for-each-ref --format='%(foo)'
>   fatal: unknown field name: foo
>
> We don't for "--pretty" formats, but I do wonder if anybody would be
> really mad (after all, we have declared ourselves free to add new
> placeholders, so such formats are not future-proof).

Oh my. I wasn't aware that there was a totally separate string
interpolation implementation used for ref filters. That one has
separated parsing, making it more amenable to good error handling.
I wonder if that could be generalized and reused for pretty formats.

However I doubt I will have time to dig deeper into that in near time.
