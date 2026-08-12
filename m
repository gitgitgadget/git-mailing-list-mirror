Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A73F40B108
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535825; cv=none; b=N81qVat2GW8R8KLQwOM/SW0WEvokxseRatSu0yggDJ+1lMWZkLzXfb4b617WkNAwI6bYk6YAEVmfUSyejL/+rKPIe0eW/AaMruH/A3U5fLnt346DvAv2BGTwqHz0dN+SeGls2lzyGmIzo/jlPJrGhbPQtvFhWRwmohDgSLlcxuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535825; c=relaxed/simple;
	bh=cL0gmdcejRqv04G0GlwMVh42lsgWZEzOLfgWzRYN+Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVZ/6pU0/KZWO8SPUK5af6xiKxRdvX6d7ZJd8/jeHoZWvJeH3BDPHtGHbB1HqQ02z4AY/Wf+09pcfwdd8FiZAYSZU1oTSYt4rERh+D2ewSjtf1n2Aga2LJW6DJwyNi80/3vXdEdHc9bEsWczwIWM35znghL263akQ6C5siYxUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GxDYRZR1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lAIk0xKu; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GxDYRZR1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lAIk0xKu"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 6DA33EC0209;
	Wed, 12 Aug 2026 07:57:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 12 Aug 2026 07:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786535822; x=1786622222; bh=7/XerJSO+n
	QsSERhZ6LHrjz3J/BVaB6+qu0Azp/wKXI=; b=GxDYRZR1eQXXzHDLQisij/xOO/
	JXKcc05bsY1nfLynPNYz1B8Xbk16L/DYXP9lBUyzihQWXVotCKdiH4ySdJpY0fQL
	DetpuQekk9T8NF8dUFlDqfunegZ+KG36Z8jg3Q3FrY7eEHvYwBiwirHeNL1/FfCh
	O/84deH2v22ZPDorDajATo6f8yH3M+l8yOI8rJtu7mhRHG5p8EeyHGZHmhFUpIIV
	lgEtE80AeSI1BEvpkXWG+mX7lJ+jrrGBh91p5ZTomWkmyORPjvSpm6GhJMRlbW1T
	lmYyokJD744QpAReWKOpN/kV2GzNqiz0aII99kNgP6KIPpBSHWYmx+BH87Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786535822; x=1786622222; bh=7/XerJSO+nQsSERhZ6LHrjz3J/BVaB6+qu0
	Azp/wKXI=; b=lAIk0xKuwUVysYkGfMG5KJ38rBMoIGXle/C+jfVnHC28uMxkajl
	wZjtyYQQ5ZWx3Doc6r1av2I/gMiBxr20TSJu9Zj/NrhQdspy5iefRNRIu0OgcjVH
	AhUCYDp9DYCd1GOvGRx7KluXs+6UWqMlI43QmwaF5kkUnD12/3C+Sv9IYFqqXceH
	G9vIVsmVm1Db5MoXQyfhZsjK5KYmFhKQPdJVKT4kqymrzm9y40+CjNuYhwOdTaIM
	rgG9YAlU9zlsXTMaXKWB3BvmOZidRvD24qYbnchYc6dIXUVpYsGn7iFWpkFPwD+X
	FpIMewe6zP8ytaq7aeuxSJ0N9yCB7PD87iw==
X-ME-Sender: <xms:jV98aisBrECFcsti0EBmqTbuoFUjNHEwLZvobrSPGEfA4C14mbbObw>
    <xme:jV98apslu25g4aRFkweZ5QTbQl7wrVx2MVzt3pqCDg1A9j3m8YX92rJF3U0j0soQ-
    pCCN-FiwYjMJNuQZcS9tsAcsdZBIR_lrsULKiC260Qxmr727LfqLA>
X-ME-Received: <xmr:jV98agAhoEmkc-NLDSg7FAILTSOfaQjFDS7DY5QXhHXhvXVPjHF2VTPsKk69fnb7aYrwnH2grVlIsbSmNIUlBOQs6FkAqUqYLyj7Vyczpw>
X-ME-Proxy-Cause: dmFkZTFZ04j+ycE7SjpgNQjbPf3966jO7yR3/3hd8CrV58WH5ARAXjQ9KSyH7FUckn1o/f
    IghP46j/Int11qpRviBZU7DDBDbZmZbWnyvaCBjtTqwPYpcMfOmiTY85QCyevJCb0SISeB
    l1QTGdREfh95c8HJ3GvFZZGrYujvyNRQIehkQrOFfTbO04cQ81XNEGTPYF1zRINnRTcaKa
    jB5Ub1Z48Z59iHZ5V6Au9t3oQ6RD4HDhXQLMbrA78pKHtiPm11ET9NiuhmT582LQRV1MYK
    VnCsrkpKDyHdCFWXeSUteQms4Jxyc7uKI75rIaBWfjN4vlrcGHBukPsT6s9D7UfGTp9ENI
    oOf72cw5RF7xaHDugL/1yc6lT9Z/umG3wl2imU3zL7BOHjYIX4fEVF9lDyPOAk6Z8ehXyM
    9E1v+snVSkw801ycCwqsSpx9BwBiJ1TNbQmPpwSLc6lgB5Qz58dZDC8hudpOZsd25PIPXi
    BEMgY1isXYqmo64q/3F2MzRLodeuTv1aX702oNsBDRFqBEIuDN50+yGCt1xTJyO8Em79O7
    61WSLZttSpzIC/u+58LvqVBtshqGTn2aeUsF3DOd4wOxgKZQuw99KAnBFrchq26mqQV4DI
    L2NCRm/eY8ITiE3UhFhGP6t3Ihh9q6YFf1D1U63mycXw9z0Zo58BWgmyqy6w
X-ME-Proxy: <xmx:jV98ajN7gzEXg1XHkTga_JmF7EKNBFOTih1bdVTiM3hZrQf0-v64Lw>
    <xmx:jV98ahwbZEoaQlZ9meyLEceAZ1brfC_z-NMJiV91geL8xa74TKSxzw>
    <xmx:jV98arUSGDV4eJxnINGwszoPHvUZm-yiYNK383fUBZJD4JVObg5eng>
    <xmx:jV98arPwxOQXFsCNnmGWC3xqlestpo2U2huwfm75Op1IOg6I6PWFvQ>
    <xmx:jl98aqRI_EIp5nVIXC3DpuUMEIzbbyB53oUhTQm6U83dVuCa6VhKDLGJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 07:57:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 406a5d3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 11:56:58 +0000 (UTC)
Date: Wed, 12 Aug 2026 13:56:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ron Nazarov <ron@noisytoot.org>
Cc: git@vger.kernel.org,
	Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Subject: Re: [PATCH] config: add http.sslVerifyHost option
Message-ID: <anxfgvcDkV6k1BLb@pks.im>
References: <20260807153315.9586-1-ron@noisytoot.org>
 <ansYP7cDvtNWueIz@pks.im>
 <7b833cd4-bad3-462a-9860-a8153d4f6b0d@noisytoot.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b833cd4-bad3-462a-9860-a8153d4f6b0d@noisytoot.org>

On Wed, Aug 12, 2026 at 04:31:59AM +0100, Ron Nazarov wrote:
> On 11/08/2026 13:40, Patrick Steinhardt wrote:
> > On Fri, Aug 07, 2026 at 04:33:14PM +0100, Ron Nazarov wrote:
> > > This allows for disabling host verification without completely
> > > disabling TLS certificate verification.  This is useful when using TLS
> > > in a decentralized way (similar to how one would use SSH), where the
> > > remote endpoint has a self-signed certificate that does not
> > > necessarily have a valid CN (or any CN at all), and you set
> > > http.sslCAInfo to that specific certificate.  Without such an option,
> > > it is impossible to use a certificate with a non-matching hostname
> > > without completely disabling TLS verification, which is insecure.
> > 
> > Arguably both options are insecure, this new option just pretends to be
> > secure. If we accept arbitrary certificates for an endpoint, then it
> > becomes trivial for somebody to perform a man-in-the-middle attack
> > against you by simply swapping out the certificate against a self-signed
> > one. And man-in-the-middle attacks are basically what we want to protect
> > against with TLS.
> > 
> > [...]
> > 
> > Maybe I'm missing something obvious. But if so, I think both the commit
> > message and the documentation would need to be amended to document that
> > gap and state that yes, this is still insecure.
> > 
> 
> The intention is for this to be combined with setting sslCAInfo and/or
> sslCAPath to the specific self-signed certificate used for the remote
> (rather than to something like a public CA where anyone can easily get a
> certificate signed by it).  If used on its own (with the default CA
> certificate store) it is of course insecure.  The commit message already
> states this ("and you set http.sslCAInfo to that specific certificate",
> although perhaps it could be made more clear that if you don't do this it is
> insecure), but the documentation currently does not.  The specific use-case
> I am currently using this option for is a private git server accessible over
> a public IPv6 address using a self-signed certificate which does not have a
> valid CN (or a subjectAltName) at all.  I have something like this in my
> .gitconfig:
> 
> [http "https://[2001:db8::1]/"]
>         sslCAInfo = /path/to/cert.pem
>         sslVerifyHost = false
>         sslCAPath = /dev/null
> 
> where /path/to/cert.pem is the specific certificate served by the git
> server, which I have verified externally to belong to the owner.  This
> provides the same security guarantees as using SSH with the server's
> fingerprint in my known_hosts file.

Okay, that's a whole lot more reasonable then. You essentially pin the
certificate that you expect from the server-side, and as a result noone
can intercept the traffic unless they have the private key. We should
definitely update the documentation then to highlight how users can
securely use `sslVerifyHost` so that they're not on their own to figure
this out.

> (Also, this is unrelated to your review, but for some reason my original
> email containing the patch is missing from lore.kernel.org.  I don't know
> why, since people not in the CC list are replying, it presumably must have
> been sent to the list.)

Hm, curious. No idea why that is -- hopefully, v2 will land just fine.

Patrick
