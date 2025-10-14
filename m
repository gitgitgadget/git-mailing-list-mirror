Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9F92BEC27
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 05:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421253; cv=none; b=Ct9uqeNcR1yXGIIstTsrjL7O1dTRymByizbJjAh48p/HnsEedvoqbkSOPG7bUf0i66SBzt57VTycUdclsXRnrwy80+4lNmpfyMbCHFKVWaFZ/uPDALJoUR8uXSHEMNpqL76beS5ex6aozGfLqGZ0RQUnsQDkEhGgeIYjtN4C2io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421253; c=relaxed/simple;
	bh=Fb/0xWsM/0NlypFpcNauJpb6GxEvLDYmDrygcILtSlg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZzbcl5ZUPwm+hQiysiEsVsGIV/seU2HJAg50WQgm9ibrA7TYXN17jQHfUxvY8AG8F5ngko4MhRXI720JhM3MWijtArgdVUKrCX7t7KnaGJOZVeJCuZVRufidmNNy2hPB5bGMqCGW8DUuKCLfhZExnrxvRT+N19xOPatVHsUirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D3vsDSCw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AqL79HiP; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D3vsDSCw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AqL79HiP"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D2CC7A0078;
	Tue, 14 Oct 2025 01:54:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 14 Oct 2025 01:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760421246; x=1760507646; bh=cyWRpNIsv/
	4WB6k7iQb4kzffPkqOto9ckRrUc08PH4U=; b=D3vsDSCwgvTUaL/JKwMMLZ/D2o
	ZvKq1s+pBMShCM/KoVNjvy6EW25YSdklfehS1qpApWhV/aGFoATgjKkveDQcXrlV
	lGmVtqj0Uf+nhQo18oEvowpzosv8YN14N+APjAgzJQdfjJ2dbb9FiEj80Q6BljR3
	1Ifb+R6AoeSwOxYn64HXLF5w+poABymq2PAZ9u5oZKyB5GspSPCMOG8hj64UKNYk
	bvtly9HSJl4Oauo/BcHvBxjMqS0VXYj1zIT9FzaVCeq31iG5UMkkdGDri8YSTpcd
	3brBTineztFLVEnqCqyjWNuYoKYATeXtFvZFKfIqbyVMlTc6ymwOXwiQddVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760421246; x=1760507646; bh=cyWRpNIsv/4WB6k7iQb4kzffPkqOto9ckRr
	Uc08PH4U=; b=AqL79HiPo/cT8Xo2OeMBfGkNN1V0SlkSxWnolDYqaf988MnOJ6n
	4IltcTam5x5bDgrFisd8I2UYrbqUb6Xi6N8CNj4u/CYtbYa3zvQ7P3mzmkeAuhzj
	KNN1ohOjooDV05RzGM+qvAkSjSMpHPwh2xFYCd19RvGi7aUIm/zZZGaiYoencU+F
	q0oenpyddMEKjiew4gs4K2zH7MVtcF1IQI3x9kbM6ZpA97hbI/V0msiHdx0Kq2U5
	jvF6MlgbbpaIdtzOuPtsdnfJE5glyW6m1UYkB0fs0cxkDo+ogrA++oH+NL9O4AK2
	WIeoFxveGsd8MQHGtH9UDZC6kx6jVD5AdMw==
X-ME-Sender: <xms:feXtaE8F3AUOB20PWWHtv0AtkT4l67Ik1xoKDrbelxiznYWwxdC9XA>
    <xme:feXtaEI0GUQE2-Nwf9tvW3Q1AbNiM72gF651DcsrLUDwwL8Y3bbP2nS7BhA-jc6KZ
    Db4yrg_6l2-ahVwsqH1JI7Lf7b4OuDhfoU77-kVVZZEp6r83ncMMQ>
X-ME-Received: <xmr:feXtaHaUBEEgFGjAHhYMU-sAN3dvEDyI_DGaU7O_GN3M6uI1ijDcjU3aFt6Prjl1YnOi_htjh9FV5JZUtLBwkzWlc7UsFJrAYh53wBQceQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeljeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvdegvdeffeehtedttdffjeeuff
    elgffgheefleffleejvdefheeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:feXtaOK95-WX1rCCMAjZBvsJuMoK-Y7n-O2AKbeTvCHJ64AsSUP2WA>
    <xmx:feXtaNBg_ooG0cGJ0rliy_RV-juMKV7rY5lhS-2MDAbVS1g0LzR2Kw>
    <xmx:feXtaLqZm2Py0iHzOjsODxSArlm-TSBCdzon0puu_KCcXQT0KTuGXg>
    <xmx:feXtaAiaqKbXvSgAIU217NOppA_AqopBcvTzUrTpT75cZa1TpJhf7A>
    <xmx:fuXtaO0yiNazHPVx__KtpWJOp98xaFUeCVs8F9iTC0cnvZErYcBkRj4Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 01:54:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9c1f9f0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 14 Oct 2025 05:54:03 +0000 (UTC)
Date: Tue, 14 Oct 2025 07:53:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/9] SHA-1/SHA-256 interoperability, part 1
Message-ID: <aO3ld4kz4Ru-OP7r@pks.im>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20251009215626.3089287-1-sandals@crustytoothpaste.net>
 <xmqqzf9u3jug.fsf@gitster.g>
 <aO0qJwFQfSXsi7lA@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO0qJwFQfSXsi7lA@fruit.crustytoothpaste.net>

On Mon, Oct 13, 2025 at 04:34:47PM +0000, brian m. carlson wrote:
> On 2025-10-13 at 15:24:55, Junio C Hamano wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > 
> > > brian m. carlson (9):
> > >   docs: update pack index v3 format
> > >   docs: update offset order for pack index v3
> > >   docs: reflect actual double signature for tags
> > >   docs: improve ambiguous areas of pack format documentation
> > >   docs: add documentation for loose objects
> > >   rev-parse: allow printing compatibility hash
> > >   fsck: consider gpgsig headers expected in tags
> > >   t: allow specifying compatibility hash
> > >   t1010: use BROKEN_OBJECTS prerequisite
> > 
> > The topic has been quiet ovre the weekend.  Shall I mark it for
> > 'next' now?
> 
> Yes, I think it's ready.  The only difference between v2 and v3 was your
> comment on the text and there were no other comments.
> 
> Of course, if Patrick or anyone else would like more time to review, I'm
> happy to wait.

I just had another read through the series and am happy with this
version. Thanks!

Patrick
