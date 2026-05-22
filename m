Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BB39BFF5
	for <git@vger.kernel.org>; Fri, 22 May 2026 06:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779429797; cv=none; b=dn0Vg/CQDzoU1p8JxVuCHEpEpOHwIzeep8ON2ESeFe7F6CHDitela7hpoIooWmGT5LdR1j+n6/I3q8W/V/EmK95m3NP9s/aLLStL8NkrkC3TDMphVTvXFInYrDNyr6bPRK/6zfT7a9K2Y9ZVz/iynwBr1bvgWyvmQPrHQ45ggRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779429797; c=relaxed/simple;
	bh=SqoJdawRgjEiHEftOShwUqm1A2OhJ6vWq+832ARaN9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q12mOikCw79ehFwLig7vqwZstsqPHYc4YcZa4meBeYkdOUwc7cmtW5+wfpsXCdvVxDdsDe2aGCogKkuXdbM4x8jGG7MD1PUy9O5eevSj4XYfQBebxypoBip2md20WsovasCc2mzAcuCMzp16PTAVulCo166Ot7JtQRHFvzZ/UXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z3NRmfPG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I91bHvHi; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z3NRmfPG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I91bHvHi"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9986C7A0071;
	Fri, 22 May 2026 02:03:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 22 May 2026 02:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779429795; x=1779516195; bh=ifM54xc7hO
	eCM8iFy4/l9yXUPlYR3Sh/DMEjeWtNPXc=; b=Z3NRmfPG8ApWMHoV+NqXFU9WaN
	aI2UTxvp0HREOVQRu3m+RLAKWDeOEbN/h4EUY6d8KtnY7C2IJCaRuPUaiUH/qAL4
	AcTGBNNA50/EVcTWPDUaRGqtwNhQgmexB5xdO03iOjYOnAN9Hn/4yBdXoVlgkNqw
	1Cp5Z4NZKEOM/R+dvvbof2592D4ylYJbpY15tPki1EXQLVPJAH2yiJlTZjHG9BgL
	VzQbjc4WW1nHwrJNwBNKQRG4ObnXMxfBNKj0LWbMdX3gYrcFmVr4WnqtPwSqUTkZ
	2ibACcnOLdb2munyoJiHzNg5Y7GQYBdtcBYKnQ/IMMzmC4Kb5vqmXGal6uqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779429795; x=1779516195; bh=ifM54xc7hOeCM8iFy4/l9yXUPlYR3Sh/DME
	jeWtNPXc=; b=I91bHvHiYkPhJICVaqE+Eh/TzpQOW1qBoPb09klhFVPm7rcrkMC
	+Q8HJssL7Rub7kYrdOJrcFuO5ADt7vJyEZE4r3bcrf10xiXbOIazJ6FBaumQOsH4
	63cyIrNbiDnXb3UzllOwRinsE/BHd/LNDN85dfO+xtLjh4IXAbJLL3UM7h9+w7JV
	REeQfv+7ZjR2NT6jnPYWns0G3sW21Oi66ZDMXiu3GD4CHaU49xIAC7BAktc4prpb
	YJw7XZVtSvM9yEJmAI5COeCOyoE79C2Q43sBXOJie2LNSBI+/wkLas1nMNaF6ZDT
	0Yoi8CyQgdvfGD+dixhiZP4T+wNIzBUcxsQ==
X-ME-Sender: <xms:o_EPah7f37jbetP36vLNO3zzLon984C5cZ6BkAPX2-KasiWhZVaF_g>
    <xme:o_EPak6TAmaPFrjfLKasc7pxACRSG2js8uN1OOr-x1s_xfAlAYOQ3BhZNXxVEOjAY
    JBf31Z_I_Li3hg1wZ7uktUol_4Hp9_64kIclfsJjhJIrZ4MwfkK>
X-ME-Received: <xmr:o_EPamHCoWOs9JpNkMLcr2wIHVN6bzfB00gtunUHcaIOMcOz2CVicr0EwPwzquH75oMIV4uja8XpuyibxunflEbV-c9h_DSJKRCij3UV-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:o_EPalQyyTdshSBPEtP2UE1rH1d-YzCoYs39ckZGqDH1P8aiRRkdWw>
    <xmx:o_EPantjGKs8FTwUkzJRvoHWldY1XZWZymP25EVxgTP8C64MSbbvMQ>
    <xmx:o_EPaszIvr9gn3IksO_6GbFAWJ08lKJ0XI_e-qNB5a99hw7sg1bvLQ>
    <xmx:o_EPap55R-wnDMuUfUi_EqTq1qCpWpKPGl_vSlTu-tHAqAthItLHpw>
    <xmx:o_EPalTUWIeaDAjOMWRQFn3pKc4r5NUx0_eGGThzla9wbJzD88shFSOo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 02:03:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 996bbbcb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 May 2026 06:03:14 +0000 (UTC)
Date: Fri, 22 May 2026 08:03:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] setup: construct object database in
 `apply_repository_format()`
Message-ID: <ag_xoMnclzss3N4o@pks.im>
References: <20260521-b4-pks-setup-centralize-odb-creation-v1-0-f130d2a7e8ae@pks.im>
 <20260521-b4-pks-setup-centralize-odb-creation-v1-8-f130d2a7e8ae@pks.im>
 <xmqq4ik0zls3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ik0zls3.fsf@gitster.g>

On Fri, May 22, 2026 at 02:59:24AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > With the preceding changes we now always construct the repository's
> > object database before applying the repository format. Remove this
> > duplication by constructing it in `apply_repository_format()` instead.
> >
> > Note that we create the object database _after_ having set up the
> > repository's hash algorithm, but _before_ setting the compat hash
> > algorithm. This is intentional:
> >
> >   - Constructing the object database may require knowledge of its
> >     intended object format.
> >
> >   - Setting up the compatibility hash requires the object database to be
> >     initialized already, because we immediately read the loose object
> >     map.
> >
> > The first point is sensible, the second maybe a little less so. Ideally,
> > it should be the responsibility of the object database itself to
> > initialize any data structures required for the compatibility hash. But
> > this would require further changes, so this is kept as-is for now.
> 
> Yeah, I guess it is a good place to stop, instead of solving the
> chicken-and-egg problem in one go.
> 
> > Further note that this requires us to move handling of the environment
> > variables GIT_OBJECT_DIRECTORY and GIT_ALTERNATE_OBJECT_DIRECTORIES into
> > the repository format, as well. This allows the caller more flexibility
> > around whether or not those environment variables are being honored, as
> > we do do want to respect them in "setup.c", but not in "repository.c".
> 
> It seems that we really really really want to do so ;-).  "do do
> want to" -> "do want to" or even "want to", perhaps.

Fixed locally, thanks! :)

Patrick
