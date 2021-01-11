Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199AAC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 07:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD701227BF
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 07:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbhAKHhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 02:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAKHhy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 02:37:54 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF8CC061794
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 23:37:14 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r9so16834457ioo.7
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 23:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=FuCptfVMyjm205LHRoX7kI5o6aBFu+RFyUF/+ucNqHc=;
        b=j3YZnPAN32zflCcRZZfhx8aRwaEuiTUpxGGKkgMZmfUqQdHHbtxQy42nDHDFE8YLrl
         fmcK9cnEYAM65IM5lMHUHVCluBmFwKLz2Yd+wR8oh1obFYB7u7yia3v8w/alVIQJS2/z
         PAnNT0pWKFaqdt7hoSToGUjln1xmx4S082QjK5Azlkk4USUbDe9qvYlZB6Cd9YQiXAeX
         8t/FDrPy3U1fw+X60XCxIR/kuUr/skdj5zSzHHXZZwruhkHIJYfun/f8sV3FajfmQTcM
         q68t+OMWNGautZ4riHcWvtDyn4gTHDbAS74AawTPa+aGwFOp+yb2x12hS/AABY7zB09m
         oQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=FuCptfVMyjm205LHRoX7kI5o6aBFu+RFyUF/+ucNqHc=;
        b=Z9qiNyWRfrtyUk2CQ3Ul0K2SR4aoD9jG1aNucKPiP7b8Ncv/cJukNXyTU9MRYeRDqF
         JZoeTy1rx5YVez1MheOe1AYt6/Ad/QwsdMTRBgfmwpiAgs19UTx10HUEBN2U6ZhkrEqx
         FmWA+T4KWy9osjJEYz3RsJV4itBOZy6KOsleMu2W1rps0GDJE57XEXAqb7UlMuTZpqm7
         AfadoX0QyU56J1lAawLU2xUc63vZU51EMXygqAHu6kVMImA4F+uKQziNLfiZzObaEhkk
         KWXtwRAFo5P9nph6ksj8ASXUbeQWtzBIMBEH7n5zB5dGZx532llVqJzhB7FSKepkFxJY
         NPkA==
X-Gm-Message-State: AOAM530rgniqSSt7l+fTFIcaNRURIgJmBfmgstHW5eBAiWvjzShsi99u
        fnacJ91APPNQRPj1ROiJCcC4ds+E1gyrLNstAXA=
X-Google-Smtp-Source: ABdhPJyTJvES0H7tHuyYg/frxs0uECNOmJRw16c7UID5PzobKTUOgddRclEJPIh/ed6HlhqLBxVdTm0314ZhMYM9kfw=
X-Received: by 2002:a05:6638:14d5:: with SMTP id l21mr1122326jak.54.1610350633657;
 Sun, 10 Jan 2021 23:37:13 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8km6mHsrCD6sW+Z2ERpyO_X8Xp6fJbYKV+JF2gaqYakgQ@mail.gmail.com>
 <4d81f0f1-66eb-2aac-4eab-dc5508d161b1@mail.de>
In-Reply-To: <4d81f0f1-66eb-2aac-4eab-dc5508d161b1@mail.de>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 11 Jan 2021 02:37:02 -0500
Message-ID: <CAH8yC8kEcUrVr9iortiWWVRwfos0DAb+E3z2k8bQgmcSSOmGLg@mail.gmail.com>
Subject: Re: Git 2.30.0 and failed self tests
To:     Stefan Moch <stefanmoch@mail.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 10, 2021 at 12:09 PM Stefan Moch <stefanmoch@mail.de> wrote:
>
> Jeffrey Walton wrote:
> > I'm seeing some failed self tests with 2.30.0 on Fedora 33 x86_64
> > fully patched. They seem to be centered around email.
>
> I cannot confirm this on the same git version and platform:
>
>     # passed all 174 test(s)
>     1..174
>
> Christian's suggestion from your other thread about running the test
> with the options -i -v -x should also help here to give more
> detailed error messages:
>
> https://lore.kernel.org/git/CAP8UFD30et-kL8dFoWvh7aPf4AKbzGxSzTuA=B3YNHZL_1axFA@mail.gmail.com/
>
> >     *** t9001-send-email.sh ***
> >     ok 1 - prepare reference tree
> >     ok 2 - Setup helper tool
> >     ok 3 - Extract patches
> >     not ok 4 - No confirm with --suppress-cc
>
> Since the tests 1-3 do not call git send-email, but test 4 and most
> of the following do, I suspect the system is missing some dependency
> packages needed for git send-email, probably mail-related Perl modules.
>
> Installing Fedora's git-email package is probably enough to fix this:
>
>     dnf install git-email

I deleted my copy of Perl. I am only using the system's version:

    $ command -v perl
    /bin/perl

    $ perl --version
    This is perl 5, version 32, subversion 0 (v5.32.0) built for
x86_64-linux-thread-multi
    (with 44 registered patches, see perl -V for more detail)

I'm still seeing the failure. Weird...

Jeff
