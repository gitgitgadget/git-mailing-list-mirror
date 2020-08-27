Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1D6C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 00:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDC32074A
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 00:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGbGb1ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgH0Ao3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgH0Ao2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 20:44:28 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54E0C061756
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 17:44:28 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d18so4082373iop.13
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 17:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Rm6QIUXDlcC2DnWf01sRoN2ZHdF7CaLVZnDl2p65Jc=;
        b=XGbGb1ze3O7Xr+9C0f6YrVBUH8p80xwQ8yt2T7hZeCw25xJZrWtXljBkSJtMzT07qM
         YofEVxc9fkLjHEyJ9BpQXqP834FekZT79v5kqIs5Qi/qBNuMuNzsDkBiAig+qv9Fon2G
         tYifXovj6Wk4cNV9SnsigsENktbcc8FSG03mz2lVEcSV8cfQYZjKxpF9LFS6dJe6Aicc
         MunMZboQxcy/DDLw/OU7WB/D9P7a5D5a5TReQ0CGL5DB9YznkfnAyP5zKJdQ4Zw65f4X
         w7BeE4FIm6cXTDupP6wkAkqtpG8+6cHimN46mVy0IcodItmCNNWTih4DvVdj2chZaUq5
         C86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Rm6QIUXDlcC2DnWf01sRoN2ZHdF7CaLVZnDl2p65Jc=;
        b=l/4YBNHr4NzeCWE7qPsJklI37bZFz2tSdyjhtCABuGMLCqvGr9DjijSfbOZfhGU8Bz
         5KePWs4/nWdDshjDMcr3/PFNl0L87A6trDMocJh7hSSy2MpEX885erMzCRohqbNxUhBw
         BiIeh8e20H1SomaFRLiZsA0lx5esXBCx7PWpXCWJmBDzaaaFTp2yQRSM84yVozrlsx/L
         jCW9BnV3LYbJi/vKApOWWL0CPksGPEMckMKQvrerC5vy3aMeZFJi2EOF2pW8hGOetHtO
         bIbNzH0HjTjv5ygJV5YmsG4KUDm70kQuJqCOl0dC/7YAkP8c5OkrMu0glNsrGSHGEpPr
         4ilA==
X-Gm-Message-State: AOAM533NeDIEx799ZAMcDK7U0dDRgEpVO+7itsYPcU8sO49Oqo/NshEl
        OM3Gd1nhHzXLJ3UQDR47tAJ5xrDc9928t7PAx1hUWkWhpDA=
X-Google-Smtp-Source: ABdhPJxSs0IwdNlf4bgbLzJIP5kfHet9fpJFms/XSDkSk1S+dH8V6LEeWTcuj7p4HAf09slOOS+4xPXhaOcUaLwvtPM=
X-Received: by 2002:a02:c919:: with SMTP id t25mr17800423jao.38.1598489067515;
 Wed, 26 Aug 2020 17:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
 <xmqq7dtlt080.fsf@gitster.c.googlers.com> <xmqq3649szs8.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq3649szs8.fsf@gitster.c.googlers.com>
From:   Tom Rutherford <tmrutherford@gmail.com>
Date:   Wed, 26 Aug 2020 17:44:16 -0700
Message-ID: <CAHr-Uu8umDQJ=LORaBNJX+wnmaeM1hHxxpG7xROPgCqgEPrwdw@mail.gmail.com>
Subject: Re: post-checkout hook aborts rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the response Junio.

For what it's worth, my hook does not make changes to the repo. It's
running a command to check that the installed version of our
dependencies match the version specified in the commit being checked
out, and merely warns if the two don't match (then exits with a
nonzero return code).

For this reason it's been convenient that the hook runs during
rebases, but I find it surprising that the nonzero return code would
impact the rebase.


Tom

On Wed, Aug 26, 2020 at 5:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > ...  If "git rebase" or whatever
> > command wanted to place files and the index into some state by using
> > "git checkout" command, and if the post-checkout hook mucked with
> > the state in such a way that contradicts with what the "git rebase"
> > command wanted them to be in, it is not surprising the hook's behavior
> > broke "git rebase"'s operation.
>
> Having said all that, I actually think that "rebase" shouldn't be
> invoking "git checkout" (and its equivalent) internally when
> switching to a specific version, in such a way that it would trigger
> any end-user specified hooks and allow them to muck with the working
> tree and the index state.
>
> I haven't checked the actual implementation of "git rebase" for
> quite some time to be sure, but we have lower-level plumbing
> commands that are not affected by the end-user hooks for exactly
> that kind of "build higher-level commands by synthesis of
> lower-level machinery", and it is very possible that what we are
> looking at is actually a bug that needs to be fixed.  I dunno.
>
> Thanks.
