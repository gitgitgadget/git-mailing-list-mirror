Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435422E370F
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576615; cv=none; b=JxwH1UGwTarndjEylHWg/NotURhPaMCQCyDGuMkDfk0JK4vasel7GAm4qNnSmIpGq1n4At9qKSbAJCT/g5I2ac261W/FpzKOLYgJ+0dT4r0116kk/ppSFxVPBvkIgbC0foZUU7SoXa4dHF83c9bR1BPHaYPHlRIt31DHSHoEVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576615; c=relaxed/simple;
	bh=tEJ3EF5eWgwvA8xFgDNt9d0q7zAzyChVuYZoyYOjdkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RisXoxXa8WjkmPPWaG6Xs+mz5OVGFhuF4dHsOKETtxhd/UGrO9Nwd7umwEQoMrCpKWaHc/pDaDDpfOSOalj1MWUVFPZjWa+4WjabrODEpjMsbusgSwAGyvhkTFJeaqwE01OtlyCNCHyqevlU7TO/LufksLZ2UDwKBe1OMF7dVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=klxTEN0t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eI2sVePm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="klxTEN0t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eI2sVePm"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 50E20EC0AFD;
	Tue, 15 Jul 2025 06:50:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Jul 2025 06:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752576612; x=1752663012; bh=OqWd1J7hbk
	7znZs5KTOc2n/aXhRTyPvvnRPWbj4ixkM=; b=klxTEN0tDa9j/RszDknsA+mVW9
	NiLI/dbQk7C9V/Tg2sfdg8r72LJG+rkNm/tE857LyS4Yu7BY9Gk7burU/VtwCKpR
	5Ml/TRAXOTifloDoqNbUKmeTH/M1jwOo3ncFMZCwzc1uvLZwzTs7C3JEXcTFz+QY
	7EovtUYK0NSIDxWCpsaMt+vvAW5lXDCUt6eza2CqRzVZHcs3B1X1v/lb3FtJA3wJ
	TzKXEqPo931Y3AzMlSY0I98dvlEDSr4/0a+9+D6kvq1P5hH6oz9FgjWHQAP8VDvY
	dFjwB5ryD6K214/XwvKeRwx2KFdSvIvUZBUnnZRtX/UY1B1dvkwfpf52djWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752576612; x=1752663012; bh=OqWd1J7hbk7znZs5KTOc2n/aXhRTyPvvnRP
	Wbj4ixkM=; b=eI2sVePmtfs+XhlABi9pe11gmrWbzPDWByPhcsOOWb58sktTWWM
	gctXYLr6Pw/jNBmBhNMBsfzSzEWz01b98ZA4auG4vW4rv5lSds7xSTlAGJrCt5jQ
	FOUmtqORdphdsPxQZpg78XZN4WKNxpArQE8fKEa+J9/uJArz2vx1LLbQBhplzPh3
	z8WTQZoADbz6LaobEzsTMUdjzwFlYcqY3viR+KavlTWG6O4ObOUrbSKP3nvBj5Xc
	M7T4ZujX3gT1s1hqUgI4Bhzl8WKPfBiERIaRtt3HocKXivpaX860IuNwfM0JYWfN
	k+H0KRWkHv26pFmSm5U2dZLRoSRg6YVUxHQ==
X-ME-Sender: <xms:ZDJ2aPrx_QScUGAoC-AHbPlo2dsGArdbk4TFJsdOWrS5_OWOlBPiRA>
    <xme:ZDJ2aJ2ZR1ry2nkUqhr02jw8C_ksdWiAHNGUArBNMD_dLXJFXVZgG6EWppMzYmsqG
    Hoi8jL5GkCEnRsM1w>
X-ME-Received: <xmr:ZDJ2aOC-Fa_78sqrCGOltIt2qOKPqWPIFPJ0Aes16vTMktHM4g1CYSxHBD8FwYs7KduvKxx9E_TeIGP8TQA2myuOWL8B-jiFUTICMWJN99QV7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZDJ2aBcDBjYdAGBE3COTv-J6QlEnkUtFPyVV3ZCMfuH5AFCAVYAbfA>
    <xmx:ZDJ2aDjmIdDmfyoVasuiSlWzIOaijZ2cJ42vsDLkGYDZBsfToFAyaQ>
    <xmx:ZDJ2aJoIerp213xA83I8o8Jj69cPjUgZmdepO4IXgrahkAYm9yJ8KQ>
    <xmx:ZDJ2aDH9eTWfqHMvN5qGiWE11rPKT-I65T67TKEPsBUCrTC_j3HlzQ>
    <xmx:ZDJ2aG6O-3ecukzWgQzknExw6NtBlWyyuHX3SyH4arv4hBxr4annQxAR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 06:50:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96a58dae (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 10:50:09 +0000 (UTC)
Date: Tue, 15 Jul 2025 12:50:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/19] loose: write loose objects map via their source
Message-ID: <aHYyXoRcJGqac9td@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-8-62627b55707f@pks.im>
 <CAOLa=ZQhWh9OKapT2=BB1kJNghYYPF+_133Qs_q8ZkyU1ONzew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQhWh9OKapT2=BB1kJNghYYPF+_133Qs_q8ZkyU1ONzew@mail.gmail.com>

On Fri, Jul 11, 2025 at 05:25:51AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When a repository is configured to have a compatibility hash algorithm
> > we keep track of object ID mappings for loose objects via the loose
> > object map. This map simply maps an object ID of the actual hash to the
> > object ID of the compatibility hash. This loose object map is an
> > inherent property of the loose files backend and thus of one specific
> > object source.
> >
> > Refactor the interfaces to reflect this by requiring a `struct
> > odb_source` as input instead of a repository. This prepares for
> > subsequent commits where we will refactor writing of loose objects to
> > work on a `struct odb_source`, as well.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  loose.c       | 16 +++++++++-------
> >  loose.h       |  4 +++-
> >  object-file.c |  6 +++---
> >  3 files changed, 15 insertions(+), 11 deletions(-)
> >
> > diff --git a/loose.c b/loose.c
> > index 519f5db7935..e8ea6e7e24b 100644
> > --- a/loose.c
> > +++ b/loose.c
> > @@ -166,7 +166,8 @@ int repo_write_loose_object_map(struct repository *repo)
> >  	return -1;
> >  }
> >
> > -static int write_one_object(struct repository *repo, const struct object_id *oid,
> > +static int write_one_object(struct odb_source *source,
> 
> Nit: In one of the earlier commits, we renamed a function working on a
> particular source to have the '_source' suffix. Should we do the same
> here?
> 
> I understand that this is related to a specific source (loose files) and
> probably would move into its own file under the objects namespace. But
> perhaps something to think about.

Yeah, things are still wildly inconsistent right now. This will change
once we can finally carve out the actual object source backends, at
which point we'll have to move around a bunch of functions anyway. So
I'm not yet polishing up every function.

Patrick
