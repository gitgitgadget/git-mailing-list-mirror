Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86392ECAAA1
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 20:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJaUwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 16:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJaUwA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 16:52:00 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307991035
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:52:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 565D55C00D8
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 16:51:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 31 Oct 2022 16:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667249519; x=
        1667335919; bh=kUQhcYJLOoUlQ8QZafqKSPeah7Hf4KKdKc1RNHTtfmg=; b=Y
        Xs8LilCbGngPr9lfrriJ8ty1/2RXhMtPvpEe85FPjZt01BNJgSKe2Y+WiGcemSZr
        /HxDTVJGRUHghsyxLXTZ6bL25UynR7MliV1zMH9e1km/j5JUT3kpQ1l+6B5d0NWT
        Wc2uHv2T1Oj+2SZgClaNmVGwow1IuF11yQiGJ7JIe+Jz0q01MWdviCs5FlxI/LZD
        XQ2er/52tRELwG68LsNc+r4cyXVMbPlGfYSTVrnWj/SmCTm8LF4pm7Li3TcdTjaK
        ft/Ua4ozioTYiicPJ/d4A4G8QhBSaww8VHxI29vRWWi7yRL1xpqk4kv9s0hhwqkB
        MENFBCYHQVIKTChWw6gyw==
X-ME-Sender: <xms:bjVgY9PN5Ds7ONxNoQbfJKSEvhJ0K1KwK5O8NbcAZZTh_84_aGHorQ>
    <xme:bjVgY_9Q0REVXJQUvEEr-tlItvYY5i4RjUOy2xsV4-NcYeeXKfCMk4iswLosaqqcn
    I_NGJKcAf8b30e8>
X-ME-Received: <xmr:bjVgY8TuWGnPu8c6bQzvv4I7AaDoO5LQijqF0CjpM5QVLuE5e3fYwLZM9wm6CFh5G_dzUpXOU7UStT7UoaB_MXNVqQQkpBrUJYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudefgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtuggfsehttdertd
    dtredvnecuhfhrohhmpedflfdrucfrrghulhcutfgvvggufdcuoehprhgvvggusehsihhg
    khhilhhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtfeelueevffelffehfeetkeeihe
    fhgeefgeetuddviefhgffggfekiefhtefgjeenucffohhmrghinhepjhhprghulhhrvggv
    ugdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehprhgvvggusehsihhgkhhilhhlrdgtohhm
X-ME-Proxy: <xmx:bzVgY5st9Rq7_lVX908Vex8Q9-7sMTKePOV7v42VBiEgx6HYd7BHIA>
    <xmx:bzVgY1dxhXIMiEErx8fwTu7miLZortNkucF-nAfsVRqLiL7NNhJ2qw>
    <xmx:bzVgY10IwBVeriWDazXioaIQwNTHFhHl5FnGYamMz1yyB9jFc8vG-w>
    <xmx:bzVgY2qy9su4S-5sMNw0QXgNvjGw-bnb8bUhrIZkdjJ6pMYhgunfEQ>
Feedback-ID: i4ce04002:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Oct 2022 16:51:58 -0400 (EDT)
Date:   Mon, 31 Oct 2022 13:51:57 -0700
From:   "J. Paul Reed" <preed@sigkill.com>
To:     git@vger.kernel.org
Subject: Odd git-config behavior
Message-ID: <Y2A1bdiw6kGC65f/@sigkill.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.3 (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hey all,

I recently ran into interesting behavior with git-config (which I
originally thought was a bug).

I was converting repos from the deprecated core.fsyncObjectFiles to the new
core.fsync option suite; I wrote some automation to do that, using
"git config -l" to detect previously-converted repos.

But then some weekly repo maintenance automation complained about the
deprecated fsync option being present in some of the repo configs, even
though I thought those repos had been converted to the new settings.

I did some digging, and it turns out that "git config -l" was reporting
nothing (no output) in Git 2.37.4. I did some testing, and found that Git
2.35.1 correctly reporting the repo's config settings.

Interestingly, the maintenance automation runs fsck and some other things,
and reports the presence of the deprecated fsync setting (which is what
made me notice); so that code path does read the config and run (and
complain about the presence of deprecated settings).

I did a git bisect between 2.35.1 and 2.37.4, and it looks like the
following commit changes the behavior:

8959555cee7ec045958f9b6dd62e541affb7e7d9 is the first bad commit
commit 8959555cee7ec045958f9b6dd62e541affb7e7d9
Author: Johannes Schindelin <johannes.schindelin@gmx.de>
Date:   Wed Mar 2 12:23:04 2022 +0100

    setup_git_directory(): add an owner check for the top-level directory
    
    It poses a security risk to search for a git directory outside of the
    directories owned by the current user.

    [full commit message clipped]

So... my maintenance automation runs as root, and the repo directories are
uid/gid'd someone else (though, the config file inside the [bare] repo
happens to be owned by root)... so I suppose what I'm observing is expected
behavior?

I guess this leaves me with two questions:

    1. Why does "git config" refuse to run due to this security check, but
       other git commands ("git fsck," at least) run?

    2. I think it might be useful to warn the user that the behavior they're
       expecting isn't happening due to this security check, instead of just
       outputting objectively wrong information (i.e. that no config options
       exist when they actually do exist); I'd be curious what others think.

best,
preed
-- 
J. Paul Reed
https://jpaulreed.com
PGP: 0x41AA0EF1

