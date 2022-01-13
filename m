Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166F9C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 16:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiAMQ3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 11:29:55 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42549 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236705AbiAMQ3y (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jan 2022 11:29:54 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 377435C0163
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 11:29:53 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute1.internal (MEProxy); Thu, 13 Jan 2022 11:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mrkennedy.ca; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm1; bh=bpop8u4AtVsh7GHS4v75dvo3ezoWMTuJgzZfbctyS5Y=; b=dPtMQFEH
        UFH9CYZt/nTRtNBnqbjGWH1SZOJ4cxKZ2ivetekjIcdnpJtmbng6obvC7St7IMqP
        s+yMcslRtR/KupEKWyXWuhuPc0PQxZhuhTaZLrFp4ObnNOdFFxJ6sK5I7zWN5vNk
        vQpTjY+vEOpok0fpfSSG/nbwy7kahaeSJIyHzzZHrYLIXaeBURc67sBTFt/5OgNf
        sphy48vWCia6o7EQGsKKFrfaVp4H3Slc+5iJS/dUz+FGvlYFmjEOcTkpvSS9Vhf/
        o2uFxVvgA950x+FXv4OqE5bxtIVzW0w578+tA+PvNiahoX4n4I1eRHzQlPDDKnGC
        rpIRuQYcWjvdZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=bpop8u4AtVsh7GHS4v75dvo3ezoWM
        TuJgzZfbctyS5Y=; b=InLbAoaO4Gd74JL4gOncFKf2LLcQ9zMBr5F6Fws67IQyk
        RyGAZw4o316elRykzBOvhGEgyyt6zSHZPsI4ikWMM047ks/72idkKADhv6L3TyUh
        eWhN87N4lmaH9Zh++xco095QUUm0qCY8EiO4oMckJ28dQ3xqSJgqolKsorubcFgz
        XKSrG9LtGQb+qTmE91DKYD9eu+S+g3hgz7lQ8lz5GeG2iSnCwpiv1DKfXim7dP3Y
        OCBy1pLKOz696JB73K2X3JErmR23V4EVgEPRyKCU4xb9FXLjeLPcoYZM8Qdk+AaO
        oNb6TdhMHr8jWUVUmMQ0CtYP6rbxMy1UIiAHhCIDw==
X-ME-Sender: <xms:gFPgYWBGgJhE_ebf35ubKu4wBSVdMJRbim3drIafbTRqrX9gCt20iQ>
    <xme:gFPgYQhTTpYNaNI8OaKzzWEPk5Swc7IV1F0bHL7uB6URg_4aNXXawhtgxwArEFP3T
    qIl_6fEpLAO_s4e1zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdefgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtredtre
    ertdenucfhrhhomhepfdevohhlihhnucfmvghnnhgvugihfdcuoegtohhlihhnsehmrhhk
    vghnnhgvugihrdgtrgeqnecuggftrfgrthhtvghrnhepfeegjedthfeihefftdevveelhf
    eutddvveevhfffhedvveffffevhfeigfejffeknecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheptgholhhinhesmhhrkhgvnhhnvgguhidrtggr
X-ME-Proxy: <xmx:gVPgYZnistAabxlnV0_Skrtqa42Q3Oof_jV1OG6LguNois61qOexWQ>
    <xmx:gVPgYUxdr2tNsSAzU_SOOQuD4zILpeZhutJNeLtwBaFGBvTqGJhu2w>
    <xmx:gVPgYbTF0I0Qyi8zMKWc8THHgfis_3G91sGxKLbDuscltIXakCNgbg>
    <xmx:gVPgYScdb6w8tAuqHz1UCYKqROC2wgqPd2vHTMGhfcGBhxSc7Dur8w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E06CBAC0E99; Thu, 13 Jan 2022 11:29:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <2a4f90e9-9abb-40b6-a6f3-a676567e4fc0@www.fastmail.com>
Date:   Thu, 13 Jan 2022 12:29:32 -0400
From:   "Colin Kennedy" <colin@mrkennedy.ca>
To:     git@vger.kernel.org
Subject: feature request: add [-f|--from <rootbranch>] to git stash branch
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Current syntax of git stash branch is:

branch <branchname> [<stash>]

Proposed syntax is:

branch <branchname> [-f|--from <rootbranch>] [<stash>]

the from flag specifies a branch from which the new branch should be derived.

Example usage:

git stash branch remove-commented-code --from main

This simplifies a workflow which is common for me. I am working N-commits deep in some feature branch when I discover a low hanging fruit. Dealing with this low hanging fruit is not appropriate for the current feature branch. It's most appropriate to deal with "directly" on a fresh branch from main. Because I am untidy, I often have a bit of mess in between my staging area, and unstaged changes, and this creates friction when I attempt to stash this low hanging fruit, pop back to main, create the new branch, pop the stashed low hanging fruit, etc etc.

The proposed flag gives a one-liner to apply stashed patches wherever, no matter your current location, which I think is an improvement.

Happy to have feedback on the flag. Happy for someone else to implement it. Also happy to consider taking a crack at it myself if it seems like something people would be happy to include. (NB: I haven't written or even read any c, or c++ for that matter, in probably 15 years. So, you know).

thanks,
Colin
