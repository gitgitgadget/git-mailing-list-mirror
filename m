Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D9115381A
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981709; cv=none; b=UInVsx67jg/0pjS3PFhauqlSMSQA/McANiX3J1DlCqbkWKzyQiV/wtWy+rND8Bx6Yw8L2VQ/3Vh+EGUIq7bE7Tr0ZaUK4acrKU4T6tgoBPh2udGZurLbp/O4h49PE3iRLejt/Z+POjaqZ1pOLX3Ax2ieaoEESvffXbO79JZGDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981709; c=relaxed/simple;
	bh=g1vnHDL5FaQfgEte+ediP2n3+XKUL+ra8tRwXvdLtOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKu5UxgKwqk1SaHSnpTxNKYQGvWaH2Uc0AtF3B+uMDcv2tK28F2NMVcamWBAGyDNaPlIRjhdntdruiDBeczB9waQ0XZV0VQDtejOjI4sMzbfH5xufYpfsx0pGTkOZn59IxNq6Yyld3VJMcyggDF7N3k3O/7u4c1L0dDQ91M5k/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OSlTf/YY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZDQdauM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OSlTf/YY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZDQdauM"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 605BA11401DD;
	Wed, 26 Mar 2025 05:35:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 26 Mar 2025 05:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742981705;
	 x=1743068105; bh=U5PlMcM2kWZ3DtSjyZ30gl+PJ+t8tJ52NJF7OHGsr1k=; b=
	OSlTf/YYR8XbaELP8RD7vF4lu/D/blJEm4DYCYybFdGaPxW5QtvJ+4NvB4PZhJDi
	3bWS8+FK3L0pfC9heh9fDUa8EVxdDHZbF+nd8s8qxUIgs2WcSw9xswpOUNuJphIC
	xARW+q6WjnQY0n4u0plPs6GCZ2aUhT7zxPTnosYfVER9MkZwqimUq9wU5IKt86JD
	qnWv3iTDEacGfDJLyHREzqKzqsYj1IQcxjOGIVZgzU83ggJEfydz1mLDnntr0zTb
	Orhh8jrFwkTJoBKvqlVm2t7YNOoA4OHcYujMxvjcw0e/w35fy445+l1pU0wtWpxP
	rze3I353l+ixhjyOs21IIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742981705; x=
	1743068105; bh=U5PlMcM2kWZ3DtSjyZ30gl+PJ+t8tJ52NJF7OHGsr1k=; b=h
	ZDQdauMA0WADJTG8j0teoe/cYjbAZIJ3sfYQ0JfQcuEj6Cn8AGFEA/Q6f1YXSns6
	H1YAtip0WD3z8RtQmDAV4yMMEnNrvzAvxI7l+c0izSDArp/zUA1oCmt3Fyg70xmC
	f/+qF5qIkhb9vNX6v/Fy73tqvUbCF8H874l55dFy9oCaKPloMftNfozdQh7iQLju
	+2udZIxXSSNUCwdC32XKHLE8+SjYaW2dBlawF1ysnCR8ln+TsYYpaqjT6mo8DVx+
	T3OGF89Z2Y9V8AEpCB+oNHcSi9Rnz/dMqV93NA/MmvJZ+sBiSebnITkoEZyGmIR8
	s0pnxmH2GV7PGnNOaeblg==
X-ME-Sender: <xms:ScrjZ79ZaVQmYJwCEOYCbkTKtdID_I0CKhzfyIHhEll6haGuxiX1rw>
    <xme:ScrjZ3vshj2522ad7QI1osknvt1iQwvhle70c9zkW7H_7F4UhKKdvE6iX2pLGCQTa
    Nm7KlHOda9uy1IBYw>
X-ME-Received: <xmr:ScrjZ5CKrQ3CRo_-10Z3Pad7E4VdhXVvhghpaJXIRm-wr_FX5nrv4e4fr2C8PKZ_kc9j6iT6x_TRhFMVw6D73IkRHcioWRhcbNCx6ApDww3mOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopeguthgrthgrrhhi
    nhhovhefsehgrghtvggthhdrvgguuhdprhgtphhtthhopegthhhrihhsthhirghnrdgtoh
    huuggvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ScrjZ3fLBJ-maFQunnAQ-Yc1vh3T1YTsyZlmPKN0unP3d_gt5XXuxQ>
    <xmx:ScrjZwNQzwOhhHOB9CcXBe0ITznqfyq4qBQ7re1lD0n1UClaqG6JTw>
    <xmx:ScrjZ5lf0r7nBHtffaZFjXQaqiCdcaLCQVpopFOVq30E9_lXWkhAYg>
    <xmx:ScrjZ6u7H4OaBSVLmi4OPQLOqdeU2qYNnedw2YFRlTyyxjS7Pk-Tbw>
    <xmx:ScrjZ8CsbDek7so-qE_IwCYgFQhV4MB6zGJlkVzYKNFb3R8cctCMvQJj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 05:35:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d06afae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Mar 2025 09:35:01 +0000 (UTC)
Date: Wed, 26 Mar 2025 10:34:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "Tatarinov, Daniil" <dtatarinov3@gatech.edu>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"karthik.188@gmail.com" <karthik.188@gmail.com>,
	"shejialuo@gmail.com" <shejialuo@gmail.com>,
	"christian.couder@gmail.com" <christian.couder@gmail.com>,
	"shyamthakkar001@gmail.com" <shyamthakkar001@gmail.com>
Subject: Re: GSoC 2025 Proposal
Message-ID: <Z-PKQNd2yI0ZaoIv@pks.im>
References: <PH0PR07MB91768A0AE333B30ADB1D39E087A72@PH0PR07MB9176.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR07MB91768A0AE333B30ADB1D39E087A72@PH0PR07MB9176.namprd07.prod.outlook.com>

Hi Daniil,

On Tue, Mar 25, 2025 at 04:30:33PM +0000, Tatarinov, Daniil wrote:
> Hello!
> 
> My name is Daniil and I am a CS freshman at Georgia Tech. I prepared
> the following proposal for the following project "Refactoring in order
> to reduce Git’s global state" that I'll attach to this email. I would
> like you to give me a feedback and critique on my proposal and just
> express your opinion if I'll be able to complete it.

Thank you for your interest! It would be great if you could send the
proposal as plain text in an email. This would allow people to access
it more readily and provide inline feedback to your proposal, similar to
how we'd normally review a patch on the mailing list.

Thanks!

Patrick
