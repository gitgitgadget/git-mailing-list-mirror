Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40F4C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 08:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD1461284
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 08:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244626AbhDFIxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 04:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbhDFIxj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 04:53:39 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94553C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 01:53:31 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id l9so6311825ils.6
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 01:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UpUGLAQVYlYiqO7KAuy8JUoQw5Hu1bJ2ZYfXZ/96qd0=;
        b=heSSrLvfWyum8/e1jsHqeOcx7WR9ZGsO++5v8P8JTcJ1ba5vN4yjlKfMqFZGdq4QNY
         8nFU3H+4rJtHsWZRgxji+i9RWpT9BpcA+Abz2vVcV872UED0Cqeo3NPrEVWAYQuSYlnv
         iNYdKOPtfYA4jV9Zjpw8J+DHxHUDdCCloMO5QCPAIgLSorfXVkNoIUGcQxH00fPq8xXT
         d9r4Z8q3PGTanUQx+2tKLtSZ4gc36Tp2kBgfUhhvXAESs3pmJF9FC1rA4z3V86JRmRw9
         rwX8j5jfQpL4u4Nww24Z2Xk3vAUFBJgXh+HxYs7RHI3a3yMTmtHz5yjCTHOKBLCRFCmy
         nA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UpUGLAQVYlYiqO7KAuy8JUoQw5Hu1bJ2ZYfXZ/96qd0=;
        b=EEHHC7Oxf3KuYJ7ZVYmK0oaeM2brW4dD5NmzFL99xU/zQOYSfxx93INqjwB516ApSC
         1h5rKBNK0KI8iwca4hXoEAHklTdhYvWU8jnMal1OyfcAzfoc78BDi3887EZvTiKenCkW
         9rGGE3oUPe7mJmeK7UtuVWg8d++BZKKEIvO+Q/wgFWlU2vP200rlU8+wcR3Zohjcxbpi
         ha7GMaNFvPsVQUib2tqCbQYhDcCYVJzDrBv5WaJMFEw9S2wQOO8b2ABaS8+UXQGmEp8a
         h8/8igT8k5NkKiNBoyRProd+6YJ2ill9SmKLg+VX0fFCeDA5nh3yWUdWfGj5V606bx1w
         tKRg==
X-Gm-Message-State: AOAM531HnC2QyJi605+OBYxEmE8n6NCDcMz1xsnQY0vuf4C2UGCH+hwq
        hqan36a6Y3W/B7sJg/YJ3/BZJmlRKz/WHfqHz7o=
X-Google-Smtp-Source: ABdhPJwjsO57tCjCK5n2MfQKMNPrxsLoTNKr0RFTmeMP2gO/ridj4lrbPW8/8GZxV8ShTwGaz9bV5uovnLHeBZtdD7Y=
X-Received: by 2002:a92:3644:: with SMTP id d4mr23740487ilf.53.1617699210984;
 Tue, 06 Apr 2021 01:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com> <CAPig+cRzv3sPHpOY_ZGBu8mGp=gy6E+c9ige3-AHh2DM+YcKjw@mail.gmail.com>
In-Reply-To: <CAPig+cRzv3sPHpOY_ZGBu8mGp=gy6E+c9ige3-AHh2DM+YcKjw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 6 Apr 2021 16:53:15 +0800
Message-ID: <CAOLTT8SoRPbcqCM33RkqQ0_rWmax7aAati0Q7L7x9JGBcVjPzA@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: use single strbuf for all output
To:     Eric Sunshine <sunshine@sunshineco.com>
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

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=886=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:05=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Mon, Apr 5, 2021 at 10:01 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > When we use `git for-each-ref`, every ref will call
> > `show_ref_array_item()` and allocate its own final strbuf
> > and error strbuf. Instead, we can provide two single strbuf:
> > final_buf and error_buf that get reused for each output.
> > [...]
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
>
> Was there a discussion leading up to this change? If so, it may be a
> good idea to provide a link to it in the mailing list here under the
> "---" line.
>

Okay, I will add them in cover-letter next time.

> Some comments below...
>
> > diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> > @@ -22,6 +22,8 @@ int cmd_for_each_ref(int argc, const char **argv, con=
st char *prefix)
> >         struct ref_format format =3D REF_FORMAT_INIT;
> > +       struct strbuf final_buf =3D STRBUF_INIT;
> > +       struct strbuf error_buf =3D STRBUF_INIT;
> >
> >         for (i =3D 0; i < maxcount; i++)
> > -               show_ref_array_item(array.items[i], &format);
> > +               show_ref_array_item(array.items[i], &format, &final_buf=
, &error_buf);
> >         ref_array_clear(&array);
> >         return 0;
> >  }
>
> The call to strbuf_reset() within show_ref_array_item() does not free
> the memory from the strbufs, so the memory is being leaked. Therefore,
> at the end of this function, you should have:
>
>     strbuf_release(final_buf);
>     strbuf_release(error_buf);
>

Thanks, I ignored this point.

> > diff --git a/builtin/tag.c b/builtin/tag.c
> > @@ -39,6 +39,8 @@ static int list_tags(struct ref_filter *filter, struc=
t ref_sorting *sorting,
> >         struct ref_array array;
> > +       struct strbuf final_buf =3D STRBUF_INIT;
> > +       struct strbuf error_buf =3D STRBUF_INIT;
> >
> >         for (i =3D 0; i < array.nr; i++)
> > -               show_ref_array_item(array.items[i], format);
> > +               show_ref_array_item(array.items[i], format, &final_buf,=
 &error_buf);
> >         ref_array_clear(&array);
> >         free(to_free);
>
> Leaking `final_buf` and `error_buf`.
>
> > diff --git a/ref-filter.c b/ref-filter.c
> > @@ -2436,16 +2436,16 @@ int format_ref_array_item(struct ref_array_item=
 *info,
> >  void show_ref_array_item(struct ref_array_item *info,
> > -                        const struct ref_format *format)
> > +                        const struct ref_format *format,
> > +                        struct strbuf *final_buf,
> > +                        struct strbuf *error_buf)
> >  {
> > -       struct strbuf final_buf =3D STRBUF_INIT;
> > -       struct strbuf error_buf =3D STRBUF_INIT;
> >
> > -       if (format_ref_array_item(info, format, &final_buf, &error_buf)=
)
> > -               die("%s", error_buf.buf);
> > -       fwrite(final_buf.buf, 1, final_buf.len, stdout);
> > -       strbuf_release(&error_buf);
> > -       strbuf_release(&final_buf);
> > +       if (format_ref_array_item(info, format, final_buf, error_buf))
> > +               die("%s", error_buf->buf);
> > +       fwrite(final_buf->buf, 1, final_buf->len, stdout);
> > +       strbuf_reset(error_buf);
> > +       strbuf_reset(final_buf);
> >         putchar('\n');
> >  }
>
> A couple comments:
>
> It is especially ugly that `error_buf` needs to be passed in by the
> caller since it is only ever used in case of an error, at which point
> the program will die() anyhow, so it's not on a critical,
> speed-sensitive path. The initialization with STRBUF_INIT is
> practically cost-free, so this variable could easily stay local to
> this function without cost-penalty rather than forcing the caller to
> pass it in. (This assumes that none of the consumers of `error_buf`
> down the line insert into the buffer unnecessarily, which is probably
> a reasonable assumption.)
>

What you said makes sense. The `error_buf` may not need to be passed
as a parameter, because errors are generally less.

> It is an unsafe assumption to only call strbuf_reset() at the end of
> the function. For this to be robust, you can't assume that the caller
> has given you an empty strbuf. Instead, you must ensure it by calling
> strbuf_reset() at the start. (It doesn't hurt to also call
> strbuf_reset() at the end, but that is not critical to correct
> operation, so could be omitted.)
>

Well, indeed, it would be better to use `strbuf_reset()` first, as it do in
`cat-file.c`.

> > @@ -2453,9 +2453,12 @@ void pretty_print_ref(const char *name, const st=
ruct object_id *oid,
> >         struct ref_array_item *ref_item;
> > +       struct strbuf final_buf =3D STRBUF_INIT;
> > +       struct strbuf error_buf =3D STRBUF_INIT;
> > +
> >         ref_item =3D new_ref_array_item(name, oid);
> >         ref_item->kind =3D ref_kind_from_refname(name);
> > -       show_ref_array_item(ref_item, format);
> > +       show_ref_array_item(ref_item, format, &final_buf, &error_buf);
> >         free_array_item(ref_item);
> >  }
>
> Leaking `final_buf` and `error_buf`.
>
> > diff --git a/ref-filter.h b/ref-filter.h
> > @@ -120,7 +120,10 @@ int format_ref_array_item(struct ref_array_item *i=
nfo,
> >  /*  Print the ref using the given format and quote_style */
> > -void show_ref_array_item(struct ref_array_item *info, const struct ref=
_format *format);
> > +void show_ref_array_item(struct ref_array_item *info,
> > +                        const struct ref_format *format,
> > +                        struct strbuf *final_buf,
> > +                        struct strbuf *error_buf);
>
> It is not clear to the person reading this what these two new
> arguments are for or what should be provided, so the comment above the
> function deserves an update explaining what these arguments are for
> and how to provide them. This is especially important since this is a
> public function.
>
> If this function was merely internal to some builtin command, this
> sort of change for the sake of optimization might not be so bad, but
> as a public function, it comes across as rather ugly. In general, we
> don't necessarily want to pollute an otherwise clean API with changes
> which make the API uglier merely for the sake of tiny optimizations
> like this (IMHO). The extra burden placed on callers by this change,
> coupled with the ugliness this introduces into the API, makes the
> change seem less than desirable.
>

Well, for the time being, there are relatively few places
where`show_ref_array_item()`
is used in the entire git repository. I may need to pay attention to this l=
ater:
the ease of use of public interfaces is also important.

> One way you might be able to mitigate the undesirableness would be to
> have two versions of this function. For instance:
>
>     /* Print the ref using the given format and quote_style */
>     show_ref_array_item(...);
>    /* This is like show_ref_array_item() but ... */
>     show_ref_array_item_optim(...);
>
> The comment of the second function would, of course, need to explain
> that it is similar to show_ref_array_item() but more optimal because
> <some reasons> and that the caller is responsible for allocating and
> releasing the strbufs, and that the strbufs are used only for
> temporary storage, thus the caller should not assume anything about
> them.
>

Yes, this will ensure that this new public interface will not be misused.

> This way, callers which don't invoke show_ref_array_item() in a tight
> loop don't need to be burdened by the new arguments (and won't have to
> remember to release them), and callers with a tight loop can take
> advantage of the optimization with the bit of extra work of having to
> declare and release the strbufs.
>

For external calls, reasonable release of strbuf does require attention,
which is indeed a disadvantage at some time.

> So, having said all that, it's not clear that the ugliness and extra
> work are worth the gain. However, if it is decided that the change is
> worthwhile, then the commit message probably should explain cases in
> which such an optimization will be really beneficial.

I now estimate that the optimization brought here may appear in a more refs
git repo like `linux.git`. I have to experiment first.

Thanks, Eric.

--
ZheNing Hu
