Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13E4C433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 10:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DA364DD0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 10:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhB1KBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 05:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhB1KBS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 05:01:18 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5C6C06174A
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 02:00:38 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id k2so12074406ili.4
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 02:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=257MbFYNNPRWkAdzvOZjpW1xXM217yc6GgHYFh8Vi3E=;
        b=fHGPxegoJEwFQc/idFkjb/qrVkgsBzgmew5feqpQ9T7m0scPZWzj/7qZ2G1mw4LZ9D
         DyBOsUBs47atQ/p42xtZY1u+djuK4qa4K/aJ5F3l/AMD+kbgDPwRSSh4MC5De743KEiV
         YXxfbnZ9VCNB7fwWR2EX2RFGxmPAb0ebn+52VrjyapIJGmfWSEqGOPFkwYTjqRwjFPVL
         t4tPkYu18QIKoJZTzOA3UaddxqvBB0/P9OFFx5JpI89kCZ112NfYGD2HsLqIKTLzDVNg
         zD4VleqneYdv1IER/z1hTW2UF+iq29mw3A45xdQTzs3mlVzvNSGO9DNxjHzB8juUe/Bp
         smYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=257MbFYNNPRWkAdzvOZjpW1xXM217yc6GgHYFh8Vi3E=;
        b=kyQLYDErNeAqRLkcaDzeB2VYcENusMn++Y5/NuStgbw4Tl0REUt33t6vWTCN8vWS57
         I9WfRNH9rVRqKSriTk5JgFVidEMVPaxGkNFQVfyPHYJMicYNzqLMhFUXxRPkZjFCWZx7
         km4w22CnEnUbB0xpGlnvlfiaLu+RI2tvhpS7qyDPACB/5gddYYZPveWUOfTfVbitIhAt
         iHA/M+rSkAK7M2hfg7JxqzssjngxYPAvsPQF/P0xah7AGKXcw9B/iteKY+IyeIzutTqD
         K2aS4z44wHogURjdFQ9QkurN3ub+8UgSV8mtGgEjmcUTw0bGBMGNwvouixTFtf2CSyE4
         hNNQ==
X-Gm-Message-State: AOAM532lPED8JiSUti1+SOQ9o6/uZ1Hn5UGi6MUPlS6PshwaJ430WnvL
        S7fUhzbqb5hMdZH+EvAtTAGcHGaRbukn4OBOaaQ=
X-Google-Smtp-Source: ABdhPJzXLxXLyC5AMN9h/Fo9c8fxcIJeRDTUoDQrSsjUjEPZN3yG06eKjLGTW+NdjljTSNC8MKw62k9FDZ8RnfurYms=
X-Received: by 2002:a92:c269:: with SMTP id h9mr8829086ild.239.1614506437418;
 Sun, 28 Feb 2021 02:00:37 -0800 (PST)
MIME-Version: 1.0
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
In-Reply-To: <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Sun, 28 Feb 2021 13:00:20 +0300
Message-ID: <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 27, 2021 at 8:49 PM Elijah Newren <newren@gmail.com> wrote:
>
> Your second commit is signed.  Fast-export strips any extended headers
> on commits, such as GPG signatures, because there's no way to keep
> them in general.

Why is it not possible to encode them with base64 and insert into the
stream?

> There are also other things that will prevent a simple fast-export |
> fast-import pipeline from preserving your history as-is besides signed
> commits (most of these are noted in the "Inherited Limitations"
> section over at
> https://htmlpreview.github.io/?https://github.com/newren/git-filter-repo/blob/docs/html/git-filter-repo.html):

Is there any way to check what commits will be altered as a result of
`fast-export` and why? Right now I don't see that it is reported.

> Hope that at least explains things for you, even if it doesn't give
> you a workaround or a solution.

Thanks. That is very helpful to know.

The reason I am asking is because I tried to merge two repos with
`reposurgeon` which operates on `fast-export` data. It is basically
merging GitHub wiki into main repo,

After successfully merging them I still can not send a PR, because
it produces a huge amount of changes, because of the stripped info.
It can be seen here:

https://github.com/simons-public/protonfixes/compare/master...techtonik:master

I tracked this behaviour in `reposurgeon` in this issue
https://gitlab.com/esr/reposurgeon/-/issues/344
-- 
anatoly t.
