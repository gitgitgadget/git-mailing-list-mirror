Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F08460
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810509; cv=none; b=RJYi2ZPbjLLZYZjCwZWhejL8bPSRT+dmlumXp08psyiYFenrzjtGuecw/MeZXBTBCLQNymJkHiUAY5XXpMcPJix9Kox4MD9d+M7zGOHUXN5h7m+9p+vJHYcdcU1ZqHubIhZfkfsqk7dzVibpVU6Fn3X/Pt5GJvHmA/e8i290yRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810509; c=relaxed/simple;
	bh=PsJsyhxKus4vE9ECfYOQyTPY2QTz8eZIAsnv+21csmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3wLRGSO5MoXfKW0bQdwK88oBIgJ8X1d8ETN6b7EUeJi6lccesLrVdzvlWs5wIGRhQRwhzm+WMqwE6VNxpyMEQmK4YlBYGc0W5fQqxA7w+oFJOMsptyl3XA/7m7Boo0xvhnHA+u6nHuzBMsP/mO28YQ7qgPLGBOarGWkH3xFknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rZ0LQsVk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LczLv7UC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rZ0LQsVk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LczLv7UC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 647EB7A01DA;
	Wed, 11 Feb 2026 06:48:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 11 Feb 2026 06:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770810507;
	 x=1770896907; bh=hZUQ1dJuW9P4q2nFgaQvUlCzfSRHr4BLVqF4ichO1vE=; b=
	rZ0LQsVk5OxOA12GMF0lo9RfkBE3H7lnrLR8KS/76PHwgLK61frJGamEVefgB9MD
	2bVEvY/txKjJNjAGmFweqndo05owGHokZY0jGAT5qNmiPmkEZxO+HbULsy2emf0+
	2T69ks6LuVAvdBli0E1IkwBMLMu3crfPNDcp7Kna/F9V+xTd6KlmfK8nH7Y7Afx3
	JjiTKJiNhVhtL00gR4egacIUS+NE8r1if9n5oj6JS1WCNZuI0OLdlbPeB+Bct9Dc
	75HLfKfXBUjyk4tB8rCYXQ2Q0A3ik1kbFZ0QlwsEIMjL2SNmbcFDUN1NMmOR9ZOA
	sty/RDr4krNiKYy/Hu2zzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770810507; x=
	1770896907; bh=hZUQ1dJuW9P4q2nFgaQvUlCzfSRHr4BLVqF4ichO1vE=; b=L
	czLv7UCZIo5fpK0Mrl/oScNl0tgIEp29KL+hUPPpfF8C/vAPdU0Rdj6bBtCvyi38
	JRqAN4+d1pc1Uv8hiSV0vpWnww0hpoADNVSjFcMeWp3xrDp4heLspd6QqS1k4k9t
	T3t2FQVkcQ94bBxyXGIL+9Hm/5i7vxsYJ3xLCFTOuh1I5u1mUoGeO3HWMBgTzqha
	CG8nPUqY9w9PW/JVLz79/6j4yQltvbDwASxlzgfk1kpyeZOSATHvK+T9qoCeeL81
	Q+dmnisvRhDrVD69yz9ki/ILt04MLDstVijHrFEXpVOGFWSrJtNmDTiEDWHC4ONV
	/yDv/Bd2DvmD0roVKek8A==
X-ME-Sender: <xms:imyMaSJD8m_GC8EHKQdkMUhX3I08CFjsYzgC2qVw7HqmWoQCBataKQ>
    <xme:imyMacYlnbCZvEoc9Zz8p4PBNalrq9E8md8g41QaTJJbFY92INN01o7jwfh7q7q7q
    Szy262IQ2v2SR-kxqgIZ3FjkbP85qU7hBTej-iViqRVWqMOr974>
X-ME-Received: <xmr:imyMaU_VpNRdl2wL_XO_z6y04HLnCD1hb4L5RSCGrouSDCokzAaYy0MOySu0SpKOIsJYRBUYzb8QEjc3_Ym_A_69xyMbnq2f8M7sWdhN4GaO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrh
    hishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopegthhhrihhsthhi
    rghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:imyMadY6V1ecmNciIb8syKyUhXgE1N_xWOtqyWEaFrmkfnoRnKRw_g>
    <xmx:imyMaYMl_aeJKviV1pAnn4N08eU0uDmdE_ZhbQs57y6NXALDZL6DZw>
    <xmx:imyMaZAKjnc86MWhy_qa3SYxfhvfWdTHNND6PGxR_eWCioCq6aXN4A>
    <xmx:imyMafI6kpXYQa06RMpbk7nv0OC4cnFGJYAEdD5LP0I4-zBITSHgAg>
    <xmx:i2yMaZKUQqbXnSi4vyYp0Y6wsf1fPzKnkh3rgaHwZS0hdr_4SIV5rmDc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 06:48:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 088707ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 11:48:23 +0000 (UTC)
Date: Wed, 11 Feb 2026 12:48:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 7/9] list-objects-filter-options: implement auto filter
 resolution
Message-ID: <aYxsgL3uMpNlLe8o@pks.im>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-8-christian.couder@gmail.com>
 <aV4v8HCe6CLqXJ-1@pks.im>
 <CAP8UFD0iBxn6cPFKLAkSW7O3To1ago60MWYwV7YxjxOVxni1Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0iBxn6cPFKLAkSW7O3To1ago60MWYwV7YxjxOVxni1Kw@mail.gmail.com>

On Wed, Feb 04, 2026 at 11:29:43AM +0100, Christian Couder wrote:
> On Wed, Jan 7, 2026 at 11:05 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Dec 23, 2025 at 12:11:11PM +0100, Christian Couder wrote:
> > > In a following commit, we will need to aggregate filters from multiple
> > > accepted promisor remotes into a single filter.
> >
> > Ah, interesting. I was always operating under the assumption that when
> > the server advertises multiple promisors, the client will pick only one
> > of them. And that made me wonder how the client knows which one to pick
> > in the first place.
> >
> > But of course it's possible to just pick _all_ of them by combining the
> > filter.
> 
> Yeah, that's the idea.

One thought I recently had: if one selects multiple promisor remotes,
how does the client know which promisor remote to fetch a certain object
from? We don't always have enough information about a missing object to
be able to tell which of the filters would have excluded it, so it's not
possible to basically "reverse" the filtering and deduce from them which
remote should have them.

Patrick
