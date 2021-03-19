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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CBFC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 07:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E81864F62
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 07:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhCSH0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 03:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbhCSH0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 03:26:07 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFA2C06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 00:26:07 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id d133so3801511oib.3
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 00:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fw2z9tDWqi2922MjRcfvlo4VkgWTGleQthnPPDDDZks=;
        b=JYBn3yDr+94il167xjOXSUJf5zTKQCZGJiWab0FPNjBnJLgG5hKrkTN7iunmj8vZuw
         TqnVQyONsaoItUdhFrnYAxt15fKR85Dnzjev+NuMCfMxC24wCeQDibTrTFP4MG41EUb7
         L98WtzZ0CZqbRxtJIsoWDGQ1eTSA4bm9iuIASiar+hiFQ7GBsGH6ER9T2WltX2NSc/4c
         PYO/xWxN3z1Ne+VdVp3TYHCm5eGUphO+MOl/SrDeH1wh45xeuSy2KqcszLNIK7KXhsxU
         MNmsTuPPUhjrPNyKue2jP9Xyt+zectj8Nf5D/nccEyloBDP0b0t5m47XMoG/H2+KUTm/
         J0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fw2z9tDWqi2922MjRcfvlo4VkgWTGleQthnPPDDDZks=;
        b=dnnL6i6mDchcA2+kwFXpihxRQVqLBmCCubjf7pFNfPsaPfRWtzMZd8wqBCRrfc2ZAz
         eOn3Eka7caezrzM+o7bUlrQqUNw4SMjK6HC9fDipZUzq3nE2x6lwriXqorilea6JdI2Y
         01MVfZvhTXGNKQtSf6awqOXimDYX9btmeAfEjFcIPtSK6H82XNixqIS+C9y1zBzP6udJ
         eFCOMepzDlwYMFtqsPVV0TySupT2Ur4Mqsp/TgVZkWG87vXsN1AvjnwY3hKGDnI1LJbH
         cH5Wk6r31Ha/j2VyJiW9iGyZWl172Pk2pCDU9aCsFH2qjl6CUPUrhNW9gg11OrsfqSg+
         e+Gw==
X-Gm-Message-State: AOAM5336TmNs5scLiHvSAGnfsM4+UUqUhwaZxfonGVaJrbQL873awZr8
        sMMnf6udEEJbC5qQO/R/ERbaHJfMdWJ6J1BPAng=
X-Google-Smtp-Source: ABdhPJwZNBbAe4MRs/SYgIPIwmgF+cv2VloxCyi4+mZh3kX655HUVIRKfKvkiYlzSsWaRGz0nL5J6SSrj16EmMiZPGg=
X-Received: by 2002:aca:af10:: with SMTP id y16mr109470oie.120.1616138766724;
 Fri, 19 Mar 2021 00:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v5.git.1615883137212.gitgitgadget@gmail.com>
 <pull.885.v6.git.1616047200968.gitgitgadget@gmail.com> <CAPig+cTv55r+Nr9pb1jQh99YjzkWgjfeYFUEgcMr1LM9g=5xXA@mail.gmail.com>
In-Reply-To: <CAPig+cTv55r+Nr9pb1jQh99YjzkWgjfeYFUEgcMr1LM9g=5xXA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 19 Mar 2021 15:25:55 +0800
Message-ID: <CAOLTT8SMW=UjXq5PJDe2w_ur=1JH-Kdhh4mKdkmRyXBG9HoEbQ@mail.gmail.com>
Subject: Re: [PATCH v6] format-patch: allow a non-integral version numbers
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8819=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:00=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Thu, Mar 18, 2021 at 2:00 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Usually we can only use `format-patch -v<n>` to generate integral
> > version numbers patches, but sometimes a same fixup should be
> > labeled as a non-integral version like `v1.1`, so teach `format-patch`
> > to allow a non-integral version which may be helpful to send those
> > patches.
> >
> > `<n>` can be any string, such as `-v1.1`.  In the case where it
> > is a non-integral value, the "Range-diff" and "Interdiff"
> > headers will not include the previous version.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> > diff --git a/builtin/log.c b/builtin/log.c
> > @@ -1662,13 +1662,18 @@ static void print_bases(struct base_tree_info *=
bases, FILE *file)
> > +static const char *diff_title(struct strbuf *sb,
> > +                             const char *reroll_count,
> > +                             const char *generic,
> > +                             const char *rerolled)
> >  {
> > -       if (reroll_count <=3D 0)
> > +       int v;
> > +
> > +       /* RFC may be v0, so allow -v1 to diff against v0 */
> > +       if (reroll_count && !strtol_i(reroll_count, 10, &v))
> > +               strbuf_addf(sb, rerolled, v - 1);
> > +       else
> >                 strbuf_addstr(sb, generic);
> > -       else /* RFC may be v0, so allow -v1 to diff against v0 */
> > -               strbuf_addf(sb, rerolled, reroll_count - 1);
> >         return sb->buf;
> >  }
>
> The comment about RFC and v0 doesn't really make sense anymore. Its
> original purpose was to explain why the `if` condition (which goes
> away with this patch) was `<=3D0` rather than `<=3D1`. It might make sens=
e
> to keep the comment if the code is written like this:
>
>     if (reroll_count &&
>             !strtol_i(reroll_count, 10, &v) &&
>             reroll_count >=3D 1)
>         strbuf_addf(sb, rerolled, v - 1);
>     else
>         ...
>
> However, I'm not sure it's worth re-rolling just to make this change.
>

Well, after testing, I think it is still necessary to add "v-1 >=3D0" to
the judgment
condition. Because if we use `-v0`, "Range-diff against v-1:" will be outpu=
t in
the patch.

> Thanks.

Thanks.
