Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00438238B
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943316; cv=none; b=KHeiNsesqb5B+EC/bdEpP26MivddESqByt+Gauk/Ou+8cAPF+yhTlwITghvhwPGtJowtgptZWvvr9ZC3d/JOpkDj9/EDpH/b/8iCLOCkBVM9eYDBznrwNnS8hg1i5R05AvQzbaudo2U+mFGDgCEJ2FRaiEWshb8/IDq0MJUwlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943316; c=relaxed/simple;
	bh=fiNUIsnaoLMoKqV3xU2w1IWfvxQsUicELzWpimv4pX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfZMDWl7xBG0Q+SbxQ6L3LwiC0QRVTQBhDcBQWmwKVVAQGQKaE9+6pS7nrKDSFYRxqgnkjwoDXbF2uQLjb6790Hz68CNWp1IlrfXO4KHhF01KTp/hdXigFZSfPcTt1aiH1dRGuPVa31581N1p8qpFgtaQdv1pcYdTPV8CWVaWAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PveYeqvD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dYMgYrT1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PveYeqvD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dYMgYrT1"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6592BEC01E2;
	Tue, 31 Mar 2026 03:48:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 31 Mar 2026 03:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1774943314; x=1775029714; bh=fiNUIsnaoL
	MoKqV3xU2w1IWfvxQsUicELzWpimv4pX4=; b=PveYeqvDI+0KrQngcW8IiOM0dP
	yzbJVUGNvbemcCuE78o6/HOuGKvsCWPV4DP7V+5z7jzBk084HHroAFgfjcK6/zSj
	fOkL9ks3v1tf0zej8pvq9ZXlNI6eD9AZIXHXkoydzUdU5uppkACPnrXg8Un07xeo
	xKD0v4fNOBLO9pOhpXbc6vPhv1PULuJK8DY/mqiufOFqxy/kBeFuikzN88o09sKi
	5FmXVTsJjF3/k5s5sR9vU9ovo02tYowRhov6kd7RtpEkbuc8NvShpErj+I57Rip5
	vlVP7ikY0PTkOPSKSiJqD+/pAmFjQQjFpi0gX1sxrUGPm6Opvuokt6FvGPrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774943314; x=1775029714; bh=fiNUIsnaoLMoKqV3xU2w1IWfvxQsUicELzW
	pimv4pX4=; b=dYMgYrT1ui6Ku1SJ6w/FikFr6Z0B7B/bV91Q364AVdvj+0KhNeE
	rAP6dmQ2T4ru1/0cSdxz7lj9xMmo6WJIsahtAaaKsYtW66QI8/3pZcIgumY6h5Jw
	14yoYG1pdERlGLATSHk0gnRmlSQo+wn7WGcBONQh/FFFoUjGaxqWTHz/u2ZNmzy5
	C3xVVOiKdQH0Oq5DwQapgeXC58/dkrC/HRjknzHlEBbwMB4cAWYspldGnJ0kmDiM
	Ur0aK57E2YzidhYEErYeLG6/Msx9psxTKmAUj7+RazDYweRBnqWsTpY4oambIzWC
	ERxuDH0m9IpLKqJhWDxmzpyTLuCz49ZVt2w==
X-ME-Sender: <xms:UnzLabZsq9C3h9uWD-FOD7IsIJEfxrsgx9hYHvMogYpFbPZEKHMhrw>
    <xme:UnzLaQZtBMGNwunF93xrfbENj2nfaoBqvnhY6DqPu_nDOm6XrWVKcTu16DsY4Qk-O
    lTAESZ8iPfaMSDsbZ-h81A79OEXaJEt8YUCPjlRrMoFn23zrXHiVw>
X-ME-Received: <xmr:UnzLabnFphJ1idYKosuIHnkDUAM9hSEcAqi5a6d2q_G4neyrE3_Zui9Jtqtwp9MZqj8IsJhUJC3WzyNW_Bsp8Pgof9sR5WV0glgEa_IHRZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:UnzLacyuDKOKmtOjBnvNJf2P3zK4bsxUXJTaIyQ5A7u_-GHW_lG02Q>
    <xmx:UnzLaZMySMfZy4kCdqQmtQ-5CivNSxuS6BI6rHlKeawnfA5k_0R45w>
    <xmx:UnzLaQSGSW79auh5gVLSDQZBkCVrnJ3IF7Ksuo09VG7GEfePCpQ2tQ>
    <xmx:UnzLaXZa-uIyct35XeVQPaO68evcYQmZB5WpPuGo982H-ffVwjkirg>
    <xmx:UnzLaRLDhxS0yyjo_AI-e3R_yX4GvBSGLHJJgvgpNNkHxrmxjHEh8fEb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 03:48:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ff1eb11a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Mar 2026 07:48:31 +0000 (UTC)
Date: Tue, 31 Mar 2026 09:48:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] odb: split `struct odb_transaction` into separate
 header
Message-ID: <act8SB3hqHvleT_Z@pks.im>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331033835.2863514-2-jltobler@gmail.com>

On Mon, Mar 30, 2026 at 10:38:30PM -0500, Justin Tobler wrote:
> The current ODB transaction interface is collocated with other ODB

s/collocated/colocated/

Other than that this patch looks good to me. We don't yet have too much
code in the split-out files, but I expect that'll change over time. And
it also aligns with the "odb/streaming.h" interface that we have.

Patrick
