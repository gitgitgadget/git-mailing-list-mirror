Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40DC1D6AA
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735309128; cv=none; b=qpvhzNPGItj2RBs22tx/V3hlFuGa8NcH0anqvoqNJ/mPGHDh+ncTw0NUuqlu7PSThLIUQh3gS/8hKSX4SNToZFAJgBVhs07b4GNMgIcc9XIlysk5sl/5T/jiDFt8aannrFIv2QYMWfYz3iozqr0dO9R+HaK2TwUCPlDek1zjBOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735309128; c=relaxed/simple;
	bh=zdHZK15lezgox3q3IMMIGUeajklPAsh4M3RPsFZdpSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBhR4KuTVj9w2FYgINsqiBda4tMGeSONuEUvvAh8NwRGe8mREcN46wM4W9IzfK1Qu9ZsIzPVgpCdFD7NdqFFZ9ebiIJ3e5d4A/Ag60bipgrezo6JScf+JH/fsT9VxvSEIvLozmm2kYg8yFD5ZuBZRRa1aKZETNJt3PoX7MiINM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K4VYgu9S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cy94l0gU; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K4VYgu9S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cy94l0gU"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 791AA2540074;
	Fri, 27 Dec 2024 09:18:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 27 Dec 2024 09:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735309125; x=1735395525; bh=Og0oGBBMPj
	kAG4JFIsPzRNkXK5W6dbmIyIdDb1jwcLk=; b=K4VYgu9SaVnGWpnEWcQoyWdIEC
	0B31vZ6S2X0bTZY+Khvu8OE447SQRNb/AFSn/L2lvgKpy8fY1YBYlg9NjWca739a
	ErgtHllM4L5ywrDwNdcuASw8EtU0OOvPje1i+LHCPD9K5GfAPziTs4SxOXlkVUKm
	vqYBwPKBdrw2PwPR1CUjzlvuNhjDAvfzZF0EWSf9gbB6YttkUZoIWXGQhWNwtUW7
	wsZOuZ2eiTQTvboAA2AMxGwgd4xS+mOZW4Mpi9UaUqLoC/oNBWBDkF6WO+z/9yRA
	DVOlP2vEr0SK0b/DKD3jbYHfDqnGGYgoAWe5xO9BehdMh2uZFUN+lKJDnEnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735309125; x=1735395525; bh=Og0oGBBMPjkAG4JFIsPzRNkXK5W6dbmIyId
	Db1jwcLk=; b=cy94l0gUk5aAUJ/ScQh3iaXyV2XLSF2KZ0h277h05bdsqxdcpGZ
	wzmL8nrU0In3uFmMLBNkZuBSK/C4JswpEzYaP9um8R7SBgr2ZezzY8MiPYORyn2+
	k4LgtC0Ko0tGr5+qATyMwf2K2e+plIfVt/pJSutkMEc+WqmFOH+lu3SaQkhW/kxp
	IeKs1PpF3vx3hrIDR3GcRd1cyOvNp5LODJz9K3o1DwotU1WOy9Irv9c4FYQgoMYb
	oWFYnLNFcbiETnTZb53YOU1/1WWO4eG8+tfDahGLauZutTCDwoWgzlspo5aafBiU
	Wa2KvoagffzmMX5EQ2I+Nuff6m0lhgq+IMQ==
X-ME-Sender: <xms:RbduZ4t291jP4vJ_AWr_l0zXG_JfjljOI9b6niDyXB608TflhFjGyg>
    <xme:RbduZ1d3-E9-ByZrG3nbkTOufm9xWpyYn_IOTRtVKlM8DyinZIScG5pRbpzdz8ox3
    Bs3NcD6SqWhyIqypA>
X-ME-Received: <xmr:RbduZzxSl7WpsOUo6vDqMHu0iWfwae3ZON0J9mheE2qutUnPFYAUHjHvnRLDsUy99kfd13tXbR-KxFhsezk-g8oFm_-UtMdRnnzpix8n52d2kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphht
    thhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhih
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:RbduZ7NXg2GX4cu53IOULmf3imdZbRaTJUIiRkM-59eoYayzg8skfg>
    <xmx:RbduZ4_t_tSyvaETENQbTZFALwKBtAveFvvn9sB_Fq9CkFnDNp2s1Q>
    <xmx:RbduZzU8tDx7cT1qNDOSgsO2eaD6cJKUR1mbeNFpGuaatY0nci0uWA>
    <xmx:RbduZxfSTrD1E6Bv1Mm1B4mH73qFN9ciZ9DsX6P5sBZfV2Gz_8rg7w>
    <xmx:RbduZyc-XU8gFL2_euh7AdQ2OCdCwrUGD_Q2GL2wj4CABL9vBeQUaQLN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:18:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ba28e683 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 14:16:38 +0000 (UTC)
Date: Fri, 27 Dec 2024 15:18:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	karthik nayak <karthik.188@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 1/7] path-walk: introduce an object walk by path
Message-ID: <Z263J9O1ybuiN-df@pks.im>
References: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
 <pull.1818.v4.git.1734711675.gitgitgadget@gmail.com>
 <62f7aae477bc542dce0bb6f8b59438442a77d154.1734711676.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f7aae477bc542dce0bb6f8b59438442a77d154.1734711676.git.gitgitgadget@gmail.com>

On Fri, Dec 20, 2024 at 04:21:09PM +0000, Derrick Stolee via GitGitGadget wrote:
[snip]
> +static int add_tree_entries(struct path_walk_context *ctx,
> +			    const char *base_path,
> +			    struct object_id *oid)
> +{
> +	struct tree_desc desc;
> +	struct name_entry entry;
> +	struct strbuf path = STRBUF_INIT;
> +	size_t base_len;
> +	struct tree *tree = lookup_tree(ctx->repo, oid);
> +
> +	if (!tree) {
> +		error(_("failed to walk children of tree %s: not found"),
> +		      oid_to_hex(oid));
> +		return -1;
> +	} else if (parse_tree_gently(tree, 1)) {
> +		error("bad tree object %s", oid_to_hex(oid));
> +		return -1;
> +	}

You can `return error(_("..."));` directly as it already returns `-1`.
Not sure whether this by itself warrants a reroll -- probably not. I'll
leave it up to you.

The rest of the patch series looks as expected, mostly based on the
range diff.

Patrick
