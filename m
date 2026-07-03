Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93AC330301
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 05:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057333; cv=none; b=CzU88+Hov9lHRqBKwYkwQkNwriQzXsxAYDvpcNNN/KMuMmnMeBhvPTWuks3YtHiH6LE9jbwY8RSSSnkfE2QnBf5NuVlFkL4JdRCseZ2o+vRGHhSMgVVzxC+eMWq+ZUNu7HV5naYZmLh1zKDPAaiqUPwg/468Hkn9LbTfex+3C38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057333; c=relaxed/simple;
	bh=3POmTzsu6Z+PceGrYA9903mbIEfZaEtCtw5IZjBixbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmfH2l4tXv7smfBhfVmrfP/UKiHPBcDfg9dp2b8W6rNPfH25aNn2CScPlQwnMVgOZhduxtyhEtuLKyHgvm+X5N5mlXIfsd5lI0pvtJZhqOUn31hb7dwpjx8YUYgVwAJT5KuyhBlz+FhBmjI++ORoWn9BwLuW4qW4VIpjQNilwOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bv2z2rJZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JzwslRhF; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bv2z2rJZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JzwslRhF"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id EF5931D000B6;
	Fri,  3 Jul 2026 01:42:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 03 Jul 2026 01:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783057331; x=1783143731; bh=UJAlkf7IaS
	o0JII4dM1a5/wndgMvIlFcxH7nat69yFg=; b=bv2z2rJZGaUWU4Qw85du2pxeor
	jveYzHldPZB+Ihg5ElVWzxVqeh+5cpTuwIyRAXvSlPeulzL4WxVCFECcteKB/fd7
	RoInVQdffjyXS521556wdf8+1s75jEvfv2I/HrgNoExnmm00u3FpTtw98bq4CY3f
	5oqAF7DHJ7CWvdRHaqQSZEEhRxOyL3tMnp6WImRRHekiW2QSmijlz36HNlf9wYOr
	CTvPZwUXSQ1/WE70wTCuQb/1s44Y+yKKAwddXmTsGs8bzEi0LVJBbCofBKoh7zsM
	hfiP0/bJD/42X1m+aidlXmxn+7vOu4Wf6tzJ+vw4tvWZC+a/iCyID8P6gbVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783057331; x=1783143731; bh=UJAlkf7IaSo0JII4dM1a5/wndgMvIlFcxH7
	nat69yFg=; b=JzwslRhFzgKhGPLysa5H1xfhCYqGm2o+R9XW5vPtbbHsvmtkZ2Q
	i6iyaMEKkoQrJA/DyTKF8wW41/dXHiIbuNvGzAR+skfX93Bs8fEvmj86eyTsVCej
	zvUmfShUtOwl16jDHG6Gm+sxGeq6lpaLaYcCZb1JjqEJJ7oH2FICs1aYcPaifkde
	uizkQFqKvoPrmLWjH9rhnjPB9lJkKbS6HbII5RPhbHsnGp3V20j7jCr/EemWaD9I
	wsJhG32f9l3OUu2chvbo39P4hVlk0UGrGB5LHt69KmAMe3vuCUCr0xjV9f4AdZXn
	mZ8D04ptEDPvJnQJRr870aIrQFviueHmsPA==
X-ME-Sender: <xms:s0tHamuLxPTMWzjTr1lEO9fpc-3Fh34dP8Up5tqo0QiJcb2EILqGhA>
    <xme:s0tHaic_xICtKp2lf4h1riNF1QPU9ocUsSZPckaKfNj2XW-8QKT8YSp84-8Lj8jhi
    qyr8WTAD2X1pdVyPb4eJz_CbPpzUX2sZq0kIsQRMxG9__xOh505ow>
X-ME-Received: <xmr:s0tHamz7KZx_l70rFKvNjb9iexUE6E1CsF6ziA8LaOlmmxGOei-KdfUQes57qVA84VCzc1RbUH5tTNPzQVyBXGueuRe_iOwwhL8yv8OCWg>
X-ME-Proxy-Cause: dmFkZTFlJeS2g+1yi2cDyT0NwgKSfOWwBacAek3w8poznAXXEO/qL2vbvZNuGpXw2hTtgs
    lPq0BcpsJcvK19vC2kuisTcT3FHNz2KTr4gIKHo0AFWV9AlQrQlcW8Tv7NC8uj7GLFUxJS
    8mSuRWddTMIi7P8nyXy05oa89vjNv3osHpAA+iivGZRd65lxvOw30vQI2CKjx+ycCLlVvb
    yuqmN19HeZfbRb8HjIjGlJnMQvlVD0oWH0EkRZwaRdscS05a4+1kZlgJV76Yxuas2xlIS2
    58CYUi/lkNDwNfxo+HOLQfDMyJf+1c4Y69sm5Y/9p/u7gJgOys9PVd4/9V75KMPTW8zQtK
    PsDXYoruU9/PiRuxGEkqX395AQ8467jpG+I8D7DH8007+QKvNnypxJQSXy5+zM0DOFs5n3
    HYBEzbg+POoQGWMiWXe0v39FpVHyn1Wr84lL4LKnYHQbFLDgs/W0XBMyQCaApLeykLDt3w
    1S0QGwBCEZJv7rU6eXUhOCgBxBK6V0gBXshd+HW7K1MPDI+LgsUZOFjXyDT04HEgbmakPZ
    6FRhZ+wof7L9p0CYOD4dYuSOZ2EK/lHa57ZCPP9MxP6B+eNcfLQhLzaelfCSvamjYZO6Tz
    41DvXgMH/a4ScIdrnWbh6ZZjnOqS/a7fZ7pCZSu9ErqjWvEoyBqB6qTSsjrA
X-ME-Proxy: <xmx:s0tHagEjc36m4FY_A5mjdT0AVsS3u40CHJtG7H3bGOmDacG-xNFivA>
    <xmx:s0tHaiwDphjQ1SfN5CWz0czJJ0buwBof2IpH_LvPTNqwpEmxpfS-Zw>
    <xmx:s0tHapsvrwjpu8PclmhiAfRrRDf2x4U8ha-jr7n_hK-bNgFtneEaHA>
    <xmx:s0tHan2aK-y35A3e6DJXugpK3Wx7BotqyM2aqnhl91Q-sJCWFaoepA>
    <xmx:s0tHao_DYLkKzOCU3hQIKAESe1f6JdXXGvu-dRNdPS1S9O3-UoNf2AXH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 01:42:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0aabe04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 05:42:10 +0000 (UTC)
Date: Fri, 3 Jul 2026 07:42:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/9] t7900: clean up large EXPENSIVE repository
Message-ID: <akdLryzNx1Vi2BnL@pks.im>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
 <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-6-76b4d7bab3d0@pks.im>
 <20260702213044.GD2051171@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702213044.GD2051171@coredump.intra.peff.net>

On Thu, Jul 02, 2026 at 05:30:44PM -0400, Jeff King wrote:
> On Thu, Jul 02, 2026 at 02:00:59PM +0200, Patrick Steinhardt wrote:
> 
> > One of the tests in t7900 is marked with EXPENSIVE because we create a
> > repository with 2GB of data that we end up repacking. We never clean up
> > that repository though, so we occupy the full 2GB of data until the end
> > of the test suite. Besides clogging our disk, it also means that all
> > subsequent tests may have to repack this data multiple times.
> 
> Hmm, I hoped this would drop the time to run t7900 with --long, but it
> takes about 1m40s both before and after your patch (vs ~6s without
> --long). Just looking at the script, I'd guess that it's because the
> subsequent repacks are mostly incremental or geometric, so they don't
> need to write the big pack.
> 
> Oh well. It still seems like an obvious improvement, though, both in
> terms of peak disk usage and avoiding unwanted surprises when more tests
> are added later.

Yeah, the commit message is a bit hand-wavy there indeed. I think the
bigger argument here is that having a test that is marked as EXPENSIVE
and that may influence subsequent tests is just a bad idea.

Patrick
