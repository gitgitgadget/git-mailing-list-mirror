Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C4EC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 04:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AED861058
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 04:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241906AbhIAFAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 01:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhIAFAe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 01:00:34 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8737C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 21:59:38 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id r6so2038836ilt.13
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 21:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ViACqXk7SMj7VliHIhIXmpn/y1NYXbdz4JuLknmaWZA=;
        b=kYTDG0EJnHONCJhJZGpSbDKXirAEdcGk+5F0erDL2sB5QATc8/jjD+P/9BEFLzivP3
         Gl4XFQwron+8lxoiK1Vh68NHTM/oJSRnCqEvlHGrDQibp4j8Rzyj6pxpRF6MqJjypUkW
         W8ggci1r1m/aMfCsEZnET9ROGJtdYvyD5mUorbhCKQAu/ts4+mZKeqCGHsP2ip1Fz0ph
         tXJwRd4X+7U2DhHx7TDQTJx0io5BImpI7lO4S6AbgpDoHslK1q8fgwaUbKqVM72aXRP2
         BXo15LMm0sm97p2Gmx/ATWSNkmMzJkiuJqwv++RQZiK0ay71PyunLqLoFGJHFQgcfmzw
         YqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ViACqXk7SMj7VliHIhIXmpn/y1NYXbdz4JuLknmaWZA=;
        b=KETdpLp8LJPHhHwN5ivzXyNryf76qea4AuANjtYzylEGJaU4G3qvFxc2mUXWijQxZ/
         QQzcj2py6zYXwdCyZB/i1FOckx3s134kyNUgvl08eeqcBrKxTb5OEzqxcTwMpKQ7II7V
         /wPwDwhZnGgjTiLJLvyb7QciqBOiqRx4LsISyPWDVqQ1pTygUhdS3KvnGlIRxehpa/FJ
         8XwF5FuF9DVZbwNz3ZQR+JAfyCwgC9e3gd7i0t8W1byMheVnef6vf0vKyEHO369ZCjRy
         g0BA0br1kOjgySz9m1VFthdSI9LAtVmZQLu1ge6HmyiO7rDK6d4dQ91hfuLt31/oHKeI
         LxLA==
X-Gm-Message-State: AOAM530/7COhJ279jjZySNGECxDCW4mFWsJWSUws4ieFlJheHCPkpREH
        xqgidDeg0hr15mwqW2E6sffIFbPu7uYSP8G1
X-Google-Smtp-Source: ABdhPJwdd0S5kagXzuvnGt8ys858K/gxcuNEskklP+yuQHJSvuGGPFPVoC/QcVhWj6hdiBg17F/SLQ==
X-Received: by 2002:a05:6e02:1ca6:: with SMTP id x6mr22097279ill.86.1630472378241;
        Tue, 31 Aug 2021 21:59:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u20sm11280431ilj.17.2021.08.31.21.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 21:59:37 -0700 (PDT)
Date:   Wed, 1 Sep 2021 00:59:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase, cherry-pick, revert: only run from toplevel
Message-ID: <YS8IucBBDX61QdFB@nand.local>
References: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com>
 <YS3Tv7UfNkF+adry@coredump.intra.peff.net>
 <CABPp-BFmU+RaAjq4_0-PSfRgH1Jc63nN0fMuDWk2+iDbdz7CCA@mail.gmail.com>
 <YS7rl8ynKD0fAerG@nand.local>
 <CABPp-BGkQTBBR_D-3EJPY-ONVYY4jjbEE4zA40n_oiz2DCrHgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGkQTBBR_D-3EJPY-ONVYY4jjbEE4zA40n_oiz2DCrHgA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 09:43:15PM -0700, Elijah Newren wrote:
> On Tue, Aug 31, 2021 at 7:55 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > On Tue, Aug 31, 2021 at 01:14:55PM -0700, Elijah Newren wrote:
> > > > Now I have spent zero time looking into actually coding this, so it may
> > > > turn out to be much trickier than I am suggesting. But this seems like a
> > > > much more fruitful direction, where we can protect users in cases where
> > > > they benefit (and give them sensible and actionable error messages),
> > > > without bothering people in the majority of cases where their cwd
> > > > doesn't go away.
> > >
> > > Ooh, this sounds intriguing to me...but what if we changed that rule
> > > slightly and just decided to never make the cwd go away?  Currently,
> > > the checkout code removes directories if they have no tracked or
> > > untracked or ignored files left, i.e. if they're empty.  What if we
> > > decide to only have remove_scheduled_dirs() remove directories that
> > > are empty AND they are not the current working directory?
> >
> > Hmm. My first thought after reading this is that it would cause
> > surprising behavior for anybody who had 'git add --all' in their 'rebase
> > -x' script. But would it?
> >
> > I.e., imagine somebody doing an in-place sed in a rebase and then `git
> > add --all`-ing the result at each point in history. If the directory
> > they were in ever went away, then the *next* revision would add that
> > directory right back.
> >
> > That behavior seems somewhat surprising to me, or at least I could
> > imagine it being surprising to users.
>
> I'm not following.  `git add --all` doesn't add empty directories, so
> I don't see how my proposed change would cause any problems in such a
> case; nothing would be added back.

Ahh, it was I who wasn't following. You were proposing to leave the
directories in place but empty. Agreed that there wouldn't be any
problems with that.

> > Another thought is what should happen when the current directory goes
> > away and then comes back as a file? We wouldn't be able to checkout that
> > file, I don't think, so it might be a dead end.
>
> I'm not following this either.  Peff's original suggestion was to
> error out only when we knew it could cause problems, in particular
> when the working directory would be removed.  Here I've shifted the
> way the problem is viewed by just not removing the working directory,
> but the end result is the same -- it errors out when the removal was
> needed.  Given that erroring out is exactly what we wanted for a case
> like this, why does that make it a dead end?

The way you shifted the problem makes it possible for us to discover
that only right before we're about to fail, right? In other words, if
you're doing a rebase then you're potentially leaving a lot of wasted
work on the table if you realize halfway through the operation that you
couldn't complete it.

Even though I think that's *not* what you want for rebase, it ironically
*is* what you might want for bisect, since the path we'll take isn't
known ahead of time. So even if there are some paths that would result
in a directory -> file conversion in the cwd, we don't need to fail the
operation ahead of time if the bisection doesn't actually take that
path.

On the other hand, it does still leave a lot of work on the table if the
bisection does eventually want to change the current working directory
into a file, depending on where that change happens.

Maybe those cases are pretty niche in practice. I have to imagine that
they are. If my guess is right, then I think your approach makes sense.

Thanks,
Taylor
