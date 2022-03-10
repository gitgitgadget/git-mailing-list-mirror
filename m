Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80721C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 16:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiCJQRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 11:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbiCJQRX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 11:17:23 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36314192CA9
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 08:16:16 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6509D5C01A6
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 11:16:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 10 Mar 2022 11:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcclimon.org; h=
        cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; bh=E
        DwtiFYZIUFGU3zyns7ujihmRYcWt6X7yrl/KRVHcJI=; b=rQLmODGdArFubn/1+
        PtB6+b+fioE7ZggdyqsbgCh6KYRIQ58dW6rk19dslJyFMa3ucddaL0AcitDSoSpW
        TF5AkSund9+V0p0lNHRq/vVZlX45fkK2FzIX+JbAb9mFHdnD22N8/vqVRjwc/0u2
        wm9g9hpTfVy1RIaGOb/EMVxXrEjncoRpOOmnMq9vW/ZryjL1RN86iQwrGzYnPuAC
        itNwRObOYy+QKenTFZPw8vX656xexWNEmipU8OjWQz2RliZp1lkApeXYtvJYqAfa
        RG+NggfI4xkOCHF7KQPi8Gg4VDSuYUypgBoM+knb8jXieET8OGDE8pVGP9VAyB03
        VIohQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=EDwtiFYZIUFGU3zyns7ujihmRYcWt6X7yrl/KRVHc
        JI=; b=EL1eB439akeQqNyda8TPcNXEEV4C1EMnUUlh4JSF5jcyN631tZu+48Hmq
        4gZhi/VReyLPSPqkhdGRaBUDSYRRTVp5OJzU2aOHgKDWe1CT3J2mI87ivJ77IQ2j
        4BR3rGpdsjddy28LIkmUBqdrE112qqrM3tXmJhbPdKqIh5ShtlJ8Tj47tYotTDnm
        JSmuq71Yk+MzT+M0WD3K4prC+P3P+JxM4GxUwxxTslW4S3s25vRuwVlSfNcQz1db
        /75p/Z3ebh6oc2P1NfY52n8qb/pK2vyicBbnVtt4kWLxOCHo8Vhy6mu7VTstt9rC
        pvrClQI1+KbsUDMABbBhcFl04G9qA==
X-ME-Sender: <xms:TyQqYg2EcCF2y8htCls9pIyCaOzVK4ph09eBZwzrEUxobt1xW9Bpkw>
    <xme:TyQqYrEDfp0QuKPWjtOW_HmwsV34AtoYFRe0A7OVZc322DcvfZwLmDP9rH8JrOQvq
    imEX3rMJd2To1vKLoE>
X-ME-Received: <xmr:TyQqYo7whCIk-PUq8i8Cqaf39x1LNPqRX1foNPH1jfeEG3w4NujVg7ECeco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvtddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttd
    dtvdenucfhrhhomhepofhitghhrggvlhcuofgtvehlihhmohhnuceomhhitghhrggvlhes
    mhgttghlihhmohhnrdhorhhgqeenucggtffrrghtthgvrhhnpeefgeektedtgeffteeitd
    duudejvdeileeggeethfdttdeghedvkedttdegudfhueenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmihgthhgrvghlsehmtggtlhhimhhonh
    drohhrgh
X-ME-Proxy: <xmx:TyQqYp1shU40jn7xIGizhqPwrdXqKKBqIhif0v5LV1lJIXkpnUsBdg>
    <xmx:TyQqYjERZNHTsBV04WOX9Q19Cchy_seYpPHunZ9k3VtefoJfFCYkDg>
    <xmx:TyQqYi_0H-fUen5pZ0jdcEKuLxQogQYzpMcfIBD5UNxSs9D62CkKBA>
    <xmx:TyQqYqyb4niHtUoTddLVHvDdH9M6oLO-n1oeBTgeaih1wZ3_vXivtA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 10 Mar 2022 11:16:15 -0500 (EST)
Date:   Thu, 10 Mar 2022 11:16:14 -0500
From:   Michael McClimon <michael@mcclimon.org>
To:     git@vger.kernel.org
Subject: Bug with rebase and commit hashes
Message-ID: <YiokTm3GxIZQQUow@newk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have run into a bug with rebase when operating with commit hashes directly
(rather than branch names).

Say that I have two branches, main and topic. Branch topic consists of a
single commit whose parent is main. If I'm on main, and I run
'git rebase main topic', I end up on branch topic, as expected (my prompt here
displays the current branch):

[~/scratch on main] $ git rebase main topic
Successfully rebased and updated refs/heads/topic.
[~/scratch on topic] $


If I do exactly the same thing, but substitute the commit shas for those
branches, git _doesn't_ leave me on branch topic, but instead fast-forwards
main to topic. This is very surprising to me!

[~/scratch on main] $ git rev-parse main
464adc6a6f8aa0a943dbf886df1eb6497f70f6e6
[~/scratch on main] $ git rev-parse topic
c3c862105dfbb2f30137a0875e8e5d9dfec334f8
[~/scratch on main] $ git rebase $(git rev-parse main) $(git rev-parse topic)
Current branch c3c862105dfbb2f30137a0875e8e5d9dfec334f8 is up to date.
[~/scratch on main] $ git rev-parse main
c3c862105dfbb2f30137a0875e8e5d9dfec334f8


Part of the reason this is surprising is that in the case when topic is not a
fast-forward from main (i.e., does need to be rebased), git does what I'd
expect, and leaves me detached on the newly rebased head.

[~/scratch on main] $ git rev-parse main
464adc6a6f8aa0a943dbf886df1eb6497f70f6e6
[~/scratch on main] $ git rev-parse topic
8d7d712bad0c32cd87aa814730317178b2e46b93
[~/scratch on main] $ git rebase $(git rev-parse main) $(git rev-parse topic)
Successfully rebased and updated detached HEAD.
[~/scratch at 1477bc43] $ git rev-parse HEAD
1477bc43a3bc7868ba1da8a919a60432bedbd34a


I ran into this because I was writing some software to enforce semilinear
history (all commits on main are merge commits, and the topic branches are all
rebased on main before merge). That workflow is: for every branch,
rebase $main_sha $topic_sha, then checkout main and merge --no-ff $topic_sha.
Because of this bug, when we got to the merge --no-ff, git didn't do anything
at all, because it had already fast-forwarded main! I worked around this in
my program by just passing --force-rebase to my rebase invocation, which fixes
this particular problem by leaving me in a detached head (as in the last case
above).

I hit this in production on git 2.30.2 (debian bullseye), but reproduced
locally using the latest git main, which is git version 2.35.1.415.gc2162907.
In both cases I wiped my user gitconfig, so I'm using only the defaults. (If
it helps: with my rebase.autosquash = true, the bad case above does not behave
badly and leaves me in detached head as I'd expect.) It's totally possible
this isn't _meant_ to work, in which case I think the docs could use an
update.

Thanks!

-- 
Michael McClimon
michael@mcclimon.org

