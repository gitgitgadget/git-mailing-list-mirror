Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C987C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 18:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6AF60249
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 18:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhDOSZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 14:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhDOSZm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 14:25:42 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA63C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 11:25:18 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 31so2016401pgn.13
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 11:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k/np5WbkTftrSI8l5ea4aLEDdLXMl0axMDF4jlHwGEU=;
        b=pWtwYYj2Z9Nkrrzs79M1sKcZDfr8EowEQH+UuIlsW7y/a9O0EbPdPL7sHVVUl1uees
         Il5v0xHEWFrD4r0OvnGVgmCWVmzFFqQg06UQFAHWPgvX+TMJErXOs/FyJhNZZlXj+jCf
         Li/8DNFvIRe5kVJZ7meVhHHqnZSqrlDRnmIe/+SoRIBbA+Nt+nK9lse0UWSxOEU+auR0
         Jskd+MJrk6cduW1PgwO9UaQ1emxSfCzV/JgC0pOEFZlXSibPgrPM7NVrH00Hj32VMYko
         a5WCLuUkAqIcaYq5YLVjMkLVjlw/Lr4eDr7JPvyF14HpHtcPeHY/yrcWHakwwcf7/3Ew
         cHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k/np5WbkTftrSI8l5ea4aLEDdLXMl0axMDF4jlHwGEU=;
        b=BMe9Nx+8Jtb+e/BAe6LaMKOApQS5AbyAUNpv9ISfN6vUm4Mwe7CGHN0LzCdUE5hT5v
         tvmsT9L/0ir2HKWAX8Ra012JC6FIAj/22Xx9vbbwYIoRjlh7nFgPjhHnUqwd+AL1GBs5
         ZqGcTcuKg5101g1Mv0x3f28vuMWc5yAesQ8Pyc95RxNYJBzxrKvO+WiU6mmme0iqdjRr
         GGyDOugObyGKRYW+mHRUxCPRRsXtdOrc5qaC1wsLe7vzMLBaCfvI+WEfOEJj2d/+AN4y
         RklyuViK31mTmS2NKlj7sjXkyu4mXBKSc94cm0lIJNK1QChYkcfQTVAr2EZQyV6h64ku
         BL7Q==
X-Gm-Message-State: AOAM53374sXNRmL/adwhAdYwegnU7X6X52seR6vtSpWmVNJhhhggyQ1k
        3jaCGelb7y9iO4Eozo68EA4=
X-Google-Smtp-Source: ABdhPJyZkn8VCh+0s7ZgnW3GjfTGoOVwlLtg0leDq6ZzKDluTNdVnx3XgYFWq0uYxszlByIp5CHBkQ==
X-Received: by 2002:a63:144e:: with SMTP id 14mr4551755pgu.53.1618511117663;
        Thu, 15 Apr 2021 11:25:17 -0700 (PDT)
Received: from atharva-on-air.dlink ([180.151.104.78])
        by smtp.gmail.com with ESMTPSA id k17sm2639653pfa.68.2021.04.15.11.25.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 11:25:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: Pain points in Git's patch flow
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <YHaIBvl6Mf7ztJB3@google.com>
Date:   Thu, 15 Apr 2021 23:55:12 +0530
Cc:     git <git@vger.kernel.org>,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3DB12C56-3FDF-49D1-B9CC-3ACB21367F3B@gmail.com>
References: <YHaIBvl6Mf7ztJB3@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14-Apr-2021, at 11:43, Jonathan Nieder <jrnieder@gmail.com> wrote:
>=20
> Hi,
>=20
> I'd like to introduce Raxel (cc-ed), who is starting an internship
> this June with the Git team at Google.
>=20
> He'll be working on a bit of an experimental project: we want to take
> Patchwork[1], which in principle can be a helpful addition to a
> mailing list centric workflow[2], and improve it to be something that
> people in the Git open source project get day-to-day benefit from.
> Raxel's previous successes in making changes to tools to support a
> better user experience make me excited for the potential for this
> work.
>=20
> Anyway, yesterday[3] Junio, Taylor, and Emily were discussing how to
> encourage more reviews:
>=20
> <gitster> this week, i'd be thinking about ways to get topics, that
>           are not reviewed sufficiently, reviewed. I can act as the
>           last-resort fallback reviewer, but that's not sufficient.
> <ttaylorr> gitster: I share your concern.
> <nasamuffin> gitster: yep, agree, on both counts
>=20
> That reminded me that it would be useful preparation to collect
> descriptions of pain points we are having with our existing patch
> flow.  For example:
>=20
> - As a reviewer, I want to be able to easily find a series that needs
>  review.  Using patchwork, I can see some recent patch series; or
>  using a hierarchical threaded mail reader, I can find a neglected
>  thread or one that seems to be likely to have an interesting
>  discussion going on.  But without reading in detail, there is no
>  easy way to see whether the series has reached a review, whether
>  someone else intends to review it, and what the author believes its
>  status to be.
>=20
> - Relatedly, as a patch author or reviewer, I want to be able to
>  easily tell whether a topic has been sufficiently reviewed.  Today,
>  the signals for this are implicit: I have to judge consensus, or to
>  check the Git repository for whether the patch has been merged, or
>  to check the maintainer's latest "What's cooking in git.git"
>  message.
>=20
> - As a potential reviewer or interested user, I want to be able to
>  follow all relevant discussion for a patch series, while also
>  having the ability to stop following it if the discussion goes on
>  too long and starts overwhelming my email inbox.  Today, I can join
>  the discussion and then (1) it is hit-or-miss whether the patch
>  author ccs me on later iterations of the patch and (2) there is no
>  easy way without aggressive email filtering to stop watching it if
>  I am cc-ed.
>=20
> - After having diagnosed an issue to be due to a patch, I want to be
>  able to easily find all relevant review discussion.  Today I can
>  use the mailing list archive[4] or patchwork to find review
>  discussion on the latest version of the series that patch was in,
>  but tracing back to previous iterations of that same series can be
>  non-trivial.  Moreover, if I'm interested in a particular puzzling
>  line of code, finding which iteration introduced it can take a long
>  time.

This is a great initiative!

While I do not have anything new to add in terms of pain
points, I just wanted to let you know that this is definitely
something that would have eased the process of bringing in a
new contributor like me.

> Those four are important in my everyday life.  Questions:
>=20
> 1. What pain points in the patch flow for git.git are important to
>    you?

As a new contributor (and also someone new to the patch flow) I
would have especially liked the second and fourth point addressed.
When I was preparing my GSoC proposal, I wanted to gather the
status of a previous contributor's work and even though searching
the mailing list helped, it was hard to immediately know what were
the status of the patches, and which changes got introduced in
which version of the patch series.

Also with my first patch series that I sent to the mailing list,
I initially felt unsure about what the status of my patch was
after a few people discussed over it. The 'implicit signals' is
something that was not immediately obvious to me, and only after
reading other interactions in the mailing list did I start getting
a hold of how I should interpret the responses, and what my next
action should be.

> 2. What tricks do you use to get by with those existing pain points?

In order to learn about a previous patch series and what was added,
I used git blame on the relevant part of the codebase, and tried to
search the commit message in the mailing list archive. =46rom there on
it was just opening a ton of tabs in order to see how the patches
developed over time.

The limitation with this trick is it will work only if the patch
actually landed in the codebase. A part of building my proposal
required me to read a patch that did not get merged, and I had to
just aggressively search the mailing list and hope I managed to catch
everything I wanted.

> 3. Do you think patchwork goes in a direction that is likely to help
>    with these?

I have noticed that a patchwork instance for this mailing list
already exists[1] so I decided to try it out. It definitely
addresses the problem of explicitly identifying the status of a
patch. I also liked that I could search for the previous
contributor that I spoke of and sort his contributions by date.
If I knew this existed, I would have saved a lot of time.

But as you also mentioned, it does not yet help me locate an
older version of a particular patch, and let me observe how it
developed over time. So that would definitely be a welcome
addition.

As Bagas mentioned in the thread, it seems to lend itself well
to identify beginner-friendly tasks. I did not personally have
too much difficulty with those thanks to the GitHub issue tracker
and the Git documentation, but if new contributors are anyway
going to refer to patchwork to study previous patches and learn
from it, it might be helpful to keep beginner issues accessible
there as well. Even a generic labelling system to help categorise
issues will do (a downside being that the labels will have to be
maintained and managed too).

Some small nits:
- The searching capability was not super obvious to me. My
  eyes naturally scan for a search box or search icon, it
  took me a few minutes of fiddling to realise that
  'show patches with' is a link that opens all the search
  filters.
- It would be nice (though probably out of scope) to allow
  me to do a code search in the patches.

> 4. What other tools would you like to see that could help?

(...I don't really have an opinion on this)

> Thanks,
> Jonathan
>=20
> [1] http://jk.ozlabs.org/projects/patchwork/; you can see an instance
> for Git at https://patchwork.kernel.org/project/git/list/
> [2] =
https://kernel-recipes.org/en/2016/talks/patches-carved-into-stone-tablets=
/,
> =
https://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html#_patch_=
workflow
> [3] =
https://colabti.org/irclogger/irclogger_log/git-devel?date=3D2021-04-12#l4=
0
> [4] https://lore.kernel.org/git/

[1] https://patchwork.kernel.org/project/git/list/

