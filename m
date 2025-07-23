Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337C41C27
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 04:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753243487; cv=none; b=VLZ6onsfr4oXvflxEq9sktRGAiESw76CuNYnNZJ400POPy1s++oA+O3P8Zcc0xHP2S8ilRSXoW56gg1i6bqRA1C7z/XyyyCM0njUVClPtraheB5NI5Y0/J4YVbCT0W/VsnAxOFnn8oJTCBl0GnpMFay7yERHIe+N2V0Us8BS2zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753243487; c=relaxed/simple;
	bh=HxdDq3IZxIVM1cvly6F+/p/3EN516zvjmoIUM2Pb/dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2GJB2ByvInepeRx1RezPLyAgwWIaxdpoRODIjGebt1qTaNWKOPy3IcSS4cJKXzMgkzCDVHrfBbcDwunry4++IZ3xRq6AC2M/y5nvYF77gEoRhbVfQYeJXZyyAluJylVtusBhKmC2eDAhme7ltoPgd5G7iLyx5IbcN1wuuMWRpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mok0DHQm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RKG4lDfj; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mok0DHQm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RKG4lDfj"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E6CC7A001E;
	Wed, 23 Jul 2025 00:04:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 23 Jul 2025 00:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753243483; x=1753329883; bh=PvG6OkUIe2
	c8p6z7tbZoRvGEKDgCl7c1lQqiCi+PuPU=; b=mok0DHQmWRQVw1SsiaQLJY/pkp
	jMSQIhdfhW056EIk4lGv1Md+Z7wOtraP89o7Vvnv51nXluNd7UmtaU2l2cfo5bDz
	5Ulhapp1LaFT1cQNAUHE35WouYU/MHJQawaofUBn+U/4L3M0eu+vnsBGD0q63Jwl
	IVikauH9rBuYLIPs+wvBrmmGCGasJDHgJBqv2D/uCAeZWAbzDa1bMNgWSPlyb6En
	3VDDvbCbL9fDwyCvCiyurop8elrX30McAIguoaAXKbNYajj3N6LdNsuaALuzIydP
	UE32jLWrbPZwhFsfIscqIpi5GGtg5ydJqdIgOYmLukedpLrBlaqThl7dp2dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753243483; x=1753329883; bh=PvG6OkUIe2c8p6z7tbZoRvGEKDgCl7c1lQq
	iCi+PuPU=; b=RKG4lDfjpOR+Jbz/uLmbuwxQIfHIyiXi+B08htm7gD9Wki2fe/x
	jkPo2Wqr+Ppf4E+TWEYV1dUkjXm15HCPtJ8ayjHlkgJVmMtjfdOtk/Lbr19d+Fjx
	g57u0Uh4KO8SjQ4HINk4QTDdmYBtYhvXNjwRYk+GqsXe3iYFBFAHy/AjxB+uEApf
	cwg2yzhoYBFipz5Bx59R3ekYOKnQJHZueraXxSt+0gVEvHcTBmVkwOxBs1Kplk93
	zVxp+IoYS74bADuLaK4kdFeepQQrNBj3/d/5pWEJylNcW1AVzqfUlir0fusRCJ+0
	KodjDZ36BuxIM7DRewmhT0yoEhvLTrZsUqA==
X-ME-Sender: <xms:W1-AaC3VMu28gZ_9EAEFz0kJRjHzFpM6hKKvM21lt4YKIQLXLkkj8A>
    <xme:W1-AaIU6JWphobqa9OIzQQC3NvH4a_PmX-JH0aNG_Mr8J7kmcyYPNl-HwAdrS8JF0
    APc-RqdPM8cjcUFVA>
X-ME-Received: <xmr:W1-AaEXs09VqzIE8PkmptYexGStwZy5IQDzn5sPU1fKq-9Cyq-94xmzKymuRuzVBDtJ6eVun6bFVy5IIIsdwDhlqH-UFM1-TshcUj55i4BKm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejieejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:W1-AaPcSf4H22V_5DAArDqqvQj2L6Wo2onP_mztwXuuNhREy1YajTA>
    <xmx:W1-AaFV-agZAdV2nnAHab8LXpLZPzaBQT6tXpoQVzjU1zY61cMloOw>
    <xmx:W1-AaAcyBwOFF3aduLzq8UD79mHBN57PuHTbr71ts6tffCwe8JBL4w>
    <xmx:W1-AaJNXpVQCcNSXS3sfOvHAbWW1vKQtJubk84v_EnAZ03u5PlX5Sg>
    <xmx:W1-AaE8nFfAJ6C74-stZxLtk7XHbouo-CN6rHX9_P4PHZZ-pMEznlziw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 00:04:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0b188679 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 04:04:41 +0000 (UTC)
Date: Wed, 23 Jul 2025 06:04:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 8/8] refs: fix invalid old object IDs when migrating
 reflogs
Message-ID: <aIBfVgOqZNrcpmh_@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-8-183e5949de16@pks.im>
 <xmqqfrenri7m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrenri7m.fsf@gitster.g>

On Tue, Jul 22, 2025 at 03:09:17PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +print_all_reflog_entries () {
> > +	repo=$1 &&
> > +	test-tool -C "$repo" ref-store main for-each-reflog >reflogs &&
> > +	cat reflogs | while read reflog
> > +	do
> > +		echo "REFLOG: $reflog" &&
> > +		test-tool -C "$repo" ref-store main for-each-reflog-ent "$reflog" ||
> > +		return 1
> > +	done
> 
> Let's not cat a single file into a pipe.  What is on the downstream
> side of such a pipe is always prepared to read from its standard
> input.  I.e.
> 
> 	test-tool ... >reflogs &&
> 	while read reflog
> 	do
> 		...
> 	done <reflogs

Ah, makes sense. Will queue the change locally and send it out with the
next version. Thanks!

Patrick
