Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E3221723
	for <git@vger.kernel.org>; Wed,  7 May 2025 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746606347; cv=none; b=k7rIBWtKOS+Td6/HTJ70N1FT0+f/bHMa471uR1iun6gZ6i657kh3yM7sMZIDxOrP9u91ikeiGLLdaTPr8QAQsgbgTEA4hhVgf8sUpsGUQpLdHhlDjhNsNQkbS8dP24wCu57OQEaWLrSaMetnQzPx+NmMT1726MX87DIz2/4Dv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746606347; c=relaxed/simple;
	bh=v2lkD+czUosodtG5uIIDldI2RlOVzK6VdXReP8ARfXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJVQGkiS+JfFQNewch1y/8eB1gu0PWsYG+CSli/6IQuk2zkwWEDHDbPuHGmko59uxA0xHr45EnzgTmA7cQE3WAR7GzIFDmxjj3JtbV4lsbLZs+XNpffo7INOrbOYM2Pjsd/J2X0LIzejwQWsDcsc94koZKH5WHTAlolP2UB0s5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OPm3c+2g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RvY7t+33; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OPm3c+2g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RvY7t+33"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 145271140156;
	Wed,  7 May 2025 04:25:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 07 May 2025 04:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746606343; x=1746692743; bh=S8ciagLgzF
	yOtJ21gKrmcY3cTbBQ2rBZhmRXSkXvM5o=; b=OPm3c+2gDCb1rzQI98jOfAjtyH
	WkL8Tbr51qL4xqv12CF4LVks1rWCdMLkcJYOdJ2JwbXSafUq+xuCxhs7VJYPFVca
	ZoTYMdojtZqcE5Qx0OkC4Mtk1Gb1e1RZ9SCN+NBK2gGptAskoN5M4XZKHp61y4Yj
	gEslgwX9htt9rF0vyhHPWjt5x6eCAdKDj/YL2XvWDsUP1kQxfA11PRhfsgBOeY6H
	5i8O/4sPtt5j0scNUhoIga40KJhYsNTsSBnWp4BtV6HbQKDs4OgbFHwKAvz4ccSw
	uOOhyXY0tO9iwlvJ1bAVYEQppwy9W9eXyIHZa1IaMwgpdljuhUl1mrzOKuSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746606343; x=1746692743; bh=S8ciagLgzFyOtJ21gKrmcY3cTbBQ2rBZhmR
	XSkXvM5o=; b=RvY7t+331i4k0Edgcro72f3KDIe+aPIuRDh8n9X/9TA8Ondrd4+
	cwazla8QIPYpGdph9U3uyO/h7lxFy0UVtRY0wCwE471ijtGyXBbQftGcrD82oMdI
	CGZV4XX6aRdN04j8Qgxl4X3ivSZSYmbFFno4rwA5yHo14jX4m315pbxKj19kSq08
	RKsQc9MZjNlXhu07CjkrsEtSGfC3AjwkJe5sMl7k02gYiCWAUvSOfXUTxZXowNKy
	PSYPdzbZS2maAJ9j6OKt6fMljtQLjIzH3XgPbak3yfibigGQ7AGjpl81JIAVmDbj
	Yv6ZX/7INRpkLqZTHwtcjCXnOsKahP4LFtg==
X-ME-Sender: <xms:BxkbaAGeYnblw49zN3LbMgOmxj6Nga6TDbwH8YpMLP9qk1VCyhPrlQ>
    <xme:BxkbaJVI1NA4wqSwozFVNMbJE_hSury-3n1ZeK33dP1F3mMl7BPM6ie_GyxGi_DsG
    Jm8xjGlDiHQb-Db-g>
X-ME-Received: <xmr:BxkbaKIdVbp2711z5WeuczpPkX0LyvGVFOmzB20pa9sOdblAypIp9xe7teleEiNUNHjdhAfkaeYBqcPfQNRPYtCA31rUgGmr790CB9EskzxMHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeifeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:BxkbaCGWGOHG6ozWexIaWdv4Tv81R5JUj4MnfeaZvu4ZNjKLQov5qA>
    <xmx:BxkbaGVWCS8e-jBJH0G_QrmuqJnLA1-30S9eIkOPXjFcAAMaH5JcwQ>
    <xmx:BxkbaFMjmyagKFtui_mnKxKh0HWCdpqLVFPqtVndreXRu02_w5xrFw>
    <xmx:BxkbaN0t7M6F_pM3Ykb6tFdmCMJNFXcTZiWy4DA5h-Wp0v7bfYBg0A>
    <xmx:BxkbaF4Kj9XWqxil1TCNAl6JJmdlcu8eUjao3YF2k4uSJwu45Yx8fVIi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 04:25:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 301cb124 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 08:25:37 +0000 (UTC)
Date: Wed, 7 May 2025 10:25:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/3] promisor-remote: refactor to get rid of 'struct
 strvec'
Message-ID: <aBsZAKmaA_uGPgk2@pks.im>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com>
 <20250429145243.992252-2-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429145243.992252-2-christian.couder@gmail.com>

On Tue, Apr 29, 2025 at 04:52:41PM +0200, Christian Couder wrote:
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 5801ebfd9b..24d0e70132 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -314,10 +314,51 @@ static int allow_unsanitized(char ch)
>  	return ch > 32 && ch < 127;
>  }
>  
> -static void promisor_info_vecs(struct repository *repo,
> -			       struct strvec *names,
> -			       struct strvec *urls)
> +/*
> + * Linked list for promisor remotes involved in the "promisor-remote"
> + * protocol capability.
> + *
> + * 'fields' contains a defined set of field name/value pairs for
> + * each promisor remote. Field names are stored in the 'string'
> + * member, and values in the 'util' member.
> + *
> + * Currently supported field names:
> + * - "name": The name of the promisor remote.
> + * - "url": The URL of the promisor remote.
> + *
> + * Except for "name", each "<field_name>/<field_value>" pair should
> + * correspond to a "remote.<name>.<field_name>" config variable set to
> + * <field_value> where "<name>" is a promisor remote name.
> + *
> + * 'fields' should not be sorted, as we will rely on the order we put
> + * things into it. So, for example, 'string_list_append()' should be
> + * used instead of 'string_list_insert()'.
> + */
> +struct promisor_info {
> +	struct promisor_info *next;
> +	struct string_list fields;

Now that we have a restricted set of accepted fields, wouldn't it be
easier to store those as individual members of this struct directly?

[snip]
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
> +		if (strcmp(p->fields.items[0].string, "name"))
> +			BUG("First field of promisor info should be 'name', but was '%s'.",
> +			    p->fields.items[0].string);
> +		if (!strcmp(p->fields.items[0].util, nick))
> +			return p;
> +	}
> +	return NULL;
>  }
>  
>  enum accept_promisor {

If so, we could also simplify code like this because we wouldn't have to
assume any indices anymore.

Patrick
