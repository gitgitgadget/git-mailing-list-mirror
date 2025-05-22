Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB4F270564
	for <git@vger.kernel.org>; Thu, 22 May 2025 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952807; cv=none; b=W2fk9APyh2QAp2mhXdFVZI6JtLWdDrV63ysdPOCxu25UhbK7YsZTb2VwqTecJD4WUu0u2H1CpcLiF9QbTMI5s15Fdajn5UlIyYvqqZDsfpGf9vWFWNpvMLwqMVvDNkS80iysMky9cdUAFfTWaoEtj6Osh2rvfjIZK69iauJ4Rss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952807; c=relaxed/simple;
	bh=cPGdCSxJm6cW2HCYta57RE6ZlyHFMh/A7T1F9iNIcfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nuLaPtN83u3ORyL83FxeoA1QrgXwym6xw0F26jW7g+lhfWa9csDvz13ju9FpE13NONTDKupznmrKo8bdfBtSao4s3dR4TnrR4PEa6g9oDmMRacX/GAcS2ARsLpL0ikJBJJIoFoevlYt0Bjj68SKXUsfZGxm5hkwkr6/ksNIhDDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LSx8oh2q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vHD245ux; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LSx8oh2q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vHD245ux"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 275E225400E8;
	Thu, 22 May 2025 18:26:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 22 May 2025 18:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747952804; x=1748039204; bh=X+xQTr3HkF
	sFrKWLoCg+IRKWliWcn6TQW9jfc4vp3Hg=; b=LSx8oh2qKGmEtI8w1S18oykj5D
	hnupFOsN8rs2aWysjEsMpidOoak204XOHfIz8LHn44MPhIQB7jjgWOPIAQL0IRS6
	Mk9ap2dQao81iMgs/bvEWc/qkTu2HXohqaPD1LkFnnSPN8EoIVzTAbQecUqw3jTX
	0C6rYHG4XppfU31w2JTylzcHijDMW/qWz5+9aK8p07U1duknkF5qomQJPNSc7egU
	+NQC2GFrMxdOI7Rc4tJcvRysQeh8iHLDLwd5j2a265WrMrUOyskcUulGs/nYk2zV
	MWG13AelgHhGWUHEchNJbmV237ueAgWSkfb/CXSP73GDAUlTOb0heZFzns9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747952804; x=1748039204; bh=X+xQTr3HkFsFrKWLoCg+IRKWliWcn6TQW9j
	fc4vp3Hg=; b=vHD245uxiBglAd5r/lz35o0ma/hQdYE8H2D+m1fq2/eGbf8eM/U
	PKUtXWaCNiHdQUnNUfR7dCYT77zoxi2Jhq1oZOlj0Yw7uZOObjkEPe2fPEBk3Lcq
	VbChcgplhfdKncFL7h7Osv4W63IiitMBqXl3hLOMdhQFkjw2Tq+99HjtcMxo3nsU
	BW2BVlZ8eV2AHSmZ7kTA17W0ebMP0LsCmK6H8v8jfZlBKmjUdjxAPq80tnEE78gQ
	zvGPTV+aHdb/BZNEZxZqIMQ3gIXH/nYpGknUlP/nfQxdULqVWu+hSFWJ9M19CboX
	/HJP9E8clXO0r7GKQn/U5Lh/p/vhk6aPMFQ==
X-ME-Sender: <xms:o6QvaE-UCnJexNGarowNB7vhnwRiojjcg9HrzCCO4gb5ss5XHH8VVw>
    <xme:o6QvaMs7ipLIuOLSLOnDESjwrFIZ6A9YMxYVj9E42aa-17z5U48Xh51toDcfXVQKb
    I5GOPJ1anDRGPn19g>
X-ME-Received: <xmr:o6QvaKAvGLfblW5DEHCDWmL6P2vbGrZZX5XdBLH7uHmmrgFfXl_R0C4NkahBrVTMkCxC0MC_A1VTshHyMeynvbL9qZ2g99bW_inmHxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejudeiucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefl
    uhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffg
    fedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepihgusehjohgvhihhrdhnrghmvgdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:o6QvaEdzeZwo_snbQwy1zwEM5_Lga29ybeXrcLHct0KZR3axhpzD5A>
    <xmx:o6QvaJOj_9BWpaftLdfmQl6tO2eM_r5CZ1zx15mm1XSNVnVEIKUrVQ>
    <xmx:o6QvaOlTOXB9x1RCegR_CFxXQXZrJ8GWlspo4KP4VtANew_NlcRw3Q>
    <xmx:o6QvaLuhNSXelPRvtJgTKI-WHwEwdHvRKGqy0Fsgx68nfFlLaXaH4A>
    <xmx:o6QvaJNFcXVZvC42RRnA-gR9j_8GaNyHUB4O7NS9v05TGqf6ry7JNSxe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 18:26:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Joey Hess <id@joeyh.name>,  git@vger.kernel.org
Subject: Re: buggy smudge/clean of empty files
In-Reply-To: <20250522221523.GA21347@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 22 May 2025 18:15:23 -0400")
References: <aC90kn2mE93DCJEH@kitenet.net>
	<20250522221523.GA21347@coredump.intra.peff.net>
Date: Thu, 22 May 2025 15:26:42 -0700
Message-ID: <xmqqr00g2sf1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So I dunno. I'm hoping somebody more familiar with the index and/or
> clean/smudge conversions can show a better way.

My initial reaction was "well, do not do it then---an emptyness
smudges to and cleans to an emptyness and that is either by design,
or is a known limitation of the design of smudge/clean".  

If somebody can show a clean way to lift that assumption buried deep
inside the design, that would indeed be nice ;-)

Thanks.
