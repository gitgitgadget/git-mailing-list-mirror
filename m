Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4813FEE
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251809; cv=none; b=ZC0mVFgHZ8a8xOQimUgycl2rilQE1q2ixckpiJKxFhcVGPRr61Wo8oYcF3hv3tNOTo/RSH4d81izIMvlG+FCWveGYRipfzP9sEqDFQTtwFLqSddnFTThpbfwkgNMCdNSp9kFHM40vTpDHVrXj7kpc11NkGzyqttOf9Nu09uIfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251809; c=relaxed/simple;
	bh=89ZVr5VLCNSCcSWFl2GF1kCgCopqsspxAgl19inY6SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxQkQDLKmUc0bOM1W3f8TBVQ/P/8ReegpHIz9d3x1sBHcs+HRV8AaQ0NTVxaJI4ZPBIjLeemupwfwLWLoQ0f4gLIUq289hC5ZhtWXODPSbjMvoLUzSeuuke27p6e5nVi8z8ef8V3fbCdE/RWwX9x5z6eODEn5xo3hAJSTR+c8Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cTX6dKHs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R5PR9pFO; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cTX6dKHs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R5PR9pFO"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF11114000DB;
	Tue,  1 Sep 2026 04:36:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 01 Sep 2026 04:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788251803; x=1788338203; bh=b6f7CHinPA
	UyYDlqAT5df9UCqESY/ocyPxGRe8RYBNc=; b=cTX6dKHsA0IKI9VwDubbkIdNaD
	Ahuujay5UGgdN6ltjrGKkMWqu7SvPh3YDOdk0V4eBTiVO0TXG7CyrRjbhiCTlDnQ
	sL74D7cjxgj+xKHbzGI8mZM/YZGVIk5buRlAK1d7FNZkArQjGf+Xj4MrBkQCCNnx
	XAtp6ZbuQaj6POM0riMi18ZdePUT6SydUMzJ8QPBryIegCwm3dQt2QLtOIJDfJex
	2BbL9cbD065Cu4SenTUfQcMQ7vXZ3vnJD75ftHT0X4mtex0q+m6RibowsCbieqUp
	P9pGQy0BfGvmqzYwv8+yIj/jSiF9iSLN65SysG9yaxwiFbWdPq8Hllfap2tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788251803; x=1788338203; bh=b6f7CHinPAUyYDlqAT5df9UCqESY/ocyPxG
	Re8RYBNc=; b=R5PR9pFOOOvJ4hUlz0wPArkXcSD+db7eOHWG9mgMqAO5zy58mM1
	/NGoZouelTNQB2EDQw9rY6MvhCv8E0DC7ptz5rJ/ikutzhMnS8BIHuXv+qtS5H9o
	wwtgvhljPDfCXLwjvhTMrX2xaKKOEO859RUYpY2AZSHAw6UphK8iSEQuJr3VQ83t
	oak3/HlAwS8puJA5No07e5E4e8AMTAv4P5OFRb734jUQ43LHH9yDjbRhOUY71ryH
	G2TmKgc7u4yJqW4YLiQo43CvrolFNsEBTXhQ8YR6xxm3vRMmH6rg7OQ0NBHZEZmj
	mAXVdQLgshVL2UJzF4slVoOcMR2OmuHDOBw==
X-ME-Sender: <xms:m46Wajt_tgjHJ54lAFTKSNTmtGhdIx9hAFyFLEP23DnudvsJ8F806w>
    <xme:m46WaqfN-via0TinbPQMfQclNi3OCm1apW5UQee7DlQ6QzRMye0LAloV_1v9rZGEs
    pgCkezIL-qyPVwGtMmT6gxuCTEuA6XLY5dCmatQvN8hiBkxCkqxWw>
X-ME-Received: <xmr:m46WakaQyvMq_5toy8KoZGFBSkux5jsGasrsEjq8xMmeTLsT2GOnGg>
X-ME-Proxy-Cause: dmFkZTGr4okKz/nUoy+cSoKLSROrnGyA7iVb7jVbRaOeputTF1UfzejxUNImEaBPAXsgpG
    dqpIkqiED4+IDygyem0cV5GPVAH9cqcZlF29uG0QZ7+ajDCBuq7m4nOULXX8wMSOXFNkt3
    1Zt815xmqiLt6EnRwCdTNIj+lsuEMC9Zhg6BcGTeZNV48WhRHdzfFoV0X0PxA2n2bjroOy
    uN5UcBZeU+TT1ynHfE9Tjg5b0XCaFj7Nyalayop3pt8MlQhqsbB/Vjh+tHOq7zlDuCSsjh
    jVvfg7qI8tC7mOa9/GxrcIHhMP6qd0xJWpSVEbDbcNTbGgC9txOdzMQe1c96a8ls0CxmLS
    LDnZNKaUZ3P8HfDNnMXrwPS1E+AlYBg8QKSpbxBSDzbSUGFjwnDXgW/uYXaG142v6L7PFK
    ZMsOAlP0L3mVNZ8kDNorwpKqWDM1PQrVqJSkot0cPAZv2PJYhpy8q7T1IWSnMom9KWS1yu
    wzkbyr7JTnKgK8yUu55iGFFR0bQEyNZG41AgAcnuPB4zdiQiDnc+CKYJ93voCqv27PkGcY
    o8fDoFbHVrnFAo2IaXpf5+Bjo1xWC1jLS4dR24M0azTtCYNP4QXtXhAbdHdi7wC80f/54s
    3k4soKtRDug4c0BORbnPpo8a7jd0t/SjgviBY3nOOP0YFa+pA1eiYVCCzorA
X-ME-Proxy: <xmx:m46WatWaQKfMmmnmWnT9IyIdjOAR8fOIEhj53RraNBdx7gARZ3-aYw>
    <xmx:m46WamjIv53GgtpPPIJ_2FND6Yh6JPlUq2wA_Wdp8VEImj4z0eWYWw>
    <xmx:m46WarWvLQbEhmQZZtG8i89BWObqHy9ur1sfZflViMGmNTmo2Z04-A>
    <xmx:m46WatMgwXk6cwFKpKX4jM4h0XvOb08nWt9TnHGwIWbgQV_gjxDAdw>
    <xmx:m46WavHG2qPKU8OYjK9cEIWb9aa2r10elgcMirQcMGllQGdp5FwSAZcJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 04:36:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 529f7b7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Sep 2026 08:36:50 +0000 (UTC)
Date: Tue, 1 Sep 2026 10:36:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: fix missing Ruby dependency in "documentation" job
Message-ID: <apaOk-4f9du1tQSE@pks.im>
References: <20260901-b4-pks-ci-fix-documentation-job-v1-1-a8257ee2a9a4@pks.im>
 <87pkyxwf9b.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pkyxwf9b.fsf@emacs.iotcl.com>

On Tue, Sep 01, 2026 at 10:24:32AM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Our "documentation" job has recently stopped working with the following
> > error:
> >
> >   + sudo gem install --version 1.5.8 asciidoctor
> >   + gem install --version 1.5.8 asciidoctor
> >   ./ci/install-dependencies.sh: 23: gem: not found
> >
> > The root cause of this is that we never explicitly install Ruby, and
> > consequently gem(1) isn't explicitly pulled inus, either. This used to
> 
> "inus"?

Huh. I guess this was supposed to just say "in"? Fixed locally, but I'll
refrain from sending out a new version just to fix this. Thanks!

Patrick
