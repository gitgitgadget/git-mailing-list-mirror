Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB41F4727
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735307931; cv=none; b=eJTY49Wh72RpcLBqQg9HaKxt3dWg6+oUuJqUcmQjtaGWgKpa5/bz43kjj70/godyZ9CfcSGa6JwTsPpOA8fEDlFtc0hF+m2xutad4V6xlpmWf3No6pd/s6D3VL1qZvZVVA2wXDyCOyRIJMeLsAfdm/qSPz1M8z6zKm3GTo4WyGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735307931; c=relaxed/simple;
	bh=lVcVj8Wh7ATvaPYiM3yFTbVHUX9n/+yzooHHMZNLQyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGVH8aaHKsanLxUUQz8lLxCiZQBq95T5mD47pekbz88jpp6MeCg8QBmWfKDO9zIe8cG28aQ+N97sEcsOVrqURkdolGlqtNVPatU08LLCT3UWmXUKqMZp/h392W35A0fTleQpd93gzoIcDcSUlarOW/54zPhPq3Z6GmvJErqjODs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oaampx8m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KKcfidd8; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oaampx8m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KKcfidd8"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC3AA254017C;
	Fri, 27 Dec 2024 08:58:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 27 Dec 2024 08:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735307928; x=1735394328; bh=cp3Ct931yR
	cz5qftPT6m32m12Rd1+3CXd/kPMTKDoQg=; b=oaampx8mkoYAUguGZQqHGtpAWI
	cqpdp8LL0+eNbLQ9upTN7yXWxyynqwWgP8omM5MdxL2ylscvpr1WjGkH9a4igEl2
	HIXDF0jbdFN90BYW92uDDcX+E2TbYmbk0ul+5HOgXzPKDJsnnX0Y2VyPXs9K9W5P
	yl16adzuEZsT/2ln80J6gs7ry/wWBulULyZESkI9xE7BqyGbcKsWBYUgu8h6LTOL
	UAb8iNj1caRKibdR59/jMgnhZ1vOO6jULvhcUsFtPOev1xVb30jiE8xjX8cmL7HJ
	Km81d5O11yW2K3zxJj2pQJhHBAfy4h29MFUDnS2kvlbGFfBshpV/8Xr0l9Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735307928; x=1735394328; bh=cp3Ct931yRcz5qftPT6m32m12Rd1+3CXd/k
	PMTKDoQg=; b=KKcfidd8MMra8QYpmB6zihCFuf9Ed98l1e8wHFU6C0HuAi8FJ11
	yn+AHC75KvuZRuFU/vHOrxw0E9sYbz0E8BWwCI5qoZJaJnamZDDljBQEjdp71rMR
	g1dA17MVRTvG+EUyxxlGx9q3L3ySwMn02J4blr11NIyFGvGlGHe5QOJRXdHhVBaL
	d+3ByGIFWWoy9l8LHa4bTOTkeRw18wZ+tLFKAz1j4vjqYbKBABdJgfp9AfcXyz9h
	JUBaqTITVR0ZJcXw7GpqiIxCNHRs+77y3r5TNj85eWQI7WgG1pjNK+wyb04sUioY
	gDD+luUiiKama8q8GZ5f30pRq5qCf2lfDZA==
X-ME-Sender: <xms:mLJuZwYOcQ0LO9u66w_XOINfExSYMy2uCNzIX2Cn-JJyoi7imezAeA>
    <xme:mLJuZ7Z4OrXSDuC75tpZqc3w1kN1hpQs2krmzngEMd9yFoo0L9jZ7y4c1YimhZebS
    Ky5iCrQuaB6z0Kuxw>
X-ME-Received: <xmr:mLJuZ69BgcU2BFDEEg8iOnGKC4Oz_cy0vJpKKa2dNN77fAxZlhrJ346woLDf75scyJMURutUjvaph1TMiX-g-tKpZR1i0acWwJzVeWHa7G0xiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:mLJuZ6qdQ80VsblIGO1exGX3U74Fan-pd0aYPKqNKRE_FKOOTL_AcQ>
    <xmx:mLJuZ7qhbCZBr6wd9W-HCePvk1-uZGRFXcAv6Qz_FrF9HH3MyLCNpA>
    <xmx:mLJuZ4SU7NkOqHZwPsToGkNb4OxVmOnDtuluLueqeXpEEHBVAEAPfA>
    <xmx:mLJuZ7pldysoqHlv7qfwN8RiZS96UVF5u5G5FKhJrqFne-OnnBcYtQ>
    <xmx:mLJuZy1sIA_7QH9nfj2FmXXcQrIv8oMYz-CICQbiwo4TaA99ULoaGkEa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 08:58:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5d3035da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:56:44 +0000 (UTC)
Date: Fri, 27 Dec 2024 14:58:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/10] meson: generate HTML pages for all man page
 categories
Message-ID: <Z26yhWsL23liQz7S@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
 <20241213-b4-pks-meson-docs-v1-4-0c7895952cd3@pks.im>
 <87v7vafwg6.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7vafwg6.fsf@iotcl.com>

On Mon, Dec 23, 2024 at 12:52:25PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When generating HTML pages for our man pages we only generate them for
> > category 1 in MEson, which are the pages corresponding to our built-in
> 
> The tiniest nit: I don't think you intended to spell Meson with a
> capital E.

Indeed, fixed now.

Patrick
