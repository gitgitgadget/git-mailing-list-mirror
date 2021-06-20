Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7605C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 05:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDF76113E
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 05:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhFTFyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 01:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhFTFyt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 01:54:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B930FC061574
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 22:52:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t7so14301282edd.5
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 22:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CwOJIOA9v810oMblebC2f1YN14YU5e7LPXP3RKhJ3EQ=;
        b=QOYHoV35F50k8pV7ye/thaRVgBvKqcHzrA/AjsxIrD6a4w1xA5veebC3bJgsM15Yjt
         564ygxLjpujlN4iOgTcrTQF5tW0zs5BcaNSAHwNWVi56lYfFbQWiGZTEOPvPULBEsLBd
         YHk2bB9enDRxsXea/sdQ6wUko5hJANI8ZlGS1B7cFnvOSx30EtdI7UrpvTc0fXfcHqFi
         yFa4mkkfUmsVxUg/vG+Hxj2jWvZmAL36s0XyaOXIKyEpsYU5dZnlAy5YpNp9JkDWlSA2
         wY7v8ljdkuGLtrALb5d5YZOzP9FeYQ0B/HDdrPEUSf+EjV5huJXMmLLRQ7JK6RwJRHNb
         JCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CwOJIOA9v810oMblebC2f1YN14YU5e7LPXP3RKhJ3EQ=;
        b=DAj6DvhaRrUPr/v+hm40wVPGVgZ7zvGJGlL/JQJXnm9RSS1ibtqeVQlhpgATPdeSY1
         xPTmcbJBsIolUjkDIQb4SCb2bQLUpTL+JGw2dOUImFu2BewBAgyUVkA9MTquFvCaTs8A
         s2eTdn7TXJ2D3TQCz/YQDaLxQ9LhciqGUNuO62CbAYGxSP/iaWgzmEaoPEypmG8ZigB/
         Gx4f3XtmmJbGnPJGyGiG6dDsY91FU0uDvYevyQq7waAxMqqewjIqf4+fRh91oRatKru4
         /hJW2PC+T8yNM3ezbvRI+xBn2wBgeXRLf5ogHwwKFlhqzyinS5wu8v56CVhF39pi1QKh
         6f5w==
X-Gm-Message-State: AOAM5302WPN593mK+0z2TEhcJfgdP8PArR/HTyBYmQiFWihmu9oSOZe7
        ZwdPBsy0pn6JFPwy9hgmfyZE0Jm8/CgFrpZktD0=
X-Google-Smtp-Source: ABdhPJwi2DiPogNU6dUoyXm29n/eDrg3zCiUQ3Qk8/wG1IfoTEJIBCAyNgRzgMJnbFxQSkJCwHRKRSUbAFk61iR7pE4=
X-Received: by 2002:a05:6402:1d3a:: with SMTP id dh26mr2430745edb.127.1624168349488;
 Sat, 19 Jun 2021 22:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <D32894F5-FC76-4DD2-A2F6-E69AAE88C645@gmail.com>
In-Reply-To: <D32894F5-FC76-4DD2-A2F6-E69AAE88C645@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 20 Jun 2021 07:52:18 +0200
Message-ID: <CAP8UFD2sXjRgn6FqOcBor=Q_PXmy+xL4mHmV7Qy_fSrc0q+O9w@mail.gmail.com>
Subject: Re: [GSoC] My Git Dev Blog - Week 5
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 19, 2021 at 3:32 PM Atharva Raykar <raykar.ath@gmail.com> wrote=
:
>
> Here's the latest instalment of my weekly Git blog:
> http://atharvaraykar.me/gitnotes/week5

Great!

Just a note about:

> if (ps_matched[0]) {
>      if (!force)
>          die(_("'%s' already exists in the index"), path);
>      else if (!S_ISGITLINK(active_cache[i]->ce_mode))

The "else" above is not needed.

>          die(_("'%s' already exists in the index "
>              "and is not a submodule"), path);
>      break;
> }



> A peek at what's inside:
>
>  * The blog starts with a summary of all the relevant things
>    that have happened so far in my time with Git, including
>    the status of my submodule-related work.
>
>  * A question I had about reading the index into memory
>    (any kind of help would be appreciated!):
>    http://atharvaraykar.me/gitnotes/week5#some-challenges-with-the-change=
s-that-are-cooking
>
>  * Reflections, mostly as a note to myself and to people who
>    might be in a similar position as me in the future.
>
> Have a great weekend :)
>
> ---
> Atharva Raykar
> =E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=
=E0=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
> =E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=
=E0=A4=95=E0=A4=B0
>
