Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48FF1E522
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 05:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742968486; cv=none; b=Y1qL7OyWuGBBWrlT1Q+hcLW016MXYCe6hrrmfyNl6n3HlohH1sd1qvE46XQBCQkIyvbIgbImYtAt9ugtdHLS37eYyodvJFqFNGlyyDAsoxqIuOtLDoBl7EgAVOy4ymkcN/40k1rh4Nkyet0wJA8rKpZwadAK5pur/yGW14+o8fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742968486; c=relaxed/simple;
	bh=86gPiAEu7voRgTQwmzS0MUC3W4H2EKg6DZazMrEj8Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cszbads5rZ8/nmJNBtsHffVAJJDCS6WwvqAAP4gibO9C05EOQoVQQ6YDhNUnPQjkq6lMvoscR1aywTuy9ZHmU+Plu2+SG0hfbzSjWFHxfze7n8KBAtoIe1W/L5OT2zXx+nyvZKYGJJn1kVs2LgMFeLBthphGIRbsf+Ar1QHvQQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T8Jqrc4d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ulud/K/l; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T8Jqrc4d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ulud/K/l"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7CA09138380F;
	Wed, 26 Mar 2025 01:54:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 26 Mar 2025 01:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742968482; x=1743054882; bh=yFyEYXlNgz
	GZ29o43wGxXqpRsF6lnzCyE1c4W5jAbTk=; b=T8Jqrc4dfbZb8E3XqY1fijIcz9
	VFqsva7nXTUK75zd5rHNh9SBNQODdz52+dnPzk7LTHXJPLxh2G9jKTjtzWLeXrfZ
	0PGOrJmZzYTYR+t+1otqG3kIOYR3IOx94X33i36nnkbmOnDMXQcCvZzek4tcPNQl
	j/iRBweJHeC8954OWB5mmKTvJXkYgLVzQyRtRfm+U0s9FAeH8jxDNmltX8z5T589
	WHWa2pPlgd2yMuBQG5JPO5kxhUWOh4dBp5lzHt+ObS0lBRl8Zmc806NvvSYqef+P
	jy3KvJTW2qEDvW0Wfa9FbC4LokkehoqKUjaJjry18rGUOMTIMH1iUTv7iddQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742968482; x=1743054882; bh=yFyEYXlNgzGZ29o43wGxXqpRsF6lnzCyE1c
	4W5jAbTk=; b=Ulud/K/lq9XwJDDxJVLHUOqUVCtx8QBAIFRHGa904/gzHU5jw+1
	7CeucTuawa5KGmdBLIbCVxh2iXoNTEjrE+GSsS3H8rb4JK/3Cy9QdhKdhYkzRUrM
	qcp3URlWoqmmiyNwvZrFsVTmg9Hg+4oSYhZ5+uTO122YXp/FLeM62hRMoSZLgRxc
	IgXrNmJ7lVJ9j4yxUWBkXbCVSJdUam++83ohg5B8JA2Iddf+Z9LAXDSUTh8Hi1I+
	7vI9W40PXgWhopt5OHqkr4sbBlUpGFVuyFKj8055BsEEMcaPpqAQogUYfVXrO0Pp
	mUmVNft7d0qwWMRklHoj/xLCRn9Cu2q53Vg==
X-ME-Sender: <xms:oZbjZyD9KGzumQnHYPELC5DJGqgGn2CkMo06x6BdIeMvrQ8NGdCA_A>
    <xme:oZbjZ8iiVEJgKtQaZ0ocygRnozikkH4C8a3Voj5nSPVAM9diKQEdcpsfifcJQzQ3e
    R190gxnNy4-aRRH7w>
X-ME-Received: <xmr:oZbjZ1lXCcDfoWDrcNRw5N0tpdx9Yu2DzRb0XJ5nAL_zq8kRbOy_sihQ3ukm7QZ-ZFt22ljS5GQAvHGDJWgFDXLnEmgg1vnahHFvnMSOGV9kxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehphhhilhhiphhorghklhgvhiesihgvvgdrvghmrghilhdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vght
X-ME-Proxy: <xmx:oZbjZwyTYyFMezM4FFGvyFuCJs91b4Caxj_xhQfVOKURspVhEJKsGw>
    <xmx:oZbjZ3Qo1uAI8z-e3jU2-14goL4S-xM14hcsVaMbhagekfNHviDw6A>
    <xmx:oZbjZ7YNXoeSI1GwP2ZqJdpEfgjRy_i-1l19gmfopCHRfP30nD8SaA>
    <xmx:oZbjZwTswg3t_iWK1Alqo42ytjh-bZ3TSUKCpdtu8Kud_PwqyqR68A>
    <xmx:opbjZwRvzDWP45S4DdJbaNwBoyndJCtNTbAvmxS3A-S0PUMvug-g4mce>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 01:54:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e7c5624c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Mar 2025 05:54:37 +0000 (UTC)
Date: Wed, 26 Mar 2025 06:54:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 04/10] clar: avoid using the comma operator
 unnecessarily
Message-ID: <Z-OWmSe3vCDaZLXy@pks.im>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
 <f60ebe376e10d7741f6bd657874a17f6c09d4477.1742945534.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f60ebe376e10d7741f6bd657874a17f6c09d4477.1742945534.git.gitgitgadget@gmail.com>

On Tue, Mar 25, 2025 at 11:32:08PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The comma operator is a somewhat obscure C feature that is often used by
> mistake and can even cause unintentional code flow. In this instance, it
> makes the code harder to read than necessary, too. Better use a
> semicolon instead.

This code has changed upstream already, but let's roll with your change
anyway. I plan to update the clar to the upstream version soonish once I
have landed integer comparisons, and will take care that there aren't
any other comment operators left.

Patrick
