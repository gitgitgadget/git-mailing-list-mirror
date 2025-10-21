Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E81339A8
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 05:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761023806; cv=none; b=tGHrEAvJQz3t44qh4SJ7NWp9gtXUYriroYk/sGRyQK/EjYCU4yWnvxxVUehxv6Ctwbo0dZi7TPF/Jc8vl7UOkpZJAXd1ecMb6GfE6u57WYanrEcfhxruaYMylg1uCZdUEaqkB5jIeU11wHWSCQvrLk1DlITq9/x6Lh+2vkgC+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761023806; c=relaxed/simple;
	bh=M1Zapct3JRxTAdatkOvpecbrXk++CSz4ddPptaYeLQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bylRL8lTcrdAxMx63IDaXXrGXXkfleJuPyek01zN52EA2s/4Vy+ggiCelRzOil6QUngwsmY7zmc+v3JIxe4IESQP+5yVORlSXvuxLooRaxFhDp8QcHvHujtF6BG2cmRkTxD6Px5Y4s3nlATK1bUdjtW3M6RUkE0i0Hu1n9oIouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dE0bYNm4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VoZeIVmM; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dE0bYNm4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VoZeIVmM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FB9B1400192;
	Tue, 21 Oct 2025 01:16:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 01:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761023802; x=1761110202; bh=PQmWt+jrIS
	gAKneclS/+8XxXAoIuncqS7sFMZBN8zlk=; b=dE0bYNm4C2ZZyDK4X9mH9HfgzW
	+svQlIZICvaomdrsyKhjt531+W0DnY6GkFsvPDtUegHMIU9rTjw+nUp43wxy65w6
	srrhBrL2oQlDFRhqWY//0Zy8NwhpPF71QLEuWnXC8CsNHscPeDNsGqvF15ZfkgJB
	C20RxuiabKayoJ/7i8N6Mfv6jU2m8CymkUO0j+4ST57gYjmkmV24gCt/Icuo8xDe
	mQQTOxk3VJHMzMY3kV+04h85RKxtU2/FyiHRMqdWweWETVpX+p+4j1YBMOm3+05q
	owtbywJPry6ZZi8++WwSTWVC47vlXae23UlwFXAJvxrLYXb+ghRHDB9LRt8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761023802; x=1761110202; bh=PQmWt+jrISgAKneclS/+8XxXAoIuncqS7sF
	MZBN8zlk=; b=VoZeIVmMmHEjSctEp/ALAHm8rbNhOfNBjuNquscO1IaRLzPSjWA
	9dVtUwNKhsr3UYgNcfujQBe9927EyU3AcRJj5M92mibZSWIFNQMZ8dXmd0Jm16bp
	kAAHJpvP5s8zfqREPfBpw7/+Fsgv9aHcNOotSj8xoA8Yob1+wPRAnNuKa1rbD2V7
	2irx+4Qbe6FHprwkrOuxu9QV0Mmul1ICsuqFM4xy0EWaQTEpk4mvIdtNoN2nsuYB
	cmi9ooPkWRil1ixnVNMNYqyePRgC9ckKQzJFS+R6a0WkcczhqORafVsrcGbYMuK+
	wUoG8lLrCHGOWmFdcluvw3D1ZG4gEHENZTQ==
X-ME-Sender: <xms:Ohf3aDrFORlgeJp--P5M82ZEXu9-vc9y5vZAp91PMpZmVLMYOKp9ag>
    <xme:Ohf3aFENFXSDYIF66mZGH5eamoJs4b-56MuBOUN2xYEzqkJ7wvzhmENw7_b4V1JHv
    0sYlkLWJ9KrS1PIdFXV36fDuzULk2ZXJoVF1Qt-RQvpmAElRsY7yg>
X-ME-Received: <xmr:Ohf3aNl5FxBnGd4MNtb2LLcZ6rzlZu4WXTS1yCyphvNmTepQ3vbPXf8ehgaMBbU-gQ7CkSZN8PWWOrHNklVbouycA3i9M2AI2A9eR2Nv2Yj54w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeelkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Ohf3aAlbTlzzlmrxC4oBZKb4UMXsmBKx81vgP7uOkA3AA2PkvSx0Tg>
    <xmx:Ohf3aGtU1NfW_3mC5jRHfVHmE-FRhmC7INFP0yG6_IrEai9LrEItZQ>
    <xmx:Ohf3aLmUdVDqqyxj2iNWxlAjXD-1v9qf8bcnBHyD37myGEPrv2PpjQ>
    <xmx:Ohf3aJuSDdwQxA3gZF_PiI85Phx02YDN_CpRgn5dpHG-qGoAIc5ySA>
    <xmx:Ohf3aKiSESxqiReSSJ97Ttl1DBFisokPDGR3O9OsGlAaNlrmQyvuxd-O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 01:16:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4466b594 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 05:16:39 +0000 (UTC)
Date: Tue, 21 Oct 2025 07:16:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH v2 0/3] refs: cleanup code around optimizations
Message-ID: <aPcXNOz7HdxfUzcC@pks.im>
References: <20251020-refs-code-cleanup-v2-0-f5349ed0f6a5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-refs-code-cleanup-v2-0-f5349ed0f6a5@gmail.com>

On Mon, Oct 20, 2025 at 10:18:28AM +0200, Karthik Nayak wrote:
> This is extracted from a recent series I sent [1], which I've since
> dropped to follow up with a different approach. I think these patches
> hold value individually.
> 
> They mostly cleanup code around 'git refs optimize' which was added
> recently in db0babf9b2 (Merge branch 'ms/refs-optimize', 2025-10-02).
> The code in the refs subsystem contains both 'pack-refs' and 'optimize'
> functions, which are one and the same.
> 
> This series unifies this to only retain the 'optimize' functions and
> naming, since it backend generic.
> 
> This is based on top of master 143f58ef75 (Sync with Git 2.51.1,
> 2025-10-15) with 'ps/ref-peeled-tags' merged in.
> 
> [1]: 20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> Changes in v2:
> - Squash the second commit into the first.
> - Change some variable names to also no longer refer to pack_refs.
> - Fix commit messages.
> - Link to v1: https://lore.kernel.org/r/20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com

This version looks good to me. Thanks for all these cleanups!

Patrick
