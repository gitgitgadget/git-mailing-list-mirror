Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7B0C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CB22071C
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="TUBpYpiX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="itWgXyGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgCLEB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:01:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49575 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbgCLEB7 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 00:01:59 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3FEDB21F82
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:01:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 12 Mar 2020 00:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=Te4UXHgC9dIPInzEB7ZOlNx4FU8RT0X/quSr+3cOFGU=; b=TUBpYpiXP557
        e9BWpcgTPTcgu7q/Pk/JfO6c3MohtLc31aqCVYcqDXFXtpmOB6n8Mgn5v7Oz9PKh
        G8drXPGK/3zjcNuU513WpbyTa0YfKhw5FGrOwwgLpMLfsIxmhRjw4kGpRs7XqXB1
        uWjWD+ngR9LWNbxWnC/r9e45vgUD49s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Te4UXHgC9dIPInzEB7ZOlNx4FU8RT0X/quSr+3cOF
        GU=; b=itWgXyGq6ZTnbBHivACa/T83NIzhO6Wc8Ozq9dpxiDQkWmkgw11PsjCj5
        48Qhb5BM3qUii/D4MXEHFgJQa5nt0fLiHOSEZON5EXuUcudHOvsD2Nfqs5a2UEVl
        Tn8HwiKCsuX+t0ZAFdZkL3H6dwgDLhNt8sPN2AVgmigAoHANmgkNx9rj6/sip21I
        q8EO2X4OTNXvadGEnRh2GJ+6w4Hl0MC+yUmoj26QmbPVDsVD3a7OHr5fuWgm4w/A
        4ZcfNrvCaLbEiI2Wb5mB8LnK79ibmHFhdpIZDFA62kN+rSaQnEiaJWm2H3e26ALG
        663HJEoc63STxFq1cNDZAuVPeHwuQ==
X-ME-Sender: <xms:NrRpXvvXR4xLXywj9gGwLZEjrXwC65icrQkxW4Y8zfY97vmOZCEhsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:NrRpXuv9fm5GLi_UpUIcJYRs0pjlucVzPvM-kjKrJemQ5knZfZOwaQ>
    <xmx:NrRpXsGCJfq99kSyIwE9mPk2OlBpfr06I7N6HA440_ns0iVHRkkROQ>
    <xmx:NrRpXhPlQhR-Dz-l8_b0X0Ye1lf79xPy_vURu6cd6-f0Hgf2krL5ww>
    <xmx:NrRpXl5otja4iP9kt2UAn-PUItgLKonntyDqnOAUCDH6Dyq3O99yaw>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 62B153061363
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:01:57 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 6/17] GC strategies
Date:   Thu, 12 Mar 2020 15:01:54 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <B459AEB1-BF77-44C9-B06A-4B96C2E22287@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Jonathan N: Git has a flexible packfile format. Compared to CVS where 
things are stored as deltas against the next revision of the same file. 
GC can be a huge operation if it’s not done regularly. "git gc" makes 
one huge pack. Better amortized behavior to have multiple packs with 
exponentially increasing size and combine them when needed (Martin 
Dick's exproll).

2. Jonathan N: There are also unreachable objects to take care about. GC 
can/should delete them. But at the same time someone else might be 
creating history that still needs those objects. To give objects a grace 
period, we turn the unused objects into loose objects and look at the 
creation time. But alternatively there’s the proposal to move these 
unreachable objects into a packfile for all these objects. But this can 
be a problem for older git clients, because they might not know the pack 
is garbage and might move objects across packs. See the hash function 
transition doc for details.

3. Terry: JGit has these unreachable garbage packs

4. Peff: You want to solve this loose objects explosion problem?

5. Peff: what if you reference an object in the garbage pack from an 
object in a non-garbage pack?

6. Jonathan N: At GC time the object from the garbage pack is copied to 
a non-garbage pack. Basically rescue it from the garbage. It only saves 
the referenced objects, not the whole garbage pack.

7. Jonathan N: It has been running in production for >2 years.

8. Peff: There are so many non-atomic operations that can happen. And 
races can happen.

9. Jonathan N: If you find races, please comment on the JGit change that 
describes the algorithm. Happens-before relation and grace period.

10. `git gc --prune-now` should no longer create loose objects first, 
before just deleting them.
