Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22101EF37D
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592399; cv=none; b=C9oPF1bXgxQBtIaFjWnyErW0u1HGrW5b1v97Y7zis6pau7Z9rvnk66wdyc7Fgq67Pw47gjyb96hFRtPl6jINsFvgt0tgsu047BAbhfomJlPQp4nbzY1mb9bEGqeT5/0FCCHCD9HpFBWnlOzSgDxZqy4YTUKtPluHauVGfuV4uNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592399; c=relaxed/simple;
	bh=GWUjPNexmVsCWHjU9rG0aaAmxvUCsz73316E5TJ9+48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unJcchyYOtD4trs8U2SGJLRDqH+KANzw3qeaL3RxAgJLqflwquM1WxwdAETAO71XNQ8g1K7QL6TE98INeWGlkaApIPzj+aReRe3e+kGQ4kfOrSEYO2qrfHpYFAqSH4k1V2NKOvNIX0zu9D3DfBYzzrjALD0RiJZoA4vmUwn2LYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S0IGCdMi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kFmDKXd9; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S0IGCdMi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kFmDKXd9"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA1C2254021A;
	Wed,  2 Apr 2025 07:13:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Wed, 02 Apr 2025 07:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743592396; x=1743678796; bh=E82OZ3cYP4
	NI9d6jHZFM4/gDtBL4vVTpHyn+PXyNkvo=; b=S0IGCdMirv4JgqEvVXqPb37tsi
	f4i/XCD6nPHHUAeuNtQUvi2eCpVMZrM6Ghiy+1lnvyun8t7KQcg1Zzu6hpNkzfN9
	bER0QNwU9b/sJGgIE/4ymRas+Ux53iyfMizcdHAYAhooBHva7Cop/niOlqrcgpo3
	7kH7tcOzfznyZHEBJBsIqFbISKYIvV0b0R8PuKCU/VpAiZX1P2PZ3/CBIRKorEtT
	XrKtV39x5K9nNOz9r0Cy+y4/eaIgBF/TMpVuuLPJAd/d1hUTtCJ7tPkGG/qnxTv9
	5098Y+pG4zmRA/9iX5/QeuUGvxQe4qAsS8jFqqV+ChkAwiEHDCHHqzjA2SYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743592396; x=1743678796; bh=E82OZ3cYP4NI9d6jHZFM4/gDtBL4vVTpHyn
	+PXyNkvo=; b=kFmDKXd9MK7NDMav8cZp7EJO7CYrFrl+UuqKdobc7BuP6E0/dgS
	ic+rKAL6OPunfADvo+9dgTs5eSXosqC2pGe22XKI62P7vqzZHnbkXIZ7tYQFYSI1
	AdVKh2IA5WaI+C4EyhIUNn6dEMAPB0HgxAfKxBn7m0LjKPoSIVugf3Wp1hoj7+vr
	Vht9MX5nzzAAB4B+QdrDX6oAZm0Lfp9i5TASvwg9p5KbOZyPzpQ8xK9n+16TOO+o
	XLfghnGBWOby8k9EjrL30bVGdkiulbB+avo4CMJB8jGm0iisMsygHLELLWLyKTFj
	GLMvikzrsWy3Xsi4ic0lbl5uPAdSHZY1/oQ==
X-ME-Sender: <xms:zBvtZ3EiQ3WdhMBTrXzTqAN6Di5ySFKHBZ1oar-Z7mhX_InXuPaM6w>
    <xme:zBvtZ0VMqUQc76IHQk6fhLauaqdOrF1P6SZrvOxDBk5miGhBTSZRvQdJqWmuGRBXg
    w2P0rFsLxIbi-X4yQ>
X-ME-Received: <xmr:zBvtZ5LPl3OUIt0GQPn3g4_pf4JdYATBsiMWIx32pQWQdGdBwyuzXVNE8CHqVkmNNzWkqy19GAWu-29HY8FTpEqFrybZcVT0n1gQLEnbACvhSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:zBvtZ1H5m9c6VIIy4lRgkWkwEu2D0dvU5cdpYkRtgx88dCNblm5Xtg>
    <xmx:zBvtZ9WxV0DsmrRqrkaVPngxkZ-vHImrzBieFVcOY4a51XdUlfIaBQ>
    <xmx:zBvtZwOyXlYbKiIff456vUmWz1jgGdGGaCdPmAuPFcjcdBPt_TBXlg>
    <xmx:zBvtZ80OogFhcMD7QL4P3g56xXAEwno-DBQv4HspAZV4rgMYmMHg2A>
    <xmx:zBvtZzVjiIShOfGYhIqkmOEUNCBGFZqF5qlHEl_C9EMmNlrsSjd4e9-N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07dc33fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:14 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:13:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/10] builtin/cat-file: deduplicate logic to iterate
 over all objects
Message-ID: <Z-0byX56V2E1pGKO@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-9-4bbc7085d7c5@pks.im>
 <87jz84f5a2.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz84f5a2.fsf@iotcl.com>

On Tue, Apr 01, 2025 at 02:13:57PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 430320adfe9..6f5dbc821a2 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -803,6 +779,45 @@ static void batch_objects_command(struct batch_options *opt,
> >  
> >  #define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
> >  
> > +typedef int (*for_each_object_fn)(const struct object_id *oid, struct packed_git *pack,
> > +				  off_t offset, void *data);
> > +
> > +struct for_each_object_payload {
> > +	for_each_object_fn callback;
> > +	void *payload;
> > +};
> > +
> > +static int batch_one_object_loose(const struct object_id *oid,
> > +				  const char *path UNUSED,
> > +				  void *_payload)
> > +{
> > +	struct for_each_object_payload *payload = _payload;
> > +	return payload->callback(oid, NULL, 0, payload->payload);
> > +}
> > +
> > +static int batch_one_object_packed(const struct object_id *oid,
> > +				   struct packed_git *pack,
> > +				   uint32_t pos,
> > +				   void *_payload)
> > +{
> > +	struct for_each_object_payload *payload = _payload;
> > +	return payload->callback(oid, pack, nth_packed_object_offset(pack, pos),
> > +				 payload->payload);
> > +}
> > +
> > +static void batch_each_object(for_each_object_fn callback,
> > +			      unsigned flags,
> > +			      void *_payload)
> 
> Why is this `_payload` typeless? I see it only getting passed in
> `struct object_cb_data`, is there a reason to hide this type? With
> payload being wrapped in payload I think it's beneficial to keep type
> info where possible.

Because the payload gets forwarded to the callback, and that callback
accepts arbitrary types. You can already see this now: we call the
function once with a `struct object_cb_data` pointer, and once with a
`struct oid_array` pointer.

Patrick
