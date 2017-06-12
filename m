Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8951F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 18:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbdFLSPT (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 14:15:19 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35436 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbdFLSPR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 14:15:17 -0400
Received: by mail-pf0-f169.google.com with SMTP id l89so54615582pfi.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=N4mYRDi//oBxBdZ/Fb/5QMmUHPHtolTy7NMTiuejq/M=;
        b=q8vUL0eFPybZnCLAsDbBXN+aBcVpHpw2P3A6wU4PNfSalNg4NMX7hinJI1xTM4hZTD
         0xmt+bBMN14+jF4NpI6/6zhKsG0jswsS2Ev02lnkKtebf+/o8iYVNtQmMFXoX+20AQ11
         h5DGW846V/xMQMdtfPZ/ccfMW1joWpGzKWif1khvfSWg2NzTw5HU4oOEXR0a3oaucntm
         hQ6j/Y7tig0uHBhN1oWfnUr4uwm2ZQ21j3/cKacKSNtN6f3CseJyAxoatYFYDGIDpiAU
         jMgZwTZIYRRvT+6c0gRQxFwilP+TpvTlEErb+ucA2iN1vfJhIP55BTGxAPVeNTus5tNp
         ezKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=N4mYRDi//oBxBdZ/Fb/5QMmUHPHtolTy7NMTiuejq/M=;
        b=p5KA5rS6d09uOvNFexjf0Xm/bm+pYPDuUOUg8pLjabYGc5+UzUNCVhCZgUgxlTU6XR
         ZaEwWDex+ek1MiO5ocIWuJiCms+/w+mRcq5RL3gJG+w1syAIfe6rJleriyWd7ZDUqU5o
         IdMDmvSzlRaMbO/28FUHC+F+qGWTvOlx+tqG42lfEN0oVj9UpRldxQGh3+/HLiYBwlGA
         aaDJ1WKIrQaRuqW/ylnOcowkzo9zKRYpVhotUD6htqJdvpWirLZXQi4gZZ7s4qei2oMR
         1FC6pBUGs6imRGkTlfev5XK5E90YgSJxvmutLvq9FyVfFuP6wBB8UJi39xOGCDbV1bSN
         uVOQ==
X-Gm-Message-State: AODbwcD6knxwsJ6uQq8jGXEXWFfhZSKm3burWi9zoOluSdAKRYTAIrQK
        g4uUu4AOTIzIeg==
X-Received: by 10.84.217.216 with SMTP id d24mr45728457plj.148.1497291316952;
        Mon, 12 Jun 2017 11:15:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id n71sm20097007pfg.46.2017.06.12.11.15.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 11:15:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ulrich Mueller <ulm@gentoo.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
References: <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
        <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
        <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
        <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
        <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
        <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
        <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
        <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
        <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
        <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
        <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
        <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de>
        <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
        <22846.51138.555606.729612@a1i15.kph.uni-mainz.de>
        <CACBZZX6AH2nEGPHMq6XOLDxr4SH9v-zT_YGovLXN_ZQ+fB345g@mail.gmail.com>
Date:   Mon, 12 Jun 2017 11:15:15 -0700
In-Reply-To: <CACBZZX6AH2nEGPHMq6XOLDxr4SH9v-zT_YGovLXN_ZQ+fB345g@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 12 Jun
 2017 19:53:21
        +0200")
Message-ID: <xmqqefupnkcs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Mon, Jun 12, 2017 at 6:56 PM, Ulrich Mueller <ulm@gentoo.org> wrote:
>
>> Please don't. Outputting invented information for something that
>> really isn't in the data is worse than outputting no information at
>> all.
>
> It's not invented information. %z being +0900 is the same thing as %Z
> being JST since +0900 == JST, just because some other things are also
> == +0900 that doesn't mean that JST is invalid or less useful than
> +0900 or "" for the purposes of human-readable output.

Ulrich is right.  The issue is not if JST is a possibly correct
answer.

GMT offset alone does not tell us anything about which one of the
zones that happen to share the same value is associated with the
committer (or author) time, and picking one at random to pretend
that we know more than we actually do is a disservice to the users.

