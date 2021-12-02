Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C50C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 03:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhLBDI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 22:08:28 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55295 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355178AbhLBDIW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Dec 2021 22:08:22 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4C10C3201DA8
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 22:05:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 01 Dec 2021 22:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcclimon.org; h=
        date:from:to:subject:message-id:mime-version:content-type; s=
        fm3; bh=rHHPddXm9U9bb6vT9HFtEcpmmss3fyPMV+ipTld8X2M=; b=XOQ3aWRN
        eynMw9JH3megNPuFUP96W112FQ7onXjBn7suBOk4Sk/wjQy9tsdBse4R0a3e0qrW
        uDfX3hQRDIKPv8pDL/lpH7TG6JUJA5tsJOK6lCP3rVqvjzzNp8daUVL5F0ggcoRb
        X9tpXRFBKroLYlSH17ViDJD16qP4bVfjaGuCjvrzOQjOYvElyloGXmGCNTvC5m7V
        xHSVjhkZYFoItw5oz7ap8y62Bnz847p2eZpjDBKIKIb5LVUpgR2pHdLOIKoy9cgC
        BWeyjbaqkTsUEwTD+mP1hP8Z9KMD0JjS3ZIUgSi1HqlVwvrhSswSsvB3YDplbqGD
        PFX1J5c8E0FJ4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=rHHPddXm9U9bb6vT9HFtEcpmmss3f
        yPMV+ipTld8X2M=; b=iu8aUVNiBbQxQEtyw+qJnaSrR2w6P49j9PCcM8vWHVsLR
        1+MpJaoBkWYvqdtCZR/jUAmlo90UPlEag5U3qgn+r+Zyk1qso6usDc8BjVhxn09y
        E1KcNdSPCRq3RLroNAXgUg4rDdzSTN8k7bRseitY6BLnu9uxpMslB/wGhvnyE7hQ
        13iThRYEC3VcJoNrN4ZdHzAcbBg1rsnpe/UmBYOkrsedBTuq2v4g/rZglTfNpcJ3
        dhsC6Jpm+x9QhDUoNpFCXyGpvshUtszHhrZkELbnzW9yaRpH/61zevk+EwV/U95q
        ptHh5byyfdKrgMZ3lz2G5si2O1KuxN5OnKAYQFyTQ==
X-ME-Sender: <xms:2zeoYV7VI2LbyMiBvEguCfJfdsYuXATjaaSNmSOE3QMo0Lp96O4VAg>
    <xme:2zeoYS5pknnw_ThIEQn71QZNuRqcKhd3huaON-G7BayIDjDwcZcO9iCcAnS2zr18u
    y0lfbRFUgzBhqYhckE>
X-ME-Received: <xmr:2zeoYcd0nh-qA2OO_a-j7Ivgj3I6jMbuNNaLxqmP0ePzxgbTwlJEPfgYaZ4cuov2z7NJuPpsHOHU8rCNO3hmdzrvoMos0a99xnZsGjhXEnaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieeggdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehttdertddttd
    dvnecuhfhrohhmpefoihgthhgrvghlucfotgevlhhimhhonhcuoehmihgthhgrvghlsehm
    tggtlhhimhhonhdrohhrgheqnecuggftrfgrthhtvghrnhepgffhhfdtgfdtteffveekje
    dtkedukeffgeegteefudelffeiuefggffgffehueejnecuffhomhgrihhnpehgihhthhhu
    sgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmihgthhgrvghlsehmtggtlhhimhhonhdrohhrgh
X-ME-Proxy: <xmx:2zeoYeLuuVFhXsamZbsFz0o8ds0asQ0NTy16aVrjC_mqBZG8vtWTYg>
    <xmx:2zeoYZKGZUnboAYbJ2WfFIIBEvz-rutxTm8hbssp0MgQRuuH0oLLdg>
    <xmx:2zeoYXwUoKJ9OD5Kc8o_9j0XOvydgc-XIVz_bskiNaH4rSz0Z88Puw>
    <xmx:2zeoYclTndBHlHO3tdIsdVbu2QWX0viaUuNPTNelKkGtfkZLYmZFEA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 1 Dec 2021 22:04:59 -0500 (EST)
Date:   Wed, 1 Dec 2021 22:04:58 -0500
From:   Michael McClimon <michael@mcclimon.org>
To:     git@vger.kernel.org
Subject: Potential bug with octopus merges and symlinks
Message-ID: <20211202030458.GA48278@newk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am having a problem with octopus merges when symbolic links are involved.
I'm not completely convinced this is a bug in git, but I'm also not convinced
that it's _not_. (If it's not, my apologies; I often find it very hard to
track down the answers to complicated git questions on the internet.)

There is a minimal reproducer available at
https://github.com/mmcclimon/git-merge-problem-demo. Fetch all the branches
there. The main branch contains a directory (dir1) with a single file
(file.txt), plus a symlink (dir2), which links to dir1. branch1 replaces this
symlink with a copy of the files that were linked to. (This was accomplished
with: rm dir2; cp -r dir1 dir2.) branch2 and branch3 do not touch this
directory at all.

Merging these three branches fails:

$ git merge branch1 branch2 branch3
Fast-forwarding to: branch1
Trying simple merge with branch2
Simple merge did not work, trying automatic merge.
Trying simple merge with branch3
error: Entry 'dir2/file.txt' not uptodate. Cannot merge.
Merge with strategy octopus failed.

The order here matters! Here is every permutation (1 here is the symlink
change) to git merge; only the first two fail, all the others work.

1 2 3   FAIL
1 3 2   FAIL
2 1 3   PASS
2 3 1   PASS
3 1 2   PASS
3 2 1   PASS
1 2     PASS
2 1     PASS
2 3     PASS
3 2     PASS
1 3     PASS
3 1     PASS

I tracked this down as best I could (I am not a C programmer), by adding 
`set -x` to my copy of git-octopus-merge.sh. I determined that the line is
failing is toward the very bottom of the main loop there: 
    git read-tree -u -m --aggressive  $common $MRT $SHA1

I had a read of the index-format.txt and then the git read-tree docs, and I
confess that I don't _totally_ follow the latter. But, I wonder if maybe
--aggressive is perhaps not aggressive enough if the parts of the index that
store symbolic link data aren't taken into account, when it's changed between
two versions and the blobs involved aren't actually different.

I recognize that replacing a symlink with real files under the same name is a
weird thing to do, but this is a pared-down example of a thing that happens
occasionally at $work, where we regularly octopus-merge 15+ heads into
development branches. I would also be happy to know, if this isn't a bug, if
there's some other workaround! The only way I know to fix this case is to
merge the symlink change, then rebase all in-flight branches against it. That
is often extremely time-consuming and tedious, though, and requires a human to
be involved (all the other merging is done by CI.)

Thanks!
Michael


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.6.0 Darwin Kernel Version 20.6.0: Wed Jun 23 00:26:31 PDT 2021; root:xnu-7195.141.2~5/RELEASE_X86_64 x86_64
compiler info: clang: 13.0.0 (clang-1300.0.29.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]


-- 
Michael McClimon
michael@mcclimon.org

