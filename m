Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C9AC64E8A
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 20:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398BA2073C
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 20:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="AYXZ0KPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbgK3UXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 15:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgK3UXf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 15:23:35 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B38C0613D2
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 12:22:49 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id j13so293507pjz.3
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 12:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HBx/B4lO/9WWRua5JhM2WC4LTTkt+OIPkiW8gAh/ASY=;
        b=AYXZ0KPMfI+qJXJUHXYXuj6rhNfvBXR3K0PsJEBrZjl/kerLjpunvKBzUyNGkH74io
         jyfX1AU6KWwRT0PuE6srzA9ghrIEk4fA1E3NBqj+o7iKm9C6J3I3ti0J8v8GJuZsMyld
         TsW0tiXtGkkLsfvarnlYIAh+KzlioHJySI62/gYxqBZmowfPAVsW4Mb4NG9A+W6p7nve
         EBYXKnvncwthKhngH8Iki5CoEVJr15Z/FHjhXI5HJkXTkJ+LR2T1xLBRMvYHsExO2Wfe
         iy9/Dj8iBoXUb15ME2tGCowyOq5Jd2yIchIA+su98i4FdhvR3+aPkU3D9vETMYPerSLF
         NKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HBx/B4lO/9WWRua5JhM2WC4LTTkt+OIPkiW8gAh/ASY=;
        b=KojKg2lzJM8zhBzPs5ZtBHuVeZLG6Xc476Bg9trvPEWwUPH4rppyKnkhMd9HiPsU+C
         9Il/6pcNd/vEB9Sc0h/QCnGYQu30TI9XrPIOLq7SSP6YDZdd3IqDz5+u4gdp1d+2mJXX
         0SsCXxuj5E5CoA8oqusXymq2baOzSWxJEeCH2xQbXJSfEFwkK2Tk2fPfwqk75n/o91v0
         /3nsrT2bj1FobGI9lnHyA1z4e87ONZtPRDfb15EoW8JYdsmV1hMl6/v3yQuHkrt6kPRz
         D8HcDEWQsm/IwwbUUK6gSTUf+7aGjSwdBSY8W6KZxGwsPeBuxSKJ4TtRRRcDtiDJ0Q0m
         hsUQ==
X-Gm-Message-State: AOAM5334pOL7Ft7cQYJm9FNcnMxaSFDcG2k77/NUbJgP4pPhfgUZ2ioq
        jad7QJ4n/hvBhdXAcuAe2pAIVg==
X-Google-Smtp-Source: ABdhPJz7dIxmS5DXstybgej8Afa3nsF5nMFsSE2+nuVyA5uEqCYfb94E4STM7e+2tN1W07G7WQV9/A==
X-Received: by 2002:a17:90a:c484:: with SMTP id j4mr627044pjt.69.1606767768953;
        Mon, 30 Nov 2020 12:22:48 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a22sm17365180pfn.29.2020.11.30.12.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 12:22:48 -0800 (PST)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Mon, 30 Nov 2020 15:22:46 -0500
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] fetch-pack: disregard invalid pack lockfiles
Message-ID: <X8VUf/nbRiMvQFpu@nand.local>
References: <c54233ce-ff72-ca29-68c2-1416169b8e42@web.de>
 <X8VNszeQKJPfZ+Ht@nand.local>
 <67cf2f10-43a4-1200-0c60-dada466eadb9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67cf2f10-43a4-1200-0c60-dada466eadb9@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 30, 2020 at 09:15:47PM +0100, René Scharfe wrote:
> Am 30.11.20 um 20:53 schrieb Taylor Blau:
> > On Mon, Nov 30, 2020 at 08:27:15PM +0100, René Scharfe wrote:
> >> index_pack_lockfile() can return NULL if it doesn't like the contents it
> >> reads from the file descriptor passed to it.  unlink(2) is declared to
> >> not accept NULL pointers (at least with glibc).  Undefined Behavior
> >> Sanitizer together with Address Sanitizer detects a case where a NULL
> >> lockfile name is passed to unlink(2) by transport_unlock_pack() in t1060
> >> (make SANITIZE=address,undefined; cd t; ./t1060-object-corruption.sh).
> >
> > Which test in t1060? I tried to reproduce this myself, but couldn't seem
> > to coax out a failure. (Initially I thought that my ccache wasn't
> > letting me recompile with the SANITIZE options, but running 'ccache
> > clear' and then trying again left the test still passing).
>
> 15 - fetch into corrupted repo with index-pack
>
>    $ cat trash\ directory.t1060-object-corruption/bit-error-cp/stderr
>    error: inflate: data stream error (invalid distance too far back)
>    error: unable to unpack d95f3ad14dee633a758d2e331151e950dd13e4ed header
>    fatal: cannot read existing object info d95f3ad14dee633a758d2e331151e950dd13e4ed
>    fatal: index-pack failed
>    wrapper.c:568:52: runtime error: null pointer passed as argument 1, which is declared to never be null
>    /usr/include/unistd.h:825:48: note: nonnull attribute specified here
>    SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior wrapper.c:568:52 in
>    Aborted
>
> Compiled with:
>    Debian clang version 11.0.0-5+b1
>    Target: x86_64-pc-linux-gnu
>    Thread model: posix
>    InstalledDir: /usr/bin

I see. I was compiling with: gcc 10.2.0, so setting CC=clang does
reproduce the error for me.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
