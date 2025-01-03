Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18F1F9EA4
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921530; cv=none; b=VtOSjMHv4tNoEdYGV3+gG9MShusgxAVFQ1yQC/RMvP4rvkm7w6RRqNp1X0bHcZXIRR9SVqwtH2j3Zmag3gBi9SaTxymMBLEFvZphi+vnnpta5GcCJTlP2UshwfmTp7ldBaoaZ6+yRm7M7fVF2097I37lrKX7usTkrKsyfjcYLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921530; c=relaxed/simple;
	bh=0K0+ex75JwTPg4YlNT4dTpuB5L+B4FMiaOmCWJP3/JU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DRlL10BGrYuTqQtqY7TMdGWm0BL1W5qubItkFKjFZqTPiGi3ETYQp4eNz8hzcZhaqcW9qZqAyKcKEgpNLhY7IDz1CsfJ5e7Yhf/TDtL43WgrRzk36QPO6l5XqcAcoyqBzOVv+xpoRy/5kpu+bD+MP0Q4Vc7OWoqNbXt6/jt84xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jXaJEywQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yu+HL6qD; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jXaJEywQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yu+HL6qD"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 755822540185;
	Fri,  3 Jan 2025 11:25:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 03 Jan 2025 11:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735921527; x=1736007927; bh=7ZDotUR0Ej
	MYyC9VJmBIo1rdFwVJIPFLIHjq6dfzp7I=; b=jXaJEywQX3kW+nPHl96qFFHIDJ
	zPf6L5jdFb3YYD0XHvfRqXF04CmoMUPyJYPLPg+x/CCeKYnxdV0RfHMSgc7xjHye
	RC7jIti/KgnqC6h54kAB0cCC5glqH7ERKnFqpuFa+r8w59X4MJuUR141CvKnI32D
	1Hd+qGuSwc5m1zys0ze6L6DjIhh1v7ZHfTYOSOtNHbxJXpIFJeVkBBuwn07JFRmn
	Mbqn2vmdSrBr9vBXoRY73dA+fz58cla5Rj8TkhbtKs/lpPwwFGNUzOcQg60Hs288
	BCysp7BSdhNKEStKvTGrxt+c1DkpSgtCI4ANbhEWiaj7uSzs+aXVaUAO+IEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735921527; x=1736007927; bh=7ZDotUR0EjMYyC9VJmBIo1rdFwVJIPFLIHj
	q6dfzp7I=; b=Yu+HL6qD/naW0w5y6zJO2s8yx8Fb5EL9HLAt9uahmMaUGfOOR6I
	Aj6/H74r2+B3Nq5hDiI+eRXkceRTZShmqVjL14BGonVT08A9PRHEHCFAiTG+WziU
	/FthCdlC4fpcOC+VGFOdEt1r/lRBM6nJzJNCeu/pvH3GbGio3JialE03MRJTMBnA
	MmNF8+m1MIXFlpYad+X5l/YCJCPgadAH+oRG3M1ssYbKQiGDgwE6epjV0Opkoik1
	OILg8ezqKmpd8YdnpBlBwTPFTKwWUz2EMWQs/Ujk2HlUv7T2kC8kaVA8VvtWZknu
	KZYh35HuXFxrhWyZ9CzuMKQnkt43VZK0PLA==
X-ME-Sender: <xms:dw94Z9MW9W1Mxlu1CRaW2JPlq_yjxYTHMlLa0hbYU90jby4GCzJBXQ>
    <xme:dw94Z_9lVlCZhRdi-1uaW8NIE0EvwOwAveDcJI9FS_0z0xS2kb10lTBf5tEvTCOth
    z8b25uw177ZD8AnjQ>
X-ME-Received: <xmr:dw94Z8Tf4PS3CgxW2yZaGvKeiE6Y2Zpw-Mp_Y5uM-2-4GdR57LFSDHgUUMGD2MiJjxMpXtwL0vcEhOVmeN7Yq0jKoVygS8_Bdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:dw94Z5vKXNLH3nD_v5zgSmAPxfcqxk-1CXdaUa4WKK1i0NXi_kHQ6w>
    <xmx:dw94Z1dKsVwLfsdGGvp_48WDZaZAKUzzRwa8H0XOVDNklg07ZONbeQ>
    <xmx:dw94Z11tYTuHQCWnHaQPxP5t-HJSQUl2KXAptwkhQv5NWPzYqvhvLg>
    <xmx:dw94Zx-wFrsC3Ex9231LiDsfxIdhRHHOIbpU5xINU2TPhT6r00s4Cw>
    <xmx:dw94Z86DvD9cmOB71QBEww4KdZEDJwpp2Xfz3c-arEy5CUFA3phbADoA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 11:25:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [PATCH 02/10] builtin/fast-import: fix segfault with unsafe SHA1
In-Reply-To: <Z3fhK1ACzJfVehM2@pks.im> (Patrick Steinhardt's message of "Fri,
	3 Jan 2025 14:08:01 +0100")
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
	<20241230-pks-meson-sha1-unsafe-v1-2-efb276e171f5@pks.im>
	<Z3LNVzw9UlS7SWqe@nand.local> <Z3fhK1ACzJfVehM2@pks.im>
Date: Fri, 03 Jan 2025 08:25:25 -0800
Message-ID: <xmqqbjwnsw3u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I think the ideal state would be if the hashing function used was stored
> as part of `struct git_hash_ctx`. So the flow basically becomes for
> example:
>
>     ```
>     struct git_hash_ctx ctx;
>     struct object_id oid;
>
>     git_hash_sha1_init(&ctx);
>     git_hash_update(&ctx, data);
>     git_hash_final_oid(&oid, &ctx);
>     ```
>
> Note how the intermediate calls don't need to know which hash function
> you used to initialize the `struct git_hash_ctx` -- the structure itself
> should remember what it has been initilized with and do the right thing.

Yup, that sounds perfect.
