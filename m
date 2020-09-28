Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77CCC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 06:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B182053B
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 06:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLtTMDHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgI1G5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 02:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1G5p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 02:57:45 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137A9C0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 23:57:45 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id p24so114977vsf.8
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=APnuiCvst3/2gcFkhFisGyVcZPTHySpLGSq+8Ozzdms=;
        b=oLtTMDHptodhCXg0jTL8U6PQ3uG9XG6ibSLTfTHLsPhbskUEqFierBiKAXpTnFBGYi
         RCnHvktXxUDFGGSZIOmZ4U33dUpqVjV3odl4AzpamEcUYqYex833/pQyyL5BP7DaAgdE
         zy9H/r1F6F09H9Ujp1ipC6uBvf7IhiOpN82zJeXbTpRQkh1VIPSBDJGlTBbpjQa5J4kl
         xheJkRRtDknU0pjEj+TNNgpEFQNc39nTJJO6WqoRNCEWimP8sXXNkSDmESvSWxPJoK3k
         V62qyqIHI39PYZrJQj7mg8HwkkGAeRisgAyMJvvfOb4RKkdzmsb3Su+70ylFyutmYSu4
         tWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=APnuiCvst3/2gcFkhFisGyVcZPTHySpLGSq+8Ozzdms=;
        b=dBg//AUQY5VP5AIFss4OZyggzlrcqhSs2vvs0rKzAwRGmgr1/gqY4GS6GVJZ1hNMoq
         WcqmO1glRILQtOVwxS/V0FplyKq1Xzrc9tm2t85hhB87dpA9vx5MfIWPogtkM0Li9wv4
         HFHK/s7HhWwA7sDOG5nd24RlJt9JxJV2cD5kTWdDcY3JZqLpYwOJt8aSa0/fHcODH3nU
         r9WlcHqke8FUsaXhomJx56eYYLxbrj78iKJFp16tvEIdZSq+csTPFZMfYeLQUvguCRzt
         HcwqGrLwAGiOckw70RGEWYwPI3lpCPKGsVc2spP2JIUdgxkXa/nE6u9StQzRd4tuDVTI
         AuTQ==
X-Gm-Message-State: AOAM5339q0ugfPCsKRm10BKqqeCP5Tqq0h+jvkIGBaXdRKC+iMGu3Lc3
        XrscQt0+eY2qnAyBB0VRUUvoI4SRSfQ0HHJq8jo828ua1N0=
X-Google-Smtp-Source: ABdhPJyhrnbuWWDTfBJwzC9+iNM88VgUQHiEETHgLaC33r7fvBaGFHQPDSZtxu7V+Sd58sfShbNBoG3Q3C+pqdYAnuw=
X-Received: by 2002:a67:d601:: with SMTP id n1mr139006vsj.2.1601276264240;
 Sun, 27 Sep 2020 23:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599762679.git.martin.agren@gmail.com> <cover.1600281350.git.martin.agren@gmail.com>
 <c4825f461e0408970f2adb272098bd6f2a80ef78.1600281351.git.martin.agren@gmail.com>
 <CAPig+cSBPFdF=hM5ho9_g6NCGAprh1mFFT5zX-C9huT3-Qkzow@mail.gmail.com>
In-Reply-To: <CAPig+cSBPFdF=hM5ho9_g6NCGAprh1mFFT5zX-C9huT3-Qkzow@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 28 Sep 2020 08:57:33 +0200
Message-ID: <CAN0heSr0mZDpjJysvzeG-et3uxpzDWcP3AdPVxiE+KYeY-7nQA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] worktree: inline `worktree_ref()` into its only caller
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 28 Sep 2020 at 07:30, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Sun, Sep 27, 2020 at 9:16 AM Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> > We have `strbuf_worktree_ref()`, which works on a strbuf, and a wrapper
> > for it, `worktree_ref()` which returns a string. We even make this
> > wrapper available through worktree.h. But it only has a single caller,
> > sitting right next to it in worktree.c.
> >
> > Just inline the wrapper into its only caller. This means the caller can
> > quite naturally reuse a single strbuf. We currently achieve something
> > similar by having a static strbuf in the wrapper.
> >
> > Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> > ---
> > diff --git a/worktree.c b/worktree.c
> > @@ -548,18 +548,10 @@ void strbuf_worktree_ref(const struct worktree *w=
t,
> > -const char *worktree_ref(const struct worktree *wt, const char *refnam=
e)
> > -{
> > -       static struct strbuf sb =3D STRBUF_INIT;
> > -
> > -       strbuf_reset(&sb);
> > -       strbuf_worktree_ref(wt, &sb, refname);
> > -       return sb.buf;
> > -}
> > -
> >  int other_head_refs(each_ref_fn fn, void *cb_data)
> >  {
> > +       struct strbuf refname =3D STRBUF_INIT;
> > @@ -571,14 +563,17 @@ int other_head_refs(each_ref_fn fn, void *cb_data=
)
> > +               strbuf_reset(&refname);
>
> If I understand correctly, this strbuf_reset() -- which, I suppose,
> moved here from the retired worktree_ref() -- is no longer needed now
> that the strbuf stopped being static. So, this line should be dropped
> from the patch.

What's not obvious from the diff is that this happens inside a loop
where we go through all worktrees. The strbuf could live one indentation
level deeper, in which case we'd continuously initialize and release it.
I placed it at the function-level instead, so that we initialize it
once and release it once. The "cost" for that is this reset call.

So it's sort of the same reset as before this patch, but it's local to
this function.

This reuse is what I tried to allude to in the second paragraph of the
commit message. The original has a single static strbuf, which is an
extreme form of reuse: subsequent calls to `other_head_refs()` will
"benefit" if you will from the pre-allocated buffer. After this patch,
this reuse "only" happens within a call. Subsequent calls will end up
doing their own allocations.

> > +               strbuf_worktree_ref(wt, &refname, "HEAD");
> >                 if (!refs_read_ref_full(get_main_ref_store(the_reposito=
ry),
> > -                                       worktree_ref(wt, "HEAD"),
> > +                                       refname.buf,
> >                                         RESOLVE_REF_READING,
> >                                         &oid, &flag))
> > -                       ret =3D fn(worktree_ref(wt, "HEAD"), &oid, flag=
, cb_data);
> > +                       ret =3D fn(refname.buf, &oid, flag, cb_data);
>
> One wonders why the original made two calls to worktree_ref() with
> identical arguments. Doing so seems to suggest that something about
> HEAD might change between the calls, but that doesn't seem to be the
> case. The message of the commit[1] which introduced the two calls to
> worktree_ref() doesn't explain the reason, and spelunking through the
> code doesn't immediately reveal why it was done that way either. So,
> presumably(?), it is indeed safe to fold them into a single call to
> strbuf_worktree_ref().

This matches my understanding. I'd be surprised if reading "HEAD"
changes where it points to. And even if it *could* change for some
reason, I'd actually expect this "let's call it again" to be a lurking
bug that doesn't count on that, rather than a clever caller that chooses
to rely on it. It could be that the extra call is because we know we're
using a static buffer and we're nervous that the call we made could have
ended up invalidating it, so we call it again to be on the safe side.
But that seems sort of far-fetched. A better (IMHO) solution to that
worry would have been something like what I'm doing here.

> [1]: ab3e1f78ae (revision.c: better error reporting on ref from
> different worktrees, 2018-10-21)

Martin
