Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABF71BD035
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129133; cv=none; b=UJvrY41HkiPAePbzAShJNNBIdyRNR+Ty/lQ1ZadNh4AYvlbjiJLbStRw8X5aUNgE3M+XGceaU+HIstrAhz+tFoRlz0iOF1KpjIFsOw2+iumqF9O/joohNCTtAM6ewKo6UtgiBlOUF//DAFvlZO0OuvPXOS5QRnZbKPP7p+KnX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129133; c=relaxed/simple;
	bh=ZVWk3WMSJgNzR5SRVJA62UwSczyhJarsYkPzdCAFWTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=keLw+xMBt2ofsryq8qFFWBKZJ5mcEC/uH2gHq35sNrXvDp7l+PDvclgdAdWFsLTyGiRByLIYdMWSSENuPwEym4jZrOgOLrYAMijY50kS/Wf+RG4UkK8VEk//teaEQvqJV9vJm1N7DEqkTHRKeAW4b5Ky3u1M7J0EIetF+Q4vqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pHNOJBnp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZtrqN5o; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pHNOJBnp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZtrqN5o"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A84DA1D000E9;
	Mon, 21 Jul 2025 16:18:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 21 Jul 2025 16:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753129129; x=1753215529; bh=o3pYTsbD1X
	ObyNQu/RkAV5fLDc+twSPzjF4zfun1fpk=; b=pHNOJBnpcaA1wEg58nKq4ADd/t
	+eYiKsXNWIdbUo60P3inUECGlN3qWTj5zYehAukaXQV11cwlIlN3wzapHCO/ha3C
	min0ptcZNCxXeKKmgjlDXORC2epXO2BwcKRudapoCyzvZEMmLqnS8XPIV4UtQGuU
	BrI85sbP1CMu1VFpCOFkgKheCw+GVpoBv3C2FyqKSnO9o2jX7b3BkEyGy3GkQW1C
	C8i4FJeTslQwGwGl6/bM8GJySeF1HqETsOi8bqTeRz/wsFnRNImV0UvmzkxzMUr1
	KzdMvKilThF0SCQpBI2Yoohmf1kS/K4FQh8ioe5csTrZ48ESP2Bi4zYZk+2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753129129; x=1753215529; bh=o3pYTsbD1XObyNQu/RkAV5fLDc+twSPzjF4
	zfun1fpk=; b=hZtrqN5oSBhzNEpx6E7H4kEYRJrwtABk//esxJ2oriDTB3/VPCd
	cB9WN/aJtoE73i3zOIx6rn7qdgbKRN4P/INpPVxByGtqKj2DRIoEIFzS/ul4YHuO
	EgjsdtfiipOgRm/hMZ9gd4ePHsrmWhdflAJnL3Ui5NbZ63rC9A6nEdYiT2YuFFJZ
	kriCzc9Ow6WSq/2OQn0qhP1KQaQmDEaY+fmY1tQ4KxI72JPVs4nHlF0qh2Bja2Zj
	i+UBs8AOy1RM0xG+IEF1UN2dPO54M2qo+eMB4gcob9Mo8CU4WB1KJGxbVxhO9gaL
	JeCMMTaZwkbc29+AzeDvjQER5OWLSULZYOg==
X-ME-Sender: <xms:qaB-aOAu-5d0pILh-T82Q839OEGHfctfHwB4BaESCpffafV_JLV77w>
    <xme:qaB-aFYKrl-4zN1HMVYLbXSNZy-3zgyErxedIBzcraqGgPPhKFce-S9MaGZ7LAP6e
    xAEgnPNX5aAsB-KTg>
X-ME-Received: <xmr:qaB-aBVgOEO82p7nmhpKFVL-hzD2RaZgRJlmIktsDvPr-Aj77yhne7gl46R79cUwx23HVnaIMRGDtrgco6hD17YqwY6lkzvgmBnyfpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejfedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhi
    lhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qaB-aMP2L5DP-msRRLbmIMtY_oRJkpT14A64j0lKNSOFw3ZBg2gHZQ>
    <xmx:qaB-aDb5hCMIX6yNlv0Xuju9iyWuwXjzxdNUndlwVlTwti1GdX4qeA>
    <xmx:qaB-aD-cU_KQg7A979MSWN3GHd-Y2FJZ428uuMBs7e7LHuvF3rOcsQ>
    <xmx:qaB-aMQH2m-nE1TfDuV0fF4NbNPNb6eTZHLxX8OYNUJKjcTebucrhg>
    <xmx:qaB-aHIp7Y7pS81lEiMLesis_O3BQ-mkFq6AnNJZSJ9J2WeF8HW9v3L_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 16:18:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Jean-Noel Avila <jn.avila@free.fr>,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 5/5] promisor-remote: use string constants for 'name'
 and 'url' too
In-Reply-To: <20250721141056.2283349-6-christian.couder@gmail.com> (Christian
	Couder's message of "Mon, 21 Jul 2025 16:10:23 +0200")
References: <20250625125055.1375596-1-christian.couder@gmail.com>
	<20250721141056.2283349-1-christian.couder@gmail.com>
	<20250721141056.2283349-6-christian.couder@gmail.com>
Date: Mon, 21 Jul 2025 13:18:46 -0700
Message-ID: <xmqqldohxpp5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> A previous commit started to define `promisor_field_filter` and
> `promisor_field_token`, and used them instead of the
> "partialCloneFilter" and "token" string literals.
>
> Let's do the same for "name" and "url" to avoid repeating them
> several times and for consistency with the other fields.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  promisor-remote.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Makes the code much cleaner.  Nice.

> diff --git a/promisor-remote.c b/promisor-remote.c
> index 501cb92391..2f86c68397 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -314,6 +314,12 @@ static int allow_unsanitized(char ch)
>  	return ch > 32 && ch < 127;
>  }
>  
> +/*
> + * All the fields used in "promisor-remote" protocol capability,
> + * including the mandatory "name" and "url" ones.
> + */
> +static const char promisor_field_name[] = "name";
> +static const char promisor_field_url[] = "url";
>  static const char promisor_field_filter[] = "partialCloneFilter";
>  static const char promisor_field_token[] = "token";
>  
> @@ -520,9 +526,9 @@ char *promisor_remote_info(struct repository *repo)
>  		if (item != config_info.items)
>  			strbuf_addch(&sb, ';');
>  
> -		strbuf_addstr(&sb, "name=");
> +		strbuf_addf(&sb, "%s=", promisor_field_name);
>  		strbuf_addstr_urlencode(&sb, p->name, allow_unsanitized);
> -		strbuf_addstr(&sb, ",url=");
> +		strbuf_addf(&sb, ",%s=", promisor_field_url);
>  		strbuf_addstr_urlencode(&sb, p->url, allow_unsanitized);
>  
>  		if (p->filter) {
> @@ -663,9 +669,9 @@ static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_i
>  		*p = '\0';
>  		value = url_percent_decode(p + 1);
>  
> -		if (!strcmp(elem, "name"))
> +		if (!strcmp(elem, promisor_field_name))
>  			info->name = value;
> -		else if (!strcmp(elem, "url"))
> +		else if (!strcmp(elem, promisor_field_url))
>  			info->url = value;
>  		else if (!strcasecmp(elem, promisor_field_filter))
>  			info->filter = value;
