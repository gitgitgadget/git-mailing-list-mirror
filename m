Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C135231CA9
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728292711; cv=none; b=F4yFcPpWCbuafWd5f695ioHqhaUyBswprEIwizAfKZ0i5+Lc/pd5ImU4cfxWyXwzvaXErndBlwW7piip6WzJJoGv1oSBWUWWHzpIJRhcpZG8OC8IrW0KoLmZossiGR+cclHhqWvudmV1jC0ZSPrCaFfY+vsynVJB6YHQ5Z/o2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728292711; c=relaxed/simple;
	bh=Xo1DqORT/lnmOzc20ak4ZBx6wHFd7DGoETucBlcH+XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv4vkvpcNV4vqcS3nurJd7+Je36nPL/sILPEC2plK7GqI0HifBZtZBU7QBRn/p7YxeQNv1x2/OZd9NKl5ykoU+j1BDYsyTV3dAPSzcS+78noouKnMTQXlf9tBxh/rwlfe/6PEVqeMINvF2Ld2zutIG8MUT1Z1dyABi3FGTARO7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=quwZ+4wd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PZVBnMz/; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="quwZ+4wd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PZVBnMz/"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 8407411400E4;
	Mon,  7 Oct 2024 05:18:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 07 Oct 2024 05:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728292709; x=1728379109; bh=am77FiboMH
	4Yt1VVTr6z3rP8QVR/BChYVC1c5fc1HGw=; b=quwZ+4wdEZiq6V6dGuAT5MENhV
	+iNgE2IpOCKJK+r6r7U6gl/jC2fEwJMXknRR6D/PmvdGEDOXlR+6aSK1u/OhWGWk
	b8lkxOxn4NyILIh11MS1sZYNWZbt869OcQo3UwKvDTo1NM6jd337oJ5DKVFVonDv
	UPM+L+XU5M9Ei+rDyBsot0TKuEl1jIUKlMAb4+HzcgZxLTvjr8yb3P9TZkAhVFpU
	y7nwTymPhMd6ybpu0PKgBEtfwp9ugeCTbA2vGL54thDRhqN/5IGLNtamgv0b05IO
	zYJye3GXZ97QsRWNddQisc91xj8DZ2xLr5h716auocP66i+VY2nqnAB/d+XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728292709; x=1728379109; bh=am77FiboMH4Yt1VVTr6z3rP8QVR/
	BChYVC1c5fc1HGw=; b=PZVBnMz/43G5epTPz5RqkpKGViJecBVfJNKfliP0X+NG
	FFMtONLOTUGrzg091hgtqpl36y5sfa244uauscWOohj3PVbHQMqpKHjo3QD5wQ/l
	nceXyxZLWPr8L8Th+DCh6BS7gF7sBj0DZxf1jLBrg4BQLsRMwp8mfL3SAJ/wRnRh
	jYPhVC2cFWMiy2AKALNJybs9df4U0qR8QgupB6wAF7dZqTM+d4fl+sReUEJNT7P5
	EkHPMZD0srvfXZzwzxTbdP9LDkYav883Z2+SgISAh2c8B8vuUBv/Xgg7EpnoVvkd
	I0HxkOaHasVGjVTQ8txhGgtEesOIXrJcttwez9ODgg==
X-ME-Sender: <xms:ZacDZx68ZOl0QInqHVXiiurDByEn8FaljJE18Fdylosw4-pOIcz7EQ>
    <xme:ZacDZ-4ohZh-mDPQPt9QV2ksZZTSRsAymWlvFvnGHC-T8i4KtWsyHd9QbQ1GlRHJb
    -OMbrfovFlZO_G3Rg>
X-ME-Received: <xmr:ZacDZ4eZQKoCoZBYvT-urFXYz2K5QuJP3P_FBPZOyW6EbDQsbMuWm-KdhBLCurEzCtDps4rfQ4oo02vxJ1yaa0AWZPsVegphGUnmY9wrNooDSIOIHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZacDZ6IUyGYNP8dbaMfajycybsXA13_8Q0lTwXuWFAk-MYF8dNgLrA>
    <xmx:ZacDZ1IZVkOEqr6usVYGJRPoR9MogzSFt8o4DrhhRW31DbyTqlgqFg>
    <xmx:ZacDZzwQ5_qjxME8MJnSqBI704YVls-ekQn1XW7jprjrcRQQ_xdo_g>
    <xmx:ZacDZxJj5d5U1hyurTUWG7IaSynwr3pPFRxuxFyK-DYlt01AX4ttFw>
    <xmx:ZacDZyGCpQgO1Ykd5-13r22A3qu1v0fhh_u_gZsDAIoLy89_HNtifo9_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 05:18:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 89e0a2da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 09:17:29 +0000 (UTC)
Date: Mon, 7 Oct 2024 11:18:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/9] ref: port git-fsck(1) regular refs check for
 files backend
Message-ID: <ZwOnYAx_h9uGzPst@pks.im>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-osCNDMrUQv83@ArchLinux>
 <ZwOGmoX5ner_F3Ac@pks.im>
 <ZwOfBCSTO4Qvtos3@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwOfBCSTO4Qvtos3@ArchLinux>

On Mon, Oct 07, 2024 at 04:42:44PM +0800, shejialuo wrote:
> On Mon, Oct 07, 2024 at 08:58:34AM +0200, Patrick Steinhardt wrote:
> > On Sun, Sep 29, 2024 at 03:15:46PM +0800, shejialuo wrote:
> > > "git-fsck(1)" will report an error when the ref content is invalid.
> > > Following this, add a similar check to "git refs verify". Then add a new
> > > fsck error message "badRefContent(ERROR)" to represent that a ref has an
> > > invalid content.
> > 
> > It would help readers to know where the code is that you're porting over
> > to `git refs verify` so that one can double check that the port is done
> > faithfully to the original.
> > 
> 
> I am a little confused here. There are too many codes in "git-fsck(1)"
> to check the ref consistency. How could I accurately express this info
> in the commit message?

Well, you say you ported over a specific consistency check from
git-fsck(1) to `git refs verify` in the commit message. So I assume that
it should match a specific check in git-fsck(1), shouldn't it?

Patrick
