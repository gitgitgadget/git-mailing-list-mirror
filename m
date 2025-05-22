Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0B299AA0
	for <git@vger.kernel.org>; Thu, 22 May 2025 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928885; cv=none; b=pTHW77OIm5/wPMc22+8Y4nxD0a0PYzMqLe7XM+Dorsl1npjwOp2MCKhfbgUlFk5m2ePADMcBjH4ZItN26MZDmcGs3HPGgDzOQOlHB/fcF275J1F5DBJNA13AvDKFfiXBlKiMnDfQ3g3BLAPc+HsIR0aFCN3aDGjbWUAxIxPGd7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928885; c=relaxed/simple;
	bh=i5qNES5xFmQll2dUkkAaUIt4HZesQO6lIPnING4JMZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bBfS+NRL3+fVJOQNIdNNw3SjkfDWbUbIWjHI0aY83bTsfpef8inJvM6f5zH9kh+jVVhAMp+ZWLK43msgIYvQeE2tN+zkl8Oudeqjgklf4JWIDe5XVaj9eGildKyRt4aJoRoLkySdy8NNrEXFn4el0RHkiTiuISNf2LlKlx7Zsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aHLCcUZB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H0ndZsyU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aHLCcUZB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H0ndZsyU"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E42A13804ED;
	Thu, 22 May 2025 11:48:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 22 May 2025 11:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747928881; x=1748015281; bh=iuNC0W5VU1
	FrSzVs6drWxzR+akIvtGDQ0FXPZ7WERZI=; b=aHLCcUZBIZOOYkID2mTZkTVr2O
	x6Rtxs4eFcGt94K0NVubFVJ4hHFuY432P22uW1geQxyp97oHUoU4zWTLA04R0964
	moWoYM0ahlMtEExPIQnT036Tezr7QGftniiYYIsMN+DFp0hDt2OuzTqL6QD6b0ZM
	V3u2es2dHbGV/T1ujX/9xVW7DX2kbDTmtSxr9MQLUQ29rILzHZcUoPytoMP1rwUg
	TRyoSGZF/suGpoJK1vWA2e8DfLfUj1nWYU2TvSqlLyrR4UBvrbqxP+vxPHmDIcsY
	n7JKtuRjiKeAr/dfz3UUbDLejVlvFNLCsFY1diiPBwXv5huAkY3QOqGEoI9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747928881; x=1748015281; bh=iuNC0W5VU1FrSzVs6drWxzR+akIvtGDQ0FX
	PZ7WERZI=; b=H0ndZsyUiB/RL8mYLXxmaO6xzUPwsUnTpde2dPibRl2qJ9dEhdg
	MvaqJDEr0n3+6voVlRew1ZfzWslCD91sORz+Wd6XypYtIcVr9RkHY+eX25yDUzya
	XbHkJ2KdOuentAC0ZechmJUYiMsKSi+Nwuu0UkNmN4NV90XJyKqB+jfLQf/wVQtR
	4IUkD8EU+6WeRNFeBzUPDzXkQGdbXiurkL3QeIdJvzu5/Fmo/ZHOv8KpweDZ6Ay7
	hVg3+wnMQDWGLEL0AWUBsjdatcs0y8aHbvdVJDbmX0fUqW7kl+W3b5R3tmLId3w/
	PY2HXkXMbmGKDc64448asJvBo+5fR9FfqmA==
X-ME-Sender: <xms:MEcvaMzxEHfBW8evAibYqaGNOyrWfWostCbMdNUTdkEalwoNbh6bow>
    <xme:MEcvaARYegOvx1VCHo2iImjQ0PuQfTGyew7wlKmjxXLbhFuvZZNgd_ZsTMKipTx7N
    xfmcwUYBfjen1UToQ>
X-ME-Received: <xmr:MEcvaOVpO_l7EewJhDXeUOO8dEvc_UI5mf4u0v27etLOHuvlUj6iFxy8R4dard_m_byU__hf3jiqxa80DIPihKpIdaiO0gIm_P40j_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeifeeiucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:MEcvaKhAb_nzgihsJTFJle4F2EOxCoS0ENvdpO_fAGncaqYPwgk_xA>
    <xmx:MEcvaOA7ma_YjOu_EtQbSm9u6CbSsTm8jLt17s4Lrl0hus-hkxN33w>
    <xmx:MEcvaLJacGPmdU1xc9aBcSeCpzMw8r6ykD4g1M6sOPtvDxU3vg-IXQ>
    <xmx:MEcvaFAbCLPzOMcGOYl_eE5Ol_uUQO7LlvGXzka5LkPGTNaCS3gH_g>
    <xmx:MUcvaHAPNh22aDVbcZ-TzKQtAGoUJrlX-7k8X5PJ0dUK8KLgxb9_Vsq->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 11:48:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/2] midx: stop repeatedly looking up nonexistent
 packfiles
In-Reply-To: <20250522053235.GB1134267@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 22 May 2025 01:32:35 -0400")
References: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
	<20250520-pks-pack-avoid-stats-on-missing-v2-2-333c5217fb05@pks.im>
	<20250522053235.GB1134267@coredump.intra.peff.net>
Date: Thu, 22 May 2025 08:47:58 -0700
Message-ID: <xmqqbjrk7ikx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> @@ -460,6 +462,8 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
>  
>  	if (m->packs[pack_int_id])
>  		return 0;
> +	if (m->pack_errs[pack_int_id])
> +		return 1;
>  
>  	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
>  		    m->pack_names[pack_int_id]);
> @@ -482,8 +486,10 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
>  	strbuf_release(&pack_name);
>  	strbuf_release(&key);
>  
> -	if (!p)
> +	if (!p) {
> +		m->pack_errs[pack_int_id] = 1;
>  		return 1;
> +	}
>  
>  	p->multi_pack_index = 1;
>  	m->packs[pack_int_id] = p;
>
> You could even lazy-malloc the extra array if you wanted to optimize the
> common no-errors case, but I'm not sure it's a big deal.

So the idea is to leave m->packs[] for unused pack NULL instead of
magic value, so that users of that array do not need to check?

I think that is a lot safer than the magic "we know this fails"
value that existing callers that have long trusted that a non-NULL
.packs[] element is a valid pack.

By the way, I suspect I am not reading the code correctly, but I am
not sure what fill_midx_entry() does with a failed case.

	midx_for_object(&m, pos);
	pack_int_id = nth_midxed_pack_int_id(m, pos);

	if (prepare_midx_pack(r, m, pack_int_id))
		return 0;

With or without cached failure, this should return 0 when and only
when m->packs[pack_int_id] is a usable pack.  But what about the
access on the next line?

	p = m->packs[pack_int_id - m->num_packs_in_base];

Do we have any guarantee that we called prepare_midx_pack() for 
the pack at (pack_int_id - m->num_packs_in_base)th slot?  Can p
be NULL here?  And with the magic "we know this fails" value, can p
be that magic value?

	/*
	* We are about to tell the caller where they can locate the
	* requested object.  We better make sure the packfile is
	* still here and can be accessed before supplying that
	* answer, as it may have been deleted since the MIDX was
	* loaded!
	*/
	if (!is_pack_valid(p))
		return 0;

That value is passed to is_pack_valid(), which I do not think even
takes NULL.

Puzzled.
