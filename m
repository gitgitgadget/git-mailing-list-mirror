Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584B5C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 06:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA3E64E00
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 06:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhA2GIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 01:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhA2GHx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 01:07:53 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F030C061574
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 22:07:13 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id f6so7625586ots.9
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 22:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hu83Kv1/KcuxlrFrLUqzcxoK6m0vPRsq0sfnH+wTsJY=;
        b=nuGVUQXgak7s4Z1puFXl77TiKuZXHucwqN04EpQb87yfLxjnLRgpxj+732ZX/bJUv8
         3qEcmu5Pv6m/5hr0xvpCDZrl3gkulag1apEzN1Ys3qzyDizAxj4oUTiOWtNZo7pOEmJB
         MfVyP4GlOtQNjO9yoy9E7L9mBqksWxjYxGjyoRtn8IW/vqiPePjd+tviUqgtt3A8rrf+
         t+k+TH1FU4CY60F39joY0mXxNtr5JenITUpp+y4r7U+fHc0Da8BHRkFCoc0AFYxPYGk2
         cYy4E1OPZ/0Gs6I7PPyubSGPuUU9Sue4tR3Af+QWQ1OZJt1WIXiXYhRNgZF0bNY/zLWn
         AY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hu83Kv1/KcuxlrFrLUqzcxoK6m0vPRsq0sfnH+wTsJY=;
        b=ra+0Z3KANppxQOsDyBOGJxBBgmpy3b/XDK6GjDHVScoQ6+3BVeiChEPQo1lbvuK0nj
         xjAM/PGY89V28PaS9vN3KmFRkHoK+iOkAATnToTTYUbJvSIC0IrptkoZFAMK/NkWZcss
         zy2ILSpQiFKlEXnV4S64nnb4NNaSYtrIr+mJUue3AQfZ44nsrDkCI81jOI1WI8lbDQiI
         OUpseun1BPYeZPmP6do4aEaWf9f+FeP22HVobhydGh/YG1GtLnpkYZyVM6DBYyeptfaA
         NhDqqogATCkkXgwfFCl0UdtCJTnAEtKAwAWPQ8Yd2Vn7BT9JWxOoipG+YhsTQ/2l8cS+
         Dndg==
X-Gm-Message-State: AOAM533+eLnjeJ3BEI0qI6qnHz/B6+g2vfk3zGWtgxi0NuprpX7bBp7H
        qLuhQEk9evyO4NQOBmBZc5r4/XKmwRUSC/SroyU=
X-Google-Smtp-Source: ABdhPJwVmFPDekBKfLcpAmpXxJiFHa4DwRE0/4vMOPLUNF1uHIazlUyBtNPsV1mmPAkfAceDQPfu53paqrP8C7TH2es=
X-Received: by 2002:a9d:4812:: with SMTP id c18mr1957913otf.160.1611900432729;
 Thu, 28 Jan 2021 22:07:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.846.git.1611637582625.gitgitgadget@gmail.com>
 <xmqqy2gg2pdm.fsf@gitster.c.googlers.com> <YBBeLIhd+VHS25CE@coredump.intra.peff.net>
In-Reply-To: <YBBeLIhd+VHS25CE@coredump.intra.peff.net>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Fri, 29 Jan 2021 14:09:12 +0800
Message-ID: <CAOLTT8RroMdaty-SwAfK3OSeuFA7PE6ZhPCL4vgrxFxNihdGbQ@mail.gmail.com>
Subject: Re: [PATCH] strbuf.c: optimize program logic
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?6Zi/5b6354OIIHZpYSBHaXRHaXRHYWRnZXQ=?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B41=E6=9C=8827=E6=97=A5=E5=91=
=A8=E4=B8=89 =E4=B8=8A=E5=8D=882:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jan 25, 2021 at 10:17:41PM -0800, Junio C Hamano wrote:
>
> > "=E9=98=BF=E5=BE=B7=E7=83=88 via GitGitGadget" <gitgitgadget@gmail.com>=
 writes:
> >
> > > From: ZheNing Hu <adlternative@gmail.com>
> > >
> > > the usage in strbuf.h tell us"Alloc is somehow a
> > > "private" member that should not be messed with.
> > > use `strbuf_avail()`instead."
> >
> > When we use the word "private", it generally means it is private to
> > the implementation of the API.  IOW, it is usually fine for the
> > implementation of the API (i.e. for strbuf API, what you see in
> > strbuf.c) to use private members.
> >
> > In any case, these changes are _not_ optimizations.
>
> Yeah, I had both of those thoughts, too. :)
>
> Though...
>
> > Replacing (alloc - len - 1) with strbuf_avail() is at best an
> > equivalent rewrite (which is a good thing from readability's point
> > of view, but not an optimization).  We know sb->alloc during the
> > loop is never 0, but the compiler may miss the fact, so the inlined
> > implementation of _avail, i.e.
> >
> >       static inline size_t strbuf_avail(const struct strbuf *sb)
> >       {
> >               return sb->alloc ? sb->alloc - sb->len - 1 : 0;
> >         }
> >
> > may not incur call overhead, but may be pessimizing the executed
> > code.
> >
> > If you compare the code in the loop in the second hunk below with
> > what _setlen() does, I think you'll see the overhead of _setlen()
> > relative to the original code is even higher, so it may also be
> > pessimizing, not optimizing.
> >
> > So, overall, I am not all that enthused to see this patch.
>
> I would generally value readability/consistency here over trying to
> micro-optimize an if-zero check.
>
> However, if strbuf_avail() ever did return 0, I'm not sure the loop
> would make forward progress:
>
>           strbuf_grow(sb, hint ? hint : 8192);
>           for (;;) {
>                   ssize_t want =3D strbuf_avail(sb);
>                   ssize_t got =3D read_in_full(fd, sb->buf + sb->len, wan=
t);
>
>                   if (got < 0) {
>                           if (oldalloc =3D=3D 0)
>                                   strbuf_release(sb);
>                           else
>                                   strbuf_setlen(sb, oldlen);
>                           return -1;
>                   }
>                   strbuf_setlen(sb, sb->len + got);
>                   if (got < want)
>                           break;
>                   strbuf_grow(sb, 8192);
>           }
>
> we'd just ask to read 0 bytes over and over. That almost makes me want
> to add:
>
>   if (!want)
>         BUG("strbuf did not actually grow!?");
>
> or possibly to teach the "if (got < want)" condition to check for a zero
> return (though I guess that would probably just end up confusing us into
> thinking we hit EOF).
>
I agree.But I always feel that there will be no such strange bug.
> > One thing I noticed is that, whether open coded like sb->len +=3D got
> > or made into parameter to strbuf_setlen(sb, sb->len + got), we are
> > not careful about sb->len growing too large and overflowing with the
> > addition.  That may potentially be an interesting thing to look
> > into, but at the same time, unlike the usual "compute the number of
> > bytes we need to allocate and then call xmalloc()" pattern, where we
> > try to be careful in the "compute" step by using st_add() macros,
> > this code actually keep growing the buffer, so by the time the size_t
> > overflows and wraps around, we'd certainly have exhausted the memory
> > already, so it won't be an issue.
>
> I think "len" is OK here. An invariant of strbuf is that "len" is
> smaller than "alloc" for obvious reasons. So as long as the actual
> strbuf_grow() is safe, then extending "len".
>
> I'm not sure that strbuf_grow() is safe, though. It relies on
> ALLOC_GROW, which does not use st_add(), etc.
>
I want to say is that `strbuf_grow()` have checked overflow before
 `ALLOC_GROW`,so that `strbuf_grow()`is maybe also safe too? :)
void strbuf_grow(struct strbuf *sb, size_t extra)
{
       int new_buf =3D !sb->alloc;
       if (unsigned_add_overflows(extra, 1) ||
           unsigned_add_overflows(sb->len, extra + 1))
               die("you want to use way too much memory");
       ...
}
> -Peff
>
> PS The original patch does not seem to have made it to the list for some
>    reason (I didn't get a copy, and neither did lore.kernel.org).
