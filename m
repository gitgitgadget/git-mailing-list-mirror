Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D6A20E6FF
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743070773; cv=none; b=hVo44dHu4H2mgL900ZEpdADg42uRd/UPrXQ+Zi7ihkI/q6r1UPRZJg409pA+mhe3YLUxjIReWNA2eqXyZrBvgivWOctlM1p+mIoQnFqx+yHDqgxEvztlZFTeatLr0jefMYUC/ZJTVIHPgXgublQOkEc+/IuEB+v6sclUlTMwhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743070773; c=relaxed/simple;
	bh=fILJf1U5Fi0Trn6O3pZQLkAG0buoQsgGvjyrcKAdFHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrFF9xCGLHlvj7INBMMlJsCqHyMcDUk0lgIQftpeiigbGaf6cHthN4LpB37ndtqggYDJrTXxPFWb+13ouKfPkxjN7KlQqCQ+EEIPX+gVAve+QgIhaVTFAWpcc/i9OqmLpzBwK2hnQf7xsU4Dys1p6IXF3TpCLbrrswVz7wPzE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AWRx1m2y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jdmkS0uy; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AWRx1m2y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jdmkS0uy"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4DFF1140127;
	Thu, 27 Mar 2025 06:19:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 27 Mar 2025 06:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743070770; x=1743157170; bh=wC5qGvK12M
	qcqJmX8NqWXAwIpmHmPgTBpEMuDs1ru0M=; b=AWRx1m2yCvUNRQQj6HqQeJkr9K
	kdGHqa/xt4YyJJJWqVS4RxxCx0i091z+nVHG1ePUcK+u9LGNJLLQHTmWVvLz11tP
	DJxF1Jqpa/u9fuUIZQem/aRyg4BcrJJ/B3EQ4uZ08kNM2YNbJF6EFkxb5ytyIBvf
	nYVf2Kk8OVHWA0xRsa/bNJYOkQ7GNaVt0QFc80wjdYaBdC8asRWLUcG1yidOgyoM
	NcY/T4Z7EV5716yv9QRFqd5FeyTpksZgUP43MDaqzdVzxsc18844qZAz9A/EPlpo
	XYHKRkPuTLqXpG33aHtkNpj8u131YhZCqEM255Ik88Ij2ireH3PDcuZ2Uo1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743070770; x=1743157170; bh=wC5qGvK12MqcqJmX8NqWXAwIpmHmPgTBpEM
	uDs1ru0M=; b=jdmkS0uyYPyGX8K9jYABg8QSnIDOAhnPu/8QvS2P/mlQ8biID/w
	qPV+aKTbWp0NJc9j8cIGS4+RBxLpxfy4iKBP79P9TF35DwoYAm3anVbey90ZGPnd
	Ist3IwuPqqIbi9ulWcvS4YlpCbM7jMcC8QiGq40e27OgvI4o3DWERSq8PJ0pcBka
	QwAZ1PTMguZ6siQZ+1ZRtO9rRdrT6GwqP1fHnG7q1FD4uOrq5IJ1aEi91KEuYD73
	+0glAVHI8gNOT2RPaYuGEWX/MFVFJKpko9Ja6RBccmDn6mc65iYbXPpwpro+6jDC
	zi4aRAqXP6aZdIpGQWkkNxP1OAtDSFiGh1A==
X-ME-Sender: <xms:MSblZwxt4YxoRSEYYvoafw-8vMEDMv0GVt1wWPmKMtmo2k3m1LDoPw>
    <xme:MSblZ0RS-rrZr8yRcrJBndYWKGk5uSyRrXHbKuSpiWpHH--CT0-BXQJ4xpdtU2w1A
    f8XWMUIbfMSpB9PaA>
X-ME-Received: <xmr:MSblZyV3jkjkK9Covz_hjDSJM7WFLKpbVRAyYE8YjegMiv_Q0ImqsyEJueETpiYLdS7voFvHK9-OIgtG6FEZ4E6X6E89BXQ-VyHPNUyR7a09wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhu
    khdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:MSblZ-hksxQpsa3QuxFlSrDNUKMjlfo85AtM2T8xd3WANZ-CLe1w1Q>
    <xmx:MSblZyArLm9A7p1KW6sT8GLZbKj7OI1Uu8VyL3JkRJPIdd-RKrUezg>
    <xmx:MSblZ_K4zdN2XW1EkBA9CMC0xMiC1pL4j_Z6OFWH4iaf_VPxrY_Szg>
    <xmx:MSblZ5C8dtBl3SnEnI-Bkx11hDdH5Fp8dWCuJ9sFCnjHb-iGoouKKg>
    <xmx:MiblZ55BqoR7WwSC77W-jYFrrzsyyUTuTwXt3cZNOXFLhUWfJNm-CNIe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:19:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b6fff723 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:19:26 +0000 (UTC)
Date: Thu, 27 Mar 2025 11:19:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 11/20] t: refactor tests depending on Perl
 substitution operator
Message-ID: <Z-UmLWcMgW2f9970@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
 <20250325-b4-pks-t-perlless-v2-11-4b87b8072670@pks.im>
 <198d1d40-ea1f-4362-821c-2cc621892e4e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <198d1d40-ea1f-4362-821c-2cc621892e4e@gmail.com>

On Tue, Mar 25, 2025 at 02:35:52PM +0000, Phillip Wood wrote:
> Hi Patrick
> 
> On 25/03/2025 13:14, Patrick Steinhardt wrote:
> >   broken_c_unquote () {
> > -	"$PERL_PATH" -pe 's/^"//; s/\\//; s/"$//; tr/\n/\0/' "$@"
> > +	sed -e 's/^"//' -e 's/\\//' -e 's/"$//' "$1" | tr '\n' '\0'
> >   }
> >   broken_c_unquote_verbose () {
> > -	"$PERL_PATH" -pe 's/	"/	/; s/\\//; s/"$//; tr/:\t\n/\0/' "$@"
> > +	sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' "$1" | tr ':\t\n' '\000'
> >   }
> 
> Thanks for removing the redirection here, unfortunately there are still a
> whole bunch of needless input redirections below.

Fair. I've scanned through all commits now and replaced every use of
such redirects. Will send out that version soonish.

Patrick
