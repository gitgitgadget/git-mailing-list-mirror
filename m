Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAD3C433E0
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 15:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC51120709
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 15:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl3T8R4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgGTPZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTPZc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 11:25:32 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7423AC061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 08:25:32 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w17so14664581oie.6
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 08:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8j8a5nhR6BzVRSXVc78isfmpoawSoryunPDv7unC3ec=;
        b=Pl3T8R4RWwlqig3yWJjrN8zY90xKtvQBhE0F52Tx40QxwMy8DYH4pWzvessjErGeFz
         kIT7jLgA1NCggZ8kAh50FZu0+GdM+z6pl8DVIqf+P05NX8qXOFUuuKU9XN8oUw7uq0U4
         HnsXlMfzEzStlyyh1cNwIIzGBUGn/8Bq4RwdcxgH2/JoiRdn+e+9QF+aIS7f1vaS799b
         3UQHdEkDPg3vdlesOgsizTuMrNpS/Fo/QysUNQIyYVzo60xNmoqgIZfwztDA5813sfGo
         w1IT0hAdWJsa9TD8r4IM5tnSttsqwXc9oRfV15dp7a66TOVpQCuj/cbMGMkh1wouVeo0
         ngNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8j8a5nhR6BzVRSXVc78isfmpoawSoryunPDv7unC3ec=;
        b=O0Z4WbZzpoHe7yvtQm86tI8iJNEwwqO0z/7palMK7MAKNrnQTh/MTX5j56UBM+Utxv
         s5Ry7gUPvsVE+un8LgMHNaeqHmURoZD2JtAAQ+XgX73U31GhUdeh6OnHm/bmIWSEx/2F
         wbsCNvTwleWJWxqko/i+PAMbp+nqALspV9/dvOSSzoGu1Oml0R7T351fulTGt0ppdFWK
         hGZYR1pSnJx70gKBl8EZVpFIphdCPlE3v0ElONB3c7JuzfBNWZvc5Bkd9wpw6kiAE5v8
         vXt8NUyoriFA4+8beKjJTahxUhDs491J5XW1PXKYWYlfRQ72uMZRkltLSbDM4NTwL6mm
         WxcQ==
X-Gm-Message-State: AOAM530TVK44qB2YEBIN73cv3tA/73ZZRaf/VS4CVR/G5VkAtq9FrUV7
        2m7brnERBN0YS2XTKf5vGoBjDG10/nZMhmACWTc=
X-Google-Smtp-Source: ABdhPJyijckx+Fc1jaDzxBEXq//7ojAHbPMtm8BhcGxlw4KvQGpaCfGoBacUynNCWtkKTRhHEij93isRSl91gkZR7X0=
X-Received: by 2002:aca:3dd7:: with SMTP id k206mr17173130oia.31.1595258731623;
 Mon, 20 Jul 2020 08:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <87lfjg6mkn.fsf@linux-m68k.org> <20200719123919.1802-1-martin.agren@gmail.com>
In-Reply-To: <20200719123919.1802-1-martin.agren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Jul 2020 08:25:20 -0700
Message-ID: <CABPp-BH6xYb8a5hkV_68vbXhH4kApCxw0WG9oveXOk5zzU==1A@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] Fix error-prone fill_directory() API; make it
 only return matches
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Jul 19, 2020 at 5:39 AM Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>
> On Sun, 19 Jul 2020 at 08:37, Andreas Schwab <schwab@linux-m68k.org> wrot=
e:
> >
> > This breaks git status --ignored.
> >
> > $ ./git status --porcelain --ignored -- a
> > !! abspath.o
> > !! add-interactive.o
> ...
> > !! attr.o
>
> Thanks for bisecting. This is 95c11ecc73 ("Fix error-prone
> fill_directory() API; make it only return matches", 2020-04-01).
>
> I wonder if the below makes any sense. It seems to fix this usage and
> the tests pass, but I have no idea what else this might be breaking...
>
> Maybe Elijah has an idea whether this is roughly the right approach?
> Looking at the commit in question (95c11ecc73), there must have been
> some reason that it injected the pathspec check between the
> "path_excluded" and the "path_untracked" cases.  The diff below
> basically undoes that split, so I have a feeling I'm missing something.

Awesome, thanks Andreas for the bisected report and Martin for finding
and fixing the bug.  As for the reason that the old patch injected the
pathspec check between the path_excluded and the path_untracked cases,
that appears to me to just be "I'm good at making boneheaded
mistakes".  Your changes here are the right fix.  As a separate
optimization, we could maybe make simplify_away() a bit more involved
and have it exclude a few more paths so that fewer make it to this
final check, but that's just optimization work that is separate from
your fix here.

Reviewed-by: Elijah Newren <newren@gmail.com>

> Martin
>
> diff --git a/dir.c b/dir.c
> index 1045cc9c6f..fe64be30ed 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2209,13 +2209,13 @@ static enum path_treatment treat_path(struct dir_=
struct *dir,
>                                        baselen, excluded, pathspec);
>         case DT_REG:
>         case DT_LNK:
> -               if (excluded)
> -                       return path_excluded;
>                 if (pathspec &&
>                     !match_pathspec(istate, pathspec, path->buf, path->le=
n,
>                                     0 /* prefix */, NULL /* seen */,
>                                     0 /* is_dir */))
>                         return path_none;
> +               if (excluded)
> +                       return path_excluded;
>                 return path_untracked;
>         }
>  }
> diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
> index e4cf5484f9..2f9bea9793 100755
> --- a/t/t7061-wtstatus-ignore.sh
> +++ b/t/t7061-wtstatus-ignore.sh
> @@ -30,6 +30,31 @@ test_expect_success 'same with gitignore starting with=
 BOM' '
>         test_cmp expected actual
>  '
>
> +test_expect_success 'status untracked files --ignored with pathspec (no =
match)' '
> +       git status --porcelain --ignored -- untracked/i >actual &&
> +       test_must_be_empty actual &&
> +       git status --porcelain --ignored -- untracked/u >actual &&
> +       test_must_be_empty actual
> +'
> +
> +test_expect_success 'status untracked files --ignored with pathspec (lit=
eral match)' '
> +       git status --porcelain --ignored -- untracked/ignored >actual &&
> +       echo "!! untracked/ignored" >expected &&
> +       test_cmp expected actual &&
> +       git status --porcelain --ignored -- untracked/uncommitted >actual=
 &&
> +       echo "?? untracked/uncommitted" >expected &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'status untracked files --ignored with pathspec (glo=
b match)' '
> +       git status --porcelain --ignored -- untracked/i\* >actual &&
> +       echo "!! untracked/ignored" >expected &&
> +       test_cmp expected actual &&
> +       git status --porcelain --ignored -- untracked/u\* >actual &&
> +       echo "?? untracked/uncommitted" >expected &&
> +       test_cmp expected actual
> +'
> +
>  cat >expected <<\EOF
>  ?? .gitignore
>  ?? actual
> --
> 2.28.0.rc1.7.g31f2d237fa
>
