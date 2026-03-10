Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FAE397E9B
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144598; cv=none; b=KNcqPY+Na6Si5AyvGiMax0PsL/RgbB4V05m1mbXv0kMrfq/JeD2batAFK/ie5E4fN2HstCswohhsv7IeT8Ev3zjswvpFPkQRi/ljsu0wdzbQRxGYjnE49rWbxjET1YVywoJdU4WRyJF2LGQlDFeaHtBNUX2gqnUt8ia9p7hSPlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144598; c=relaxed/simple;
	bh=eJ7qDOTvoPzfptveSdL6+codjzf7bf7QKdOD+q0ooy4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9VUEjSeyDfZvqiKLokSj2+7qELl2kOKKJpGkQc4O56/9ZH6phnAz7MveFZkICX8NzA0GYHlm+Xx4pXOolF3O1Ua812NbLfkm2A4O3gmeqR2uFaOPdjt+pxdkb+HrbQHbD2zdFScfiy+PMQgrqEovQ+d8dvsUhSslD2PFp/Udn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TTMm3Ymb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D3zm+z3c; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TTMm3Ymb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D3zm+z3c"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F787EC0C55;
	Tue, 10 Mar 2026 08:09:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 08:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773144596; x=1773230996; bh=T1oDnffXdm
	JFXxAcf7AhMHQOIcTMhV1Zus3kD46it9w=; b=TTMm3YmbFhTGQ8ArZSGBWBUI5v
	cv7TJayHir74Lazmnp2dIiDgH4bUw2bUkwRfWtiiuw5xMw/gNzXbPJOpO1/A1yzx
	pbRDXYpnjxYoAHrrhIKLCV+7FIDmh2SrQ4wssneLizbAaTKcVIAkDUO4v2wvpO0a
	1Ciqbf3/Eohavjfj2FrLcslJ5oyeiQXpD+ae1rh2Yoi6gA9cuUuailvIcrYWI2ju
	6y1GlPCMruO8O1Gzt3rt5iZnIus2XPYCeIZcfPXaT9m2e5WfA7HLT3ZZ7bMGZ4LR
	7VdMMey3LopgdCQn3XqIqvshZv2+QcUb3v8pvYdHMiQBxEAMj7WULTOdi4mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773144596; x=1773230996; bh=T1oDnffXdmJFXxAcf7AhMHQOIcTMhV1Zus3
	kD46it9w=; b=D3zm+z3cAz8ICF3tHB6Hs7oZ0KRkLR5OZZ8xlu94RRnrog1bo+J
	hsY33F5KsHkgJQnie7Nsyv5mMlbpojTOD5klTF+bhwoBHcctiDAv582BgVvyHdpf
	OEoKZGmATc4b5rHaYvWKVWWoG1I31r0okrppZCb8gR0TyJe+uUrGwKqtXf+VGzh+
	5e4k5cDHjrUStJ+G39A+p6A4/Jx/0xRmcXAULOUOH8tHFJIwXih0pXzjTsyZ4ON2
	XW8tc3rU8l5X2+Cghd2FbrKT8/HPtOPIyBr/kqyYZMKc6yI+MYK8KS8yMtKSKTEw
	i3bFbd92e/K7sscc0rP1MLAOJEAgqKe1Y8g==
X-ME-Sender: <xms:EwqwaVffo2_l1Wh-aGYTXRJXh6A6OSWFvrh1zTthjh9Dobz0P2WRzQ>
    <xme:EwqwaW6DExHisVG44-Nrcbbv3j6F7Zl2_yvgZ-cVIL2aU1zR3j76SJjo-n8p3ry2P
    94zffWSR8_M0ylDoaSyevJNzH1In2hzc9Q2p1ohUq08TcLBRRuTpQ>
X-ME-Received: <xmr:EwqwaYUkj6NHyjaD06rOeOYWenI37dd3Q-mjORQSoTDbE0VPcaa_90MmzubRO2ZcOuytfHlkuR8IzyllGw9ct66nMgNL1NudheS9wA-T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ehkeeffeeggedvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphht
    thhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvght
X-ME-Proxy: <xmx:EwqwaV56SyOQRdyfVgncBl7-8NQqkTO2A15hCEiYLyapcX-NeVYfMw>
    <xmx:EwqwaTpdMZCL6AIUhHeEo-1ccUafm0K1lQzCCdWyp850m0XgRdzLeA>
    <xmx:EwqwaYnsboupUdTLm-0LK_dNF3amc2m-pHBYocHUDEhZMfaUEluqmA>
    <xmx:EwqwafNCEvG_Obw42uylCC_AkqrRqzDhNFr5CwTFgPXE8A0LZLrE1Q>
    <xmx:FAqwaebc7057NhdzQj2WEO4lK3rwBTKel11LcG9lo53Rsnn56LoCfvx0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 08:09:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d338598 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 12:09:53 +0000 (UTC)
Date: Tue, 10 Mar 2026 13:09:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Matt Smiley <msmiley@gitlab.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 05/10] compat/posix: introduce writev(3p) wrapper
Message-ID: <abAKD91MweDTS4jv@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
 <20260303-pks-upload-pack-write-contention-v2-5-7321830f08fe@pks.im>
 <xmqqseaf5k5t.fsf@gitster.g>
 <20260305003745.GA4943@coredump.intra.peff.net>
 <aajnZZI5yqL9CYeR@fruit.crustytoothpaste.net>
 <7e8b51d1-382d-47f8-be71-74e76f0c9888@kdbg.org>
 <aaoCNUY3XVyFaDcu@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaoCNUY3XVyFaDcu@fruit.crustytoothpaste.net>

On Thu, Mar 05, 2026 at 10:22:45PM +0000, brian m. carlson wrote:
> On 2026-03-05 at 06:39:13, Johannes Sixt wrote:
> > Please don't. The use of writev may mislead you to depend on guarantees
> > that a kernel implementation of writev can provide, but a compat/
> > implementation cannot. (For example, I read something about "the file
> > pointer shall be unchanged" in the case of errors.) Please use simple
> > and stupid functions (write). I highly doubt that you can squeeze out a
> > noticable performance improvement with writev.
> 
> I have Rust code that does show a substantial performance improvement
> with writev and I use it for a very similar purpose (printing the size
> before a packet of data).
> 
> I am okay with slightly loosening the guarantees to support our compat
> implementation if that's what we need to do.

Yeah, I think that having a syscall like writev(3p) in our codebase
could likely also lead to improvements in other areas. Nice to see that
it'll also help your use case.

So for now I'll stick with it, but will fix overflow handling as
suggested by Junio.

Thanks!

Patrick
