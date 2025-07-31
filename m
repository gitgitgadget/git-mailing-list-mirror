Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6940D286888
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753944176; cv=none; b=QF7MELX/Fxf2ttN6hmyvDxFdaLiRpRzcuedLUYtLsmvrL1JzeUoh+/xztkkJG0LuRkZZ5c9AFgqfSMmi197tE96LxbRc9XGr+O3kTWo5ScvXt3Isomjm4BvkTmy51N6TbUCDRpaTsLueg0Aa3nasmzijDCB562BmELBiQuoraTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753944176; c=relaxed/simple;
	bh=BiR3MNta+8AK7Z5T3ZVmDZztkD/WtltfLUC2HNCvINE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBVIEtU+zpv0n6hq6Ja1naJuGWtQq7ljwKDCukgOtF22KIhgWH4BAOae8mJNesjjFM2LSxKlhytR3+x45x+V/YCQJxnuqNY8iN168R5xilSIxWNlhHi8/UCKipdCBkiK8v6td2L3uh+20KMGznIyZbuXGglg4tOagGDkD2D2PIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Di+P9LdP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lhDsdm9B; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Di+P9LdP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lhDsdm9B"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 745037A07C2;
	Thu, 31 Jul 2025 02:42:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 31 Jul 2025 02:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753944170; x=1754030570; bh=VxaDlH21g/
	BIw6C0KUq1WfLlwZF4Ad+07C70Ir/1xe0=; b=Di+P9LdPIGkvS/DJJnu+QN3PDv
	KUfFG+dkX1LwlAeY1YDdHTuQgu4UT6B5K/LIlbPDub8MQ9Rwz06J0KHccCcgJjy6
	4sfnTK8zfITq8rqPfImxRSvPMoo5deLhy5TiHfgVfEpiyb3wDeMY+QA+fmO/dB9s
	pekitLtbP0lAlUVARecIYvqRduS5lJx4yby+P8m/iAtheabe02J0xTi1hz+QLyj9
	+anUJ2b5Vq3MRLI+v0Z7tawFvBbEM3Gp889MtD+iNQ3tfUns5GPhfVMoa+K8V8lq
	LtzxP4Av0UH31CjZ3VR3d8xBDsLodpT0QiNzfpMnw9MJTHDkV9Ft3nQfc2ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753944170; x=1754030570; bh=VxaDlH21g/BIw6C0KUq1WfLlwZF4Ad+07C7
	0Ir/1xe0=; b=lhDsdm9BQNx7E5DaNOOurdUUwrT58TSEKv/0ay4MLxMVMJmn4eD
	MUvDmwpf+9N2XYG+C4CjPtz6kCR87mhHmv2pEUZAWm4GQ3P/RfRGcEB54dZIp40i
	UjkyGhumyTAvzz8RTu/LHbEVy3vM+GVRVp4CopwfZurUUNUaWrwyNl/Fc5pWfDZ/
	oZRvq//5Km0WDK0T1Wn5FtNnL7StDXlDqmNd2g/FCgu0I024k+/zdrUdz475Hz9J
	K7m3WqFrpOK9BFZA0L79Cb/YOYJzJO1GmxiM/Xra4kypmzoYbc7aKxvVmE7xW+XX
	yt/7LMSOtdF+m72v6QV51yP2PP0AJRh6GHw==
X-ME-Sender: <xms:ahCLaP9lQ3MIANYqbnM76rZddEB4JdL_4I89JoEMmNXSlnBFBfZaJA>
    <xme:ahCLaJRjrbWuUDxruUWkPOe84A29w4HaK8tv_GpjHDhlYoaTdKHF0073NXxvgLA71
    _uNNz23om2zVPlrGg>
X-ME-Received: <xmr:ahCLaDfMadUd53B9EmAhMrMWVrcNLVcEGaj7dRu0ahRlKlbV7sAQ3J_oMmvJwKiluTKBWrknujlnIuQLqleL5Py8NSsVHajZOJPK0iBMIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ahCLaNAx7ifplwVOA4ELnfMOiUUk6SIBYskBZ05JhpuoErfL1VHimw>
    <xmx:ahCLaFl1OZ-vaLMIAs83w0xPqn_VlFB_BiOyGQ2jQgxqZStB7CFwuw>
    <xmx:ahCLaIdIyzp-8xbb021hd4gPlHAdipl-8YuYB8qri4Inl4L4QHU2mA>
    <xmx:ahCLaJQmlCguJZ5HmxplDFCLrM9VObdyeBx-NWjbpudwAEiNP6Y4NA>
    <xmx:ahCLaDJM52AZCZjQXMNMuSrnY5DljVJyh877i3nlenpaoTGr3X5ZItXg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 02:42:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bf157532 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 31 Jul 2025 06:42:48 +0000 (UTC)
Date: Thu, 31 Jul 2025 08:42:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 3/4] commit-graph: export prepare_commit_graph()
Message-ID: <aIsQZCLbpQVQmFF_@pks.im>
References: <20250716133206.1787549-1-toon@iotcl.com>
 <20250730175510.987383-4-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730175510.987383-4-toon@iotcl.com>

On Wed, Jul 30, 2025 at 07:55:09PM +0200, Toon Claes wrote:
> Allow users of the commit-graph to explicitly prepare the commit-graph.
> This can be useful when users want to start using bloom keys before
> calling functions like prepare_revision_walk(). We'll use this exported
> function in a subsequent commit.

Hm. Ideally we wouldn't have to expose this low-level function and the
commit-graph subsystem would know to handle this. We typically have
patterns like this in our codebase:

		if (repo_find_commit_pos_in_graph(r, c, &graph_pos))
			load_bloom_filter_from_graph(r->objects->commit_graph,
						     filter, graph_pos);

The call to `repo_find_commit_pos_in_graph()` knows to call
`prepare_commit_graph()`, so no manual call to that function would be
required.

I haven't yet read the next commit though that adds the callsite. So
let's read on.

> diff --git a/commit-graph.h b/commit-graph.h
> index 78ab7b875b..0f76681333 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -131,6 +131,14 @@ struct repo_settings;
>  struct commit_graph *parse_commit_graph(struct repo_settings *s,
>  					void *graph_map, size_t graph_size);
>  
> +/*
> + * Return 1 if commit_graph is non-NULL, and 0 otherwise.
> + *
> + * On the first invocation, this function attempts to load the commit
> + * graph if the_repository is configured to have one.
> + */
> +int prepare_commit_graph(struct repository *r);

Let's fix the reference to `the_repository` while at it.

Patrick
