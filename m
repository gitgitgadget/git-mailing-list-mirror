Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570E01F1312
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735295664; cv=none; b=oqHRdgkqxZYwmvV74STM6g961pO6Y16tTzfwRDHhAZ9HztpxJ9jk1cUTw5Z4j83alr5qQiI4qU9MKsFIMr8/y7NwYIazjEPW0f+YGM6i4hwkxUGwnrzwPIxdo1ascOh9B+Vh0UPVocd2XLV3CiMXZgj8MGrtv8QcvuEr5E7upF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735295664; c=relaxed/simple;
	bh=iQnCWPQqiheQEZGDiq1cXm8J7ZVHK0szg1cxP1pEElg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONSVvUCeFzZyM+LVHhqziDvaVHCnS7dRLITezjgXI4UZuwQ0Mm/fjL73W/bQcr4lHJzU8AGOcADzwDbCTKkEcS92I8xls8Zd2KqpumYQxXn8xjELAORIMmyEfnHBFFpecMW3s4fkMOtuUQCJnW9Wj2brht5/OQNzKRMcx/cCp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UTqn5nDz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CwCJReKD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UTqn5nDz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CwCJReKD"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 555A113801C4;
	Fri, 27 Dec 2024 05:34:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 27 Dec 2024 05:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735295662;
	 x=1735382062; bh=oD9EMuFo2zaVJgdsaFjnfDAoWUVUVdMeaYxiz36uYmw=; b=
	UTqn5nDzgslnfuhv3Sc6e/7W09Dc+yKwkmlQu5MdCd4WlnOWyH6FZGGfK4njHuDA
	z8cZ3j27/CPaY7/SETk4BgSEvtsuAKmQwkO56+oPVBOkoHZoUz10VUXwRvsfyA1r
	PB7Y2A1IA41FLq7zXGqPNfonKG/nSdEkz2rQiedhflM0zQOzIMQ+XGk9gynzi/sq
	c4VYd20r/gHYjbCm8et8zeHHSFTRsk0UvqILTe9UaF5fuxleQHXs+Wlpymy9yH4N
	kOOax759DhxOb4t+JvUxHmiVcaRDvOxwXesDFU1FsqVHZ9lC6Aw9IVMvbeyog0gk
	eJCaqogu/pzRK6WPiOpFYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735295662; x=
	1735382062; bh=oD9EMuFo2zaVJgdsaFjnfDAoWUVUVdMeaYxiz36uYmw=; b=C
	wCJReKDOpbEhq5ONKh9DYiln7T0R6+xKme7I0TbEtLbev+MpLCDIHzDGmbUxtlax
	WITJ341iK3j/QqpfHtNx3T8LIDtiRl5280FvvVadSPy5gEob009qRxiKU+gdd63O
	vr/wI0a1boyw1IEVsk6H60U6iIGDxSmTpTter2+79WPmMLKQl9zmPcG8c9LFqPlk
	3xpJxQJTTYEaKap0kzwbC/F0r4Fs4cUkF4ALeRTH8d7qNfpT9jhp1EKmG+ZGZxhz
	ASoa6XXsvE6QIX473psC6C/UQjkw1kYUlhUu1dcsimRgtN/2MW454/IcC1Rx+qMk
	+EBfWleaZaTlQ3WLIyj7A==
X-ME-Sender: <xms:roJuZ_f0tt6yH0oIMfDFBzqZPlWlb7y1Wf7Ad2_h6URu--GUUHHWhQ>
    <xme:roJuZ1NTpoHAK_mbJqR34_W_IrS7VPVT3s21OfMYLyaEXj25vAxCtLaVJSxVzLVeR
    FAEFmame_OHCs965Q>
X-ME-Received: <xmr:roJuZ4hkkmTNDZPfnRkkhpMsokM8sIQu5-ISAl9ncSqtBlRxDH7At2C7Wa-CiYD5zpHL4pOP0nLoVyZa1xrtECTnqVsmR448Nsl7BQH1y9UunA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:roJuZw9q6jrX2QF35Pauz_8DvuoGui4oThXVQELDiCWJ0GwE5bs1yA>
    <xmx:roJuZ7tmMLWbVl0E9eZnlp7IgMx76YjSG6WNnH0Ad6ex43NZh6_s0Q>
    <xmx:roJuZ_FbMgG06oll1z6g9a_KtTsdNLDzOEN3M5JdBsJcmO5fB0WU3w>
    <xmx:roJuZyM91fMAIldB5dImr4PkcKdi5-HqqV58-KpCiRlTdss471VGqg>
    <xmx:roJuZ7LuFU08l8fVj-JhHX39kIG6LQPG1LqSZ7N7A-tCwSGQXbKG4ahp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:34:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36b8f7a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:32:17 +0000 (UTC)
Date: Fri, 27 Dec 2024 11:34:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] t-reftable-merged: check realloc errors
Message-ID: <Z26CmZEMQeqGFuEs@pks.im>
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
 <6084c017-9557-478b-b485-a1c1a21842e7@web.de>
 <xmqqplldvfsk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqplldvfsk.fsf@gitster.g>

On Thu, Dec 26, 2024 at 09:46:51PM -0800, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
> > Report reallocation errors in unit tests, like everywhere else.
> 
> OK.  That's good for consistency if anything else.
> 
> We have a test framework for doing unit test at such low level, yet
> we cannot really write tests that validates that the right thing
> happens when a particular realloc() call returns NULL, which feels
> somewhat disappointing, but that is not a fault of this series.

In the context of the reftable library we can because we've got
pluggable allocators. We could in theory swap them out against variants
that fail, but it's not easy to make them fail in one specific code
path. For the case at hand though it would work alright.

Patrick
