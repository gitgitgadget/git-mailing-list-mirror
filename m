Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF2FC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 22:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF1F2225C
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 22:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="IGQ2TRm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393547AbgJTW3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 18:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389308AbgJTW3i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 18:29:38 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EE7C0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 15:29:38 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b15so487736iod.13
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 15:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QYVJeM9iEwh33OrN6P0Bg+IWcqn5y+w1fTLgBZ0gzVQ=;
        b=IGQ2TRm7UuQv2x7i51qb3oKwpPJkiPnHuipRRzikLyDyAhFz51i5MEClF/EfRg6gTK
         9wzRlK6CTe1kldTiPsQprOvYRVDrsvCevLfuCRANyHghj15IV7nNR6WoUFEfl+myCDYg
         zJOv3WQVT6r8Gia47KU1UtAtptv5P5HrKRgJl/dFo2lcVp0ZzjM4PHP/uyAR6tDtmgI/
         v8ku7+aQfq/sllMBujNOgi9Z9uHkO+4c1tgqVhxTmltMPZ0N5zchJUaqLX9L+7RGALv8
         rVjXxJdm7J6CdnXYu2Mkz1LNgDeBoCKfnsW1tS+wjkf+v+ELJ0+SsZ60Lzw6kqCoH4J6
         7p8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QYVJeM9iEwh33OrN6P0Bg+IWcqn5y+w1fTLgBZ0gzVQ=;
        b=BOnNLTIdQu7xQgaTBFrE8K5xyRYqFcH/jPypYvOZSYUxHkiBfYtQTYX8CJ4WEFbGV5
         o37BI5tT3HqquDQjdj1fTUf8xoMmQXFUTuGxwW0GMsJIzKQmGyP1RCuDG6wzlz0c2qRl
         e9uZbh1A9xmyJQjJaoV3yUrHMCU+i0nhnvU40RtQTt7yUbAsjBsbxdXrDl8ATrS2LFE9
         EI/ReaWmWArS9pLxpViRTgJciBvxRnYKnrorNfN3ahApDHn61I4GInovQKKrDsE58IqC
         zlZ4c/HaaRNLvOVnpAv82/5e3rjizIrJyYDTwSf61OdHm3HIwaIAWTnmVyS2aQMQyQ3I
         Cgvg==
X-Gm-Message-State: AOAM532NSkPSsWL392WjxK5yT2/RTOG5H1Pa6IMRn95wYKxVtXZoZaCR
        +Nxn9QWJ/M+h6yeb/er6mbV/TA==
X-Google-Smtp-Source: ABdhPJw+dE3Ee6ojoDqcdp5FmP6x2PrVejzF92Xi8N/gfPCMFSI8FbeJK+kvm1RUTJf9JnLRxxRskQ==
X-Received: by 2002:a02:6062:: with SMTP id d34mr435613jaf.84.1603232977289;
        Tue, 20 Oct 2020 15:29:37 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:5440:c3ba:60f:b745])
        by smtp.gmail.com with ESMTPSA id 128sm198192iow.50.2020.10.20.15.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 15:29:36 -0700 (PDT)
Date:   Tue, 20 Oct 2020 18:29:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        jonathantanmy@google.com, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: Questions about partial clone with '--filter=tree:0'
Message-ID: <20201020222934.GB93217@nand.local>
References: <aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexandr,

On Tue, Oct 20, 2020 at 07:09:36PM +0200, Alexandr Miloslavskiy wrote:
> This is a edited copy of message I sent 2 weeks ago, which unfortunately
> didn't receive any replies. I tried to make make it shorter this time :)

Oops. That can happen sometimes, but thanks for re-sending. I'll try to
answer the basic points below.

> ----
>
> We are implementing a git UI. One interesting case is the repository
> cloned with '--filter=tree:0', because it makes it a lot harder to
> run basic git operations such as file log and blame.
>
> The problems and potential solutions are outlined below. We should be
> able to make patches for (2) and (3) if it makes sense to patch these.
>
> (1) Is it even considered a realistic use case?
> -----------------------------------------------
> Summary: is '--filter=tree:0' a realistic or "crazy" scenario that is
> not considered worthy of supporting?

It's not an unrealistic scenario, but it might be for what you're trying
to build. If your UI needs to run, say, 'git log --patch' to show a
historical revision, then you're going to need to fault in a lot of
missing objects.

If that's not something that you need to do often or ever, then having
'--filter=tree:0' is a good way to get the least amount of data possible
when using a partial clone. But if you're going to be performing
operations that need those missing objects, you're probably better eat
the network/storage cost of it all at once, rather than making the user
wait for Git to fault in the set of missing objects that it happens to
need.

> (2) A command to enrich repo with trees
> ---------------------------------------
> There is no good way to "un-partial" repository that was cloned with
> '--filter=tree:0' to have all trees, but no blobs.

There is no command to do that directly, but it is something that Git is
capable of.

It would look something like:

  $ git config remote.origin.partialclonefilter 'blob:none'

Now your repository is in a state where it has no blobs or trees, but
the filter does not prohibit it from getting the trees, so you can ask
it to grab everything you're missing with:

  $ git fetch origin

This should even be a pretty fast operation for repositories that have
bitmaps due to some topics that Peff and I sent to the list a while ago.
If it isn't, please let me know.

> There seems to be a dirty way of doing that by abusing 'fetch --deepen'
> which happens to skip "ref tip already present locally" check, but
> it will also re-download all commits, which means extra ~0.5gb network
> in case of Linux repo.

Mmm, this is probably not what you're looking for. You may be confusing
shallow clones (of which --deepen is relevant) with partial clones
(to which --deepen is irrelevant).

> (3) A command to download ALL trees and/or blobs for a subpath
> -----------------------------------------------
> Summary: Running a Blame or file log in '--filter=tree:0' repo is
> currently very inefficient, up to a point where it can be discussed
> as not really working.

This may be a "don't hold it that way" kind of response, but I don't
think that this is quite what you want. Recall that cloning a
repository with an object filter happens in two steps: first, an initial
download of all of the objects that it thinks you need, and then
(second) a follow-up fetch requesting the objects that you need to
populate your checkout.

I think what you probably want is a step 1.5 to tell Git "I'm not going
to ask for or care about the entirety of my working copy, I really just
want objects in path...", and you can do that with sparse checkouts. See
https://git-scm.com/docs/git-sparse-checkout for more.

The flow might be something like:

  $ git clone --sparse --filter=tree:0 git@yourhost.com:repo.git

and then:

  $ cd repo
  $ git sparse-checkout add foo bar baz
  $ git checkout .

Thanks,
Taylor
