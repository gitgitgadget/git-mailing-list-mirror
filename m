Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C36E21E3AF
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 05:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729141473; cv=none; b=jf7P/uGF317Q5VvnD9eJq6iXzSodBm6ioj4Q9pQva1ha4S05xzAe/qM2CBb6hkCFu1fmjzs6TrCaOCy9F2jqEj/K8UeWuwZh6aXtOMpOllMwsi/C5mqvW2vFPn7tnMc1E5jPy0vByK+9QaeF5xAuvMAJOu/cuK1wuEqU31MY/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729141473; c=relaxed/simple;
	bh=of/vQvr0YBdPvcIl6R9Ysy+jWZZHvsHCXfqA4aJIW7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EynekBOiHM2rZEAOGDBgMpY56PrzYgI2Ikq4w4TRBDSCzsMM3LMkCTphshG8tH5x057twcm33BYhwHcI/iLwI0Y2nNA6NDvI1IhAyLwoBb9tl0z8dCZi+GcFAzMoEL/ruYfME2NT5Vqg/QtKAoX9G03k37sNyNQwiMwRMjvW6+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qZbzNsCY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TGwOUYfI; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qZbzNsCY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TGwOUYfI"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 48C5E13802BC;
	Thu, 17 Oct 2024 01:04:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 17 Oct 2024 01:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729141470;
	 x=1729227870; bh=m2wUkGORqLK9X0yTSUGSFdpIj16F06Rfcx8FrEqz1S0=; b=
	qZbzNsCYG2HPxpW9+A966XjfOSCMX3Zj7qna/aJKujOP+y8fxVdy1V6lUiHnZAe1
	vZtlrb4FksvxSqVqjJkYQ8iIsG11gw+D/LbCR3M3z1JP0Ic/Q+CDe1thHDX7lQVF
	OaIhWWAbUyNt960/c6fUyCc1Y4bjPFbSK6VsftuowMbzHZyUKp1VbtEHCM9vo8Gd
	9Y34IiB7C64W5SCL9QfavvADBQzkOAka/R6nd/y0RpfQ9Bo7vJ/14PGZ8VKAM70g
	ss7+cBFMsbc5yGSK1CGjUlJr9Ag0HBOJ7vmYngJ8N9eU3YRUHiAjVUHWP5QdbVQ2
	HUZzl+mZy9SeSGpP0d8gkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729141470; x=
	1729227870; bh=m2wUkGORqLK9X0yTSUGSFdpIj16F06Rfcx8FrEqz1S0=; b=T
	GwOUYfIKWdfhkjXUeKHEumABvrlVVIPQuMLkFj0XGKNs8a6PyUDur3P1gZ9DlGqr
	Ks3YTZoQ1/oz4nxlY7j3Jg7ycqeaU28PNBDI9M0l3YwWwf73uMtg2pe5ZKI3+YFp
	8tYFm4CMl4wKVdna0cg6/8BBEwlJr+1IS7mDy4GIk61ygF7yrDPY15cTdEUh4H6g
	C738vVLYeSSM1vdACkAJhmYXJBhjYDql0FdobgbPM/sClOcwY8nqM/KgK20ZNqF1
	vuPrazkucsoX+AmukAPEgLyPElRPNuM2luhDkKY4lBk7Q41edZjJ+bp/4Y5ODI06
	HHRF0JsbyABJ7BxmLqo9g==
X-ME-Sender: <xms:3poQZ7e8o_T4AuEtlpZCLjBsEnCz9vDsOwOryhnRh9tJZ3hxbWrprA>
    <xme:3poQZxPg7TfwO_hEquJzEaeM3pSSrqtxULG8n39jWtQvaY4a22eSTld1i8UXvGNYj
    adw-vjZWLHX2TvDvQ>
X-ME-Received: <xmr:3poQZ0jSfYoKWpV95n6u59LNvzDfzrGwQEevLOxV4M7-jF5q_KFNR5pUdQd-XB80av58zi0Q8RzHGOrKsDZ-kOyZp7t_4QWVYvz__7x10oKmIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhm
X-ME-Proxy: <xmx:3poQZ8-kwpFAzu70p5LhnY_evItqROV1U6tK14wp1n6SMuPsj6DVlA>
    <xmx:3poQZ3vqCZ1TvJQTQmSIE8-zaS5zEdNJYWlUmj3ThgNc-g4jpJoMWg>
    <xmx:3poQZ7H0LRogL9XKI3eXzNwKPCp_GPqv6Lkd9pH-0-Y8tRduIjThxw>
    <xmx:3poQZ-PGMfNxrRD5NXsLzk_wToM_zv7PFnN2C-58_wid8cr26m1FDg>
    <xmx:3poQZw6se2wLXjCy67Re5MgXblD4M-ZpaOBgL1UQZzgUtS7t5IGBQAe0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 01:04:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 95ad5b8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 05:03:09 +0000 (UTC)
Date: Thu, 17 Oct 2024 07:04:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH v2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <ZxCa2X7bo5JFelRu@pks.im>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241015114826.715158-1-wolf@oriole.systems>
 <Zw9P90_QtiAAH3yz@pks.im>
 <gtdjnvonjodr435wuv2pofnww2pdcd33s22xxz5ypwkpvdythc@vrajz5ttkjbz>
 <Zw9_46fbvbGhjmYw@pks.im>
 <yxfpbmwy5bhtjwmffzrfoagugs4rsxw7wn2cvve5ygzcnlolpu@lhjgpz4riogd>
 <ZxALiDHkkq4yIP8R@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxALiDHkkq4yIP8R@nand.local>

On Wed, Oct 16, 2024 at 02:52:56PM -0400, Taylor Blau wrote:
> On Wed, Oct 16, 2024 at 11:07:02AM +0200, Wolfgang Müller wrote:
> > On 2024-10-16 10:57, Patrick Steinhardt wrote:
> > > Given that we do set `log.abbrev` I think we should be hitting code
> > > paths in git-shortlog(1) that use it. `git shortlog --format=%h` for
> > > example would use `log.abbrev`, wouldn't it? It would be nice to figure
> > > out whether this can be made to misbehave based on which object hash we
> > > have in the input.
> >
> > I did try this, but like I said, --format seems not supported when
> > git-shortlog(1) is reading from stdin. It always outputs the same
> > summary format, either grouped on authors or committers. This is not
> > explicitly documented anywhere - the manual only says that "git shortlog
> > will output a summary of the log read from standard input" and then goes
> > on to document all the options with no mention of a difference in
> > behaviour when reading from stdin. So I'm still not entirely convinced
> > that this is impossible to trigger (also given the complexity of the
> > argument parsing machinery), but I have not been able to find a way.
> 
> Yeah, I think this is correct. For the purposes of this series, I think
> that what Woflgang has done is sufficient on the testing front.
> 
> As a nice piece of #leftoverbits, it would be appreciated to have a
> patch that amends git-shortlog(1) to indicate that '--format' is ignored
> when reading input from stdin.

Yeah, I'm happy with the in-depth explanation that he gave and am fine
with not adding a test.

Patrick
