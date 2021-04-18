Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABF2C433B4
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 11:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3BD6134F
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 11:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhDRLWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 07:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhDRLWv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 07:22:51 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9229C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 04:22:21 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h141so23688345iof.2
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 04:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VREbe+hqU6NdQoLZ4KIQX5aEvXI5bp/grB1Szt89Rbk=;
        b=NaurcXInxpt8YVjVtIBxgdxSPcRgQg37b92vzdJHCvwM/uBrx9q5ARx9iuYC4DTyjc
         3qPoWV1ACENtk7O1Xv/bxVKbtaq/sSkfG6UMmlsDm6AhriUEvq6vM8uRX+OmJdpMUy1D
         h36TszHbWpK++XuiDyVUVUlzVacHHb00LZtslet+/08rWdrC2faEKHXJ4GwozoaLU5lQ
         xkhZC+Jx8JQcrRZz25x51hQ2go7olreQ6J70cuaT/qpMiMh6ktySoQhOKWD7qhOfz8LL
         El5J7atsCBxyBsye1Pf8rDC4lz3MV9h5JreV95wTIfco+J7RlBE17fpTVWURyqVWoTaf
         BfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VREbe+hqU6NdQoLZ4KIQX5aEvXI5bp/grB1Szt89Rbk=;
        b=BsBRw1B5SJBeo3nWWrV7zkDWcuVABZKd08/LNYAA3sjOeqxOc5q88jAxCaFD3SQVs1
         vJ7uJOOjqfNpE7wNUplvArS5ph4X6u6z3+zYe6jTuJtTU/nQIv1y5+K/mNVSd+MhVh6q
         93UCZyNTu5LmKevppqN4GctxDDoRv6fxJ+wWl6qMShXHLw9BrDSo9dqWUCtFVEfEkpRy
         Ij9rtMbl1Ynu2LfZjlxpJ2BzteectDypY9cu1sYn5YiVdNl6CIy9kkNyInHdSoUhHotG
         P69UFbaAzBDOkQ4ztkJ0ihQAepTPd6z49nmKAy7AvK2K1QiKSYnjYsItBLIezJGLnRGW
         gMDQ==
X-Gm-Message-State: AOAM531pI4oowLRE6LbhkjTuI/EiMYZVKuVksYXpDRmZJwtDYuSJvzcj
        jr9j5hAz15XwwEDdSVbxI4j9k4BmuUGwzwx7Pa8=
X-Google-Smtp-Source: ABdhPJxW4jydPXKAah6WeLneA/NBCudQczVWdItGnQJW7DLc0RUGgPVHtrjx10RpVtWrTvO/4BdvoZ+Q3urMg5zvpLw=
X-Received: by 2002:a05:6602:2f10:: with SMTP id q16mr10689025iow.106.1618744941231;
 Sun, 18 Apr 2021 04:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.928.git.1617975348494.gitgitgadget@gmail.com> <4c4eded7-3bb3-7ae9-6455-468b9522978c@web.de>
In-Reply-To: <4c4eded7-3bb3-7ae9-6455-468b9522978c@web.de>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 18 Apr 2021 19:22:05 +0800
Message-ID: <CAOLTT8RY_8Ui7AAfU6K7O03DqbMTh0m5GJpmuwOyiV8Ghn+cQg@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: get rid of show_ref_array_item
To:     =?UTF-8?B?UmVuw6kgU2NoYXJmZS4=?= <l.s.r@web.de>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe. <l.s.r@web.de> =E4=BA=8E2021=E5=B9=B44=E6=9C=8817=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=885:11=E5=86=99=E9=81=93=EF=BC=9A
>
> Am 09.04.21 um 15:35 schrieb ZheNing Hu via GitGitGadget:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > When we use `git for-each-ref`, every ref will call
> > `show_ref_array_item()` and allocate its own final strbuf.
> > But we can reuse the final strbuf for each step ref's output.
> > Since `show_ref_array_item()` is not used in many places,
> > we can directly delete `show_ref_array_item()` and use the
> > same logic code to replace it. In this way, the caller can
> > clearly see how the loop work.
>
> Inlining an exported function that is not providing the right level of
> abstraction is a bold move that simplifies the API and can unlock
> improvements at the former call sites, like the possibility to reuse an
> allocated buffer in this case.  OK.
>
> > The performance for `git for-each-ref` on the Git repository
> > itself with performance testing tool `hyperfine` changes from
> > 23.7 ms =C2=B1 0.9 ms to 22.2 ms =C2=B1 1.0 ms.
>
> I see a speedup as well, but it's within the noise.
>

Yes, the performance improvement is very small under a large number
of refs. It was almost completely drowned out by the noise.

> > At the same time, we apply this optimization to `git tag -l`
> > and `git branch -l`, the `git branch -l` performance upgrade
> > from 5.8 ms =C2=B1 0.8 ms to 2.7 ms =C2=B1 0.2 ms and `git tag -l`
> > performance upgrade from 5.9 ms =C2=B1 0.4 ms to 5.4 ms =C2=B1 0.4 ms.
>
> On my system there's no measurable change with these commands.
>

In our case, git branch -l has made obvious progress, but it may be because
the number of branches is far less than tags.

> Nevertheless I think reusing the buffer across the loops is a good
> idea.
>
> > Since the number of tags in git.git is much more than branches,
> > so this shows that the optimization will be more obvious in
> > those repositories that contain a small number of objects.
> >
> > This approach is similar to the one used by 79ed0a5
> > (cat-file: use a single strbuf for all output, 2018-08-14)
> > to speed up the cat-file builtin.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC] ref-filter: get rid of show_ref_array_item
> >
> >     Now git for-each-ref can reuse final buf for all refs output, the
> >     performance is slightly improved, This optimization is also applied=
 to
> >     git tag -l and git branch -l.
> >
> >     Thanks.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-928%2=
Fadlternative%2Fref-filter-reuse-buf-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-928/adlt=
ernative/ref-filter-reuse-buf-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/928
> >
> >  builtin/branch.c       |  8 ++++----
> >  builtin/for-each-ref.c | 13 +++++++++++--
> >  builtin/tag.c          | 13 +++++++++++--
> >  ref-filter.c           | 24 +++++++++---------------
> >  ref-filter.h           |  2 --
> >  5 files changed, 35 insertions(+), 25 deletions(-)
> >
> > diff --git a/builtin/branch.c b/builtin/branch.c
> > index bcc00bcf182d..5c797e992aa4 100644
> > --- a/builtin/branch.c
> > +++ b/builtin/branch.c
> > @@ -411,6 +411,8 @@ static void print_ref_list(struct ref_filter *filte=
r, struct ref_sorting *sortin
> >  {
> >       int i;
> >       struct ref_array array;
> > +     struct strbuf out =3D STRBUF_INIT;
> > +     struct strbuf err =3D STRBUF_INIT;
> >       int maxwidth =3D 0;
> >       const char *remote_prefix =3D "";
> >       char *to_free =3D NULL;
> > @@ -440,8 +442,7 @@ static void print_ref_list(struct ref_filter *filte=
r, struct ref_sorting *sortin
> >       ref_array_sort(sorting, &array);
> >
> >       for (i =3D 0; i < array.nr; i++) {
> > -             struct strbuf out =3D STRBUF_INIT;
> > -             struct strbuf err =3D STRBUF_INIT;
> > +             strbuf_reset(&out);
> >               if (format_ref_array_item(array.items[i], format, &out, &=
err))
>
> This function didn't call show_ref_array_item() to begin with, so
> strictly speaking it's not related to change in the title.  It is a
> preexisting example of show_ref_array_item() not being flexible enough,
> though.  I think it makes sense to have separate patches for inlining
> the function verbatim and reusing the output buffer when
> format_ref_array_item() is called in a loop.
>

I agree with you. I will divide this into a separate patch.

> >                       die("%s", err.buf);
> >               if (column_active(colopts)) {
> > @@ -452,10 +453,9 @@ static void print_ref_list(struct ref_filter *filt=
er, struct ref_sorting *sortin
> >                       fwrite(out.buf, 1, out.len, stdout);
> >                       putchar('\n');
> >               }
> > -             strbuf_release(&err);
> > -             strbuf_release(&out);
> >       }
> >
> > +     strbuf_release(&out);
>
> err is no longer released, and it is also not reset in the loop.
> That change is not mentioned in the commit message, but it should.
> Why is it safe?  Probably because format_ref_array_item() only
> populates it if it also returns non-zero and then we end up dying
> anyway.
>
> That makes leak checking harder, though -- it's not easy to see if
> err hasn't simply been forgotten to be released.  I'd just retain
> the strbuf_release() call at the end of the function -- it
> shouldn't have a measurable performance impact and documents that
> this function is cleaning up after itself.  Thoughts?
>

Makes sense. Perhaps future changes will forget the release of err buffer.
I will add `strbuf_release()` here.

Thanks.
--
ZheNing Hu
