Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10EA31F405
	for <e@80x24.org>; Tue, 18 Dec 2018 21:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeLRVaX (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 16:30:23 -0500
Received: from 0x63.nu ([109.74.10.199]:58838 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbeLRVaW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 16:30:22 -0500
Received: from localhost ([127.0.0.1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gZMwT-0004Aw-87; Tue, 18 Dec 2018 22:30:17 +0100
References: <20181028125025.30952-1-anders@0x63.nu> <20181208163647.19538-1-anders@0x63.nu> <20181208163647.19538-3-anders@0x63.nu> <xmqqa7ldkbwr.fsf@gitster-ct.c.googlers.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v4 2/7] pretty: allow %(trailers) options with explicit value
In-reply-to: <xmqqa7ldkbwr.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 18 Dec 2018 22:30:04 +0100
Message-ID: <87o99iwmjn.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano writes:
> That way, we can handle %(trailers:only=bogo) more sensibly,
> no?  Syntactically we can recognize that the user wanted to give
> 'bogo' as the value to 'only', and say "'bogo' is not a boolean" if
> we did so.

I agree that proper error reporting for the pretty formatting strings
would be great. But that would depart from the current extremely crude
error handling where incorrect formatting placeholders are just left
unexpanded. How would such change in error handling be done safely, wrt
backwards compatibility changes?

To get good diagnostics for incorrect formatting strings I think the way
forward is to have the formatting strings parsed once into some kind of
AST or machine (as also mentioned by Jeff) that is just executed many
times, instead of parsed each time like today.

 anders
