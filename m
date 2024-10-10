Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64661C5798
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564926; cv=none; b=UqHhPBbwW2T5S4Ehi2BH6jI44f1EDwNdIM9YjKTU0E2uoxFG6/60aO/pPAgqVh4a3xFadnbyhxEDW1BK6Od+bou4vcWSmUrJLCcuKvg43VfN8iTnlD7w9FV41/zBigUmdAiuPCfltlGz5M37uqzflq//f/2LLAIiX65GEh9RwfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564926; c=relaxed/simple;
	bh=LklHz4WloDGU/xuzY+wgf0mfRx3xIV4ArgvHDafKoh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feZu5GuYKBUmim4GCZQohp+me7ruTYO4lAc0OBRS+p13dQpeR7und4juf8Yqkjr65U+O5UU1ffG8bvbnIuN6eUhyK6QPj0b1qNerKRS3axRydLp6Jlegg92Vhx4Xon0sOnF51Z37bQMj6VIV/8DRRbpE8iPPXxKE0tNVgQBxB8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nPJ1OfaR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OkggbMrB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nPJ1OfaR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OkggbMrB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF2A5114026F;
	Thu, 10 Oct 2024 08:55:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 10 Oct 2024 08:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728564922; x=1728651322; bh=Wj4JX0YFpm
	Wdgfs5XaPXW518AHETj0Fz1D0RrZ48cL4=; b=nPJ1OfaR/4Hev3JcNopN+hlmxF
	Ky0iL886BjqXxwSijFAf7gypDfYwspYn84/LdY+pLU6mZjKpQLP1fAbsZQy+ytxt
	ioYQQ+ilwB4g2vGyejj0G23YSNsZHCa7TKhSAPsd5PCF7DQRjHl9336NFY5BUgm4
	Qf1KJKIOkbMuu5gn2rmx5RHPlCWrtc5aWTovTtLFvipd/+b5hEy9mekVYNgdBcb6
	La3ex7YHTA/Z/ith8Y5nvBzARXlt7JGkPC47as9Ey5j7nOKvULUC0fStYmDfVLQh
	6RoR1+ezTFg/DCS1BiJZjpS5dC1RccfxZSSxms+wrxFI9WHkTK6lVBEmgNQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728564922; x=1728651322; bh=Wj4JX0YFpmWdgfs5XaPXW518AHET
	j0Fz1D0RrZ48cL4=; b=OkggbMrBm0vQZqzMAy1TPsP/eYYn7rmZbx4KvGAdevIR
	/mvS/udp38QhC9WRjHRGg0bsDyWqlMLJdrSZsBGfFYWMgxIFVCVUI6gRl6IN7BKt
	eQqw6FBcgLeMaX0ehpOTxNizfz70FQmkKgH2+o+PzLyzdir9icwwOkccNaDuo7WC
	3LP8QMmafRwB1IW58F259haYA8tFDOeIHPU/1ReSNwHnZe6g5StMjHndy++H7SGD
	59W1wJTSmr8+GdgxGMKtKuA47a7youcOS+gq9BXclz1ZMX+mznyw6763snoemwis
	1TMakG4c+t6aSq0BDnTguI/+27i0VMNHUhlQizAB6w==
X-ME-Sender: <xms:us4HZ_UUr5Lo7NANRd4op6GNBBLuqP4nJMmRAkT9Lsq4U12Xwiil8w>
    <xme:us4HZ3kmMtGM2NHfwv3tHulWYyRUYTTZqiXRbkURzsPCu78GJy9nIggwqIlbtte8n
    xPGRkVnUeBwFXkVJg>
X-ME-Received: <xmr:us4HZ7Zv131whgB-pewlCNEEEOeNzXiyNbqbjglFVJF0gX8PgyOb7KXMYtsX1YIdq4AVZCyb1DfrjALuhbhGh0FGIpqngxrtPMnuRE_2bvLiHpX3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefhedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:us4HZ6WAwzcAlI7ELlbavqrueNBJnBe_DOlRupFKL3wzwsOc3896kg>
    <xmx:us4HZ5nIMU5uisjnG0OT3muLWoOXOf1mPVPifxfXQUNhoKG-myoqJg>
    <xmx:us4HZ3d7XiEnfGRpGL6imVn5enaFAqeH4_JKJnTCAOJ-AHqyPgmfwQ>
    <xmx:us4HZzENeY6F3f_11m5i6jMic1T3r54kurK5QI9uh4wujW9e8WAdiA>
    <xmx:us4HZ-zv6cF6vbCoYJAJcCAKv1Qr0ELo2EgekuSaRkXu2A8Ww2ZrNnq1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 08:55:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd87d5f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Oct 2024 12:54:13 +0000 (UTC)
Date: Thu, 10 Oct 2024 14:55:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] bundle-uri: plug leak in unbundle_from_file()
Message-ID: <ZwfOsoC35x-wyn7S@pks.im>
References: <20240826083052.1542228-1-toon@iotcl.com>
 <20241010091249.1895960-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010091249.1895960-1-toon@iotcl.com>

On Thu, Oct 10, 2024 at 11:12:49AM +0200, Toon Claes wrote:
> The function `unbundle_from_file()` has two memory leaks:
> 
>   - We do not release the `struct bundle_header header` when hitting
>     errors because we return early without any cleanup.
> 
>   - We do not release the `struct strbuf bundle_ref` at all.
> 
> Plug these leaks by creating a common exit path where both of these
> variables are released.
> 
> While at it, refactor the code such that the variable assignments do not
> happen inside the conditional statement itself according to our coding
> style.

Thanks, this version looks good to me. We now avoid any discussion
around the changed error code completely, and the commit message seems
reasonable to me.

Thanks!

Patrick
