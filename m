Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FA202F8E
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316827; cv=none; b=D25k8i6Mq4qJ7z2/Ipaqmu3eZqjf2hGtw/NMCT6G2zZ38JNPDbWQNU6au7zP+LwZGUkvvs5x4lMJm3iuASqL2oV/g9u3mR60/LBw+kzuMbnKqhjKWSUCFUjIHNA1pnLWabcUO0MbiGbmc4COhrVC9g43KHev6noEbTSOSQHUWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316827; c=relaxed/simple;
	bh=fEqV0P9bSzPdFq13Sfa6V5NSv8WEXcrY2JgQrb9gj5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtY5fKvFpaNx4dZvZdXpXShcVk/u361rA/b/GH12SJzYjJ7t1Nfcxb0N/scSHqcOXFort8bB1P9dlDMfDAjYNagRv2ObYRlEjJSc4+A+dOn6K0DpqUS34RULxtOau6mqZYIsZ5Zjc5o3evllQN3S2vdEToBU8HlMtsi91QRD8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LtWX4Kfb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V3lnnqsf; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LtWX4Kfb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V3lnnqsf"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 11B4725401B0;
	Tue, 22 Apr 2025 06:13:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 22 Apr 2025 06:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745316822; x=1745403222; bh=07lxC3lbe2
	9oSEnAlXLat0yOsBDTM/6t+zWOWkH1izA=; b=LtWX4KfbEUeekpdm6AEUHMn0zv
	XMCM/RetpJXMiDuOx9C8oIMedWWU+odvPts2t/zZzMHEi0F/Ybl/YIPOctLHhARD
	X/KQxoSfo4hATHR7TcAR9TrOYeXPDNIBPH1z+iVlXE0y879bDECtRtStzuPOEehg
	eyq9q4Nu4T4a9NRzlBfJNFarB7zubow1C4TJXXnVj70slkFENdCOhmoxCUi28Sp4
	+dVVMtHNPr5fTaCMc5kStfpFK3nkuHrS8UWrKg3GXsqLObWhd764n7SOGsSSqMnS
	m4gGTY7RDdav3tU7bRFqOMzLDDrFXAUPTQSp7rw9De52ApScYkK+4dJvQnMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745316822; x=1745403222; bh=07lxC3lbe29oSEnAlXLat0yOsBDTM/6t+zW
	OWkH1izA=; b=V3lnnqsf1sLWH893CkFzzAVKnM0ni6waminPVEKfqqInMcyaLPz
	7EO9Ske445VAiOoY69Qr1hq951ykbMSokPrDS69RpiZA7bLd3CyPhKXRa3OSy8Ly
	I/g2q6A9VN/qsS8jN5DEhgUIXVUDH+w7X+Pp4rTJ6Sb9gqM8yM5NZc+vd5i1K8zp
	4GK2SNf1JZMnV7KrabQKuK2adezQDEagvNEWuOP6TrQujuRgtFbwIcFdhGJIoOrQ
	0fqr9ODfdShuAyXmeoWicvUSHvc66hKXSxCQVw+Wz6XzIQlYY5yhxRbkACQRaBzM
	+7HsnBk6rgo8gZRLcPkuPd+T763wtI8ce2Q==
X-ME-Sender: <xms:1msHaNPF2fzeQOHDpd_uJqBPL6HdlcPSNZ4m3xL7AiU2DE_tIst2Kg>
    <xme:1msHaP_o7vDJ6dqtHGZKwf3YVeV6mlWwZDPRgdpKLwF_L2RAm4U4baS0XwPyF-J-d
    ktHHkj4DQ_cSGn8lw>
X-ME-Received: <xmr:1msHaMSmgh-TZO92ptjtlWmLOnxDflra02FyLMUMqFQH5JZHp_0fVoUj5nYiZciqLf6vwuevtQQfkgtNZBL_SVkGjDirLrDfhJ7vG12dwQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhr
    tghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:1msHaJuFCMbKmjE3b1WPrGUHbqiMJY8FHz093b8s5qvj8ov7YOBu7g>
    <xmx:1msHaFfp0cpGSnNn6KaP8GWohCxixRiOhm6wHLt-TjPvcMAXGZlg_w>
    <xmx:1msHaF0gHwKfEr-gi4yT_IXFARmkfr5ZyH7nTLmCBK_bSKyViYMV7A>
    <xmx:1msHaB_nrcxGWRlwQLLzghXy23qVtqn7r193qFbc1d2T2KTeNfwsjw>
    <xmx:1msHaHBeGRUZXmrKVHXESU1IFJrajU1MJysuBpWtBCORC9uHZomgqR3R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 06:13:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75d7cfcb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 10:13:38 +0000 (UTC)
Date: Tue, 22 Apr 2025 12:13:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/4] promisor-remote: refactor to get rid of 'struct
 strvec'
Message-ID: <aAdrzlUX61TK1x8_@pks.im>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250414160343.2216312-3-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414160343.2216312-3-christian.couder@gmail.com>

On Mon, Apr 14, 2025 at 06:03:41PM +0200, Christian Couder wrote:
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 5801ebfd9b..0fb07f25af 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -314,10 +314,38 @@ static int allow_unsanitized(char ch)
>  	return ch > 32 && ch < 127;
>  }
>  
> -static void promisor_info_vecs(struct repository *repo,
> -			       struct strvec *names,
> -			       struct strvec *urls)
> +/*
> + * Linked list for promisor remotes.
> + *
> + * 'fields' should not be sorted, as we will rely on the order we put
> + * things into it. So, for example, 'string_list_append()' should be
> + * used instead of 'string_list_insert()'.
> + */
> +struct promisor_info {
> +	struct promisor_info *next;
> +	struct string_list fields;
> +};
> +
> +static void free_info_list(struct promisor_info *p)

Nit: nowadays we would call this something like
`promisor_info_list_free()`, with the name of the subsystem coming
first.

>  char *promisor_remote_info(struct repository *repo)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  	int advertise_promisors = 0;
> -	struct strvec names = STRVEC_INIT;
> -	struct strvec urls = STRVEC_INIT;
> +	struct promisor_info *info_list;
> +	struct promisor_info *r, *p;
>  
>  	git_config_get_bool("promisor.advertise", &advertise_promisors);
>  
>  	if (!advertise_promisors)
>  		return NULL;
>  
> -	promisor_info_vecs(repo, &names, &urls);
> +	info_list = promisor_info_list(repo);
>  
> -	if (!names.nr)
> +	if (!info_list)
>  		return NULL;
>  
> -	for (size_t i = 0; i < names.nr; i++) {
> -		if (i)
> +	for (p = NULL, r = info_list; r; p = r, r = r->next) {
> +		struct string_list_item *item;
> +		int first = 1;
> +
> +		if (r != info_list)
>  			strbuf_addch(&sb, ';');
> -		strbuf_addstr(&sb, "name=");
> -		strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
> -		strbuf_addstr(&sb, ",url=");
> -		strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
> +
> +		for_each_string_list_item(item, &r->fields) {
> +			if (first)
> +				first = 0;
> +			else
> +				strbuf_addch(&sb, ',');
> +			strbuf_addf(&sb, "%s=", item->string);
> +			strbuf_addstr_urlencode(&sb, (char *)item->util, allow_unsanitized);
> +		}
>  	}
>  
> -	strvec_clear(&names);
> -	strvec_clear(&urls);
> +	free_info_list(p);

I don't quite follow the usage pattern of `info_list` here. My
expectation is that we'd:

  1. Acquire the promisor info list.

  2. Iterate through each of its items.

  3. Free the complete list.

But why do we free `p` here? Shouldn't we free `info_list`? And if we
did so, can't we drop `p` completely and just iterate through the list
via `r`?

>  	return strbuf_detach(&sb, NULL);
>  }
>  
>  /*
> - * Find first index of 'nicks' where there is 'nick'. 'nick' is
> - * compared case sensitively to the strings in 'nicks'. If not found
> - * 'nicks->nr' is returned.
> + * Find first element of 'p' where the 'name' field is 'nick'. 'nick'
> + * is compared case sensitively to the strings in 'p'. If not found
> + * NULL is returned.
>   */
> -static size_t remote_nick_find(struct strvec *nicks, const char *nick)
> +static struct promisor_info *remote_nick_find(struct promisor_info *p, const char *nick)
>  {
> -	for (size_t i = 0; i < nicks->nr; i++)
> -		if (!strcmp(nicks->v[i], nick))
> -			return i;
> -	return nicks->nr;
> +	for (; p; p = p->next) {
> +		assert(!strcmp(p->fields.items[0].string, "name"));

Why do we add this assert now? And if we want to keep it, shouldn't it
rather be `BUG()`?

> @@ -414,11 +461,16 @@ static int should_accept_remote(enum accept_promisor accept,
>  		return 0;
>  	}
>  
> -	if (!strcmp(urls->v[i], remote_url))
> +	if (strcmp(p->fields.items[1].string, "url"))
> +		BUG("Bad info_list for remote '%s'", remote_name);

It feels somewhat fragile to assume hardcoded locations of each of the
keys in `fields.items`. Would it be preferable to instead have a
function that looks up the index by key?

Patrick
