Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D373203B2
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620107; cv=none; b=NquHFU4OaFxaDAoQikgRDIdytqrl/dDEz2xSViEwWeRetbCKEsq7QA43D517IQHNoCRvsGw4VzPM6iCYJ/X7KlTqsDTfl87frh5M8Aa6wbHMTS6Iqt3xVbBuG3n18aGzXlmuiKihErw3y6XynSB0noeGzhRAE8DPmTchc0CDpsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620107; c=relaxed/simple;
	bh=w+BtMOWDhADKdq9n4eW0LBbc+JDt3pI7rO3k6HYYfss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJJEysd4bHAAF5tzin9yyreIkAMekgN5ko2I1Mk2qurvgQr0vgxpEb6EPkdY8eswSLhkyMTegj9bTY7qsO+wUUHz5gxM1ZuHQN53q84TPC/Qk6m6Ledmo35UBaXVqJRUXPqsPHe/uGYverkpgZuq2FvygdR8PJVjTtqppR/UJ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dfFgermw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jvsUt/dZ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dfFgermw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jvsUt/dZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E67F7A0267;
	Tue, 23 Sep 2025 05:35:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 05:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758620104; x=1758706504; bh=/2YLzRLOdm
	0TbB8FCxUiPmZcaiv6fz6Wr79AcL8XzfE=; b=dfFgermwAT2uV85lZhvxZDjth5
	iyVeLEcDATBnsJVuhhjZ0O6npADd8YQFFPkgecf0Lx84GdmoYU2kF1dgIiGpLIXb
	tko9WC6LUrolO00Hf62z9f6TZqI4xmzt5BynKJC7FsmZVPpLejmiFRhnyZULBTO7
	kNgrOTbwrJYDcndJWeITxwaLjS5T5/CyS/Zk8uHBn3y4lG6nCVn8tckiJM2pQusc
	8AHmkZbB1TeTJ0IwTBgL891PgnDHaurQMlcfrpMj5oClwTH2PLbQ2JCj85LZEcGw
	lFWG0EkeWrbg+3a4asrrLTHXrVbRY1R8C4WJbFmvNNAgJ64D8pe0UrhAJfxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758620104; x=1758706504; bh=/2YLzRLOdm0TbB8FCxUiPmZcaiv6fz6Wr79
	AcL8XzfE=; b=jvsUt/dZKGH8tKazHDsnDH77s68zkMXMYnEifaSH6CY6VktC96Z
	Eu+h2b0tnp5bKs8ICIb08BOKkQE56spQ77iemTLSUkv7L000SJC+Gjuupfg+wz9f
	9kjb1MFzngt2AfETj4ZX/j0hmnH7TaMuFqrtVBI02pp9/5M3x3tnmYPrGqmODl/I
	oasVieVJkvEDQc+UWlEqLaWKxLX+Nfsp9G/bmgFue3eVqRi5ffRIGOZdMfdKX8Yc
	5EwPkx2fo2yxtN2fqY0GbZPPMcnEsbavFr2s9jrASNk7QGvp8oykJM9TqD5m85XW
	fck9AMaoZfqVa0iyQDSLuuAUP4Tl+gCjpbQ==
X-ME-Sender: <xms:yGnSaDicqOKQaOG-GuhRQ1DAyy0k_kvOExlYUeK2eIo2pUnfDtejfQ>
    <xme:yGnSaDsVNollUEjyAD_apJCU7qKBJFK8e_aFAOrHcEaZrEwyvFBZtIGbiFmCpArob
    DapfKaimimGnnM6ynCfF4eYPDoNkHWJtNPR106Nt8653IKOKkAE>
X-ME-Received: <xmr:yGnSaM5mQQj0pC4KMlyGP9p7sZmOSvmbrEPZUvJifsQbhgw-gfcBEpiNS2BQpfVp_f7ncaGdDkvk-kqLF7Yycp-rKRdBKPtJo0OB3OT9xXKa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:yGnSaHNJC5Qbn0IT60CUqk7E6gvErsggSgp8IGSc773gWzFIo1bb_w>
    <xmx:yGnSaCtnRQNJc9cccZdUVtwgxHEnF4cnyu_6B7ggB0mLf87QyVgxDg>
    <xmx:yGnSaCauEbQaAxwCzLCEhqR5jGYQrLek7ydIhzyR1mm_0gH-il7YIA>
    <xmx:yGnSaMzADRsHlLTFId9DULH4VRPXYAdH9K6qg-cHh53y88u8gQYHbw>
    <xmx:yGnSaA93dhPyKjlRfEjxuJg6JMr3XkPn63fbQeXfTXB5lRpPJ3YVcopD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 05:35:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec556097 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 09:35:02 +0000 (UTC)
Date: Tue, 23 Sep 2025 11:34:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 01/15] packfile: introduce a new `struct
 packfile_store`
Message-ID: <aNJpw1uJuhmpsCQ9@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
 <20250915-b4-pks-packfiles-store-v5-1-d6340350934f@pks.im>
 <hez25mocjub4zswsptv4j5etgygavllfai6zb6h2tdln2xhmo6@kjvvzrbjmilc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hez25mocjub4zswsptv4j5etgygavllfai6zb6h2tdln2xhmo6@kjvvzrbjmilc>

On Wed, Sep 17, 2025 at 04:26:52PM -0500, Justin Tobler wrote:
> On 25/09/15 10:54AM, Patrick Steinhardt wrote:
> > @@ -91,6 +91,7 @@ struct odb_source {
> >  };
> >  
> >  struct packed_git;
> > +struct packfile_store;
> 
> I find it a bit suprising that we already add a `struct packfile_store`
> to `struct odb_source` since it doesn't get wired up yet. I suppose it's
> just acting as a placeholder for what's to come though.

You're probably misreading this: we don't add it to `struct odb_source`.
This is only a forward declaration so that we can include the struct in
`struct object_database`, which happens in this same commit.

Patrick
