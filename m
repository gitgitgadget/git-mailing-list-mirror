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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739C0C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 06:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BB16199F
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 06:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCWGMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 02:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhCWGMA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 02:12:00 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FDCC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 23:11:59 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so18411898otn.10
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 23:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AdwDuuwnNcpTHom2anWiE7b/m+oJeNWheH7T0P6qTUA=;
        b=WQoBv911tC4a21R/yiN53fUzEvuQyR9HupgIVPbW6+tybqSHLzfT2Z0nGiU2dvFHnI
         7OnFyxXCWOfCJ9yrtKuVYc8kMgs/TVlVACd3Bu9nj5sp0MVgcyfmORc/RcwV8zKM8ZKY
         HV072slRxlbAabMymGBEK4DksDh14wrp7Xx1g+H3kKK99nRv4li4UwqCjqUzz/sa9N4e
         q6XNx8k1YpjHpU+hds8XbdsVP4EkhUeOO/wQfwCbnbHIPWjDd2r8sfH7IeBf62xhknMm
         Z0Olphh97e1/IQC3sjb8pZgLUkyNRuAmKH+urL3RhnSHWj+KIcovj00oPSJ3QT+RsihO
         3YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AdwDuuwnNcpTHom2anWiE7b/m+oJeNWheH7T0P6qTUA=;
        b=rIeKBgUx6GcKSNkTLB8lFRC/BNFDSSPWZhZ9NICTMxtbZZD8jf0ZdlwzQ2DMQ+4aLQ
         cd2eKyPIyIGTCOoNYu+w2LCeZbA9RSJ/E8CoC7cBn9dupGtlqO+8ufliH/Gfn6B+6nx5
         xxdZHdi6aDI6UrPzbpyVlmt/Y1i3O1+6ZWX06a/nqyjdRQWDj1RrWkZHjSYCJCIPh2gA
         DzKGJyaIhOSX/XHl/GA2R3CjBWw+kIZVBG9x6OhkJ9tZj/LabwEUYgP+dYQRxvw1x01G
         S9KMgD0yCBqZlGw72RVdMdvi41N3XWqRt98r6FkrJAGRaPG3NnBsOogIbeyd/M7+EWce
         /8Vw==
X-Gm-Message-State: AOAM530QxdwYXBAbFIBsIMmYselp5744PqotL8o35mLvqjlzvBIKTm+H
        a4sUVo35DajsZoJBTq/+fs/oYN4nG3Natmakh4g=
X-Google-Smtp-Source: ABdhPJxuI9o1wj8GJS+6YpTLfA7ctnDclMj40GL9rOXvUckFaPEujLAzW6finrlzb1CzWRGjTXbjdaareiD1oGTt8zk=
X-Received: by 2002:a05:6830:17d7:: with SMTP id p23mr3060112ota.164.1616479919073;
 Mon, 22 Mar 2021 23:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
 <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com> <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
 <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com> <CAP8UFD3fYTc8=y+kru-mN5KmTsnqc6X8mf14VtyWf1Nj9CJ1EQ@mail.gmail.com>
In-Reply-To: <CAP8UFD3fYTc8=y+kru-mN5KmTsnqc6X8mf14VtyWf1Nj9CJ1EQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 23 Mar 2021 14:11:43 +0800
Message-ID: <CAOLTT8Rc6Y4=a-2aj96hs24-h4zywxO0nLxBwh_B19hSSxcs_w@mail.gmail.com>
Subject: Re: [PATCH v13] [GSOC] commit: add --trailer option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=
=8823=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=885:34=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Mar 22, 2021 at 11:23 AM ZheNing Hu <adlternative@gmail.com> wrot=
e:
> >
> > Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=
=E6=9C=8822=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:43=E5=86=99=E9=
=81=93=EF=BC=9A
>
> > > Nice that you have added such a test!
> >
> > Thanks.
> >
> > But at the same time I have two little doubt.
> >
> > 1.
> > If we have your config:
> >
> > $ git config trailer.sign.key "Signed-off-by: "
> > $ git config trailer.sign.ifexists replace
> > $ git config trailer.sign.command "git log --author=3D'\$ARG' -1
> > --format=3D'format:%aN <%aE>'"
> >
> > Then I touch a test.c and use:
> >
> > $ git interpret-trailers --in-place test.c
> >
> > without `--trailer`, See what is happen:
> >
> > It seem like your local repo last commit "name <email>" pair
> > have been record in `test.c`.
> >
> > Could this be considered a bug?
>
> First it seems strange to use `git interpret-trailers` on a "test.c"
> file. It's supposed to be used on commit messages.
>
> Then, as the doc says, every command specified by any
> "trailer.<token>.command" config option is run at least once when `git
> interpret-trailers` is run. This is because users might want to
> automatically add some trailers all the time.
>

Well, I understand it now.

> If you want nothing to happen when $ARG isn't set, you can change the
> config option to something like:
>
> $ git config trailer.sign.command "NAME=3D'\$ARG'; test -n \"\$NAME\" &&
> git log --author=3D\"\$NAME\" -1 --format=3D'format:%aN <%aE>' || true"
>
> (This is because it looks like $ARG is replaced only once with the
> actual value, which is perhaps a bug. Otherwise something like the
> following might work:

this is because `$ARG` is replaced in "trailer.c" by "strbuf_replace" which
only replcae the specified string for only one time,
I think `strbuf_replace()` can be changed like:

@@ -110,8 +110,9 @@ static inline int is_blank_line(const char *str)

 static inline void strbuf_replace(struct strbuf *sb, const char *a,
const char *b)
 {
-       const char *ptr =3D strstr(sb->buf, a);
-       if (ptr)
+       char *ptr =3D sb->buf;
+
+       while ((ptr =3D strstr(ptr, a)))
                strbuf_splice(sb, ptr - sb->buf, strlen(a), b, strlen(b));
 }

>
> git config trailer.sign.command "test -n '\$ARG' && git log
> --author=3D'\$ARG' -1 --format=3D'format:%aN <%aE>' || true")
>
> Then you can run `git interpret-trailers` with the --trim-empty option
> like this:
>
> ------
> $ git interpret-trailers --trim-empty --trailer sign=3DLinus<<EOF
> EOF
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ------
>
> or like:
>
> ------
> $ git interpret-trailers --trim-empty<<EOF
> > EOF
>
> ------

Thanks for effective solution.
Maybe I should also correct this part of the test.
