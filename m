Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64923BD14
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753131562; cv=none; b=V1IX3z9qMreA5sVEvxvFTm3itJSP8fkLv599h7GoKyf3pcssVksOjns1JfWcWFGYj9tK13CS4aGsDOoqp1YT70PVX5+r0R0vb4h+jbPArNf2+fNdPvK6hwFQIzGhJgoWZjIpVgtcSw5QcYXbCapOk2JCST3l72Q+PbmrC4TURd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753131562; c=relaxed/simple;
	bh=pPlpVhxtZ+ERDV/xX/x0CYl+2XJmcxgKyJiczrOB3uM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X6xixqVUrw9RykYe+JcZ3TBptHaf/rU4cc1SeP05/TdNXi5ojGix7N3N8huEaGqSKcYEXs4LaTWmFJlSPwHdIWBK6+zz0HbCYem/ntJSs9AmgPsCzB48PXcT4C00Sq6jlSr8vZ1YlVPGoD3c5qdp32v/Uh9Fdh7CTGvxVJQCNuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ijyOqBXm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TjoE2E1A; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ijyOqBXm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TjoE2E1A"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E7A47A00DE;
	Mon, 21 Jul 2025 16:59:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 21 Jul 2025 16:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753131559; x=1753217959; bh=zd2JxmoM2P
	Z8bYmQKIx2MaPnKEAm9cL+MkeJcIoDonk=; b=ijyOqBXmXFxtho8ARbLOK3Ampq
	drt1ZjMrCf44Ys08bgdgzDbHJnY/zeufciOP6ic4UgNonqzNtt2lC7CcwjnlsZXS
	7J21A8qs/gNDWwgBuZF0mnrHzoksV/zd/FFZNga+RW9XvWb0cSnteUZaJgZrywrm
	hNL5TsvrjcArp5zz0OOkfE9I1A1kP6PehMJPIgh103aYYVp8YTWDVWtszdHPtvi+
	mp/tsskmrll6xkPQLs6H5Y8do0caaaHPy1F7+n3Nmqr/KIKH1ex9u604Hl4UgeKr
	pGohJ4ggvOMguZGwbptdGc8ykf9koKXULCcEw8/7BfPgxicoI4ylLkRmAeoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753131559; x=1753217959; bh=zd2JxmoM2PZ8bYmQKIx2MaPnKEAm9cL+Mke
	JcIoDonk=; b=TjoE2E1AFpJBoHb68hf4SWSlPt4mpAg13q3Og+trcZWF74b1y8+
	GTW78kJJ3M19LI5mO3QbqPA9zE90+CGSrGFRg3j7FXTuueZrXDTs+0ULKJGaU0hh
	PUP7ZTPrq23LcQCOF8468uRgbks9TtmL5dXpX6wlzVDcf3mRsyHGRWrPOAyyHhDr
	0uPnuORgW9L+lRoQ8hFvwcDrGDVZpFPPNnb4N/6FXToa2O/zfhMhJnQgIN6Uj+Pr
	GHANh+EFrHJFPq4jWTvb/qme6QESlgQTnMT72VhCYgWGM2T6TkVfFQMi2NkVhQaY
	Lm5guslqqf4/pMftxfHV+Mk6lumvMoajR9g==
X-ME-Sender: <xms:Jqp-aOGsS83Vr8iW6AtS0J_Z5mUFCHrZA4_j0fOjshBF9fT6Pnt0kw>
    <xme:Jqp-aMOWFGsHLK9k7Ix40NYwEVmdsBRnNbW7mzYoMLzQsohrSe9rQUKD2N4BDznRb
    8K6A7SzVtZRNfza_A>
X-ME-Received: <xmr:Jqp-aH4YiDrV2cr5W3XtIPvf9dvR1XouScjhZ1sUWrjxLNdHBvN6mX9Q9IElszgCLTyHu850oZuqSGgU4WfCkKNuKFZaQ8njqIR8nJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejfedtlecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Jqp-aHjRm4vUKcPGpag1kofMHbt8cVgEoY65o1GDIC4ODTfHodUICg>
    <xmx:Jqp-aEe2y6tyzFc-mV_71UoFc1d2Yn87mbHy4AEucbQUDnoyQ8GiVQ>
    <xmx:Jqp-aHxi-4-25SYtfeRRq22TVS_OfHEg2uzbXg_l2I5_xYs5e7FpHw>
    <xmx:Jqp-aL09oPLcLLNeiKLXzraineRKhS6iFyQrY5OIuOq0MUqSEp85-A>
    <xmx:J6p-aLe_H89OiKoiGnFjWig2l52dz9E1KOGTOP_fsrrH_qYoW8kHJPf6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 16:59:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Jean-Noel Avila <jn.avila@free.fr>,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 4/5] promisor-remote: allow a client to check fields
In-Reply-To: <20250721141056.2283349-5-christian.couder@gmail.com> (Christian
	Couder's message of "Mon, 21 Jul 2025 16:10:22 +0200")
References: <20250625125055.1375596-1-christian.couder@gmail.com>
	<20250721141056.2283349-1-christian.couder@gmail.com>
	<20250721141056.2283349-5-christian.couder@gmail.com>
Date: Mon, 21 Jul 2025 13:59:17 -0700
Message-ID: <xmqqo6tdw996.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> diff --git a/promisor-remote.c b/promisor-remote.c
> index ae2c49a0a0..501cb92391 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -388,6 +388,20 @@ static struct string_list *fields_sent(void)
>  	return &fields_list;
>  }
>  
> +static struct string_list *fields_checked(void)
> +{
> +	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
> +	static int initialized = 0;

No need to explicitly 0 initialize "static int"; let BSS take care
of it.  Perhaps we should add an entry to CodingGuidelines if we do
not have one (#leftoverbits).

> +	if (!initialized) {
> +		fields_list.cmp = strcasecmp;
> +		fields_from_config(&fields_list, "promisor.checkFields");
> +		initialized = 1;
> +	}
> +
> +	return &fields_list;
> +}

OK.

> @@ -533,6 +547,61 @@ enum accept_promisor {
>  	ACCEPT_ALL
>  };
>  
> +static int match_field_against_config(const char *field, const char *value,
> +				      struct promisor_info *config_info)
> +{
> +	if (config_info->filter && !strcasecmp(field, promisor_field_filter))
> +		return !strcmp(config_info->filter, value);
> +	else if (config_info->token && !strcasecmp(field, promisor_field_token))
> +		return !strcmp(config_info->token, value);
> +
> +	return 0;
> +}
> +
> +static int all_fields_match(struct promisor_info *advertised,
> +			    struct string_list *config_info,
> +			    int in_list)
> +{
> +	struct string_list* fields = fields_checked();

Asterisk sticks to a variable, not type.  I.e.

	struct string_list *fields = ...;


> +	struct string_list_item *item_checked;
> +
> +	for_each_string_list_item(item_checked, fields) {
> +		int match = 0;
> +		const char *field = item_checked->string;
> +		const char *value = NULL;
> +		struct string_list_item *item;
> +
> +		if (!strcasecmp(field, promisor_field_filter))
> +			value = advertised->filter;
> +		else if (!strcasecmp(field, promisor_field_token))
> +			value = advertised->token;

Hmph, together with match_field_against_config(), do we really need
to have this case insensitive to begin with?  I would suggest making
it a habit to design the interface minimally, and not making case
insensitive comparison as default counts one of them.  If the
comparison were not case insensitive, we do not even need to have
this loop; rather we can just look up from the list of the fields
for an exact string (i.e. promisor_field_filter).  I do not know
offhand what other code will become easier to read and simpler by
such a change.

Thanks.
