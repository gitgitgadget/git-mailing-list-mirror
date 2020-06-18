Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77269C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 01:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F092224A
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 01:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkcnG2ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733299AbgFRB7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731250AbgFRB7l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 21:59:41 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C808CC06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 18:59:39 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k4so3678314oik.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 18:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wADNfv2JLnSUumDML1FSuCn9CwhzM1O0ix80Uus0ELc=;
        b=ZkcnG2tst6UHpc/Uypun28aWwAij8vqSV4g2p8slgY9XfyScU3vdnSYVXX3ndLoQOl
         09cBDnxrilhKzh8Cva8aQRQZaL+0a+/8mH4u4smWQUP178vMWI9/xQXOSXFIB6lhHx+u
         9NiQu7ilAF/hYY5qSlZ6q39mqxliDOXOPZDYbjAZhG8BlK26XRvvP/ASpe9SS3D8t0aM
         SCqG5zCykRDdh081+Yy69VfiGpja7QUTM0dHayue67HUNOC7k1TUCd2XL23dfBsqtUdO
         dhNNWcFu752jgTuHBCRzRp/gjGzG3c5tY9y+WUa4rY7RUskDnhj14bzRpWWp7Bz9Stsy
         JYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wADNfv2JLnSUumDML1FSuCn9CwhzM1O0ix80Uus0ELc=;
        b=Ur73Xt2ofLdAV8iIfxdrXWi54eW0W/qYMfJeXTNd5RcBoE4XHGbnYpgOXIk6vhaWEr
         PVJUOYlFWHTnjfrWXpKrh5mCSxh737VUq8JCrCMmIJv+wgcpSgeVw8vvM7WnfO4uLGUv
         izwriUCFh1O5cAJEhoSljpabpuRFyCNfQQPUDxIf6yrrVfRf1aEjdeBaPuP3XhX4Ve2T
         TPX0SV4sEuM4TgWpO9BWOlVMag5Dxr7cQCkOQY/KjBhoJDF6uL/0jjADviG3EEd0azj3
         KooxyFCIpdy3SyvQCOsy5KLqOxrzISGYcxCibzdDvmZA+BO17ijy17ivk+dqwyPKDaNS
         VALA==
X-Gm-Message-State: AOAM532KhqcfYOzgVGzzQe8nkX9PfCJNm7BAd64AVTbEfMUR9Eix93Y3
        7EvgZY5ycEOJeruOczXuTbS/UYcCgwjQXX/Yv2c=
X-Google-Smtp-Source: ABdhPJx4Cm18wsL+9zbXh/4NZvuHaCReA7cyiPZ+gTWLla+4MAcSydxbv5Hi4kcHYSpMSP3pdWCZ0oQAD61Et7dTMVM=
X-Received: by 2002:aca:6287:: with SMTP id w129mr1290791oib.167.1592445578515;
 Wed, 17 Jun 2020 18:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
 <CABPp-BET86K_N5_W1pXMWeFccbUdxU8+vNvi+m-i6PX0MrXknw@mail.gmail.com> <64d477b6-7bf2-fa0d-b9b4-821285af386e@gmail.com>
In-Reply-To: <64d477b6-7bf2-fa0d-b9b4-821285af386e@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Jun 2020 18:59:27 -0700
Message-ID: <CABPp-BFDcM+QSx_YSAAazkN9AoTPWVYV+ZpSQBPTihVM=gP-qw@mail.gmail.com>
Subject: Re: [PATCH 00/10] [RFC] In-tree sparse-checkout definitions
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 17, 2020 at 6:42 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/17/2020 7:14 PM, Elijah Newren wrote:
> > Hi,
> >
> > Another late addition...
> >
> > On Thu, May 7, 2020 at 6:20 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >
> >> IN-TREE SPARSE-CHECKOUT DEFINITIONS
> >> ===================================
> >>
> >> Minh's idea was simple: have sparse-checkout files in the working directory
> >> and use config to point to them. As these in-tree files update, we can
> >> automatically update the sparse-checkout definition accordingly. Now, the
> >> only thing to do would be to ensure that the sparse-checkout files are
> >> updated when someone updates the build definitions. This requires some extra
> >> build validation, but would not require special tools built on every client.
> >
> > "In-tree" still bugs me after a few weeks; the wording seems slightly
> > awkward.  I don't have a good suggestion, but I'm curious if there's a
> > better term.
>
> I am open to suggestions. It reminds me of the two hardest problems
> in software engineering:
>
>         1. concurrency
>         2. naming things
>         3. off-by-one errors

:-)

> > But I really came here to comment on another issue I think I glossed
> > over the first time around.  I'm curious if all module definition
> > files have to exist in the working directory, as possibly suggested
> > above, or if we can allow them to just exist in the index.  To give
> > you a flavor for what I mean, with my sparsify tool people can do
> > things like:
> >     ./sparsify --modules MODULE_A
> > which provides MODULE_A and it's dependencies while removing all other
> > directories.  If MODULE_B, is not a dependency (direct or transitive)
> > of MODULE_A, it will not exist in the working directory after this
> > step.  Our equivalent of the "in-tree" definition of MODULE_B exists
> > *in* the directory for MODULE_B, because it seems to make sense for
> > us.  I want people to be able to do
> >     ./sparsify --modules MODULE_B
> > and have it correctly check out all the necessary files even though
> > the definition of MODULE_B wasn't even in the working directory at the
> > time the command ran.  (The sparsify script knows to check the working
> > directory first, then fall back to the index).
>
> I think one tricky part of my RFC is that it _only_ looks at the
> index. This allows us to read the contents even when the files are
> not part of the current sparse-checkout definition.
>
> You mentioned in another thread that it is a bit unwieldy for a user
> to rely on a committed (or staged?) file, so adding the ability to
> check the working directory first is interesting. I wonder how the
> timing comes into play when changing HEAD to a new commit? Seems
> tricky, but solvable.

Isn't that essentially the same timing issue that comes into play if
you only look at the index, and are changing HEAD to a new commit?
