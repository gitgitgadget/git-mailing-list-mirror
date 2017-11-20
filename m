Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 037A3202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 20:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbdKTUrz (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 15:47:55 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:43664 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbdKTUry (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 15:47:54 -0500
Received: by mail-qk0-f176.google.com with SMTP id j202so9168342qke.10
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 12:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cSCIInlT0AG5TOUja1rnXraK/HQJvms+UKv57jqvjdI=;
        b=iE6kan75dm9IW2zryP2t+Ifs+mOioaqymf3xIVLw2dhLVT/vrg+fteGJo+wkk8t4ja
         c1Vl0bDdIHZ9gLsxeF66FkkkqcFi+Migd02J+gaiGh//xFuKBczvUJGurJRm8fxl5Kq1
         jt+IX6UdB7ssikPbG74VeU53rTowwQ3NSBL5GfVPJGBkYrFVWukI6F3ADEGAboaxp4NY
         8TYbCeJPmKWrcLAnCTMtvcY3QP+PCKiqp8BDP0AfkRlcYmeTlT+fYlQ6AT+46KJanSnx
         nvJKF6q3+tmoJzNcZG5f85e/asE0W7eJX7nIpVrE1M4WG21lgvUvi+zv4bOwZRZweWlW
         QERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cSCIInlT0AG5TOUja1rnXraK/HQJvms+UKv57jqvjdI=;
        b=tNvtei4cI6sLVCBRv5bMvxFljdsm13GhnxwInnEGDktVg03rvlNd8Xf9ryrg7jBKZm
         mPsrT2UMaxK15QUbksD524zHXb4BXJoX4OwY9ydR+txzbLk6vd4xQoy9mopKx/+xCr1u
         OGJ5cC9QljTUWCPMKpsUAnkctOWI3c/XwvdJvYZ9KhzqGfGYcVJKcxUMLJLdrlj/XfeL
         UZvS9s8K5xO3Yf6JD7NKSOe4fY5L50SO9c6AZRrd9RiWD4aqUoixgtSNED5LtGZWWqzi
         OmKQv+v/MV+a4ZAn4Iwoxjy3aQfMvp8qKEYq7Ay0PeI79iiSeCnTB2fdWf1zosSruD2O
         ZKMQ==
X-Gm-Message-State: AJaThX7U300fczrueiUDkPeOjE3bzZDTx5BAdD+ZRsTlR+hZQaELWdV0
        h0vvdrjt7MM5rPqsjwGnD4biv9JWNpG5w7xpG5YLpw==
X-Google-Smtp-Source: AGs4zMZokSWwq4xh7PMJoRBJ43Iy6Ud3dpsC3DSEOYCL09ja7knSrKVQ6Lb03CHbPQEBCs+RL0CDJgQ3ikLblrzh/Ag=
X-Received: by 10.55.106.132 with SMTP id f126mr22109414qkc.295.1511210873792;
 Mon, 20 Nov 2017 12:47:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 20 Nov 2017 12:47:53 -0800 (PST)
In-Reply-To: <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net> <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Nov 2017 12:47:53 -0800
Message-ID: <CAGZ79kZWJhZ-6-1MZiWK4O-uWJG+T5QU29a5fRnw6R26J4fuCA@mail.gmail.com>
Subject: Re: [PATCH 5/5] sha1_file: don't re-scan pack directory for null sha1
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 12:35 PM, Jeff King <peff@peff.net> wrote:
> In theory nobody should ever ask the low-level object code
> for a null sha1. It's used as a sentinel for "no such
> object" in lots of places, so leaking through to this level
> is a sign that the higher-level code is not being careful
> about its error-checking.  In practice, though, quite a few
> code paths seem to rely on the null sha1 lookup failing as a
> way to quietly propagate non-existence (e.g., by feeding it
> to lookup_commit_reference_gently(), which then returns
> NULL).
>
> When this happens, we do two inefficient things:
>
>   1. We actually search for the null sha1 in packs and in
>      the loose object directory.
>
>   2. When we fail to find it, we re-scan the pack directory
>      in case a simultaneous repack happened to move it from
>      loose to packed.
>
> It's debatable whether (1) is a good idea or not. The
> performance drop is at least linear in the number of
> lookups, so it's not too bad. And if by some 2^-160th chance
> somebody does have such an object, we probably ought to
> access it. On the other hand, enough code paths treat the
> null sha1 specially that the object probably isn't usable,
> anyway.
>
> Problem (2), on the other hand, is a pretty severe
> performance issue. If you have a large number of packs,
> rescanning the pack directory can be very expensive. And it
> only helps in the case that you have an object with the null
> sha1 _and_ somebody was simultaneously repacking it. The
> tradeoff is certainly a bad one there.
>
> In an ideal world, we'd simply fix all of the callers to
> notice the null sha1 and avoid passing it to us. But a
> simple experiment to catch this with a BUG() shows that
> there are a large number of code paths.
>
> In the meantime, let's address problem (2). That's the
> minimal fix we can do to make the performance problems go
> away. p5551 shows this off (when a fetched ref is new, the
> "old" sha1 is 0{40}, which ends up being passed for
> fast-forward checks, the status table abbreviations, etc):
>
>   Test            HEAD^             HEAD
>   --------------------------------------------------------
>   5551.4: fetch   5.51(5.03+0.48)   0.17(0.10+0.06) -96.9%
>
> We could address (1), too, but there's not much performance
> improvement left to make.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is the minimal fix that addresses the performance issues.
> I'd actually have no problem at all declaring that looking up a null
> sha1 is insane, and having the object-lookup routines simply return "no
> such object" without even doing the loose/pack lookup first.
>
> I'm also fine with going down the BUG() route and fixing the
> higher-level callers, but it's a big enough task (with little enough
> real-world impact) that I think it would be worth applying this in the
> meantime.

It would have a lot of impact in the future, when new developers
are hindered mis-using the API. The (unwritten) series with introducing
BUG() would help a lot in 'holding it right' and I would expect fewer
performance
regressions over time.

The patch is impressively small for such a performance gain.
Personally I think (1) (which essentially means "making null sha1
work like a regular sha1") is quite an endeavor at this point in time
for this code base.

As a tangent, a similar but solved problem in the diff code is how
NUL in user data is treated in xdiff for example, as there we kept
being careful since the beginning (though I think we don't have tests
for it, so it might be broken)

Stefan
