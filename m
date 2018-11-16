Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787811F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 17:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeKQDzP (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 22:55:15 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37712 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeKQDzP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 22:55:15 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so629864iti.2
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 09:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LqN0MIR/CHvalQ+bZ2TIuR3e3yEGdVZ1q/qeYY1mL/I=;
        b=Cl7FP3U36i6chart9ltfmCljM5b5baNMBO8i+nNl0uHbA/SZGdXhuI+EjVhSQBGBRv
         XE18OgrBv2f2krh4sRD1dlo3cACDwb2bh1O9Wf/0AtIBhErlkvJEoSo8mzytOxHp9LMz
         4UNHJYzxcJ6tnwMMFGWg62wXMCiq9/00EOMn1pVbb4nmyiVuE9grYTCG0NPMfM0SMpS2
         uyt57QUb4QCY/HZw2M+RUCPZMutY7LXKbmPncQibwweZwyEfVgIgHBwlqeh9J22bXslQ
         lWREqX2gqCLEz6tkleWM1Y4rViZ7DErXJF5iRO5es7w03ZNdJjzkuSvGZbbKEvLVD1Iq
         W8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LqN0MIR/CHvalQ+bZ2TIuR3e3yEGdVZ1q/qeYY1mL/I=;
        b=N9i2CRDn07thbAFH4igkJT+fFHj2N6/3VGjsNZI6pYLTj2FTOvXbrlC+tjMx0N5tgm
         2VrOlp0A4s2KL+scKP7J4Xt5GoGMJw3ZbcDcDx3Ged5qd25JsYj11g97dEpG3cuarNib
         C6aD8jluOsg/WhnS/+GueNls+ktRMG6zzEBm/qMwlzQwkXhf66Nv3ECc+RBs8B60WufL
         ZnJtFlj4ukU5cjBQpyfbrvw6PE2kTXZdZV5w7tnHAYvf+mK7D9Ltp6rPOejGxwpKmbBX
         FF0snkGYrP0tiyn6inf5+LtRkn7dQorPq/9NnMTpojbL3g9ZKLuMtNgdyomYbYb5glHS
         G8lA==
X-Gm-Message-State: AGRZ1gK9KxBa26VvrKD7r2EWThSob/djg15f3QkyOxRnkdWNTwHW+wEe
        LVfPJ41RWI6yCRfNwy288TOXpU7XlTpX21dfak8=
X-Google-Smtp-Source: AJdET5f2fpDoF/o2pA+MGQx688r5+KWQMw5lW8VWl+8rc13sCAbXNZTOVaNVdl9/rrYHwhsV5ekx1i32gfw+ne9mT9M=
X-Received: by 2002:a24:dd3:: with SMTP id 202-v6mr2839701itx.54.1542390115870;
 Fri, 16 Nov 2018 09:41:55 -0800 (PST)
MIME-Version: 1.0
References: <874lcl2e9t.fsf@evledraar.gmail.com> <20181113153235.25402-1-avarab@gmail.com>
 <CACsJy8CaAC0UP+VxYU7zbdQc6DtKYa-FzOnbpNf+_P2L3zfUvQ@mail.gmail.com> <8736s43mps.fsf@evledraar.gmail.com>
In-Reply-To: <8736s43mps.fsf@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 16 Nov 2018 18:41:43 +0100
Message-ID: <CAP8UFD1Nd657Afgk6s+uNXMW=26Fg-6Jnv6ngB1biUX2mGBkSw@mail.gmail.com>
Subject: Re: [RFC/PATCH] read-cache: write all indexes with the same permissions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 6:34 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Nov 13 2018, Duy Nguyen wrote:
>
> > On Tue, Nov 13, 2018 at 4:32 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> > I don't have any bright idea how to catch the literal _XXXXX file.
> > It's a temporary file and will not last long enough for us to verify
> > unless we intercept open() calls with LD_PRELOAD.
>
> Sorry for being unclear. I don't mean how can we catch this specific
> bug, that would be uninteresting and hard to test for.
>
> I'm asking whether the bug in this patch isn't revealing an existing
> issue with us not having any tests for N number of sharedindex.*
> files. I.e. we have >1 of them, merge them and prune them, don't we?

I think we shouldn't have many of them. Usually we should have just
one, though it's possible that switching the shared index files
feature on and off several times or using temporary index files could
create more than one.

And there is clean_shared_index_files() which calls
should_delete_shared_index() to make sure they are regularly cleaned
up.

Anyway it's a different topic and according to what we privately
discussed I just sent
https://public-inbox.org/git/20181116173105.21784-1-chriscool@tuxfamily.org=
/
to fix the current issue.
