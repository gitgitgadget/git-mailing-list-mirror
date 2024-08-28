Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1561C158216
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833295; cv=none; b=qkdUbqO0o8gP50H/1pZmgKBnyBKrl3ndON0w6roe3V6kivZm0w4xoykKbbeugObzEQqvfZ1TfFJUOgLBmzUEVglbsjdFy3f+YMKbNCJu7U6HRLEy13XSo9Tl38HeUE2H1C7x59NMZigsDTSR5kSSkuW1fDqJkDOWA5C7jjV+Yv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833295; c=relaxed/simple;
	bh=+CKIa+NDDuxGhyD9ffT6FiCCAO5UeYuh1CbAae/uhOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de1etZwQmOo1J96sHTHEnH+qZj7JeYF98l4CVhwzIP2Aq5vf4/Fn5Y+/vGVfcSEK9MwRKnak21mlTD/3K+UxmLOLFQ7UL8e73a4A87B0qJ/hMGPWZWjlb35QUAWub8rJlK6GEl5JNUA/R/+3cH/qNQaMFOkboFxj00QtM30LpEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T0fN+k56; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZArV/U8j; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T0fN+k56";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZArV/U8j"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2BF8411470C9;
	Wed, 28 Aug 2024 04:21:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 28 Aug 2024 04:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724833292;
	 x=1724919692; bh=54eXWipA5GuH2SIp3OTT+n2A8d7yQD5B0mzd/5hC72o=; b=
	T0fN+k56iLESQ0pFbbmTU31gTK6XHFZH/6/YbdaGBFqouPmx4BE+P5c1XLSjrZ06
	cDM+QZIn3jA03h5s6LaaJ+G0lxBMBE7NcmWHIgWzmOGlhz9rLXGfuB0Rzsw14Iv4
	mkgXc6jQsbco/HkGLTeaqC54w8MLpN7aTrcy6jGvyOI6FqLpHtYwiSdaRtinZU1j
	lWwhg3E2dBDtzE4+qHfoNdzVBTTaQzt1L+uTl9NnkOl3xKrbC6ozOcIE9kqJWknT
	XBNnPAfar79v5DBApz+SfWH7ilf19/rGVW4h2ejl+11jE/+QjJ4/ng1BOYdWWxWw
	pfFMl2Ba7JBbMIKQZJ23Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724833292; x=
	1724919692; bh=54eXWipA5GuH2SIp3OTT+n2A8d7yQD5B0mzd/5hC72o=; b=Z
	ArV/U8jMRd2lRBFhXSHQ9gh6v0xi9RsV0/Hhhfa7PhO372kT/Sf6qblU/67/uFm1
	7dkgjcEP6KPCvXXg1f/6A9zgJCaeI/as7qlRwjorsmMfTIEiXQIjIR2rHN7WuPT0
	k4wrm2/jJcAdO0BEOC2dNGgggWwSDXhaaANnY6+vdl+epzPblPp1VKiICTCgBswP
	JLfLi7u6fEErcRfnHjekUB66yOrKhys4tyluD++HAWF+/IyI9UpMFAJ7gqnTKCs3
	KAGf1bBg+hsFGTwSJSZ21tBGxJCF6czozmStVRAzjqO8gVaXCRB+MaTJI7BV1dZN
	QAZ8+S5ETbceCeVa22eNA==
X-ME-Sender: <xms:C97OZrY8KOP31n1J63rlPc42rLZv5ZhBMjuU1tnsNx9QYQ-j-fECpA>
    <xme:C97OZqZ5a_KBiFIUJLAUssglYCPJBaK9tPC8e8LNiHxUYlYIhPLpKZB6_ogUBdHMC
    6YcH_RNB77Dcw51Ww>
X-ME-Received: <xmr:C97OZt9HdtehXXRnyDuW-ywv95_ul_6r_G6_47pwh_EuqIOJMRHT2wYizYq-UFA1Rx22lBwrnOo6ajv5gJuN4lBqmkec76ZpnW8-kxVN5Gskgds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejudeuffetudefvdehvdeugeduheehheejgfdvhefg
    geeftdejleejueeugfelueenucffohhmrghinhepmhgrkhdruggvvhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggt
    ohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DN7OZhpgZupY3qR10zh63EW3wqfE5Ckl3ZpUnvVVAPQL2tn75K_07w>
    <xmx:DN7OZmoLKihmvysNKdTfmPiQCAgNOrm4a8PqYqMmrQY3sf2he_ubQA>
    <xmx:DN7OZnS0xtJE-TCSccuomRIPxkfZCOEmOTh2dbiXdVmcBxtgedEtMg>
    <xmx:DN7OZuqeSKoUY9o0F4RHS2qc4lUUnJO1BNVQFvsJgoVqUv2cY91FiQ>
    <xmx:DN7OZpW0HZxYRbSawXcslNklu1aq-TWNv5WZsD8F67S6-O39snldPcYP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 04:21:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dac3dc2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Aug 2024 08:21:24 +0000 (UTC)
Date: Wed, 28 Aug 2024 10:21:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] config.mak.dev: enable -Wunused-parameter by default
Message-ID: <Zs7eBocE3RZb71-q@tanuki>
References: <20240828035722.GA3998881@coredump.intra.peff.net>
 <20240828040049.GF3999193@coredump.intra.peff.net>
 <CAPig+cQLr+vAzkt8UJNVCeE8osGEcEfFunG36oqxa0k8JamJzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQLr+vAzkt8UJNVCeE8osGEcEfFunG36oqxa0k8JamJzQ@mail.gmail.com>

On Wed, Aug 28, 2024 at 01:56:13AM -0400, Eric Sunshine wrote:
> On Wed, Aug 28, 2024 at 12:01 AM Jeff King <peff@peff.net> wrote:
> > Having now removed or annotated all of the unused function parameters in
> > our code base, I found that each instance falls into one of three
> > categories:
> >
> >   1. ignoring the parameter is a bug (e.g., a function takes a ptr/len
> >      pair, but ignores the length). Detecting these helps us find the
> >      bugs.
> >
> >   2. the parameter is unnecessary (and usually left over from a
> >      refactoring or earlier iteration of a patches series). Removing
> >      these cleans up the code.
> >
> >   3. the function has to conform to a specific interface (because it's
> >      used via a function pointer, or matches something on the other side
> >      of an #ifdef). These ones are annoying, but annotating them with
> >      UNUSED is not too bad (especially if the compiler tells you about
> >      the problem promptly).
> > [...]
> > And since the code base is now at a spot where we compile cleanly with
> > -Wunused-parameter, turning it on will make it the responsibility of
> > individual patch writers going forward.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > diff --git a/config.mak.dev b/config.mak.dev
> > @@ -54,7 +54,6 @@ ifeq ($(filter extra-all,$(DEVOPTS)),)
> >  DEVELOPER_CFLAGS += -Wno-sign-compare
> > -DEVELOPER_CFLAGS += -Wno-unused-parameter
> 
> What is the expectation regarding newcomers to the project or even
> people who have not been following this topic and its cousins?
> Documentation/CodingGuidelines recommends enabling DEVELOPER mode,
> which is good, but this change means that such people may now be hit
> with a compiler complaint which they don't necessarily know how to
> deal with in the legitimate case #3 (described above). Should
> CodingGuidelines be updated to mention "UNUSED" and the circumstances
> under which it should be used?

Updating our coding guidelines would certainly be welcome. Other than
that this series looks good to me and is a step into the right direction
in my opinion. Thanks!

Patrick
