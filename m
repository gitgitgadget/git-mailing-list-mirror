Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1417CC07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 05:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E954B610A6
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 05:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhGCFRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 01:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhGCFRe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 01:17:34 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3F7C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 22:15:00 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id i13so11766656ilu.4
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 22:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aFyJbHRr+GiNiDM7YdOylPrG0Losef49vfbDlmURzpc=;
        b=o4+C90W2Y6VPdV6YYkzYA91jfy67eC2ww9m54R8c4bCWVxFJAKdXXqv4WcWS7p1UUn
         YP9gSFaxB0JlB/GkSJiLUUblKiB47vqDWu6okYG7A6WPJRMnpfz+dm1uNU5SznNPPkX6
         EvgoGjxtJveUImH50+xiu1o/7xGavULBZibMh96P1iME41eSqXxCTRqHvHNC+JS3+f54
         r9i01rMd21JoOxlS5rbVzEM9MB7LA1Wo7azdg/EGwT3gVXyp6AMttPe6Zlvu3Nm6/7Zf
         4zslCnje6i6yypj4GOMkdyHe0bFRo/Uj14NEvBPuotjv9CO87a3YYQh4mXvZE0ioMMF0
         uIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aFyJbHRr+GiNiDM7YdOylPrG0Losef49vfbDlmURzpc=;
        b=r7gyV+fglrSpKmDOAdl4DQKk7Qgp7rVjOFQb6V8JXc6scx6mxdNXvmnECYrrvkrnBp
         jtEz5HTlpXCOB+AxvBSKd+0W4sW+w0LkQT06FQ3eFPj/MC+2LXxP+UJO8RiCLWxXtDuU
         IwS53kNp39V6APT3d7wUfOGwmdSIGBYTsSNx+vxrYsl7axuRbYRLSQfdWI5/ng1aUCIO
         Ff52YI0BD+DOB1s4tmwrw7tX+oHs7z8JZAg2BQCRVRqC9qh780uJRr2oMUACFSh9XSfz
         GLAWAc5opXIHD9pwWJPB2VPbmtM4YXYGZJ6gGZ5+yaC8vEvNr+dEMPQX0RvzxfaKLBnL
         em7A==
X-Gm-Message-State: AOAM531CV9/Suxp9C6b4RoeIzLANoEeUCCjEO4MxJuIZ9otaDD/ujp+1
        oHMoxac7sJBNBoz/1Uz5cMGqK0EZtgU3YzEDee8=
X-Google-Smtp-Source: ABdhPJxHc4B+h43YU3NDicUCGu7/kE3ud82zwjcpJ01fiNTiuB1CXU6MnOqPqAX0lFUfV9QJsU26+BsKWUe3rqEDvds=
X-Received: by 2002:a05:6e02:bed:: with SMTP id d13mr2187220ilu.259.1625289300385;
 Fri, 02 Jul 2021 22:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <7d2314b43f21a470667971f1fdcb382f43bf51ed.1625155693.git.gitgitgadget@gmail.com>
 <87fswwalmv.fsf@evledraar.gmail.com>
In-Reply-To: <87fswwalmv.fsf@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 3 Jul 2021 13:14:54 +0800
Message-ID: <CAOLTT8RK4y76XAzFf+X=Dh7ysO4a-2-F08hdaof8gYWL8Kuv3w@mail.gmail.com>
Subject: Re: [PATCH 03/15] [GSOC] ref-filter: --format=%(raw) re-support --perl
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B47=E6=9C=882=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:30=E5=86=
=99=E9=81=93=EF=BC=9A
>
>
> On Thu, Jul 01 2021, ZheNing Hu via GitGitGadget wrote:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Because the perl language can handle binary data correctly,
> > add the function perl_quote_buf_with_len(), which can specify
> > the length of the data and prevent the data from being truncated
> > at '\0' to help `--format=3D"%(raw)"` re-support `--perl`.
> >
> > Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>
> Thanks!
>
> > -test_expect_success '%(raw) with --perl must fail' '
> > -     test_must_fail git for-each-ref --format=3D"%(raw)" --perl
> > +test_expect_success '%(raw) with --perl' '
> > +     git for-each-ref --format=3D"\$name=3D %(raw);
> > +print \"\$name\"" refs/myblobs/blob1 --perl | perl > actual &&
> > +     cmp blob1 actual &&
> > +     git for-each-ref --format=3D"\$name=3D %(raw);
> > +print \"\$name\"" refs/myblobs/blob3 --perl | perl > actual &&
> > +     cmp blob3 actual &&
> > +     git for-each-ref --format=3D"\$name=3D %(raw);
> > +print \"\$name\"" refs/myblobs/blob8 --perl | perl > actual &&
> > +     cmp blob8 actual &&
> > +     git for-each-ref --format=3D"\$name=3D %(raw);
> > +print \"\$name\"" refs/myblobs/first --perl | perl > actual &&
> > +     cmp one actual &&
> > +     git cat-file tree refs/mytrees/first > expected &&
> > +     git for-each-ref --format=3D"\$name=3D %(raw);
> > +print \"\$name\"" refs/mytrees/first --perl | perl > actual &&
> > +     cmp expected actual
> >  '
> >
> >  test_expect_success '%(raw) with --shell must fail' '
>
>
> Nit: Formatting can be "| perl >actual", not "| perl > actual", like the
> usual style...

Yeah, thanks.
--
ZheNing Hu
