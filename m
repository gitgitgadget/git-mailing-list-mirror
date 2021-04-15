Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A5CC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 23:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE95610FA
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 23:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbhDOXHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 19:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhDOXHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 19:07:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C8AC061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 16:06:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e7so15889402wrs.11
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 16:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AMjujgZtkdgoRkRuHtRwsTGijBY2k4o054KDKgMnKMk=;
        b=TjXfyAdoGu8ChKrIOwd11tPjMUf41CZQr1b9LrOOrjBBba+ZZyi3WE/OhGqbhA4VWx
         qEPOaDGROq0sudfQ9LJBX1bj1W9gYtnSs+0vwnHn8dbJXaglzYmWvqnyACIQpNsWJ4mD
         msaRqryGqmAqSd8TuLZ+a8XhETHyJl0SK32sz8/aV4Fm4QkknvoW28wASCq3Q1629Dvr
         gJ7M5njxqHZymLb1yR8uiSM4tLLtF3JcLaYprV9VdsKF5AB9IOQxStzl/wZUB88uFKd8
         4kctlXXHrd+FrWABkpTsVOQfTvnkzBDIhbKbmoLCjjnEZuWCBKIxSp0TQPyYWfXnwBqW
         cjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AMjujgZtkdgoRkRuHtRwsTGijBY2k4o054KDKgMnKMk=;
        b=AB6krnXAWZUT6qgsAROM/oN2KNwxGGNUr1Q8ttPY8FrO0UJsD1znzDU7BugpcVGoaV
         +FWxyIPqcGy7XcZpo35ePDX0C2+R574JJllu73G0CXkYNeA3qccGESVaa3rl0M3+Aiyz
         kRBGw2J1OhCVeBbPY/U2spwCH6KYo4QSyHv60q0kv+3lQHOS8zuiVPAfHbzkd394SdSE
         TLd6BQf1cAGL/IgU2lo3CkcpBAncjoPUtMMiJ9SsNcTQf3XvTuEmR+LDwAaIB1yMv0t2
         +mtDTWPcePM3AUNZr4loZo0IUqlV+Xxbx9t9HQJOWVxVSCxGTo5OIXCXoFzyjIAHpcv5
         Ek+Q==
X-Gm-Message-State: AOAM530FvOuS93WUKftIEs0LfILHN53VAxM0TFENk7GCgNENkGnmjvjX
        IOnCmJMUaSynv1Xak4jUmL46p3nSxwO7CJ8OHwIqmg==
X-Google-Smtp-Source: ABdhPJyWw1MHi1bYv9MSy0WHh4ikjIuzV+0P7DmlGkY0jn6NnXj9dTXKjfbFILC7XazqF41MefWAK6IXvLXAwYKbIO4=
X-Received: by 2002:adf:f64f:: with SMTP id x15mr5899004wrp.266.1618528011426;
 Thu, 15 Apr 2021 16:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210415212017.1407303-1-bga@google.com> <xmqq4kg7p63j.fsf@gitster.g>
In-Reply-To: <xmqq4kg7p63j.fsf@gitster.g>
From:   Bruno Albuquerque <bga@google.com>
Date:   Thu, 15 Apr 2021 16:06:40 -0700
Message-ID: <CAPeR6H5wx6F9rAYoRC-1GwHDujBFyjMTUPdHkQAuZh-eYAoRsg@mail.gmail.com>
Subject: Re: [PATCH] object-info: support for retrieving object info
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 15, 2021 at 2:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Is the assumption that such an implementation of VFS would fetch
> individual tree object with the existing "fetch this single object
> by the object name" interface?

That is the general idea, yes.

> What I am wondering is, as an ingredient for implementing VFS layer,
> if this is a bit too low level.  To respond to "ls -l" when you only
> have a tree object name, you'd need two roundtrips, one to retrieve
> the tree, and then after parsing the tree to find out what objects
> the tree refers to with what pathname component, you'd issue the
> object-info for all of them in a single request.

Yes, as it is designed you would need to do that. There are a couple
few reasons for this implementation to do this the way it does:

1 - Although it is currently only returning object sizes, it was
designed in a way that it can be extended if need to return other
object metadata.
2 - Doing it like this is a fully backwards-compatible change and
older clients would still work without changes (just not make use of
this).
3- In a real filesystem, it is common to have multiple directories
under a tree so in practice you can optimize requests (if needed) by
retrieving several tree objects and doing a single object-info request
for all objects in those trees.

Note I am not saying it could not be done in a different way, but it
does look to me this change strikes a good balance between what it
provides and its cost,

> If a request takes a single (or multiple) tree object name, and lets
> you retrieve _both_ the tree object itself _and_ object-info for the
> objects the tree refers to, you can build "ls -l" with a single
> roundtrip instead.

That is true. But it seems to me that there is not a good place to fit
size  (and maybe other metadata eventually) information currently with
the existing protocol. But it is not impossible that I might simply be
missing something.

> I do not know how much the latency matters (or more importantly, how
> much a na=C3=AFve coutner-proposal like the above would help), but it is
> what immediately came to my mind.

I do not expect the latency of the object-info request to be an issue
especially because fetching the information can be done in batches and
also prefetched in some cases (as we do not need to download the
objects, we do not need to worry about downloading possibly gigabytes
of data while just iterating through directories). But, of course,
assuming there is a clean way to make things even better, I am all for
it.

> Assuming that we are good with an interface that needs two requests
> to obtain "object contents" and "object info" separately, I find
> what in this patch quite reasonable, though (admittedly, I've
> already read this patch during internal review number of times).


FWIIW, I gave this a lot of thought and for the purposes of doing a
remote file system (and one can even optimize git ls-tree to be a lot
faster for partial clones using this), I feel confident about the
change (module missing something, of course).

Thanks for your comments.
