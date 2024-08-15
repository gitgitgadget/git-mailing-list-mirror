Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206B17BEA6
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720928; cv=none; b=RZXcmed+VliJ1ZYUJ368iDkc/Gq2BhzFhls1jeb1HLggitEjFhzWNNTjw/fUWF6VsfoTm0R0LudROhb8JkOC/vDHInn3eEpOOQMezSq93sLbBtaGZlshIf3lUdQW8hUeN4SRyaKPqInnNjU+TmTPDTTzo3/GG/0hxp91Hmpk7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720928; c=relaxed/simple;
	bh=9EYCsO9UaKTVRPw2LyV7V6zqOCnLhsZ/SnxlIdjHbxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/ij6gfyrwT+hwsuo1VB5AMSnYAZUpnOo11qTdOHCmFte+jR/4ckfckRD+NjF3NktkW0idkCs/Tep1OYgp09wi7l8t0FUcsNxPqoxE4DV/dhTgL45r/T5G9+K0BC7H+/FV90aVBE1S2pwxWELPhuKtEH/6OXIdykhCW0aBNEl4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c+aiDLHy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EbouqFIR; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c+aiDLHy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EbouqFIR"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1EF701151D27;
	Thu, 15 Aug 2024 05:40:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 15 Aug 2024 05:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723714849; x=1723801249; bh=/6H0dw1CNR
	o7UwRvcKSuzYoOzy5WgUZAWIGRBHnStBw=; b=c+aiDLHyx7P+BGCD+KTzqpvsjo
	5MFE325kNfaPncjJf8zUh/Iup0V8/e+bXDWyGxuQN7IOGVt0l44KsLepYgbWFnM0
	ejyZdtG4RnJMiu52/2i6uNpjAdZ4FktT00RALPu/DBicOcaqovRCOVCmEMAt9u//
	9azcMuwpxoXNmCJV1WT4kbYp2rLWZo+qHYuXlAb9QCnFNIGvS8htP4Ip6/nO43o+
	KY/HCnLcScipuw0NRikyMbbgAUUBU8fFXf04WtgY6J2Lcez8sv0Ro2bS75wH5JrO
	uhaC6fSrMBKXqRk5AtvYQiIq2IU1DXaq+syHgeaEaUmHN9QjZlgXrvESI81A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723714849; x=1723801249; bh=/6H0dw1CNRo7UwRvcKSuzYoOzy5W
	gUZAWIGRBHnStBw=; b=EbouqFIRprI5RCJAR2ZdA7LFr7QFkeX50+fcSjIsR5kI
	PONRP5brTFQ/3hRWZNINgLcwzOBOj9zMkZie84sUrLujC1FCW3O6Dgu9vHRK2Giv
	NU+FdhvI1fpPmHZ+SzUnHGWocPVXtQzWJ5s0S//jnuqcmeouwXiHJsJuI8focnyG
	+54QBS6b9fKIggwVcVf4RezGWAeiVeaa8Eq3WmzdJuSQy8c6NGBFSE8Wod9i3dX9
	+z6x8k7Ngal7pdrYtECBvm/+gj3sRhOY3RqOI2or+H9EV8tY2ICWhOMprVDKtaRy
	CUtuajsc09kaI47sf7wnzIefuMjR23K8JpdoRGsxFA==
X-ME-Sender: <xms:Ic29Zmiqhx_YxOSA1bqTVogGYvrlH_6e0hgJXQUPlI7_jgyxfE5VIQ>
    <xme:Ic29ZnAas98PS4nj4fjbTPuPVmZNtkXoPQDSYeCuweP2JgsmUCAquy2vT_VyOIeDi
    _MISb82v3w9OQsjwA>
X-ME-Received: <xmr:Ic29ZuE5o5-Hs3TMA3_CT1YonoudUaSHeVZecdELpCtxWPqPbV-zlGwfH4XjjORP1EYH0-diwelHyDb5uXsB8qazph4oaxZy5s212h6MueZ3mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthht
    oheptghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Ic29ZvQ2z1wWRGhnFdRxwbLxbfYWmJa97cXvrS5cEq4m5zIMlj4QKQ>
    <xmx:Ic29ZjxizSzHWYRbWtFaOChkQ604u3R-mH2kszidW0tNJpz1rbYskA>
    <xmx:Ic29Zt5X67GR-FUBMqUmeAjzBGC9IQ1KQP3hgKMhFOkW_9KQnFhy4A>
    <xmx:Ic29Zgxvayk2hbvTRT4ytWTgm1VhBTQhb3cmW-BKRl3GXcCz5KRicQ>
    <xmx:Ic29Zj-bp5VOL0RYW9moiECKVUJYmu0iwRShBRRlzIkBUPUNCwCau_ZB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:40:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 31abb66c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:40:26 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:40:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 03/10] t-reftable-block: use reftable_record_equal()
 instead of check_str()
Message-ID: <Zr3NHmKfslOzXlUY@tanuki>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240814121122.4642-4-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814121122.4642-4-chandrapratap3519@gmail.com>

On Wed, Aug 14, 2024 at 05:33:11PM +0530, Chandra Pratap wrote:
> In the current testing setup, operations like read and write for
> reftable blocks as defined by reftable/block.{c, h} are verified by
> comparing only the keys of input and output reftable records. This is
> not ideal because there can exist inequal reftable records with the
> same key. Use the dedicated function for record comparison,
> reftable_record_equal() instead of key-based comparison.

Nit: there should probably be a comma after the closing brace.

> diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
> index 31d179a50a..baeb9c8b07 100644
> --- a/t/unit-tests/t-reftable-block.c
> +++ b/t/unit-tests/t-reftable-block.c
> @@ -15,8 +15,8 @@ license that can be found in the LICENSE file or at
>  static void t_block_read_write(void)
>  {
>  	const int header_off = 21; /* random */
> -	char *names[30];
> -	const size_t N = ARRAY_SIZE(names);
> +	struct reftable_record recs[30];
> +	const size_t N = ARRAY_SIZE(recs);
>  	const size_t block_size = 1024;
>  	struct reftable_block block = { 0 };
>  	struct block_writer bw = {
> @@ -47,11 +47,11 @@ static void t_block_read_write(void)
>  		char name[100];
>  		snprintf(name, sizeof(name), "branch%02"PRIuMAX , (uintmax_t)i);
>  
> -		rec.u.ref.refname = name;
> +		rec.u.ref.refname = xstrdup(name);
>  		rec.u.ref.value_type = REFTABLE_REF_VAL1;
>  		memset(rec.u.ref.value.val1, i, GIT_SHA1_RAWSZ);
>  
> -		names[i] = xstrdup(name);
> +		recs[i] = rec;
>  		n = block_writer_add(&bw, &rec);
>  		rec.u.ref.refname = NULL;
>  		rec.u.ref.value_type = REFTABLE_REF_DELETION;
> @@ -72,7 +72,7 @@ static void t_block_read_write(void)
>  		check_int(r, >=, 0);
>  		if (r > 0)
>  			break;
> -		check_str(names[j], rec.u.ref.refname);
> +		check(reftable_record_equal(&recs[j], &rec, GIT_SHA1_RAWSZ));
>  		j++;
>  	}

Okay. Because we're not only checking for the refname anymore, we now
need to store the expected records as full records, which also requires
us to allocate the refname. Makes sense.

> @@ -90,7 +90,7 @@ static void t_block_read_write(void)
>  		n = block_iter_next(&it, &rec);
>  		check_int(n, ==, 0);
>  
> -		check_str(names[i], rec.u.ref.refname);
> +		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
>  
>  		want.len--;
>  		n = block_iter_seek_key(&it, &br, &want);

It would of course be great if we didn't only verify that SHA1 works as
expected, but that we can also read and write SHA256 records. But that
would be a new addition to the test suite that doesn't have to be part
of this patch series.

Patrick
