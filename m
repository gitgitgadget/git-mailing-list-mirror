Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEAD78C60
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727723475; cv=none; b=hQBHUaI6wB+H0AFcxmnQbsU8qRIRgr8Coliq2XTGyT/kM7NHSuoiC9OybI8dWozjkegGlQzoW3xDeidcVprmzpjV7lGUUXnfnhOWRBO0NS1Cs0Wo2NJbNwexfrRbwsS0RdhN+ERz4jVQqLUsthsuxx/NPEI33ll3i063NiCb8rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727723475; c=relaxed/simple;
	bh=IQLMA6aZdSHFUNSaiUgYyiFpzLzixQEk8TR9hsU/qAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QtpSPa0j6oqrJQ5FuOGwYHfDQtTNRLyH7R5rsw1nc8lvjYQepSc+honVAj844DGUUXIUgHc1luQUpOIg6rTa6bzRxZfC5kvB6s5TdmgTLWlYQSAcaqwJz3vlPzJA2MbH2XtO5qIklbKDGgbwFoVlghfJGOjxsGL1zVOJ4o9BiFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=An1yMQQK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xza7DVcq; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="An1yMQQK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xza7DVcq"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 11897114005F;
	Mon, 30 Sep 2024 15:11:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 30 Sep 2024 15:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727723473; x=1727809873; bh=IQLMA6aZdS
	HFUNSaiUgYyiFpzLzixQEk8TR9hsU/qAU=; b=An1yMQQKUQUCbeORY6tDBkEs3d
	u+yyOoVZeJUsruyzUVnalAqb5UxQv7oBOH/QubqM39svYG9AR371aBAfDJ4ycUGo
	2V89Sz8/WH0/2cEDvypnwTajYHUnE4fzMmt4piacawpdv7PD1/J0QVVSLFeQYiN4
	EYTlL3q9sQuivRQJywC7GmEh2Zi+Ejdyrd9xdKISWMZnHmf0hxYDl44V6G4oupbj
	2gxTX6HvLmZ9nVGvWKR4aIVp2Ptp3F3bnhsAsIISvojE/AnBa9DTdZOSZtS7DXLr
	vU4CoThEvgD+m7+T4tU7eZPZMzvIqhS1NkHz41sKoazA/QhUypX0naz49Z9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727723473; x=1727809873; bh=IQLMA6aZdSHFUNSaiUgYyiFpzLzi
	xQEk8TR9hsU/qAU=; b=Xza7DVcqZMhILViDFF2pn0Mrm+Mu8sw9MtPQ2B9+6VYx
	ZrF3XUV6l4h93zb/7ZcGq5KEH94Wee28F0JO8D9EgxFC0F3Tw+wm3BpYbgSnsYQ5
	e/q3NJPqe14v4HG+Bvc5dFq7J0nA+wouXdLSX0VY3ZzlVvLif1FYy7CWMR/7HIvY
	OLYtvBaYFoTOwlzJkIokp4H45EYl0rUHGXzeeOjjllZj+0aWuLXOPmMl3eoQazce
	umMCypAe/t7k95H2p67X2jiaOlariX0bRvx/SdoiCUDMuAJryhe/BHMx2GFRP/yP
	J3lFh8Rcj0lzD1O5HdOWebSNSmi0cwGCsQTinE21pA==
X-ME-Sender: <xms:0Pf6Zt-hAePKsH484yMHjNH4nnh36SgCrbSvsrIAcnNI_SsMwzp_qw>
    <xme:0Pf6ZhtiqgKJCPSnRNUM2a4yFYRIRNR7C874S3pN6Td7d3xqfP7FrlZ8Ma5PRZxXf
    dzyCa6q7eIn6P06Ag>
X-ME-Received: <xmr:0Pf6ZrBf9Ah7tdmXje8vZ3aRgFSCTTauVz2frrKJ7Ndf_x4z7K3cHf6UjY8rf85_QqWuwCHfFOQsaz5wxU_nZZZCEcJEbqvZiCqB7XE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrh
    guthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:0Pf6ZhdKKHm1_XVte9w5MCUA_1iexi9uk3oZQPi6DISpHWW54dI5fA>
    <xmx:0Pf6ZiP6L0RccP3XaMxnPVrxY9g4DDewDM1iVKPEBhe6nHb55QDLow>
    <xmx:0Pf6ZjmPU5YDzk79xpKY4sgkcYvdZezCIH1DLnKsSm1vngzMe-_F0g>
    <xmx:0Pf6ZsvCav1t7JhRY3YkPXy_24i0ZyawqhP5nOtTKuoY81bwrHG-4A>
    <xmx:0ff6Zp1PiCOCal_QYkMPbBo2a8EOhFzFZx-vVlL6AfgTW-C0PHIQ9DMM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 15:11:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org,
  Edward Thomson
 <ethomson@edwardthomson.com>
Subject: Re: [PATCH v3 09/22] reftable/writer: handle allocation failures in
 `reftable_new_writer()`
In-Reply-To: <Zvrsd5JQr8RAhSaN@pks.im> (Patrick Steinhardt's message of "Mon,
	30 Sep 2024 20:22:47 +0200")
References: <cover.1726489647.git.ps@pks.im> <cover.1727680272.git.ps@pks.im>
	<9edd1d84cdbd53d966ff5cfe9b75281dd5966b07.1727680272.git.ps@pks.im>
	<64253c71-915d-4862-8fa2-555ca2fc63cc@web.de>
	<Zvrsd5JQr8RAhSaN@pks.im>
Date: Mon, 30 Sep 2024 12:11:11 -0700
Message-ID: <xmqqed516jow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Perhaps ban free(3), strdup(3) etc. at the end of reftable/basics.h,
>> banned.h style?
>
> Ugh. I was relying too much on your review having mentioned all cases,
> but I really should've double-checked the other patches, too. Mind you,
> I really don't mean to blame you here, I blame myself.
>
> In any case, banning these functions via "reftable/basics.h" certainly
> seems like a good idea. It's just too easy to screw up by accident. Will
> fix tomorrow.

Sounds like a good plan to do the banned.h-style annotations.

Thanks.
