Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC5128541A
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218422; cv=none; b=ONYmJnk168RsvZe0va3GTUc5eGKCv602MNAatWb+xRA0gLKAFKNbkXmvm/X40uRmKMqLfW5Rgzxbq7o8srCgE5Qz6pl+M1GEAXQs40gLbzcFKU4OwAwP++HwoH2CWlTQMllaVu5qxKrC5h4AiP9eHb3jad1d1AgX500gaNKuJjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218422; c=relaxed/simple;
	bh=nRjWVC8vjxbklGKexGtWt5PIU5b/9EZrZpMobY5RSvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzH27LxAa8wWRT2Ef1zMc90HqAR3V2keNz8G6Yo1wAvsnY9WVAKB76/LK7fjfH+CLPVR/LDxINr+GzO15mEp++9ZTgFTRQsYKn28mSodaYGfOve6wJdmssBBf7I7HsHOkkDinmixMzrf8tP/49k7V/0whQJ75ayzxClOM23ZpNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M7JyVlJD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=st954OSA; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M7JyVlJD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="st954OSA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 111FC1400049;
	Mon,  8 Dec 2025 13:27:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 08 Dec 2025 13:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765218420; x=1765304820; bh=4iONGXgncE
	2XmnSQLgmQFcIXrClTdKLNlWgOJCnmPpA=; b=M7JyVlJDZJ4DT3sXB2qz+p8JTp
	/LlwaYuMZjA0NUlSEspPSaC81R9AZrcCTswN8KzE9gPkKeV5MlRZgWyUbMQDVT9w
	HRP3jliQ3qccSRJYCCrsZyIJ5WACXlI0bPDgQ+YadnSGWtvj0HYoshGF36JAKlJJ
	MX/HMb5V6u23ocGNKjOUFJzIKGPGFcsfBapqTeu7xNmhh1JhQXZqJKiDZb4kj00r
	a24J0kEeTVp67HsjBNkRsA6/2692isT26tGHO2lxnpM9ihm/lphsx0mzLONhSLd3
	BanZ0DXyyrUW+/mxE2VOOCgkGrJiKzsdaFykybi2cb4x+f7/8kZTveuaqHcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765218420; x=1765304820; bh=4iONGXgncE2XmnSQLgmQFcIXrClTdKLNlWg
	OJCnmPpA=; b=st954OSAppbyujKcvBM5easgPBa6SCl+/7FUWO0icToYuUKAHAt
	Hf/zW/chgVH3RZw+++F2xDV8g52+w/16827f/0DeZP0+luR8KJxiMq74cj1hjtt3
	wl93Bnl/rNA2plSA/nCYr8wHVRe4X/T/7g/SSren/kglt4IzL6SQXvko/0UZOJES
	tBMqk1ogAmjNbPl1WAg28PrniZ5YPN4laEl6mxG9im5793e5yMEG07AfCSkhmsnQ
	rVXlA8VKugFvOOAaa/jsiqaHlqY0++uKws5U4WtTSW83jdOPg2mMjCRsSyy4tcHv
	cK7txbsk4bIehcB/B+PyrYGmw+EcwMos4Fg==
X-ME-Sender: <xms:cxg3aan5riGFpQEepr1UX8-mZxw3YNh_b5HTVxTE1gj5MHBF1B8XAw>
    <xme:cxg3aYsJx1yuCauWOzLaQWgMxzwilCIZdDiCiGaI6ERw2rlj4CEuiGkxTvEoIlRcb
    tOCXGpg9qGx38BQDE55JaZKXMm5ULyKWfvaIKYz8j7fhKbBv9dgqA>
X-ME-Received: <xmr:cxg3aQ-FiExibvnYyZyJ84YVNJyoWx7U_ZPX3ahKcrG8eiOW9nTSmSLfnTg8sX9_OQm49gX4aTTTkck5ZRimYjNmeouPgh5Ssx2vIScX10E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cxg3aaNLIW_2L78BXpf22phUueecvyiBjmtS5Yd7v4hqDVEQ3ochzw>
    <xmx:cxg3aWFje4TovEmu1lQWaNRb43jizuR2lgMgzRsteU_h3hZWoS1uLA>
    <xmx:cxg3aQTQOgONeyVJOdpsFVUSWPB2543C86tM9ZJSmYN44cKBDjqClQ>
    <xmx:cxg3abtx18gXUsfcDInKCFevMjrgzoLgGj9euGUd1LzK8x6jKmEp6g>
    <xmx:dBg3aWtXjIz0f1l9OwejLKlV_Jpd138eEUF175xrFEtpjZBUOfJBW935>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 13:26:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ebafce93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 18:26:58 +0000 (UTC)
Date: Mon, 8 Dec 2025 19:26:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/17] midx: do not require packs to be sorted in
 lexicographic order
Message-ID: <aTcYbRt-aUIcym77@pks.im>
References: <cover.1765053054.git.me@ttaylorr.com>
 <d5389a93b16a4933b0c54f78f2d5ce84b9ecac53.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5389a93b16a4933b0c54f78f2d5ce84b9ecac53.1765053054.git.me@ttaylorr.com>

On Sat, Dec 06, 2025 at 03:31:25PM -0500, Taylor Blau wrote:
> Note that this produces MIDXs which may be incompatible with earlier
> versions of Git that have stricter requirements on the layout of packs
> within a MIDX. This patch does *not* modify the version number of the
> MIDX format, since existing versions of Git already know to gracefully
> ignore a MIDX with packs that appear out-of-order.

Interesting. Did you verify how other implementations of Git behave if
we start to relax this requirement? It seems like a somewhat dangerous
assumption to me that this will just continue to work.

Also, is there a reason why you prefer this over bumping the version
number?

> @@ -656,17 +652,37 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
>  	return strcmp(idx_or_pack_name, idx_name);
>  }
>  
> +
> +static int midx_pack_names_cmp(const void *a, const void *b, void *m_)
> +{
> +	struct multi_pack_index *m = m_;
> +	return strcmp(m->pack_names[*(const size_t *)a],
> +		      m->pack_names[*(const size_t *)b]);
> +}
> +
>  static int midx_contains_pack_1(struct multi_pack_index *m,
>  				const char *idx_or_pack_name)
>  {
>  	uint32_t first = 0, last = m->num_packs;
>  
> +	if (!m->pack_names_sorted) {
> +		uint32_t i;
> +
> +		ALLOC_ARRAY(m->pack_names_sorted, m->num_packs);
> +
> +		for (i = 0; i < m->num_packs; i++)
> +			m->pack_names_sorted[i] = i;
> +
> +		QSORT_S(m->pack_names_sorted, m->num_packs, midx_pack_names_cmp,
> +			m);
> +	}
> +
>  	while (first < last) {
>  		uint32_t mid = first + (last - first) / 2;
>  		const char *current;
>  		int cmp;
>  
> -		current = m->pack_names[mid];
> +		current = m->pack_names[m->pack_names_sorted[mid]];
>  		cmp = cmp_idx_or_pack_name(idx_or_pack_name, current);
>  		if (!cmp)
>  			return 1;

I assume that it cannot happen that we append to the array of MIDX'd
packs after we have sorted. It would mean that the MIDX somehow changed
its representation or was amended to, which isn't possible.

Patrick 
