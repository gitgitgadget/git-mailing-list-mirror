Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AD2746A
	for <git@vger.kernel.org>; Mon, 19 May 2025 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669591; cv=none; b=FFOMGcxV1K4b2/oRkbL1AEJyETGLOvONVLiEdv2tAFRGW+TEB530KKhDquGOVIlvcvr8mqCrfqOICT+l83pMReRUzS+Wus1mZ3/rp6Bo0rKKmCk7kLklFUI4pd8GaH1V3xEgM68prxsTDArQXQXR3KNuadPqpOoLqIQZh90LNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669591; c=relaxed/simple;
	bh=IDASPTh2E2jdCsGW5ECWK3/7+/TvfkmqeQViAe3gDFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=otuOQCgt2RS9Ycg9COjucMK2ZHOz/+qJh5Arqj6FoUuvVRgNORFnxK0kZkYc90/GPIpx/IkSEOIRvRZ2kjJ6OIFG1aLySQHNoTauhpDZvkJuxcp/kvJTESXktJDHfH7L48ap2K+vzhsGlYZH7bxsmiSipmiYVi1XoJGv8n1D4P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L6ibzOcU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i1F/vvbD; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L6ibzOcU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1F/vvbD"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F2F625400E2;
	Mon, 19 May 2025 11:46:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 19 May 2025 11:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747669588; x=1747755988; bh=dglahUKjJN
	FQlrPFVOtfF23ACRywqvDsFCq7v59/o90=; b=L6ibzOcUragWfJuBI+nmXbPoSI
	VdFfFhQQCqAaFDfDPeqFY0HqbAtmn0ZOeCnZzTZcAO4theZ/JzBBnNRpeCFLIKPl
	cRlv8fMEETQ2gy6OgjV0UUFKVSzsOlC5GQ7LbnY73PVF4xgWqxcmZzdihphG2rBx
	nOhc62SccuLMNve6PZoEydBAiF32iFj11NFs5Y0F5Icy/tUW0TTsxH+HT0he0Abq
	DacISROlEsyI+aaV7IjQnighB7yqd6EpqvTvJzscNZFgS3oaLf51QYyJdd47uFFt
	kk5p2gxgmQNi9SCsSzRQFzU7RWuflGv5pZS0LSw8JeCg+QlZCthETp/68mUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747669588; x=1747755988; bh=dglahUKjJNFQlrPFVOtfF23ACRywqvDsFCq
	7v59/o90=; b=i1F/vvbDZYm4gEpRhEnU4QfduDQHtMO+HrYbSfdZZH075NVA+AC
	zdUCMa4Ac7sR/GabAdlRkBFwoKQ+a4SqOl1E6X6iQ5pCUM6isSGmHSAZapCH8rN0
	ftq2dyIGw9RJ8CUs35b8d1p4jmEjXv7Fv21tNTfjc12m98TmVubdfVo1F059PNdR
	f/XdjAblIvH6//pVwYmboK6mG0zXgFBINtWLZB8zy5Fng1XzFZ4s2eumLjpEU6YY
	iVFYHkITYzGg07EkqnzRG57vsFjhdpI5NrMc3UbSR8YfeRkVvRt16Pv3Rue7QmZS
	Ro2kUAYX7+xjLwaDh5sDmVVMtkdN2kWKRAA==
X-ME-Sender: <xms:U1IraOXdCZMCgrBd-pqSYPVHK32UpJJO6CwHx1UpSkp-xzhCy_T0dQ>
    <xme:U1IraKlUoeXx2xMCVcH5n6OSAPZnHJrHpaxBFiEFD_ECQcZ7TnkTWpWjuU8t94iqz
    0V3ODxHYXxobc168g>
X-ME-Received: <xmr:U1IraCY67UiMwXQdgP-xEUpaCMJzVwudVmflGdHpWAsJNr-Wc5DKf-vxFfOcinbgLWsuNtfqWaSJjSbICtcSuP1qxsvlwobVr80PKqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddujeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:U1IraFVSKwMJ97bV_xuJtTdVbDb2cf_AEAaESugZRyry-bPSZH6eUQ>
    <xmx:U1IraIkwCh7NtDD6sMDnSkIKF9k0L8EWhRyYN81jtzz3rEY_ShZySA>
    <xmx:U1IraKdcJP_5kugluE2BMXCbdwdHK2AM1mFM6xOdmHy5cFgyZGzQRA>
    <xmx:U1IraKEOS_xv-LS-T5cIk1tUFFf8QtFvX_0hfM4xz1uXQqOon-bENA>
    <xmx:VFIraF0bS8ybjGoS5C3xmMxJeqyN3NYdNe_RrYCHiHGdUEecqD-Ka6lV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 11:46:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH] packfile: avoid access(3p) calls for missing packs
In-Reply-To: <20250519065221.GC102701@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 19 May 2025 02:52:21 -0400")
References: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
	<xmqq7c2gv1zx.fsf@gitster.g>
	<20250519065221.GC102701@coredump.intra.peff.net>
Date: Mon, 19 May 2025 08:46:25 -0700
Message-ID: <xmqqsel0ob72.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The code in prepare_midx_pack() converts a numeric pack id (referenced
> inside the midx) into a "struct packed_git" pointer, caching the results
> in multi_pack_index->packs. That field holds NULL for "we have not
> looked it up yet" or a valid pointer to a packed_git. It probably needs
> to hold a third state: "we tried and failed".

Yeah, this was exactly why I asked "are we having repeated failures
in the same process", and I am happy with this direction.

> Something like this (large untested) patch:
>
> diff --git a/midx.c b/midx.c
> index 3d0015f782..354b1f886c 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -405,7 +405,7 @@ void close_midx(struct multi_pack_index *m)
>  	munmap((unsigned char *)m->data, m->data_len);
>  
>  	for (i = 0; i < m->num_packs; i++) {
> -		if (m->packs[i])
> +		if (m->packs[i] && m->packs[i] != (void *)(intptr_t)-1)
>  			m->packs[i]->multi_pack_index = 0;
>  	}
>  	FREE_AND_NULL(m->packs);
> @@ -458,6 +458,8 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
>  
>  	pack_int_id = midx_for_pack(&m, pack_int_id);
>  
> +	if (m->packs[pack_int_id] == (void *)(intptr_t)-1)
> +		return 1;
>  	if (m->packs[pack_int_id])
>  		return 0;
>  
> @@ -482,8 +484,10 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
>  	strbuf_release(&pack_name);
>  	strbuf_release(&key);
>  
> -	if (!p)
> +	if (!p) {
> +		m->packs[pack_int_id] = (void *)(intptr_t)-1;
>  		return 1;
> +	}
>  
>  	p->multi_pack_index = 1;
>  	m->packs[pack_int_id] = p;
