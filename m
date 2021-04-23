Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBC3C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 15:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D649613D5
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 15:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhDWP0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 11:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhDWP0m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 11:26:42 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A56C06174A
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 08:26:04 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id r1so3352806uat.4
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rc5KVK/4x6TTInau8GZ+9Jl8Ptmq1Ly44XP2xUJEu9o=;
        b=ayiWAcF0B7P7iVgnygliG1ySA48Alhed8v1t9HADjij6bOtz8GXS0me4IVjaCKEgsi
         KLJlExNkm4I7c//eEsynYCCFJFZFLwXhQQYI+HEleUnV/BWfsHBUi8W5/pvMxQQMrMQH
         Ie9Sb/GNeigyvLYjOUdkVUx2y5Q01GuR/nklJb4aeFJXGtHswfWpx3x8thIQh+uQJh6O
         tm3vxOsOAEipuhH00VmE2RGL48ptI2w03JiRIf4jmBh9vZ2ji4KYiJw84j85XLh+TVm4
         DSGGazofleSXk6vTDRvXtuTfMNe4UGfgfyLjMYdm+We3Xd7oB0B40zeoBEpHtbfzHeMF
         66eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rc5KVK/4x6TTInau8GZ+9Jl8Ptmq1Ly44XP2xUJEu9o=;
        b=uGofYPb1bo8xUTZYeplsVh7Mlve3iqGQ0UKsAV5tor4TDU6HjCNPG7Aa0dlt+LWono
         WoC0ftqxizPqgw3si1N/gJv9sTTceJuTi0x3LUfVCSPhRt8vd+TesK6Wh2haY1myzlMx
         0nXHEN5daBtXbHwDON3/DbHAlLixkRFwKEi/XPaOyEqGwLfomTjvtWjpgX2aRQH6q83V
         IyTcznJFKTumbl7Eb8Cwp3J5KzQFCPcJx6VeTaokIdHb1gAPpes2kOgxRgIJGOXEXBnV
         p5qLoDni1n1VTLi5Fqw9Xp91nxN7HbzVsf/l8ZCEwZZDnkIEFmYsr4ZFujJej8nyEoSK
         TCZA==
X-Gm-Message-State: AOAM531+Nn9+ViEOVdI6tEDLAI84yjy6P17yxyY91MgvzZihJyiT87/n
        uGT0kEDGpBYGG0zmQqAfgVaTRJksWrmI4SrY2Kw5IA==
X-Google-Smtp-Source: ABdhPJxb7oJugVuMEWhcxvIc+cGHw7pgjUWOJFno35qH3ECBVULYtDvfB0S/tVBVHDu1sPW9eOvcchBWaD/z/YZgikQ=
X-Received: by 2002:ab0:6030:: with SMTP id n16mr3846423ual.87.1619191563697;
 Fri, 23 Apr 2021 08:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1011.git.git.1619173446857.gitgitgadget@gmail.com> <YILENm8vZE28HyuZ@coredump.intra.peff.net>
In-Reply-To: <YILENm8vZE28HyuZ@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Fri, 23 Apr 2021 17:25:52 +0200
Message-ID: <CAFQ2z_NxSLN-wNnk5gByit+_uhC9j-1QEt1=MZEk-kH5ztU6Jg@mail.gmail.com>
Subject: Re: [PATCH] refs: remove EINVAL specification from the errno sideband
 in read_raw_ref_fn
To:     Jeff King <peff@peff.net>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 2:57 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Apr 23, 2021 at 10:24:06AM +0000, Han-Wen Nienhuys via GitGitGadg=
et wrote:
>
> > Subject: refs: remove EINVAL specification from the errno sideband in r=
ead_raw_ref_fn
>
> The subject says "read_raw_ref_fn", but the patch is touching
> refs_resolve_ref_unsafe(). The former is an abstract type, and I didn't
> dig to see the relationships, but I'll focus on the code change in the
> patch.

Well spotted. I reverted this part (I did glance over existing
callers, and couldn't find anyone inspecting errno)

> > A grep for EINVAL */*c reveals that no code inspects EINVAL after readi=
ng
> > references.
>
> I don't think that's sufficient, for two reasons:
>
>   - in general we try to be careful about forks and topics in flight,
>     which might end up with semantic conflicts. So we don't necessarily
>     assume that we can see all code, and prefer if any subtle changes
>     like this at least result in a compile failure (e.g., changing
>     function name or signature). In practice, this is balanced with how
>     likely such code is, how bad the breakage would be, what we're
>     gaining, etc.

would you say this is warranted here? refs.h doesn't mention the word
errno, so this behavior isn't documented at all. I also looked over
the current callers of read_raw_ref, and outside of refs/*.c none seem
to inspect errno.

>   - just because they are not looking for EINVAL specifically doesn't
>     mean they are not looking at errno at all (e.g., after calling
>     refs_resolve_ref_unsafe(), lock_ref_oid_basic() does so). So we have
>     to set errno to _something_ after the error. After your patch, we
>     don't set it at all for these error returns, and so we'll be left
>     with whatever junk was in errno from a previous unrelated syscall,
>     which could be very misleading. Since we have to set it to
>     something, EINVAL seems like a reasonable value.

The function has several exit paths that don't set errno at all, so
the result is kind of random anyway, but I can't see the code I don't
have. I've updated the series, with some real progress to stamping out
errno. Hope this pleases you better.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
