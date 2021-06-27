Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C04C48BC2
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 11:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9291F61409
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 11:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhF0Lpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 07:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhF0Lpi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 07:45:38 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE700C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 04:43:14 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i17so14568705ilj.11
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iZMd8O7llVjXgl61SnFNmsriN9q728jF7+aeO3f4yJ8=;
        b=q2lNxzjc8VHP8u0rFAkUznju6acQ0d6fYAlLQ6zo0hlB/rMoro9+/vsHXREM/owQ8Z
         C5t8S6Td1uVhoJms3jTKYotUntRiqthrYgDYHmH4oKfV2PcF23sx7ORP5imXtzFI8XA6
         jqZuuhUNyBtprO+ip1giyB/iKzbDSrcPb6+YoFBpEPu24E6CltCmjzgn9I04i1EsD5xI
         RE1dBPNSJhjGuOmONNGUh++QEONsy8Jv7TJYFodwVU04lKeThXlCHXvAA4RxZsA30vPj
         Ltz5YD3S8m9s/T67nk5oXnxi7r1vLtDMcCCE74V2CYHoKKr7Fw7it444dcFjhJcHmP6u
         /NiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iZMd8O7llVjXgl61SnFNmsriN9q728jF7+aeO3f4yJ8=;
        b=NPvMMD1Blrqs4eHska07o2bZyFLlNUlmxUbo5lNYB5FuifDz3QFdrDS7ilKsbjJLgm
         DwEZqQeLF5jG4n9s02Ccy2YlftSgzxRFQlU4QPLSbB3QW2ZsIdXD1lI+hOmeE8QdX8Fa
         pFzsBdhfFlTdBouBl/BE5qkdjjRY+uQtV84j2fPZTBLWp5l6WdBqn12HcPtbCLJO8Akl
         AjSyPSxVhalmIgQGtdNgWb6ka1i3Wf4gmSjKNO2k1iTXHbINX999XztCL1WN8hbm+699
         xzdjWPRU8Kyul9Q3O8GnYWUS8dswBBg44kywSm//zTyj7kAle9l09jCT0jojEyuUfK16
         FFQQ==
X-Gm-Message-State: AOAM532963V47812/wS6k6JK0YqKWqbdqyl9lcdyN1IqFtaMNAev1/BQ
        A3uIgeX3j4QniluOcCn3BXv5jdUmrnaPR3fn1zQ=
X-Google-Smtp-Source: ABdhPJydvWHgIwBOFHxeVjNpOwvkzdnkso3JfGJiIzmE9icUVJggjiueEvvSemvEPdWYW3giWo2qSx1wKuqBXVedTx0=
X-Received: by 2002:a92:c8d2:: with SMTP id c18mr14078764ilq.301.1624794193512;
 Sun, 27 Jun 2021 04:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
 <pull.980.v5.git.1624636945.gitgitgadget@gmail.com> <4e473838b9d2651a8e4be27332697c2ba354db5a.1624636945.git.gitgitgadget@gmail.com>
 <946c95bc-d57a-5b55-0dcf-5c4d6f980396@gmail.com>
In-Reply-To: <946c95bc-d57a-5b55-0dcf-5c4d6f980396@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 27 Jun 2021 19:43:02 +0800
Message-ID: <CAOLTT8TK4cC1P-h+=wag8OdPc3C_Acd-dHY55NuA48UuuABAiA@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] [GSOC] ref-filter: add %(raw) atom
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8826=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=888:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On 25/06/21 23.02, ZheNing Hu via GitGitGadget wrote:
> > Note that `--format=3D%(raw)` cannot be used with `--python`, `--shell`=
,
> > `--tcl`, and `--perl` because if the binary raw data is passed to a
> > variable in such languages, these may not support arbitrary binary data
> > in their string variable type.
> >
>
> Commit message looks OK, but...
>
> > +Note that `--format=3D%(raw)` can not be used with `--python`, `--shel=
l`, `--tcl`,
> > +`--perl` because the host language may not support arbitrary binary da=
ta in the
> > +variables of its string type.
> > +
>
> Seems like out of sync between commit message and the docs change above.
> Did you mean the (unsupported) host languages are Python, BASH script,
> TCL/TK, and Perl respectively? If so, the docs should say:
>

Indeed so. I will change them too.

> "Note that `--format=3D%(raw) can not be used with `--python`, `--shell`,
> `-tcl`, and `--perl` because such languages may not support arbitrary
> binary data in their string variable type."
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara

Thanks.
--
ZheNing Hu
