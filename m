Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C42DAFCB
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902812; cv=none; b=QE5thL5giC58++/pbV0YTj0HQBw8xzDv3h9eYQIayEYshPAcPN1wbcqc9F+Z6+5N27uyH1Sk4tPXQXWcqbVaMENu/5HyZF+YaAWkgob9LksIP4kkuYifS0Lbn99SLHxrcoJQKqfmMIw9srHOPRMCRjY6QTluMScMsOLvRIiuRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902812; c=relaxed/simple;
	bh=Qpd9Mfmu8vYG9qYrZJibUKOuLAT6+lGAILBCDDHywd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnqvT1SCsGSIERSHOUCpKMbcEmXLk4iANHv4XdTuiBAIdH2bWKbKfhEqTOrb20fpggEbCyN5hZzUT1jVhftds4X43jna92UkgGMrUpsEzVzPKlmPZfEGKtL/qbeUS+Nvu3l+dvJYy2OZ7UJXhHTY/JoVEqR4OboGZfE9P+R47+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PhQ4uQ0Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ad/RNQn/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PhQ4uQ0Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ad/RNQn/"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id D2755EC009A;
	Mon, 11 Aug 2025 05:00:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 11 Aug 2025 05:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754902808; x=1754989208; bh=5r5hw9p5Qc
	EPaHKe9NaKDCitO8NkZ1IU8QKm3JN/Btw=; b=PhQ4uQ0Yt+Cc99HpY+hWkkWuFE
	AxL61+86lIBg8YspXg7TPzbM+DLpCmU9XEGKF1jGhyMcKBF1Czk27AekuIczA6Bu
	Glln7Bci1/RV1KDZeGkKSrK1RrSHGIAeXIiAPgVVpq3G5328dlpScjbBxYL61Ria
	rrNL0ffgMP/R3Hh3PReEnzFAzc4j3xVAVcWuCglnDKBv1kvdN+Aa1Cjp6U/67aDF
	L1rEaLOOBqTokZN0bzQfEBjVUmce4UvMIddKvKpj3FX3JE73Ag0BIviO/UzMyJuX
	G0B0L8dq3LqMvnpI55MbPobZEwhorBjAgCJ9BIjMRmbYvCzccKcdASHWnlqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754902808; x=1754989208; bh=5r5hw9p5QcEPaHKe9NaKDCitO8NkZ1IU8QK
	m3JN/Btw=; b=ad/RNQn/MHJ3hhibmsFO9jngsf2M8fyg4I2+p8EO9Quz5ch7ilh
	xNbBrl41fyTalhCJsZCt1JRqoyC8SIkyINeJTN26hiGNuMHVQDpoIQ3ai8Ro4xXz
	6BIScaVQzkpQw0uEpCFc5yThuaU1g+GRGc987VrgNI2KbW64v0DfmS5aLxf/THb4
	iip0W10kpYf6SlMw+Q5+f3zkflSF3qaK21q2isW/z+BvHQAxUraa4XUl8wUB6jEu
	xmyHeQCU8Rw6M352RZ/OLbPLL4PhNxnmSAu0rcn0ZVVbonOIbN5oo2WXe9tmwyu4
	DK2DHxMAQxLUf1RmrZeXhHPSJ0F/HgzBVKQ==
X-ME-Sender: <xms:GLGZaHhFpljZXOCWyi9c7rQ-G8BbW_99PRIWXhh9z7xskg71O8fxDA>
    <xme:GLGZaOlxv6nDALIY7btDVIgQk1cEjg8hAeMOjqpa0C0SFiPraFlZkJ8fdTRHd57DG
    YvfaKXBYTTAeIcjeQ>
X-ME-Received: <xmr:GLGZaDrkxjDXQpzEW2BmzPeUlq4fx4SaQmtrznfYwY3_RTnDZzTJAKnnO6-_LZDevixtIjHgthoHjOAVl6j3vKPN3T0sZqSpDQUk377j_Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeefhfefleekueetudffkeelffdtueffuefhiedufeettdeugfevkeffkedvtdefnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheplhhiuhdruggvnhhtohhnse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:GLGZaHF-dNSY4XMbGGpWEWRZ_hprPkgoJdFh5IFwd36ScItT1B8AsQ>
    <xmx:GLGZaPyp9fvKTrJr2Zay4V2kJTjIgWp7-Swoja-7afKG9om5t66c0A>
    <xmx:GLGZaMrbjMJDl45ohHh_XIvcFC4tUgaH3KvgpN8i9F9N3Ef7J-fGsQ>
    <xmx:GLGZaJj31UiUWCWL2lMUP6oJBbQQuKvyP6wM6eDW1aFe1BeMNDspBQ>
    <xmx:GLGZaJyvN5NM511fcxxxYfAhgL22X14IfwBr4QuXqFWRKqxIl1iqRJew>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 05:00:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed987cb4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 09:00:06 +0000 (UTC)
Date: Mon, 11 Aug 2025 11:00:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Denton Liu <liu.denton@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t/unit-tests/clar: fix -Wmaybe-uninitialized with
 -Og
Message-ID: <aJmxExJgFKxeiHDf@pks.im>
References: <d03308e9474f5e26fd4a5494ec243a278e971443.1754302009.git.liu.denton@gmail.com>
 <cover.1754371649.git.liu.denton@gmail.com>
 <8ed0ac14092e7ec979e53d2a3da84dfe884d6b3f.1754371650.git.liu.denton@gmail.com>
 <aJWPmo6oGCuQvqMG@pks.im>
 <aJWtbGGBOELZN6tp@generichostname>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJWtbGGBOELZN6tp@generichostname>

On Fri, Aug 08, 2025 at 12:55:24AM -0700, Denton Liu wrote:
> On Fri, Aug 08, 2025 at 07:48:10AM +0200, Patrick Steinhardt wrote:
> > On Mon, Aug 04, 2025 at 10:31:16PM -0700, Denton Liu wrote:
> > > When building with -Og on gcc 15.1.1, the build produces a warning. In
> > > practice, though, this cannot be hit because `exact` acts as a guard and
> > > that variable can only be set after `matchlen` is already initialized
> > > 
> > > Assign a default value to `matchlen` so that the warning is silenced.
> > 
> > Would you mind creating a PR against upstream [1] so that we also have it
> > over there? Thanks!
> 
> Good idea. PR over at [0]
> 
> -Denton
> 
> [0]: https://github.com/clar-test/clar/pull/119

Thanks, approved and merged now.

Patrick
