Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F6B321F20
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416170; cv=none; b=qZPESyMUq+FjLvOt+HLssVREPE0xPePWUXblmjaI3FSCFsRpj60Jq/Ihp4xU8O0yI7Pb9cXGLYMyRl7GJH9c+DPEn4inpB6ujOgptLK0E8+D2/u731J5sGoSYlW/wG9SYyVhCXGNeBksMpFZM2P0ClvbMZ3PsJoA2EfjRXl9kk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416170; c=relaxed/simple;
	bh=BqYYcaU8loJ38v6spZ0SqzbzjxAKkb91wnnJN0dGRL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3rh8/fDWy2j8G+YSro/Een0pKWuG0uNqYUzw/3a9AhtEeSvgxqt+2zqMKHY1kGwND+8LldaHOypMxV675CiyYdblnnBBkX99nN9brspcrbe9IrZaAuQ2lbC3sPIu23ejPBx/UPGo0kAGNkLModMwtm5SDo0bO1BbZ8OmCgfBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EDzqNp31; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SXPsx1WG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EDzqNp31";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXPsx1WG"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6221A140014E;
	Tue,  9 Sep 2025 07:09:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 09 Sep 2025 07:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757416168; x=1757502568; bh=SMOVHvUEEO
	W1i5v4NgR8dGjkdsnXbKcEO7eF40my0sg=; b=EDzqNp31DIKsqdAia98/ahW0kx
	DMv0ODKLtAwVc7xXoaCkbH7eMnlXdcnPnaC0h9ZbfSFx0K4ivq4yXfUWozMTurVs
	61K41e6ua55PQenP3l3W5WEIg0LcC8M7sshIzUaeJS8o07MAeFf4jNXyLAqHsgkP
	ALBbTxmckD4K0suAcrB/LNGUVJthbyyLW1vMlV5r5reFu5TxWovFph38THqu03j4
	g81F6cPKr4N0Tpp1KK6p7u7KK2Cy1aDK2QRsodMugfl9Gor39rhiN05nUkFt+s5D
	M2tnNNgWmpGM90+qesUcrZ8jRM3o4KzL16CL8OZNTTwW/yP9RInMcJtFH7eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757416168; x=1757502568; bh=SMOVHvUEEOW1i5v4NgR8dGjkdsnXbKcEO7e
	F40my0sg=; b=SXPsx1WGsxwb5otxI5Ti5U6AvhLapk+iX+Kv8eok53MI/6qNsRN
	5D4n340oKQrtOZPt6a7lMBVYzqV3+jXXE0Z/FkYPDnrKY8tBwtxjqTK2JpouopoW
	BfxvuMvegKC5nwDXwg4ODRlJfQ3CuIcvrknMfZ7JbWPTA1Sk4BPnbPaquJdxsI8E
	8A385arRZGbWb8L7S5BZs0NqyBNQMmsyMQkulHmKXIghPi2HnEcnf2BAkVsiz6lq
	9SoOwhAhIQe7IqodDOi5ttGU+Beobf6WFlpAxxOuHbdmbfUOGoBGyY0TTaWkYRUU
	IMklGlQmZNyzz6oGib+XVLCg9Jq60ROwhoA==
X-ME-Sender: <xms:6ArAaLXQTVc84tQmLAVWZOKp4__rhLQH59sWvuRJ2dSbeEoKbq0xng>
    <xme:6ArAaPENkxUloQDS3eaeqAyoZl3I6hgsYxd8lZCWO8lHeaB7wC-25sm0ML12wCwCR
    HzCovlfvpqwbVxrwQ>
X-ME-Received: <xmr:6ArAaN2f8KsqVRlomZ_bD8kUcUDUTQWNsaNwxvCtEHaKleBMF9EGoAf9szawv-ylAiGcCSV40us0EBdYkakHCCe9GufEVAGcc-H8zQzO0ns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6ArAaBNc5p-eJmEqEVihe_jsB-gDEDslgBLdV0uCOf1QRMfb0qoijg>
    <xmx:6ArAaM6fTmtqc-pREp7eCRZBLpEVQ_FuLDoN9DhmAqRtjPqnSSiONw>
    <xmx:6ArAaL1mLqCbUYPubED1IRGQKZXJUPOaJpltqqO39Fn0pCoq5VNrTw>
    <xmx:6ArAaNzNvHdjbtKF1Q32V-e_A3nRSGcwBqrdhv5VuarJ0oqFEqlwgQ>
    <xmx:6ArAaPQkGBDJl3RCnNAQoOlbNIZcaldv7l1GW3gevLYJq-Y8P2gcx-4w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:09:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id de13f16e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:09:25 +0000 (UTC)
Date: Tue, 9 Sep 2025 13:09:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/15] odb: move list of packfiles into `struct
 packfile_store`
Message-ID: <aMAK4tKcoCaL2YYh@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
 <20250902-b4-pks-packfiles-store-v3-2-6925278efeda@pks.im>
 <CAOLa=ZRrBVoGKo+VD25LDBUV2QF1jow62w5Ab3cVmu8S7W+-kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRrBVoGKo+VD25LDBUV2QF1jow62w5Ab3cVmu8S7W+-kw@mail.gmail.com>

On Tue, Sep 09, 2025 at 01:00:53AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > @@ -789,8 +784,8 @@ void install_packed_git(struct repository *r, struct packed_git *pack)
> >  	if (pack->pack_fd != -1)
> >  		pack_open_fds++;
> >
> > -	pack->next = r->objects->packed_git;
> > -	r->objects->packed_git = pack;
> > +	pack->next = r->objects->packfiles->packs;
> > +	r->objects->packfiles->packs = pack;
> >
> 
> So this is where we insert the packfile into the packfile_store. Okay
> makes sense.
> 
> > +/*
> > + * Close all packfiles associated with this store. The packfiles won't be
> > + * free'd, so they can be re-opened at a later point in time.
> > + */
> > +void packfile_store_close(struct packfile_store *store);
> > +
> >
> 
> One immediate question is, how can someone reopen the closed packfiles.
> Is that something that the packfile store should offer?

There is no specific use case for this right now. Packfiles get reopened
automatically as needed when looking up objects.

Patrick
