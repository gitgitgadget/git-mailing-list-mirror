Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DEE13A888
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431863; cv=none; b=Im3xGuiEeVJIzR4U5Cd88nZPIBe7OYoK9UNTH4PM+rXhUgxXi2B5VglpsrEmbGVoBuOaDo+qS65Jx009hgI8KvK/o6mbVaw2PTphYAOg+nwbiyvUp6h5TYM0mMmNmVWdLV15U+HGADw+4e1mEbEf56UQYk8krpBjbtlCFfl72l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431863; c=relaxed/simple;
	bh=bOhuAmcfzILVdNTdyia/xrjZm9uY6wVfhSlyevbR4uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzqDmEBAYAgPHjhSPkvLmuJM1Y9w1FvL9ApCO2Rm46Va5BMhb2qBVZy46869ukrvDw3HCw7xGBqSMBVMYBnH12H511M8XN5uzewcDdqkYkJqkC/kgjDauvifWfQE8I9Q2lXnkkdKOIs9/bVXhpz0DlVp5deA1K22YqzworqmgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FGSRxGD9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T1LT3dXW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FGSRxGD9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T1LT3dXW"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C7D7C11402C4;
	Wed,  4 Sep 2024 02:37:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 04 Sep 2024 02:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725431855; x=1725518255; bh=7nhzAzG8yy
	+dUVGR286RWjjOieCsdVtZ3QAvscD/quQ=; b=FGSRxGD9Tg/hq/cK9VgEVGmgvo
	8qptVvTHky8bf+b4warhbHIdcTmWXp9tvEKOcgRzrj5l3fZbldYwb8freiPnmTny
	8HyLP6Lm+eCUMtUUlItO5HJj6H+DwDDIdFyuk57JxY+3b/1YUGrJZk73dDy2Vdk3
	18UTa68UeKc8szXnPkccFgy1k7xkzenrdq19bD9P5/KzvK2mvrD8K3lQfnERi2aJ
	ZzSJ9MP88OVPZ4cF1C03DP9nuv3jwQ0GHWO7Rfabc2pe0MYbGf8meqRaEam/bFj+
	Okm4tXAqQx9TygfFUevdxiyh9tKh4FcKIP+xsGg4EyUE/yGxJVhhb1sCjm3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725431855; x=1725518255; bh=7nhzAzG8yy+dUVGR286RWjjOieCs
	dVtZ3QAvscD/quQ=; b=T1LT3dXWEqXWxi6ViwdHmJYtwWpgLIvU05KI9mIxO8mz
	ENM1B25VMwokawaf3+1oaPQMqYz/bt8ppyhXZQIwO6Ro8OJBzTW45hiU3UNrvmGN
	Xgy+oiJph2siiRikA1jIG6gignqRvk08DvjKsA2toH/0TNkeCvRb4W9uw8bfMx6F
	8Hv0DjZu8JZiSMS+akl4sxSasPp6zs7ff6qrO/72Ia1Rt9DClm1Vw7OjSDmiUbDi
	ASo6IWZfXSSj9iTF4UIbjnY41hgVzYh1Br59hk3KrBhUJe0Ubgzt9n0IokBIQ7Fv
	hoePxrIB5LbXY0tHns/BAhKZ9FVNooceZ20Y1INBxQ==
X-ME-Sender: <xms:LwDYZphDSAd2G-p57OWnUUa0Sb89pZMxLnYD7aYxK45iOpry4I5BPQ>
    <xme:LwDYZuBzlW5qh7cu8Oeb60FFa-jHtMo-a4MpYjPhSUDYi5onIOIT5qHhxibR_rQC8
    BWwAGA4TpbTax2FzQ>
X-ME-Received: <xmr:LwDYZpHunWX3jUJ-4D0Iamx92eHbsZWn6-EGD7FIkZR68q2WU37h_83qzSkp5h7Dh15rTGByWGqZFL2ShWJnr9fjXrEXrNYMaejyqSX15IA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmsh
    honhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomh
    dprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    lhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LwDYZuRFJBm3sSVDcvXklfwL8v8IIvnsHd1-UAdVmahKLn9F47QflA>
    <xmx:LwDYZmxesK2gW1fhjpe-9zZC7hvChjAsYgecxTb7ggCgyiuVKMw4FQ>
    <xmx:LwDYZk7YY52I1pvZ4Oi6jT2wcaNmr8xg4YzVxe2AZ4C35RDuMD_p5g>
    <xmx:LwDYZry-XjZCpgFGalvyA5T3iO6Vc-GL55hcNaT9Hp-kkRIImwNAwA>
    <xmx:LwDYZqenJvNf6yvuOuxLpRHzZb4JS9wn4EBCNORd6XTUiJC76geIdfxx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 02:37:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7e0bb664 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 06:37:23 +0000 (UTC)
Date: Wed, 4 Sep 2024 08:37:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 11/13] t/unit-tests: convert strvec tests to use clar
Message-ID: <ZtgAJFSXn2M252ZY@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1724159966.git.ps@pks.im>
 <b3b8df048725c25b14860513b7950b158a6990ea.1724159966.git.ps@pks.im>
 <c6f13f6b-7899-4bbd-986a-9bb1649b214f@gmail.com>
 <Zta-nU4UMyrWgABW@tanuki>
 <3be1d990-9f9c-4963-bce3-742511b79022@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3be1d990-9f9c-4963-bce3-742511b79022@gmail.com>

On Tue, Sep 03, 2024 at 10:48:01AM +0100, phillip.wood123@gmail.com wrote:
> Hi Patrick
> 
> On 03/09/2024 08:45, Patrick Steinhardt wrote:
> > On Wed, Aug 28, 2024 at 02:17:05PM +0100, Phillip Wood wrote:
> > > Hi Patrick
> > > 
> > > On 20/08/2024 15:02, Patrick Steinhardt wrote:
> > > It might be a good opportunity to show the set-up and tear-down facilities
> > > in clar as well instead of repeating the initialization in each test.
> > 
> > I don't think it's a good fit here, as setup and teardown would hit the
> > system under test. I rather think they should be used in cases where you
> > e.g. always have to setup a repository for your tests.
> 
> I'm not sure I follow. I was suggesting we define test_strvec__initialize()
> to initialize a global strvec which the tests use and is then freed by
> test_strvec__cleanup() like the tests/adding.c example the clar's README.md.
> That would allow use to remove the setup and teardown from each test. As I
> understand it clar's setup/cleanup functionality is usable without setting
> up a sandbox directory for each test.

What I'm saying is that `strvec_init()` itself is part of the system
under test, so evicting that into a `__initialize()` function doesn't
quite make sense to me. If there was for example a bug somewhere in the
strvec code we might bring the global `struct strvec` into a state that
is completely unusable, and thus all subsequent tests would fail. We
could of course work around that by always zeroing out the struct, but
because of that I just don't think it's a good fit.

I rather see the usefulness of `__initialize()` in setting up auxiliary
data structures that are a dependency of the system under test, but
which are not the system under test itself.

> I'll take a look at v7 in the next few days - I suspect we're getting to the
> point where it's ready to be merged.

Thanks!
