Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FFC246BC5
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778950; cv=none; b=pfWddJgeDDlF/vz0M2zPMf1ixvZYBsI0VkI9sDHDki4MskRNXFKON/VkC8iD2G+i48TTbHr2rzpc7kQuD76SHNHGCLkJ9y0pkjDhZN2w5qr1F0AUiCbHnQL+LqxPEukHdBqu8jUb2adQzLzyx6cANNq0PIOOy8F2NrDaNnpBZJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778950; c=relaxed/simple;
	bh=Bz7mcF7hxWsXWYfj412y4s32qguzt+vIEhAStNVmoIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b66yw2gfvBdwT7KfjfdPakFVlWe6+VHcSOy1GIwHOdyczJvVbbbeGCOYgQ5sSnNfSkVqp/QczSQAhGwG44mNPWTa0+jRRxYC3JWju1vSF53Fr0jC7ydC6pR6CsK9hqUj2RlA/rq6Dg0ZptPzRpnDZUbTDjnqpMn9wr28ZR1/zOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YXfe/yE1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EmOzhIGP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YXfe/yE1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EmOzhIGP"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E3D9EC01C2;
	Thu, 25 Sep 2025 01:42:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 25 Sep 2025 01:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758778947; x=1758865347; bh=/5pLZSl68M
	MTC9R0pjF3xLwSxRvnhhJxGYXJrjAizdU=; b=YXfe/yE1tbLyzZgnYNAXKkj2gv
	VpkWwo7lS6XNnccjz4c7WvYYkVDrfIjsqhR17q6CwaBWyJu8oUvTjgiryjqjo3lS
	06RpAbh3DoqYv0m1lZAyVXEd4ufYcav5Wh3nb9WUIOzHeQ1rU8blGumNn8wRjzN3
	zY0koB9xXmNRzW9tBGNt96DzRze+t7QkZSU3+iozMalcpCcZ7ZI8NK9hXiwnjPSQ
	+/Tolb8gQRuKSjXFmfKkz8imhywVSvpTZeb9OALDGJFY+nymRyKvKzdRzh7ln3J9
	W1q9kJI9IS/7RBbGcrgFxCrZlIL9aVPijlgKYvauXTojvk0VY6z+ezgeKhyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758778947; x=1758865347; bh=/5pLZSl68MMTC9R0pjF3xLwSxRvnhhJxGYX
	JrjAizdU=; b=EmOzhIGPXIfk80nt5k2q//9Z9rewsGqXblGVeijOHqaGjW0Mlgs
	ojDClMM9RfoTX/I7lW1KbPFQK5Od3X0csIb36BDCKIIASMbffY/A/R4Prz63L5oq
	uZ1XlEj03SuoANFHr/5Yb4fSnzbCSS1l8+4Yfkph3f2D2nwZzfPm3h2/VEtpvhbJ
	xoI3CSmJy8hT5WX1olHYaaemndSVVhP5dABgcC2ysGDAU4vLxaUfEB8mQQF3/S+T
	grOXyM5Y6Hu4FsjhCQq5NkRtfzCkuSJ8LuKSgEMUl+EXK4d3ooyu7o2QZMLS4Gb9
	BH5gtDZVLdrr9YpI1IXKMeFOxJEEvbDqV8Q==
X-ME-Sender: <xms:QtbUaAdu6WJUldNbBqDcjk-tXpQM08-9Qh8LXuBAG9WKsyhOksx1zQ>
    <xme:QtbUaMNAm8u4Hg4oscDO3ia_m3U3xAcDYTfeL5X5e8ntbLr33kne2A0jhYLcLppyS
    7CM4287H_Ti-Sb220A-fr0xdXO2XQyt6NuKuXHgcNXoc5IsBw2Cxg>
X-ME-Received: <xmr:QtbUaIJTTCNF2ed2AuaeRg9DTPXbPmP0NaJbCi8CDVCN7Md_Kd_uGVeRJIIN3Lwyxe_GGwKXIqMKxIdnL87YapxkC76XH4BBdxTpj_VD6UU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsth
    ihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Q9bUaEJYFjMGhoRrY1-p6Y9sIi2DDFD8iguPEAX62pdscqF4ajtn_A>
    <xmx:Q9bUaK4wau_FPAfhRgtE2QI7lY5a3-wOwVxJEmxEzQG7y702MQg1uw>
    <xmx:Q9bUaGfuDk8ZAyEAatbKUheDObZg3-9ZPM3G9Pu6bLF6nt1ImfakyA>
    <xmx:Q9bUaNHgnbMF-q1H-XitIsxZbRFopCSfBrPJp1CdAQ80H8begr_JaA>
    <xmx:Q9bUaAe8kIgjujmnUc9NMpnjtAM3nZDM_Zoh1W-hi6T9UX2GmJJM_2fk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 01:42:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7781637b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 05:42:24 +0000 (UTC)
Date: Thu, 25 Sep 2025 07:42:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: phillip.wood@dunelm.org.uk,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: gitoxide-compatible licensing of Git's Rust code, was Re: [PATCH
 6/7] xdiff: conditionally use Rust's implementation of xxhash
Message-ID: <aNTWPSWTaHnW3wKt@pks.im>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
 <5596e569-6632-c2b1-37af-a978de5408cd@gmx.de>
 <dd3a7ab0-947b-4592-a086-8c7028f02ffd@gmail.com>
 <9818dc92-3569-3e6f-0252-245c2bf0bf84@gmx.de>
 <20250923174825.GB1136654@coredump.intra.peff.net>
 <bfaaf26f-5759-4812-9057-b3e0bf7c7949@gmail.com>
 <20250925022555.GA3202669@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925022555.GA3202669@coredump.intra.peff.net>

On Wed, Sep 24, 2025 at 10:25:55PM -0400, Jeff King wrote:
> On Wed, Sep 24, 2025 at 02:48:26PM +0100, Phillip Wood wrote:
> 
> > Thanks for putting this so clearly, I agree with everything that you've
> > written here. Another thing I'm concerned/confused about is how the
> > exception for a single project works in practice. Does it mean that a third
> > party that wants to re-use some code from GitOxide has to check if the code
> > originally came from Git to determine which license it is under? Or does it
> > mean that anyone who wants to use Git's code without the copyleft
> > restrictions can do so if they launder it through GitOxide first? Neither of
> > those seems like a great outcome.
> 
> If I understand the suggestion correctly, it's not to license it
> specifically to GitOxide. It's to use a permissive license (like GPL
> with linking exception) that would make it compatible with other
> projects with similar licenses (like GitOxide).

Yeah, we certainly shouldn't single out a specific project from my point
of view. But going with something like LGPL or GPL with linking
exception would be quite a sensible choice from my point of view.

I cannot really say much about the concerns. Should we maybe ask the SFC
for some guidance here?

Patrick
