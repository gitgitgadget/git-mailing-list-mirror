Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1819A1B4F02
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385796; cv=none; b=LUlfzcSHnqeZwOubwV106szvN2Yn3KygQgZllfBkywnVMQ2bVkIoPnUGiin4u//fyc33CLVHuuE2J1N1jdJTbRp6WOyGwhsxE+FJSdtuyfCf11BNVUke/KDHUQOhG7xondTa9eb/NTgra9mKBB5eyQGj7Jm4sgsNwf53eCgrNAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385796; c=relaxed/simple;
	bh=GnucthqIHp/wjNSTVn/lThY0G7QZm1UhaerPtggjGH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3sLpGnOIH62ZbtAeu1DM8YQ91SIRfCld6oXz9bpkV0TG3za4+9mutfDLagU93GQA1Vqn9xBRCCXmIHoBC3j3zdAg6wdLzIuPOxrjFzTjQtLT2RGSTLHIDnddfk18QaqNYkFWq6DNGgOLzMkfWn/2mhmgJbayhAAFFdQUnl6g+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HOcpqvXs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XstOHUwT; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HOcpqvXs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XstOHUwT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DA65F138088A;
	Mon, 20 Jan 2025 10:09:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 20 Jan 2025 10:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737385792; x=1737472192; bh=saBLBqo7df
	hle0jwjmJk0RT1qhDRN8gG8Uyf+cygmFU=; b=HOcpqvXsIVHYt2PYZpD/xcxMoh
	V4IhVFLtNn7DbDWg+fumSkf49O9x1GxEWxZWCb1I9JpZ00vySOtol2eiKD7JJrmI
	5GzXEC2840V+DIbGdV5UdbRydjXQeN4IxVUDA/wYhBUkHlS5UQn/aNv6KbxszBrm
	1Qn9oEHmV6dpeyWocR7FfSZPI/ZzUw7UC/2ex4kGajGE1cZcDKOqHsGmi/RU4St/
	JWyEPYlOy+sacrWGOvYyIIELWHv++dJZRmBEmqMgdTyh/kglcOD8Lj/2SA4rlV6M
	AkKyGwPQ6mE65A4qigUEIlXUj6q44YEwNfY9sBvkikntX+yMTKGm3AWTgutg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737385792; x=1737472192; bh=saBLBqo7dfhle0jwjmJk0RT1qhDRN8gG8Uy
	f+cygmFU=; b=XstOHUwT/6htK6INxzM92UJhxYkqgn+Clj1bu4dKGb7jfaQ2mKA
	6JCMiVcesaj0ZUB92avUxrv2L2Fvl7ELESvjPIgaVFge0rdrnnQVXKAvKl1YorXR
	f907aqj0BAvneZUFuBd0hf7ihWTlN4RLx9QYJejTT+QA3DEcL++g3yPgDSzHsTv6
	kl4Hn/HdAXOizwF0YRRrEP6GzucKKHqIcME2NcYYcllKu9u1Osyn7XlqZ6dhyE6j
	wCI1fYPPGMkdkJSZiWVFhUMStcVjJT2bNr1/WmPiDlzeZCD8fy176YiFiqqtQ2Ss
	fFC7ZsgdlkblhaoQw4o6oR7ZPh+AzBXWFfA==
X-ME-Sender: <xms:QGeOZwYbsqZ-2YPzWybWdcSaOXnfng_-yjfgUBbYnm4GTO0A75Ngbw>
    <xme:QGeOZ7YBm2N6Smk1KAFwMFYQCpvy3QsZFkY2CEhdB8yKWFjdVPmrVAErilP0q09Rj
    FrvgBAm27iFLNI8Vg>
X-ME-Received: <xmr:QGeOZ6-WsQt1cXcMLqaA5cGdxotoa-YuY68pO5WstN0a7Vfj1jfolvtxmYljdiMU2Rxplr_wBDJhApre8wB_sBna_b_0WC9aQKQBP7Sza3Dzcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:QGeOZ6rONXjELgUacA_hNVw2JJi7nw-S7fS9KhE9-VymBDKGPNXkTQ>
    <xmx:QGeOZ7p-kbNhKDrUv73c1v4oLuI_EOV_GqUuf1RHR2484f30Om612Q>
    <xmx:QGeOZ4StLM0l-fgR5cxilK69Uy6lWbs_ilxp-lGk_DNsjUdVz1L5QA>
    <xmx:QGeOZ7oKOGCSFQo7zIuJA3LH4dHp1KhKkzDoGlU3VD_5kdiR_47Ftg>
    <xmx:QGeOZy3pIxdoEoebkgQFouYg-5ZIQjqcj7bT5Rs8Qc3dh3ZofWBylQKt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 10:09:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d5f18b12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 15:09:48 +0000 (UTC)
Date: Mon, 20 Jan 2025 16:09:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/10] reftable/record: handle overflows when decoding
 varints
Message-ID: <Z45nMqLUHwMGEy11@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
 <20250116-b4-pks-reftable-sign-compare-v1-3-bd30e2ee96e7@pks.im>
 <CAOLa=ZQxp=tmmBwAV2OR9ODLGf_VHLxG_50-YwN7-s7+c6pmNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQxp=tmmBwAV2OR9ODLGf_VHLxG_50-YwN7-s7+c6pmNQ@mail.gmail.com>

On Mon, Jan 20, 2025 at 04:47:47AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/reftable/record.c b/reftable/record.c
> > index 04429d23fe..4e6541c307 100644
> > --- a/reftable/record.c
> > +++ b/reftable/record.c
> > @@ -21,47 +21,40 @@ static void *reftable_record_data(struct reftable_record *rec);
> >
> >  int get_var_int(uint64_t *dest, struct string_view *in)
> >  {
> > -	int ptr = 0;
> > +	const unsigned char *buf = in->buf;
> > +	unsigned char c;
> >  	uint64_t val;
> >
> > -	if (in->len == 0)
> > +	if (!in->len)
> >  		return -1;
> > -	val = in->buf[ptr] & 0x7f;
> > -
> > -	while (in->buf[ptr] & 0x80) {
> > -		ptr++;
> > -		if (ptr > in->len) {
> > +	c = *buf++;
> > +	val = c & 0x7f;
> > +
> > +	while (c & 0x80) {
> > +		val += 1;
> 
> I was at first confused, I understand that we add 1 to check if there is
> an overflow before adding the next section. But this actually modifies
> the value itself, but looking below at `put_var_int()`, we did value--
> before storing each continuation byte. So during decoding.
> 
> Nit: it would be nice to explain that part a bit here with comments.

Yeah, I had to think about it a bit myself. It's quite a clever
optimization: when the 0x80 bit is set, we know that the remaining value
cannot be 0. We thus don't have to represent that value, which is why we
can subtract 1 when encoding and re-add 1 when decoding. This allows us
to save a byte in some edge cases.

[snip]
> > -int put_var_int(struct string_view *dest, uint64_t val)
> > +int put_var_int(struct string_view *dest, uint64_t value)
> >  {
> > -	uint8_t buf[10] = { 0 };
> > -	int i = 9;
> > -	int n = 0;
> > -	buf[i] = (uint8_t)(val & 0x7f);
> > -	i--;
> > -	while (1) {
> > -		val >>= 7;
> > -		if (!val) {
> > -			break;
> > -		}
> > -		val--;
> > -		buf[i] = 0x80 | (uint8_t)(val & 0x7f);
> > -		i--;
> > -	}
> > -
> > -	n = sizeof(buf) - i - 1;
> > -	if (dest->len < n)
> > +	unsigned char varint[10];
> > +	unsigned pos = sizeof(varint) - 1;
> > +	varint[pos] = value & 127;
> 
> Nit: While the `get_var_int()` uses hexes, here we use ints. Would be
> nicer to use `0x7f` and so on and be consistent.

Yup, makes sense.

> > +	while (value >>= 7)
> > +		varint[--pos] = 128 | (--value & 127);
> > +	if (dest->len < sizeof(varint) - pos)
> >  		return -1;
> > -	memcpy(dest->buf, &buf[i + 1], n);
> > -	return n;
> > +	memcpy(dest->buf, varint + pos, sizeof(varint) - pos);
> > +	return sizeof(varint) - pos;
> >  }
> >
> >  int reftable_is_block_type(uint8_t typ)
> > diff --git a/reftable/record.h b/reftable/record.h
> > index a24cb23bd4..721d6c949a 100644
> > --- a/reftable/record.h
> > +++ b/reftable/record.h
> > @@ -34,6 +34,10 @@ static inline void string_view_consume(struct string_view *s, int n)
> >
> >  /* utilities for de/encoding varints */
> >
> 
> We should remove this, no?

Yup, good catch.

Patrick
