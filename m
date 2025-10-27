Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ED52F83B8
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564104; cv=none; b=hRgksdS/wvsjntSbF3HUDWFmO1jy2pAmIpU1FCmEkB1C2AwRjL9H6X7TDSB0HtCxx3Zh/Iw1jRuIgqWG1Dt0V3kfGH/Kolq5O9pb1G19ze4qcE8MbvDpRT9f1m9TJZFVfG41TINFIEHAKxGtliJd2v7b2C3SCZ6d5pS5A47vFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564104; c=relaxed/simple;
	bh=DYP1THtNLOIIMTcYd5pY4vsn96Z+gbYRNNcDNV9tNL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLt3BXHclv1daGuJSy/UFwluBTOAghyPRp/kLI0IxKnti2AoniaXvNGdaROxEedaWeRugQ8mx9Wphzlh5rFvyHankBu/CmR/zMcnBLWk+0QIePrrcnYudtcK4dNvIPPIo9e7ogrzr9tD7Wqsx+yvMKHgmFQkc/vGGz8rKYAD04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lM4J1vzC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c32zZfgd; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lM4J1vzC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c32zZfgd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE25414000C2;
	Mon, 27 Oct 2025 07:21:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 27 Oct 2025 07:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761564101; x=1761650501; bh=1HIF2dagnP
	vXZd4o9Cp75jxzTAQypRNMdEZETdh1aOM=; b=lM4J1vzC8E4l1HflprpjQBtJAh
	WjQkCVbmfCgNnI38GHyFACPtgBIQ1evh+4ClJRYipoDLMNqVQWkI5HVOm6y9xfUo
	kKdA6optopUjCJnserZGP/8XllgKSyqVYG64aan8BqKtM1kRytCjl8bSF8wh+vTe
	pm6BZ6Vg/6DgrPF3gjvnuky/zSAIb0d4k0ZqaeDjnqiTgcVypSLojj/ULtwJi1tr
	RC7ScvagAd8jvbk8soDh8kYvfBmUdroqaqYWiiRf3N2KHwuXTuyz8yTn2u797YJt
	VG6ILmvUBX0L9Qj4XM6tKEuWQNEG7/OcU7+Yj0CSRy5IChr+NOEbHR88vZUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761564101; x=1761650501; bh=1HIF2dagnPvXZd4o9Cp75jxzTAQypRNMdEZ
	ETdh1aOM=; b=c32zZfgdwoljreTr+Tc3FXxj7i+6XUd/Y5SDe8s1xe6YDBL/Aqn
	kyA0wUHHgQbrH4fldC/4YpWKOqvvr6/7qXN8vMkI3TRKyJqDXnazHwYVpbYbx3xh
	TGV+ZuNIv0uXZ6AQZEX7EeEjB/aTkXD09cFwAfrpvVRXDFgvL9hbmJNuJ2P7TDz9
	Aet7aXT37RMQlEWGGNcZLqHz3LBCfMChzBil6MgfX1EfU6bCOi92TyDCAzMSYHai
	uSf0gEWr9hr11aXRkooh3WLyPzngEq0+yQ0sH8qkgbzllxzyuzyCpAD0+oKtNU6/
	n1n/H88c97fEkdnhl4FNY8OYbdpp0SHNYAQ==
X-ME-Sender: <xms:xVX_aEILDJB-zHxylL0PuRng356FZcI8aW9AkHkfi-wMy6x48yNBtw>
    <xme:xVX_aKK2qZyRkJxeU6fxBtQ74OG79C4lPi8CjUcasoz-jXeSoTjegb8787aP9gYh1
    LcPSyn0xYKNtHie-IbxANcqgwZ3FreNZL4OZh5k4yXgH6UumzzqCQk>
X-ME-Received: <xmr:xVX_aCVF-TvT65smfgHPx2CqdRxMVlxE5gHDqsyLgwweesZ-JxEO-7yLKCx5XEm1hfNhjJ_zFdbrvWB-NzM0Od8BtrpnrHqv4QASjrLJ-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xVX_aMj3N3kKCwJzZ62mFrPZaDHcUOQL6OH_CrRPI7ifX2hTZBae2w>
    <xmx:xVX_aN-tmKuMpJQP47csdopfWWCUGRUsu527el-Jl0C5VeZxkjoxjA>
    <xmx:xVX_aGBNZIWVw5zUUmiQ4BojoUBRMtRjjclADoyaJICHv9hfpsLAGQ>
    <xmx:xVX_aKLkTVmtHjvjdfWNCp3Ch2-WJAtNdSq6kVMzEt4a3TAaLFrEZQ>
    <xmx:xVX_aHjiYa0rEKhO65q66iI7ZUvEHdfkoweYaTEhN_fiEqzdsfjnNLt->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:21:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6473bb25 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 11:21:40 +0000 (UTC)
Date: Mon, 27 Oct 2025 12:21:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/13] object-file: move loose object cache into loose
 source
Message-ID: <aP9VwTVr8IGNCReF@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
 <20251024-b4-pks-odb-loose-backend-v1-6-1a4202273c38@pks.im>
 <xmqqzf9gnfe6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzf9gnfe6.fsf@gitster.g>

On Fri, Oct 24, 2025 at 02:44:49PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > @@ -2006,5 +2006,8 @@ struct odb_loose_source *odb_loose_source_new(struct odb_source *source)
> >  
> >  void odb_loose_source_free(struct odb_loose_source *source)
> >  {
> > +	if (!source)
> > +		return;
> > +	odb_clear_loose_cache(source->source);
> >  	free(source);
> >  }
> 
> This had me confused, especially the source->source part.  Perhaps
> call the parameter "loose" so loose->source is the way for somebody
> who has a odb_loose_source to learn what odb_source it belongs to,
> or something.  Of course the round-about way to clera the cache that
> now belongs to odb_loose_source by taking odb_source looked awkward
> in this step, but that awkwardness goes away immediately in the next
> step.  And the parameter of type "odb_loose_source *" called "source"
> here, instead of "loose", still hurts after the next step [07/13] is
> applied.

That's fair. Will rename accordingly, thanks!

Patrick
