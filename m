Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF58246799
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 05:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758864384; cv=none; b=r3TmveP5Jwo5/AGADj6PM0fSqvvVb9zknX2/GlaBZ/PYWj4pky/COHAgc1pa8opvMrsWeoocJGdUUfs/f4OsItsoOLgV2fZi6qUZgsyexi2fqFol6k/mYS1Q2PhldFwW3Y9qNCVxsCfsJNrzvgiZbX3Yrw8eYyiQZEiFHvOEvDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758864384; c=relaxed/simple;
	bh=U6RrOS1OcQdo9Us6kvUT1zoLW5TGxaoWwD0AdeuGy6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdwK0pocxb0hzB9a7x5JdDaCzmBw7TPgYklILjv3JqCz0DrnOiEPm/rrl9D1RyAzfxjfmxQGcFx8Saj+aLamrxM1Nlojydm5ecqyFu4r+Zi+odg5piQsu3Re1vPH9hFO0ACZ6cjn5QX6m7U/p+3nB57OtY6hUuURVUYMgDM2pZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZguzDmtf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NaEKajsg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZguzDmtf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NaEKajsg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 18BD7EC01E7;
	Fri, 26 Sep 2025 01:26:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 26 Sep 2025 01:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758864381; x=1758950781; bh=UiUCAMZ5hW
	ZCH6vgmIIDJAAvGv3nbUmVb8O8OaICltQ=; b=ZguzDmtfIxBCm3/rfF2D13jf1m
	XP/xp798TPp7gR/7kWJ0zBeBV/STNhqIPf05oEB3PpODlEtKa5Xm6cmt/Zm1zvCA
	zniAYv6qONEATFS7EH/c9C/bmDzwh/mPjcKdjowR2SCU3LHOWjSAqxLyfBhGyhUD
	jJOMBJwlQGS+drFG3NFa87nXrp7sptDwh6ZuB1Otwm4UWjsCL6+y+YXfO6Ytzag/
	ON+9xaF/2IIoC0ktqzB9tIWggAwOb/RyqdPXyzq3IQa1bCWtVEC9yJ8ZoCMVyczF
	jB3jizlVJ+kP6b0ccW4r0ebfZfyeW4utlJiuBdMAQQIOj6bddumHWHjicNQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758864381; x=1758950781; bh=UiUCAMZ5hWZCH6vgmIIDJAAvGv3nbUmVb8O
	8OaICltQ=; b=NaEKajsg7XMOwixtjEJQ0TR6kTx2TjF+f8/tqNr1cZ/i5R0V9fI
	UtbIpSoG+QeBr6KJJ6NgliDLXekEmFOmieF8E9NHwgTu7bHLoXaUhur6xvlqt+X1
	nqFHDCnBFDBMmQbLEM2A4/BuDisVFErJE+CfR50JD14RBj619JhTrwyhBuDcqEPq
	jomdhzrlNQ7udZI8hlHPNratuAJbVszsHQb4tiFFczdkzIwoI9Pg8ZPGqHJsPzMU
	ZdQ62FR1yVhB9zsWbWjek/IayYXiOS3TYO8L9LHJ2DjPHEWVdzbkKw6f+Sd+TFEr
	tFswwwMZVq1UYRb47//zldylO1JDMKiH+Lw==
X-ME-Sender: <xms:_CPWaNsn4p8jnTJSXRXSWPyAxB6avFz7_PBcZBNYiRPn-uj2TpUP0A>
    <xme:_CPWaKL7buLFHysOrLDLsW84OIBY7Ha-j57KnKl1NCH4EZGem3AEBP9bM23G2pBfD
    gZ4PEqzrPB4OBdsonAI7XYdfObTlo-05oUdkmQWtDpnD71BlYjyMw>
X-ME-Received: <xmr:_CPWaKkKcN2-zZaQrtE6W4oursXaOcU9-MZm67XfYiUmTkHJySg8oUA3muWjrxyNfj-vaoQg2Fxdl0-r88lJtKeekYXAFTAskd20aNiDVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejvedugefgffffieegtefhgfeikeevfeefheevvdegieetgeeujeeliefhiedtueenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:_CPWaLLPATg02mru4r4-oet2GMFbf1PzvXj57ZdGMCOIuZNGyALDhQ>
    <xmx:_CPWaP4p7bNds-3XAGVxmg8tRDFwE4e2CYGmYnz5wkgha8ZZvL7XNg>
    <xmx:_CPWaP0zDTlljag1mPq0W3-KaAVNtu4w8TMINmeToKIOT3IESp-iYQ>
    <xmx:_CPWaFfnmIis8khCSRIZg3FteIpIf24ZYAYvQdewsXV3sXvB3C4geA>
    <xmx:_SPWaOJPpiaMEd2m6LhzROQkV6dM1XX7iu0WYbU3gCFOCbs9o5w0VVkJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 01:26:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9bca4b0b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 26 Sep 2025 05:26:18 +0000 (UTC)
Date: Fri, 26 Sep 2025 07:26:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v6 00/15] packfile: carve out a new packfile store
Message-ID: <aNYj9oijx4dhJBOk@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
 <xmqqwm5mh5vw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwm5mh5vw.fsf@gitster.g>

On Thu, Sep 25, 2025 at 09:08:19AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > information about a object database's packfiles is currently distributed
> > across two different structures:
> >
> >   - `struct packed_git` contains the `next` pointer as well as the
> >     `mru_head`, both of which serve to store the list of packfiles.
> >
> >   - `struct object_database` contains several fields that relate to the
> >     packfiles.
> > ...
> > Changes in v6:
> >   - Fix a grammar issue in a commit message.
> >   - Update a comment to reflect that we access `struct packfile_store`
> >     in "midx.c" directly, as well.
> >   - Link to v5: https://lore.kernel.org/r/20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im
> 
> It seems that we are basically done with the topic and strayed into
> nitpicking territory?   Shall we declare victory and mark the topic
> for 'next'?

From my point of view it should be ready to go, yeah. Thanks!

Patrick
