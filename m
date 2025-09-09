Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E891A262A
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 06:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398150; cv=none; b=KMrKKpgBJRtpbeY8B5qZZJ790DAZbyLasv/vioT2Ib1sx/zlvvyQEedA7jFSDwgKMzFSXU8UeTQNMSsoMLHb4Hzbe+yzyAAq8adtvbh3wQqvFP7qQc+3cM4pvxs/qW3dVcF7cbpIemYwXUpGQMOP/4xolC4sO8CpgWC99Rnox1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398150; c=relaxed/simple;
	bh=HzX0Xl+9vnvb3wPK2qOhorD27WZQHZQ+8VSJsbjOFR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fimpbahj3I7PtQX2szVxk4HwPA6VzNPS5o7VIBKbnnM/kYSBnEuxEMkt9xBw0KLY3F+SG1Y6iUOrSU1gUCl37t1ZPro1UX183jwjAz7haS2x17OYxekNPiYN2eU6Oqx+gW2ModJgm6oh2bgL91dlKHdVllEwT6+jV1+TxZqQObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KoL4iFNS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z1/YxVDT; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KoL4iFNS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z1/YxVDT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AEC5DEC021D;
	Tue,  9 Sep 2025 02:09:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 09 Sep 2025 02:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757398147; x=1757484547; bh=HnRWtLKlkI
	uNirD+8+3iXR7q4QNMcB6MgisL1juXnBA=; b=KoL4iFNSV9Yb9xgw/cUtPkmksw
	17r3wOIrGAZ+IBUP6mm0MsRwHbxENBCnwpTOw6KQhk6Ec/NZT9CZnaRKPjXs47rD
	KtS/Ogo1LO2D9aREYDMLEYP5atp4h+riA59Yu/onZUjnIPLLbQNN9tfQAhKRTWjP
	knieeinKwBNd0UJS5zeyAznbvB22MlOG0HRha0m8n91XaSn7F3bg5wC2Kg6CxG+E
	BB1H+SlDUPx/0tZUQmqcGk81RcASqUY9gdI++KGYP6V9LUiuxfstoe9Ko9lru2r1
	Tb1xg7eEXmkQy0aIsFdRR9xvfMbCTky8hvfiSlpnu7WSv6tV7JVm4brPQg/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757398147; x=1757484547; bh=HnRWtLKlkIuNirD+8+3iXR7q4QNMcB6Mgis
	L1juXnBA=; b=Z1/YxVDTbAdkn1YIZh8hXvnIX7ttlh7hnYE17DGYWN6+UZx9DP1
	4BaNwnHyD/Hd3cB7u69G1vZcfnPWUrOqHL2eN7TjAEG4E4SeVQE1wQrnYuUHzyYw
	1xHJ8i7sjXIDlaCbZesvpqReINkEcUJm/Q4AnkVMooZi4NxpY9U6XLzEY3dIm64+
	r5DpT2JU0JNW11T74zLG/TfrYfXYAjZ/nk6YEBWLOMsJCW/+cfpVqlx/5ueC+5el
	BsumjmoIjK/O1cIrkftIzczWCoce8aRxxmRJkUtq+CDJ70WUryNrynaYLbdiwX+I
	IaoLVuGM6QoIUMrsSEvzXwTCfU00SUPHF6w==
X-ME-Sender: <xms:g8S_aP31_utpJnKu2pUY0Gl3LiT0jXa52ba-knUTHRDLRewF_Xy-qA>
    <xme:g8S_aE-GLSIagAjjioPXbvKr19CgVHe_u6EQLEzgPjrLZ5kB4iuQpDJcCcz4EAI4d
    EbQhUppg3c-R2LOQA>
X-ME-Received: <xmr:g8S_aM2qctGW49QCTVLM8PMNnl7VaIqrWMyvyAVySNAZdEAeMzhIH6h2Gk2MBaO95Ev3H4jfngrjAnwvhotYWoIKZFDRvSGf07Nw2z8bnNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehishgrrggtohhstggrrheslhhivhgvrdgtohhmrdgr
    uh
X-ME-Proxy: <xmx:g8S_aB_xFdz1bLmaTlMiZwrXvyfHtvWAnVEfa9yeN8oUy4zvzbcdiQ>
    <xmx:g8S_aMtEvPllygH4zMUYQNnADLCZpNUdhl0b8WYEbUsEtyyDDGSNKw>
    <xmx:g8S_aEC6BV6WTaUkTBnPxnWAenAvxJul6vztjdQpWEfjoPDkFMHSNA>
    <xmx:g8S_aEXb5TnJZRwhL73OxQfkc-5y_XS7nf1gYh1nwizyOBSWPLyaAQ>
    <xmx:g8S_aBcKLMloTIJEhcICKrtJdgnESFf5y6OAQwKrcmxBJhXnLbEXsrCo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 02:09:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4c6df8d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 06:09:05 +0000 (UTC)
Date: Tue, 9 Sep 2025 08:09:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Isaac Oscar Gariano <isaacoscar@live.com.au>
Subject: Re: [PATCH v2 0/4] oddities around add-interactive and color
Message-ID: <aL_EfmRj_zDC_8xm@pks.im>
References: <SYBP282MB296329544B33E3C16DD99FD28C33A@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
 <20250820220439.GA1668511@coredump.intra.peff.net>
 <20250821070740.GA3356411@coredump.intra.peff.net>
 <20250908164157.GA1323487@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908164157.GA1323487@coredump.intra.peff.net>

On Mon, Sep 08, 2025 at 12:41:57PM -0400, Jeff King wrote:
> On Thu, Aug 21, 2025 at 03:07:40AM -0400, Jeff King wrote:
> 
> > So here's a series which I think addresses everything I found. These
> > bugs have been lurking for a while, but I guess not many people tend to
> > set color variables to anything exotic.
> 
> And here's a v2 based on Patrick's review. I also touched up a few lines
> whose indentation did not pass clang-format (not new, but ones I was
> touching or moving around). The only thing I punted on was refactoring
> the GIT_COLOR_* defines, as I think it extends well beyond the code I'm
> touching here (see the reply I left in the thread).

Thanks, this addresses all of my feedback from v1. Well, except the
GIT_COLOR_* defines, but I agree that it doesn't make sense to do that
as part of this series.

Patrick
