Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E540EC35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 20:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32FC217BA
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 20:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kaarsemaker-net.20150623.gappssmtp.com header.i=@kaarsemaker-net.20150623.gappssmtp.com header.b="KnEfth5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBEUYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:24:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56280 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgBEUYI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 15:24:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so3884990wmj.5
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 12:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jb7fXrWbOJAV385B77WPbmmAwe6C+OFE3l70jUMxlRo=;
        b=KnEfth5B9ZKoOojm8qiM5fxbjsix45Z/Cpik82FAvJ4QjUxUwBPHOS5OjYB5cQM7Oh
         QAfQ+0ijR13Xy6gxyb7hvWTU4nafZWNMDZpBWR/MFZ7yWEaAYZ1P9LRY1/uaL8iq9DDh
         RJFz34mB8y8Yel8czuorADGT6L8p9m1rXbOwR2EuaZ2HMwZiK+NsXLFYIN3AoOxRWvQt
         Dv2JUVFKtzIiwkhK3v95CTs+EZgp7e4YYTqXc2oV//6S3PUBpitKn30V1sIGvf6X5CVV
         02b9Ueo0Hd0qE5gSvd8oDqGS44+cfnZmMocLcExbxAi1hmsJoVGfh6shN72CtMQ3bFA6
         Oljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jb7fXrWbOJAV385B77WPbmmAwe6C+OFE3l70jUMxlRo=;
        b=V/t+6ugXBjSZHSgSBId9k16Vq9slYeXKr38uMtU2JJD/LwhM8ahwDU7Se7CqTj8jLi
         LHxjZw09edx/ybPltRytCmlSClMeG6HaGP8leqravISc3176Tu+5gA7eNwdORtjeu3ue
         k+23iels463b03eabTEZdXSnyRply+KhdMQaFzIXdTuLAnG4hqEIUosx6mJPSWjyduh8
         vGB+cDCZT2Uj7TZvQIcx9SRD9GDHwWfZGvV2ZuyBWPalFkIxmP70bG2HvnFbta4+PvKk
         9SSusFVxxCHBU5TTt5hIWdIT+l1rPmdNFQK3LW7Marq8lvI2lc43z8FZ8Fn9s3FSuU5E
         tFWA==
X-Gm-Message-State: APjAAAXsLSF70JcTTa9PVs+97r8OerPiQQNLkbQpzYl1FsWZ2ldkNYWe
        j7VVDtizy6sl9+bNJ3/bhmkv7qlYutfR
X-Google-Smtp-Source: APXvYqzh586BGR6Y9PQmVpT5e+SX3GIj3jF4puQyw1NCdXYaww7GyjIjU09KQ5U0IFctxotnxohmdw==
X-Received: by 2002:a1c:7919:: with SMTP id l25mr7316596wme.135.1580934246387;
        Wed, 05 Feb 2020 12:24:06 -0800 (PST)
Received: from starfire (4dafbc34.ftth.telfortglasvezel.nl. [77.175.188.52])
        by smtp.gmail.com with ESMTPSA id r1sm1211821wrx.11.2020.02.05.12.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 12:24:05 -0800 (PST)
Message-ID: <8575e5067f7506992cc61ceb3b4185ab9c6f3d57.camel@kaarsemaker.net>
Subject: Re: [PATCH] restore: invalidate cache-tree when removing entries
 with --staged
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Jeff King <peff@peff.net>, Torsten Krah <krah.tm@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Wed, 05 Feb 2020 21:24:04 +0100
In-Reply-To: <20200108114344.GA3380580@coredump.intra.peff.net>
References: <07c84224bb0b093ab3770be9b5ab2ec23ce2d31a.camel@gmail.com>
         <234df85965f8a685be5e563fe795ed477f359d7c.camel@gmail.com>
         <f0638fc0d09c213b661d2b244d3457f362daebe0.camel@gmail.com>
         <20200108091119.GB87523@coredump.intra.peff.net>
         <2423f8c0b91578c0faf7527b7d97b0e1e9666261.camel@gmail.com>
         <20200108104008.GA2207365@coredump.intra.peff.net>
         <20200108114344.GA3380580@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2020-01-08 at 06:43 -0500, Jeff King wrote:
> On Wed, Jan 08, 2020 at 05:40:08AM -0500, Jeff King wrote:
> 
> > So there seem to be at least two bugs:
> > 
> >  - git-restore doesn't properly invalidate the cache-tree
> > 
> >  - the index-reading code is not careful enough about bogus cache-trees,
> >    and may segfault
> 
> Here's a fix for the first one. I'm adding Junio to the cc as an expert
> in index and cache-tree issues. I'm pretty sure this is the correct fix,
> but I have some lingering questions below.
> 
> I'm not planning on working on the second one immediately. Between this
> and Emily's patch from yesterday, I have a feeling that the index code
> could use an audit to be a bit more careful about handling bogus on-disk
> data.

We just ran into something similar where git would create really bogus
commits when mixing squash merges and restore. As it's a private repo,
I don't have an exact recipe for reproducing it, but it roughly goes
like:

git checkout master
git merge --squash branch-for-which-we-want-to-redo-commits
git restore --staged .
git add file1 file2 file3
git commit -m "commit"

This commit would remove a file4 that wasn't even touched in the branch
(further commits would do even more broken things, eventually leading
to broken commit objects with duplicate file contents). Changing `git
restore --staged .` to `git reset HEAD` made this behaviour go away. A
quick search in the list brought this patch and I'm happy to say it
fixes our issue as well.

Thanks Peff!

D.

