Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310C5C43467
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD45B2222C
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/eeYmL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbgJNTMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 15:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390416AbgJNTMe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 15:12:34 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F712C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 12:12:34 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id l85so316511oih.10
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 12:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xk/6Z6PHE1zYBWkVkHInQ1CtM8i+DgJz7wbaSyXX1Xk=;
        b=g/eeYmL1A7+nus+xg9a32ZS5veAoGtIt+FzIMT8ydU9ltZUxO47N2r8HHIG+ZA/Ntw
         zwbaJz5RLi4Z2HW21JoXX8gGBSYWP0Xb60C4BErHDX115sbQIf5p4OyIdPfpooW5CBcx
         dgTi6y0ReYjZuRCIScxmmLYa5q4B/kRacc6MVREScNW/YPeYdRcjLEcFYXk1Sh6kDVX0
         c1Rgouruy1NqavWOTDhCCLxucRIYMJTfhifnX+59L3GRJCabSR1nKgeZtGaeLNlgbxud
         syjNWtBLpHUGwNK5IvLLD+2uziXgcMaQZNhivzL76HEENM4gqcVVweEs6YE1PqXbavQo
         rn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xk/6Z6PHE1zYBWkVkHInQ1CtM8i+DgJz7wbaSyXX1Xk=;
        b=L8hn2J8D+nX6jtRFQy82ZMeLBs1JiAW5NrL2WB+eAmXDCpPQwJd2ZYFhW+XthU1Zcb
         9XDqKA5CA090jevV6xqdqPFElqxuG4wO1vyRX7LOolIO8PVdEEVHM6lG3zyn0NvCLTCS
         j9MiXBwq6SSwHzImaT2Lr771MUhWUVMuf+xh729MNI36U1+pX+PcY+fSq90VuOKgvtDl
         uMzl1jg2UcOaOcLLlGCCalLPj6grZ07ZjyVWVIR93xVCmKeqDWOZ3dFxuK2GsT9JdtKv
         87dYbtC0h95aZ8bh+oJmxi9mtLrabZK0TC6IEs+1oCLNpXd2VljoxIRjcupHu0OJkNny
         jmhg==
X-Gm-Message-State: AOAM533qnbYu6OYl1c8dZIAyIBLCX9li44xR+kdZb/ng6uejMA0noJ8S
        mglGssZw0JilxPL2n2eX4Ju9WMSFw1pP6puwnbo=
X-Google-Smtp-Source: ABdhPJyUzqpFmb+vZY3BzgEWbIqK7R+wB97ClNIGPZMtzZIDRtvJtFjNmJWqYmSyrUdrG0HUx6yMfk8OWJZTPpmoqWs=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr512068oic.31.1602702753680;
 Wed, 14 Oct 2020 12:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com> <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
 <20201014170413.GB21687@coredump.intra.peff.net> <CABPp-BEOrYhUBZ112Z7qFgwUYojmus6_Ra0G0Ts4y+n=-D5vMw@mail.gmail.com>
 <CAPc5daU+w2U_5FBrSYEVO5PB2sOV_fxvBQ1=51_=NMTZooZGmA@mail.gmail.com>
In-Reply-To: <CAPc5daU+w2U_5FBrSYEVO5PB2sOV_fxvBQ1=51_=NMTZooZGmA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Oct 2020 12:12:22 -0700
Message-ID: <CABPp-BGBG=wh41BrvFZdzsN6biUPvuDkrA9EZURM4GKLx8kC0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by substring/regex
 with --run
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 10:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> > are you suggesting dropping the regex handling and limit it to
> > substring matching?  In either case, does using expr save us anything
> > (isn't expr a shell command)?
>
> I had something along this line in mind, not to do a regex but a glob.
>
> case "$title" in $selector) found=1 ;; esac

Interesting.  Since it needs to handle substring searching (e.g.
./test-script.sh --run=setup,rename), I think this would need to be
tweaked to be
   case "$title" in *${selector}*) include=$positive ;; esac

That'd probably be good enough for most cases, but I'm still inclined
to just pay the subprocess cost in order to allow regexes.  If someone
is specifying --run, they are going to be skipping many of the tests
(and thus a whole code block with dozens or even hundreds of execs per
test skipped), more than making up for the one extra exec per test.
And if someone doesn't specify --run, there is no extra cost.
