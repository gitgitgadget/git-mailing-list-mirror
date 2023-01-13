Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC2BC54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 04:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbjAMEfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 23:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjAMEeF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 23:34:05 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4915BA1A
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:32:53 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id x37so21386128ljq.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 20:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1xPzvBc9rVfD43KUL+7Fxn5pa3XcQCFTjVdzDOJTiBU=;
        b=EuxP+tJLGb48JOjwhh33g7tl7WMbFltZfDNxrguCxi2Kmx5BBcXoGyXV911aCL48oJ
         DD2lskJxd8azgMnGhOe4KTBG9i61EfA7hYSKc1mfjm1wdjJwmh641UnCowHU8zsYrEhp
         7Je/07leC3jshJPzZKdCCkfS4LjqjAHmMrjXEUpkSH/lRy8LeNGAcVPT+B4iuEB7yrIB
         vmCQKXrg+Oqb/5CrZhkL/qNfGI3hl6+Az6TEsKcgGAYaXUaMWIaA7uFbm1Fi8B8AeVN8
         5tieppCLzPaZCLDeAux6v2AEcD8MhtXHduH+C+hxVoAPNkX/g11g7F/Yr7ACPJxi1+UX
         P0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xPzvBc9rVfD43KUL+7Fxn5pa3XcQCFTjVdzDOJTiBU=;
        b=5GrPPRTFHuXAK74Q4WRXPoiOiGFKvi7H/SDIGhHYZcd0iq4Dppk06mG4flPfwhaY8N
         TEzzv5OJ+0edHoABaNHZLCaoo0cZUZDPq3WAWg4rT8XRudYYnGVH3jkATJgiKUZ3WGPj
         9daE7Pr87/u7gY5bCnBDwLkIlHcrIvNZ4FYsZJVP/8lu8yw8RN6YWk13EXW6PZwJqDC7
         KyMZjHTfhcGILkVA67Lvx4vUsIdW9tlIvZfZ2+FCpalRKJ8W8qrDd1vxi8CiGHiAW1kX
         qnYAZjdUZ29MjbPz2zHZkseYpMXvWUQcUwiv+6OJWqrL2nuiu2a00arloFRanF7ss2FT
         gfkw==
X-Gm-Message-State: AFqh2kpVJ2prONLahX20vcSlZH99otHMFKkLNRYIGA6ky1Yn7FyDLLHt
        FrCY66XUOn49PH8NB92SrktBKNaThJ4r/N3aKKjc9LADbpU=
X-Google-Smtp-Source: AMrXdXsR47Iu5GGmUZ7q9G3p+maXJlJUn1Frj/smIPs/rIyd/JPfUJL6k+tdbaZjXBqZ2N7rG985DppuVUffW5ase1w=
X-Received: by 2002:a2e:9ad7:0:b0:288:791b:71ee with SMTP id
 p23-20020a2e9ad7000000b00288791b71eemr631628ljj.521.1673584371761; Thu, 12
 Jan 2023 20:32:51 -0800 (PST)
MIME-Version: 1.0
References: <20230111233242.16870-1-rybak.a.v@gmail.com> <CABPp-BFxK7SGs3wsOfozSw_Uvr-ynr+x8ciPV2Rmfx6Nr4si6g@mail.gmail.com>
In-Reply-To: <CABPp-BFxK7SGs3wsOfozSw_Uvr-ynr+x8ciPV2Rmfx6Nr4si6g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 12 Jan 2023 20:32:39 -0800
Message-ID: <CABPp-BExVRPjO9DsFsqk8NhKcFcS=mxG91VT8HnPHfW0=XyC7A@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] fixes for commented out code in tests (was "Re:
 [PATCH] *: fix typos which duplicate a word")
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Tim Schumacher <timschumi@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Robin Rosenberg <robin.rosenberg@dewire.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2023 at 5:54 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Jan 11, 2023 at 4:05 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
> >
> > [ I apologize for some people getting this twice -- I messed up when
> >   invoking `git send-email` ]
> >
> > On 2023-01-06T19:25, Eric Sunshine wrote:
> > > Not related to your patch at all, but I notice in this test that the
> > > call to test_when_finished() is commented out:
> > >
> > >     # test_when_finished "stop_daemon_delete_repo test_insensitive" &&
> > >
> > > which makes me wonder if it was commented out while the test was being
> > > debugged but then forgotten, and that the script is now potentially
> > > leaking a running daemon if something in the test fails after the
> > > daemon was started, or if the daemon does not shut down on its own as
> > > it's supposed to do. [cc:+Jeff Hostetler]
> >
> > Here's a patch series that fixes some of the commented out test code.
>
> Patch 2 is obviously correct.  Patches 1 & 3 make sense to me, but it
> would be nice to have someone familiar with fsmonitor look at #3.
>
> As to your notes about other related testcases...
>
> > I skipped changing the following:
> [...]
> > 2. In t6426-merge-skip-unneeded-updates.sh, second part of the test '2c: Modify
> >    b & add c VS rename b->c' is commented out with an explicit "# FIXME:
> >    rename/add conflicts are horribly broken right now;" above the commented out
> >    part.
> >    [ cc Elijah Newren, author of c04ba51739 (t6046: testcases checking whether
> >    updates can be skipped in a merge, 2018-04-19) ]
> [...]
>
> You missed the cc...but I looked up this email since you did cc me for
> patch 2/3.
>
> Yeah, the commented out code was never tested, because the only thing
> I could have tested at the time was incorrect results.  So I just took
> a guess at what the improved testing would look like and apparently
> made 3 small errors in doing so.  I have fixed it locally and can
> submit a patch.

Submitted here:
https://lore.kernel.org/git/pull.1462.git.1673584084761.gitgitgadget@gmail.com/
