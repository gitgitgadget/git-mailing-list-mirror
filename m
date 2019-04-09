Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4873320248
	for <e@80x24.org>; Tue,  9 Apr 2019 08:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDIIps (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 04:45:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40837 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIIps (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 04:45:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id h22so14169934edw.7
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 01:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=e/WsRLl7E7qeuq2WBG3JfSbtI3aiCwcMBPfJmpQDtWI=;
        b=jVTOXD1/jrdYoldQIYCv6iD20uFyWyPGP26zCE1H1rqEvt144M+E0s/kCrMBcfp79J
         1UDQs5McmUx6IdDI8YayPPnqEk5xkbb0tnzkKK7klUItOP0m56fnmM3ciUcZS3KC3QPR
         eCfm2R6wyobP5rpIBTi89tezIqIzI2ot6g0zVWw9XXtap/XfETQeI4PVvjzDsMxwUYuR
         EFIuXtFoALo4I67+GC8Hldl8iP+IVUtHGl4gmJ5RYt/1T5p0UaOWOST+7n3Yt5FcrhUl
         Lqu2iFr1knraE3dt/lZoMaZGS70g9CsLm2ndLoul1WFwI0u52LTEsICEBnh816iflyg1
         dPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=e/WsRLl7E7qeuq2WBG3JfSbtI3aiCwcMBPfJmpQDtWI=;
        b=PZiFksTb5bFAq+GA6TxGw5ra+HqwRBkzOLaiPW2r9pM604xy0w3lucx4QxPsex+ASM
         zRbLdiIhAszDDn+l8GdQG118A7+WOFiSF9krQDT+wjiLwtxDE5y3UP2R398gxfiH4zB8
         sSNnGp0j1kweLYU4Ul6wSa9YW0hBhPcMmVAmikftzO1rvTtJX6gFGQdNo8Dpw1eeVEQp
         GV8dcZngPrb2DsLYFKUmM1dPVwx/+QbrsSHm8k5hdb5EgSTmDZqZRoTje0v+bfnaKCfH
         1i/LLzYejPTB0B0CNLW4vpf5Lpd8lvvyHClUKgjmAKCHDxKJozkQjXaAn88FU2yJlSlh
         JSDQ==
X-Gm-Message-State: APjAAAU9ykJ9PyCvijkMyNpmXxKm4G7L3k9hS1Fqm+LRR/Nf90RSEO47
        ij66ae/LQ5eydiKP56IBAy8=
X-Google-Smtp-Source: APXvYqyD5IUlrkzfL+kw1+dYc1ZUnr725LxpN8JVQrO2s51VnyEfMx7HFZJUoAGh17xoHK/bGL9rrA==
X-Received: by 2002:a17:906:b756:: with SMTP id fx22mr13279741ejb.192.1554799546640;
        Tue, 09 Apr 2019 01:45:46 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id v1sm5927570eja.7.2019.04.09.01.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 01:45:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2] sha1-file: test the error behavior of alt_odb_usable()
References: <20181204132716.19208-2-avarab@gmail.com> <20190328200456.29240-1-avarab@gmail.com> <20190329134603.GB21802@sigill.intra.peff.net> <87pnq9aipl.fsf@evledraar.gmail.com> <874l78a3rz.fsf@evledraar.gmail.com> <xmqqimvn7fnt.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqimvn7fnt.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 09 Apr 2019 10:45:45 +0200
Message-ID: <8736mra7nq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 09 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Yup. Just wanted to get the patch to test what we do *currently* out,
>>> might loop back to finishing up the rest of this.
>>
>> Junio: *ping* about picking up this trivial test coverage improvement
>
> I was waiting for you to make up your mind about your earlier "might
> loop back to finishing up".  For a topic like this, for which the
> ball has been in your court for a long time, just resending would be
> easier to handle than pinging, as I do not remember much about the
> original attempt anyway ;-)

I don't know when I'll get to finishing the rest of it.

I'll leave it up to you if you want to queue just the test patch or drop
it. I figured I'd re-send just that since I figured just fixing the
blindspot of the current behavior would be a good thing on its own, not
as an endorsement of the current behavior, just a "this is the current
known behavior" regression test.
