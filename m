Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E5BC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC0D61004
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbhHZSuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 14:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhHZSuA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 14:50:00 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBB2C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 11:49:12 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q3so5024171iot.3
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ciHJy4IR21/fdoW2+mGXRZdX9gDbp1brzU4wEbyroqM=;
        b=iet1GskqZtBYSHhYWss8nINnzcxcWeVNTXKgKPCc7e5mwQVxWYEcrAT/r3GVqtkg0M
         MxGkzXMes1rggRBfNWWVnvLn2Nz/xselK0OKi0g+FLviCkFhuuKTCGjmEIspk+y/ZYRd
         pDXlioeN/BGz0x/k24Xdch4kTttK/72qt58yDlPS0qZsLE2fV8Ds4nvxkr4V8eCXuVrF
         nJztTYTn+kIV8AEInUOIlTX2Re2G9NBNOEiOEvNBmAQ4uevgGI/ou9m9C+Pnzup3wcGx
         vLaxztyII9j2yw55SCewMlYBDuUZeRNB45vP+xu1GZCh3uOZX6qIr03myXWZCmk6uMiv
         A5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ciHJy4IR21/fdoW2+mGXRZdX9gDbp1brzU4wEbyroqM=;
        b=URGXUUwQDRFXbhKkuX6k4Y4/iZkyM/DMZ7dX6qlKDkTx0EetBn1k4zTcqJn3CDHbrz
         bClzLiBq9wfoqj8k6ngmnM7jECqeXPAx5sUlC329PBrPtjxMT/fs4J1aPv6EQgVGseNv
         eSqF/FfzvJzUfhg8oLCLIaJYF4946S0fw6S7aAi5ryhPeon25XeHS2h7W8QuG8HyCNPB
         n2bysLXQ7bRRYu23EBsDdkOT4S0cfwNvqrzFKPzYkOMqfZRgNsoWdm5g/G4EazORrdGf
         HWtmA0I+QDHxC/K5KCK0yZDVSohy/ub66mBwEWxv+ZNZNnxfcU9Zc2sc984Vq+tzyiTj
         8BIQ==
X-Gm-Message-State: AOAM530UZKs2qS2OQsIZfCixpFbnb+kdlukxlG4iOVFs10S9RfSAe3J9
        ls7pJbyk5XyQXQDtg/uAAzW88Q==
X-Google-Smtp-Source: ABdhPJzSLYxY+DoYFNa0sLxoTyfnM28+czNcFvl8qKGIe63gqMRFu5bQsT2sZxfteklVSbRU+OjiWQ==
X-Received: by 2002:a05:6602:117:: with SMTP id s23mr4202696iot.124.1630003752180;
        Thu, 26 Aug 2021 11:49:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a11sm2067423ilf.79.2021.08.26.11.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 11:49:11 -0700 (PDT)
Date:   Thu, 26 Aug 2021 14:49:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 00/25] multi-pack reachability bitmaps
Message-ID: <YSfiJmYMPPyEueUG@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
 <YSWOtNoxirDdmBXG@coredump.intra.peff.net>
 <YSWmhMID1hGs7Yp1@nand.local>
 <YSXy73lWKteiuY6s@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSXy73lWKteiuY6s@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 03:36:15AM -0400, Jeff King wrote:
> On Tue, Aug 24, 2021 at 10:10:12PM -0400, Taylor Blau wrote:
>
> > > It's not clear to me that we have a resolution on whether calling "cd ..
> > > && git multi-pack-index write --object-dir repo.git" is supposed to
> > > work.
> >
> > My recommendation would be to do the following things, all in a reroll
> > of this series:
> >
> >   - Fix the bug by which we would delete a .rev or .bitmap file out of a
> >     different object store than we were working in (when the caller
> >     passes `--object-dir`).
> >
> >   - Disallow running `git multi-pack-index` outside of a Git repository.
> >
> >   - Restrict `--object-dir` to only work with alternates of the
> >     repository in the current working directory.
> >
> > To me, that seems like both the least-surprising behavior, and what
> > would lend itself to the easiest implementation. I would probably argue
> > that the existing behavior (where `--object-dir` would work against
> > arbitrary repositories) is a bug, and shouldn't continue to be
> > supported.
>
> All of those seem reasonable to me, and are what I would suggest if we
> were starting from scratch. My only hesitation is whether people are
> using the weird behavior of --object-dir in the wild (e.g., are bup
> folks relying on it).
>
> Johannes, is this something you're using _now_, and it works, or
> something you hoped to use in the future?

I did some research[1] on what parts of `--object-dir` have worked (and not
worked) in the past, and came to the conclusion that although this
behavior is surprising, we do bear the responsibility of continuing to
maintain it.

And in that sense, I agree with your "only call close_object_store() if
the MIDX we are using came from the object store, or otherwise call
close_midx() if it didn't", so that's what I did in the
tb/multi-pack-bitmaps branch of my fork[2].

I think that this is the most reasonable path forward, since it resolves
Johannes' concerns while also not breaking any existing functionality in
the meantime as we add new features on top. It has the added benefit of
closing some holes that were open in the past, so I think that it's
worth doing.

Before I drop 27 patches onto the inboxes of list subscribers, would you
mind taking a look at [1] (and the rest of the patches in [2]) to make
sure that you're OK with the approach too?

Thanks,
Taylor

[1]: https://github.com/ttaylorr/git/commit/a24290489c2b30f3caed7e33fe8f85226a12778f
[2]: https://github.com/ttaylorr/git/compare/tb/multi-pack-bitmaps
