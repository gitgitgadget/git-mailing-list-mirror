Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3999EC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 21:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244331AbiHHVvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 17:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238812AbiHHVvq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 17:51:46 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5884E18380
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 14:51:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BC1D85C0132;
        Mon,  8 Aug 2022 17:51:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Aug 2022 17:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659995504; x=1660081904; bh=+Jypfe5BNB
        +O1x4ZfcIaXxQEONxoZtETn6DCHSotmQY=; b=mTZHkVJ27NAFefnLzzQ9Ppnym3
        hORHqTAkO2HCp7hM+QT1QwUiblttNcySH5oon93HRvRrM4YTRPcyNEhfjm1T5SO9
        al0khztb1meScOSUTK8zR6OI8Yf2tO1N/Ql/Rx1o2Nf6Va2zaqaz1NlRJKemxkTC
        dWLVjYw4Ckp7v3vigBRJPIoYnvYD03HfsO6UFAExbAfDLxZ4s4Xi4AeqAVHbRpfs
        LraBbzLKSyNyz//y68627hPU2bkoiffmlLuiUOi6Ju/JsbvfMiwsdmqYvcQu/zYl
        gQUFBxxhIK9VoZwausgL/wAb4j8zPU0WqiNffFW35HhYtmIVRBWOfA2KX8CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659995504; x=1660081904; bh=+Jypfe5BNB+O1x4ZfcIaXxQEONxo
        ZtETn6DCHSotmQY=; b=sr5sx9OlL6CcvtU+Hz30VfO68vU/tDcO4Dzbnvc5jN/O
        mSo/8TV+1Rmn/Bpj5KqpsSCxOwGM7YTdqcqBOjvDn749snlbWcumJbuJCw0vZVRn
        ztOjWzYhDOzMKOhR6eb8lAi0LUizTVhQbQu+jWebgb9+hMiquRSfXyAs808AJ6lG
        ENBKg9qEm3efq4CvdbyOWI5eFTjHQW3Wy6zYtoXeb8t1TMNqn+q1vblxiEYvlCcu
        vNvpypD/pb8OVt4sFIOJZvheCRq0YU7xThEdZjebAwPSpjPvciee0bbdRThWs/mW
        ZqYK2b50DZhCyU7Igibm7DSVyeiq/HZ7WWju3VhWow==
X-ME-Sender: <xms:cIXxYk9E2tAozZ4OzJ1DKFhnjqnUa7aaUr0-pAUidb6ZIESE65LiQQ>
    <xme:cIXxYssrGMnFJJtchoMDmq5fr6t1OZxbIhLW0E-ymD-QJ6pmQboE8IoQ6tH4-YdpR
    v6qdyzWNC7WDIdySQ>
X-ME-Received: <xmr:cIXxYqBfJ7dt9IiYPTk9pWohhXb_JBlmqM-p_pPaC4diBk-4ZTQqa4Lg-lvK-rLLGPgYwKRF-_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtjeenucfhrhhomhephfgvrhhn
    rghnughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrth
    htvghrnhepueehvdeuteefkefgvdevteeljeffgfekveekuddtkeeuleefueeltdegledt
    teefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:cIXxYkfjEIjgm5qgYcVmuQHBi9BJVOewI5GoMaL7-ppJXqdPy1wqWA>
    <xmx:cIXxYpNTGm_qUYjkiES-OWRu9jrfFG3F0tZekoZ2Afu3z7YPg6wJfw>
    <xmx:cIXxYulDtvvdlucHNp2Puu02t75CI4aQY3o_T9zP-K83rtWUrqgXvg>
    <xmx:cIXxYrXQ5GoJKFpypNBLn8h5E7V0wbeqYK1SWBvjl5olsqmJW-5vEQ>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 17:51:43 -0400 (EDT)
Date:   Mon, 8 Aug 2022 23:51:40 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mergetools: vimdiff: fix single tab mode, single
 window mode and colors
Message-ID: <YvGFbCZIhxoLlIzo@zacax395.localdomain>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
 <20220808053459.184367-1-greenfoo@u92.eu>
 <20220808053459.184367-3-greenfoo@u92.eu>
 <CAMP44s3v_4PdOfaviXCxik1LL5k_kkmZ2Yp=+Qfb8CqyNCdMUQ@mail.gmail.com>
 <YvFSgjK0P5kzoOfg@zacax395.localdomain>
 <CAMP44s1E6B4gG8nzNJwqAkYGQRns87i7iJFw=0yRadw2QL3-Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s1E6B4gG8nzNJwqAkYGQRns87i7iJFw=0yRadw2QL3-Ng@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/08 04:00PM, Felipe Contreras wrote:
> 
> No. That only happens in patch 9. In patch 5--which is where those two
> bugs are resolved--that problem doesn't exist yet.
> 

Sure. I was referring to your whole patch series (which is what I was testing)
not to a particular commit.

If I only apply some of your patches it is true that (1) is no longer an issue,
but we still have to deal with (2).


> Also, I'm pretty sure that's a bug in vim (of which there are many).
> 

In any case it doesn't happen with v3 :)


> >   2. It treats a single tab with a single window as a special case, when in
> >      fact it is just a subcase of a layout with many tabs where one of them
> >      contains just one window.
> >      The new patch series makes no distinction between them by keeping track
> >      of the number of windows opened on each tab which, as you noted, adds
> >      some extra complexity (but needed complexity nevertheless if we want to
> >      have highlighting enabled in all cases)
> 
> That's not necessarily true. You are assuming that is the only
> solution possible.

Only solution possible? Of course not! (I'm sorry if you got that impression)

I'm just presenting one solution that works, but I'm sure there are many others
(we could use "vim -d" in all cases or even implement a completely different
parsing logic).

Do you think we should try a different approach from the currently proposed one?


> Even supposing your solution was the only solution possible, nothing
> prevents us from applying your patch on top of mine. In git (and in
> many other endeavors) it behooves us to do one thing at a time for
> many reasons.
> 
> There's no reason to try to do two things at the same time. We can fix
> the specific case now (which is urgent and needed), and explore the
> generic case later on (which few people would care about anyway).
> 

You mean to apply your patch series and then apply mine? Sure, why not? But what
do get get from that? (I'm just curious)

I mean... v3 already works in all cases, right? Or am I missing something?


> For the generic case, I took a look at your solution and noticed most
> of the complexity comes from trying to guess the number of windows per
> tab. There is no need to do that.
> 
> I experimented with doing "bufdo diffthis" even in cases with multiple
> windows *before* doing anything else, and it works. There's no need to
> do "bufdo diffthis" afterwards, and there's no need for "windo
> diffthis" either. There's also no need to store the current buffer in
> a variable.
> 
> It *also* has the added benefit that now multi-window tabs now show
> the diff colors for all the buffers, not just the visible ones (which
> is what I would have expected anyway).
> 

Oh! Ok, now I see where the confusion comes from: showing the diff colors only
for the visible buffers is *a desired property* from the original design and not
something we want to avoid (except for the case where there is just one window,
which is what we are fixing now).

This is actually why all of this work started: we want to see, in one tab, only
differences between BASE and LOCAL and, in another tab, only differences between
BASE and REMOTE *without extra diff noise*.

If we enable ":bufdo diffthis" in those tabs we get a mess (at least for complex
merges).

Imagine this:

  - Tab #1: classical four windows layout (LOCAL, BASE, REMOTE on top and MERGED
    on the bottom).

  - Tab #2: two windows: left BASE, right REMOTE

  - Tab #3: two windows: left BASE, right LOCAL

We already see all highgliting and colors in the 4-way diff in tab #1, but we
are only interested in the sepecific BASE vs REMOTE and BASE vs LOCAL in tabs #2
and #3.


> > I would go as far as saying they are the same :)
> 
> That's actually my point. You copied one of my fixes without
> mentioning it. Not only is it not nice to copy code without
> attribution, 
>

You must excuse me here... I still find it extremely confusing to figure out
which field to use for attribution each time.

I added you to the "CC:" footer of the commit. Is this not the right procedure? 
Should I have done something different?


> ...it's not a good practice to sneak in unrelated changes.

Should we split the patch series in more commits, then?
Something like this?

  1. Comment fix
  2. Keep track of windows opened per tab
  3. Update generated string
  4. Add "set" options
  5. Update unit tests

I mean... I'm right with that sure :) Note, however that 2, 3 and 4 are closely
related (ie. "vimdiff3" won't work until the 3 of them are merged)


