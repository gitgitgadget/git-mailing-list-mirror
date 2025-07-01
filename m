Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB9F26463B
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369746; cv=none; b=Lnw+rO6lnxqCbIeeJYGzwVWs2fRPsSiQKcsPTdwclTi/uxsDCFg98zWAm99P36CgFxijO3jWJN2N4eHYaXDppq6fHUScObwf3ZiNd2icJao8Pf+tIbY62piOF6oQA7FQsvhm4ei1kApHbzfdZOWosF9X9y6Gjsyie7DuvOQBcC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369746; c=relaxed/simple;
	bh=OjHUVJQBPPfTwtWfuB9SQZJzA5fxJ4Z5rJMNHBpMJ40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKfPhEoibTPQ5MdnZuvj1PFJvL01yaG7cmJx+0R6+NxEYUhR4XZrHDaxTNJDoVJ3lP/xhusM2UK7ckqGmYu4yOeh2OPZnQkKJAZCLJfWFDCJwdTuBJTlcRst6us+RZsuZ8feF0UKDN6JiiXeBGw44cNGa1iOzdIVP/LIAAWaYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IyiTAhX0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kE7iSf6r; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IyiTAhX0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kE7iSf6r"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 078271D0020E;
	Tue,  1 Jul 2025 07:35:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 01 Jul 2025 07:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751369743; x=1751456143; bh=XXGNU1lPXA
	yB3UEWofEvRQKjAAAci2RSb/BbBSUFu4U=; b=IyiTAhX0mczda6CoTVxsDViI8X
	Q5kVK91uMmLxEA5FKAtd8cYDc8u4X6J6toNY9aXmRceHW8tmvw1htklJQpiw3cs9
	srEPtojOgKVe+o4K8oBE4I0aIkdfO/RK1D1dy1mIvFIVDgNL1W6tWNH52l1u/NY8
	Dr+qqRr4q16E7gHQAyce0GS7zULPqDv9W4kucxFsPWf3YeOMJ2Mq2NwqVpuaE/aW
	mYegVl4pYFdqa8MZmT9wJtwljjFhOUtHeklL0t75hzNnfiga8dHrnMhEP92WJxz/
	zGzRVjlW7lcpTqJHlsTLkvi6/649niBWbjmXWFEc9Wwof7j73nx6vkvK+n/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751369743; x=1751456143; bh=XXGNU1lPXAyB3UEWofEvRQKjAAAci2RSb/B
	bBSUFu4U=; b=kE7iSf6rgyCzLHXCDZgRFNyP6Eotq9VVDJyD9sF60RRv91bZmxY
	6L49HDHKU/pq+A1ZK+xCPoB6wQNTZ7WkxvbFksV0VEm4UrbD/cuOcpKVrWawSjsU
	C09hnhx4jqjOtSe2skIbF//sRe/OYkm0sTrMP5ewhLcqt74T2k6q9KBDUmtE2iMY
	lN2cyfP+q9t91yJw9zBOPBMbwDn+oRmLw9gvDRAAqOr3VbmZIXd4PodlXBVEJYU4
	ZjTm98lyatQYD/7gbk2zQLhON5Y3d/WqdCUD1aq0EgQLeRZ4b7kni83HyK2dkgIi
	rpdZ6BA0ohQQwDDzWKgHEy2EpDomA4b/Mlw==
X-ME-Sender: <xms:D8hjaB3wPGLD8Cw4y8M52ErJ8ebk4dFdhLHeRX1_k_y-rKH7WVK3VA>
    <xme:D8hjaIFmXlyEVoSjpQreNWpw9g9bNlbVBtNOfQ75hG8J-CywaNLOsUIk10D6q2aHb
    9GP8aa9sJcGTVw42Q>
X-ME-Received: <xmr:D8hjaB7jlXgZv7ZBZ19NqXGdI3G_Wq6LYWPulSiWENC8aNDuFzP2Ic-x6Nx9S1z8pRTEmVsMc_nzVzIAwij5TKyDhcGI9RmEFR4iTyThHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:D8hjaO0TaqoYssP0thqQm2jaLBgWOFjdqR664SeC-3fT-t9CqebuoQ>
    <xmx:D8hjaEEu0f3F9SDdTGzI1qgpTfH6KDvNFW4wEoYk2_Xcn43nVSqDIQ>
    <xmx:D8hjaP-zcYTauLhZyjuEiLV9ORYpTNsfw2RcGZYosXB1oA3V426fHA>
    <xmx:D8hjaBlP0g_2UEnRAL0rzuc2MiqNPtUndIY-4jqsT29wISDYAriNkA>
    <xmx:D8hjaCOe3WJO8EYqg0W-Y8Y8PWcw28pG48v1HhJW0P_9eoCBLhjwwMOv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 07:35:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0a01ba5b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 11:35:42 +0000 (UTC)
Date: Tue, 1 Jul 2025 13:35:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH 04/10] Use original hash for legacy formats
Message-ID: <aGPICjCpQMN4cMKy@pks.im>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250620011943.586596-5-sandals@crustytoothpaste.net>
 <xmqqcyay7ale.fsf@gitster.g>
 <aFXJunWKq28BeX-a@fruit.crustytoothpaste.net>
 <xmqqmsa215gi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmsa215gi.fsf@gitster.g>

On Fri, Jun 20, 2025 at 02:14:05PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > On 2025-06-20 at 14:26:37, Junio C Hamano wrote:
> >> If we call use a name with SHA-1 in it (e.g., GIT_HASH_MUST_BE_SHA1)
> >> from the beginning, perhaps we do not have to rename _ORIGINAL later?
> >
> > We could call it GIT_HASH_LEGACY_SHA1 if you prefer that.  I originally
> > considered something like GIT_HASH_GOOD_OLD_REV (GOOD_OLD_REV comes from
> > ext2's much more rigid and less extendable v0 rather than its newer v1
> > format), but I felt like that would be too esoteric and not document
> > things well enough.
> >
> > I'm also open to other ideas for naming if someone has them.  After all,
> > naming things is one of the hard problems in computer science.
> 
> Yup, legacy-sha1 is good enough.  I just did not want a name that
> does not have sha1 in it.

Agreed. I almost started bikeshedding in the patch where you introduced
the define, but refrained from doing so. I myself would have proposed
GIT_HASH_SHA1_HISTORICAL, but calling it "legacy" is even better.

Patrick
