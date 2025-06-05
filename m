Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E241FC7D2
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749161209; cv=none; b=YQNqg5svtuWXhvEjns1NqmoJg09m5wo8ZLtdQYcMKERcMED77k6k/RPMtJ0yDEoK0wcGj7pE0vs/k6oeOrpHkQsM8vmZ0Yu97cl/Q3V5DPkZAavUd/ypniCAkNzga2nZyEgQR3cFl//yUcMzC/9qhFZod8NKWd/9cDN+E2HLhhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749161209; c=relaxed/simple;
	bh=ELNHga1pMJFPfB0nDAVgnxd4j4DsKoOLTgYdRsZhS2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A8DtpjWTtGRAqMouAtnLFlfgLMicqnCWyNqez+EWgknFSAvXpyUrDIceKIqgIQBg7HCd8mSFyKsn1Yv1WawXpo/q+9NWLUqPQqEiDpxVdLxLT2tv2/RbD9xlHnh81JO1UJCP0/cPQByOfbOQA6ed71WBE+LDTvEvZggbWXrceLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IBxHXamF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQ/KirK0; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IBxHXamF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQ/KirK0"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 359C9114011A;
	Thu,  5 Jun 2025 18:06:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 05 Jun 2025 18:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749161206; x=1749247606; bh=/sfBeeFkSj
	3mBT2btfuRRealhGTIdIaROHf6m/v2n/Q=; b=IBxHXamFYpmwkshhC/89l/c1Vx
	Q9hQT8b9ytoaGsN9/sY/tY/aCq0CFDRCxLKXItXAzI165bZAjc3y35j3NYa3Ae+Q
	Lg1ZGCwILWv85TciR20RHXBn/Zlw7n0C72t7WTitSa+jLZsZt7NlFMxXxfFf/Nkg
	uu3nl/+BpyiArbvVnJKBqJN3SFp+mMf6l7ePJqB0VRO6PCuOx//fqjzPsH2px6pR
	50xaphVWoieJzkg6wOp9Sa4XCRSMdNMEl99/ngdfYbSanyibCb2eJWM72u567K0a
	RHD6jOJXnbIfoqc6AI9DZwMXQEVRpT1L5NlOG5xa2DxcPhXrCpU+WqgxgCBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749161206; x=1749247606; bh=/sfBeeFkSj3mBT2btfuRRealhGTIdIaROHf
	6m/v2n/Q=; b=VQ/KirK0pEfLTDegNKLCCZMBrXOjLtroMevm31Pfyc24Je1Yg2Y
	pBi0sqn8ey0UIpImEZMrI1LDfCa5qYtElxDj+kjXolO0r0aj/2LW0nVqYcrQEo1X
	PqHwlfPjwzWbSzVsGxNWsjASp7WnV7Acxfpl2Ob195rhuFJgU2LkdxzohMc99Gv4
	EJ+T3D8MzS2imWJ9Ak1m4i80Esoq2OgsQBwrRefBq2poI2FWWCQ3wb0xbGVy37v/
	2armJyYkRPMpL/h6YhAv1lsO4ApKbBj8u4oggdeVoh/X5jdZGO814hV/uygpZOrs
	JZZVi9BhVv+EKsXPNSc7+94aRkqJXwSMtbQ==
X-ME-Sender: <xms:9RRCaDki6UtFo-eUyJ7jh1-3kKOm96G1ATzJxgDCFrj5xZ8t83_Dkg>
    <xme:9RRCaG3khAl7PYqK4o0uoIkrCRdrRFBBcRZlBiucd8TaX9mcmwEgR1eJSWwqVFIoZ
    9dByOowvAr0QSNjcA>
X-ME-Received: <xmr:9RRCaJqIq4Sxcr6kJA8mzxjUyEp946MJS98AYXNmdVEq0yQYTdvCgjKe_Z5vC5NcBHSeTkeKyBbjuzWbmDyMy7PUxm87Q35_OKcE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghkvghrse
    hnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9RRCaLnxnljg_l5D7hxlx7nmZsVUIr4yN_rtp0RYEgjL-80ApaCTpQ>
    <xmx:9RRCaB3mqAlHIvK8IvCBwlOTxjXZ3alK-v3bQ-6KtX34PKqsd8_sTA>
    <xmx:9RRCaKukSqXT7UrQAmKpsIcZ_zfKzNRLdlxUEPYaENzq1mfLEVlr2g>
    <xmx:9RRCaFVQ-_qw7xCs9p_tcoPodObXXwjLtdfg9VAAyfv_kU8cNa3KBw>
    <xmx:9hRCaH8tdtYOna9b8nAoXNcBRqVB9hJStVsz5ns1umsoUKPGY9te9O5R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 18:06:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Johannes Sixt'" <j6t@kdbg.org>,  "'Patrick Steinhardt'" <ps@pks.im>,
  <git@vger.kernel.org>,  "'Todd Zullinger'" <tmz@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.50.0-rc1 - Test Failed
In-Reply-To: <014f01dbd663$0ef73530$2ce59f90$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Thu, 5 Jun 2025 17:44:41 -0400")
References: <xmqqsekgn4gk.fsf@gitster.g>
	<007a01dbd4d7$89ebf100$9dc3d300$@nexbridge.com>
	<007d01dbd4d9$356ded70$a049c850$@nexbridge.com>
	<aEBPdFXpIca7lMls@teonanacatl.net> <xmqqjz5rcz90.fsf@gitster.g>
	<44fe8627-5680-443d-bf02-a6e85afd46b4@kdbg.org>
	<010b01dbd5f1$3c26ec20$b474c460$@nexbridge.com>
	<aEFb0Sjj0Xuu-t7l@pks.im>
	<014201dbd658$4da75680$e8f60380$@nexbridge.com>
	<f2ed8920-347d-45d3-a0bb-df94ece0d9df@kdbg.org>
	<014f01dbd663$0ef73530$2ce59f90$@nexbridge.com>
Date: Thu, 05 Jun 2025 15:06:44 -0700
Message-ID: <xmqq7c1p7si3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> Can I pass this in via command line? Instead of modifying config.mak?

    make NO_TCLTK=NoThanks

just like you are passing V=1 on the command line of "make" in your
earlier message.  That would not build or install gitk and git-gui.

By the way, I do not think writing into config.mak qualifies as
"modifying", as we do not ship one ourselves.

