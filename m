Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A274CC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6B920724
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="hbspiOvz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b5BLK0yO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgCLEA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:00:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34823 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgCLEA7 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 00:00:59 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4A3782219C
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:00:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 12 Mar 2020 00:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=2cMA3zPuoh4+rHXpso0biRcqBe8XHPXwJtDhHajLUWE=; b=hbspiOvz7wxz
        H+XMKonDESZtYxYWsi/YWT+rZZVcK5/okh/Jda/0RCjAS2xkPsnhj6UyA6V3fOC+
        XCY8bUyT6QXqnLfQ8RtPk16TF2TOzeJd2djTEhJ8lLMMjAIZTQZ7+IDhL/sXs1Ih
        hxbmaKGIpqj24yQ/NJk/Q45JX+OQhzk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=2cMA3zPuoh4+rHXpso0biRcqBe8XHPXwJtDhHajLU
        WE=; b=b5BLK0yO9AKKaGFfj4fKIBMWYjoMKbUnyQlOs5Y3h4vmR/J9Am0cFaiZK
        4NJC95uKhanPNzaGiNFDmsvJklu9+UnwnwZw1zt36BcHQdUTz6D0X2D5K7jVehWg
        hoCY575mka3VawysF2i5bsYOhZsQKUEx794HwPLS6D2HGIZcAn/NX0jPBORN1jHq
        rq7P9PkUbz9+npezWtqypPHrooWhmTAsAAIEjGGbMfFeSbXbbqu5GoVqjH7ReGaU
        lTWtQpcybUAOHuUfoGYWU5sGxJWwS9hJ8RNxSnRl6YRntt+ol0rNSyhx1sXrq093
        Q3XWhltMv2gwvOdBOGwNZ3ZOndm5Q==
X-ME-Sender: <xms:-rNpXms98tK6wqqfr7bWp7ROmIooXB8Tzn_TIh54Svfgs-Cg1kIJig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:-rNpXiXEV0e_Ckfy88R7lvEotD9ZQTRfVICVi4grsCmArx7Y9B_F4A>
    <xmx:-rNpXutCRS062BE4uB8Asq6jV8EsVb7aVsFICVhQp960debllymNWA>
    <xmx:-rNpXuWpE2llORJwEsLyX3WCuxxZIdmtF4YGXyKw6_zCJgMDYXyvWg>
    <xmx:-rNpXkZPLiHN1BN7udp5gOTmD5yOW5McN6gc2HD7_Fy4KaWzMvBV_g>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2EB6B328005A
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:00:56 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 5/17] Partial Clone
Date:   Thu, 12 Mar 2020 15:00:54 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <58425B78-7C6D-41CD-92AE-434D0A58F968@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Stolee: what is the status, who is deploying it, what issues need to 
be handled? Example, downloading tags. Hard to highly recommend it.

2. Taylor: we deployed it. No activity except for internal testing. Some 
more activity, but no crashes. Have been dragging our feet. Chicken egg, 
can’t deploy it because the client may not work, but hoping to hear 
about problems.

3. ZJ: dark launched for a mission critical repos. Internal questions 
from CI team, not sure about performance. Build farm hitting it hard 
with different filter specs.

4. Taylor: we have patches we are promising to the list. Blob none and 
limit, for now, but add them incrementally. Bitmap patches are on the 
list

5. James: I’ve been talking to customers who have high interest in 
this. But they are hesitant. Do people have similar situations, like 
shallow clones?

6. Jonathan N: we’re not using it en masse with server farms (see 
Terry’s stats). Performance issues with catchup, long periods of 
downloading and no progress. Missing progress display means a user waits 
and gets worried. On server side, reachability check can be expensive, 
in part because enumerating refs is expensive.

7. Peff: client experience sucks with N+1 situations. If the server 
operator side is tolerable, that way it’s easier to move the client 
side forward. By default, v2 just serves them up, no reachability check. 
Not sure if we’ll do that forever. Often have to inflate blobs that 
are deltas, and then delta compression which is not needed.

8. Stolee: Jonathan built a batch download when changing trees. Possible 
to improve by sending haves.

9. Jonathan N: if you’re in the blob none filter, and say I have a 
commit, I might not actually have what the server expects.

10. Peff: could enumerate blobs

12. Demetr: Partial clones are dangerous for DoS attacks

12. Jonathan: JGit forbids most filters that can't use bitmaps.

13. Peff: just blob filters? Yes, so far.

14. Jonathan: as far as the client experience goes, we’re not batching 
often enough and not showing progress on catch-up fetches. Any other UX 
issues?

15. Jeff: no, those two are what I meant.

16. James: another question for git service providers: Is it a 
replacement for LFS?

17. Brian: some files can compress, others don’t. Repacking can blow 
up if you try to compress something that can’t be compressed. How do 
we identify which objects we compress, and which we don’t.

18. Jonathan N: if you see something already compressed, tell zlib to do 
passthrough compression.

19. Taylor: two problems - which projects do you want to quarantine, 
where do you put them. CDN offloading would be nice.

20. Stolee: reachability bitmaps are tied to a single packfile. Becomes 
more and more expensive. Even just having them in another file requires 
a lot of work.

21. Taylor: we’re looking at some heuristics so that some parts of the 
pack can just be moved over verbatim.

22. Peff: I see three problems: multi pack lookups, bitmaps,

23. Jonathan N: we never generate on the fly deltas

24. Peff: there are pathological cases.

25. Terry: we are seeing 89k partial clones per day. Majority is clone. 
Shallow clone equivalent.

26. Peff: why? Is it better?

27. Jonathan N: initial clone is about the same as shallow. One reason 
we encourage, if you do a follow up, with shallow clone it is expensive 
for the server.

28. Stolee: if you persist the previous shallow clone, it is much much 
cheaper to do incremental fetch.

29. Terry: JGit has enough shallow clone bugs that we often just send 
everything. Make shallow clone obsolete

30. Jonathan N: Jenkins style CI, option for shallow clone. Want to run 
diff or git describe, have to turn it off. Partial clone is simpler.

31. Minh: could the server force the client to partial clone?

32. Brian: risks, working on an airplane. I don’t want to do any kind 
of fetch operation on poor connection. Could be good for CI, but don’t 
want to break things for humans.

33. Jonathan N: if I am going to get on an airplane, is there a way to 
fill it in the background. There are workarounds, like run `git show` 
which needs everything.

34. Elijah: I want to fetch a bunch more stuff, but don’t fetch 
anymore, throw an error rather than hanging.

35. Jonathan: filter blob:none is people's first experience of the 
feature. Make it a first class ui concept, present a user oriented UI 
like git sparse-checkout?

36. Taylor: It looks like it’s simple to use, but there’s a lot to 
do to actually use it. And Scalar is doing that for you.

37. James: Some of our customers would be interested to have a feature 
that pushes down configuration to all the users. It would give them LFS 
by default, without the end-users doing something.

38. Jonathan: We considered enabling a global config at Google. For 
example for 1+GB files.
