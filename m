Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B942D323D
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754913414; cv=none; b=ZyjGDzV+XuCGOL84jrVTRX0YjQZ436qHLg0gmbHbhwnZnE9ecTKhd7qHEfURhHp0KLFfXbTQ3XGI3ERBF4Mrh/bLXYbTJPwldsNWDm8G88hj/WqlvdK77CuKzLLz5x8bi5by50ZVPrHz8xfCV7v3B7e7VswVRqHStCQ6lgG+r74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754913414; c=relaxed/simple;
	bh=akra6cP53kTcEVyPYXAuKGKFarl0Dr4cFq4UcyIQpi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwxV3Baz+k7S8suFI3lOoxWN2eraCqV0vzc1axDaVpA3Oha1s4mNvzMKkYePQe8xxAmjUhX9UOv9w7h/F3BTzH9lk7USWSJi+PFMPhaEetcanv1eXe3sjDbpOAGXNHf0Mo4zBydsEzLuymiPwULhzs9TTgL41fKAhLljcE+9eks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R5o4PngF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3vds+Hu; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R5o4PngF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3vds+Hu"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 41D1DEC0083;
	Mon, 11 Aug 2025 07:56:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 11 Aug 2025 07:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754913411; x=1754999811; bh=mJRB/6Zw1i
	dBG7+SXCaCp8BWp/kIjF+QLv+Fx5O5rNA=; b=R5o4PngFjaZLyJpbT+pMah5aW5
	Ngs37nPmp8dlhJr55E9M7qJpOBvlSlXKd/A6zRmd47f9JaraYAN33/3lfA8gi2GR
	javKjZOLGQws+ypsagcB2S5xU94gD9ZF7zRGi1SuqF2oM65pu2gVK7U6pSHL7cMX
	H2SBMhs1+KY6/rglmUt0hvIymNv+3UjjDroyw5CHuuJTDwSJ+OKK1rgTZjhHc2BE
	Vj9I8hyXS1sy41AnaqcX1ruumLn1dYD9Cdi3DvbI/5L/vKrwNM5llZ3B6G5ohT2A
	y8Azg8oolbOexv4VTPELR3Vhqd27FhBZXyxgjw6B3M5QC79QNkIEUxtRISyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754913411; x=1754999811; bh=mJRB/6Zw1idBG7+SXCaCp8BWp/kIjF+QLv+
	Fx5O5rNA=; b=k3vds+HugprqjY5lBmipQAQnzGXrBTvk7SgST/Plc1lliyFaagw
	3o3rOoEDYPzO9vr8xOmDpj7Xqw4NIJs4XLc1pUgLnNZaDaaAR2raz8qTqcZy3MRS
	u9tyiQCKA//eOm5cLf9lN8sB5YsQRUASTAl0tdrKgvCXeOxs9D7GG2O4pwzEsHdT
	IbwqZ5xKjlNK/GPjyEUZdozxNvGJsKu5UeRXmBTQsfwllZq4L2gPBnqYG93DV823
	SsPcWYRM7LT7rPAerCUr5lvu3hhTOd2vsB21yACL0wfWZqiVGAKaJrygiqTdTfmF
	Z+z1LJ3hCbkmNtyqTBcf50fRhkGhWPm9IcA==
X-ME-Sender: <xms:g9qZaLDQy_rbHKdllnlawcOLDrFfDeuDQm1fpl0wyEIZ3rCkHYweXQ>
    <xme:g9qZaEwDBB16bA6m1ZaHHSnJKmdYHbhRDO4nEp4oxToqpApwFbDIaNFDscbLL_O3t
    dgrRSafayp2KNXcLw>
X-ME-Received: <xmr:g9qZaAAzhtBlmwGi-SNP084Gjz1KtV1yN4i1Pk3aEzHYYImYupdhfRDw7DbyjcEJzSllZKP9dYVIE2dKxrmtedlGeVRD0ZqlGt5JiGMwJCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:g9qZaJYyV8naLTB3Nb3_SG45y3fIm82DyFothg_RKPPvWfuKyQNu0w>
    <xmx:g9qZaAjPbNKdTqOGXaiYAiaKRI6PtiCeyTz2pJ4OsjzIz5yjadS5bA>
    <xmx:g9qZaD5giJOjeZT2hXRV2Hi4pn8TYmaCcyyuNuByG-A64kCoBD8KSA>
    <xmx:g9qZaP5u3ze78Nb9SbHVBdHNYoZo-N1GefHods17hA1K2PjEccN-RQ>
    <xmx:g9qZaBlC1DCFFKw7XeMlfg3zWnLWkxFeTEXPCmxjTGSCLVTJVfaZPHeh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 07:56:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b2b20fe (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 11:56:50 +0000 (UTC)
Date: Mon, 11 Aug 2025 13:56:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 0/9] midx: stop duplicating info redundant with their
 sources
Message-ID: <aJnaf_7i08pGvV43@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
 <aJUoPJrVfGS5l9L1@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJUoPJrVfGS5l9L1@nand.local>

On Thu, Aug 07, 2025 at 06:27:08PM -0400, Taylor Blau wrote:
> On Thu, Aug 07, 2025 at 10:09:50AM +0200, Patrick Steinhardt wrote:
> > ---
> > Patrick Steinhardt (9):
> >       odb: store locality in object database sources
> >       odb: allow `odb_find_source()` to fail
> >       odb: return newly created in-memory sources
> >       odb: simplify calling `link_alt_odb_entry()`
> >       midx: drop redundant `struct repository` parameter
> >       midx: load multi-pack indices via their source
> >       midx: write multi-pack indices via their source
> >       midx: stop duplicating info redundant with its owning source
> >       midx: compute paths via their source
> 
> I read through these patches, and they look pretty good to me. I left a
> few minor comments in the first half of the series, but nothing
> show-stopping there.
> 
> I would, however, like to hear from Stolee on the --object-dir stuff,
> since I am not sure if the implementation here has any unintended
> consequences. That feature is (as yet) mysterious to me.

Thanks for your review! I'll reroll even without having heard from
Stolee just yet, but will add him to Cc for the next iteration.

Patrick
