Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB425A2DE
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765776803; cv=none; b=L+Mff0K11De6qIy/FOsHEOsxrX8MUC0Nn4+idiHgfU9gor9wJD3HeICpmTA3GoUwGQ9Tu2s+1fyYZfubLVp+m6JABpXI1uKwTWfkECkdBQ0zGTWgO3/gUWWxKWyTHXP//c2F5r5aZDjJYmlb/vgvltZbkBTkVrnk+K2UN2/mIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765776803; c=relaxed/simple;
	bh=/DEBD2QCERqtXoEhoClQZJ1SEfqrfleh4XFxWVVs5q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/9jR0XaiJBzJCRdc/5PNDPsywLhe58+SBpVBIfzSNsQ97XBDg3ueQ8o2IuRbimwvTaL2Wl1ElW7aiGcNCr/t0E/uJ021wqEGF6BXb+BIwAtCcGpg5XaKt3+l8l2Z9zTwgUN2XPzCFRZpjSG55DgicFHgG0n4ENY3qzLzUSNLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YeMqqu6i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yf4YTmAr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YeMqqu6i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yf4YTmAr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C600F1400142;
	Mon, 15 Dec 2025 00:33:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Dec 2025 00:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765776799; x=1765863199; bh=Gnr7htE/cP
	TQ/OsckwRfSr3YyjHLpdjq2SYIsSD7hU4=; b=YeMqqu6iCYe+tfAGUUoDJXPEnA
	Flk19o33sZPNbfsqD34Voo/4/Fbm0rrA3G64hbxi/e5iWYPPVyHAgt2VnFLJVAMT
	wDLaY7bFsHmxVsoHqUsHTrjQzFNm/RitGGq5P5vQXqy5z4P0KQcGJy7ieeiObxoy
	UVB4499LiOCHpqiJHdSkE7yMBCJVyMoPILMlxVRDESh4rue3wUZpzeZsU7LWPu6Z
	RufNhpqfaQ9HDRZ1PCoB0hXUGWru8UTDNJ1sjl+SV8vmdw/g9WUzZUAfqXABY4Qy
	c2MSKtaYaOXzGaC6BIG06jTLHzMF9MpSoJ/579SuW02EhhY4NwxTSsSIRcwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765776799; x=1765863199; bh=Gnr7htE/cPTQ/OsckwRfSr3YyjHLpdjq2SY
	IsSD7hU4=; b=Yf4YTmAr62SdnruT99Opqe0rw8TC2rTlyHxkxjl5qo2qFDKevU4
	5rv3UevQnvgeYmPQ4uL2ME8gG9OxDCARHuHdhcjFVC6UB5rIsB6G7ioUbttUL31O
	6nVd8n0qhbkFhPyZAv2CcXrJL4e54sIJbfmfLdNMVgZp+yjt1/ffHmNF35kv82+n
	kwbihiaOUstARulbbBU5lg9Kw8fk7sHgvdJM8HC/BHYKO5B6Dd1XPjt6dLdHX9bL
	J9n0qPQtnqIfwYb0YQsK6Q9rUX5hSEB3oCMVL6nD3g8A1goAaBsRzOxA5kM0nbVC
	yrjI2muccG43bNaFChQ01rA21XaPpqJT1pw==
X-ME-Sender: <xms:n50_aRGPd_a3Wrwx7_tCgfBy2xKtlxnvV04fqAeI_x8O69tRA7sybw>
    <xme:n50_adwn764nWTcmYJps2OthJSBBp8VN8JB_wSTaNL1kEY56hXlwjA-FLse-Ukema
    3zzrf9PVbq-UaCVv1wm17YZT8H78nIMyfbREspBOJeKXlUNpNLt6w>
X-ME-Received: <xmr:n50_aQip8RSPJ6HMwdhhZbxFqIoGJHkRR2kOF2m_Ebogns8sTuX4eyhorDyBh5aSnRxP-KLdu-hx2R8uYViPqpGSjdOuCrLMW6mQupiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefheelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:n50_aQys7LTuLVURaVqHwC8vNw_B8XRWWxPSXbB-Fj2Q8TvD5rotWA>
    <xmx:n50_abKEyRgY587mKLi4gPwNfc-qRwHdGLxf34CkmMTi14WhDIEaGg>
    <xmx:n50_afTsrlVfbZoiQxj7yd-n_QfOb_jq9F_d3HSFVDHhVDib8wvMIg>
    <xmx:n50_abolIRtm0cbbLUFIt1oE9bJ8OCefLKqAieiy4wykMek0dUgApQ>
    <xmx:n50_aRy9Tovf2jhphm8XypWQ3OA2QkuGyx7g1O_Fyp8YgncblUve2LdD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 00:33:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74455634 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Dec 2025 05:33:17 +0000 (UTC)
Date: Mon, 15 Dec 2025 06:33:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 3/7] builtin/repo: humanise count values in structure
 output
Message-ID: <aT-dmuOZyMhV0fX6@pks.im>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
 <20251212223644.3090879-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212223644.3090879-4-jltobler@gmail.com>

On Fri, Dec 12, 2025 at 04:36:40PM -0600, Justin Tobler wrote:
> diff --git a/strbuf.c b/strbuf.c
> index 1fb47bf21b..cebb1593ab 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -836,6 +836,29 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
>  	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
>  }
>  
> +char *strbuf_humanise_count_value(struct strbuf *buf, size_t value)
> +{
> +	if (value >= 1000000000) {
> +		uintmax_t x = (uintmax_t)value + 5000000; /* for rounding */
> +		strbuf_addf(buf, "%" PRIuMAX ".%02" PRIuMAX,
> +			    x / 1000000000, x % 1000000000 / 10000000);
> +		return xstrfmt(_("G"));
> +	} else if (value >= 1000000) {
> +		uintmax_t x = (uintmax_t)value + 5000; /* for rounding */
> +		strbuf_addf(buf, "%" PRIuMAX ".%02" PRIuMAX,
> +			    x / 1000000, x % 1000000 / 10000);
> +		return xstrfmt(_("M"));
> +	} else if (value >= 1000) {
> +		uintmax_t x = (uintmax_t)value + 5; /* for rounding */
> +		strbuf_addf(buf, "%" PRIuMAX ".%02" PRIuMAX,
> +			    x / 1000, x % 1000 / 10);
> +		return xstrfmt(_("k"));
> +	} else {
> +		strbuf_addf(buf, "%" PRIuMAX, (uintmax_t)value);
> +		return NULL;
> +	}
> +}

Same comment here as in the previous patch, can't we return `const char *`
here in case we drop all allocations?

Patrick
