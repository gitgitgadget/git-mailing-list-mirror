Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E523B62D
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130382; cv=none; b=GLq3+zCSPtBajBOkWtS0Nyr5uIQ4iyXf47Xsis69RqKWPE3pNq1N6nVb4Js+NOnobfG37W263igQcfM+4s57qHfdwwTxNWIH+ua5+XCYwqE/diH/sIxlajmzcUfWGumyzvbWPPDB59IhCymFvAJkXCkMtfjNIoQhm7vsCTY3xtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130382; c=relaxed/simple;
	bh=sLGCBd+s9tlldpU0/22fBa/L15PX3VPYEU6RNKJoUcM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tgVO+vCxiyPdP56WQfVnLHhI9WtHYdGdFHmliLP9CZllOYgVVuSzDH9GK8Mlqh0HQ47V4QP+XSK9Xi8SEUY5cWedRHZo1tY0bfpABH+rmUEYEvxCuIJRoLEPWaxTE0Yq0gHNnwqDf6xxfcG2cA2O5irTQkOaOdEDQYTEQBDnxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CZPQDb2T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U0M/SSQG; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CZPQDb2T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U0M/SSQG"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 93CB67A00A1;
	Mon, 21 Jul 2025 16:39:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 21 Jul 2025 16:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753130379; x=1753216779; bh=/7YWrA45v4
	9mumMfv8l+VW0vOpzvy7XmKlU6beY0BR0=; b=CZPQDb2Tb433ly7JE+4eGyYPg2
	sJCQ+A4NV9yaDZ8R/fPZV3t0uJEd9RrtbM2shulyq8OrIvLJyM7Nq6UbHEDYkmzf
	cdhpc81SbyvkCCovhW7uP4Zg/JLTKyZS1jJPpoSMRS0wrxMXuvEcyR7lZ3qkM8z/
	GK9CoIDWgGI9x+Y+CST3GRf6n3OIOOJX5mHrEqeEPQDZmq7r5gSprSxRHC9q23Z8
	XTgg1dew1WRGB/u/9xpVoHs34fBG74T1uQOKcLwZ03HDV8TvcSQ0Yd3B62xYTzu1
	QDkf1C+kjP7Lnf+5R/cMbDc10DosAF3tMoS3lp6lTu8eoG2e0QEsU0hzU3oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753130379; x=1753216779; bh=/7YWrA45v49mumMfv8l+VW0vOpzvy7XmKlU
	6beY0BR0=; b=U0M/SSQGFMVZSogBpDQRUtIePsTXmFRGCyyhBZUkAFONT1in9DG
	EFglJajN3Lw3DhblaehFk2dlNoDzGnvLuUA0sNxLi5XqFe6vnq0ghUoljyp8dc7n
	s3r0ozvn1EuY8/JOLXL+pNQAIZ8juv1siYY8FSfDyAKTx+UysppbdjzXjfuPrKK3
	YcN1ToM6zLfj537jkHn4WBb+fxGfkuozbpU6jKPKGORXEwqGt7MmMwJnY/VrH4Lc
	ulqF0vxlrAqRwSWq5GUZH4ayXRSrITMpgZfXExJ/olIxgRR7KZCMvc3KuGOXho+N
	fXrKv+3Q3Po3gOiGIZvQvTcLVck6ZTc/0AQ==
X-ME-Sender: <xms:i6V-aJPpW75rxI0yfF-oYbCknbIsimirS7q0slcYDkRnAaxIVGY4oA>
    <xme:i6V-aI1anvUL-WQFqxFkCU3F2hAP_GPGCXkMjV8kl2_HBLFiUFi8nrUeNOH1fA7XU
    3a_cukZ_ygclsC13A>
X-ME-Received: <xmr:i6V-aIDxT6dVVtrnzTsRWbfi2RsHN_IPwPBYmh3-QhNlcePKoN2HpDSl05v0ZtJqLFkhb-tyrpZSS8OfC8aodsTaLREVrqW8m7jCLGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejfedtiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:i6V-aFIDgzNaEmXMlC-A87ZkZiyHfT_NRJTfhp0w-Ne8yJheTAlbUg>
    <xmx:i6V-aBnM_eC23UH0ht9SKlKiS0NCkVJ8wecTslRTNPV0Sv_oRpMS4Q>
    <xmx:i6V-aOZYgW-H1KXcxcLFkjM1BAeqFjlCIpdvXlWn0wLj_fnRhtlA8w>
    <xmx:i6V-aN9kxY9yFFfe--l4W0Fi1ybB4ZhViR1R-mQ5EYzFIcAp0I56_A>
    <xmx:i6V-aF3ARtKw1vMzMETh8Gq19mrOAQi7xEJAAopWkpBnz1QBZzCRmE4u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 16:39:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Jean-Noel Avila <jn.avila@free.fr>,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 3/5] promisor-remote: refactor how we parse
 advertised fields
In-Reply-To: <20250721141056.2283349-4-christian.couder@gmail.com> (Christian
	Couder's message of "Mon, 21 Jul 2025 16:10:21 +0200")
References: <20250625125055.1375596-1-christian.couder@gmail.com>
	<20250721141056.2283349-1-christian.couder@gmail.com>
	<20250721141056.2283349-4-christian.couder@gmail.com>
Date: Mon, 21 Jul 2025 13:39:37 -0700
Message-ID: <xmqq1pq9xoqe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> +static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_info)
> +{
> +	struct promisor_info *info = xcalloc(1, sizeof(*info));
> +	struct strbuf **elems = strbuf_split(remote_info, ',');

Unless the primary use of an array is about passing it around as a
whole "set", name such a variable singular, so that element[4] can
be naturally read as "fourth element"---"fourth elements" is not as
natural.

Also, can't we do this without strbuf_split(), which is a wrong API
to use in general [*]?  strbuf is a very good data structure to work
with when editing string data, but an array of strbuf is not---you
would not be editing many pieces of string data in parallel.

    [*] often string_list_split_in_place() is a better alternative,
    especially when you do not have to heavily edit the substrings.

> +	for (size_t i = 0; elems[i]; i++) {
> +		char *elem = elems[i]->buf;
> +		char *value;
> +		char *p = strchr(elem, '=');

	The pointer elem points at the name, and the pointer p
	points at the beginning of value, which could contain '='.

> +		strbuf_strip_suffix(elems[i], ",");

This does not even count as "editing"; split_in_place() would have
removed the trailing comma (and replaced it with NUL to terminate
the string).

> +		if (!p) {
> +			warning(_("invalid element '%s' from remote info"), elem);
> +			continue;
> +		}

	elem pointed at "foo" or "foo,"; we may have stripped the
	trailing comma, but we didn't see the equal sign to start
	the value at all.  Bad input.

> +		*p = '\0';

	Terminate the name by replacing '=' with NUL.

> +		value = url_percent_decode(p + 1);

	Can this helper function fail and signal that it saw a
	malformed data?  If not already, shouldn't it be taught to
	do so?

We are inventing the syntax for this data in this series, so if this
helper takes garbage data silently, and if we are not willing to fix
it, then we can even consider changing the syntax to something with
a helper we can use that already has a good error checking.

> +		if (!strcmp(elem, "name"))
> +			info->name = value;
> +		else if (!strcmp(elem, "url"))
> +			info->url = value;
> +		else
> +			free(value);

As url_percent_decode() always allocate a new copy of string even
when there is nothing to decode, value will always be an allocated
string, and if we are not storing it away, it will leak.  The copies
we kept in info->{name,url} are ours to own.  Makes sense.

> +	strbuf_list_free(elems);

And because [elem..p] (name) we only peeked, we can safely release
the whole thing.  If you used string_list_split_in_place(), you
would only free the string_list shell without having to free the
underlying string.

> +	if (!info->name || !info->url) {
> +		warning(_("server advertised a promisor remote without a name or URL: %s"),
> +			remote_info->buf);
> +		promisor_info_free(info);
> +		return NULL;

Nicely done.

> +	}
> +
> +	return info;
> +}
