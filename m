Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9782FD696
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861696; cv=none; b=MlvCDuScrguIToTo6qRDz6LMbYTmqEL7PKEv9B0RS6BMUfeTr38U+a5lIsAtxkfLkPC2hX3/i4H/txflgssp+7dAcJbp7pu1POOucTkGdp6JYoYAkDir7fXIbzZ5P/VXYAA/fk7QcUa0IpuYTjJTcW7CfZt4W6DWG0rzMtXF4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861696; c=relaxed/simple;
	bh=7x3ynYlclD3cZ1YaRLVHCJShTfNAnFfG+saJ5Z58o18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K81gi6UVEarmxWFmwwFgouKjY5FSwsI1jEdzb8p/4tjt6wnneWTLYK6dFtY3wbVtKg7FTUDW4Cb0LA9PGEscJgUEB2Ld1sYAsthf1eoun25sz394Gb5dLsOCQODnVOqCoK46xLIPGKDAyOChYiD3skzCK9GbZ3BnWmaKEwbZC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LkkA07N1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZDLVU/sf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LkkA07N1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZDLVU/sf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 754BAEC0599;
	Mon, 23 Feb 2026 10:48:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 10:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771861694; x=1771948094; bh=GS7uACH3iW
	BUDyHc0Vz671P+0Wu62HvRLLLF/3UVkPg=; b=LkkA07N1ehnrf6xWQgPU62oqZG
	JuyIQxix9OQd6izQu3qxdIl5ER1DP1D/xDpIfKWX+DatNJfVJvaSgjy686Gp/gkv
	3geF5c/eI4dN0gmj/sbBud9zyTpavw5InfsSK7ttaX3ZQwDSZ+4qpD0GHCepbzw0
	S7AuQEG8SGe1vmDksUsrnDqgbLcAgvS16lcXzEDhsoeBtWW4ihRiB/Tl/H9uthp9
	AfSGx1H/5T2tt/53o7djtvnhlKxvtOymX3Fn33CeSrBTYEtWWUoM/VApiVDZxUOd
	zptAdsLQPlohBJclywdds8//+e9gtsK4NZ8vGrla2ga1gOEM4MlrjJ0RVYIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771861694; x=1771948094; bh=GS7uACH3iWBUDyHc0Vz671P+0Wu62HvRLLL
	F/3UVkPg=; b=ZDLVU/sfgEA3dpcxnxC0cZrFS6Lyjnjou0sIaIzabmHrkzD4Sqx
	j7ZFYm7PJIbhjuWJs1gO5RCLOizNSw1VtbIE5iWip5RJ3BDms/+h8otfRTF+N2Jt
	0WbaBDaOku0k3pWHATNwV5Ii/g7csTyWd4kIVMB+0MbSbnnh0dog6ljNCQzvLV8v
	owhkjOiN4jpxxm5SJFHTH5qmlA2U3U8aHqHAP8xAqkxcJnAEoGdImJjubCJa7V+r
	3zK7qqbQJyDvxfUCf9Km6WYV9g/7YQzYQgMFkt5f4fkhT2FlzEODPkrgxLcI/d4z
	VmsUahV6TmXcQ9Y8+3uzi54HZ+bFtwV7Jdw==
X-ME-Sender: <xms:vnacabF6e2GM2zItEUJJHMyhRyE5ddxXXMfyyd4rngC-I_hVESorFw>
    <xme:vnacafUDKW4s0bTSnruAgETJG6BmOI8xO9mBeGbXgb8WGeyQKaynrTsTN39MYLDrG
    csG50eKCoDGwUjvErTSyJmKTx3vKTveM46FmqY8_nRH10pAVcAF>
X-ME-Received: <xmr:vnacaSLbyko35Axi6AohQ4haxtPUGrhzHkWYHCdEixyiDyVg7O3MuypbEGx8LT01tT1Nb7tbKa0XqcxE8WZx7_Iu3_QKrPL-3Rclx9gLHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthih
    thhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:vnacaX_nt3HAbLwOlE8V91ZwgPqYNIDluZupvbGmU7hd8UbdEbJBEQ>
    <xmx:vnacadLgnt2evkEumIT3pvLZNWIeJM3to7nsiwML8FPWou5F10ar7Q>
    <xmx:vnacaUmz0MbzEWLCnpWVWzrPGywiuaZ40AICG-MU2_G4VYjfr1qVMg>
    <xmx:vnacaZP_JkUDPHSpjraYctC_56KVxi4h6QUw4tdFCn7Od2SeiHj1vQ>
    <xmx:vnacacJO2wbWUshd3rs1m3yenZAAZhudEay5JJk3W4znB8FAAgA9YtGM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 10:48:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e4dd7db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 15:48:12 +0000 (UTC)
Date: Mon, 23 Feb 2026 16:48:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] pack-check: fix verification of large objects
Message-ID: <aZx2uRiLIaa21L-x@pks.im>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
 <20260223-pks-fsck-fix-v1-4-c29036832b6e@pks.im>
 <20260223111120.GC215364@coredump.intra.peff.net>
 <aZw6W_BHoYiC9RYl@pks.im>
 <20260223125843.GA215671@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223125843.GA215671@coredump.intra.peff.net>

On Mon, Feb 23, 2026 at 07:58:43AM -0500, Jeff King wrote:
> On Mon, Feb 23, 2026 at 12:30:35PM +0100, Patrick Steinhardt wrote:
> 
> > > A more concrete test would probably be something like:
> > > 
> > >    1. Two packs, $X and $Y, both contain the same object.
> > > 
> > >    2. The object is corrupt in $X but not in $Y.
> > > 
> > >    3. Running fsck detects that one copy is corrupt but the other is
> > >       not.
> > > 
> > > Right now it may or may not fail depending on the ordering of the packs
> > > in the MRU list (which we might be able to tweak via mtimes). But
> > > hopefully in the "after" state it should deterministically complain
> > > about $X.
> > 
> > Yeah. The problem I had here is that I'm not sure whether we have any
> > tools to reliably create a corrupted object, e.g. with a hash mismatch.
> > I'll have a look for v2.
> 
> You can see how do_corrupt_object() in t5303 does it. It's basically
> finding an offset via show-index and then writing a zero over it with
> dd.

Yeah, that's what I ended up doing indeed. I spotted such a test in t1450.

Patrick
