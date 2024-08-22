Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DFD405E6
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724305305; cv=none; b=nRWXY3nGtEOSGNRIqj8BPuddS89spSQi8Rj0MWXLea5moO5/D9NTNz32gyMEAkGIL+CTL4QDEToJtKw2zPcWx+UUS4BL8Odotj0ApxZ8yerTqOAobCPK20k7pZoSilTiQeviRAWPkrz34ARVeJ9DmMO83LpxQMbt9DcsP/CgNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724305305; c=relaxed/simple;
	bh=Yme/RmgQnuZyPrC99b3CPPxgJEEOe6lxLbQzEQ3riNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM69witVzGfoA34itX6Q03aEf15OoRdU3OldzMDofuCxhvsTCYWj8WJVlQAUjqyrP5A82X5TRnf3ilSYw2CDoPu/RqpEyJff5qetr93DUh2jdUkATPinBWz44q5z33FGgweTFcrgTB3hFU4LIdaq1DC5Fie/FjTe5J4NZMCOSpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TWwYKUbw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uTDPAhUq; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TWwYKUbw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uTDPAhUq"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7A7F7138FFB8;
	Thu, 22 Aug 2024 01:41:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 22 Aug 2024 01:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724305300; x=1724391700; bh=gsyV8dbs9P
	NiZBZpE+t50kGChThPrG3rdSePlpmYteY=; b=TWwYKUbwQRj7IkeR7xLt/l5KtJ
	CiXLz8WeDCwFuf0Ycuedahf+g+QojCRf+5SPFJ9p8TxSQ9P8jXxDuPU/YWRr49lR
	0c5ZIWGdCJuHcx6CWmrhYzpL5Xl0hVWloP4PdobdS++wZqA5G2YJKnfPwiWEW3nj
	u95Tom2hHnzWQfiiAtM7CBgId2ah/peJkzTWlUy31RSoCUYqp2hqoPZ9bGXWdtJ1
	Rn3dGE1kljSyEB1saO+rXy0bNEG8Fn6SQEJ5E45DcgZBgfm6WWZqNXhR6R+2TfQv
	6GVZEkt6FACfuyFfRqmXEZ9l3apbLrJm0hTtzvSOlXY7xwvD1DlfPKWaDMpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724305300; x=1724391700; bh=gsyV8dbs9PNiZBZpE+t50kGChThP
	rG3rdSePlpmYteY=; b=uTDPAhUqQ9PMZLvy3NDoAPl0/ERcPqVBPC/a4B+INmwa
	PvA8nmTqPm/hWy6vVTVAxcrfdzJwWe+ozuy9D08qHIhl0Sfgjni+at0bD/gy9YQL
	0lf3uR89SE/gEmQr26NF7lIfupCSrlEDu+6DJhOimnb9v2+hOKzVjd+G9qKD+us2
	adLgnK3VKEficpVgA0YdAHWdk3cJqUBTtaKtaZk0Os/auuqSAhbo8JDB+m1k0qQe
	PUe9bzw00saJycjR7rgTvhtc3WAq0GNlW4M4286Du6KlsBS+TfP5o5m7+XrsensX
	LHp2z3HtoQThsgu/UVqv7q0aMf4ql3RPk244miPT+w==
X-ME-Sender: <xms:k8_GZhmXy7hY4Oymx6NBdXxq0PfylXXtCBm3RFBwyRrP6FWG79xdxQ>
    <xme:k8_GZs3ncdmzrfyi8GmzQehmt4QuXjP5C4Bt6-15-MUYgs4LbgH1A0Drkd9M7K6Rs
    231Eovi02YG67CnBA>
X-ME-Received: <xmr:k8_GZno4Hlp5KIyYJNQYz8s7-s3Ot2cTuPS_16lKLJdts_IQ7KXNAwnsDTVFJLpGIcAIlE5I6gul9lr9lZQAU6XP4-IXZSXXMWp-EkakAMxttiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:k8_GZhkU96aEcdSe5ANnIt4M9Rmr2O-D6GJeQwbqaHAt7qLcKXoXMg>
    <xmx:k8_GZv3IkYSfjdB6z3dDCoFUNWQbwIl3UdatzF7heot_Z1Yzra3KRw>
    <xmx:k8_GZgt-yJxOlVLNxhA3D9Q3Vszk7gOzMbhWDRivkbm8MyWxGIM1Cg>
    <xmx:k8_GZjUeXRFvpW1IcIi4cp5hUb2uEJCl97tzupFC6cN-JzZXzinCrw>
    <xmx:lM_GZkn_CPUIfQ0IpTnvmi0cY1IPAUdBwZJAH2t55BI_bdBmXFIf7155>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 01:41:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 587ec2c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 05:41:02 +0000 (UTC)
Date: Thu, 22 Aug 2024 07:41:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/3] t7900: exercise detaching via trace2 regions
Message-ID: <ZsbPiGJlgxWiM-t9@tanuki>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
 <9712aae82bcb51dd94fdc10f4156e9c78e4b6d8c.1724053639.git.ps@pks.im>
 <20240819085105.GC2955268@coredump.intra.peff.net>
 <ZsMIxmX2Ash9YtEU@tanuki>
 <xmqqfrqxyb5h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrqxyb5h.fsf@gitster.g>

On Wed, Aug 21, 2024 at 11:38:02AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> ...I think this "we have no better way..." comment is now out of date
> >> (and can probably just be dropped).
> >
> > Oops, yes, that one is definitely stale. I'll drop it in the next
> > version of this patch series.
> 
> I am not sure if there is a need for "the next version"; in the
> meantime, let me do this.  I'd prefer to merge the main topic down
> to 'master' soonish.
> 
> Thanks.

Thanks, this looks good to me.

Patrick
