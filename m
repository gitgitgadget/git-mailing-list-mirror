Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0843C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 06:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C6064EDD
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 06:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhBYG7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 01:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhBYG73 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 01:59:29 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06691C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 22:58:48 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id f1so7002930lfu.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 22:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCTcZl6YnvfGjOVdAk1W+kIZrpbwMirIRiccP0QLYL0=;
        b=gP56PhuhqqSUI2XODCIJLneoLrn8bzjQQX65Qy1rrpw6yBACTeQ7EyMMzLqVWTWdU4
         NdDXwMllx2VtYD/PrHiUS1mWLl2nK7Qrus+YdbjI/IyXZqgE1IHW70m6mVR11dbHG13z
         WfHowe6q/z5OWauEQahIXzzzaGCojBXi0W8qMwsUoRTuEOYyN4BJ4mHrqbB9h3bO/wff
         TTMn0N5xtM6BQhYH9bJWC4Ly7rI3G+TBgvz713kJppwXM5ZIzdrsOCGJMJy/F1rA/SA6
         wNLaO0OZQsbk2i5DCzddx0AyBByqK3AO1DTQNqoRn490ApMTsAUpNr+oPVTKYfdYjkfN
         Bk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCTcZl6YnvfGjOVdAk1W+kIZrpbwMirIRiccP0QLYL0=;
        b=MpjFuuaAzIRU2WsKAQw0O9hZ7dgZou4hfXd+xrH0elSdI7V/s/BcxuTOu8xS8uTnfG
         5jNqWuh57Zy4wa+2R/8/FqZ8JjeLShHuN50L4+mh7QokwbfwLMAM8i1BGw2NnPjngsFw
         jSEwzz220p+vetsmDfHb2s3kdoH5qLyjGh8WAAIt+Rw9P8CEoGVN2epyOslD20h/mtb2
         hNUbWtWVZv8GQBPyV68AKBq2G/o9+G5BwG8nKZXiyQfvZw+Pt505kijWd3oLK1ExyTP1
         vXu3MsaeLXY7znltscMj4dNBkk8fwyPjnDySgnhhUtEmmNTLhhHdO0pKuN0xC1eMXw8e
         AcMw==
X-Gm-Message-State: AOAM533WfxEhiTJGU2c9bWTFrw4DTueFXTGSJQGDQyw/TSQLcvy66/dd
        BbMBnekYBjy8OhntFtGVuespUkfc0+YwjM5j+rk=
X-Google-Smtp-Source: ABdhPJwkdzgQitanf732viB70ElbbC3e2H3ysJvELkVdoS2fQ1JNFh9irfyuLXdTe5HwMGh3QjoAk0oYLd9ugpDgknE=
X-Received: by 2002:a19:c306:: with SMTP id t6mr1137090lff.113.1614236327208;
 Wed, 24 Feb 2021 22:58:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.877.git.1613616506949.gitgitgadget@gmail.com>
 <f52df30b-4ab0-fd6f-17f8-70daed81df39@jeffhostetler.com> <xmqqv9ana05b.fsf@gitster.g>
 <CANQDOdeEd=JjWL4gb5CWHL_HkvJMnFumW74ew4DXJahh4BKvfQ@mail.gmail.com>
 <xmqqo8gd8tyr.fsf@gitster.g> <CANQDOdfJApBOEm2gPMwtz9T0ETPoDk107mF7LYRGCmjFLi3Jxg@mail.gmail.com>
 <xmqqmtvswvp7.fsf@gitster.g>
In-Reply-To: <xmqqmtvswvp7.fsf@gitster.g>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 24 Feb 2021 22:58:36 -0800
Message-ID: <CAPx1GvdA1prtO+y-bJ7yu8oZP6Lp9mHQ5gv-fXvS193NFospkA@mail.gmail.com>
Subject: Re: [PATCH] read-cache: make the index write buffer size 128K
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git List <git@vger.kernel.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Neeraj Singh <nksingh85@gmail.com> writes:
> > I collected data from an experiment with different buffer sizes on Windows on my
> > 3.6Ghz Xeon W-2133 machine:
> > https://docs.google.com/spreadsheets/d/1Bu6pjp53NPDK6AKQI_cry-hgxEqlicv27dptoXZYnwc/edit?usp=sharing
> >
> > The timing is pretty much in the noise after we pass 32K.  So I think
> > 8K is too small, but
> > given the flatness of the curve we can feel good about any value above
> > 32K from a performance
> > perspective.  I still think 128K is a decent number that won't likely
> > need to be changed for
> > some time.

Linux/BSD/etc `stat` system calls report st_blksize values to tell
user code the optimal size for read and write calls.  Does Windows
have one?  (It's not POSIX but is XSI.)

(How *well* the OS reports `st_blksize` is another question
entirely, but at least if the report says, say, 128k, and that's
wrong, that's no longer Git's fault. :-) )

On Wed, Feb 24, 2021 at 10:46 PM Junio C Hamano <gitster@pobox.com> wrote:
> Thanks for a supporting graph.
>
> I can very well imagine that it would have been tempting to instead
> say "after we pass 128k" while explaining exactly the same graph,
> and doing so would have given a more coherent argument to support
> the choice of 128k the patch made.  You knew that a "then perhaps we
> can reclaim 96k by sizing the buffer down a bit?" would become a
> reasonable response, but you still chose to be honest, which I kinda
> like ;-)

128K is correct for ZFS; 64K is typically correct for UFS2; 8K is
the old UFS1 size.  Anything under that has been too small for
a long time. :-)

Chris
