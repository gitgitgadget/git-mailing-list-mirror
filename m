Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E8260583
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760180284; cv=none; b=IZt71gKtxMxz/VAp+wzYDk3Gb2gtVrmXjYUZSnBE5ygqq9cfMJlCTxtnAuaCwY8kzIynCC+oUjCzdR7E4mX5SfmMPuYk9HlM1VpV3ErikNNumpjW4fL0ySs3hweQLzbvXSe+M0Cw0egUtJQFgdiFbOv9DMXuulNaJGTI8VArL0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760180284; c=relaxed/simple;
	bh=Vzc9WqbNOmr7IFT3STnhpUhPl+mWkJYu9BZDsejNfAY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmUEj/GnLaPsKWoEVFyOwz9t+keNWbjRkx45tPy4vYNdm9L9YLOvkDooP0nr5+mDaLq42c8nBaMUWiSyTY/0IiVzexc+MjvwdCYYccc+7/ETbiQerCSYoKVWL8vLrsJB2KRB/hWTG1Zxc0zzaJlvcInBaEf+4zYZblyo6hum8HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G5ejQCJW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ljsOb1rv; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G5ejQCJW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ljsOb1rv"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 11452EC024A;
	Sat, 11 Oct 2025 06:57:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 11 Oct 2025 06:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760180278; x=1760266678; bh=xw7Z+7Nuxc
	VmOilPYXCfX1cSg3POIesaiZIvx6smvdg=; b=G5ejQCJWLFMh1lomHgB7bQmdlj
	C3nlzraJYeJ47weDUABsw6xYEm0DGvrGr/0PR2HHrOWSp1fHE1cNfLWzMjFz+KOy
	q4/hy1nwB5DYJJNAvl2hqdW64EYzJURGuPjSzQxm6Von04r7nZngyA/GnU5xthkN
	T5ybfVD8Wiee20k9qgLjnNYxFFUv/7z3zTu8CwZ/JwoSDmPIwUHh6giy01FMuvrc
	NJJ2G6MCNs9CaLdU4NgVSywjlg7djyOTjsmpSoQO4OxBMQLQsuJFM57l6Mu2mt8n
	V02UWr27QrOxWAOT1H4vDBTXZeqpXhVwaPxkQS80i3PBig3xJ6CH6G9Jeeng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760180278; x=1760266678; bh=xw7Z+7NuxcVmOilPYXCfX1cSg3POIesaiZI
	vx6smvdg=; b=ljsOb1rvmJsH+4seV1Db+imA/e0ADDbk6lMhbEgMTv0GqSum8RT
	SfyFADF/R965r6lwmbcY9ZQIFIvpQm5qQfhEGVRA4R7/xjd8WVGtb+6uTLqb4J0Z
	+c4V+JIbX57fTyW0WpCCcIIvtuXhiqn6kSjzwzlnfrZ2C9vEO4ouRF6/1Vo3IQI5
	SOGJUBOwjrutUKBjN/jgF3XlY5qT+JTMyQ2sfgWRZXzxZ0ZndoGiVrTlqT1pMNji
	YdbVnyTp4dF1CuXmgYlHXNVX/bSIhULDBM+7mQYqxX0SxStAIutDdbR5P37Dyx2H
	baaxXI6PK2U7bhwCZSLTc0KKXyP6MkEiEjA==
X-ME-Sender: <xms:NTjqaMx6gv02w-ZU19csnm6K1jqAV9xxSrEeIgX0ea4pb7jBqXQh8w>
    <xme:NTjqaHuIw_gYIMEhfnuhBKzzwvQfovxGqWx_EpT6pa3ApoKMVICx1hWQ3QqzAea2c
    2am08TJDsSXxdXCS00jQJIJnwmmsxM7JgAE3Ms240DC5t3YXD1BNw>
X-ME-Received: <xmr:NTjqaLumwUcHHXneGmR_W5f1hGlojHBagz7c_o7L9_FnfOtCuD-dZd7nQm96-R3-l47eETT__uuQJ4Y6ZMmcwc-z04_A9MYVfPohka2IMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepfeevfedujedvhfduheekieeijeegffdvteeuvd
    dvkeevvdejhfelkefhffeigedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:NTjqaEODblCa4Wx-FKNW-JCr7rA-jHv53TyXqik911ubzjbyhzsQFQ>
    <xmx:NTjqaB2RIQ-iU7sC3jYdU3bOG0aVhMA2nWNH5LjQ6eaSh22pt8xVdg>
    <xmx:NTjqaINY-JAaYcanjhqcGTtWVUm-3DQy0KHvITm3Td6nYWbdMHvclw>
    <xmx:NTjqaJ1r2nmaR1sSmqKuOdRch4X9oT5QJt6uYWlA9NGPI8pI963jbg>
    <xmx:NjjqaN5ZId7gaihEQo70Zjen3_b4t0oZr7A8QXO0tJ_MaKdu-GQ3xGdB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Oct 2025 06:57:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0acc4fb5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sat, 11 Oct 2025 10:57:56 +0000 (UTC)
Date: Sat, 11 Oct 2025 12:57:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ci: fix broken jobs on Ubuntu 25.10 caused by switch to
 sudo-rs(1)
Message-ID: <aOo4NC5zZDYMr0po@pks.im>
References: <20251010-b4-pks-ci-ubuntu-sudo-rs-v1-1-88cc846d251c@pks.im>
 <aOl7jFj9Ftd4wNH6@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOl7jFj9Ftd4wNH6@fruit.crustytoothpaste.net>

On Fri, Oct 10, 2025 at 09:33:00PM +0000, brian m. carlson wrote:
> On 2025-10-10 at 09:41:14, Patrick Steinhardt wrote:
> > Ubuntu 25.10 has been released. One prominent change in this version of
> > Ubuntu is the switch to some Rust-based utilities. Part of this switch
> > is also that Ubuntu now defaults to sudo-rs(1).
> > 
> > Unfortunately, this breaks our CI because sudo-rs(1) does not support
> > the `--preserve-env` flag. Let's revert back to the C-based sudo(1)
> > implementation to fix this.
> 
> I've requested that functionality (which I also use in a variety of
> cases) upstream:
> https://github.com/trifectatechfoundation/sudo-rs/issues/1299.
> Hopefully it can be implemented in time for Ubuntu 26.04.

Awesome, thanks!

Patrick
