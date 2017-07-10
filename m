Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6815B20357
	for <e@80x24.org>; Mon, 10 Jul 2017 21:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754420AbdGJVqU (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 17:46:20 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35194 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754020AbdGJVqS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 17:46:18 -0400
Received: by mail-pg0-f49.google.com with SMTP id j186so55732249pge.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 14:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JTcnFmfZSgrYFVPJNOWptpDsTyEYvahTEoNlyVSdyrc=;
        b=uQXXyaukCSG2yQza9MYAjRul/bQ08ej/ZtB7h4EF+ntuWVLwsqgtLO+1dx0gyj3jzf
         ijeUDr0o+UyQaee4myWz4fTAEzBUzQvYoQSPmY2kIN5C4CF6mZvEgAV+F/mGyD8/lxyT
         5rEkkko+aJ1se9Nx3y9uqNLjqKKw6LLx1bnxCsD84z58XcU0akuW8mElYVWvULDN/QWg
         5dcn3IXhvNhEiygsUEAuA8F2vZh1p1+DszhnrPHiKcN/JV9I5CVMKwOV5daT13xbopiP
         DliN2BmVeAkDsNRIc2gYMLeQl9or0rbpsI/i/p5Y382j2WPDV7fYpynwVZgAaSufRqMg
         HRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JTcnFmfZSgrYFVPJNOWptpDsTyEYvahTEoNlyVSdyrc=;
        b=MqctNBYejJ5qv3sCaxBPnPFAac54qHNxmhCtz22CxKWefjaCHAezKtu38mZi6dQT+t
         rATV2w0See9g1JPU379t7eDNvp+k4FVRZYfx6lgCHZTx2P5FKWHEcru5Cfpz8/t0sGtW
         OU2PmoS5g8i4+wRGzDouLsT1jrXZ14Bzan9lOGNDvMjb3030ALuEgL6zYTuzC3iimZMS
         Odr3Sb0/A4nuk88oVEj6A4aXF8PJcj00u29+GMAOiMUZSm/fOESHYTBx7r292SJwQYTk
         nQ0x5BGXQqdZus47rGsHDR/YYIMJJE/vwS0oD1eE1Qu89wfCth8AYqGPENt2qKuHTeYP
         R4nw==
X-Gm-Message-State: AIVw112tDRChV7so56Q6AOf6S8W8rRnCRnfK3o3MWvzmj82qRACIgy/Q
        BNIPM8JCSsPRVA==
X-Received: by 10.98.93.136 with SMTP id n8mr46669957pfj.211.1499723178209;
        Mon, 10 Jul 2017 14:46:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id v70sm26507754pfi.110.2017.07.10.14.46.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 14:46:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
        <xmqqr2xo6y2s.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbbqj++1HZVY3gBaghn+knWa+cAgwWUw9Z+zdNkjQHCWg@mail.gmail.com>
Date:   Mon, 10 Jul 2017 14:46:16 -0700
In-Reply-To: <CAGZ79kbbqj++1HZVY3gBaghn+knWa+cAgwWUw9Z+zdNkjQHCWg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 10 Jul 2017 10:33:37 -0700")
Message-ID: <xmqqtw2k3qzb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Jul 10, 2017 at 9:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Credit goes to Brandon for spotting it, but the introduction of
> "trailing comma at the end of enum definition is allowed in c99"
> is e1327023ea (grep: refactor the concept of "grep source" into
> an object, 2012-02-02) IMHO, which is more time that proved this
> feature being supported on all compilers.

Yup, I did dig down to that commit earlier when I wrote

  https://public-inbox.org/git/xmqqlgolm2jk.fsf@gitster.mtv.corp.google.com/

I just forgot about it, as very many things going on the list ;-)

Thanks.
