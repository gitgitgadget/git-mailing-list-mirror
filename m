Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8101BC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 18:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245712AbiCPSBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 14:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiCPSBM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 14:01:12 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06DC40900
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 10:59:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u3so4246903ljd.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHxFtXNyvGZVm+DOUJUpCqxf0MXLJC0zTvbSUn85zqE=;
        b=BTY/L22TA42tchm+CohImxhokpT9dWdged+rPZGh7A54df3ayBAUNLGtinDbt3bEnw
         8C5bvFWANnqiZErq0P0JiuhLZJ0VNZ2drdXo7nXCsOhiVOX1dPerzpxri/uOCRoELEkI
         k9qRVcK9uU39/xSJtaxhXl7yjRR0sPhQZmkSZmKy1To3bRXMNY1Px5Q/q+v5VSdN0pgU
         9k5jJoz8Wv4DGPXlXmA6tMKYR/akXQ8rVJP2jN5+0YGLz0kU6IbU+ku/4r7LDNdv6jNU
         NqlyjmS9KTbvtIm+IZ3ZA4POdh/8Igg/LJ87g3jf7aqhM5SWfRkUhpEiNhquRb2sfig9
         jfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHxFtXNyvGZVm+DOUJUpCqxf0MXLJC0zTvbSUn85zqE=;
        b=WELXIEz6ogdsJqOeOeONorLJHuGsnhAn/G2lLrsIC2E9FmG1cYfMbVgefKSYjLHWRk
         XXiaog3Qso1ayjmqcsbjNASLNMvXOxNnCwwpsuAjgXqMUcFLa+/LnJmGybg1qnGMyBie
         jUaG8iHDrqc8FVaSMAbM5yF1J5+yVh7cHFbWHZhVs0gdR/oRqOSoCi0KBqrBmR+r0YR6
         PHSZ2prgnPOENEGnWSLKVLPFe5B9QZ+G90vMfD3HFZ0cDaDhegXeyEPXPc+DLJ7Vtfms
         Hty51k24l2LW0U/MjuhCafFJDjlHvYwuXBupb/EkUV/RyQaWyhF6PduuoZfp2t47o4wS
         bpMA==
X-Gm-Message-State: AOAM531KT6YT5HSaGHSnbmmSi0xVWmUH2ovZ7QgD8qS1cXXSaZN2aYAa
        Z/d4M08nHZtMMHpZuVFNzneXmouPyzUPuHfGXHoWibfN5a0=
X-Google-Smtp-Source: ABdhPJyTagwth/IdviQJmDMVasj0mWAUOsjoAfvDlI6/EBZGZ9FaApqQYWNDybfrq8+1GgqzO+gip9O5PlGAcFbe7YI=
X-Received: by 2002:a2e:8ecc:0:b0:249:3a3b:fe70 with SMTP id
 e12-20020a2e8ecc000000b002493a3bfe70mr485044ljl.230.1647453595999; Wed, 16
 Mar 2022 10:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <a77d02df626ed6dff485e1342ff7affd6999ec44.1647379859.git.gitgitgadget@gmail.com>
 <xmqqbky6bgw0.fsf@gitster.g> <CANQDOdcak1nV1Pr9cmyk9dgEjHOH8Au92pUMskJipUodzskzqQ@mail.gmail.com>
 <xmqq35jhoows.fsf@gitster.g>
In-Reply-To: <xmqq35jhoows.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 16 Mar 2022 10:59:45 -0700
Message-ID: <CANQDOde+3QaTWnNWPQzz85iAGH=M-ZhG-HDR9SP4FCJf+=k43A@mail.gmail.com>
Subject: Re: [PATCH 1/7] bulk-checkin: rename 'state' variable and separate
 'plugged' boolean
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 16, 2022 at 9:14 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> > I think my new usage is congruent with the existing API, which seems
> > to be about combining multiple add operations into a large transaction,
> > where we can do some cleanup operations once we're finished. In the
> > preexisting code, the transaction is about adding a bunch of large objects
> > to a single pack file (while leaving small objects loose), and then completing
> > the packfile when the adds are finished.
>
> OK, so it was part me, and part a suboptimal presentation, I guess
> ;-)
>
> Let me rephrase the idea to see if I got it right this time.
>
> The bulk-checkin API has two interesting entry points, "plug" that
> signals that we are about to repeat possibly many operations to add
> new objects to the object store, and "unplug" that signals that we
> are done such adding.  They are meant to serve as a hint for the
> object layer to optimize its operation.
>
> So far the only way the hint was used was that the logic that sends
> an overly large object into a packfile (instead of storing it loose,
> which leaves it subject to expensive repacking later) can shove more
> than one such objects in the same packfile.
>
> This series invents another use of the "plug"-"unplug" hint.  By
> knowing that many loose object files are created and when the series
> of object creation ended, we can avoid having to fsync each and
> every one of them on certain filesystems and achieve the same
> robustness.  The new "batch" option to core.fsyncmethod triggers
> this mechanism.
>
> Did I get it right, more-or-less?

Yes, that's my understanding as well.

Thanks,
Neeraj
