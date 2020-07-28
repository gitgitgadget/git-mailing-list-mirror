Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927D6C433E0
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 17:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721042070B
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 17:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzFxigRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgG1Rw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgG1Rw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 13:52:27 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95D4C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 10:52:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 3so404500wmi.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 10:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90xy0B4hNwXMZ+Xi4/Yzwxqq7NN/IZeLtR36ppOiOwo=;
        b=DzFxigRrENHRBNjI7Jke3AqZj76G1JJP57/er8cyZGsweaszJNu6CPPP8GBgIhcbmO
         kgiorJHoDo5N7Rrzmk841VfJAgfi9eNa9pmNhwxFX47mJJXsJqHfL5wNkqIiz9PiIC6t
         cJOgiS48n0x4qfJmze4RhBIc+HGMsHQva5Uu0QLfPnCf105a6scOJ2GutIV5dOCz8Pp9
         b9hJ2ciCMmbJ8d9Y3Frw8+HS9gSBiws09b5AIZS1sl3wM6M1FGrk1xVtPCcY1VFV08+i
         XE8QcMri2vJEwq5SMGah7BiGQdzl8IWvzEA6OnboqRptiutPrnkPnKV1mWILc1+gFNy2
         nlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90xy0B4hNwXMZ+Xi4/Yzwxqq7NN/IZeLtR36ppOiOwo=;
        b=XGGCv2TWUV7awtuQmDol5JQCqe8CYiiBhfYHBW6iT6NIXe6aQDrFVZVtYvYeQei1yh
         MvKfQNOgEYQGnr8iwKf5r5WgTp+BNyGG67/sC5gkRMc4RSUvAjbc1Z6cuMh0W2D4L9lH
         Wy1BuukCYCeJXPn/VJUSTHoIi1BjmNGXsDiODFFThI9FlwDxpYX6mM7BR0SEcTg2szDN
         iPDsEGFvZZlR5mczahxvfGr5/m4l4Zin16UjraFrdLD5CaSnISOyhn+AHLOFsf3Wwtdq
         qOCYl/vEgAp/xJnlgrUuvcgVhg/moqoYDnYl0fJ6hr4qUiabfQP7hICb5UhyyiUyeAyB
         067Q==
X-Gm-Message-State: AOAM5309nJRHHeAumIL3FYX/hYYW07dNqsMAJ78FazxZyZE/SVO0pfbM
        d+SLmFsYNtwpHcc5QSLLpqU6m/gjNLqEdSviLO9Rz/MqONk=
X-Google-Smtp-Source: ABdhPJz2kAsQX5j9hFfYwnKUJPqR21kbhjB8Ad3P4XNN+pd7dQ9/li0s312JPDsnFX7BqgOAPQnKEqJ9iwCUY9P1QHs=
X-Received: by 2002:a1c:3102:: with SMTP id x2mr5295026wmx.171.1595958745467;
 Tue, 28 Jul 2020 10:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200728163617.GA2649887@coredump.intra.peff.net> <20200728163853.GB2650252@coredump.intra.peff.net>
In-Reply-To: <20200728163853.GB2650252@coredump.intra.peff.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 28 Jul 2020 10:52:14 -0700
Message-ID: <CAPx1Gvf7d5kdPqYVvruStZuXTySBFZEWMx_1O2MtWJatUM3j+w@mail.gmail.com>
Subject: Re: [PATCH 2/3] revision: add "--ignore-merges" option to counteract "-m"
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First, not that anyone should particularly care: I heartily
approve. :-)

On Tue, Jul 28, 2020 at 9:40 AM Jeff King <peff@peff.net> wrote:
> I pulled the option name from the rev_info field name. It might be too
> broad (we are not ignoring merges during the traversal, only for the
> diff). It could be "--no-diff-merges" or something, but that would
> involve flipping the sense of the boolean (but that would just be in the
> code, not user-visible, so not that big a deal).

Perhaps a bit bikesheddy, but I would suggest some clarifying
notes in the documentation.  The fact that `git log` *follows*
merges by default is pretty obvious, but the fact that it doesn't
*diff them at all* by default appears to be surprising to most Git
newcomers.  (It was to me, so many years ago, and I see this all
the time on stackoverflow.)

  Note that --ignore-merges / --no-ignore-merges affect
  only diff generation, not commit traversal.  Note
  also that by default, "git log -p" does not generate
  diffs for merges except when using --first-parent.
  See also the -c and --cc options and note that the
  default for "git show" is "--cc".

(The "except when using --first-parent" is of course new here.)

This probably needs a bit of tweaking, but the big idea is
to communicate and emphasize three things:

 1. "git log -p" and "git show" behave differently by default.
    It's a surprise, so we should call it out separately.

 2. The default for "git log -p" is no diff at all for merge
    commits, so see -c / --cc when you're looking at -m.

 3. The default for "git show" is "--cc".  (This note doesn't
    really belong here; perhaps it should be separately
    listed under the -c and --cc options?)

Chris
