Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5BBC433E0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 16:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB36520674
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 16:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="d8MGVww1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgGXQNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgGXQNM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 12:13:12 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90D4C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 09:13:12 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so9088310qkc.6
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ZnUOUMVTpg/VOurdKXhqpWV4Zbg4y+bLjZonCz1kyo=;
        b=d8MGVww1frIWyGjAPDiHDGik6Fwl0xkG4XoeNaDjsYmU4FcKuW+CsnGkKRikQlk3Fz
         1EODexsl3BINfzsJEFsZ9X1nLyB3HON0axyQlrXYekDhxN3ZjpX9rUf7Blx+5rUNPOn5
         Jnt/46JbeT9q1x1Hnm+ESgGVi8sD53eVxdvUfAMVeSfOTQB5iwhTKmwNC59cgHC7L/f6
         vRlwFXcVUlbJrMn4lIttu+zRrqs/v4HN59MFlANP0992UcklV0zzqwBRCjBWPTZhSG9H
         d0KPE+DvkC1duTDq1MMQrFAWfKzcr8K2GpEW6KzxrkYNyqbR054lz1UcenRAaFnzfWLY
         YdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ZnUOUMVTpg/VOurdKXhqpWV4Zbg4y+bLjZonCz1kyo=;
        b=JAF4ITNx3gRW3xc3xsqJXub9r3Daiv4NZSOt3bSN2x8x+4Srx8d0GAIJugLxuFjAwU
         DM302gfI9j/pMoqcK4aTmuW13D+oxL0nJkfLSliW8YEw64nslTGqE3r9f/XSlCfBSYtR
         gYLPJSFLInTYdZOmtD8G2S7azpm7twUiyxiLjPLuEr/flhLgt7SNObUmPQpdWPohoNMz
         Y09InnZJK4+sYjOuozt/sGOwrktcIY4CEbICaeWLKW6alU9iFDuzHUSKayE79YLVrnVd
         eW7HpOKS8iiR4nM5+XcpPIr5LtVGCheWAdQlnQVAuKetAxR5/XReZ1d8Gyf++DrFB6eD
         dlcQ==
X-Gm-Message-State: AOAM532F1dzoH1QiHtoZeht26CiXRz6kQhwCN4dVoaD36tAvlNPnH9WA
        vt+wCR6t/GMFvzb2VCZxggN29xbochb0tg==
X-Google-Smtp-Source: ABdhPJx9zQYTdvBfDjcSPHyTfiLXieW3BK/0CTzrb7tFQTn2d8xyq1uUaYMOe3spNpdlDBLL7mJXig==
X-Received: by 2002:a05:620a:b86:: with SMTP id k6mr10177440qkh.242.1595607191794;
        Fri, 24 Jul 2020 09:13:11 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e588:f326:57e3:7769])
        by smtp.gmail.com with ESMTPSA id y7sm1901094qta.36.2020.07.24.09.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 09:13:11 -0700 (PDT)
Date:   Fri, 24 Jul 2020 12:13:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Glassman <matthewglassman78@gmail.com>, git@vger.kernel.org
Subject: Re: Trying to update GIT in Ubuntu 18.04
Message-ID: <20200724161309.GA13769@syl.lan>
References: <CAO-dU=fQZ6YVk1rWw_Tc8YT-i_zH7-hw3GATXmf7hwaqqC3j4Q@mail.gmail.com>
 <xmqqmu3pq5m5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmu3pq5m5.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 02:33:06PM -0700, Junio C Hamano wrote:
> Matthew Glassman <matthewglassman78@gmail.com> writes:
>
> > My git version is listed as 2.17.1.  If I try to just do sudo apt
> > install git..It will tell me I have the latest version and this is
> > after running apt update.  I can not get the PPA to work because there
> > is no GPG Key to input and thus Ubuntu will automatically keep it from
> > use due to insecurity.  Can you please advise me on how to best update
> > GIT to the current stable version please.
>
> Unless installing from the source is an option, you are at the mercy
> of your distro packagers.

...especially on a long-term support release, like Ubuntu 18.04. I was
skimming through the changelog for their version of 2.17.1 [1], and I
was glad to see that all of the recent security fixes that I could think
of had been backported down to those tracks.

It's good to be on a modern version (and Junio provided some great
advice about how to build Git from source above), but if the best that
your distro provides is 2.17.1 with their backports on top, that's
pretty good, too.

> But it shouldn't be hard if you are on a mainstream platforms (any
> recent Linux certainly qualifies) to build and install from the
> source.
>
>   https://github.com/git/git/blob/master/INSTALL
>
> Using "make --prefix=$HOME/gitstuff install install-doc" and adding
> "$HOME/gitstuff/bin" early in the $PATH would let you use the one
> that you built, without uninstalling what came from the distro
> (typically in /usr/bin).

Thanks,
Taylor

[1]: http://changelogs.ubuntu.com/changelogs/pool/main/g/git/git_2.17.1-1ubuntu0.7/changelog
