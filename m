Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7752C433EF
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 13:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiFZNB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiFZNBt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 09:01:49 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B111A12
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:01:48 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a16so4392180ilr.6
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HcNfzyGaYYQWkaGQWCyxBDFlShvCOR6ybwytabkLrqA=;
        b=FhXBFHCgUYzaFbq4eUcdBbgsvyjyoLTfwPnhRyf8AD25ugaE1PywmfRDJsrQY+udTy
         hCO7KXhQe1fabcSSHkVy48ShnRIcuIZZp0PWqLXlB7DRNXGu4M2MCF/EyXh4iFZWMEM6
         mv7nDtO/FEkjuWkXP0pCdqtuo46GbTNeyWZaErJ2lvSkDd4cofZZQDb0RC3Sg9mqrs0V
         260SAlfFRW+hbGGa8TAxIHftIHYlgQDMipYIWsiUCkNTu++tjsRbmDHoLnnGhnAub0W5
         gEt8LzDNm3aDDxcI9qYBgnT4CfT0etzzrCgobHei0gdSJjiRG3itS9aHSMbROQ+nQCt6
         cyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HcNfzyGaYYQWkaGQWCyxBDFlShvCOR6ybwytabkLrqA=;
        b=yCpEYvbk2pYnWhZXrlKJu34LZGgB80bGfOnTqNRIAs5FFOzf3LFziKptlPTqlOB4Pr
         8L+ECzEKUITIzypinVoQeixcZiOcRHRNp4A/w9mdAOhLQcbyX+RT5AbjdWwmwD1erFqi
         TZ42VdHtC/efhuoQL5nFVQxzwUY0eqn8eXzPLDGtEI0SjeQ97oPdIjqMyfQiIyKzAomZ
         h7CKcpNnr9gEbDbb7AiWjg+rlWRZW3OjEOWzJA6pSo8A1qVWyu9TerWpPrFmzlMCPTfs
         w7wGOF4LXYxyarMJWsiWTB33R9i/+eCcA6VklsbFks8Sf4VyCIgvZ2QXzLvnk4HtAl5T
         3tFg==
X-Gm-Message-State: AJIora9az8jxx9v6Kvh4o74quiZf7ECFZrBJhxv9T0g/jAoPSqCRwAag
        w2J6cSoTA2oh+8PYzE98fC7lGRuecmMavLU4Za8=
X-Google-Smtp-Source: AGRyM1tYD+kEH35ErCI3JhPRj2ukbvnnRRKMJDQOAO3K7VfXdsnBBymQMnJW871/YIhakuOM9rnDwOHZpXdmb0br+xQ=
X-Received: by 2002:a05:6e02:1d96:b0:2da:6dfd:7f8c with SMTP id
 h22-20020a056e021d9600b002da6dfd7f8cmr4287136ila.322.1656248507837; Sun, 26
 Jun 2022 06:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
 <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com> <080f65b3-91f5-7b68-4235-4bfb956c8321@gmail.com>
In-Reply-To: <080f65b3-91f5-7b68-4235-4bfb956c8321@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 26 Jun 2022 21:01:36 +0800
Message-ID: <CAOLTT8R1fQoH7cEWcE42+fjxu_iGBxDJy5Cgff6Bj9YH2f0--g@mail.gmail.com>
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8823=
=E6=97=A5=E5=91=A8=E5=9B=9B 22:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi ZheNing
> > [...]
> > +It is possible to print in a custom format by using the `--format`
> > +option, which is able to interpolate different fields using
> > +a `%(fieldname)` notation. For example, if you only care about the
> > +"objectname" and "path" fields, you can execute with a specific
> > +"--format" like
> > +
> > +     git ls-files --format=3D'%(objectname) %(path)'
> > +
> > +FIELD NAMES
> > +-----------
> > +Various values from structured fields can be used to interpolate
> > +into the resulting output. For each outputting line, the following
> > +names can be used:
> > +
> > +objectmode::
> > +     The mode of the file which is in the index.
> > +objectname::
> > +     The name of the file which is in the index.
> > +stage::
> > +     The stage of the file which is in the index.
> > +eol::
> > +     The <eolinfo> and <eolattr> of files both in the
> > +     index and the work-tree.
>
> Looking at the test for this option I think it needs more work, why
> should --format arbitrarily append a tab to the end of the output? - the
> user should be able to specify a separator if they want one as part of
> the format string. Also I'm not sure why there is so much whitespace in
> the output.
>

Because I used old output format in write_eolinfo(), now I think it's wrong=
,
I will separate it to three parts: %(eolinfo:index), %(eolinfo:worktree),
%(eolattr).

> If %(flags) is going to be useful then I think we need to think about
> how they are printed and document that. At the moment they are printed
> as a hexadecimal number which is fine for debugging but probably not
> going to be useful for something like --format. I think printing
> documented symbolic names with some kind of separator (a comma maybe)
> between them is probably more useful
>

Agree.

>  > [...]
> > +test_expect_success 'git ls-files --format eol' '
> > +     printf "i/lf    w/lf    attr/                 \t\n" >expect &&
> > +     printf "i/lf    w/lf    attr/                 \t\n" >>expect &&
> > +     git ls-files --format=3D"%(eol)" --eol >actual &&
>
> I'm not sure why this is passing --eol as well as --format=3D'%(eol)' -
> shouldn't that combination of flags be an error?
>

Thank you for reminding, will be corrected.

> Best Wishes
>
> Phillip

ZheNing Hu
