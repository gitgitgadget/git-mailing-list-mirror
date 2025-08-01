Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4C1B95B
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754038057; cv=none; b=RLDjbVySuB9+smx0OQ/ZiCOnWUSLVIgCJKWwjI0xUETOLsmR7tJRDpBm8+4KgOIlP/ePnFwOEqUKkfZF7wvF3taBR0DR8S1Q9KANvg0w7AGAEfkIgrLvDbP2Pztc4YsQs8DAvcfZWd3mhPmGtJggbl69OD4aKPbfkHERdQDxZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754038057; c=relaxed/simple;
	bh=mTCcXeIM3lqURL74lLxFCPfGN6585nWWil5tBRXkgbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4yo5pY31A/UxqPxtau8hJLacKXBNaI0fQX2X9SUCKgDpyKgu+Bhe1CoywyddAJ/EsYvTMxvOLUCBtBdyRfPeG/N7Q+FVD4ii0nyxqvVJ5+VvLP4na6/QK9TBT5rjJ/lx+wXlkibMaLI9xl+RgYicvOubd8bz2pXiaPTeHLGyYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HHh2jJhy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c3pd6X/n; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HHh2jJhy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c3pd6X/n"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E43CB14001C5;
	Fri,  1 Aug 2025 04:47:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 01 Aug 2025 04:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754038054; x=1754124454; bh=zFEJcjdO4D
	mT5KGJdv6dYGCyw8uLXeaeE75thkrqRlU=; b=HHh2jJhyL3FftdEXOJWMueEs/N
	fcdSPZijqkr0p8lwGKfVSWjsUzZYI8n/umnYmqVd9tDV7vHgiotF++F3L5x1X+kM
	MGz18VF0cL0EhO1dDvxVO1p9rF1brUitRwCtV4Dw6ULV4zwuTYu1U2ZI6g8Q9g05
	VxpEohM4/6jYxBcA4DPPjWRj9M1FqkmZyiEYzJUATSAMX/+oIlVb9ifrFJRoB+W0
	nZeuAk5hp8H32BQ+BROJPU4OQoCiSK1dQtxgR8OIDNhrwt0p/s17EjDgmGSPrpLL
	qybdZuFKvVj95+4Is6ko2oDBCZY5TH/EDl6c2vxFKqRAMnArjI7Es0313QhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754038054; x=1754124454; bh=zFEJcjdO4DmT5KGJdv6dYGCyw8uLXeaeE75
	thkrqRlU=; b=c3pd6X/nubbTwC9zFq732L/FUbYvyGWtX+pP1Km8Lcol6T6v8tE
	BUo7Q1F/DksjyKbipzs8O3Ed8l0Z4Yuc2Jr4k68IuU6XR/mSbjhsuGxySj9q2lQI
	tLdxap7MqeG6BmIz4ItsfkLZzvogZTKg/QOfRnGpQNmWwBi1g6EbtxGaucTIJdhr
	avoIIYp3FHsqzJ0lfI6NI+9w8VZhm0+nQtJFiD+MXET1PXxdjdPczGWxSROyXaof
	dUabDS786BpIeysj3AO6Zhz6a3FN9gLKKSirj9oJQIOomLB6B3PsHVoOAf7Gwc50
	gXY9D0IHF+aA4iNpilUxzZSGf5GrpM3TIsQ==
X-ME-Sender: <xms:Jn-MaPu-Nv-sMrnAB56rrInD5QCqXQXQNQyS-Gbd95pDJo3EIRqHwA>
    <xme:Jn-MaArJkcedlMcm5qdINWg1S3UOpgbrlxauW3KV1js8eaFdxqABZqdziS5IJTD3q
    mlqhvZGXoJLhGEh6g>
X-ME-Received: <xmr:Jn-MaEnewxwalnjJGKe82p6anMnvrdXfLh0vwFHlucRNLKyRMp_skLiD6nxALT15NO8FG_zhwRPYZnoLtYz1rEnayvOUFoxR_vE1rbvRDTSV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Jn-MaMy4LVxObl03WOqglqgYZu-u07xCkxumguSYQkDxAdMZDKkg4g>
    <xmx:Jn-MaEniJjUUZIzIKQfj5PH609yftJ3eysJ6lC9WQIFVs0mDO7pr3A>
    <xmx:Jn-MaNehvFW-UJGsw1E-P3x_-NBi-zx89-RJE9sBBzv41Wv6-qiv6A>
    <xmx:Jn-MaCoKvlCKnRYvG1Hfu86Dwvvfk1BTjyw7TIWlr563fa6ZXvQxWQ>
    <xmx:Jn-MaCTUkcsK4-ClJvsGCyFewYNYw-ECz_4V3wZvYzpLtwOceoscn4tl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 04:47:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c73f9199 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 08:47:33 +0000 (UTC)
Date: Fri, 1 Aug 2025 10:47:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 5/7] diff: simplify parsing of diff.colormovedws
Message-ID: <aIx_InP6HRn7bO6k@pks.im>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
 <20250731224607.3942417-6-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731224607.3942417-6-gitster@pobox.com>

On Thu, Jul 31, 2025 at 03:46:04PM -0700, Junio C Hamano wrote:
> The code to parse this configuration variable, whose value is a
> comma separated known tokens like "ignore-space-change" and

Should this read "comma-separated list of known tokens"?

> "ignore-all-space", uses string_list_split() to split the value into
> pieces, and then places each piece of string in a strbuf to trim,
> before comparing the result with the list of known tokens.
> 
> Thanks to the previous steps, now string_list_split() can trim the
> resulting pieces before it places them in the string list.  Use it
> to simplify the code.

The change itself makes sense.

Patrick
