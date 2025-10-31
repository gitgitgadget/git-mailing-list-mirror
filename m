Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786062E7BAA
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891075; cv=none; b=uCLMkD6xWOLldf6HXcCpt8fyBvfqG2/CAW9EULiaKKfBHVwTlqzg0KIeWhSnMCHZCkczxPrAmdtzT/Ucd9RwCo6M8zt8iDeFmkvzJrYCbBgKNPVbUQZzG/Bz0xObIsdrNFN0qxiENysYI4ysfRcIbQygqyiyTfDF19uRD8/jU34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891075; c=relaxed/simple;
	bh=KNH4mxpSBnXFsJmVAQaE2yXgkO/1+M0rslEdLrJyRFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcKne5pfZpU5uOwzJjrAffqBoi0qraG6PgpbX5K7hlpVkRjXte8+3Mm46m8rvd0Ttchz/kjLuachrckNfs/MwzinIYwIGCcq86B3g3wZXvCtHchA843qvOMWXZCPPzlZlnCxe6qIBHOHF5ISQXCIzdj+vK1T+JrMEXHJgrP5urQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UX9nhS5k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E39X1Cak; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UX9nhS5k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E39X1Cak"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 67BCAEC0246;
	Fri, 31 Oct 2025 02:11:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 31 Oct 2025 02:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761891071; x=1761977471; bh=zt9mZuOm6O
	PE3oJAi5sjvvgTcCmQ8VTCo5ObKgsTuqc=; b=UX9nhS5km1H6KxI2JPtIl6z7dG
	YKrX554rUHCFZOcGycXo37OOxI6yHhgDEyaR2IrAdMUZMzRua4Dn1IWyX0iT5uEX
	QyPr085QfvotRqRDSvdk/y5T9hry7DnlDieCM2FEJrjXJHVOZjxDdPUMKsxnG8vb
	YqohK59kbGfz0aF0hC7HZ0SgxFo1wyg8hsaRgTHoe/+x1OkpdNeyABt3gEir0nyI
	wdvuXpSHRgZsrFYjqc4kY/qxKFmNFQ7bzVQVuHw3CJt25OF/C4ZevncoPawlTjY3
	rLcgyoIGFGyRJidn7bfD4UWXnbJs9SKJ+XGOUlgqqy53ggzdhxE4HjBRYy/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761891071; x=1761977471; bh=zt9mZuOm6OPE3oJAi5sjvvgTcCmQ8VTCo5O
	bKgsTuqc=; b=E39X1Cakp+F1jXT5zlY6B0aItEFU2pILvUwO1MBPV5DyfduyKGz
	p0uCrcSCf4dphGiJ1zgoLuyhVNvOyqVmpxvehugew5Orb22o0evNAvsVEOZLoLBL
	mfCudO6vyGrJPCMqSqXpx1yXT8H/v0073nx3LsRJthJdCRgJlqxOzVQADRxRV0CM
	JDICI5qBb8JqSnLX7lFwVdCfhEkGzM4wlaMdzd93+GyjfATjPy8goYKcVpRH1jX/
	+otx9WXBKC9owVMYH0NIcI132DkLzwQVKGMxzRlctjSp3WwqlhSoANMeyJdctEFo
	JkRKTyzwdgJOeLYfq1+Za3880bMmdqbDpbg==
X-ME-Sender: <xms:_1IEaZEWzeDNXQkIXrXvglmTRq5Qcevqp3ON6eb6A7ktMwrCvIkWyg>
    <xme:_1IEaUWB2F31zweYBOn23fLFEgA0BaV-DKKwuGyjOmNRW5XW3MHb9NPSful4CB_xu
    4Gqv1SEWpyj9TuMR_66knO70Ducdi2J2BnKrQKgFMAl3qr-LZh7GA>
X-ME-Received: <xmr:_1IEaYz-N69AiKFtQ1l77JJ5vkLkYAQHWXc_2kqUSHNDtlmiV3gp_b3AdeqAUfdESrMWf7Zfar38BhszDhpdU6Ji04mcJ8pjxnn531hs-D2xOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_1IEaaNycyLF1l3KTx8BV1WM0HOrPFfvORBpBjm4fCyYK7YzPFnSwQ>
    <xmx:_1IEaR6_MFY_VhDA9VX4i82JJYP2BaBL_VTNIstVUgtnHP17T7YBbg>
    <xmx:_1IEaTM_tk8vAg4Xy4xdGnJdSW8XhlaoQ7lHfdsTDc1xKc-2DXIaUQ>
    <xmx:_1IEaXlt-QUi9LTPYqsEQVznXsEZHN6slOkE5jnHzsn3SGwg4wfvAA>
    <xmx:_1IEaZ1SfzU05wqM8V937BBpP6hHfN1xCrusWJs_BThlLmV2Ba6H9DFI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:11:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b4e4ad01 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:11:08 +0000 (UTC)
Date: Fri, 31 Oct 2025 07:11:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/13] object-file: introduce `struct odb_loose_source`
Message-ID: <aQRS-KcNLD9prRYa@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
 <20251024-b4-pks-odb-loose-backend-v1-5-1a4202273c38@pks.im>
 <CAOLa=ZQdit7N0aQWyqYHAoO6nuXaU3QqZbQmsbp52jW8C-zbzA@mail.gmail.com>
 <aQNMwve9sUP-QDN6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQNMwve9sUP-QDN6@pks.im>

On Thu, Oct 30, 2025 at 12:32:21PM +0100, Patrick Steinhardt wrote:
> On Thu, Oct 30, 2025 at 03:47:58AM -0700, Karthik Nayak wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > Currently, all state that relates to loose objects is held directly by
> > > the `struct odb_source`. Introduce a new `struct odb_loose_source` to
> > > hold the state instead so that it is entirely self-contained.
> > >
> > 
> > I wonder if the naming should instead be `struct obd_source_loose` that
> > way other backends (if added) would be something like:
> > 
> >     struct obd_source_loose
> >     struct obd_source_postgres
> >     struct obd_source_mongo
> > 
> > This is easier to read and also for autocompletion it leads nicely into
> > the 'obd_source_...' namespace.
> 
> Hm, I see your point. I think that "loose source" flows a bit more
> natural, but I agree that the above is more accessible in code.
> 
> Before I change this: does anybody else have an opinion here?

I think for now I'll stick to the current naming. This is due to two
reasons:

  - As said, I think this flows more naturally in language. When talking
    about this you'll say "I'm using the files source" or "I'm using the
    whatever source".

  - It somewhat matches the naming we have in the reference backends,
    where we have `struct reftable_backend` and `struct files_backend`.

That being said I don't feel very strong about this. So I'll post v2
with the current naming, but if either you or somebody else feels
strongly that this should be adjusted I'm happy to adapt.

Thanks!

Patrick
