Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED8AC0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 11:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjHAL0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 07:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbjHAL0h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 07:26:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205AE10EA
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 04:26:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c353a395cso72768366b.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690889191; x=1691493991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJ+mVXg/G8jYBDYiXMm9SOk69xX0csSSzMyl+nG8mlY=;
        b=1ZbUJfR3Lt6XGgwmh8jaelZPohhp4c96HG8zZLYp3wjSZjefqc/mJCxfrUSoDP1UFo
         ZMDOL33HRkDtsbqk0ogyJ23jSSYgbM8sowa9QRLdRBfEoCAlk8SrC9BSYicur9l71NnZ
         ImDB0qSHy5Qah22uATvMfDqr2p1fpdhSQnwXLbhXst7TvMwIkMOEfJ2TYkZKVbdWT6Kp
         bVOpe960mrzkfqRLANhOZt5A26tSkVqfZykWYiSwo55hdgKhsfBJsXWxDxCFmzCxRWtT
         i5kQsS7jydxGWb9Qb8srSmmi1gKKccENfaUDtIOTQwFXd4ZDkhAu9P7lcVSQF39glXVI
         D/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889191; x=1691493991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJ+mVXg/G8jYBDYiXMm9SOk69xX0csSSzMyl+nG8mlY=;
        b=cURpZtTYMqdHnzan5fiYydsjeRvKG9bfS98IECViTjOmYH4KeyfgOvM9MLMPTmRNdY
         lVxX/7eapGTGzsMcBGAXFS9yfYncscPaGEMRyhKHDlRfgat8ZTfeXIuFrq5JLx8QV4CI
         Wev2xcQY+2gP6JUGfkxPdGPEjpE509vIyJT0VZhG0lIDhW4oRCwLIJcWj1dpbHZs1Oz+
         H33Aimu4vE5JGSQOAH/gZGxjv3Bxlc5Yt0D1+Ao4OmjGC3m6DjKriJAkQ74UysGndj5w
         3LuaHscSSQ9FuD8Q5hvWwtQWo0JY9jSImNG2PY5sDDF8Gnj4nv56z/H9nMLgqNeSvs7P
         PmcQ==
X-Gm-Message-State: ABy/qLYb9K1Yy30uIAEkQwD+yNnvtRbnm+34uYQpj8+MJOyJrDTCAIGR
        h2O5dZGpCCFU/N6HU3yBiP0HLFS3/gCKRTxqM5ikHw==
X-Google-Smtp-Source: APBJJlHDEcEAgywyho0BXrgzry6pRrQMpGcOQYFDTDQiyELvN5a8/7/+qPWyI4BmbidZTXFIf1+gKnehAVwbPm9xuwA=
X-Received: by 2002:a17:907:784a:b0:99b:c952:309a with SMTP id
 lb10-20020a170907784a00b0099bc952309amr2196726ejc.39.1690889191300; Tue, 01
 Aug 2023 04:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <858rfnb770.fsf@gmail.com> <ZBy18EBE7WM/E4KF@nand.local>
 <851qlfazzp.fsf@gmail.com> <CAPOJW5x+yQsPxdwCWMT9AkMQhJyxKp5BiPXp_1PT6WwF7yF4YQ@mail.gmail.com>
 <85tty8afvy.fsf@gmail.com> <CAFQ2z_P2HkT8grAFk=6Mr05rJRfsh_sXypVFPyHr0v5xkcjYTA@mail.gmail.com>
 <ZMgXBc5idN+sR3o1@nand.local>
In-Reply-To: <ZMgXBc5idN+sR3o1@nand.local>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 1 Aug 2023 13:26:19 +0200
Message-ID: <CAFQ2z_MzWauauzq_fKdcKTXahutLtADb7uHTh7ysinGNOx75nQ@mail.gmail.com>
Subject: Re: What is the status of GSoC 2022 work on making Git use roaring bitmaps?
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2023 at 10:18=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrot=
e:
> I haven't proved conclusively one way or the other where Roaring+Run is
> significantly faster than EWAH or vice-versa. There are some cases where
> the former is a clear winner, and other cases where it's the latter.
>
> In any event, my extremely WIP patches to make this mostly work are
> available here:
>
>   https://github.com/ttaylorr/git/compare/tb/roaring-bitmaps
>

thanks. For anyone reading along, the changes to JGit are here

https://git.eclipse.org/r/c/jgit/jgit/+/203448

I was looking into this because I was hoping that roaring might
decrease peak memory usage.

I don't have firm evidence that it's better or worse, but I did
observe that runtime and memory usage during GC (which is heavy on
bitmap operations due to delta/xor encoding) was unchanged. That makes
me pessimistic that there are significant gains to be had.

> One thing that I was able to do to produce slightly smaller Roaring+Run

Just for my edification: what is "Roaring + Run" ?

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
