Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486CF1D47D9
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737705705; cv=none; b=MyaT4C461+NDFaCF57I9ktkPpr/z5fEew6CbabuXAAroi1mo1/qEfEKjAzdyhRh+h6iOOHqhTsGA0y5BI2YqToAu7akbKgh/ydj/6caylGvJce9KV/ClE3Sc9pTWvuRI11mo9Pj6n+nh66dVs/HS273ap8f8GspR/Gf2ay1nbfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737705705; c=relaxed/simple;
	bh=hb+2gSQ/Oj0UYTEI63wV4UOn64XDCT3WgzZCV4Erw9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COf+RDDr7BesAzisXfovPxg3tTVEySXh/MLFaeiDTZgv0UzR2mU10BXIEwTuVOOFagUFnTDS18w+DqaIhRDuj0qxtGuFYqNBNCP7FYzJ+rd6vWSEj+sbVBd4Yvxc/LkqUpFqS1qXzDP5sn1Zl9ss0/CxWbnv8e7qNjkPT4XYoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZuZI760H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NEBxJpBM; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZuZI760H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NEBxJpBM"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 41541114013C;
	Fri, 24 Jan 2025 03:01:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 24 Jan 2025 03:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737705702; x=1737792102; bh=vzVrmpdHBL
	prbn6FI4Xo37Cc+kqQA5tS739kgtctiEk=; b=ZuZI760H3u8lp+51svT7cXjqI0
	NeZkDfqFizdBnmIzVg38N8bBsa0Yd8VjUApuC7NUcmbSG0UW2IcLJHy6qtZ/w3ku
	KLlohY1+pliCAfEHW2WBsYHg7P2eCkLcR41MVqjhYCcNH4I+WfT3JKGZeHlK8DdX
	elbrYwsVhi2ou6WvmbNQmPCnYrLUT8gNWZE+HaFPGLDFNr/v/kc1FSjQEltIf4U9
	zInjS96l6z7/MJq+WL+B4VigCQJpeXt+nIvLjGEVUpNZyWR2BuOu0iIY8bwp/jwD
	kjTbEMclO49ikJcNI86Cv1mweIZhdqhXbVQPDNsJA9hquJtHEuI/cvsYpv9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737705702; x=1737792102; bh=vzVrmpdHBLprbn6FI4Xo37Cc+kqQA5tS739
	kgtctiEk=; b=NEBxJpBMuXnG8zp4p3OFXScbw54vor4K/WWMCXmwMEYKhspmmIy
	AFfdx+zL+RoP2wAT7au4zjWnl+neFj9vNdNA10pPzI7Yyio/Oi3lmX90yiy5af1+
	cKlpe9v/0Lum53syK+rzOSbIC+ZFojVWRyYPS1NXxBUCunKFPRVzh82K0tEIVDmx
	5QBGjgB+IwP0JDT+p8jAXcxP+0B36S2L9dSzBgfZrY5OmlBLqMi11xc67F5e86VQ
	ksc0Z/EnebnBQWRUO6es+sIrweBy2JnI+nDKlsrL37zz0kwLB5Yl3BPAR9aQdEjs
	pKUuuLHQ09r9TnMQD1b+F5REHSzj0/Dkckg==
X-ME-Sender: <xms:5UiTZ_fowmsMoqgBEVjm-XYv6sj_LG1jNrMIOzB7D3gtunfigo83dg>
    <xme:5UiTZ1M39TwOnY5fysJCa_yMxUxw1uZhanUo7zZ7L-Ws3rLFYZV0wzoaG31B1yeyK
    zxEDtKvYBfmv2cpCQ>
X-ME-Received: <xmr:5UiTZ4h4ATbmo8eBu6eWG3h3Bg-Qvw1BBb6dwxAVcFVdDsqczw18T6h4W7rvsiokEdAMTbDHyGfg3Sh7xQVglLpL1S1tM-yLMFvEZNdNLHwwKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgfeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejvedugefgffffieegtefhgfeikeevfeefheevvdeg
    ieetgeeujeeliefhiedtueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhusghhrghmrdhk
    rghnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvvghtshhonhhife
    dtudejsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5UiTZw_uLaNFwPIiq_R_Wth4fnrZ2OocUrZNX9lFhZPjkgjhTsBLBA>
    <xmx:5kiTZ7uah3I3rRT_xHDxHgFFrsgyiI2gSLA5jqIj44m8PA-B4jGzlA>
    <xmx:5kiTZ_F_C-iWOdWfZAfFW8-Oi361p6x-PyNVqoxaYKKxXHBjOOwaAw>
    <xmx:5kiTZyORoYSeEmep64mmrfRHw-oJSHgM6Vg6MlulqDJoWabP-TPERQ>
    <xmx:5kiTZ7KSbyBFIyqyYkgTJwqxcObpH8PIy1c4zzXrjce8lNUy7n5FG2vx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 03:01:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 76dc5358 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Jan 2025 08:01:39 +0000 (UTC)
Date: Fri, 24 Jan 2025 09:01:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shubham.kanodia10@gmail.com
Subject: Re: [RFC PATCH 0/3] refspec: centralize refspec-related logic
Message-ID: <Z5NI4uUaeHknckJY@pks.im>
References: <20250122075154.5697-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122075154.5697-1-meetsoni3017@gmail.com>

On Wed, Jan 22, 2025 at 01:21:51PM +0530, Meet Soni wrote:
> As Patrick pointed out in [1], the logic related to refspec is currently
> split across multiple headers. This patch series addresses that by
> relocating refspec-related logic from remote to refspec for improved
> cohesion.
> 
> There are a few functions that seem to be on the borderline. They seem
> to have refspec-related logic, but also contain some elements related
> to remote logic, so I'm unsure whether they should be moved.
> Specifically:
> 
>     * get_fetch_map()
>     * count_refspec_match()
>     * check_push_refs()
>     * match_push_refs()
> 
> [1]: https://lore.kernel.org/git/ZysQvUyxgdRqjvj2@pks.im/

Thanks for this series! A couple comments from my side, but I think that
the overall goal of this series is sensible (well, I seemingly proposed
it at one point, so no surprise there).

Patrick
