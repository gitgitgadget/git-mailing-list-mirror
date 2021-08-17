Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0E3C4320A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 21:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D6016103A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 21:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhHQVtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 17:49:49 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:45590 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbhHQVtn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 17:49:43 -0400
Received: by mail-ed1-f53.google.com with SMTP id cq23so16245621edb.12
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 14:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJBFD4Mm/LRYUm44RcfaXv7o7sU3Ch59XAsTi/hbWw8=;
        b=SZsSabCiTrjCBJjgdx34mplf9HZ+4grU5PMwnvOAnnxDqQErckK9lNU1MSC6ZC7FyW
         Vl53c5wn01QRklSZi7BmwwY/j3UVDTS16D+lePlb7JbT76pLen5R3D4DAgCp6MRXpqtx
         kLxz/YdOeg+p40tQ4wq9GLG5dplvImq/+/icYogsDZkF5EJsbRinkZSHpGT9BnWE3pFI
         ift1zT0p6/fQRut4uJjJBCIYpt0yYIO0kMRHQp9+YAzbAysTdrf+8jGVz0Ela9zXdSNa
         NKLB1U6JdPVv8mzayTUwNMFxh057ypQ8kosBx+m56vsNG0mVnfUzvlMC01m1mJhJUW4H
         ksug==
X-Gm-Message-State: AOAM530uUO3gM8JGtve4Tggao8QChMYgRIZR8jEgPcmvMMOD6WwBZDQ4
        V7aCisoXchfcLMjxyZfq93szaUrd7CGIjjzOsXE=
X-Google-Smtp-Source: ABdhPJzCoGD4AYMYi9+k8rZyCVDdX7lXUngaUi1L1QWAYs31nNMB3QYjThr7YCEzzNeEYOKvCQVzxB4MkyB6U9LBcNI=
X-Received: by 2002:a05:6402:d7:: with SMTP id i23mr6204326edu.291.1629236942424;
 Tue, 17 Aug 2021 14:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210817110728.55842-1-bagasdotme@gmail.com> <nycvar.QRO.7.76.6.2108172327290.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2108172327290.55@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Aug 2021 17:48:51 -0400
Message-ID: <CAPig+cT5nPJ7NKFKXRQJwTzL13oEwzMBBpAa+P+XoZxO9SEKKQ@mail.gmail.com>
Subject: Re: [PATCH] make: add install-strip target
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        ak@linux.intel.com, Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 5:29 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 17 Aug 2021, Bagas Sanjaya wrote:
> > diff --git a/Makefile b/Makefile
> > @@ -3093,6 +3093,9 @@ endif
> > +install-strip: all strip
>
> Would those `all` and `strip` targets interfere with one another if `make
> -j2` was called? If not, wouldn't it be sufficient to let `install-strip`
> depend on `strip` alone?

A more pertinent question, perhaps, is why would we need
`install-strip` at all? What benefit does it provide over simply
typing `make strip install`?
