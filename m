Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CE91FE451
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759181955; cv=none; b=ee/qVY61MuVOTllq01h7ijxg8/wG0twrgpiz1kqUo7khJUFLN/R5srROC384PewvvYh8YxstrA8GHtrYi4ThBV5QvmN8jpwsfG8J6Hhp5qYl3wQKZMLk17Np8j5UDz1UEEL4hgWf1ym3cVNEQbKyScaADB0PqNCMUlLB5bzx2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759181955; c=relaxed/simple;
	bh=cS4Jyl3pdbddr7ocYLaclyx9EtnhhKLGwT7JZFxMFdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HH/NqnO9DAM88eiYpo532CxK8F1z9tVv8y/Y0ph6lZE32wAvY1HvDg4k/Dtp35izFrekvMGWZav2q/5kV+o1D7DX4vVbn3AP0M00Kg8ENuCVWfTFlEPH7ZqGGwbv7I/Rq9E2JhqqV3AB6EDoIsQK62uxSe4sqv1zjPZg3fgjfSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TyF66t5H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UHUsbe0+; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TyF66t5H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UHUsbe0+"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id BAED8EC0229;
	Mon, 29 Sep 2025 17:39:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 29 Sep 2025 17:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759181951; x=1759268351; bh=apmzeeohsV
	d/pOOIEn4KAWLyBqLFca/mX0DLxN7CBZM=; b=TyF66t5H4/OpEFa+KmiaV2yb/Q
	nJaENMGPHtYRKd2mVzuyoT0PKFQqLWnqgUaEG6FQ42o4xTm/FiMRas0lkevTnUAc
	huvvkhdm7uPzhTZPX41qjfosOyj1cYdI4gVnBme4HJz5o3BPE2jtH+9LcO8xoz5T
	WwlR4/7ox9Hv6pvJmBtia1RzcP76Bpv8d94R21Z9OHXI4qTdcQONJ0qSUs/wqc93
	kOP7aFRWrCIHf2VCDKcUY6mhaRdyBan0vByGXeqIEARK0rRNnvkwc+N45dLnz6ge
	+nk3G1nwGzXslP+ILOEIlTXkScgYLnA+V+6jD7niA8vulG2UhfQKlID+gzJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759181951; x=1759268351; bh=apmzeeohsVd/pOOIEn4KAWLyBqLFca/mX0D
	LxN7CBZM=; b=UHUsbe0+y/mRL6PYV7/LJpv1tkJSMe59Nk4e9UowWgGciqwEalc
	wIYeIWex8n4deV5pzqK/5EpbjAaN8F/kJ3oOryx4rd4IxkO3oDIS+w9nC40eRdF+
	EqKf+NUNjftBuH1v5zZnvyzU8ftob+ltdlt7VQ9oq0xlwhzFt2U6Amje0nnCzRNe
	xm7jXY4Gafbu0h6FK98S+d4k2w/qNnA5bQXjlPCalW28J/b9PzstdWoP3ehY0oVz
	G/AiaSW1Xhs4HlpEmCcelVZ9G9UFpLuiZsM00NAXBffQOpfPgCrQJTc+VMcaAHYm
	v3Ac7SvzRGtdsUXPDlgLs48hdb77/kbiykQ==
X-ME-Sender: <xms:f_zaaLO_O0E1uWoZJ9NfHbyQ6kaYjHpcCH6r8N0Pun1v4DBVXYL40g>
    <xme:f_zaaJqyIF-AwltcY6E2hwSeIH99dGYdhwySUXzRBSKHuEsfahaYPFlJE5zZo3f22
    MS3MO670HIHr9-OxnoZ3bqecBQQkWLyQihF_b2ZgkktScIKHlZ5iQ>
X-ME-Received: <xmr:f_zaaEHCHVxVcWI0OKl_IikDCl289pf0CBBYehzH03OXHtFwYULcq0QIlPXqkE95rwRBK7m5J2HbBbWGc4ULQHBBN-U0xZkq4udnWIEZw3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejvedugefgffffieegtefhgfeikeevfeefheevvdegieetgeeujeeliefhiedtueenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:f_zaaGqLC0sfi2EZF0d_-9pyFqjGqhIMn7ViI7UgK_NT3G8esY_qrg>
    <xmx:f_zaaFZnWSv1VXrUTBge-Rje6-7IBHVANbuWPaIjmE8ID9a02ERgwA>
    <xmx:f_zaaHViYC7RYnkzdjTFb7JP190SMe2HjGIBqStTpK5fpHgggL0M1A>
    <xmx:f_zaaG-AY59vUqE26tt-rsRYBU2UGJntSpAaJVe0gE8vTHFQuZnclA>
    <xmx:f_zaaDq93IXflQq5-R0gH0L_i9iH6dZVqGt_j91W6bs24i6IOUX9J36I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 17:39:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 744b2826 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 21:39:08 +0000 (UTC)
Date: Mon, 29 Sep 2025 23:39:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v6 00/15] packfile: carve out a new packfile store
Message-ID: <aNr8eSabW3rw0Ze8@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
 <xmqqwm5mh5vw.fsf@gitster.g>
 <aNYj9oijx4dhJBOk@pks.im>
 <aNmxQqV3+1Ad12qC@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNmxQqV3+1Ad12qC@nand.local>

On Sun, Sep 28, 2025 at 06:05:54PM -0400, Taylor Blau wrote:
> On Fri, Sep 26, 2025 at 07:26:14AM +0200, Patrick Steinhardt wrote:
> > On Thu, Sep 25, 2025 at 09:08:19AM -0700, Junio C Hamano wrote:
> > > Patrick Steinhardt <ps@pks.im> writes:
> > >
> > > > information about a object database's packfiles is currently distributed
> > > > across two different structures:
> > > >
> > > >   - `struct packed_git` contains the `next` pointer as well as the
> > > >     `mru_head`, both of which serve to store the list of packfiles.
> > > >
> > > >   - `struct object_database` contains several fields that relate to the
> > > >     packfiles.
> > > > ...
> > > > Changes in v6:
> > > >   - Fix a grammar issue in a commit message.
> > > >   - Update a comment to reflect that we access `struct packfile_store`
> > > >     in "midx.c" directly, as well.
> > > >   - Link to v5: https://lore.kernel.org/r/20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im
> > >
> > > It seems that we are basically done with the topic and strayed into
> > > nitpicking territory?   Shall we declare victory and mark the topic
> > > for 'next'?
> >
> > >From my point of view it should be ready to go, yeah. Thanks!
> 
> Yeah, this version looks good to me. I apologize for the delay in
> reading v5, but looking at the range-diffs between v4 and v6, the result
> looks good to me.
> 
>   Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks!

Patrick
