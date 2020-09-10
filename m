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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16021C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C491520882
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQ8RtM9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgIJTkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgIJTkK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:40:10 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6ACC061573
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:40:10 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id s62so4064724vsc.7
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZUJMyywpyQoUkY/zK0JuKR1JZlGJsbsp43acgZdkakg=;
        b=bQ8RtM9HLAtvTOEJ6+KhvPqGkLMk703vRlpd7/DXBX2J2lNY0Qn0IWLPY8J/nitDGP
         r4aptwGjrYOlOFpW97MoRUDgkEZBp682vb4trkU6Zw3h8eFrNTvYU6ZMthUsKQvjWo/G
         N6iWSRRnLFBXrXG3serXtJIZ187h13l2b/nDZEQxbAhPftmCu3hD+6Y53fUwmzGPAEvn
         LFFQaryBuJQmawpV4K52mbaYp68Da8WhakVmr/37m5/fQxbQruoFFgQaD7+aC4exeIPd
         rM82f1yx2eA1wXPAxE1bZbE9LDSvPwBOaQVO9XoO7uUsH41uqpeN8kcRBiawAa/7Z6xZ
         MdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZUJMyywpyQoUkY/zK0JuKR1JZlGJsbsp43acgZdkakg=;
        b=JyPXRJDXvIBGCVh+zScRX3i9d6cyEOyzoUjSx/ZImL/TPUUbBiIYyY+3/xcVCTXOqb
         h0q7EzZnGjn5krALXSgfym/Y/gC4wVcWzaiglUIwvq1G3fiu7JV7Y+VbIHb42uiMuosO
         ZWGUS4qJNW9dEVKk6OMP5NcU3CIE4qLUSEvkDmm7TwoexBWgEloBOgxurrwOBCPQgb02
         MQnrUyo4uRCSwqYNS9J9o3iyNw+zI0ozp6PGEZ1cnSXcUoIldBQJmvCWmF5NxF7MsSTz
         r6pqOZL6a2Bh5XTvZtRiziqSb8SY8VhIiZqgCBCkBLKP39X76QC7he2u2m36vK4J3+sg
         Apvg==
X-Gm-Message-State: AOAM532GGk9/H2PmEVDtt/G6SF7TJbgpNPKiUSqA7bkxXSd2HvMKQpTW
        yv5VA6Z6k8ckmfBd5UHtmrNEgrWt4YFGOZWQ/4ORQAAQrGU=
X-Google-Smtp-Source: ABdhPJz6FzQr0OwKsn0y0rQoYs2CHPSPmQugxrv0TCKO/PLF5LI3Xm+KZIMiLIe27W7knSQUk0JQPMxkWeLL4sk97T4=
X-Received: by 2002:a67:ff17:: with SMTP id v23mr5593809vsp.107.1599766809075;
 Thu, 10 Sep 2020 12:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599762679.git.martin.agren@gmail.com> <58a2469cc18839e57b45f687b6e484d69161a34c.1599762679.git.martin.agren@gmail.com>
 <CAPig+cTZLqFayp0wZEFYkaXtoOx8HedUK1oQoOa+zq=Yrgvjbg@mail.gmail.com>
In-Reply-To: <CAPig+cTZLqFayp0wZEFYkaXtoOx8HedUK1oQoOa+zq=Yrgvjbg@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 10 Sep 2020 21:39:56 +0200
Message-ID: <CAN0heSrQT9N3=e70qkgS_rOQ0oy0rrHqud=rRtr-r5JaL=ofNQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] worktree: drop useless call to strbuf_reset
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 10 Sep 2020 at 21:15, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Thu, Sep 10, 2020 at 3:08 PM Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> > There's no need to reset the strbuf immediately after initializing it.
> >
> > Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> > ---
> > diff --git a/worktree.c b/worktree.c
> > @@ -552,7 +552,6 @@ const char *worktree_ref(const struct worktree *wt,=
 const char *refname)
> >  {
> >         static struct strbuf sb =3D STRBUF_INIT;
> >
> > -       strbuf_reset(&sb);
> >         strbuf_worktree_ref(wt, &sb, refname);
> >         return sb.buf;
> >  }
>
> I think this patch is wrong and should be dropped. That strbuf is
> static, and the called strbuf_worktree_ref() does not reset it, so
> each call to worktree_ref() will now merely append to the existing
> content (which is undesirable) following this change.

Oh wow, that's embarrassing. Thank you so much for spotting.

I wonder how many worktrees you need before this optimization to avoid
continuous allocation starts paying off. I guess our test runs never
actually hit this. Unless the tests are loose enough that my bug manages
to go unnoticed even if it actually triggers during a test run.

That's not to say this optimization won't ever be useful, of course. I
also begin to hope that no caller keeps their returned pointer around
for long. It only seems to be used from `other_ref_heads()` and that
looks ok. If we do want this strbuf reuse, maybe that function could
just keep its own strbuf and reuse it (not necessarily having it be
static) and learn not to call `worktree_ref(wt, "HEAD")` twice.

But anyway, this patch should definitely be dropped.

Thanks
Martin
