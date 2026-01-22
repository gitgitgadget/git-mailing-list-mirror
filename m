Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D5E35770B
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 06:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769064720; cv=none; b=S4KYmx3izKmOJ+qZPp19TLUTOeYmIaE+pKOuvpCWD/GKiA9ug74dwdP3TgOqY8/dPqCGmyVG9zpRCNTZR+ikmVDc+WjxCwM7OrTLNgf/13Wv2oN2TfdxaiiPwnQW/uNRbe/gxn15GEB91j6KL8xujLcFckiOEBUARQ31rzl9Wz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769064720; c=relaxed/simple;
	bh=FyYh+NsJ45CfAwMBCCKWah8MwxiEAKe3tedjSoIC6r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBNYu6H5Voj63I2+emzGgjMXWoY6YEJSzC4lYk4J0RsZ9Oxs7qFJYm5dh/aRCN7QATwoRNX5WyuMUvCioemNxxqzbJiNc4yTmxjuRa+tr5GDYkk4nG51arvPhODoTa++enRdTq62EM9I28mEv1JNInDccuVVQjjdwO+iKAuJ2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LYSGpt6h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PhNy2SoE; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LYSGpt6h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PhNy2SoE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 89D5C1400162;
	Thu, 22 Jan 2026 01:51:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 22 Jan 2026 01:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769064706; x=1769151106; bh=DrvfGV39YS
	N3xufOp4xvaqLCCT+8dB09RDEfcE88b6c=; b=LYSGpt6h3zkLA4iPhD4Bq6Lc83
	4Z8wWjOFUx96YXWyiw13FCiZwNQ833Np2EbCiz+433YNgDSmyaGywqlkS9c36EFe
	dJWrTbV0eNHL0movEpUgMswQ3DeDeFTb6y7CL+QrxtD3tDVWfthLt6m+Zqbfq59N
	zIygLKuU5JOXsaHVHCiQU1Cgnwh1v4Kq52flfBHInL7FhEoGPKix8MB+m6D4F1jL
	DFSjS/j2as5yp/vnVPU3DnI6FoUQRaCFlo9e9ZAqq6X081/42cJx+Nn9ifW9QEtX
	KuFavD1zodDI+Tb76xGnq37JoP0l0w6LEWLTk9Yxw51kvEe2EBEoprexDSRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769064706; x=1769151106; bh=DrvfGV39YSN3xufOp4xvaqLCCT+8dB09RDE
	fcE88b6c=; b=PhNy2SoEIkAmO7hzmuOMRbpZlSdq696V/z+m94A552+qRDWTY83
	ChOFw3g+EixLGu7yzQTPKyI0/+7PL2+YOWfiO7G6Cogi+/RX8qvibWrl0wSp8STM
	PcqCjB74RYucu6mXECageGJF4hXLdKIShMhWoaHG1LPnqwnUqTWrjvHSQf54S2Dy
	7DR3e6ccn6kL17RGsyejUQtghlVJKsN3/nP1KnTGSCKSQ6OjL6F8z7kzl29Osfbz
	OanzrFw6/PLP76DFPQc1cBvYWpyxlMGx34SgMLDZUkIWcG6+B8/BjHOc53+Pk4pZ
	TS+aj5/xpk3aRfiKTwtW6xqZbiDyNzErKFw==
X-ME-Sender: <xms:AslxaVMHFcO5nmizc51vgB_2YrivSr6B786CS1UAP9-yHc4NjuTGhg>
    <xme:Aslxae2WOcrC6PmjEYZ6sTcPWLvfu-G0M9R96PYKEAALXmotI_1EpAYmvHmpRy88M
    8nM5g7mICAcQWnKbpgH3jlP-csKqZ_fedtR7uuqvYN84SFCS9e4qMQ>
X-ME-Received: <xmr:AslxacnDrCPzWy8bsVBVuXNxVbXAkcSuqJxu8j6Oedt7yyWi3EF2LunW2TG-Yx22MWOVJSqogfQTOSdmPERb54jnnkMldRo1fvp7o5jrfD93>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:AslxadUcY7mUrFxk4uXsdunbIwey7eqi468Kjd8nytLe9IXDkEZAyw>
    <xmx:AslxaathjHpHNZbqDejtvroGEnGifLhu9Q4HScFxiGv_lm9LPNXb-A>
    <xmx:AslxaYaRJaW3rnfP4lIbwtNo-Arp1D_4yuVDeMMDDEWznadFrD7ZGA>
    <xmx:AslxaRWifsOuu3mHIFHpnDyQDzdXmUYGx1wxGHJNTcBeIBMBbddoCg>
    <xmx:AslxafuGwhkUPrZ0cidAe-uQbx_5CPepoZU-ajgBQgGYKrju81ym60Z2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 01:51:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a032a867 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Jan 2026 06:51:44 +0000 (UTC)
Date: Thu, 22 Jan 2026 07:51:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/14] object-file: extract function to read object
 info from path
Message-ID: <aXHI_Q_88q1aAXlW@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-3-12c4dfd24227@pks.im>
 <aXFpcms/adskOx3X@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXFpcms/adskOx3X@nand.local>

On Wed, Jan 21, 2026 at 07:04:02PM -0500, Taylor Blau wrote:
> On Wed, Jan 21, 2026 at 01:50:19PM +0100, Patrick Steinhardt wrote:
> > Extract a new function that allows us to read object info for a specific
> > loose object via a user-supplied path. This function will be used in a
> > subsequent commit.
> 
> I think that I'm a tad unsure of this interface. I understand that for
> the existing object storage mechanism that having a path makes sense:
> loose objects are stored in files which are referenced by their path.
> 
> But this feels like a leaky abstraction to me. If we are dealing with an
> object store implementation that uses entries in a database, or
> arbitrary blob storage, do they have an equivalent concept of "path"?

It is leaky indeed, but that should be fine given that it's local to the
loose object backend anyway. So no other object storage format uses or
even sees it.

Patrick
