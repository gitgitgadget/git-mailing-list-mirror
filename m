Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53316A959
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316192; cv=none; b=tLLQvtOW8QTraFtN2gljHeSu3hfxbsACke7U5fg1AHFHnmmFjvIk5xue8HIs7mEhxHq+jeUeKItSQVvTIH9tn/nj73rKPYzgIi+oi1at7tJUwPQ2E9WpLfQcaXvB61XyIoGadratHueTfJEha+9ukErGnLQtD1cukA5alpyl2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316192; c=relaxed/simple;
	bh=cacCWvLV1cDLCbq20P4UmS4fdn7dKDiwu0+HnV0lVqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3LwrPOssdswHg0TvHWaC/sNGypk1lMwtgpmC2Ji0jSFOYwxrRe0KrDRaZZqHNmUCka0fGopMGtUbUqRPA0AeI9cCsTk8PPwH4ry50zJFGNejSkwyqdqdBJ6aNMNRbNWAderFo0Sq45Fdjqc20oODxj1MxHHLCJWvP0Is/gscvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TWrqcV53; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OZFBYOVD; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TWrqcV53";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OZFBYOVD"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D5B1613805E7;
	Mon, 11 Nov 2024 04:09:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 11 Nov 2024 04:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731316189;
	 x=1731402589; bh=IcPp865Jjcbtja96aUaS+XtfluMWIqIFAjDUea/DwQs=; b=
	TWrqcV53kSCI5qlTZM/9VWDxWel+TsfdqO1NSxyNnpuDr5+Ze8S0idkZlBA2B0Sm
	lKjKsZycUvtXKPEPDqkf46gq3snpT1A4n23sojhI4mrQESaFjSHqlrwJy/dmvn2E
	vEsvi2XF4NwHu7kANMyF5s2RhWqrXz4+OLmj1pNXV2nc62QOkbv7gmO/vqEuR2Nz
	2zQA0SBO3ZHv75Gm+iYf/5OpylyluMeBIwM8Y3n/RL5d3bRJTj7y+RrgrvaPt7On
	9Sy7WPfxj75OQcyXbil55bHpHazxI3cBRmVX+7D4Tdk777CBiE5Ad7UpEkLIsE39
	32cG6qso9Af6ciPUoz0HKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731316189; x=
	1731402589; bh=IcPp865Jjcbtja96aUaS+XtfluMWIqIFAjDUea/DwQs=; b=O
	ZFBYOVD5r0VSdnuyBf7wGWEAaiL4NGtbJ03ntc4fEoU0nFU7OcUhLnEfQuXF3VVN
	k8l1VUhAj7/fbe/UWyVgc80QhXyLYp+fv9j4aUwWEITMV+H3GCvmmWWtgq/eMkAJ
	bHk/Wy+yMJgAdo5F0UhaduK77EBYtifGqSrR/xdKdPzj/ziD/vSEAQXmWK4sgfRE
	OUVXRVxFG83sJz2QjuAMVBPA/XgKZBbbsquLIMsZWQcQZ4lNtLNjAbG+p7L01mdr
	eJSHqRtI0pL8+JuAnGpdXCrRxkHAVsuDyrnRBWkPbxTaTV8stc2QVsIEcG57zoda
	OlIWP+AkBIljxOBHl5wKQ==
X-ME-Sender: <xms:3ckxZ-IcE0xJbC_dWuXvAgBuugyjeVydmaRaDLwdUDnFr0yaDRyj2w>
    <xme:3ckxZ2J0ZHTsi7BDNW1EPITY1bsqDv5eRdy4Vf6tyegbV2kubrWexOKQ_I0aJ5j7w
    y30AvB0wFbAM2BBCA>
X-ME-Received: <xmr:3ckxZ-vxDQ3uwUiZfCCL1-A1YfnfrTuf9ZKrj9Fz5MO3KXnkanRQyn_pcxjY08FxppNqiDy4qnPNILO0oM2OCNqvRMcClG-BjmtqIZPrub88nDFv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfurfetoffk
    rfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculd
    dquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveev
    jeejleegtedvgfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehrjhhushhtohesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3ckxZzaP0ClPvAMQeZKxVJJBjIte0xMS5fv3VV7mfNledEX-of4WtQ>
    <xmx:3ckxZ1ZCg0Q7BwemOsVuib2cAwZM_JZ4fRvcstzDGPf0-tjRiEj61w>
    <xmx:3ckxZ_Aeq1U-SVjcS0hOESRkeFZfqjZ50QcyHcwOHmcTUj1lKIAOaA>
    <xmx:3ckxZ7ZdhU9blaOb-9JZBoM2BxVAE_ZVVBsAuEogiJalkEsGwVhFMg>
    <xmx:3ckxZ0kEWBgchKOLcXAYxiJPZ-jwk_4NZwcWrlleneMNYgw5LxQJJEnZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 04:09:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9531b781 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 09:09:15 +0000 (UTC)
Date: Mon, 11 Nov 2024 10:09:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/26] Memory leak fixes (pt.10, final)
Message-ID: <ZzHJ1IyRhA-YquN0@pks.im>
References: <cover.1730901926.git.ps@pks.im>
 <b1cf41c5-ec47-43e2-8a99-3f5faba4d261@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1cf41c5-ec47-43e2-8a99-3f5faba4d261@gmail.com>

On Sun, Nov 10, 2024 at 10:48:53PM +0100, Rubén Justo wrote:
> On Wed, Nov 06, 2024 at 04:10:14PM +0100, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this is the last part of my series of memory leak fixes. This series
> > goes a bit further than past series:
> > 
> >   - Patches 1 to 16 plug remaining memory leaks exposed by our test
> >     suite.
> > 
> >   - Patches 17 to 21 remove the last remaining `UNLEAK()` annotations
> >     and ultimately remove the macro itself.
> > 
> >   - Patch 22 works around a bug in the leak sanitizer itself.
> > 
> >   - Patches 23 and 24 drop annotations where leak-free tests pass with
> >     the leak sanitizer.
> > 
> >   - Patches 25 and 26 unconditionally enable leak checking in all newly
> >     added tests and then drop the `TEST_PASSES_SANITIZE_LEAK`
> >     annotation.
> 
> Hi Patrick.
> 
> Thanks for working on this.
> 
> It's been a while since 956d2e4639 (tests: add a test mode for SANITIZE=leak,
> run it in CI, 2021-09-23).  This series marks certainly another milestone.
> 
> I have left a few comments, none of them important.  The series looks
> good to me.  Just in case you re-roll, while reading the series I
> spotted some nits:

Thanks for your review, I've addressed your comments and will send out
v2 soonish!

patrick
