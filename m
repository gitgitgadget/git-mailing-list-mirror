Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E52C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 12:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF0A61168
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 12:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhDHMGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 08:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhDHMGI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 08:06:08 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB761C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 05:05:55 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id v26so1920335iox.11
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MH/g0LREGmDrg1IzUuGzMpI/fiOSpIP48KhKKsWvPfk=;
        b=qpcqDQBeUMjxD0JAguM7/9sucuJhuSZ4PPkBdTrUMbPzszw2HeKuxo5YPhKbSZ9bRg
         BbFyoe17S/461AxU/2YxW/QzW78SUIFXRFGa7FLaFo4/LjLGhNlYm+tGHzYJ5itnmDWl
         +m26a+fOmLC0QnRoztXlq9x5zc2aaxcrs67H4ZKyj5bIhYbeLcU9uD8rAgGbNBM9r1vp
         6sVgM7bz9W8YstUe8whlqS4N1BcgBGDuVNyTWNC3I+2ujiSTL94j/8eaWDQ6CRdNhp4E
         fbAqFJYPKWB4AmfvR2bzvf5R9dTUmAwPZ9ZtvpbEcrIobcpX/nitAZRnPU+ApYM8ship
         TTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MH/g0LREGmDrg1IzUuGzMpI/fiOSpIP48KhKKsWvPfk=;
        b=b27q+c3Q+H4QMyiaiPHgZRx+xpyxM2Kjiv6CeYNAsXG9c9wH00xXPi/XHo6enIqxw2
         ce88xDjI7ImkAiw7Ku7M5B29tthclHe2DypR17XENMCEJxSXd9cc+t8PGh+/iYRsw9CI
         JWo6jXOPKdEQMNS4tMoMUd5zhtlKJ6cq3YiAF4v+7TXwfUZheTIFiFmaq7HsHA9vtZu9
         sJ+4Pqw/H5xBdXyxgrKAmbS14qYthX8ysrwUYSWGOOXeki/5b87LmbuLnceu6UL10DVM
         dGxAQqELUBjEAb6Q0UOhzfWGJk5xCKSu/s3jpNfoD68NLcADZ3yArHfNnhkyM+7ZcWFn
         QPAA==
X-Gm-Message-State: AOAM5301OM7cwn7PgkYQQm5r28ZTRfOZ0T+/BjvvhUNR2vIoP5nFzo1U
        MthtPWj3Qhon+Id8FtPVecp2u37L3MIWUfJI33cySZAlgqYtsox+
X-Google-Smtp-Source: ABdhPJySr+zDWz8/GFQIA8yzvrYScc230bkSCyBnoineg6KL6tY29qB1UF1zdCKhKsGCf78HhhcNcizLGjUSfSbvmr0=
X-Received: by 2002:a6b:7302:: with SMTP id e2mr6494676ioh.106.1617883555256;
 Thu, 08 Apr 2021 05:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
 <pull.927.v2.git.1617809209164.gitgitgadget@gmail.com> <xmqqczv5zvj3.fsf@gitster.g>
In-Reply-To: <xmqqczv5zvj3.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 8 Apr 2021 20:05:39 +0800
Message-ID: <CAOLTT8RYjp1GKQpdPSzSNnn9o3+tuKNcGEUTp5HD9_Jut01JMQ@mail.gmail.com>
Subject: Re: [PATCH v2] [GSOC] ref-filter: use single strbuf for all output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=888=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:31=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Subject: Re: [PATCH v2] [GSOC] ref-filter: use single strbuf for all ou=
tput
>
> The implementation changed so much from the initial attempt, for
> which the above title may have been appropriate, that reusing single
> strbuf over and over is not the most important part of the change
> anymore, I am afraid.  Besides, it uses TWO strbufs ;-)
>
> Subject: [PATCH] ref-filter: introduce show_ref_array_items() helper
>
> or something like that?
>

Yep, I may think that its core is still reusing strbufs, but
"introduce show_ref_array_items()"  will be more accurate.

> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > When we use `git for-each-ref`, every ref will call
> > `show_ref_array_item()` and allocate its own final strbuf
> > and error strbuf. Instead, we can reuse these two strbuf
> > for each step ref's output.
> >
> > The performance for `git for-each-ref` on the Git repository
> > itself with performance testing tool `hyperfine` changes from
> > 18.7 ms =C2=B1 0.4 ms to 18.2 ms =C2=B1 0.3 ms.
> >
> > This approach is similar to the one used by 79ed0a5
> > (cat-file: use a single strbuf for all output, 2018-08-14)
> > to speed up the cat-file builtin.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC] ref-filter: use single strbuf for all output
> >
> >     Now git for-each-ref can reuse two buffers for all refs output, the
> >     performance is slightly improved.
> >
> >     Now there may be a question : Should the original interface
> >     show_ref_array_items be retained?
> > ...
> >        /*  Callback function for parsing the sort option */
>
> Again, not a very useful range-diff as the implementation changed so much=
.
>

This makes me wonder if I should give up GGG in the future.
I also don=E2=80=99t want a rang-diff with a big difference.

>
> >  builtin/for-each-ref.c |  4 +---
> >  ref-filter.c           | 20 ++++++++++++++++++++
> >  ref-filter.h           |  5 +++++
> >  3 files changed, 26 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> > index cb9c81a04606..d630402230f3 100644
> > --- a/builtin/for-each-ref.c
> > +++ b/builtin/for-each-ref.c
> > @@ -16,7 +16,6 @@ static char const * const for_each_ref_usage[] =3D {
> >
> >  int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
> >  {
> > -     int i;
> >       struct ref_sorting *sorting =3D NULL, **sorting_tail =3D &sorting=
;
> >       int maxcount =3D 0, icase =3D 0;
> >       struct ref_array array;
> > @@ -80,8 +79,7 @@ int cmd_for_each_ref(int argc, const char **argv, con=
st char *prefix)
> >
> >       if (!maxcount || array.nr < maxcount)
> >               maxcount =3D array.nr;
> > -     for (i =3D 0; i < maxcount; i++)
> > -             show_ref_array_item(array.items[i], &format);
> > +     show_ref_array_items(array.items, &format, maxcount);
>
> The intention of this call is to pass an array and the number of
> elements in the array as a pair to the function, right?  When you
> design the API for a new helper function, do not split them apart by
> inserting an unrelated parameter in the middle.
>

Eh, are you saying that `maxcount` is irrelevant here? There should be
`maxcount`, because we need to limit the number of iterations here.

> > diff --git a/ref-filter.c b/ref-filter.c
> > index f0bd32f71416..27bbf9b6c8ac 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -2435,6 +2435,26 @@ int format_ref_array_item(struct ref_array_item =
*info,
> >       return 0;
> >  }
> >
> > +void show_ref_array_items(struct ref_array_item **info,
> > +                      const struct ref_format *format,
> > +                      size_t n)
>
> IOW,
>
>         void show_ref_array_items(const struct ref_format *format,
>                                   struct ref_array_item *info[], size_t n=
)
>

Yes, it will be more obvious in the form of an array.

> > +{
> > +     struct strbuf final_buf =3D STRBUF_INIT;
> > +     struct strbuf error_buf =3D STRBUF_INIT;
> > +     size_t i;
> > +
> > +     for (i =3D 0; i < n; i++) {
> > +             if (format_ref_array_item(info[i], format, &final_buf, &e=
rror_buf))
> > +                     die("%s", error_buf.buf);
>
> OK, the contents of error_buf is already localized, so it is correct
> not to have _() around the "%s" here.
>
> > +             fwrite(final_buf.buf, 1, final_buf.len, stdout);
> > +             strbuf_reset(&error_buf);
> > +             strbuf_reset(&final_buf);
> > +             putchar('\n');
>
> This is inherited code, but splitting fwrite() and putchar() apart
> like this makes the code hard to follow.  Perhaps clean it up later
> when nothing else is going on in the code as leftoverbits, outside
> the topic.
>

Ok, swap the position of reset and putchar.

> > +     }
> > +     strbuf_release(&error_buf);
> > +     strbuf_release(&final_buf);
> > +}
> > +
> >  void show_ref_array_item(struct ref_array_item *info,
> >                        const struct ref_format *format)
> >  {
>
> Isn't the point of the new helper function so that this can become a
> thin wrapper around it, i.e.
>
>         void show_ref_array_item(...)
>         {
>                 show_ref_array_items(format, &info, 1);
>         }
>

Maybe it makes sense. But as Peff said, Maybe we can just delete it.

> > diff --git a/ref-filter.h b/ref-filter.h
> > index 19ea4c413409..eb7e79a6676d 100644
> > --- a/ref-filter.h
> > +++ b/ref-filter.h
> > @@ -121,6 +121,11 @@ int format_ref_array_item(struct ref_array_item *i=
nfo,
> >                         struct strbuf *error_buf);
> >  /*  Print the ref using the given format and quote_style */
> >  void show_ref_array_item(struct ref_array_item *info, const struct ref=
_format *format);
> > +/*  Print the refs using the given format and quote_style and maxcount=
 */
> > +void show_ref_array_items(struct ref_array_item **info,
> > +                      const struct ref_format *format,
> > +                      size_t n);
>
> The inconsistency between "maxcount" vs "n" is irritating.  Calling
> the parameter with a name that has the word "info" (because the new
> parameter is about that array) and a word like "nelem" to hint that
> it is the number of elements in the array) would be sensible.
>
> void show_ref_array_items(const struct ref_format *format,
>                           struct ref_array_item *info[], size_t info_coun=
t);
>
> or something along the line, perhaps?
>

Aha, I guess this is the reason for the misunderstanding above.
Yes, `info_count` is the correct meaning and the meaning of `n` is
wrong.

Thanks.
--
ZheNing Hu
