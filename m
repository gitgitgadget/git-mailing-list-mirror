Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2029EC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 13:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF0961156
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 13:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhFUNH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 09:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhFUNH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 09:07:58 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FC1C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 06:05:43 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h3so15176606ilc.9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 06:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bPwVAziFayaqveu4trJBTqpj4I9oOPfaXSrY4BDET/E=;
        b=CakpnoqDW29YtKL3PUL4jCKaYvyn+nXQaEkK8/S8pgH4QLVVSXmn/OeJCuJTpSDWk+
         ljEkQoRRjWcKwYvfYagTGPAAffxFsNDTH4ZW5vmRHyzhZhpS0w8uLKYaVN2fJBhkNpZr
         udvNDnT4eq4TL7sHjn6Vdo1QTKHwkRgosRU0FXiVAEasPSfI1c/7uyzCTYPs67H3kltp
         P8d1cv6e6g8z87vWYSxLXQEy5VWKdEGmAwbGZ/cX5Dwmu6LnCqeu9o1z2NDcV/vmxfOI
         f6BDdBp7bYRdVNssuD3LEa6zvrtb3Yq5E2OsaudcQwb9i7mrda2KUr5SZ0b6rmkLbSov
         csww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bPwVAziFayaqveu4trJBTqpj4I9oOPfaXSrY4BDET/E=;
        b=G+6Yn2MdvXsac0oZyVoA1iUVFl6/jbmLGE1iQw0fZI59N9mkvKrZOQyMP8gRmW9PC0
         tae0VkzjLW+jxkRfH1YWRNE4BtKtE3GXYzqRfC5I4KcQAEHNXO/yk+k5z/24+QLPaGu+
         dEFZvH8IcyfEAWXkaMWw63hvKaWbYOxBby1MNgxRgG49XnO4AI0ObuxaFopB4hMbLrym
         /Jn3ltWNeD5lpDYGd8CO1keGvoAghtQ/RT50fmFcWi9X+JPDlnCgno67NR3xvDiOLUMc
         2l4Ywgq25l3H13Cn3S6ifX7kkIF6HxjhtVLRS1NX2waaKBdqWxHYOW/BKq78zl1tTNDh
         8aNQ==
X-Gm-Message-State: AOAM530fMwcOMUOvrK1I9vUzXhIJxAw3RDA05fF7RB5+PwxYr3YbSw1d
        dSTsbqbcbkM7FC8PK5XYuXucuIqNbIwRxlC5OGk=
X-Google-Smtp-Source: ABdhPJzzATb+vK8WggvNy+RfOfGowy75FygvfB3PrtWL339ruY2D6Ciyopshh2K7LGwiNaNlkfz+34+9KBludlMG2Ro=
X-Received: by 2002:a92:2004:: with SMTP id j4mr18244164ile.53.1624280743305;
 Mon, 21 Jun 2021 06:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
 <pull.980.v3.git.1624086181.gitgitgadget@gmail.com> <bd534a266a401a8edbf8c4d12a2d9e44fcc79d70.1624086181.git.gitgitgadget@gmail.com>
 <CAP8UFD18iumUEgayGxL612MmbK9_2uDpHz3i7aqJ5zYSh7skqg@mail.gmail.com>
In-Reply-To: <CAP8UFD18iumUEgayGxL612MmbK9_2uDpHz3i7aqJ5zYSh7skqg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 21 Jun 2021 21:05:32 +0800
Message-ID: <CAOLTT8TU+E+GaxR+fMvH5Rc-C+BEJDpqjmmrF_BO5kG-i-_gsQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] [GSOC] cat-file: reuse ref-filter logic
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=
=8821=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=881:55=E5=86=99=E9=81=93=
=EF=BC=9A
>
> > 1. Add `cat_file_mode` member in struct `ref_format`, this can
> > help us reject atoms in verify_ref_format() which cat-file
> > cannot use, e.g. `%(refname)`, `%(push)`, `%(upstream)`...
> > 2. Change the type of member `format` in struct `batch_options`
> > to `ref_format`, We can add format data in it.
>
> Not sure what "We can add format data in it." means.

Well, there is something wrong with the expression here. What I want
to express is that we can fill its member "format" with the atoms like
"%(objectname) %(refname)", and then pass it to the ref-filter.

> > 7. Use free_ref_array_item_value() to free ref_array_item's
> > value.
>
> That looks like a lot of changes in a single commit. I wonder if this
> commit could be split.
>

Yeah, But I don=E2=80=99t know if I should take it apart step by step, If t=
aken apart,
those intermediate commits are likely to fail the test.

> > Most of the atoms in `for-each-ref --format` are now supported,
> > such as `%(tree)`, `%(parent)`, `%(author)`, `%(tagger)`, `%(if)`,
> > `%(then)`, `%(else)`, `%(end)`. But these atoms will be rejected:
> > `%(refname)`, `%(symref)`, `%(upstream)`, `%(push)`, `%(worktreepath)`,
> > `%(flag)`, `%(HEAD)`, because our objects don't have refname.
>
> s/refname/a refname/
>
> It might be worth talking a bit about possible performance changes.
>

Makes sense. The performance has indeed deteriorated.

> [...]
>
> > +       ret =3D format_ref_array_item(&item, &opt->format, scratch, &er=
r);
> > +       if (!ret) {
> > +               strbuf_addch(scratch, '\n');
> > +               batch_write(opt, scratch->buf, scratch->len);
> > +       } else if (ret < 0) {
> > +               die("%s\n", err.buf);
>
> This if (ret < 0) could be checked first.

Yes, it is better to put error checking first.

>
> > +       } else {
> > +               /* when ret > 0 , don't call die and print the err to s=
tdout*/
>
> I think it would be more helpful to tell what ret > 0 means, rather
> than what we do below (which can easily be seen).
>

Ah, There is indeed only one situation for ret > 0 for the time being:
Show "<oid> missing" without exiting Git.

> > +               printf("%s\n", err.buf);
> > +               fflush(stdout);
> >         }
>
> For example:
>
>        if (ret < 0) {
>                die("%s\n", err.buf);
>        if (ret) {
>                /* ret > 0 means ... */
>                printf("%s\n", err.buf);
>                fflush(stdout);
>        } else {
>                strbuf_addch(scratch, '\n');
>                batch_write(opt, scratch->buf, scratch->len);
>        }
>

Yes, this might be better.

> > +       free_ref_array_item_value(&item);
> > +       strbuf_release(&err);
> >  }
>
> [...]
>
> > +static int batch_objects(struct batch_options *opt, const struct optio=
n *options)
>
> It's unfortunate that one argument is called "opt" and the other one
> "options". I wonder if the first one could be called "batch" as it
> seems to be called this way somewhere else.
>

OK.

> > +       if (!opt->format.format)
> > +               strbuf_addstr(&format, "%(objectname) %(objecttype) %(o=
bjectsize)");
> > +       else
> > +               strbuf_addstr(&format, opt->format.format);
>
> If there is no reason for the condition to be (!X) over just (X), I
> think the latter is a bit better.
>

Although I think it doesn=E2=80=99t matter which one to use first,
I will still follow your suggestions.

> >         if (opt->print_contents)
> > -               data.info.typep =3D &data.type;
> > +               strbuf_addstr(&format, "\n%(raw)");
> > +       opt->format.format =3D format.buf;
>
> I wonder if this should be:
>
>       opt->format.format =3D strbuf_detach(&format, NULL);
>

No. here our opt->format.format will not be changed, it would
be better for us to use `strbuf_release(&format)` for resource
recovery. (strbuf_detach() will forced to let us free opt->format.format)

> > +       if (verify_ref_format(&opt->format))
> > +               usage_with_options(cat_file_usage, options);
>
> [...]
>
> > @@ -86,7 +87,7 @@ struct ref_format {
> >         int need_color_reset_at_eol;
> >  };
> >
> > -#define REF_FORMAT_INIT { NULL, NULL, 0, 0, -1 }
> > +#define REF_FORMAT_INIT { NULL, NULL, 0, 0, 0, -1 }
>
> Maybe this can already be changed to a designated initializer, like
> =C3=86var suggested recently.
>

I agree.

> [...]
>
> > +test_expect_success 'cat-file refs/heads/main refs/tags/testtag %(rest=
)' '
>
> If this test is about checking that %(rest) works with both a branch
> and a tag, it might be better to say it more explicitly.
>

OK.

Thanks.
--
ZheNing Hu
