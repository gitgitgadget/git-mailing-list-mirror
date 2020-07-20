Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13ADC433E4
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 18:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C53322BEF
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 18:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoiAvGil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgGTSt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTSt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 14:49:26 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BFFC061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 11:49:26 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k22so15201226oib.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 11:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bwLlypuMVun5LDQfNqhW8aukQ2K3/munXSMB3WYlVQo=;
        b=FoiAvGilGNV3MX0o26IHqSUxd+GOH2BpHTouiLyeZzhz4jcRrbydG8gTl0wH0qkyz0
         orpkQ3RiWhFjIJEABU9encojijPqXdbDQBBRyulYecQfaQgn0fRXGhrJJBfnrT6O7efS
         WUqio232qLlmNWA+BSHJ1FX8gZ4OLM4t/laqGxt/elp5PHlQpeUb54RxGw2Y6IvTIqzK
         +uQA77U8vJmz624k/k4gOXMXFxUArvvS1SEb0G4mF7CK9ry6oObXueKmKoegd/fv6/bd
         ea8OXWadXjfud2o2Rhca8SlM/dOAE7uvGsHsW+3GsEaL3SGHut/wQvcRsH4Ie3ipb8YB
         7tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bwLlypuMVun5LDQfNqhW8aukQ2K3/munXSMB3WYlVQo=;
        b=qLG3C8rjosESVB2Ci1EEkGLGNu37wpyt/pLYEN/RBcQgCBaXXMI+BkVxooOe2VG9Vk
         eK1Zj99SXJNOqLYXF0umcdgIEioojWf3x8qo7NIMyOx/gn6D+swP77HAVz0NJkOdvE1S
         lATBzzc3X1AQosR/3d9lFGvVYBMDwXQOMg3NYfrctObmUEjTZ0J192IneHJ3D7VKwk3R
         Z+192yvOMTfKMyjD5Hd0ghekoO5eQOvF5W01Oec6mQW3evoQCd1Ktasm5r2IpxJVZN+D
         LgXQp5TnZmcaqhY/luc1VVMcT1XkM40ZcF2MnldnhSUva5ox15LGO9oUvJGgKa0N1smG
         ky+A==
X-Gm-Message-State: AOAM532imd48giW+SHyz4FqVlwTEAaLGljalln+2E+vGCv1x1Mqd5bEE
        aabGFrB8IRFxhk7XqK4R5ZjWdaPKMLPKgOseLoKhhmCW
X-Google-Smtp-Source: ABdhPJyWZuJEKNkbbtgkvTr+rWkMZdK0z+2j9m7aSQledVF9W5aO14LP4a6rSUnmORYqssit+IYZ871YIzuI6wPgZGA=
X-Received: by 2002:aca:5b42:: with SMTP id p63mr570027oib.39.1595270965042;
 Mon, 20 Jul 2020 11:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BH6xYb8a5hkV_68vbXhH4kApCxw0WG9oveXOk5zzU==1A@mail.gmail.com>
 <20200720184529.22449-1-martin.agren@gmail.com>
In-Reply-To: <20200720184529.22449-1-martin.agren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Jul 2020 11:49:13 -0700
Message-ID: <CABPp-BESf35g2zyCUZgBdbz4RacbToX+g7N4kwSQUCLq0h0ACQ@mail.gmail.com>
Subject: Re: [PATCH] dir: check pathspecs before returning `path_excluded`
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

On Mon, Jul 20, 2020 at 11:46 AM Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
>
> On Mon, 20 Jul 2020 at 17:25, Elijah Newren <newren@gmail.com> wrote:
> >
> > Awesome, thanks Andreas for the bisected report and Martin for finding
> > and fixing the bug.  As for the reason that the old patch injected the
> > pathspec check between the path_excluded and the path_untracked cases,
> > that appears to me to just be "I'm good at making boneheaded
> > mistakes".  Your changes here are the right fix.
>
> Ok, here it is as a proper patch.
>
> > Reviewed-by: Elijah Newren <newren@gmail.com>
>
> Thanks. I've included your reviewed-by below. The log message is
> obviously new, but the diff is identical to what I posted earlier.
>
> BTW, this bug first appeared in v2.27.0, so this is not a regression
> during the v2.28.0 cycle.

Looks good other than a minor typo in the new commit message.

> Martin
>
> -- >8 --
> In 95c11ecc73 ("Fix error-prone fill_directory() API; make it only
> return matches", 2020-04-01), we taught `fill_directory()`, or more
> specifically `treat_path()`, to check against any pathspecs so that we
> could simplify the callers.
>
> But in doing so, we added a slightly-to-early return for the "excluded"

s/to/too/

> case. We end up not checking the pathspecs, meaning we return
> `path_excluded` when maybe we should return `path_none`. As a result,
> `git status --ignored -- pathspec` might show paths that don't actually
> match "pathspec".
>
> Move the "excluded" check down to after we've checked any pathspecs.
>
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Reviewed-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  dir.c                      |  4 ++--
>  t/t7061-wtstatus-ignore.sh | 25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 2 deletions(-)
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
> 2.28.0.rc1
>
