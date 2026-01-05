Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1CE3358A8
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615808; cv=none; b=nCuE1hQszm1gcT6esHDbMOQepXqXkhwygGroTgAO01gY35+mR9RIxSLudkhytVEtBRgZnRINeJP2E3yMZ1G8veeDhyIwj2mFb1g7SsW/d+GU1+dY8Yvd4OEu94bRnQMeFqqge3nlmPrYF1+QRMVrH0c6K4uXtbcWoRi7U8wNMxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615808; c=relaxed/simple;
	bh=FHfxUgpDum5ej6KdLWv4qknAPvhLCIfddrWDP+fNjkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4sWVtH04PG3TyKO9rmhNlZSkZsxqGV4LFtGMvnq3cs6j7IgXLd8FMX0bEzdfd1iJyaNGdhfALw/x82i7f8a1V4OpOhYnVvUkW49bj01Az8jEF+60muUwv8jXBLrc+b6ilDzSLuADN4RCX/kzqZiu7vxcsgMQw3wi8+JIpNyG/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cW5VNDrH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gcU3XU6i; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cW5VNDrH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gcU3XU6i"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D18671D00059;
	Mon,  5 Jan 2026 07:23:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 05 Jan 2026 07:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767615805; x=1767702205; bh=7Yv+cAgZnr
	nY+vauYRkqTLQ7bW2kCbErR0/DzRF9ShA=; b=cW5VNDrHM2tDk2FHs4/LQfbr4k
	FrtJMb0FVYDttKT5J2nbsWkCdr7dhzLqDjcItDl+VUFU0HNtbI6Lz40y+tGWnB/4
	4urFjm9KB+7tbZBC2WVPCJDf5ajADjKOQRw1XrSJlOGcIQ53jEJOwzoW1F30Ys0+
	4bd7uOuAdjO1I0AeawGqQFJ2uPGqpmmh7h8ylfZKBN93q7loiFrcYi5ejC/EjiKm
	wsovKGRncXgOyVwpjOMWA6Sru/Vr4pRrogf7CmmP9RTQhS1JOVgPPiVCYlZdkEcT
	s7rih/puf78p/WeskHb4NqcJGDpObCB6kORTJZGDMKYrOf3qTUhkxE++kyDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767615805; x=1767702205; bh=7Yv+cAgZnrnY+vauYRkqTLQ7bW2kCbErR0/
	DzRF9ShA=; b=gcU3XU6inVnGg/rIbwLbgzugVcKlWfLRyfO3Te7Z5H0xLtu/MWk
	ZhQfLwds0FWjQyhhMK6SBTw9OME39mdP+rfoIHNi9LijUR3fFHWwASsumDRwih8D
	GiK+4HeJLjTMeRtqBtM4UmpANjXXm/kMl3tEoYKnFv2RdFQq3crnDWW+ooqnQ+Ku
	tVjfQwE2ZNwFLUNhaKZP1jRyQVrHn0jdSVNmW18N3wNNCHQsljfxbx+hao0d7yi+
	EOzBpCacrC7qnQvfdnixFlju5VOm7oJEDPRbl27l7Js5k5ZU3bIV5OtmbXDAFFjo
	kkWK98kvo/NeoRYExaj2xZueSlBOy5AwzhQ==
X-ME-Sender: <xms:Pa1baddqWbVbIsb1STsDz1P8jNVsUZNY3mnFenbQ48Ie-UwY7t8l9Q>
    <xme:Pa1baaSirAvop955wLuQBuRIOpF46bzH64ret0NGyqZd62XEdS4FqbODwUYP7m85f
    z-kePe_yak2TyUXgrkmJfBy1OsnzOfxwGsasGPZ3KKs_eTc_Fz-AA>
X-ME-Received: <xmr:Pa1bactVXc1c071gBMLR5LWHukUqRrYrrQD5DCBvodYb-Lyoy2DfcRW4RNoEf_snKqrVGYCAxDNtS3GVQpJO9v179bV2hv540ymUsCul>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthgsohgvghhiseifvggsrdguvgdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehptggrshgrrhgvthhtohesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtph
    htthhopehprghulhhordgtrghsrghrvghtthhosehshhhophhifhihrdgtohhm
X-ME-Proxy: <xmx:Pa1baTcH3-Fz8HW8A8EdxIqVIywgozctp-j0OHRMstADohb6Auqe4w>
    <xmx:Pa1baeYKZA0wYvha0_1x7qlHK34H48kzhBexmwPxY9y_hu_q8gpQPA>
    <xmx:Pa1badZFI_ZPg_rYyA2SKLL3OFdaSIdEu4Y1uEmnusdX8yia9jZzYg>
    <xmx:Pa1babJQzvWKggJS4hJpw5Lm6fuKoVfnMeNO461paLJmltN2lMH4wg>
    <xmx:Pa1baXsYGOStjNn0c0Mq4UYs8HeW-cQZ_DnBDq-h7Y_hMjXWUvIp3_Ub>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 07:23:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 748127b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 12:23:22 +0000 (UTC)
Date: Mon, 5 Jan 2026 13:23:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"Paulo Casaretto (Shopify)" <paulo.casaretto@shopify.com>,
	Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v3] lockfile: add PID file for debugging stale locks
Message-ID: <aVutN543nceW0f8W@pks.im>
References: <pull.2011.v2.git.1765997966593.gitgitgadget@gmail.com>
 <pull.2011.v3.git.1766579053136.gitgitgadget@gmail.com>
 <20251227075025.GC2071715@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227075025.GC2071715@coredump.intra.peff.net>

On Sat, Dec 27, 2025 at 02:50:25AM -0500, Jeff King wrote:
> On Wed, Dec 24, 2025 at 12:24:13PM +0000, Paulo Casaretto via GitGitGadget wrote:
> 
> > For a lock file "foo.lock", the PID file is named "foo~pid.lock". The
> > tilde character is forbidden in refnames and allowed in Windows
> > filenames, which guarantees no collision with the refs namespace
> > (e.g., refs "foo" and "foo~pid" cannot both exist). The file uses a
> > simple key-value format ("pid <value>") following the same pattern as
> > Git object headers, making it extensible for future metadata.
> 
> FWIW, I like this approach, as the earlier collision possibilities in
> earlier iterations made me a bit uncomfortable.
> 
> But then I wondered...
> 
> > The feature is controlled via core.lockfilePid configuration, which
> > accepts per-component values similar to core.fsync:
> > 
> >   - none: Disable for all components (default)
> >   - all: Enable for all components
> >   - index, config, refs, commit-graph, midx, shallow, gc, other:
> >     Enable for specific components
> 
> Do we really need this complexity now? I can see reasons why a user
> might want to switch the feature on (because they want the extra pid
> debugging info) or off (because they do not want the extra filesystem
> operations or potential cleanup hassle of extra stale files).
> 
> But if the collision problems in the ref namespace are now solved, does
> anybody really care about turning it on just for particular subsystems?
> I'd think they would want all or nothing.
> 
> 
> Trying to devil's advocate myself: maybe somebody is concerned about
> filesystem overhead for frequently-written files like refs but not for
> others, like config? That feels unlikely to me, but at least possible.
> 
> But if we were to ditch the subsystem-granularity for config, then all
> of the extra LOCKFILE_* arguments here could just go away.

I tend to agree. Based on my own experience, references are by far the
most likely subsystem where one may hit stale lockfiles, so the feature
is most useful there. But at the same time, it's also the most expensive
subsystem to enable this feature for because we write so many small
files there.

Consequently, if anybody cares, they would most likely want to enable
this feature for refs. And, if so, the impact on other subsystems would
very likely be dwarfed by the refs overhead.

So my approach would be to enable this setting with only "true" and
"false" as possible values initially. And if we ever get a use case
where somebody would be helped by configuring this per subsystem we can
extend the config to learn about subsystems.

But ultimately I don't care too strongly about this. If the author wants
to keep the current approach I'm fine with that, too.

Patrick
