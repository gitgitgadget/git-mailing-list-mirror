Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0225C433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 21:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A430822203
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 21:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbhAAVRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 16:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbhAAVRd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 16:17:33 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6ADC061573
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 13:16:52 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id k9so4989881oop.6
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 13:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdSJTOgr382z3UF7vYlEzXyfVjanvTCrvNKgCe63l8Y=;
        b=uN91XXZNdpXBC7S86dHhDOSwrF85eZOKivQvx69uCxvU0zJgBNCYXeKJK5HBmpopB3
         Zb0CU2dfuHl6UHiNUsS6N0uS4kj9J3qZcDTBcp2FX5U6KTEg3ki7iKwJUDLuyYpUpiz7
         Az9ppOUm0in1UsLg160WmSp+Dy31x9FhbS6AFMUyHpmOgdRzqQc1EiKapGCq/EOyQahq
         3HnqUHod/bPX2bmwZwVNXXhuOu5Zn5SUe65rVM4ahYvq7TZYuIoBtKR1uqrxPcRoMd4q
         Z9S/ZTZR/U74WWTbsODiqXAZghZkv6cL6usDrR8wMOY52Midl7YxxNyKB3lxynJfLdhi
         sFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdSJTOgr382z3UF7vYlEzXyfVjanvTCrvNKgCe63l8Y=;
        b=tQJMD/eZrc/beuXJL/dq9wB3MIUfMUPOqN0cek2tKZqqugEHJqrgCuPk+ctn84OcRu
         2mlUjz7jDxtzVuJKZnFTJYyt+sUlOUMC2QRZsQd3geiDcn/OZD2PW5jW2bpm6vu5mBmW
         dVgCnCcG+lhEQN+h6HFULBXdMOUutvo+aXwKSX0F4+Zs9LdK0mzQbrvr/pIORdtz2UPX
         6RZEupGPl3b6Izs8H8aU9qeo21K8CNSHWsRblVWlZJygMAugXUD/4NkQPbPW+gby8sKv
         hNe6mA+HBhsJ0YOix69hIcI78D2XfBRn1eSIxsEaUt8BqI1BW628SHXYVAiG0QLZvMCX
         dKUg==
X-Gm-Message-State: AOAM530lsZMcaVkmdoER08SkESNWeOAsZ0imDgcg/Bk/cV68xplTEwX4
        Uv3TRFuwgrHkwRexHh5WuzLPpRMovZjCVwwu+0I=
X-Google-Smtp-Source: ABdhPJzcoIEtShTqRfNdct3/Nu5YoV3UhKIGSFFX9iNlWSHMcC7/dQn8ZFllqJnunhcPrny5ExnT5P3XAJ7cxwono/c=
X-Received: by 2002:a4a:3e42:: with SMTP id t63mr42395782oot.32.1609535812109;
 Fri, 01 Jan 2021 13:16:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 1 Jan 2021 13:16:41 -0800
Message-ID: <CABPp-BHKeKegCRNVJLvgPMk8F60NgpVxjU0jiPYtzGpK-2xRBw@mail.gmail.com>
Subject: Re: [PATCH 00/12] Remove more index compatibility macros
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 1, 2021 at 5:10 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> I noticed that Duy's project around USE_THE_INDEX_COMPATIBILITY_MACROS has
> been on pause for a while. Here is my attempt to continue that project a
> little.
>
> I started going through the builtins that still use cache_name_pos() and the
> first few were easy: merge-inex, mv, rm.
>
> Then I hit update-index and it was a bit bigger. It's included here as well.
>
> My strategy for update-index was to create static globals "repo" and
> "istate" that point to the_repository and the_index, respectively. Then, I
> was able to remove macros one-by-one without changing method prototypes
> within the file.
>
> I had started trying to keep everything local to the method signatures, but
> I hit a snag when reaching the command-line parsing callbacks, which I could
> not modify their call signature. At that point, I had something that was
> already much more complicated than what I present now. Outside of the first
> update-index commit, everything was a mechanical find/replace.
>
> In total, this allows us to remove four of the compatibility macros because
> they are no longer used.

This series is divided nicely in a way that makes review easy.  I've
made some of these same types of changes elsewhere, and the whole
series is really just a long sequence of mechanical changes (plus a
case or two of fixing formatting on a line you were changing anyway,
such as adding spaces around an operator).  I think the work to
continue dropping the implicit dependency on the_index is helpful.

I only found two minor suggestions for improving the commit messages;
the patches all look good to me.
