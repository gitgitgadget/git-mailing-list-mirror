Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490D8C433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 12:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18BFD23109
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 12:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbhAZMcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404243AbhAZKno (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 05:43:44 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E974BC06174A
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 02:43:02 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id a77so679828oii.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 02:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KvUH57TPqjODHpRuVsGO7440j0Z0RYQZkFSGO58QOKY=;
        b=nov1a855iEFgs47msXL2RiifIjpcn8a+Rx9uGC+zUgukanclrYfdMzxObVtIdsM8tk
         IqNkxf/BKsqY7MvayCDX7JND8eLzm/WlWdJzHyqRMoTo/31ldVqk9RDD8JnTcraP/swj
         8S3wYj3spc7Y9RXRYHKJfjLljO+AgpB1W+gfGZ2MHeEreOPvkUFu48aVbxwAEmYkZWn/
         BiduMY5pqo4/J1c5no012ZMfdttqQMmdcKvU8hIkDyjm+7mx47PKnQhvyGK1kZaao+AO
         oYHIOOTS88juL1qgz/mdlPhTK9uXlQN6iBlk54RUXJBi2zXgNtv6iBe6x4rUqa/2T3Q4
         3YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KvUH57TPqjODHpRuVsGO7440j0Z0RYQZkFSGO58QOKY=;
        b=RW+zrFst1/T/BE+SuKA0KyJqmxvE3KcCdXw8fIBck+RZbSHqa6t+//mCL3/azjX/Mg
         gMWX5Iaq/pka0RWDF3/vjhzcjKYp865LxA9LtyKLUL9Eojuc1CTp+HrbguGSG4fh9CqV
         3cqsCEfRVgYJubu6FTrGAgUxfwB2FwK2vIQRKnWAhY++7VAC6U44aK3i4Ysnj8DS7Dbs
         z9NdpOQPTpx07Y54/wSVYZxPxuPWv7X459c3PDAJC3HSvjqW5b5iRtWvn6xz8LlIpJc4
         KpfzN4YIYlLNrb5wqUJZRm9/Jzaq+yaLj/xk9aWLh/h7fJ66VM0s/2Rnh3lUsCT2aP1K
         zUQA==
X-Gm-Message-State: AOAM532/D6IZH7JwOxjS1+zaeR2HoegXujCxmC150yCgtMDqwjZCuKi0
        IjqusX2nLVG4psRoQrC0ZmLBRNTfOMpOUhn0R5Y=
X-Google-Smtp-Source: ABdhPJy6PILfJt4iemgI+OFez1RSTrHTzYuTNdJIsVDD+iUJv5j8oQE6rYsDiIfcKM2cNHsayNUB4O3TbTRBtIj+U5A=
X-Received: by 2002:aca:1a17:: with SMTP id a23mr2765444oia.120.1611657782385;
 Tue, 26 Jan 2021 02:43:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.846.git.1611637582625.gitgitgadget@gmail.com> <xmqqy2gg2pdm.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2gg2pdm.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Tue, 26 Jan 2021 18:44:57 +0800
Message-ID: <CAOLTT8T1N2FSK3GiLaQUZt-OO5qzjQz7iq2cuKxasmuwnEZoXw@mail.gmail.com>
Subject: Re: [PATCH] strbuf.c: optimize program logic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?6Zi/5b6354OIIHZpYSBHaXRHaXRHYWRnZXQ=?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:17=E5=86=99=E9=81=93=EF=BC=9A
>
> "=E9=98=BF=E5=BE=B7=E7=83=88 via GitGitGadget" <gitgitgadget@gmail.com> w=
rites:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > the usage in strbuf.h tell us"Alloc is somehow a
> > "private" member that should not be messed with.
> > use `strbuf_avail()`instead."
>
> When we use the word "private", it generally means it is private to
> the implementation of the API.  IOW, it is usually fine for the
> implementation of the API (i.e. for strbuf API, what you see in
> strbuf.c) to use private members.
>
Well, I just think most other functions in strbuf.c follow the use
of `strbuf_avail()` instead of "sb->alloc-sb->len-1", and the
"sb->alloc-sb->len-1" that appears in `strbuf_read()` is not so uniform.
> In any case, these changes are _not_ optimizations.
>
> Replacing (alloc - len - 1) with strbuf_avail() is at best an
> equivalent rewrite (which is a good thing from readability's point
> of view, but not an optimization).  We know sb->alloc during the
> loop is never 0, but the compiler may miss the fact, so the inlined
> implementation of _avail, i.e.
>
>         static inline size_t strbuf_avail(const struct strbuf *sb)
>         {
>                 return sb->alloc ? sb->alloc - sb->len - 1 : 0;
>         }
>
> may not incur call overhead, but may be pessimizing the executed
> code.
I agree,It may be a good practice not to use redundant inline functions,
because it will not make the git binary file too bloated.
>
> If you compare the code in the loop in the second hunk below with
> what _setlen() does, I think you'll see the overhead of _setlen()
> relative to the original code is even higher, so it may also be
> pessimizing, not optimizing.
>
> So, overall, I am not all that enthused to see this patch.
>
>
> One thing I noticed is that, whether open coded like sb->len +=3D got
> or made into parameter to strbuf_setlen(sb, sb->len + got), we are
> not careful about sb->len growing too large and overflowing with the
> addition.  That may potentially be an interesting thing to look
> into, but at the same time, unlike the usual "compute the number of
> bytes we need to allocate and then call xmalloc()" pattern, where we
> try to be careful in the "compute" step by using st_add() macros,
> this code actually keep growing the buffer, so by the time the size_t
> overflows and wraps around, we'd certainly have exhausted the memory
> already, so it won't be an issue.
>
This is true, but is there any good way to avoid this form of overflow?
> But we may want to audit existing code that is not careful when
> preparing the second parameter to strbuf_setlen().  We just
> analyzed, if we were to accept this patch, that "sb->len + got" that
> appear as the second parameter to new call of strbuf_setlen() looks
> bad but would not matter in practice, but we may not be so lucky in
> other places.
>
I thought before `strbuf_read_once()`have almost analogous
"strbuf_setlen(sb, sb->len + cnt)",so I change it.May be you are right,
"sb->len + got"is not safe.
> Thanks for a food for thought.
>
> > diff --git a/strbuf.c b/strbuf.c
> > index e3397cc4c72..76f560a28d0 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -517,7 +517,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size=
_t hint)
> >
> >       strbuf_grow(sb, hint ? hint : 8192);
> >       for (;;) {
> > -             ssize_t want =3D sb->alloc - sb->len - 1;
> > +             ssize_t want =3D strbuf_avail(sb);
> >               ssize_t got =3D read_in_full(fd, sb->buf + sb->len, want)=
;
> >
> >               if (got < 0) {
> > @@ -527,7 +527,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size=
_t hint)
> >                               strbuf_setlen(sb, oldlen);
> >                       return -1;
> >               }
> > -             sb->len +=3D got;
> > +             strbuf_setlen(sb, sb->len + got);
> >               if (got < want)
> >                       break;
> >               strbuf_grow(sb, 8192);
> > @@ -543,7 +543,7 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd,=
 size_t hint)
> >       ssize_t cnt;
> >
> >       strbuf_grow(sb, hint ? hint : 8192);
> > -     cnt =3D xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
> > +     cnt =3D xread(fd, sb->buf + sb->len, strbuf_avail(sb));
> >       if (cnt > 0)
> >               strbuf_setlen(sb, sb->len + cnt);
> >       else if (oldalloc =3D=3D 0)
> >
> > base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
