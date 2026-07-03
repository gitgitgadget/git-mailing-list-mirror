Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A473537F7
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 05:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057328; cv=none; b=HcOHwqgtU8EEdilX0bEl8eIk4de+eVMNEimxpF7oBoxG0hhwMFcTDW8pTn5I4s3ZK8A7gxW08k8XjUynmIXn6bvsv4ZfmUQAoa0am19Oe6p6BQZp0DQI3RqhVIdfRbw+Ev/IzNY/4eaObU/sjNDmqvGCENR4uGpPA4rJkLh5TkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057328; c=relaxed/simple;
	bh=0xFkhJqXa/wcmz+vQlawohAExYSdnK08KJGFuy+ke5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL6OaMRsHbVX7rAlkJCa/jJxncBwVHyNM7Um5XlvHGauzH1QrjUO0CQVMrpHJuPG3YP+m4uHiz96r03WhucoGhqtyqjHGYWdq634ZLapJ0/Im7pXFXX3Q9lv3W+AzzMfsh/QGx0i22WUEkspkrczCuNveKGML+3+uNBM0iWo338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CF4wr+Kz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zu2GlhBy; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CF4wr+Kz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zu2GlhBy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5582F7A001C;
	Fri,  3 Jul 2026 01:42:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 03 Jul 2026 01:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783057326; x=1783143726; bh=/cP/t3Cyng
	0B7NmBnYLhH2VDPCjozRjH5wW3uNwK4GM=; b=CF4wr+KzbSHrqB+z8vu9cV9n7G
	w6gsQVUXQMWy1NKBQxVrLS8yXsHEQZj3f/xgvpbRe9885qcUs3UV/VemAYBZo5f7
	TK3PXHc1y2X0FYzWB9hm92imoqa7wQ639dUk0ephzyQhDqGD7MQpxxT2h8gFt7LA
	u/RcDjvJCvKFAvXqMjTeOukTxnUqGc7bKUjmJlYQltdotLFkE3KzrBpOkuuTmZ81
	jC9sL5Zgio5BK3Yq70wswyjm5zIH5J/tJnX81/zOiws7HojDCeEVrJv9Y4E9nVSX
	wE/nOnLPXBkyDRr4Gw//tKc+aPg8hDTMZfNnVTx9S3dLkA2itwfiqVCGSQ1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783057326; x=1783143726; bh=/cP/t3Cyng0B7NmBnYLhH2VDPCjozRjH5wW
	3uNwK4GM=; b=Zu2GlhBy8LhWrR94SeTga6pMtWLjT5OYBHc9Y9Zrh9TRM2yI2Y4
	Lq6WUhYMHvm16d45CG+tsm2Ugf01XSgcq5ZSvUWF3KY05kelHCnkaKC0W+2PD9dv
	1gqnHQIXy7qPDxM41tu5mPBxn5LAqZXWQVI1VakLmKVpLg0xAKrjTBz9hmUEOmb1
	jO0Q6kBDkFJ6EIi4hZhfoLekjbfW4o+v/C8/7qglzoJUt1raY9f2lBkoai8oI74N
	VPKTjDGGHV9V4wZG1jvIbQDkGGZOzP+QUBTEOjUqHYObhx1B2cMid3pRxB1VW/UY
	VuO8VI+WmFv7htZNniIwLKGpVuM5y1+32sw==
X-ME-Sender: <xms:rktHaqrnzTZm2mjC6w8R0Ld1lin6TUFK4f7KU7XFH6YtImeLdcCrZw>
    <xme:rktHavoftbPLjCGUxpTpj4cmI1MHS1ow6gy0rLDP9FXXEyyfWcuZkjX5wHZaNiIKL
    mm_K9T-sLFZTjA1MWDp_7IdcRRIAsOvPbsJSyv7XepLO-QBBj_H6g>
X-ME-Received: <xmr:rktHakNHO_OzA3ISx0wsvkGdDJWwhpofHus4PgEl74jhP6EinpksB-bcxiQ2URYEQcbuhOm2WpABd_jlaMOCayx5tQ5R1rZFYw8UQ8DOrw>
X-ME-Proxy-Cause: dmFkZTGgJxKAniFpP/0S6WeeJZEe2xOAAgq2F1Z3mINUVfhX9E4rHYvLyxzJmcXxZv5C0/
    o+p15RyPnEgoviQJW5tdnFEMXWd8muTk2ZJ5ui13HABWgFiT9/Dap20PxsZglgZ0VLJCD2
    GNU2qwGkdhWdZS3sSfLZQuu+PNUEBQ9iODOwUWyO/OP7Nfuotf9h63n1JnA5aSJNC6oK8m
    gnnfokSgdqYym9FJIZDfpXb+0t5FuMJiJXG8f7hj8VMo+poVhuCildxZDHCtd8BmEihpvz
    fJP7cNq0mEQslhIk7f5JtWXOoINSH+lIKvzFxFhoBav7jAyVQ6fgk1zP2+R7Pc8fTERHd0
    Vsu+HDfhMd2n1DDucUFWl0hKlJyYiOTBmCqofwFbg0fZ6/hrneAO1rb6JJPOY8P+OzR4w0
    j9VuYPmW07W/zUBNWvhKJI7r4G3N+040pGKWwTWbpXgoHCuGBQOKbUTaXFbgHjL6GdM7Ym
    OVpNBFnizT3//2V7U7G3RFjjo6I0hDVn18y2JqTXb0k+Ve1je7we5zlza6RaplC9AkJOEr
    XVJvVqOAKW/Ywy0SLnhYQw5O4T/GM1XlEFVnSUpgQLaaFhw+egZse/65zUQSMdu0rLOlJt
    vHIpCbux+/dXcn+LraCnNrdOOd2W1W3EsCifbug0qUkytLANXv+HzGHJqG3A
X-ME-Proxy: <xmx:rktHaoyXJ3cEScCQBAubVwkTkXI5xTAfhqYU69gIH9mpPcpXgbqTsg>
    <xmx:rktHaluEVBi6_d6U7WKjTMf1dSZTfIQ4SWZK5F0avlWXYanEOpuAGw>
    <xmx:rktHap5qYIeQVhMwVJUNAZ1CBwBVyXP34Lj5thubkiU3_wifAC9asw>
    <xmx:rktHasRsahnFYyIgXoJ15O7d601boHaRZwCEX3ue--BNQpR4HzAq4Q>
    <xmx:rktHaoZ2zply_shBVtV_98FYVT1iklbzrP87HhaU3-DPcm7sCEkjjK8P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 01:42:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 03990491 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 05:42:02 +0000 (UTC)
Date: Fri, 3 Jul 2026 07:42:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/9] t4141: fix inefficient use of dd(1)
Message-ID: <akdLqNHW3pGThQat@pks.im>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
 <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-3-76b4d7bab3d0@pks.im>
 <20260702211614.GB2051171@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702211614.GB2051171@coredump.intra.peff.net>

On Thu, Jul 02, 2026 at 05:16:14PM -0400, Jeff King wrote:
> On Thu, Jul 02, 2026 at 02:00:56PM +0200, Patrick Steinhardt wrote:
> 
> > This test setup is extremely expensive, as `test_copy_bytes` is
> > implemented via `dd ibs=1 count="$1"`, which copies data one byte at a
> > time. So as we write 1GB of data, we end up doing 1 billion reads and
> > writes. This naturally takes a while: it takes 6 minutes on my system,
> > and around 40 minutes in some CI jobs!
> > 
> > We can do much better though, as genzeros already knows to handle an
> > optional limit of how much data it is supposed to write, which allows us
> > to remove the call to `test_copy_bytes`. Furthermore, it has already
> > been optimized to generate the data fast.
> 
> Seems like a good fix for this case, where we can skip the extra process
> entirely.
> 
> It feels like test_copy_bytes should be able to do much better in
> general. The obvious thing to reach for is "head -c", but the function
> was originally added because that wasn't portable. The "-c" option is
> not in POSIX, though the original comment claims IRIX was the problem,
> so I wonder if "head -c" is de facto portable these days.

An alternative could be to implement a simple helper as part of our
test-tool. But I doubt it's really worth it: almost all callers only
want to copy a small number of bytes. The only exception seems to be
t0021, where we copy up to 65kB. But that whole test suite still only
takes ~3 seconds, so optimizing that feels like wasted time to me.

Patrick
