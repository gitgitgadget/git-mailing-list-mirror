Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB0FC43334
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 05:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiGIFET (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 01:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGIFES (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 01:04:18 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0529813E3E
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 22:04:16 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31cac89d8d6so5583347b3.2
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 22:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gTQoYFZvpp+KbrO+W89cguqpzoWCO/MpXk5WY9EwNp4=;
        b=XIMjbvEMhMhBaxV6GSujNl6SgLMoOpgvpbT79cBi6JY6uHoi2JRtcQ1dnnv6eEUzer
         vW5veigZjJopMzWIgMxaRpKCLQI36pbokUXF1IRUIznFrZVzIcHkmQrBuP0oVbC55aus
         liKRqUf3UQOMQa7mhcl5pGlI3+mEGjRi/SmFt5ZHyHjs/SPj4E0vr6Ar2b59MqCC2vqz
         IOZzaAcOBxwvu5ega+BXphed7Q9GEQpvSW5D4fTo9MaeCLb6az0C4qKsaulLDAs7G7fK
         WAi8aRA3EftTu4b0gsxBzwxb5b7PPEkhr3+RYbtJFQylf5UKtXyy4YKpRJIzcDPfMw3W
         4POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gTQoYFZvpp+KbrO+W89cguqpzoWCO/MpXk5WY9EwNp4=;
        b=BXZG0joKLxtqO8Q7MgqfSFPwdDi8cisWG9IG4fHavgwOwbvnRGmWoF4KRpa7KMkfN3
         67kRnCUQ7n0uirqDkXc7BUJaW5WcemuBg/AM2Khf/2zL4xOixcVx0IXDmDbaIZmss/3E
         4miXGQ10sxPnPYFgA4e0vaY2MTUHWXWAbSM/ryp5KrfIYdedin1G9afB8WeUNezGqHvS
         HhpqPqCx+XDCcEnrr1O+VKrdGp40CJ1bv6jb0eniz6bT1MzoUgbqrccwhSkWi2xzFlvu
         h3mjYbq7vLadmhFhfWiwcp5yBOl1ZhaAIpnJoPNfj5pMvMWjpw8BH6dGlPXhM1rMT78W
         Zp7w==
X-Gm-Message-State: AJIora/BACj8lmDkzcmFrTNAwHwyhGgEvdFW2DypnU0SAx5Xb6v+0/Ef
        niBdykzPWjwBRbeoD4CwywsG7Wqo3/qGjgqrtYw=
X-Google-Smtp-Source: AGRyM1viYQO8GSygep24/Ny9/B5H9+BJB9MV065zYK1yOxFMhiL0QVYK33QKt5lYhCSJafG9yX2JBBXV6JBex00avBs=
X-Received: by 2002:a0d:ea47:0:b0:31c:9814:dd81 with SMTP id
 t68-20020a0dea47000000b0031c9814dd81mr7815785ywe.346.1657343055072; Fri, 08
 Jul 2022 22:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220707161554.6900-1-siddharthasthana31@gmail.com> <20220707161554.6900-2-siddharthasthana31@gmail.com>
 <YshESKSHfpcQf/dI@danh.dev> <CAP8UFD116xMnp27pxW8WNDf6PRJxnnwWtcy2TNHU_KyV2ZVA1g@mail.gmail.com>
 <YsjTif0TjYBzBXfh@danh.dev>
In-Reply-To: <YsjTif0TjYBzBXfh@danh.dev>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 9 Jul 2022 07:04:03 +0200
Message-ID: <CAP8UFD0p+Ty1Fx-vBoX6N0Ahg+Z_JCYe_Jypk7Mag=yY2yzbqg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] revision: improve commit_rewrite_person()
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 9, 2022 at 3:02 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <=
congdanhqx@gmail.com> wrote:
>
> Add list back to cc

Sorry for not keeping the list in Cc by mistake.

> On 2022-07-08 23:23:07+0200, Christian Couder <christian.couder@gmail.com=
> wrote:
> > On Fri, Jul 8, 2022 at 4:50 PM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Da=
nh <congdanhqx@gmail.com> wrote:
> > >
> > > On 2022-07-07 21:45:51+0530, Siddharth Asthana <siddharthasthana31@gm=
ail.com> wrote:
> >
> > > > By simplyfying the interface of the commit_rewrite_person(), we als=
o
> > >
> > > s/simplyfying/simplifying/
> >
> > Thanks for noticing the typos!
> >
> > > > +static void commit_rewrite_person(struct strbuf *buf, const char *=
*headers, struct string_list *mailmap)
> > > > +{
> > > > +     size_t buf_offset =3D 0;
> > > > +
> > > > +     if (!mailmap)
> > > > +             return;
> > > > +
> > > > +     for (;;) {
> > > > +             const char *person, *line =3D buf->buf + buf_offset;
> > > > +             int i, linelen =3D strchrnul(line, '\n') - line + 1;
> > >
> > > Would you mind to change those lines to avoid mixed of declaration an=
d
> > > expression.
> >
> > I am not sure we have some clear guidelines on this.
>
> Yes, we don't have a clear guidelines on this, but this would sure
> matches into mixed declaration and expression. And some variables are
> initialized and some aren't in the same line. I was confused in my
> first glance.

Yeah, it might be clearer to avoid having some variables both declared
and initialized while others are only declared on the same line.

> > > Also, I think i and linelen should be ssize_t instead.
> >
> > Could you explain why?
> >
> > I think 'i' is changed only in:
> >
> > for (i =3D 0; headers[i]; i++)
> >
> > and therefore cannot be n=C3=A9gative.
> >
> > While linelen is set only in:
> >
> > linelen =3D strchrnul(line, '\n') - line + 1;
> >
> > and therefore cannot be n=C3=A9gative either.
>
> Yes, both of them can't be negative. As I explained in the part you
> removed.  However, I choose ssize_t in my reply because it's
> a ptrdiff_t.
>
> So, size_t is an obviously a better choice.
> Either size_t and ssize_t could be used in this case, but not int.

I am Ok with size_t. Thanks for the explanations!

> >>> +
> >>> +             if (!linelen || linelen =3D=3D 1)
> >>> +                     /* End of header */
> >>> +                     return;
> >>
> >>And I think linelen will never be 0 or negative,
> >>even if linelen could be 0, I think we want "linelen !=3D 0"
> >>for integer comparision.

maybe `if (linelen <=3D1)` is just a simpler check.
