Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301CDC4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02971613B1
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 13:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhFANSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 09:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhFANSq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 09:18:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BC8C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 06:17:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g8so13212592ejx.1
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdW/5vv9qCbiNm5DSe0mX5jJJJHoet2BAvk1IJEsSLM=;
        b=GB1kb9qPgQnbqdZk52aW+uHawzVDLpBXR5HydwjfpLar8CEC5vgnlSXXHmhUZTRz6T
         IJAuZMTIjixhxC8wKMYt+P4ug2kIh8L1ZzWdmoFglTAcGltFE9LeE9GVBoeVDarFgGqR
         NKQpxUAfJnGO/WW34VZ7PEU8HWugwndNWgOfbeLlvmHbtvFqdMpS+vyTrD/g3fK10WI4
         28tA2e4zE+bXFdHoH6tdGFBqmDGTAYt50yv5D13VKw2leGyDNRy19DWWq9ro/dpto7/f
         UhyoJxOrN4kqPZkZKKSXM0MgdcVRvfxUTJahLO5czOSxKBHFTb83bsYvgkg6S4k4A4m1
         SCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdW/5vv9qCbiNm5DSe0mX5jJJJHoet2BAvk1IJEsSLM=;
        b=DCTZgo2veF4fqgptBt6j5S5RvwS/oosvg/9FBidmvDeOyfI/EONrPhgxdPEqU+q1FY
         Eq5hldHL8whtYIZAJD8CnWEOO0WIWHVlaHwU2RJ94RTpxG0pNaRiwlkBRO8wV3ZsBuFt
         NSz/1ngHfR8Rv1R51kjzHWo3ta65/2CwUVwJxenS2qec0a3EbaQYLf7sw4oqhh4Xh+n6
         TseTR/xK+3S5j48G7irNVUrg36OdQaKTSpWU5Kre2JG6Saq06wq/Ihy7nLkkpPLBko0d
         mUvHxPOsexkYm+9xcEBqICjF4R/WOmIbzq0OUKohRmRyMgRfTkeEjPmJJF3vZwLQNZEH
         S6Ig==
X-Gm-Message-State: AOAM531slUZnKH9IUIm7L3hlxM0Uy0k+wyjeWAXh7AP4Eh7Rod+eU0rl
        IgSOHL5AUNZFtHJPt3lT2BPIt0JrVio3Ej4wZ0XG3g==
X-Google-Smtp-Source: ABdhPJzzIjhOkDg55TpDOXfzP+qOfpicHma7/s0xCVBSpHFCn0hqh4tnkBhbRRrpjOPIP5sJ+xT+KweJdCx1m5jnIp8=
X-Received: by 2002:a17:906:c1d3:: with SMTP id bw19mr29498576ejb.145.1622553423009;
 Tue, 01 Jun 2021 06:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoim38J3=4pd0_fM2h=DN_PrEE_Osg2duU5Ur8WUZ5S1Pg@mail.gmail.com>
 <032cabb2-652a-1d88-2e12-601b40a4020c@gmail.com>
In-Reply-To: <032cabb2-652a-1d88-2e12-601b40a4020c@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 1 Jun 2021 15:16:51 +0200
Message-ID: <CAPMMpohOuXX-0YOjV46jFZFvx7mQdj0p7s8SDR4SQxj5hEhCgg@mail.gmail.com>
Subject: Re: Removing Partial Clone / Filtered Clone on a repo
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 1, 2021 at 12:39 PM Derrick Stolee <stolee@gmail.com> wrote:

> Could you describe more about your scenario and why you want to
> get all objects?

A 13GB (with 1.2GB shallow head) repo is in that in-between spot where
you want to be able to get something useful to the user as fast as
possible (read: in less than the 4 hours it would take to download the
whole thing over a mediocre VPN, with corresponding risk of errors
partway), but where a user might later (eg overnight) want to get the
rest of the repo, to avoid history inconsistency issues.

In our current mode of operation (Shallow clones to 15 months' depth
by default), the initial clone can complete in well under an hour, but
the problem with the resulting clone is that normal git tooling will
see the shallow grafted commit as the "initial commit" of all older
files, and that causes no end of confusion on the part of users, eg on
"git blame". This is the main reason why we would like to consider
moving to full-history but filtered-blob clones.

(there are other reasons around manageability, eg the git server's
behavior around --shallow-since when some branches in refspec scope
are older than that date; it sends them with all their history,
effectively downloading the whole repo; similarly if a refspec is
expanded and the next fetch is run without explicit --shallow-since,
and finds new branches not already shallow-grafted, it will download
those in their entirely because the shallow-since date is not
persisted beyond the shallow grafts themselves).

With a (full-history all-trees no-blobs-except-HEAD) filtered clone,
the initial download can be quite a bit smaller than the shallow clone
scenario above (eg 1.5GB vs 2.2GB), and most of the disadvantages of
shallow clones are addressed: the just-in-time fetching can typically
work quite naturally, there are no "lies" in the history, nor are
there scenarios where you suddenly fetch an extra 10GB of history
without wanting/expecting to.

With the filtered clone there are still little edge-cases that might
motivate a user to "bite the bullet" and unfilter their clone,
however: The most obvious one I've found so far is "git blame" - it
loops fetch requests serially until it bottoms out, which on an older
poorly-factored file (hundreds or thousands of commits, each touching
different bits of a file) will effectively never complete, at
10s/fetch. And depending on the UI tooling the user is using, they may
have almost no visibility into why this "git blame" (or "annotate", or
whatever the given UI calls it) seems to hang forever.

You can work around this "git blame" issue for *most* situations, in
the case of our repo, by using a different initial filter spec, eg
"--filter=blob:limit=200k", which only costs you an extra 1GB or so...
But then you still have outliers - and in fact, the most "blameable"
files will tend to be the larger ones... :)

My working theory is that we should explain all the following to users:
* Your initial download is a nice compromise between functionality and
download delay
* You have almost all the useful history, and you have it within less
than an hour
* If you try to use "git blame" (or some other as-yet-undiscovered
scenarios) on a larger file, it may hang. In that case cancel, run a
magic command we provide which fetches all the blobs in that specific
file's history, and try again. (the magic command is a path-filtered
rev-list looking for missing objects, passed into fetch)
* If you ever get tired of the rare weird hangs, you have the option
of running *some process* that "unfilters" the repo, paying down that
initial compromise (and taking up a bit more HD space), eg overnight

This explanation is a little awkward, but less awkward than the
previous "'git blame' lies to you - it blames completely the wrong
person for the bulk of the history for the bulk of the files;
unshallow overnight if this bothers you", which is the current story
with shallow clone.

Of course, if unfiltering a large repo is impractical (and if it will
remain so), then we will probably need to err on the side of
generosity in the original clone - eg 1M instead of 200k as the blob
filter, 3GB vs 2.5GB as the initial download - and remove the last
line of the explanation! If unfiltering, or refiltering, were
practical, then we would probably err on the size of
less-blobs-by-default to optimize first download.

Over time, as we refactor the project itself to reduce the incidence
of megafiles, I would expect to be able to drop the
standard/recommended blob-size-limit too.

Sorry about the wall-of-text, hopefully I've answered the question!

Thanks,
Tao
