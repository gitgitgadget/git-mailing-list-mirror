Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210C23EAAD
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836367; cv=none; b=ewN0YgeP4DQew+AuLnzvBnaN+IW58HqUSib/PpQZ3Ri0GuSgLk+7nKwZIbrNHXvITxsE/xFIDP5/JaXNOweEGnSrkQ+Eq9wk3OM543jWz5+Khzx+FVBIxenTauP4/Hr5SGEJNUVIplQ7yZI3cMOglGAVuu3rZLLr8kZl6U6hIZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836367; c=relaxed/simple;
	bh=+h+oWwHfgUBC652a3Y/eJutn/b7GImjy9/ZYxa/WdsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK6m8FeAM/tMyiD+n4zGqdSPb++Fsx91jXVj5IXAd2qDzxeX9664J1dNg7JttC0KvtTu60dY3a+AViDgNhJm5QbpB0O6z3Nz+ZDxKL4vUidRcZVhyqvD0iO55hxAcedCrfqNO4ne4gkHT5szEGaPk3Qv9R7DGC18pZbInRgpblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hDHqAZ9D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m5UirYYy; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hDHqAZ9D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m5UirYYy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 382DDEC05D3;
	Mon, 23 Feb 2026 03:46:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 03:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771836365; x=1771922765; bh=jbW121JQpv
	UP8aylqr3sgIT4/7AA9/cl6tLeE7xlkA4=; b=hDHqAZ9DkDG6YyfA5/mifsbWOv
	KnWQcIl5CQqMWi3AqkYEoJ7yOGgXNUlCp6yz/oRjpVAFObNnimvp2qUXUFWCTU0/
	3Y3eEZocwmr9q37u1bdXe6a8F0P04gG/nbWkwM21VHCP7MtjcTJPpPQvGDayba7G
	aMvT7TkSYOftpE1DXH+fbzT0pGwXEfyaesEJl+e+2TqFTmGEx2JgMq4qVN92XygZ
	SLM5eTbJjx5DyRn3WIZ0ErRqqeE5fJ8sDs7z0EptcU0BmdahuBfbtB3WHrJjUnpm
	RkWXxR7xPRZlyTegLXPU5CJz9JbDRpTTAj8QeWWELS2K5mnYLY+j+IFpAgrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771836365; x=1771922765; bh=jbW121JQpvUP8aylqr3sgIT4/7AA9/cl6tL
	eE7xlkA4=; b=m5UirYYyStlQd/jxeYGaH27lCyqquAiJL+m23jLnAvkz3Dr43q6
	xTmlRmY+QTI9kJS+DT6VPugtncSqjTSssh0F94fasidR7iURDcAuvDywRoU+2y/W
	iAFtsSiGpE43UZcqX7jpvdoE80dMWxQUMuohE8SVAhKBkjKNY8aXgLUDmvPaQS/B
	eULQcDi3bWyTD5ibF5OQ9IiU/w5XKPY/wLp1AwJrk8y5hWpyUv3p7d2WJXHpspV/
	QITv5p5ynwp4BcyzO9YT79qudubBuUxLdKji1k52Su6cJVsn9ziLZgROZz4nUkdM
	Utr6ySi/h1jQaH9ulqc/Y6JxtaPDGlCewPw==
X-ME-Sender: <xms:zROcaZEA0aOlghPy8N5DxM1w1AwIDzutTYpETvRd7QTrguszoztjjQ>
    <xme:zROcaVVEWi1X-GZYxCjNR-OrEgddazoWbM7s7TjvrxF3Fu8qIGZ08GMnLrASFfhxO
    J4XqtnXfBGwlpQebGqkR_m0nc8scGvux7Gs_9RqQoG1fRVVGwBX>
X-ME-Received: <xmr:zROcaQKEGYulFgfRB7bIm_G-r5NhPsedesS3VAT-k8C4dfQRE1AX-0s_66-trSY52exgoZoh7LRPaxwybZISP7EQPQZjm50lg7i2xiSJTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeijeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdortd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejtddtgeffkedujeejgeduhefghedtgfdtie
    duleeulefgueetheeludegueeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvg
    htpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zROcad8Ob21Mqf9uAID1ZLTBIOKpOCRnwtDpnE4iniRkevaJCg3wxg>
    <xmx:zROcabLkeiREIrE1Bi6YFXoIm4omniZP4TmGmKIs3_Y1rXwRlub74A>
    <xmx:zROcaamZeXAh2tdNZhWf5HYvumwAX7XiEhM5OFHOPeMBADFHGjLpmQ>
    <xmx:zROcaXNWi-ERJ2Luly7w-DfVzm9GCi89xrC5-4nIFkj4a6TKUOdkvQ>
    <xmx:zROcaaJ8shNavHLDyTgADv41nc88GZaP8D7cEPs84unWbiDNoIr93hik>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 03:46:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5d9536d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 08:46:02 +0000 (UTC)
Date: Mon, 23 Feb 2026 09:46:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] fsck: do not loop infinitely when processing packs
Message-ID: <aZwTyLMWbcXWnYhQ@pks.im>
References: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
 <xmqqv7fopflu.fsf@gitster.g>
 <aZuMPcMYwFi4Sch5@fruit.crustytoothpaste.net>
 <20260223071215.GA136463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223071215.GA136463@coredump.intra.peff.net>

On Mon, Feb 23, 2026 at 02:12:15AM -0500, Jeff King wrote:
> On Sun, Feb 22, 2026 at 11:07:41PM +0000, brian m. carlson wrote:
> 
> > I noticed that the code here seems to have come in with the 2.53 cycle,
> > so we may want to cherry-pick it to `maint` at some point if it seems
> > like the problem occurs often.  From what I can tell, it only occurs
> > when one explicitly invokes `git fsck`[0] and not on transfer, so it
> > shouldn't cause a DoS against server implementations.
> > 
> > Of course, we should wait for Patrick, who authored this code, to chime
> > in and lend his expertise here.  I must admit I'm not very familiar with
> > this area, although I had recently seen the MRU code when working on
> > pack index v3 (and then I thought, "is this actually the problem?").
> 
> The problem seems to bisect to c31bad4f7d (packfile: track packs via the
> MRU list exclusively, 2025-10-30), which is not terribly surprising, as
> it was one of the known risks of collapsing the two lists into one.
> 
> Your solution is using the tool provided by that commit for its edge
> case:
> 
>     Note that there is one important edge case: `for_each_packed_object()`
>     uses the MRU list to iterate through packs, and then it lists each
>     object in those packs. This would have the effect that we now sort the
>     current pack towards the front, thus modifying the list of packfiles we
>     are iterating over, with the consequence that we'll see an infinite
>     loop. This edge case is worked around by introducing a new field that
>     allows us to skip updating the MRU.
> 
> So in that sense it is the right thing. But it really makes me wonder if
> we are going back to keeping two lists (one MRU and one in some stable
> order). Or at the very least providing _some_ iteration method that is
> guaranteed to be stable (whether a linked list or a function), so that
> iterating code is not subject to this subtle dependency by default.
> 
> Having to identify each potential spot and set a "btw, don't switch the
> pack list order!" flag seems error-prone. And also loses efficiency when
> you are iterating a pack and accessing objects in it (since we can't
> push that pack to the front of the MRU then, even though we'd expect
> there to be high locality with our iteration).

As pointed out in [1] the root cause is actually something different,
and we merely expose this now with the MRU-based iteration. But I
wouldn't mind if we eventually switched back to maintaining two lists,
or finding a different way for how to maintain the iteration order.

Patrick

[1]: <aZwTPfmyrFp-QAPq@pks.im>
