Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D9A269B1C
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353849; cv=none; b=dTpKfKDW46ayoWMlGnEVfkPq6XEExzHHA7VvgysgDN2pmoo77ECvS+UzxTJVN0BjAtsVw5G55BoUmfly94aJr8nY+y1dwKZUj8NLyphlQkr60x3dCdudxIry/fW+6N+TmUeY/HVrPfA2HaQVxSxY6Sbznw83JSCp4VL4NDKVnQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353849; c=relaxed/simple;
	bh=fbAPEkk2spx54Cvcrezx4OJLJ4Zr/W3pulUlSBOTo3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3TLD1/tLLpzX4YaZ7VL98mH1kUuvQ/21MTFj1OUs/JQGNAHs00drRgCelL6VB5762M7qVSAKV6++3l9QOYC009td9MjRa6U3NBdBh0NzsCyC2rqqifbaSsw/vMgbzBpDVry6McpXYFqnbCauJsuOfLNSWwh3/5lww35h7Ogsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kZbo+ApW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tUZ2h14H; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kZbo+ApW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tUZ2h14H"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D68A31D00083;
	Mon, 13 Oct 2025 07:10:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 13 Oct 2025 07:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760353845; x=1760440245; bh=QngWPstnwI
	9HTqPimJRrwmlgfddpVl8DzWiVSxPMjTw=; b=kZbo+ApWAWMyaSXkr4isrvu/Fe
	+sdpF6zuqxFFQqyxKtr6UsEavWNpJZan0Ic/NG7ZoX5k331S9dTBEH/O+6GewkzF
	iRTSc81tzuTb6HYN7PpkhjIsdnI3bjyq+QOpKS1HBFsb0EkWoQgXN9sAQ7BWj4QY
	NTBrmby8lChJEAsS+acWBha2AOUU+Q4q+op1DoBnN77mPrjfEcOacCSVPCW+KKYa
	jGpOf+TmMs2DM/Cbo7qWtbNw5ck4VKmjXcbke99z1g4OuKE68zg0RODRcq/f8WZU
	juWsHsg+LtMD6iouAKgeJyS1160MQNH0G+c+vQoO0LC6ScAsgJn6AFV8n2Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760353845; x=1760440245; bh=QngWPstnwI9HTqPimJRrwmlgfddpVl8DzWi
	VSxPMjTw=; b=tUZ2h14HmXQfCo45rkq+n6V+0YvlXP4K/rMeu7LUs94hxo8h8HM
	TZ4iCYm0N5hTB6U/VIu0vm09fEzplliYYy2c/S6qLnhGgOQn1EDWg0AdBNQc00+Z
	f89Y/lLW/mTh9QoTgxh0Exh6eXvmkKXn1GSTqCzpXeMOPl3OXbBR2Yn74/ID2wwm
	i1ynECkEGVwE5K1c6xTyaMw9av5eM7Zq6yesp67EIB2Ssm2b5cJtxiAHGLTP2VCL
	5lMHFRs1NIgDYwW+3kz98IWDGMj0ChLp9L4W031MH4mVRngBjmDaGj3kUnRwqE1R
	WG4YpxjpDfglmhS/vBgZ2L6tr/ObKgkVvKg==
X-ME-Sender: <xms:Nd7saEuVSDrPiedyWYHKMxTvun6XDym_eT1-5VNnA_5l2KZD7750gg>
    <xme:Nd7saHeSwIrWZeMaHnzfbPlFu4HeX_TsNGKEGn8GK3q7uvA_5nHuUu7izLj1eFWib
    WSY3lmzl2QPeDuEgSTWkA4IoaJ16MRMRiyFDMVROTN4_zibok4D7g>
X-ME-Received: <xmr:Nd7saNY8koMv_e026ExrmLFgJ5dtVUWiJ5jiLJuR37rlh6L-XXU1HuMHYj42cIV_unH28I9nSb5QZGiyPGo4sXiLztTD4yB3fN0EgIrIzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Nd7saCV0DjlyX9ROgocvIkmb2Wz7wKy0a8veIdNjhv910FbToKTCBQ>
    <xmx:Nd7saHgvY1mBaNgYICubRFbNFnsbKcZzdlmP8jclj0FXAQqvvUg47w>
    <xmx:Nd7saIXxGJwZb19EEBc7-771qOZ_RsHYDZkjEGCJnr1Xx6TRlZKFIw>
    <xmx:Nd7saGMGzbc64IdZVk8xG7orQmzU5UUy-1PK9_ppztSKO3rC9UxWOQ>
    <xmx:Nd7saPesEm19292KKva5RIV5iV9WUFD9Tp87SiwfKgztvFuvZLwnKZ84>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 07:10:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 176d1592 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 13 Oct 2025 11:10:43 +0000 (UTC)
Date: Mon, 13 Oct 2025 13:10:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/9] reftable/stack: return stack segments directly
Message-ID: <aOzeMLVx6P_AbxCQ@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-6-c7962be584fa@gmail.com>
 <aOjse9udPEoWqUaO@pks.im>
 <CAOLa=ZSfiD4KTSMyc2WW4oC2zyDO9CHmUWwnws3GhCdbtL4rAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSfiD4KTSMyc2WW4oC2zyDO9CHmUWwnws3GhCdbtL4rAA@mail.gmail.com>

On Mon, Oct 13, 2025 at 02:01:15AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >> diff --git a/reftable/stack.c b/reftable/stack.c
> >> index f91ce50bcd..9d9326ce0e 100644
> >> --- a/reftable/stack.c
> >> +++ b/reftable/stack.c
> >> @@ -1639,29 +1640,29 @@ static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
> >>
> >>  	REFTABLE_CALLOC_ARRAY(sizes, st->merged->tables_len);
> >>  	if (!sizes)
> >> -		return NULL;
> >> +		return REFTABLE_OUT_OF_MEMORY_ERROR;
> >>
> >>  	for (size_t i = 0; i < st->merged->tables_len; i++)
> >>  		sizes[i] = st->tables[i]->size - overhead;
> >>
> >> -	return sizes;
> >> +	*seg = suggest_compaction_segment(sizes, st->merged->tables_len,
> >> +					  st->opts.auto_compaction_factor);
> >> +	reftable_free(sizes);
> >> +
> >> +	return 0;
> >>  }
> >>
> >>  int reftable_stack_auto_compact(struct reftable_stack *st)
> >>  {
> >>  	struct segment seg;
> >> -	uint64_t *sizes;
> >> +	int err = 0;
> >
> > The initialization is unnecessary.
> >
> 
> True, but I always think its nicer to define the base state like this.
> This makes it less error prone when/if the code is modified in the
> future. But doesn't really matter, so let me remove it.

The counterargument to this is that it doesn't give us any nice compiler
warnings if a specific return forgets to set the variable, so we may
return successfully by accident. If you leave this uninitialized then
the compiler warns you for every early return where you don't initialize
the variable. For all I can tell this warning is also quite reliable.

Patrick
