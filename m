Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036C1C43460
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 14:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3D561103
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 14:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhDHOoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 10:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDHOoV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 10:44:21 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3338EC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 07:44:10 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z136so2476147iof.10
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nGbxxUOJ4hDmSNCLOUDyzjRiiV//iUoh0A3h00ppftc=;
        b=GvXsJqE92Z1lSoRSTLdCppU8hS2Sxqg/IivB4R1PA3mTiuizIeMpGupweyGhLdUkYf
         WNtHIRzMBu8D6bxEJJe1SVjhA0xs6OLnZsRIBv4OElsyeu+JZ/U2V6F8eOQvFVlV5gI2
         UNYKWwx/iQ2z0d/SsZVgV/ms+8XKhH+jHJcKqxXVFRS4NhUbonIDZnwgLc1BI1dG6gNH
         FjIvnfWsssBddntnjm5Nf8HD6NCrczSbC4JKiaiDk8N1l8YoGP4kARDXKwb0IL/drEcL
         XlYsYlmoJBkb//zB62WB9Us6gf47l1UqzyudWPXGdw4zEt4/30l3at6QFcl/SCsMReyT
         PrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nGbxxUOJ4hDmSNCLOUDyzjRiiV//iUoh0A3h00ppftc=;
        b=rqxP5v3Tni11JrXFXE6g3fZcNb6ToULiuVmJ0MY49CllmJgR/Hk1gpc0CbdlBC8+S7
         1R2x8KsPFYELjlxneiWZ4Y0OJM94ugy3yEmPedqC9POk/IQJnTbSxdN3/yltVhor466p
         WkGCjFKRaNkePlbP0nzycRBN+ZRLJNtvjq3Mr87zzM5+nvwh8haPH79oH1ZzVRDdx4Lp
         PdSzUtEXNpfu7DiJ4PbWi64ZEj6cEcZgmV0wErsAh9GFpf4E2PUGJ2JKjL4qzMTTHKm2
         09Wg2xZk5moQ8qSKW+ZsYF+TbylADFHnAUUc1BSefzRKw1QLmpxMKjl2+YmNoP/wWY/S
         nQeg==
X-Gm-Message-State: AOAM530wLFB1A8qjuFt3hDaE5EV6suDKofutCfvVY5EfY9p5pPkEQygt
        eJgB/jdmCXW6rCYwTpcEXB+phTlDf2kezdrKUtvCdnKBksPkU35q
X-Google-Smtp-Source: ABdhPJy5JOUSpJhi1corOFf4jCWQGxQuirt4r4u7WzI1S5hDWs7Ljh9iv5xbATCsISASsU1Y1O35Ibx+H0nb+aH82Oc=
X-Received: by 2002:a5e:c809:: with SMTP id y9mr7258496iol.192.1617893049646;
 Thu, 08 Apr 2021 07:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
 <pull.927.v2.git.1617809209164.gitgitgadget@gmail.com> <YG4jxKQ3z1R+8Jfz@coredump.intra.peff.net>
 <CAOLTT8QvdLeWz=cDOoVFV8Lrk2QL2wf_jwDc6oK5j+6gup+Png@mail.gmail.com> <YG8UD7c4lChOQM5a@coredump.intra.peff.net>
In-Reply-To: <YG8UD7c4lChOQM5a@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 8 Apr 2021 22:43:54 +0800
Message-ID: <CAOLTT8STy3Y_pLf0PDs-Uj1dXJYSjPD3FbKrUiSM4Uz-F7etSA@mail.gmail.com>
Subject: Re: [PATCH v2] [GSOC] ref-filter: use single strbuf for all output
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B44=E6=9C=888=E6=97=A5=E5=91=
=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Apr 08, 2021 at 08:18:59PM +0800, ZheNing Hu wrote:
>
> > > I think this is a reasonable direction to take the solution: wrapping
> > > the loop so that the reuse of the buffers can be included there.
> > >
> > > But I do wonder if we should go the opposite direction, and get rid o=
f
> > > show_ref_array_item() entirely. It only has two callers, both of whic=
h
> > > could just write the loop themselves. That is more code, but perhaps =
it
> > > would make it more clear what is going on in those callers, and to gi=
ve
> > > them more flexibility.
> > >
> >
> > Indeed. I think `pretty_print_ref()` is proof that we may need to keep
> > `show_ref_array_item()` because If it modified to `show_ref_array_items=
(...,1);`
> > it will look very strange.
>
> What I meant was that we should get rid of show_ref_array_items(), as
> well, and just use format_ref_array_item() everywhere. This whole
> wrapper is only saving us a few lines, and it makes it harder to see
> what the function is doing. Likewise for pretty-print ref. But I dunno.
> Maybe that is all going too far.
>

Ok... so you mean we just use a loop like in branch.c, and get rid of
show_ref_array_items() and show_ref_array_item().
(We can still use the optimization of reuse bufs)

> -Peff

--
ZheNing Hu
