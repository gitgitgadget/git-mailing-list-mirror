Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A841862
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035878; cv=none; b=ObzPFPqYHOXOF9BFk1bPe5HdlavtWJ0Meg5I5gvNTNw81ypQqHVFNKAaraeiqhZubEUC41C110k9uhyJUhx6NxHrszwiQoOTs/4sTXTENjwXIwgInOkVfp3+mxUw9IEfrWvwx5OMPtjXVA9RIvBU160XJHQzD0q+ovBqihESD7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035878; c=relaxed/simple;
	bh=NOAU+bp9N0uQPX3nFr7L2J7Vv85HvfxvXdbBrIdmbOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1DV/qjJ/C1OJ6RLMWwHNpm+6VvbcdqHTEp6V+9nQdA4bA46iYzhAALZz4ZWvH8uWdlHqMo7no7+9SYIvbiDPrMKIRC95A16+znJQT/RK00T4eXLu3LQ9x9E4HztKqU99/EvnKpJVv7dxdXpqyHCYpntzXmrIMlwjYvp/P8lvpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jcLRbKB/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hWlIcUke; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jcLRbKB/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hWlIcUke"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E7A61140193;
	Thu, 16 Jan 2025 08:57:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 16 Jan 2025 08:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737035875; x=1737122275; bh=5rvUH5+vLk
	EaJeG1XwS4NyXXSgfCeFRv7KDbYbL2P5Y=; b=jcLRbKB/eisqnCsTG11ZkYXr2w
	wRlhLLQ/Fvhum5BKXrbHhFAL78RgEaIadsUPsmsiOyrTLrq+ahVXO3aGYXDyO6vD
	bN4OfWzKHFpsCvduHNgwxI7wvxMv53IgUBVhG/H3vNYpbA7StlQk/XdvHE/MeVTq
	a7vkKbOsnyCuJWJtB/B2QPmm4RJf45upQvG53l/f7iZNbjqL0Fynj+GwgKtblnN3
	TkkqN4f/dKpBptd7Ir+Tdde0v9u6ftezLBF2iox5KigfhdYW9R8PiKqUzjEbiJJQ
	gLRPI7qovNNxKCXtkfhWmm4UP6avsWNZTHxct3PjlvpM2/PDnsJJpkNI1z0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737035875; x=1737122275; bh=5rvUH5+vLkEaJeG1XwS4NyXXSgfCeFRv7KD
	bYbL2P5Y=; b=hWlIcUkeqPPrFQAhZ8uVfuEwJac7GQ9T+gzdf5+uCsXIDwcJBmx
	T6c5/jHcWog517EXUGJyk7fb+obLv7HG9cynkNQyRiyEALBKpDVanrrNKs4s7Q6K
	Ze65FUje2JKaj3mJo/G9Mg2epgf/RdNgryojeoPZz2GpECR0n4hSXJGG+jkCR3Ag
	/0DU6A7fAJ5PWYs0jLUDBU+KbVTW+uCAhunRaICQaQAJrntbJitRFECvJ2wOjdgA
	QnPWkfqMCClwFH/t6yrfiViqgcBIJmGO0F44pbTbs7BNcdv8cxg8oJeXqipx+iFk
	zzSjPboNGS/8m1qU8G+pe8G/iwU7gI7PWKA==
X-ME-Sender: <xms:YxCJZ2hSIqqNuRi42lo5wYPH_AO3eurBpcr3wEN3qVLFhpeJBagOeg>
    <xme:YxCJZ3CifLaxA-eiALo8tEys32pEHC4-wpruVnsnuxO4PMRai-ka6WhFls-CMdYc0
    IcErEfmnKjPHvn7Rg>
X-ME-Received: <xmr:YxCJZ-EhooPklh7AYXey6o-EYefHd6xVSMUL7m0EFU8f5B6FimQWC-Gj7dqg_1KDaVufl2EUJFyY3yBhSsbGGibZbwMG9cl2jOh1YbkOI46_2wjr_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhmihhtrdgvughupd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehshhgv
    jhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:YxCJZ_T-x1TpMyw6roAdgQkHRsA4PxVfD2OkvZDUq-nd9F40V6pUUg>
    <xmx:YxCJZzyKaqU5kYSzZME1BNjD8_ahjV6xlRSc--MzAP3om16aEf8iAw>
    <xmx:YxCJZ95fxR56lHYU5M93-GjvkoxnfkF0L2LHl5f3ywhkzPepaPrm9Q>
    <xmx:YxCJZwzXcMV4h4A4JqwqPcnfUrc068Aj3E1BnQWG1n5O734P17zpeA>
    <xmx:YxCJZ-p9Zdh6cLgMVXLDLjUJ7XWFRYBIzHMWW-bqLRybvBcKqdZ3OndM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 08:57:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2940d914 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 13:57:54 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:57:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 09/10] packed-backend: check whether the "packed-refs" is
 sorted
Message-ID: <Z4kQYfT73geFdMNJ@pks.im>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qOJ_ixuoE4yTut@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qOJ_ixuoE4yTut@ArchLinux>

On Sun, Jan 05, 2025 at 09:50:31PM +0800, shejialuo wrote:
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index d83ce2838f..df65fec5a5 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1980,6 +1989,50 @@ static int packed_fsck_ref_oid(struct fsck_options *o, struct ref_store *ref_sto
>  	return ret;
>  }
>  
> +static int packed_fsck_ref_sorted(struct fsck_options *o,
> +				  struct ref_store *ref_store,
> +				  struct fsck_packed_ref_entry **entries,
> +				  int nr)
> +{
> +	size_t hexsz = ref_store->repo->hash_algo->hexsz;
> +	struct strbuf packed_entry = STRBUF_INIT;
> +	struct fsck_ref_report report = { 0 };
> +	struct strbuf refname1 = STRBUF_INIT;
> +	struct strbuf refname2 = STRBUF_INIT;
> +	int ret = 0;
> +
> +	for (int i = 1; i < nr; i++) {
> +		const char *r1 = entries[i - 1]->record.start + hexsz + 1;
> +		const char *r2 = entries[i]->record.start + hexsz + 1;
> +
> +		if (cmp_packed_refname(r1, r2) >= 0) {

Makes sense. It has been a source of bugs a couple years ago, and it can
silently make you receive wrong results, so this is quite a sensible
check to have.

Patrick
