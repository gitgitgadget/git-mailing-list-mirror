Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5BF1B1510
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640925; cv=none; b=e1REuEjafVTHOCLmtiEarjeCltLR4CoH53TVLDEZUK3By1zhB23wLuzzkZoLwsRqrGwyG1aTyWX8pbaZ+91GFxDrhegIRZuCsr11Q9C4S51CLGZrs8zvmkzVmWXcHjmatthy46vKCqDsbIQm5FwlUNc1lyv7g23eYyTQJQS1PvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640925; c=relaxed/simple;
	bh=mTQei8+JVMYcDSVfvdRrqG4TTQvKe/rh4QQv1wkxpJA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeTo3jWeuXwAbfB/FEm7xU8mKTYrWu8z/E10OhCvLWq9ud/n2fZgyldczgpXlltJOpgQUad46ZR2rFHeoxty6+509sMg2/eCnaHPN7r3JAInmp6NKzUASNMvx51IYhThxreS4ifrnFEYpxfuAOvN/4MUoLB+8CY4AZAZ1Jsnhbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rlf2VNTy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OjUlj0E+; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rlf2VNTy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OjUlj0E+"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0BB82138FCB0;
	Wed, 14 Aug 2024 09:08:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 Aug 2024 09:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723640923; x=1723727323; bh=Og3i3eu8bW
	YOpdpGv5t6kmjrn6Ju0EBNYrcONMxmcfQ=; b=Rlf2VNTyhVbNOOwVS+tKiowA2/
	9o/PU8S0bTNDEMiNjgakStcH2kAQdeiv62oE/rK9nX/SJMPlFBhASdYnBbMETu1b
	zSR2rYXLVQUFm/y5PQ/neOr1rczTu3KY0TisWXnk2AVt3tnPyDl3aYO8WEaUVdAx
	JNso/u9NulYj8jg8ym51ux1nL4QhheZ1q7Q8V9AMdNlHjXtOKAaIrqLhDhf498PA
	GXqnFuH1642o8drDKuB8pS4bYpnWz7Gf483rckENX70ij9T298X/eolNBFeLVedT
	4sxo4YtYTP6ONxxTxdpkvVMPaG4cD5m75I6tStrLmra8GlgigBeNqKqyEfSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723640923; x=1723727323; bh=Og3i3eu8bWYOpdpGv5t6kmjrn6Ju
	0EBNYrcONMxmcfQ=; b=OjUlj0E+InO9Y0Ts/2N5R6vsqhy0EGEMCOHDP5zURm7Y
	ilBeYV6bp04pvu1QVa/LWhkhyFaATOORGH+6SlvWzooWZKlTTB/8mC6Y6ghvRLlL
	+xvu3pXUZYdNvv4QJmJ/9G1+Cu2apI/E5/jxSKp8eu8WvspEippk+dRSXNgeJCyn
	H5iaC1uPm4ioyHARX+a16ioQU9JOU8LoG4q1d0RArEMB2t4t3n3pcv09bLXBnpMy
	USH3BoAyNO/Rre2yCe7HvrFr3F54DV90m/iFM3Q9Sa42mh5VJfRbQNVzk+SKW6ez
	510PvjxLuXOTj58PS3Z2aKH4bDALqweXaJR3rgptSw==
X-ME-Sender: <xms:Wqy8ZrltEPWz8KNdkivcYpaaxXxwVpyGMXEaMs26_nDyDyLTo--qEA>
    <xme:Wqy8Zu0JFff1IsMZqP7ApqtGVaLLu44nqSIcUZ2254mBPYs_1m2j1HdQ0Qau-pRVR
    tmWa1jZh3DD_V10-Q>
X-ME-Received: <xmr:Wqy8ZhqAvL4fUBU2Ge35m9RVNOKP1RFeZnab0e21JZ3gCIwfBZVhxdfCTns83ScMDc7huKNhI0Gm2cS58igqcUtrrSqrXHvNmYxTrg_zyhJwdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeehkeeffeeggedvgedvfeefheettddtffejuefflefggfeh
    feelffeljedvfeehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorh
    hgpdhrtghpthhtoheptghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:Wqy8ZjlTNXr5YFH8d60h-ropaz3uazVnYYsqyTqQ2QV0689VoDDY3A>
    <xmx:Wqy8Zp1pSVTcDLCECoMy_N7ia_hryaEX3m8MsSoGuSkw0cc7yVxEDw>
    <xmx:Wqy8Ziuix9tshheUKVHmlpwbx8CmAbk11vC55nx-szUsLcWdvypFBw>
    <xmx:Wqy8ZtU_9CvN6GKShEU8kIhEOhJLQ5ENwcZhIN5jvUwsTrTq-C828A>
    <xmx:W6y8ZkQU3Df01hupnEvHu8wxNMaeFlwdPQf0tymNvANWiizdvGIb0tZg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:08:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f300db39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:08:21 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:08:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Josh Steadmon <steadmon@google.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 1/4] t: move reftable/readwrite_test.c to the unit
 testing framework
Message-ID: <ZrysVg04x_uIdNio@tanuki>
References: <20240809111312.4401-1-chandrapratap3519@gmail.com>
 <20240813144440.4602-1-chandrapratap3519@gmail.com>
 <20240813144440.4602-2-chandrapratap3519@gmail.com>
 <2rxxfpzijfmvo65xournnmx4oawzqlhgipje4cxzxvo5aqzt6u@xppoikj262cp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2rxxfpzijfmvo65xournnmx4oawzqlhgipje4cxzxvo5aqzt6u@xppoikj262cp>

On Tue, Aug 13, 2024 at 03:33:04PM -0700, Josh Steadmon wrote:
> On 2024.08.13 20:04, Chandra Pratap wrote:
> > reftable/readwrite_test.c exercises the functions defined in
> > reftable/reader.{c,h} and reftable/writer.{c,h}. Migrate
> > reftable/readwrite_test.c to the unit testing framework. Migration
> > involves refactoring the tests to use the unit testing framework
> > instead of reftable's test framework and renaming the tests to
> > align with unit-tests' naming conventions.
> > 
> > Since some tests in reftable/readwrite_test.c use the functions
> > set_test_hash(), noop_flush() and strbuf_add_void() defined in
> > reftable/test_framework.{c,h} but these files are not #included
> > in the ported unit test, copy these functions in the new test file.
> 
> I'm assuming that eventually, reftable/test_framework (and all the rest
> of reftable/libreftable_test.a) will be removed after all the tests are
> converted to the unit test framework, is that correct? Will other tests
> need these test_framework functions? If so, I'd rather not end up with
> duplicates in each test file, even if these are small functions. Is
> there a reason why we can't link the reftable/test_framework object (or
> the whole reftable/libreftable_test.a library)?

The reason is likely that they use different infra, e.g. `EXPECT()` vs
`check()`. So instead of linking `libreftable_test.a`, I think it is
fine to duplicate the functionality in `t/unit-tests`. In not too
distant of a future we're going to get rid of everything in the reftable
tests anyway, including the `libreftable_test.a` library. So avoiding
the duplication doesn't make a ton of sense to me.

That being said, I think we should not duplicate functionality in
`t/unit-tests`. So if there is functionality used by multiple tests, we
should likely move it into a new `t/unit-tests/lib-reftable.c` file.

Patrick
