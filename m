Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C13175A85
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774246974; cv=none; b=XDnQrCUceeH4MXJJT0V98GC2Y6ppCqc13Xy3w6WRsEgCD051Xa55RlSICQ3toHbjHVhGzY248YFIEgtMg/7825hEFM4A8FOnolGNUT5DSJajB7AA+JML36KJ/z2rTbMg3DuXI4ObwDcW53XRmsFFw2cFiyoE52Gcida/GcxXLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774246974; c=relaxed/simple;
	bh=q5wezfZIji+gXoBY7H53f/COwdVYh/zToSmgRiepAvc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dnuw6RAAWq8ul7mrdz55EdIzKPBglamzG8a9xqftxV67IC2B/oZnMI8xNDD/zJ+eMpePSC34oGr1TqmotnJcH25JPAwsGLBsX/vzixQDzC5KMeuT5v7RgnuWrsUXw+8jRw7QcK0n6/T1oQ8iWraq8OVxjpd/1A8mg/mb1x/WiKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HirlboSt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MhEQtLtR; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HirlboSt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MhEQtLtR"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 82DCB1D000B5;
	Mon, 23 Mar 2026 02:22:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 23 Mar 2026 02:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774246971; x=1774333371; bh=yDNL54kQ0K
	GuNSIhp81PmRzd4avc9V6RLoCHOmfQxYE=; b=HirlboStzwoh9tGqALkawGq9o/
	6FSLgtpQquFPtoBtv5t6BfDX2rM3AQjLIFt5LXWYlhMlJSLukspfmgG/WM/3Zvhf
	psF8Rq5rpa96QbdBt8iNFMyHJfSC3ccoAWNXXbS2R+18vsoLoAhsLxdDp0UHbwpL
	waEhdKRr2qwAKT7K8HK03QEmnhfVM09lsZEYsaj6NQpJb30o4rU5OHndWS+rsSCK
	zj0ZXXJJIoulSce4Rf00bBV61xiBRfUEVC/Jvz8tPr08l15oSf8RD1aYmON3oeh2
	Zxu/92goWYLJQ2l4mjvJoyKxhtGMvZ6DVutbTvDuXH/Hx9ZBcKZirnU1VG8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774246971; x=1774333371; bh=yDNL54kQ0KGuNSIhp81PmRzd4avc9V6RLoC
	HOmfQxYE=; b=MhEQtLtRWVSvpbxfBAp7B5SR1bXEetFpLUb3IN5yFFLW5hLpBkS
	7D6jWYFfoaja8fUDDOQN0pU75ZBD4Brd7K3uIAZTjz0PoAsFusiBXucdcNQW3DhV
	vWKijzTvsmMvNCkXL8eYSvU7WbxkQCYHFIa0ggAFl6LRFkPy2OGtCsDKhRCSpJYO
	QfoBSw/v3rHM4vAH+nP+DZlOCkM14By8tHghJA+WNJslAKv/83rHde5JR5AWY9xK
	jErl1ngNWfwQoEc2BtycK2mt/zRe8BdlFdsTU6UDjuKnq14jcY6fEarAiwGkzjsy
	EvgbFTA7VSZ49Z7doyqpW0Q1EgtaJLVAJFg==
X-ME-Sender: <xms:OtzAabSVUCcMZez0_1RyBqaCKj2mdTFE0RCEACTq99RyNgf9QrbFIw>
    <xme:OtzAaUNtke_1uoFc131BfEEwjCM9uDls21Wlu0ovNs5_DOzuyRLP1MhIG5qs7bds5
    nW0xX_EVCG1HBshoTjw5EFXAN39-jpYNFCjlY9P6CfLGpHz5GojxA>
X-ME-Received: <xmr:OtzAaeO_V7ExnmQDRMVsORNWVmqsjyrr_4A0bXM2jtFnqAjX9Ynnw68CFRwwao6HlJcJNElq8W11nLOs_e4JJeH2RrWxMhgkmw_NUoPl6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudejleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtrodttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepvedugffgtdffleetheevkeevtddtkeetgeeive
    duhedvuedvueejhfehveejgefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:OtzAaUsp0QATvIutM6Wylv_mlIujS-7o0tallAs97_-TsqFQPKO6_w>
    <xmx:OtzAaYVyrcnuTxIOib7-fBoZKu3AyQsI2JLbVmIZMO72DE_8yLRRkg>
    <xmx:OtzAacvB6qYd5837g-zDjGKip4c_nJpHB2uhk6rnCt4etUoqYEqF-w>
    <xmx:OtzAaUXvBxuny95rUbTxVxyGGgLdR4ox4JzDGdbKneEO6UWO5pKGxQ>
    <xmx:O9zAaWY8dfJPycG8HmjtvPojBNNEmPe88dwcGApJeFQjqbu9zx2Wy6YB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 02:22:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d03fecc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 06:22:49 +0000 (UTC)
Date: Mon, 23 Mar 2026 07:22:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 01/14] oidtree: modernize the code a bit
Message-ID: <acDcNkIojSNiryFV@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
 <20260319-b4-pks-odb-source-abbrev-v1-1-5ddebad292b0@pks.im>
 <xmqqeclfn6nn.fsf@gitster.g>
 <abzryk0qjlbvy8OL@pks.im>
 <ab3KjF_1WW7hQBaA@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3KjF_1WW7hQBaA@fruit.crustytoothpaste.net>

On Fri, Mar 20, 2026 at 10:30:36PM +0000, brian m. carlson wrote:
> On 2026-03-20 at 06:40:10, Patrick Steinhardt wrote:
> > On Thu, Mar 19, 2026 at 09:08:44AM -0700, Junio C Hamano wrote:
> > > I know the original also used GIT_MAX_HEXSZ to clamp the length for
> > > sanity, but because we know what algorithm is in use, I wonder if we
> > > want to use the limit more specific to it.
> > 
> > That assumes that the passed prefix OID actually has an algorithm
> > attached to it, and that may not be the case. We could initialize the
> > overall oidtree with a hash algorithm in `oidtree_init()`, and if so we
> > can then become a bit more thorough with our asserts.
> >
> > But I feel like that would go beyond the smallish cleanups that I'm
> > doing in this patch.
> 
> We should stop assuming that a zero `algo` field in `struct object_id`
> means `the_hash_algo` because that makes libification hard and our Rust
> code doesn't support it (because accessing mutable globals without a
> lock is unsafe)[0].  So in general, I would be fine with forcing callers
> to set an algorithm per OID, both here and elsewhere in our code.
> 
> However, I am also fine with doing that in a different series for the
> sake of minimalism in this one.  I will probably get to that at some
> point if nobody else does.

Yeah, I fully agree that we should get rid of this assumption. Thanks!

Patrick
