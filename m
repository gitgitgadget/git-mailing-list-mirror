Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ED41BA86C
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738323836; cv=none; b=B2ip4Q+4PcSfo+/mRNBwmGq782NlHvVxlrgzqgvYYDFht7oX8vVPCMsmQ8yraTHM4kM2bOxDqHVpY1iUXrwHO15cPXp0EtAdKM8cVRnye9uhVosbF63FXy/KhVl7PRtPTiW2uLoZS//cyvhxpiE0IEwVTlT5xOeAhvW5aOCRGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738323836; c=relaxed/simple;
	bh=bmLhbXvIh445o4RvUXCuTqGAbq6zf48KAt1sl5USIbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIPRaAuJc7LHnv8pkzDTvgX01z2fd1kqov2CH9GUgqkYHFQi1nMi7v2ttFBgkbLVchUtCjqz1i7UBNc+ip/mxTaZYvdeZfnC489c0H7f7tOfkM5b777/kOX0NamDatFtUDBm2fUdRHNAtP6So+pWTmHzgM94Sy+MELdyr8EMUz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mL7P135W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V1DN6KB8; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mL7P135W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V1DN6KB8"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F17931380092;
	Fri, 31 Jan 2025 06:43:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 31 Jan 2025 06:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738323833; x=1738410233; bh=EUk+3sD+Iv
	82FaajoXUv1Jhp8RNwr9kxumxJ26iHtJo=; b=mL7P135WCVVhl04ioddhcXv5/A
	fbtB8hNOYinAvFdYSGz74XofhjMSyHlPN28uhgtd/w/FOuV6tpITHSqVnTPPa5Gd
	qJjLGEQJejk1KJbZoHSh3M2eGJL3w4a65FaqYwaj97nnyF88R6fEp4P6ieZUMqqX
	ShAbmoAXPjsxKjTnvL0727JzkMpxPPW6FZzbXrolDBAnnHHMb9IutvCNZn04lDXE
	GMVwhXueSN/ZJeq8Tf8OP+hQav0fpzC8SbpiMjFOnOmR5lbbdnc0Uvv9JMwAl2KO
	G8rQ2HDTkMu47VCQXbSPZ9PtZ+lt0N2yW+e5siOa8c6I6JBE43yeGOQ2UAuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738323833; x=1738410233; bh=EUk+3sD+Iv82FaajoXUv1Jhp8RNwr9kxumx
	J26iHtJo=; b=V1DN6KB8qmGZwDh0AyzSQB6oBFgWyLspgRacyMk26CNzjY0sgSh
	M5qxcJzBu8aW5GyiL5uCqpOE7YHvqzOxSwyh//FGronYbVwyPe0lMf4Pz/0FYrWU
	hFrlSNsL+gnx17WbaJqI6zfLnLI8EnAcK3j6576+CaY9eymAa/ehgIEo3rAg1Ccv
	S57R35wTX/fIhBE+xTcQPNre2rwAgKddFwc8fx9vJFKM5Df2o0doKDxEw1r2Qqml
	8YNY/I3NZppL+j6AGzBpmyBCsNSuHffKiuGGugysWkt0SDKcFb+A/knew7+nBA1Z
	g4NcZew988aslPqJ7kqddOlJo3pyD/Y9yVQ==
X-ME-Sender: <xms:ebecZyWWayLOOoG6vqqrTyo5AdWYAOKbnPjnIMp_YuC2nq-o2bl-Zw>
    <xme:ebecZ-lHxhhhZavfCCaUHvkBCzS5LHndrbB59ahpwlq0ie9cnYG51hJJDoe5MNMQ0
    cXtbQC9TxyW3jVKAw>
X-ME-Received: <xmr:ebecZ2ZMNAH8oRSAIB1dQ6Mx4Vr4gwRSyemWVqefOcGRllHKxnK1hU1XsT76QLl3PbAAKfiBk8fezwc0plQJTgmBqOu1nR1iDkST43xKUAiOKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:ebecZ5WX06byvY_jAM3N-lciFTt_j61wwY-LAmnR95AkRcFaY2SQiQ>
    <xmx:ebecZ8ks51GB3aKv7xSxksPjs1Xqcyw2sUfqnKCWLp6NANehqQ0GCQ>
    <xmx:ebecZ-dD3an39vkdD2knM2-9nnXG0jOgaEgdcNE1YemeOi_NWZUC9Q>
    <xmx:ebecZ-EEyXujaABCSqjEoNK6oPRonp7BjkGc12b9ECAzBi69wrKCpQ>
    <xmx:ebecZ2ifvYE6ulU8j-kFBrO8YlfIuzZ2KMzLkktWhbIsr20P42Jf8FmW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 06:43:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0766296e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 11:43:50 +0000 (UTC)
Date: Fri, 31 Jan 2025 12:43:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/4] t/unit-tests: convert unit-tests to use clar
Message-ID: <Z5y3cQ70M10yNqoJ@pks.im>
References: <20250130091334.39922-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130091334.39922-1-kuforiji98@gmail.com>

On Thu, Jan 30, 2025 at 10:13:30AM +0100, Seyi Kuforiji wrote:
> Hello,
> 
> This small patch series transitions the existing unit test files to the
> Clar testing framework. This change is part of our ongoing effort to
> standardize our testing framework to enhance maintainability.

Thanks for your patches! I've got a couple of comments, but overall this
looks mostly good to me.

Patrick
