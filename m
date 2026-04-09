Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309DB2E6116
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 05:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775712175; cv=none; b=EqdTftOdeDrHZn64Wds9QPKIOEGzsJ3KQjqBWfeIRhdMtL3nxG5tzC8r+9Jnu7jG9SnB8pCDjUsIJy6bo6zvPnPdcJbcFVuIoYncHPX8/Q61GG7+vdpVLyDvKKnmNIjx7kG5goI2+7u4ju4loQdFXnUTJHZo5GG5iHJJfk0rcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775712175; c=relaxed/simple;
	bh=xo6zWMG6Y9Iepdt5Ideo+y755le7rBGxmEiApJeAq0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG05zjVOFCa5FTojRvV/lbbb66yzPXvUMP57tunfHI1LaucMsISqOkDTHUQiNWO/dBmpuFZhEr5Db4YC2OczsDgDmPb5h/PLAbV/42RZvxG+0NqrsCY206SLnCi3d9KoqrIuvMZg1fN8Foo4kk5T38OGWjC4BtbWxqvvn9E/8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L4N0cI5e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P4c9eNyH; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L4N0cI5e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P4c9eNyH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B9FF7A01CB;
	Thu,  9 Apr 2026 01:22:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 09 Apr 2026 01:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775712173; x=1775798573; bh=9c5t1rM6Ln
	sjJNjHTRZzZsJKjDXad1TJWaSc6SJYp9U=; b=L4N0cI5eZQf3sq/uEZsG3miKJM
	8dsuglRbIYHqo+Use+51JkAJm79iznPh0XCrZ09RafjNRhU2zpxT8z65MPfWl1jK
	u4xGf8xpwC4xhI4h9i1KwuenxhaO+SKMTlYsemeEEz8HzwKHkzkDusmhuH2qc3Iq
	gdRwOsvQmYf09lxsTL7n7Xy2Vh4mB7KTE9uGXSPA7lZfXbMSBbiFK29+OoZHOsQu
	+KVDaCOZ45DrPmiVNSjsdWoX7Q2feVPQC84xPltxlDYL4TKiC/Ex63+QkZVmkFc4
	WhAzACKG3fwO+a787YfLq34UDMY3xLQygRZaWp+uoP8K1JQniqGYnoQzR6aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775712173; x=1775798573; bh=9c5t1rM6LnsjJNjHTRZzZsJKjDXad1TJWaS
	c6SJYp9U=; b=P4c9eNyHNsS3og5wdDX1OL7/qN1SUYn+UfP+GBUoj5q58fNmCPE
	Fnpv6m2bYWioM2TR308rQqPEAflXUf2ZSNe9Vv5lwmzX0bNqPIQ39UpRn+7WaV/V
	pvTdTa1qLOUvox+8kY+H20cdvm/P+8G5gY4kwRszIB/6cO+mKi07a8MGOfQviAKy
	CfSz9gdhd/xGjrt7vA9SZ++VvNQIN9go2OLpzexRF+sHTJYUeMGLtAjwRXTEQDfP
	goG2r04qeTL1NnyYvi6ia5IBeNaDQcX0cy9c9vuCsrf6x9pVL434OUVXa5mpllWZ
	2GwH15LWpFY0G+xD5V54wJYttOmKboLPofQ==
X-ME-Sender: <xms:rTfXaZesLNZfYA81b1ssRHzOnW64hTSicHsJBXSZov0wI2vqWmLGSg>
    <xme:rTfXadPF3Dk_WGQ61YxNaPhRXW2N8TjHPUYMkqiZRHNfkKGZSLCzZhq1HrEQwBOHS
    ooWL49DG45C4-1tCJuZbwL7J__k4UbWEO24y1nm7PDRA1frNglxIA>
X-ME-Received: <xmr:rTfXaQLDiImlOu08QVJv-e3oIMqJzP0Lbaov1TMI8FVvzzNEXPX0j6f9ruxdPorf8fHluXydv9_S_QLNTKwjE1Hm3nQMQRz_WwzXpg9JWUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rTfXaeEcIRgu-OLRoI_pbvdcVKw8zys7uAp_QQpyobuWs-EFxpz_vQ>
    <xmx:rTfXaYTvPa1KvSG-nm7K0jUKOuGuJuRmjc4OukMxVbfnA4tYpZZYyw>
    <xmx:rTfXaaF-10vHVcyfjSSpCzFsGT6LZnvnGKYSGUFRunUNZM0aUyWPOw>
    <xmx:rTfXaU9DhhxuQOt1rmCMnaVwCizpWNVo3pfS1Wrs_ARjaiSkO88FIg>
    <xmx:rTfXaQNZmo9UAmr6BIsq6zMllMfdYZXUHTvwetRU7dEZbrcE-pB1ct9E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 01:22:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d44b611c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 05:22:51 +0000 (UTC)
Date: Thu, 9 Apr 2026 07:22:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/16] odb: fix unnecessary call to `find_cached_object()`
Message-ID: <adc3qfDPinq1aakq@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
 <20260403-b4-pks-odb-source-inmemory-v1-3-8b8d1abaa25e@pks.im>
 <adbDpPQgvPfctxQS@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adbDpPQgvPfctxQS@denethor>

On Wed, Apr 08, 2026 at 04:13:45PM -0500, Justin Tobler wrote:
> On 26/04/03 08:01AM, Patrick Steinhardt wrote:
> > diff --git a/odb.c b/odb.c
> > index d321242353..21cdedc31c 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -774,8 +774,7 @@ int odb_pretend_object(struct object_database *odb,
> >  	char *co_buf;
> >  
> >  	hash_object_file(odb->repo->hash_algo, buf, len, type, oid);
> > -	if (odb_has_object(odb, oid, 0) ||
> > -	    find_cached_object(odb, oid))
> > +	if (odb_has_object(odb, oid, 0))
> 
> Nice, odb_has_object() does indeed already check the object cache so
> that makes the explicit find_cached_object() redundant.
> 
> If a future where temporary objects could be written to the inmemory ODB
> source, would there ever be a reason for odb_has_object() to
> differentiate between inmemory and real objects?

We could in theory just append the in-memory source to the normal list
of sources, and that would ensure that all the usual operations would
know to also consider this source. But there's a couple of points that
speak against it, at least for now:

  - Callers that explicitly want to explicitly write temporary objects
    need to have a handle to the in-memory source. That handle would be
    hard to obtain if we were to only store the source in the list of
    sources.

  - It would be a change in behaviour if functions like
    `odb_for_each_object()` were to also enumerate in-memory objects.

The former one could be solved by having both the direct pointer and
keep the source in the list. The latter can be solved by having a
separate flag for `odb_for_each_object()` that tells the ODB that we
want to exclude/include in-memory objects.

But overall it feels like this would only complicate things without much
of a tangible benefit.

Patrick
