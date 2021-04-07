Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D91C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 13:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4426139E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 13:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347933AbhDGN5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 09:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347556AbhDGN5V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 09:57:21 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C545C061756
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 06:57:12 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id c3so8142797ils.2
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6QtahTLx2wxHkVnaaUx9wG5GkQ90pF4YjJDCTfl1J9k=;
        b=W1Q1AwcEgtTIkM/zE3Xgy8FemKvxs+HjVLoFcTyug1RKjZq2EsEB/sJirUMzeQGWxj
         DOCzS8s2Lg3jfFC9peNzf2joFTzRbQmg0yFkpHJ2woH5k+DPhnvtvfZzrTjnwQguDkx3
         dax2BkCR52/X6pXc0hLLob9VNhSjDYTj7HzJa+6wT06bDVp88Fk8wfIZyGLmOXWzh4ky
         VGu2cWGJbwO2j5C2fPpbDKG4s+SjfTFChFxAc3AbvPfm4ngfI9l+rVWIguEfPlmIzNJV
         SrludbcgRwhLxiO1tOSXFaKyPD30nneNvTPv2ahvY9HkeEM1fb8Uq3ZRvG+pg83nv55s
         GLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6QtahTLx2wxHkVnaaUx9wG5GkQ90pF4YjJDCTfl1J9k=;
        b=Mkgz/v6N7qFLekWPs9S4LdVLjJP/P46N3cBjT+ZSGdgIr7MT88ItuNXFny/YDA/4eQ
         YVIFxjsB899WC6+v/fl6hM0/mJaFswgfN7CycbTzZsVRY4MpMVxa87E/hHZPIsXDfdxK
         jk1GNT/SbZ6Vlns8/wsKPvK4jBrCEhV39addX/iDlR2lhyF+sndYKpbV1Pfxhh7et3Df
         08z1s9j8DXkFFzxf9jVBaAbiaoI1vUqnWhGiJnGzFEIqxuCBxQ/iuXoN+pPnRfu8hno9
         TmS9pAoeZm2YRHvvqeTatGL8TyHQtyVfb/DlXAcKGTQSwD6iqVlXebE28Mov5AmbK7SW
         dnBg==
X-Gm-Message-State: AOAM531CZVvaxiT/Cgj2fpH0gqI48S/xsv+xmUz+ngaBB+nVAeZ22jiM
        gYhtEqFoyVaT/B+qOjMXn0it+A12TKMgJ4gQkVc=
X-Google-Smtp-Source: ABdhPJxCIr3q07uLspZBJwOEEizRPtfiMbt/SVB0+YHk9tUsDhovE4doijhhV1kNubsrmruyEgwOND4JpXsbtpO5Cdg=
X-Received: by 2002:a05:6e02:15c6:: with SMTP id q6mr2855989ilu.17.1617803831415;
 Wed, 07 Apr 2021 06:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com> <c70a7c17-650a-ae4d-9a90-66c3511f8371@web.de>
In-Reply-To: <c70a7c17-650a-ae4d-9a90-66c3511f8371@web.de>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 7 Apr 2021 21:57:00 +0800
Message-ID: <CAOLTT8S4-ZAjU5qcfep8-bbw+BNM3f-khMXJvQP+an3H6emp8g@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: use single strbuf for all output
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> =E4=BA=8E2021=E5=B9=B44=E6=9C=887=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=882:34=E5=86=99=E9=81=93=EF=BC=9A
>
> Am 05.04.21 um 16:01 schrieb ZheNing Hu via GitGitGadget:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > When we use `git for-each-ref`, every ref will call
> > `show_ref_array_item()` and allocate its own final strbuf
> > and error strbuf. Instead, we can provide two single strbuf:
> > final_buf and error_buf that get reused for each output.
> >
> > When run it 100 times:
> >
> > $ git for-each-ref
> >
> > on git.git :
> >
> > 3.19s user
> > 3.88s system
> > 35% cpu
> > 20.199 total
> >
> > to:
> >
> > 2.89s user
> > 4.00s system
> > 34% cpu
> > 19.741 total
> >
> > The performance has been slightly improved.
>
> I like to use hyperfine (https://github.com/sharkdp/hyperfine) to get
> more stable benchmark numbers, incl. standard deviation.  With three
> warmup runs I get the following results for running git for-each-ref on
> Git's own repo with the current master (2e36527f23):
>

Yes, hyperfine is really easy to use!

>   Benchmark #1: ./git for-each-ref
>     Time (mean =C2=B1 =CF=83):      18.8 ms =C2=B1   0.3 ms    [User: 12.=
7 ms, System: 5.6 ms]
>     Range (min =E2=80=A6 max):    18.2 ms =E2=80=A6  19.8 ms    148 runs
>
> With your patch on top I get this:
>
>   Benchmark #1: ./git for-each-ref
>     Time (mean =C2=B1 =CF=83):      18.5 ms =C2=B1   0.4 ms    [User: 12.=
3 ms, System: 5.6 ms]
>     Range (min =E2=80=A6 max):    17.8 ms =E2=80=A6  19.6 ms    147 runs
>
> So there seems to be a slight improvement here, but it is within the
> noise.
>

Yeah. I meet same noise when I do such test.

> I'm quite surprised how much longer this takes on your machine, however,
> and (like Peff already mentioned) how much of the total time it spends
> in system calls.  Is an antivirus program or similar interferring?  Or
> some kind of emulator or similar, e.g. Valgrind?  Or has it been a long
> time since you ran "git gc"?
>

Yes, I haven't used `git gc` for a long time.
In addition, when I did the test before, I ran the network proxy software,
so there have a bit notice.

> The benchmark certainly depends on the number of local and remote
> branches in the repo; my copy currently has 4304 according to
> "git for-each-ref | wc -l".
>

Yes i understand this point.
But In my git.git, the result of "git for-each-ref | wc -l" is 8716 refs.

> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC] ref-filter: use single strbuf for all output
> >
> >     This patch learned Jeff King's optimization measures in git
> >     cat-file(79ed0a5): using a single strbuf for all objects output Ins=
tead
> >     of allocating a large number of small strbuf for every object.
> >
> >     So ref-filter can learn same thing: use single buffer: final_buf an=
d
> >     error_buf for all refs output.
> >
> >     Thanks.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-927%2=
Fadlternative%2Fref-filter-single-buf-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-927/adlt=
ernative/ref-filter-single-buf-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/927
> >
> >  builtin/for-each-ref.c |  4 +++-
> >  builtin/tag.c          |  4 +++-
> >  ref-filter.c           | 21 ++++++++++++---------
> >  ref-filter.h           |  5 ++++-
> >  4 files changed, 22 insertions(+), 12 deletions(-)
> >
> > diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> > index cb9c81a04606..9dc41f48bfa0 100644
> > --- a/builtin/for-each-ref.c
> > +++ b/builtin/for-each-ref.c
> > @@ -22,6 +22,8 @@ int cmd_for_each_ref(int argc, const char **argv, con=
st char *prefix)
> >       struct ref_array array;
> >       struct ref_filter filter;
> >       struct ref_format format =3D REF_FORMAT_INIT;
> > +     struct strbuf final_buf =3D STRBUF_INIT;
> > +     struct strbuf error_buf =3D STRBUF_INIT;
> >
> >       struct option opts[] =3D {
> >               OPT_BIT('s', "shell", &format.quote_style,
> > @@ -81,7 +83,7 @@ int cmd_for_each_ref(int argc, const char **argv, con=
st char *prefix)
> >       if (!maxcount || array.nr < maxcount)
> >               maxcount =3D array.nr;
> >       for (i =3D 0; i < maxcount; i++)
> > -             show_ref_array_item(array.items[i], &format);
> > +             show_ref_array_item(array.items[i], &format, &final_buf, =
&error_buf);
>
> This user of show_ref_array_item() calls it in a loop on an array.
>
> >       ref_array_clear(&array);
> >       return 0;
> >  }
> > diff --git a/builtin/tag.c b/builtin/tag.c
> > index d403417b5625..8a38b3e2de34 100644
> > --- a/builtin/tag.c
> > +++ b/builtin/tag.c
> > @@ -39,6 +39,8 @@ static int list_tags(struct ref_filter *filter, struc=
t ref_sorting *sorting,
> >                    struct ref_format *format)
> >  {
> >       struct ref_array array;
> > +     struct strbuf final_buf =3D STRBUF_INIT;
> > +     struct strbuf error_buf =3D STRBUF_INIT;
> >       char *to_free =3D NULL;
> >       int i;
> >
> > @@ -64,7 +66,7 @@ static int list_tags(struct ref_filter *filter, struc=
t ref_sorting *sorting,
> >       ref_array_sort(sorting, &array);
> >
> >       for (i =3D 0; i < array.nr; i++)
> > -             show_ref_array_item(array.items[i], format);
> > +             show_ref_array_item(array.items[i], format, &final_buf, &=
error_buf);
>
> Dito.
>
> >       ref_array_clear(&array);
> >       free(to_free);
> >
> > diff --git a/ref-filter.c b/ref-filter.c
> > index f0bd32f71416..51ff6af64ebc 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -2436,16 +2436,16 @@ int format_ref_array_item(struct ref_array_item=
 *info,
> >  }
> >
> >  void show_ref_array_item(struct ref_array_item *info,
> > -                      const struct ref_format *format)
> > +                      const struct ref_format *format,
> > +                      struct strbuf *final_buf,
> > +                      struct strbuf *error_buf)
> >  {
> > -     struct strbuf final_buf =3D STRBUF_INIT;
> > -     struct strbuf error_buf =3D STRBUF_INIT;
> >
> > -     if (format_ref_array_item(info, format, &final_buf, &error_buf))
> > -             die("%s", error_buf.buf);
> > -     fwrite(final_buf.buf, 1, final_buf.len, stdout);
> > -     strbuf_release(&error_buf);
> > -     strbuf_release(&final_buf);
> > +     if (format_ref_array_item(info, format, final_buf, error_buf))
> > +             die("%s", error_buf->buf);
> > +     fwrite(final_buf->buf, 1, final_buf->len, stdout);
> > +     strbuf_reset(error_buf);
> > +     strbuf_reset(final_buf);
> >       putchar('\n');
> >  }
> >
> > @@ -2453,9 +2453,12 @@ void pretty_print_ref(const char *name, const st=
ruct object_id *oid,
> >                     const struct ref_format *format)
> >  {
> >       struct ref_array_item *ref_item;
> > +     struct strbuf final_buf =3D STRBUF_INIT;
> > +     struct strbuf error_buf =3D STRBUF_INIT;
> > +
> >       ref_item =3D new_ref_array_item(name, oid);
> >       ref_item->kind =3D ref_kind_from_refname(name);
> > -     show_ref_array_item(ref_item, format);
> > +     show_ref_array_item(ref_item, format, &final_buf, &error_buf);
>
> This third and final caller works with a single item; there is no loop.
>
> >       free_array_item(ref_item);
> >  }
> >
> > diff --git a/ref-filter.h b/ref-filter.h
> > index 19ea4c413409..95498c9f4467 100644
> > --- a/ref-filter.h
> > +++ b/ref-filter.h
> > @@ -120,7 +120,10 @@ int format_ref_array_item(struct ref_array_item *i=
nfo,
> >                         struct strbuf *final_buf,
> >                         struct strbuf *error_buf);
> >  /*  Print the ref using the given format and quote_style */
> > -void show_ref_array_item(struct ref_array_item *info, const struct ref=
_format *format);
> > +void show_ref_array_item(struct ref_array_item *info,
> > +                      const struct ref_format *format,
> > +                      struct strbuf *final_buf,
> > +                      struct strbuf *error_buf);
>
> This bring-your-own-buffer approach pushes responsibilities back to
> the callers, in exchange for improved performance.  The number of
> users of this interface is low, so that's defensible.  But that added
> effort is also non-trivial -- as you demonstrated by leaking the
> allocated memory. ;-)
>

Yes, this may be burden for the function caller.

> How about offering to do more instead?  In particular you could add
> a count parameter and have show_ref_array_item() handle an array of
> struct ref_array_item objects.  It could reuse the buffers internally
> to get the same performance benefit, and would free callers from
> having to iterate loops themselves.  Something like:
>
>         void show_ref_array_items(struct ref_array_item **info,
>                                   size_t n,
>                                   const struct ref_format *format);
>
> Callers that deal with a single element can pass n =3D 1.
>
> Perhaps the "format" parameter should go first, like with printf.
>
> The double reference in "**info" is a bit ugly, though (array of
> pointers instead of a simple array of objects).  That's dictated
> by struct ref_array_item containing a flexible array member, which
> seems to be hard to change.
>

I personally think this idea is great.
In this way, there is no need to pass in two strbuf from the outside.

+void show_ref_array_items(struct ref_array_item **info,
+                        const struct ref_format *format,
+                        size_t n)
+{
+       struct strbuf final_buf =3D STRBUF_INIT;
+       struct strbuf error_buf =3D STRBUF_INIT;
+       size_t i;
+
+       for (i =3D 0; i < n; i++) {
+               if (format_ref_array_item(info[i], format, &final_buf,
&error_buf))
+                       die("%s", error_buf.buf);
+               fwrite(final_buf.buf, 1, final_buf.len, stdout);
+               strbuf_reset(&error_buf);
+               strbuf_reset(&final_buf);
+               putchar('\n');
+       }
+       strbuf_release(&error_buf);
+       strbuf_release(&final_buf);
+}
+

And the result is here(close the network proxy program):

HEAD~ result :

(git)-[heads/master] % hyperfine "./bin-wrappers/git for-each-ref"
--warmup=3D10
  Benchmark #1: ./bin-wrappers/git for-each-ref
    Time (mean =C2=B1 =CF=83):      18.7 ms =C2=B1   0.4 ms    [User: 14.9 =
ms,
System: 3.9 ms]
    Range (min =E2=80=A6 max):    18.1 ms =E2=80=A6  19.8 ms    141 runs

With the new patch :
 (git)-[ref-filter-single-buf] % hyperfine "./bin-wrappers/git
for-each-ref" --warmup=3D10
  Benchmark #1: ./bin-wrappers/git for-each-ref
   Time (mean =C2=B1 =CF=83):      18.2 ms =C2=B1   0.3 ms    [User: 14.1 m=
s, System:
4.2 ms]
   Range (min =E2=80=A6 max):    17.4 ms =E2=80=A6  19.2 ms    140 runs

Seem like it does have some small advantages ;-)

> >  /*  Parse a single sort specifier and add it to the list */
> >  void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *=
atom);
> >  /*  Callback function for parsing the sort option */
> >
> > base-commit: 2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48
> >
>

A new iteration will be sent later.

Thanks!
--
ZheNing Hu
