Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F7229A9E9
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776419056; cv=none; b=h9f7lQ6HRfNEHUY7ViwkCcs7vuv4n3Nw4xuLi2LRS0XbfZzBpYHJvFlMYeL3Tkdjr5asK4X+JF2v0WgjeSt3FakHzMHUeFPL1cyFz4P4XMFj4Y82cLVUBICPklDoEd13NqwR0b86f4MbCacu9k7MmvIiaf0jA9zheAj1mzqBuAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776419056; c=relaxed/simple;
	bh=rYge0yOvusBRJUFEeNIn6yruB6Qzo4JkAzYi7N1nTF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nzb5GphitFup+GKcANTykS7d30rbblMJWIs5oLK6QkxaOQt+pY7uXmcrkrcSmLJkRS+VhoH5gVcXwSCvuZ8QoSw4KaaGHw+/LTD5NCamhCq9yagZhVx2ycuweUkzz20Qr2S/OjDGwYXhE5uhHv9CmI0L2KwVVdSbhrrp1Mn6dUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PPIrs/kb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DKdI54V4; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PPIrs/kb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DKdI54V4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1702FEC018E;
	Fri, 17 Apr 2026 05:44:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 17 Apr 2026 05:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776419054;
	 x=1776505454; bh=ANbOAfvMerVY7PpqPcF9RfACPlqHzX4QrgMBUOXmhXk=; b=
	PPIrs/kbnRodoRll5K4j7l5Isj2/rJ4IYj1XiFXu1bDaOr/Qdu/ixP+692qtRvXP
	NAhxWqzH+u0pTDMIItYDAToky4gq+M3hU9OtEJUYcShSHLDIrPWGJF4CCQss/jiD
	Wy4lWCf1ZEFhhxUZMjzhQo0P+IcMPja+nUYivV583USmhFKn8scCRDzk09I2CWLv
	+cbcJT7S7EZicvxcPtYNbXG52VMKjZtcQysZza8TZ1miCbgowiNI5j72VzvPfouD
	uNpS0mIhuwV8uEgOmxTy5KQ/UKOvjsnpAtLSCBPv4Rd/i2l0b1BPJNdnEbW4s7ma
	OWpwtqf3CN5RbEwCh+1F+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776419054; x=
	1776505454; bh=ANbOAfvMerVY7PpqPcF9RfACPlqHzX4QrgMBUOXmhXk=; b=D
	KdI54V4vLhkdyTErMUP6lsUUKBe1E5DjK1MBb/zwLzyZqJ118Cl2pa/ZCoITZJjp
	tFOb69D3mUxidKxSCK8y9lwsctMx7t+VcPM+H5S3qkOwMEgUeVEFmWGkngRM1THA
	gUsdl+fvJ+TaDS6EFVVPcXxXfo9s1WDp1qeMEgglWJskpIve7Rqgaa8muG7rhGS6
	N6AbHFjMtG0KVFxCx6jTEEAXZj/3fT2MfFCIEb5vRs9+ZqpVgtDrVmnkrxfSMzLV
	gFKLqmkPDKcFlHLX5agxl60pzUYUdtBvY/VQsP8L+qCyEElk5DIuhSxoOHHxokot
	kB9P71qcLS/94ctJYjdqA==
X-ME-Sender: <xms:7QDiaXFM74crJ1j5eCbtiU3fCMoXeOvEHXWI3XpE8OdXlsYdxexSDw>
    <xme:7QDiabXS67jNlpZZT5K-ExgYViK63uprIP-GM8yIOQjnc5Hung6_vWLy4STVRY6Y5
    J90-r2fxRwDae0zIV4_ZMreIg5Puo-jtOUM9KVLGyodJ0wfnqn3UQ>
X-ME-Received: <xmr:7QDiaeJifT7qXNDzjyBwRoDc_bdzU5hf-3P7pa_aDdMBrdD-Sw3cGAfnlGXKO5tDWab9cvUehgX9r7h5GT6-3AGrlYx4XpYduibyACnMnHSb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:7QDiaT80sj_HtzpKg8dKoABjE-i2qE3Rnxk_qNRL0jpZA8q-4yYoDw>
    <xmx:7QDiaZIOJrPBz0VVjiMHAM55Xvc8nAr_wadg9WAXvlIBrSi_gDshdg>
    <xmx:7QDiaQmuedFu8Qhe01EFj490Biujb1DbFnGR_iij3hy7TmdP8yX5IQ>
    <xmx:7QDiaVNDYkm8k2XcChLtzLw22vXB63w1paCY21Zm40EG7mnwIuxvFA>
    <xmx:7gDiaeFC8oe1SmuW7BIaDs8xp-Yk6q0_-2of5i7dnBKH72ew84i5nCLi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 05:44:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 932a9e9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Apr 2026 09:44:10 +0000 (UTC)
Date: Fri, 17 Apr 2026 11:44:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 11/12] t9902: fix use of `read` with `set -e`
Message-ID: <aeIA6H2G3D2FoJPj@pks.im>
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
 <20260416-b4-pks-tests-with-set-e-v3-11-7a90e5dccadd@pks.im>
 <aeFCqhGIWQgE9lq6@szeder.dev>
 <xmqqbjfizlfx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbjfizlfx.fsf@gitster.g>

On Thu, Apr 16, 2026 at 01:42:26PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Thu, Apr 16, 2026 at 01:19:28PM +0200, Patrick Steinhardt wrote:
> >> In t9902 we're using the `read` builtin to read some values into a
> >> variable. This is done by using `-d ""`, which cause us to read until
> >> the end of the heredoc. There is a gotcha though: when the delimiter
> >> isn't found at all, then the read builtin will return an error.
> >
> > The absence of the delimiter doesn't make "read" return an error, EOF
> > does (that's why a "while read ..." loop works).
> 
> Very true.  So for this kind of "read", failing is the norm.
> 
> > So AFAICT what this "read" does is equivalent to:
> >
> > refs='main
> > maint
> > next
> > seen'
> >
> > Isn't this much easier to read!?  OK, the first ref is not aligned
> > with the rest...  But I admit I had to look up the docs to see what
> > the empty string as delimiter actually does, and even after that I had
> > to add a printf '>%s<\n' "$refs" command to the test script to see
> > what's exactly going on.
> 
> Yes, whether "set -e" is used or not, not using "read" there makes a
> lot more sense.

Hm, true indeed, that variant is a lot more straight-forward. Will
change, thanks!

Patrick
