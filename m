Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CDFC43445
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 16:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308C320672
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 16:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsIPKCYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGOQIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgGOQHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 12:07:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69259C08C5DB
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 09:07:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so3311307wrn.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYxsfLkzAGRI20yM7Xa28R9jZfK8pcYpYEL2l9gZpFc=;
        b=UsIPKCYuGXEZkf3ZqlEWBvLiH9cW99f9beynzd4RFBOJ83+3Vud9mQNEO5Xy9KyPgg
         2axm0/xUBs9ng0m+wz6IXaPbhJ6FZu4Zb/klMeJ9ZRfpvK75HIaywFhF+51CNjLalesi
         Nv5y3GnQ5PBeyBNkHdzhKyuiqtlhEx6NV/FTxCkasZC1StA9U1auWr8l8zmIsAkxoChv
         5upnLPVCYmrJUidmdgpUIpjv4aVecw02gCbbd8zF9CTzAJOXFR2UCGqYKkaYwqQ9NMML
         edJSd/PLNOXMNQv5cyGoBXX2lOjOJ0kjMQGaWX/XTvPlUg8iPRwO3ghk5PdoYAe5XRSR
         RLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYxsfLkzAGRI20yM7Xa28R9jZfK8pcYpYEL2l9gZpFc=;
        b=ngrelD1uJJ6mEXiYsxrQXMp9L43IM5gJq4HqP3iNibLklox9wkrSXy/4aJ01yWXcK3
         KHWVyDSrSS6xf4TDxg0l4pZVl5YlC1HSRZ+XRYHo3QGdIhdmTmtbSIa+jTMoCKLptBte
         Mwr+fgFVDsSMdLgIMcjlVLQeOHGPKaW/PiK2zgvsLwWZIR3fDcrGNL/kerMXRWn44y2k
         0e02lTY9I7+mzE1cdVkQRRvwX8xKVKCIBnDShovIqYgAuQ8F/k0oNbfuHtV/2+MLgLRu
         +lHAkzilK2QFmv8tAUteYWRxrt0r0jzCwcBlIhS4czOv/IxUY7jqelLM3Cf1A4RCTtPM
         HykQ==
X-Gm-Message-State: AOAM5302Ff09BDqK9KQ30IEBK97NiAiK/qo8fGbdigEG+U2vc4dFYdNA
        2jzOPo9FDzHDlxdKZ3FAkAY3WvMXn1kXna18kSM=
X-Google-Smtp-Source: ABdhPJyIpdpmzdsaAqhmY/khR65opbvCXbsrwTBsz0/d95xm/vWMtpc4uwCzm4vYuJ6ckPxESW2BIR0792dpIHTgdfM=
X-Received: by 2002:adf:e90d:: with SMTP id f13mr119083wrm.146.1594829219161;
 Wed, 15 Jul 2020 09:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <14b3d372-f3fe-c06c-dd56-1d9799a12632@yahoo.de>
 <c8061cce-71e4-17bd-a56a-a5fed93804da@neanderfunk.de> <20200701162111.GA934052@coredump.intra.peff.net>
 <11754dcc-3c88-04dd-d009-89da01881e5d@neanderfunk.de> <20200715093831.GA3259535@coredump.intra.peff.net>
In-Reply-To: <20200715093831.GA3259535@coredump.intra.peff.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 15 Jul 2020 09:06:48 -0700
Message-ID: <CAPx1Gve48S+6VmpWD4FoYJ0MzMUVBZB_=Mu2bXy3RoLoZsJBMA@mail.gmail.com>
Subject: Re: Interrupted system call
To:     Jeff King <peff@peff.net>
Cc:     "R. Diez" <rdiez@neanderfunk.de>, Git List <git@vger.kernel.org>,
        santiago@nyu.edu
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 15, 2020 at 2:45 AM Jeff King <peff@peff.net> wrote:
> On Thu, Jul 02, 2020 at 09:07:46AM +0200, R. Diez wrote:
> > I do not understand why Git is getting these interruptions due to SIGALRM, because SA_RESTART is in place.

It really shouldn't -- that's the whole point of SA_RESTART.

> Delivering EINTR on a non-blocking call seems even more confusing,
> though. I think the "if it can block" is just "you won't even get a
> signal if it's not blocking".
>
> This really _seems_ like a kernel bug, either:
>
>   - openat() does not get the same SA_RESTART treatment as open(); or
>
>   - open() on a network file can get EINTR even with SA_RESTART
>
> But it's quite possible that I'm missing some corner case or historical
> reason that it would need to behave the way you're seeing. It might be
> worth reporting to kernel folks.
>
> -Peff

Right.  This goes way back to pre-v7-Unix signals, as a sort of a
side effect of the implementation.  In ancient times, the kernel
code for the internal wait-for-some-event took a priority number,
and anything below a cutoff value meant "not interrupted by
signals" while anything above it meant "interrupted by signals".
Disk operations were all at PRIBIO which was never interrupted.

This is all quite different in modern systems and hence it's all
adjustable, but in general we like to distinguish between
"operations that will definitely complete fairly quickly"
(normally not interrupted) and "operations that might take
significant amounts of time" (normally interrupted with the option
of restarting the system call).

*Restarting*, though, means exactly that: not *resuming*, but
*restarting*.  So whatever system call is to be interrupted by the
signal *must* be one that can simply be started over from the
beginning.  That means, for instance, that read() or write() can
only be restarted if no data have yet moved.  So if you're in a
read() on a device (e.g., serial port, or tape drive, or whatever)
and have gotten a few bytes, but not yet all you wanted, and then
the system call is to be interrupted by a signal, the read() must
return with a short count.

An open() can be restarted on the assumption that no path names
have been changed.  That's not necessarily a good assumption,
but it's traditional.  The openat() can be restarted for the same
reason (and in fact correct use of openat() can protect against
some pathname issues).  It's up to the programmer to decide
whether to use SA_RESTART, and hence allow this, or not.

Chris
