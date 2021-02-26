Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61C3C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 10:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549D364EF3
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 10:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhBZKi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 05:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhBZKgq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 05:36:46 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A100C06174A
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 02:35:59 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 40so266548otu.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 02:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7gGf1wjeKDrTes7QgMyXUo977D+sEPgG+NUCYJH7Gh8=;
        b=jC/Ov1D+b6S5bXDzxC4/G875/FkrOjYVV/fJQ66iAB1ZO4Wys1tuQr5Z5r+hgkg9HJ
         8oxZgtVmtvtIwIcQnVla98p/PAOThRRHGrtpPHdnARLfThZcMWxZp7dkkonqpQg8FVgE
         2DLcnQhjejmDvPZ4cNm2YvATFg8XvmA8gt92kZEikjrhE3udtmaBhGFWoDrEQ2iDn0d/
         U+mYo0MvSFb0gQEMuCpGUf/q2yadl1Ig8yr8oO9e98bp/T6x/a9BL8zm4nirPtWwIfIv
         4VRvZtzkG3XouihfPt3CReThED0y4KgcqzJ+l6gD8QBbMKpA0CbNXaa/wFeGALXZ4QyH
         luJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7gGf1wjeKDrTes7QgMyXUo977D+sEPgG+NUCYJH7Gh8=;
        b=FgmGzzFv5QDP+EgNiWskzkGGmGQ4ZFoifLyvEIJkJC1oUCoyo5/il63gAvQkcsfQGB
         NUGTQy+gY02ZuKxpNcaY4MNZJhJMQ6nZbd/q5kUoDcLvQGP2+I48x/KQub4IM3gSzcIk
         ni++Zkio6/9A+hYXeThMSpFSVafSctxtSWUPn3oFIaZg1fYMFRcCDF3wcrxm2A4sIBoQ
         guBgMZWIr2xkucVnzgk2fHxf2oe/U/NaVhK9PnbjN2ziqyou4eXzk1orp5C1mtNCdOx0
         B2MrJEUeMvkEqQUinWpeWLpMlFXF6Tlw2T4t1F6gElFjqlUskXDSP9uUO3zK36Fosoga
         r2Cg==
X-Gm-Message-State: AOAM531O6pB3LZoGCdUJm0kzwvHCLNPXgkzKH7heWZXkAGUpTj0b4lZP
        3jeUB48oVHb85MzMD19DgzO44ldUD7OUGCoFpVeR3GeXA74=
X-Google-Smtp-Source: ABdhPJzwKey7jQXaAr9aWpzLqbNcLo3YysJvPR8Yfixvgk2O/ig3JxjNiTB4FTash8S1u8Cg1GSmvks6kgaI7YlQiPg=
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr1791852oth.184.1614335758954;
 Fri, 26 Feb 2021 02:35:58 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <20210225100855.25530-4-charvi077@gmail.com>
 <xmqq7dmvubus.fsf@gitster.g>
In-Reply-To: <xmqq7dmvubus.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 26 Feb 2021 16:05:48 +0530
Message-ID: <CAPSFM5d3M5joEBmAkY_-7hYGyz_e7HVpWmR6EN2U2Hw7V_LEqQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] commit: add a reword suboption to --fixup
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 26 Feb 2021 at 02:03, Junio C Hamano <gitster@pobox.com> wrote:
>
[...]
> > +     if (argc)
> > +             die(_("cannot combine reword option of --fixup with paths"));
>
> It would be easier if the user is told "foo" in the message when
>
>     $ git commit --fixup=reword:HEAD~ -- foo
>
> (from your tests) is attempted, no?
>

Okay, will print the passed argument in the message.

>
> I am not sure this comment is all that helpful to the translaters.
> If they are not allowed to translate <amend|reword> part, telling
> them what that part means does not help them very much.
>
>         Leave "[(amend|reword):]" as-is, and only translate <commit>.
>
> would be more direct without distracting them with useless piece of
> information, no?

Yes, I agree and will correct it.
