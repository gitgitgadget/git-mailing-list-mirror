Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DC8C07E9C
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B705761378
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhGNQ0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhGNQ0x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 12:26:53 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A52C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 09:24:01 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id r16so2154922ilt.11
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 09:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jFLafLjcfqBAthlsV++7p8TlvCoSAtga3g5/urOeWLc=;
        b=t7KBqCH1rn5RIWzm0YsSTEiJFlGKbOEoRzrqvrOKYkv+mFzmBi2cPA/ZpoUXq65wis
         BBwPiHKaHhlV6RpjcTh7rjIaDC3z/DEcQqveyJq6eKzOrKIldR9xjUUj9QvxGzEujcsB
         AlhRs/IrP6J36NOaFbmQBpYZQA0XJPci8mhp5iDaP8MfrwLzDMjxF3tg6C5RWq24lWhc
         nzIjd9bj2on3N/BpASDG6jmiFUau7iizwhbW0opkyP88q43GINjGxvpNeUz9BR5YXHgm
         rXLf7qu6DunW8BWc5/NwYpF8Vvi7euZ8qS+i8L7G2CGoqvR00up1MI/QCR7oCKMDjCRA
         rvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jFLafLjcfqBAthlsV++7p8TlvCoSAtga3g5/urOeWLc=;
        b=eYO3w5iWJdy3wzci+rUpD8Tt/nV9m7GIazyxK53w/EmKO/K+Pc6TJbQdCHb6zgkwvA
         BMZaQRc3IXi7nq94LqSA6P/jeuye2W80pUOJSKfKwh3yOaSRplkW/FCY4p65jaKkQSX5
         tZ2rNqr/A0z0SZsrf0uMGziyE6ZJYxnMC7TN4PRHAcOtLc5EMJI71OXgGp6JIipjh3Bd
         k/WOy4foGPOmX7sxICKOZDKAtEpo0OJMWR7qmrRMnWvPBju1ViHwlSI3GMQ4jPw8ueds
         f5pEkCZ1cIMfwV7mz2C/QWnUSSCCT/bDEyLMftVVr93RmAxP1bWhCbo/fsg/5NiDn+8x
         SnDQ==
X-Gm-Message-State: AOAM531vw1blXdUf7AI7cSeXyx9TmjWL5CVOhTl+58gGGr7BTi8Dcr8x
        HO5ZY/YN38kvHrRIYuuL5dg0z4fbrGFv4IQYTFk=
X-Google-Smtp-Source: ABdhPJwSPJbtpHHhu9r9Q7VA1kwz8nB7QQG/280k2kwwy/G+PAjnX7FnAKoXqWXXcIXTL2OjTw0N2rB5NkUOddTO/ag=
X-Received: by 2002:a05:6e02:114e:: with SMTP id o14mr3709894ill.301.1626279841430;
 Wed, 14 Jul 2021 09:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
 <70e83e4ba3cc8a55bb8d90cb2c581cd04ac116d4.1626090419.git.gitgitgadget@gmail.com>
 <CAP8UFD0vHw8cK90RbOUcrAcxNKiHVTMX0VEiK8+MNyHH0CNm4A@mail.gmail.com> <xmqqtukz2rp4.fsf@gitster.g>
In-Reply-To: <xmqqtukz2rp4.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 15 Jul 2021 00:24:14 +0800
Message-ID: <CAOLTT8RR4+tUuT2yc2PDL9NwCburW8bM_Sht6nhKJ_fYV8fGsQ@mail.gmail.com>
Subject: Re: [PATCH 14/19] [GSOC] cat-file: reuse ref-filter logic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=884:38=E5=86=99=E9=81=93=EF=BC=9A

>
> Christian Couder <christian.couder@gmail.com> writes:
>
> More importantly, why is such a fast-path even needed?  Isn't it a
> sign that the ref-filter implementation is eating more cycles than
> it should for given set of placeholders?  Do we know where the extra
> cycles goes?
>
> I find it somewhat alarming if we are talking about "fast-path"
> workaround before understanding why we are seeing slowdown in the
> first place.

There is no complete conclusion yet, but I try to use time and hyperfine te=
st
for these commits (t/perf/* is not accurate enough):

---------------------------------------------------------------------------=
-------------------------------------------------
|                        subject                                  |
--batch-check (using hyperfine) |   --batch(using time) |
---------------------------------------------------------------------------=
-------------------------------------------------
|[GSOC] cat-file: use fast path when using default_format         |
        700ms                |          25.450s      |
---------------------------------------------------------------------------=
-------------------------------------------------
|[GSOC] cat-file: re-implement --textconv, --filters options      |
        790ms                |          29.933s      |
---------------------------------------------------------------------------=
-------------------------------------------------
|[GSOC] cat-file: reuse err buf in batch_object_write()           |
        770ms                |          29.153s      |
---------------------------------------------------------------------------=
-------------------------------------------------
|[GSOC] cat-file: reuse ref-filter logic                          |
        780ms                |          29.412s      |
---------------------------------------------------------------------------=
-------------------------------------------------
|The third batch (upstream/master)                                |
        640ms                |          26.025s      |
---------------------------------------------------------------------------=
-------------------------------------------------

I think we their cost is indeed from "[GSOC] cat-file: reuse ref-filter log=
ic".
But what causes the loss of performance needs further analysis.

Thanks.
--
ZheNing Hu
