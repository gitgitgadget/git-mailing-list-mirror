Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E74364
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078929; cv=none; b=fWeJYVqkpGqJLoycHG3BrXy++m6FyZOMQqAtYVGpK4v3JjBWC8/AvB+2QtkrNYndl8NH/W0Rlt+svB9Y5fW/PotnEO98NER6MfRKRqyelMRjuAmmVH8sZ4M9U1akOkq2LBhrAMMdAXBWGWqMi7R3evLqJtHIOoeXp0SZQD3axdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078929; c=relaxed/simple;
	bh=OFYuCr7myJnuRIfvYWm58ixz27NfYnA2RM/uRJfq5iA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=KB4Gx9vBUWuXhc8JAt51XgNliWg20lQuYajEVBtxZujU71t1A8CZhLSdQ2Ezz54UFyp1Motldf+pm4Fyd9Dp6HX37rMFFFBy6pKugCErnUMTloJ8qf9QAOnhv3P8u2CEsik2cakwnKk1P/OReAb+olAXR03+uc8vm/HjNL36bro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=PLGs0iEc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aU9GH8vB; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="PLGs0iEc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aU9GH8vB"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 69CEA1C0008A;
	Tue, 27 Feb 2024 19:08:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 27 Feb 2024 19:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709078925;
	 x=1709165325; bh=dZowknK9w3i8pQ8JNSQ5O13ZfC9rsl75U2bY4SvJN/c=; b=
	PLGs0iEcZFrBP+hE7H5jODsK7tnnVmrurjtN4KX/pMhTRuPM4v+J/9KW+nsyBNgC
	qbCvXQWkUQTDKkwnPiHG9RAQ6TK0BlIeZ8xZeFmTZyd70lONi/fM4o6RRNj9m3g9
	5m6zhUfQXo6oOgjUtVtz3jMxjBgr5P2baMzVu9HwoHCnwaEuSlkzdo/dQRo9+n+0
	ySW4YnSHpIzBPzMw2dU909FjfD3VwrVztaCH+pdpia9NRZnaNtIAYfEbyiIsyyEe
	AdVmuOVFxxH/Is+zPuqiki07FvXmDWHz1v7PGFzjvvE4Xi6loIU6P0Iuwa22hCMD
	ErWUX35Qg3QcdsKVMn5XHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709078925; x=
	1709165325; bh=dZowknK9w3i8pQ8JNSQ5O13ZfC9rsl75U2bY4SvJN/c=; b=a
	U9GH8vByujZ18atFo7yitJqxhb+soPTukuCKiRDXftB2DQqKmFhSMu8zXV9gZFvG
	O4z3g+awQNI93qpUeI4b+U+uFBAqPWCzylMsvRQPrF6AqmDZam8fGmHJeqXzLSXx
	7Fvd8MsB0aL3GbGQUtlY2sWtcB4Ezx2/Bj3t+qKL7h80/zeder6jt9bKz65FEwNl
	ZJGxZpl+uViwVrdokf1j7JChu1ONIc5sL13dlAnDYLcZm+f4sBrzK4D++kWmxkxJ
	95VCNMV+0HTSwcC2+3nwV7j8V5eiq/qvuzO3d3AdLHyJ6L0RrNza354Jzr3TniJB
	wd8VO3iIy3Jb+JSu0QGAw==
X-ME-Sender: <xms:jXneZV0ksci8lf-fb-4SmfIHC7QmKUPNKVTcNZPuPH38UF2hbq2kYw>
    <xme:jXneZcElyg1kGUCoI5bblC5vCJ-FFT43TCVt0HuyBMtL38agvI8PWTcj4Atxjzr0B
    FKEque_QQ3e6Haidw>
X-ME-Received: <xmr:jXneZV7RSaD0POs5etEr9A5jm9uGERqCBoII-BEuWi886DDXxVsNhpm188rY5LLjQ8toQrbB3z7Ya5KJDYrBFYFdO4Hy8sdxaBrjFJNy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeeigddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegggfgtfffkuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgrmhgv
    shcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrthhtvg
    hrnhephfetueehudeltedtjeekudelueeihfevheeugfehhedvieektedtvdevgeeileet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmh
    gvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:jXneZS0FFF00zeFlOYKkMx-m5wO6Rrxz4DpRPrmwBUcV-4Ai6kQsCQ>
    <xmx:jXneZYFm7KXDLlXIqx6IGwQhrkynauRqAaxJjxtR2fKhhpH5GBeg5A>
    <xmx:jXneZT8nkufhGU-4wsRFTNsAKtDi_csKfF1XVfWLuNH1Qw4K5gWNGQ>
    <xmx:jXneZdRik-OtfaugrHhXoowEdcduDvkELRQCGIh9Wg-qniKzwvgDRi7GuDc>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 19:08:44 -0500 (EST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Feb 2024 11:08:42 +1100
Message-Id: <CZG9WY119NCG.2ID9DQE6T030U@jamesliu.io>
Subject: Re: [PATCH 10/12] reftable/record: reuse refname when copying
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1707895758.git.ps@pks.im>
 <d7311598c0f81ad3fa41560b54b0974d41485a23.1707895758.git.ps@pks.im>
In-Reply-To: <d7311598c0f81ad3fa41560b54b0974d41485a23.1707895758.git.ps@pks.im>

On Wed Feb 14, 2024 at 6:46 PM AEDT, Patrick Steinhardt wrote:
> +	SWAP(refname, ref->refname);
> +	SWAP(refname_cap, ref->refname_cap);
>  	reftable_ref_record_release(ref);
> +	SWAP(refname, ref->refname);
> +	SWAP(refname_cap, ref->refname_cap);

Likewise here, what are your thoughts about reversing the SWAP arguments fo=
r
the last two invocations?

