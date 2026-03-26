Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA223F7A84
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527679; cv=none; b=QxbBCCb0XpvghZ1ta8g+lY1MLuDnujvOHdjaEF2Tzda/sbp0fLAAhEFy9e8VbaJ1hN/cCM0XaazRv/yO07u5yntEVbjGqIELRvOupArS68/9VfU1hwXWfA4Nrj/gbUYMsK5tMcwVCvNvhV0TO48LgzawIZQwuQ5vGUqvk0IJijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527679; c=relaxed/simple;
	bh=eUDjzJUMjbpZtZrEjxLxX3p7WmzoO8/2NmiBl3kpS0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8NmtPHEa3OpxGWPFRvcvZJyk6QGJomzTa6N7I9zlnFnaMCK/Lhz73wQXS750hL+hNXMk6HP+zu++1U/PrXhyRDYQGXCPI+y0pKg2bdHqyuzeMb/PZKkFDmKJG/eap9xWvtArMK7KMzAK8onR2N3EAfaqFHeDUZd3RE74Sjhhq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JPAM8fR1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MJxOhXep; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JPAM8fR1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MJxOhXep"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D25B21D001F1;
	Thu, 26 Mar 2026 08:21:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 26 Mar 2026 08:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774527677; x=1774614077; bh=NUAWvkiqBy
	Cz+n91fMyOMi4Af+FOnEYhNP3srmMLVt4=; b=JPAM8fR1nh218L8Awq9L/DJcPa
	HuwHXJckZm2lSU4Vf63MGSNb2bNwTuokoTFy8LUz94ng6greO9pPeVhpgYIa1a8m
	xvoIGj/pv362TNg0oPMwzENgg4yk8SNO8JuPxaD0jLsCe52l8ibaDxSX5BPxAcRJ
	oN7z65CWS6jjuD6KChoslhrolTQcb0l1RdWQgqYT1nk8PwZiTbYnwXbyyjTPgBh6
	L2QdogOyX5c0vw4IV39K32sS2UnI76eO4ootMS99qDCykP7xFRLJlbLKxHYvTTNm
	VimpOm0cV4ihY4s4QNmP05uaZ24sk/Ane5rIiqHK8VVJjCtzUZWaYJSD4nOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774527677; x=1774614077; bh=NUAWvkiqByCz+n91fMyOMi4Af+FOnEYhNP3
	srmMLVt4=; b=MJxOhXepwbTKrvtoQu5BxOuCNJDbPhoqHwWz8mujU4M1vVqcYuj
	NZmsHtRyQAQdiiGmejFnKRMGO3fLX7HOT5uFX2JlkKzkTTWefcEifZpFhNFU4hsB
	KBvNvyGUFCGBmFtGoopZeEja5LXnrWFnt6TEesDp3KbU1DB+JSdS8P8Ye8wovdyb
	gyCMZLaznw1Wq5u5CHnW237HYtQD0gugDUTxf+FGuoC1q/dboGxgZjYYnVWNvEJt
	5ifAetPw/V/XZCcdR6WeDtFBdj+gnCItkyzgyMNeb2BstNlQJ/2WtGVORgx157G5
	A9C3TQtTYPFHttlxJ/hja+rMmP9dVKYe9BA==
X-ME-Sender: <xms:vSTFaRZFUm3L8hGjSvtrI4TxOndZbyvVwmwQ78H19WFif4O6Ycq-cA>
    <xme:vSTFaaoyLzkc1j58rg1Bl2wHZ6LsM4V4KkjuGJftVC3vLc-UuujVthxW7XgUdA5Nz
    FPtsuobgdYS9n4m3DMOmI-sXGRIXCE93C0qHUmFuLN9tzWa_Rg8Yds>
X-ME-Received: <xmr:vSTFaWMqmcxSOPUAmrgC_hlzuNcJXCYRLrcM7QnaNGabFQgqFntc__igw_7QIGMZzF-omW-auKo4UXHK4cDqSDHO-d6TTpu433G_mhpbLFPrFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:vSTFaVpsPzVQ5dyXzaRriV69cCeuK26G7ZfdXBgHCp2NmmfAdjLbbA>
    <xmx:vSTFabfSBt73x0WkUr8sGyZ5qpRNz3GWdvnqOPqvf1zYWc1JWFVZOQ>
    <xmx:vSTFabSBOe8eP5cFZwaRf9UmodHKMO14NZAZ1Vbb3GOB2RMrqT9JqQ>
    <xmx:vSTFaUZNzqO9kXu1K9jdtl1Y0s5hK_AKJaQ4ONyoHIic7bqeDQx_rg>
    <xmx:vSTFafbhC5Hf04agQZde0hrIcK7Qn3ngAWAJAe_33GiyL40bNZV1phfS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 08:21:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6a3943a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 12:21:15 +0000 (UTC)
Date: Thu, 26 Mar 2026 13:21:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 09/16] promisor-remote: add 'local_name' to 'struct
 promisor_info'
Message-ID: <acUkuD6iuq6nTeHn@pks.im>
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-10-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323080520.887550-10-christian.couder@gmail.com>

On Mon, Mar 23, 2026 at 09:05:12AM +0100, Christian Couder wrote:
> In a following commit, we will store promisor remote information under
> a remote name different than the one the server advertised.
> 
> To prepare for this change, let's add a new 'char* local_name' member

Micronit: s/char* local_name/char *local_name/

> diff --git a/promisor-remote.c b/promisor-remote.c
> index bdfc5e7608..da347fa2dc 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -434,15 +434,19 @@ static struct string_list *fields_stored(void)
>  
>  /*
>   * Struct for promisor remotes involved in the "promisor-remote"
> - * protocol capability.
> + * protocol capability:
>   *
> - * Except for "name", each <member> in this struct and its <value>
> - * should correspond (either on the client side or on the server side)
> - * to a "remote.<name>.<member>" config variable set to <value> where
> - * "<name>" is a promisor remote name.
> + * - "name" is the name the server advertised.
> + * - "local_name" is the name we use locally (may be auto-generated).
> + *
> + * Except for "name" and "local_name", each <member> in this struct
> + * and its <value> should correspond (either on the client side or on
> + * the server side) to a "remote.<name>.<member>" config variable set
> + * to <value> where "<name>" is a promisor remote name.
>   */
>  struct promisor_info {
>  	const char *name;
> +	const char *local_name;
>  	const char *url;
>  	const char *filter;
>  	const char *token;

I think it would be easier to follow if the struct-level comment applied
to the general description of the struct, and individual members would
then have their own comments describing their intent.

> @@ -464,6 +469,11 @@ static void promisor_info_list_clear(struct string_list *list)
>  	string_list_clear(list, 0);
>  }
>  
> +static const char *promisor_info_internal_name(struct promisor_info *p)
> +{
> +	return p->local_name ? p->local_name : p->name;
> +}
> +
>  static void set_one_field(struct promisor_info *p,
>  			  const char *field, const char *value)
>  {
> @@ -819,7 +829,7 @@ static bool promisor_store_advertised_fields(struct promisor_info *advertised,
>  {
>  	struct promisor_info *p;
>  	struct string_list_item *item;
> -	const char *remote_name = advertised->name;
> +	const char *remote_name = promisor_info_internal_name(advertised);
>  	bool reload_config = false;
>  
>  	if (!(store_info->store_filter || store_info->store_token))
> @@ -927,7 +937,8 @@ static void filter_promisor_remote(struct repository *repo,
>  	/* Apply accepted remotes to the stable repo state */
>  	for_each_string_list_item(item, accepted_remotes) {
>  		struct promisor_info *info = item->util;
> -		struct promisor_remote *r = repo_promisor_remote_find(repo, info->name);
> +		const char *local = promisor_info_internal_name(info);
> +		struct promisor_remote *r = repo_promisor_remote_find(repo, local);
>  
>  		if (r) {
>  			r->accepted = 1;

Okay. These hunks are essentially a no-op for now given that we don't
yet store a local name.

Patrick
