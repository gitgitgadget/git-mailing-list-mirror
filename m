Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0D0193090
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520515; cv=none; b=Og8N2GW4eg51BTMx6LLmtCwD7CsFTRsohNREbk3kcvJqrtQQL1E331wqKLfDEF6T/ZwByDcw4PSnMxgOpESOJCGiy4p5x3sfPVUwg9iUMRjSSv6ea170255ob1sXzz95omrUgmBZW1Bycsh/CqeuzUzV3e0LtETx+n0b0PT2vNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520515; c=relaxed/simple;
	bh=odzhgdyYYpb6apS/YQky+ydSy4CEIdQuOzjlg8ttqC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iw1Oq8WkvfnfzBbbU+5FismT9IHkHdTkE9gvb9mmXiE+aLZTrKwOi3my89RKGCCBEm9vLjmusnjc9DrSTruvkBqiCGdlw41Ij9ZYBxyPLEI83gkzrWCIt/7Yca5pUOTG+aqlf89GFTGkneCDzzy7+tYCgJNX3jjySXXvtO4K17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h8wfQzAQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4G6oRGf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h8wfQzAQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4G6oRGf"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7210C13801E2;
	Thu,  5 Sep 2024 03:15:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 05 Sep 2024 03:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725520513; x=1725606913; bh=2vPi9p8hIU
	zZU9uw24Xi7jHcMhgqcNr0uRX3Cc95K9s=; b=h8wfQzAQMh88TB8cV45n+xgUSQ
	k30RkOkTJg3daUXZX0Sc1jJXnRrQsurxHHTUuq/UTmzm7rrNffU4eyE23fIbNGL4
	0AFADY4JuF0j/tTdQ2ty6ZC8UjNwBNRu0wacnqY3B6Dxsf//sxlIRo4ogjlOGP4+
	msedpx9D/XMm0UxO/e1fWrVUFFpoZNTNMnT7+DjWNMD8eoEJITze2+hJ/thOHYKw
	3BljG8NGNRdEgsh0Jhnzm1oLmWJsqMRXhzGS8b8WoxN/kAOxWyMEFSW5uMP6lyXX
	YzEgHp6xMIkbuLOLwdS4PDvu+2aOK4LQ5my3364uL2dQUlf1JUU93z5Nd4Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725520513; x=1725606913; bh=2vPi9p8hIUzZU9uw24Xi7jHcMhgq
	cNr0uRX3Cc95K9s=; b=B4G6oRGfHF+77UW+Fb6vPisdUf1txdzMi72BbLTBkcSU
	mASEdbqmZsAyZHLgJYjNLlMpdNzNQ+TbVS7Syj03LDIw5SxEUhP23dIlC9/JaAac
	tENgSuihYBl7dZcT+vfCHPMcHNQJGZ++iNMStRxx6S2g6gDNAzA6fd3aouIPP4gb
	/4m2/AnJKCVT/8z0yoOkA3b4P1vMzLsttw8zjyBkztgHyEYUzf5osJoLhZIOFsEB
	M1zEm6FEMrPddcmB63TH5n7Yw1yIDOkkuvxTUPqxq2Nmz9MReKADUYfbHhotpY+3
	xWZpkHykbW+QtgsNoUnEvJeyNPNVkwDNNm0ly7N1eQ==
X-ME-Sender: <xms:gVrZZssy8Qa2WbbF7ovgeUMP4MGxCW15HgxDG9WU4IXnK0jOgIBDKA>
    <xme:gVrZZpceb82vQk2o2t-DCwusQYoZK3g_sgONyVu3-PpFMM5E26xUG5cdrClUAZJyS
    cvGDI6BYYOhu_VBlQ>
X-ME-Received: <xmr:gVrZZnwIYGrCm0pN_fZCVI3hXtLVAOUogzyuQDQ93qvdESnfXHzPb0Ds4BEX2OMvD5GAmvGudGU-PJ16K_0iveyhiIOiNiqn8ksbdfcTeKfjMSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehkedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtoheptghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gVrZZvNwtjFxNFTBcfe65et4HUc1e9-YiJnyhubPnpIXZQoLHn4i-A>
    <xmx:gVrZZs8tcCo8CaXkNwBv1xFXfHpOTQyo1M1IwzQWjKCBDTG2kJzgIQ>
    <xmx:gVrZZnUXphh0UP8xJNRZHGDFmbJ77PPvDtLtltfLof28hXSlojAmSQ>
    <xmx:gVrZZlesREDTJhARYXkDbpEI37X2e_HDyw48jGSGIqN4X85Y-V5pvQ>
    <xmx:gVrZZgbPaDaVmliVWFYNNcnKAI3zlsRpYoGwf_YpZXSlmPpneiWyLQBF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 03:15:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9cf4f06a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 07:15:01 +0000 (UTC)
Date: Thu, 5 Sep 2024 09:15:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 1/6] t: move reftable/stack_test.c to the unit testing
 framework
Message-ID: <ZtlafDnM-geVUTQ9@pks.im>
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-2-chandrapratap3519@gmail.com>
 <xmqqmskn9w3o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmskn9w3o.fsf@gitster.g>

On Wed, Sep 04, 2024 at 10:17:47AM -0700, Junio C Hamano wrote:
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
> 
> >  int cmd__reftable(int argc, const char **argv)
> >  {
> >  	/* test from simple to complex. */
> > -	stack_test_main(argc, argv);
> >  	return 0;
> >  }
> 
> This makes cmd__reftable() a no-op.
> 
> Even though you cannot remove t/helpter/test-reftable.c, as it
> contains the implementation for "test-tool dump-reftable", we should
> at least be able to do something like this.

In addition to Junio's patch you can also remove
"reftable/reftable-tests.h".

Patrick
