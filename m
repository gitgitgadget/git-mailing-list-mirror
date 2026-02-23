Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F09B3451D9
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840166; cv=none; b=ubacNR8b/8ZVZKf4BDdF9LFrFPdbMjwcN/VB4Dbb/DdpDymSndeCxY/sc18BUqtZIX+bCaUbpC6OkRgh8mBIuTOHwvfPXyfx9RsZw2LXgnRv/RlicmUgAkBMvEAUKk0kYaYsegB6bDwC+woIKzFSKi5opGTrS/ahc5mvmJ3ignE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840166; c=relaxed/simple;
	bh=USzRd4kxyy2IsrAhFrBzemuNNBWBXAl/+BAnuI9fUhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOFabb2kWiPyOyb9fBvbIVKqYoJOWKNnP9jvKQzSs5ZEdtzHOYKzkbFth1YgWn0ebU9BVZberWrIjHlqOBcVGR6/ja9ss7hEIdaKoG/D26oKHYkiMFqON87UTs8zWSiDj6I2tcfowwWO57k1ojA5sx0URwrMIve/U9lgVrSeabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Og75ss5D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TycjDi90; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Og75ss5D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TycjDi90"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6046014001B6;
	Mon, 23 Feb 2026 04:49:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 23 Feb 2026 04:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771840164; x=1771926564; bh=iqzaO2rTok
	0LNIufZ3jQCLh4uE/4HKG3ErVZG8q9UAA=; b=Og75ss5D0bobVXkzuyPqv2rXBP
	ne9+mXDkfBzbRtISwmrHwoDj+xTg1o4jmU6xB2z1vvtpGPLAZnPUcFNGvrQWm+Ht
	wOoV5klri3vtJENntrP81fv5tHMNBktwOJRmUnSzW+8Mcvvp9gB13MNQoM+o7eKS
	JuGbeW57DBYNBBoNYU+LIgPxSfMg4Ym3IxEfbm3XGXDr87nv0qqqYUHBYB1lT2Qf
	dPW4IJ4drVnahvWZKDMYAv/j6D+Gow3duBoDh3IDgx7OSXE3G25ktHbmhig3hVCy
	DfsMngXSfBPBA3iz0m5NHjVsVO9ThfiLJRIyctNhd2UPfmbCwNFXI3aRbtQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771840164; x=1771926564; bh=iqzaO2rTok0LNIufZ3jQCLh4uE/4HKG3ErV
	ZG8q9UAA=; b=TycjDi90CI40UmAPuzh7d73nklIE6maHl6THwdLEjFqO5GhQQqH
	9ZWhvXRYG7nwD1E4CJb3H+Wba8RF+fsCfUUbJtoiDP3DLzyMTojnvdXgcfC0+1U6
	wJas2yN2r2mYQ4PErNzCOoDtVqVgvL+yudJuIyMnKHaD1YQFsD9Oqd++NPFt+erE
	wW1s79MATHjXGNt42GTFFzQCrN2BGkQTDvIMlIJTJjJxK3e8+fxTB+lOD6KJtoxj
	HKFwyZZ58o4C1CIzyFJp3qcVu6bzTqBlqvnISGnmS7UmdZhi8dX04HO2EwKqtFn9
	7T1bk3qHfyYOo0ghk0tqkClcBQjfMnaEYAA==
X-ME-Sender: <xms:pCKcaSmYXRbo3jsISlzrRT3fLYYWijUPkzpOv-cTtkwrqvZbYdOy7A>
    <xme:pCKcaRSXLCJCcSxKZpYPOMYyRinDsLESPwTfgGoWFzj-Et6L_ZKlWhk64rPWPIiAn
    mP59-6EAQBZDv3URMf0F4fkQwjrQE5PwOQD94eeoAhJfzAeezZv7rE>
X-ME-Received: <xmr:pCKcaeBTpm9C0d30ixhjXAhYl7C940H_aLCXzGnpeCJCy0OnMnYfN_DzmMPkhNicrrX418ziqqLnyqrJr61RmUNAt2GDj71QxR7Ci2BIOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeileduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:pCKcaQR6d3TZXiOhelqusmlGyAgPsXmxudJZ6cVjwKXI7X8NCfBdkA>
    <xmx:pCKcaUoHkEyDDrmjNakI47vhAYYE4Ay1qWy3P1alxHv0pbXuN8d43A>
    <xmx:pCKcaawXqe4pexXk7Q7aaEpQDSnIfvPZFbS4uMyFgQ_i43SIM9EJtw>
    <xmx:pCKcaRKmpvFPhDjGm26iUBE79GmwjpySiSayASxj7vDtwOr_y8U1mw>
    <xmx:pCKcaRuJ_e1peTaJvp9hhiGNuv_PYBJTyaAxXpDdVB_5UgyoSxgK4wB6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 04:49:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a75478b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 09:49:21 +0000 (UTC)
Date: Mon, 23 Feb 2026 10:49:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 8/8] builtin/maintenance: use "geometric" strategy by
 default
Message-ID: <aZwinjoywwnzEvRG@pks.im>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-8-faeb321ad13b@pks.im>
 <4ec59d18-5aef-48e9-a4ec-77e20a2a14c8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ec59d18-5aef-48e9-a4ec-77e20a2a14c8@gmail.com>

On Sun, Feb 22, 2026 at 07:52:40PM -0500, Derrick Stolee wrote:
> On 2/20/26 5:15 AM, Patrick Steinhardt wrote:
> > The git-gc(1) command has been introduced in the early days of Git in
> > 30f610b7b0 (Create 'git gc' to perform common maintenance operations.,
> > 2006-12-27) as the main repository maintenance utility. And while the
> > tool has of course evolved since then to cover new parts, the basic
> > strategy it uses has never really changed much.
> 
> I agree that the 'gc' strategy no longer serves users as a good default.
> For those that want foreground commands to trigger maintenance (detached
> on Unix, and as a blocking child on Windows) the 'geometric' strategy is
> a good one.
> 
> > Switch the default strategy away from "gc" to "geometric", but retain
> > the "incremental" strategy configured by Scalar.
> 
> Instead of "configured by Scalar" I'd say instead "configured when
> initializing background maintenance with 'git maintenance start'" which
> is how how Scalar sets this up indirectly.
> 
> Users could still opt-in to 'geometric' in the background, but it
> would cause difficulties for the largest of repos that rely on the
> 'incremental' strategy's limit of the amount of data processed.

Makes sense, will rephrase.

> >   	} else {
> > -		strategy = gc_strategy;
> > +		strategy = geometric_strategy;
> >   		type = MAINTENANCE_TYPE_MANUAL;
> >   	}
> 
> Should this include some kind of documentation update in
> Documentation/config/maintenance.adoc?

Oh, right, it definitely should!

Patrick
