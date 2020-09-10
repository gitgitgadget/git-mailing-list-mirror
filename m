Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA886C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC8C21556
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmyWnPpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIJTss (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgIJTsa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:48:30 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB37FC061757
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:48:26 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id y194so4092903vsc.4
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k26pko0hwwBRW4jXrgO5W/RVo8ZUdiObIhHWpcvYn6M=;
        b=hmyWnPpo3YeLQvoKy74o7HRd6S/7EGePUlH31IVrzHxME3mJJFbLPKSCebzseIivDy
         lczjp142rx48hktXrkuYJ+8aVOoa3WXZpEIu5wVrWAtjda84TfQnIYSfHuDjSgDGmuby
         d6PtprTzbugzeePKf9CVSvvQGJ2kXZ3ZWeA5mDbUYvjbpeDcpk97+PyMH0Rg4DxpkvYp
         oYoMdl7K8gfN4hhuLK0Z1Qlsbz3QgyaVNMXLwBYsObXt1n679qRCWTlv8hpNPrH5/D+L
         2JSnCB13DPu3TZZPzIuRutZQzoUgIpCcvuxPBU17ugykg/zGExPBmEYvny98qFFnrBln
         QX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k26pko0hwwBRW4jXrgO5W/RVo8ZUdiObIhHWpcvYn6M=;
        b=PI8nVQu9eCWLdKbfWRxzKJqcSUFXNRgugcLAQwu7z5XitV74q1PzrJGopGKcCzJxRL
         F3jaR1RKg+UZ3bJAQFWoGA9/ba8EtW6qXz8BVaW6MKCY8Y9tBaJ6Z0nYdrJhpOzJi1ab
         le4u1RBdAnJeuFuyrrRHwSJipUCcOHVnuFQD9LsMWWZjbUiq+KaHgGe/bGaR1EwrP2PL
         JlUPkpv/cc0Bgm45ZEPlmVfhJusTOiK8ClKYGcOV4bnIO2RLRW22AOXKr8VRxQ5AQ4Ks
         YrnoYalybc5KQ26bK1ocz5Sta/BEnTwOaq5m8fzXhUThtmjiD3glO3WjDBdhov3B4E9B
         cwvA==
X-Gm-Message-State: AOAM533iW0qqTGe9KWrA7ca1NXlpUZLoPwUgr1rOJE9RgKBCodgLan25
        bps9j5mvMSbI3JUzN7KPkxgkrw1vHsbL1vEs74I=
X-Google-Smtp-Source: ABdhPJxKQy+jVkwn/kxzCi5+aN7XYbEiJ6QPg9/mbrjf8RHb1NTZg7OnskEFEfTzTmxMXaxlV2VT7tYlHgT90Ffbg1U=
X-Received: by 2002:a67:7d52:: with SMTP id y79mr5474338vsc.34.1599767305797;
 Thu, 10 Sep 2020 12:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599762679.git.martin.agren@gmail.com> <8383c246f8c23e61dedd69d6e69c72d51fd6b469.1599762679.git.martin.agren@gmail.com>
 <CAPig+cT_VvOiKBCC=E_P0R8SXkoWPVUxxOOLovOmr8N377YNdQ@mail.gmail.com>
In-Reply-To: <CAPig+cT_VvOiKBCC=E_P0R8SXkoWPVUxxOOLovOmr8N377YNdQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 10 Sep 2020 21:48:13 +0200
Message-ID: <CAN0heSrUWiZ_xar3G5rZG-c=8OVp5-eByS6rMXOw9wfTA8kmbA@mail.gmail.com>
Subject: Re: [PATCH 8/8] worktree: simplify search for unique worktree
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 10 Sep 2020 at 21:28, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Thu, Sep 10, 2020 at 3:08 PM Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> > We track the number of worktrees we've found and break out of the loop
> > early once we hit 2. This is because we're not really interested in the
> > number of matches -- we just want to make sure that we don't find more
> > than one worktree that matches the suffix. This can be done just as wel=
l
> > by checking the NULL-ness of the pointer where we collect our
> > answer-to-be. Drop the redundant `nr_found` variable.
> >
> > Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> > ---
> > diff --git a/worktree.c b/worktree.c
> > @@ -172,13 +172,13 @@ static struct worktree *find_worktree_by_suffix(s=
truct worktree **list,
> >                                                 const char *suffix)
> >  {
> > -       for (; *list && nr_found < 2; list++) {
> > +       for (; *list; list++) {
> > @@ -186,11 +186,12 @@ static struct worktree *find_worktree_by_suffix(s=
truct worktree **list,
> >                 if ((!start || (start > 0 && is_dir_sep(path[start - 1]=
))) &&
> >                     !fspathcmp(suffix, path + start)) {
> > +                       if (found)
> > +                               return NULL;
> >                         found =3D *list;
> > -                       nr_found++;
> >                 }
> >         }
> > -       return nr_found =3D=3D 1 ? found : NULL;
> > +       return found;
>
> Although this change appears to be correct and does simplify the code,
> I think it also makes it a bit more opaque. With the explicit
> `nr_found =3D=3D 1`, it is quite obvious that the function considers
> "success" to be when one and only one entry is found and any other
> number is failure. But with the revised code, it is harder to work out
> precisely what the conditions are.

Thanks for commenting. I found the original trickier than it had to be.
It spreads out the logic in several places and is careful to short-cut
the loop. My first thought was "why doesn't this just use the standard
form?". But I'm open to the idea that it might be a fairly personal
standard form... If there's any risk that someone else comes along and
simplifies this to use a `nr_found` variable, then maybe file this under
code churning?

> Having said that, I think a simple
> comment before the function would suffice to clear up the opaqueness.
> Perhaps something like:
>
>     /* If exactly one worktree matches 'target', return it, else NULL. */

That's a good suggestion regardless.

Thanks
Martin
