Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3082AC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1208B60EB0
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243679AbhHZVXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhHZVXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 17:23:05 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7176C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:22:17 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id b4so4732293ilr.11
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8bAHyGr5DTKNZmRcGTiLFZLRuXyuS8t7wBDJbXMnlBU=;
        b=mI/Waxk5BsnJgI5A24RmKptEqjqPPLRG/M+DJaVkrx6IWXvAtRdQ/qB1ZucMsHE3rZ
         0pmrRsfH0lvFl1fNCA26OlbpwPPf9bK58mRiVmhCOvXQdru3/RwgT6dvIVuWf2H/tisU
         Yg/eP8NiZX21FlTkFlQSC38wtmOlZHcI9x2hWZvskDsBMoMfuAkxaoLxw3/SROc1PDRK
         M+FbPc/6C9SwhvlxxLPycT5jFw2g8wZhC6FtiweC1ZR97P1IW8HJcpDecI6HG2CKS/SZ
         yACmNro91XhF/G4hihBlELmSdTPt2jxV3ouQqPB9uTn2L2tXR9uTKQR/HvbDkSaw0aw9
         NMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8bAHyGr5DTKNZmRcGTiLFZLRuXyuS8t7wBDJbXMnlBU=;
        b=TivNX6iMPixRhhXfdSr3fiKN5SqXQOjx3uGmZo+K5TdZ9WVIKnAK8qLezWnT5Ozjk3
         37z8sMVj0UFH0FP7jO/AjqiIlDwXae8JkQBUfKZFI7kybMAj5Jt/dzLKN36ZaBh0Hnl/
         uq9zZAhl0t+hU5Ku0S+oNe7mmwlFAdCGtIQ3HdR92EBfAJO1uQ/b2cffRynPHTUxdzwu
         ak7YZvmdouRmUweggHHH/ZwdpFB6m5xXHaNUnOlvdTwE9ymuj/bLfm+Ig+MtkvPkMSWG
         ZOWTt84apbE89pNdgc4fkMxfhKR6LDF7wzAtZFE4FGAr5H8p5LqxqAyJShw9hz7blnXk
         CzKg==
X-Gm-Message-State: AOAM530q8dbJ6ssuSBt3xYFtnjJOXxDfTSRA6oMZv4CK2ewOgewCAtA6
        1qRfXglcMcECSonYCQanNOJzSg==
X-Google-Smtp-Source: ABdhPJzK70kIz5fc1LNlm8IxNMsklntKJJBdX/it2EXsDATGVOd+3eFQBh+V3bSie9o9H2nX0zdQNA==
X-Received: by 2002:a92:c5ac:: with SMTP id r12mr4187717ilt.279.1630012936945;
        Thu, 26 Aug 2021 14:22:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x15sm2331523ilp.23.2021.08.26.14.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 14:22:16 -0700 (PDT)
Date:   Thu, 26 Aug 2021 17:22:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 00/25] multi-pack reachability bitmaps
Message-ID: <YSgGBxh24UAZR5X3@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
 <YSWOtNoxirDdmBXG@coredump.intra.peff.net>
 <YSWmhMID1hGs7Yp1@nand.local>
 <YSXy73lWKteiuY6s@coredump.intra.peff.net>
 <YSfiJmYMPPyEueUG@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSfiJmYMPPyEueUG@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 02:49:10PM -0400, Taylor Blau wrote:
> On Wed, Aug 25, 2021 at 03:36:15AM -0400, Jeff King wrote:
> > On Tue, Aug 24, 2021 at 10:10:12PM -0400, Taylor Blau wrote:
> >
> > > > It's not clear to me that we have a resolution on whether calling "cd ..
> > > > && git multi-pack-index write --object-dir repo.git" is supposed to
> > > > work.
> > >
> > > My recommendation would be to do the following things, all in a reroll
> > > of this series:
> > >
> > >   - Fix the bug by which we would delete a .rev or .bitmap file out of a
> > >     different object store than we were working in (when the caller
> > >     passes `--object-dir`).
> > >
> > >   - Disallow running `git multi-pack-index` outside of a Git repository.
> > >
> > >   - Restrict `--object-dir` to only work with alternates of the
> > >     repository in the current working directory.
> > >
> > > To me, that seems like both the least-surprising behavior, and what
> > > would lend itself to the easiest implementation. I would probably argue
> > > that the existing behavior (where `--object-dir` would work against
> > > arbitrary repositories) is a bug, and shouldn't continue to be
> > > supported.
> >
> > All of those seem reasonable to me, and are what I would suggest if we
> > were starting from scratch. My only hesitation is whether people are
> > using the weird behavior of --object-dir in the wild (e.g., are bup
> > folks relying on it).
> >
> > Johannes, is this something you're using _now_, and it works, or
> > something you hoped to use in the future?
>
> I did some research[1] on what parts of `--object-dir` have worked (and not
> worked) in the past, and came to the conclusion that although this
> behavior is surprising, we do bear the responsibility of continuing to
> maintain it.

Hmm. Upon thinking on in more, here is some evidence to the contrary.
The new test, specifically this snippet:

    git init repo &&
    test_when_finished "rm -fr repo" &&
    (
      cd repo &&
      test_commit base &&
      git repack -d
    ) &&

    nongit git multi-pack-index --object-dir=$(pwd)/repo/.git/objects write

will fail with GIT_TEST_DEFAULT_HASH=sha256, since the MIDX internals
settle on the hash size via `the_hash_algo` which doesn't respect the
hash algorithm used by the target repository.

And that seems like it never could have worked. Try this at your shell
to observe the failure:

    git init --object-format=sha256 repo &&
    git -C repo commit --allow-empty -m initial &&
    git -C repo repack -d &&

    git multi-pack-index write --object-dir=$(pwd)/repo/.git/objects

and get:

    error: wrong index v2 file size in
    /home/ttaylorr/repo/.git/objects/pack/pack-9f08dc78ae6f37407a5acad69e3fdf5a1887eb7da5c043a1ddedc56ea7160814.idx
    warning: failed to open pack-index
    '/home/ttaylorr/repo/.git/objects/pack/pack-9f08dc78ae6f37407a5acad69e3fdf5a1887eb7da5c043a1ddedc56ea7160814.idx'

since we're trying to open a sha256 index with the_hash_algo in
sha1-mode.

The question is do we consider this to be a bug in the existing behavior
that we should patch, or an indication that the feature shouldn't exist
in the first place?

I think that I tend to agree more with the latter, so I'm inclined to
drop support for it (where "it" is running the midx command outside of a
repository) in this series (i.e., by making the midx builtin have the
RUN_SETUP flag instead of RUN_SETUP_GENTLY).

Thoughts?

Thanks,
Taylor
