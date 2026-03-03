Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A5D335543
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545634; cv=none; b=kMLpj+0z+jXgqaDgON0XOc1qqTkPxjBVCbn2Q5cg3UCC99ZmRVuQysH0z+bcdwN1p30jtSSIWveSChH2lJi8XfFDijZPT3+unqV0AxeP6h79jm+u5anZOk8lJOOWm1fLNqyqxXYwJQ8BLzDrr6muO+gazZkNPo41Q9vYQIlQZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545634; c=relaxed/simple;
	bh=w87ZZ6tZxTT+9piBQV6O+XmvxHLQ5YmcFI+qtsN9vuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeisbOLB1zag+8Y5xTKkTRfrRZVi4fYR+/dfBtdR0tC0doF6C/yKClrOI5iqyuyT87yILrOKzZWWkzjdhsyzgPfwJbySBXMLvj9mf2dgrKL+balMJtXrkcCrAuWETRg8nL2Wd92gDevDByUubkC4SvKmcxe2kW9LJ6CBPpv3oGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QepPgql8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FxCMh1Oy; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QepPgql8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FxCMh1Oy"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5840140012C;
	Tue,  3 Mar 2026 08:47:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 03 Mar 2026 08:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772545632; x=1772632032; bh=3h2NsoaEJC
	86NZAbx0pGLm9FLFWeDsXUKoQ0QMx6U+k=; b=QepPgql8dZsXyGCk75KIpS5os+
	JC26LSulm1iKmVJPJMD9ve67xzgUzVGLFp6OQyXbz6uyfmaRCKGNURpTFNUMLDd4
	DzHtwfByAYsDEJlY0NVhEOVJkb622HqH3CO0Cp1jTEsmnmV1v7MCHmjRciYfsPls
	kP5BXpYT/525JyCu1j5eLiU5xx65aGIYJzvp4OTXLvLloGFcdf95JS7WJFdJbiY6
	BLTUuhmRiicBWf7JfJifM1ooHWiRns2zFyWVtmuwiYRaqYXgS9//Sg3ME2wfV4yf
	iFITLS3TqYzKxZcmaqr1yb2lfpuNJ9gyBpoPPK/uJiIz78eY38zhlGdJC51w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772545632; x=1772632032; bh=3h2NsoaEJC86NZAbx0pGLm9FLFWeDsXUKoQ
	0QMx6U+k=; b=FxCMh1OycftP3SuI3iaEHaoQOd5Ci3pSxqLl1OuFxxiPPKPHfiu
	rQd9ErVYnffD+zE/9L8b4J/13yVf04G6irdvGGbM+DXr1ahp1hAWdwtIuBFWuSkP
	GpvPhCQZBKu43NhjGR8F1pweU7EWNWrxGMG+nhxe+jxXF/DQDTnuHvoBEu4foTUx
	OntAvCKSrQyPQPzYG1p+MvZ7eic5WJXsTBNX/8YZwnE7GdXe1WD6DmjiSWlYH0mq
	3QZvDRdkNbfUI4VV3emFnMDOzpxboufjxK0PhYZQYNxSbq5U52WidavdMEb8RRyW
	zDKqR1tWI1JdFiImZOt2fRM7E+rhDU899lQ==
X-ME-Sender: <xms:YOamaSgiF516dDkyWEn1_Prc9lrPJqwDcvAKv_AbF0qNXWQmbBdSUw>
    <xme:YOamaZ5hlvNhChUt7dSrP8cDIhsl78LvD9fHBpCOZWqkPESYB2VR8YhWHIeDkV44C
    RQ-l1wGi1nIUGo2E8AbLTtRhMZHQFDeeu8l3JO3hCAfZ9wnBsq2pg>
X-ME-Received: <xmr:YOamaSYXdndFcTMf3G9mHlu0iJrIVTCrO0f4EN9WSbuSREfZDZeX32gB2p36_I3ColTDpMR4S6Ec5QrcUy9rEd78wL1D2Iq_b9jxP3Cu7vVZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehmshhmihhl
    vgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YOamaW4pvcZQRdqc72JQcLXZ6QnuGtb9Ka9M1OJZXylThWDbAvGmwg>
    <xmx:YOamadA0QVy3btca1_JMTIKSjJexQuywz9ftUN_gJ7RlK16DHnyvFA>
    <xmx:YOamaUe28vCLm6UO8lt2B3_pSIizXopXBv_ClRzN71FEoV2Y0Jx4dQ>
    <xmx:YOamaUKuyJiSsPYUzaxqRIdvAoWwAiyEXRxLpbmzKu2mZML6p75bkw>
    <xmx:YOamaR4ukL2gUfbcoIhjjt6qVGtlWiOs4NpLTsbamUVRDACD14XuXBMI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 08:47:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ae95b094 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 13:47:10 +0000 (UTC)
Date: Tue, 3 Mar 2026 14:47:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] upload-pack: reduce lock contention when writing
 packfile data
Message-ID: <aabmXF5D1rMRZgP3@pks.im>
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
 <20260227-pks-upload-pack-write-contention-v1-2-7166fe255704@pks.im>
 <20260227193758.GA2931515@coredump.intra.peff.net>
 <aaV-l_NyWpkKDDp6@pks.im>
 <20260302182023.GG28275@coredump.intra.peff.net>
 <aaaqgrmOBj-Ly1Vx@pks.im>
 <20260303133540.GA818878@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303133540.GA818878@coredump.intra.peff.net>

On Tue, Mar 03, 2026 at 08:35:40AM -0500, Jeff King wrote:
> On Tue, Mar 03, 2026 at 10:31:46AM +0100, Patrick Steinhardt wrote:
> > We would likely hit this issue if we insist on the buffer being
> > completely filled before sending it out. But that's why I adapted the
> > logic to say that we send out once we've filled it at least 2/3rds of
> > the pktline limit. So in your case above we wouldn't face an issue as
> > we'd already send the first 50kB, as it is smaller than 2/3rds of the
> > maximum length (~42kB).
> > 
> > That being said, you'll still be able to construct cases where we have
> > weird edge cases. For example if you consistently send one byte less
> > than 2/3rds of the capacity.
> 
> Right, my numbers were just meant as examples. Whatever the values, it
> means that whatever is generating the pack data (pack-objects or
> otherwise) really wants to be in sync with how upload-pack is buffering.
> Or vice versa. If we just pass back whole chunks of what we read() in
> upload-pack, then that happens automatically.

Yeah, that's fair. I'll include this part in v2 for now so that we can
discuss once the bigger picture emerges :)

Thanks!

Patrick
