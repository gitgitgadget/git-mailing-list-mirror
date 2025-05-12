Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7078118641
	for <git@vger.kernel.org>; Mon, 12 May 2025 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039029; cv=none; b=PS5NMf0eRgMahJ1QjD82lE1vObfgoXNtJMRaIi6Dl13ebUytkhfAfo0ro0nXo9pdSFTI/LEHxnLPjTY+oYqcRKXgDXAbi+m69RjXoqxub1H8TafHbO49ZocCdw2b/4lQPPUk2PhMIP0pZPz9x4VP9IV3AR8xjehwEy7HDl10hJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039029; c=relaxed/simple;
	bh=scscPBFvjaWjPCkYF0yKfv8uxMMIf4EG8FoaTOaVgME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpcL5MsvcTz3dqtttH286Ea9aU97RMRTqvmjpEglhAFspi8dxLVVhx5iQQeIpadovsmOWXkxbBAeaKVNbhpZLtCBLIZCU3i5Tqq+78RUmlFb4k4EG2ON7TWMWYNk5a3Tnbub3UqTx6BMl0kssSljMDi9zWlWtOtre2gR9/86gxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NPrL73J/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qsi9XMOA; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NPrL73J/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qsi9XMOA"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7DA04114011F;
	Mon, 12 May 2025 04:37:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 12 May 2025 04:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747039026; x=1747125426; bh=4IBJKwr7ox
	vNDXQx9Ux4XDI38qHb4ThD+6IrXAIBJoY=; b=NPrL73J/cyw1pNcrT/FQCgEds5
	x3xkB/gQavJE+vu7twHduENxIfWuw5xLXrPjoZsm6ZH5suCz4YNoUZPCy6HgdFgF
	6c3o+Vazuk6vujFFGtUMYTe+pJAveGrM7NvO+Ib1GhGyCIesJinXsDW/ee+vTxzJ
	DqHULelzqh4t7rSKaqMJzEDqk+UHB1p9R7jjBJdG+1bNaDnu2yT+MQZwkV10KEa4
	xlZVyqavi+kwwKM6GzSxd8xVWS0HWNVyWf1KmnyYW/e7j/ymlGDGUpVY/C9yoR2C
	VlF8Cu3Jl9DPRQ6e9YiH/7yS0fTZKb6wCgYF0CeDKKoI2hWihZHps++xsxNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747039026; x=1747125426; bh=4IBJKwr7oxvNDXQx9Ux4XDI38qHb4ThD+6I
	rXAIBJoY=; b=qsi9XMOAhInki0bb98AoinPC8s4vZ4HwN5bROGPufhh5nlkMvQ5
	9XL5VQj+M2VvHufDrND1GIsWceoaSFO467XU9O2Dc4MXFcC4+p9OTzw3BSJ8yfJR
	MffOVN1n5qA91u0PFm80ABINWwg/L6+kFNx9Qx3D46tOg61W3Fj4zWtd1pgPZ7E/
	FBoaqZtDcp1DBtDEGaJs6hKqAZJI07bYrLXV59fcoydr6aHIq1//jIxnx4jZ3uo9
	1JslndTV5ee4cRyRjGzxFo3USa1X3bQMX6u7TY6P7ncwJE6bHUYpCLUTY9g2JmWV
	IZcLgQHnay57kvIWWLZ2U+1MTzi202PiuiA==
X-ME-Sender: <xms:MrMhaBl2-PGLr3dy3_MxVWok2goGssAflALln5dG6mGDC4ipXxXl3w>
    <xme:MrMhaM3a5hVVOWXMjstcvcDSb3MLJfxLLAAqX0dI7KLja0XKwEM-m_VlDkj2jHpLb
    0-6e3s847y4YnZLww>
X-ME-Received: <xmr:MrMhaHqvOy7rtDYD8_2xAJxfs460HTYTQ6llQ5v3eAbR0bCF0gEvIX3J4_CEZ1xUDZCgm9TGFPuG3auSNNKi6GVkM-Q75uVpV4JcLsivuFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejtddtge
    ffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MrMhaBm_bCQshoHYmU-hjZPhsZHAy21deWGljW9owuStD0cv2nITOA>
    <xmx:MrMhaP2XTUsfK2egs7w7AbUBrGDZ9H49MA8nbJi-C0WvnprmP9_6fQ>
    <xmx:MrMhaAuhucopiZDOv_0Pe95RkFZVv5YWd7mEyCg0m0jVnqXLUnT1fQ>
    <xmx:MrMhaDUFe4oe2HkORKVZhZv5ciqbKN_9y7yRFUm80jweaDNE3fbGng>
    <xmx:MrMhaEMzhDqpJ94jmdH1CpMeOldVhY5jHxS9IS4KJhFTdQ0vHZadEQt_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 04:37:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 916c905e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 08:37:04 +0000 (UTC)
Date: Mon, 12 May 2025 10:37:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] packed-backend: extract snapshot allocation in
 `load_contents`
Message-ID: <aCGzLxcXlcQLtorC@pks.im>
References: <aCCtQDnWII-knmEc@ArchLinux>
 <aCCtzm2bDRSTgEO-@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCCtzm2bDRSTgEO-@ArchLinux>

On Sun, May 11, 2025 at 10:01:50PM +0800, shejialuo wrote:
> "load_contents" would choose which way to load the content of the
> "packed-refs". However, we cannot directly use this function when
> checking the consistency due to we don't want to open the file. And we
> also need to reuse the logic to avoid causing repetition.
> 
> Let's create a new helper function "allocate_snapshot_buffer" to extract
> the snapshot allocation logic in "load_contents" and update the
> "load_contents" to align with the behavior.
> 
> Suggested-by: Jeff King <peff@peff.net>
> Suggested-by: Patrick Steinhardt <ps@pks.im>

Huh. Are you sure I suggested this? :) I cannot remember at least.

That being said, the change looks sensible.

Patrick
