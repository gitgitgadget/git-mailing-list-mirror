Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FAC19E802
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106500; cv=none; b=a6vEj99C800I8REimVOdKTEat84UHuB9yUnUc9j8vIdy1SeYtvKxXWO2N7hpqxB6c0NrBjoEV09/9+N3DIavqCsqXZs8wAebDMwiB3XmpRwVCyLIoRnKlPFRhuIB4tvWsEbQ25DgBIVg3kNd2tu7uo7hlaBs2C9Y1U4YNO8GQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106500; c=relaxed/simple;
	bh=LMMf0cJTdjgUtGIvYDGu2Uhl4WF7eHEZbOmtBQrYSCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6AVG6EoyKdG/3wg3ErG5kDnbxfdrBBTidgYgFIWBCGmNJuHZD0Te2HqkJ8WiEOnW/o2fCxB7GvgvSnEestWfvwIE5S3p3N+HWYPf06O2Y9lIpNGfqQMi9jq2L12kJzuBDnLacZ2sDyoGPpBYBuq18HSJPjalfOPc4QLxXR4xcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M/JmvzA4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EJY/LTTT; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M/JmvzA4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EJY/LTTT"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C4A381380282;
	Wed, 20 Nov 2024 07:41:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 20 Nov 2024 07:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732106494; x=1732192894; bh=aqviBUHC3V
	wUX+QCWlO5iJGIXWPUJjQuWSemJ3ZG0TE=; b=M/JmvzA4bdpKiRLsf2Ai/NXmgY
	yPtB9DJfmeW1RsW//J5h6yIsweLLOkoPzUUqQ3MHE6uB08WDXLMhi9d4U+kKXZjF
	Yr0fZmY2WoCDg2Rk4Qp/3goTztqn31TXO9qTzZzlQVbnsCA3xD1bQ+cw30Sn9gcE
	lkk4adMRXdvPz8xwEFpKiP3MS6Lushe5TCAku3CmeAXUxd80ijmW/JjLiZVS9mPv
	v+e9NNc5UeeYYL1CrbdhvDUXICj0dOXZ0t459hU7UwXh+3tYtdecwGmR37jkWzKm
	P5qdlZ+E5OYWj/A2eR6fnh2r3QD710a8g2SEbwjk5NNct0TMiAfOu2/Bkx9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732106494; x=1732192894; bh=aqviBUHC3VwUX+QCWlO5iJGIXWPUJjQuWSe
	mJ3ZG0TE=; b=EJY/LTTTyjqh2qH+ZC/XG72EdSsieZKKFkGKv5hCabhSfx1iPjo
	mBzT634lgCJYNVIgnEU33OgO/Pe2UFxEXoyvIAKL9upSrWsXk8sVcOPY7vKw5AdH
	IfFQTnPs4FDLjC6Z5Bq2YHuhBxhZqLqPkERU9qW/Mpikuu+ktjYacGA1zkTdfRQo
	vpeXkPwvLTUfKwWZzWCq6iBCs4eDBsJLSNYILGoX/XoeCc0aa5ydrQ6izQM5UXlk
	xROVvuLGwg0RwYS+dEoMYNeF6SXx6vhscuWC/y2KRsQ5lVyz0lWaLc4+2my4od3d
	pksBfRrVCQWDww9qTBumt2dEMRpSFJ62HBg==
X-ME-Sender: <xms:_dg9Zy6GJ3W7txoPY4K7WWRL7USwcMO0NvWA4U7bWqMEeBXYFugDTw>
    <xme:_dg9Z76Rv0LLnzJtd8qZVR0vSdDJEC05Rd6JPseJOgC1pB_HAmNJqLfKyZS3D66BN
    dRAqWQ-I4PUTiKngQ>
X-ME-Received: <xmr:_dg9ZxcaCp-rfQcDiSoZqciyZA6VoubW1HDrC3p0BNOumnZvICGe3Oy_7dzDlwfGu8V5z58-AXsGRHW2CK0g9SmoPZcVGCK_4b08aHaOSs8iow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhjuhhsthhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_dg9Z_Ix1Q5I4LhPlKnEhBr_xVY3-ijbYoVdaAXmaVuX1P82kfQiJg>
    <xmx:_dg9Z2J0Af87q6an3j45eslhxZzilmWBvGTkVwS4wbizREnBQhH2lQ>
    <xmx:_dg9Zww2banZJSqNz0T7JaxF93cciMNr7oswQWY7e3j_CC24dHmIwA>
    <xmx:_dg9Z6JcvO-kAIDo4-WIzMNErgs3G3-UhkSX3zLpFNLB2KdcKH9hKA>
    <xmx:_tg9Zy3RCdXhJRpc-Q0O2SxromTFvdWOAecjZ46Pql7JhG8a9qvbNucQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 07:41:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 27153bac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 12:40:38 +0000 (UTC)
Date: Wed, 20 Nov 2024 13:41:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2 09/27] strvec: introduce new `strvec_splice()` function
Message-ID: <Zz3Y35YI9ysFabUJ@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-9-6154bf91f0b0@pks.im>
 <877c8yti5n.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877c8yti5n.fsf@iotcl.com>

On Wed, Nov 20, 2024 at 09:37:40AM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Introduce a new `strvec_splice()` function that can replace a range of
> > strings in the vector with another array of strings. This function will
> > be used in subsequent commits.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  strvec.c              | 19 +++++++++++++++
> >  strvec.h              |  9 +++++++
> >  t/unit-tests/strvec.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 93 insertions(+)
> >
> > diff --git a/strvec.c b/strvec.c
> > index f712070f5745d5f998d0846ac4009441dddfa500..81075c50cca4fe44608775541d876294a79d9e4e 100644
> > --- a/strvec.c
> > +++ b/strvec.c
> > @@ -56,6 +56,25 @@ void strvec_pushv(struct strvec *array, const char **items)
> >  		strvec_push(array, *items);
> >  }
> >  
> > +void strvec_splice(struct strvec *array, size_t pos, size_t len,
> > +		   const char **replacement, size_t replacement_len)
> > +{
> > +	if (pos + len > array->alloc)
> > +		BUG("range outside of array boundary");
> 
> Why aren't you checking against array->nr? I was trying a test case for
> this, and this seems to be unexpected behavior:

Oh, good catch!

> 	void test_strvec__splice_insert_after_nr(void)
> 	{
> 		struct strvec vec = STRVEC_INIT;
> 		const char *replacement[] = { "1" };
> 
> 		strvec_pushl(&vec, "foo", "bar", "baz", "buzz", "fuzz", NULL);
> 		strvec_pop(&vec);
> 		check_strvec(&vec, "foo", "bar", "baz", "buzz", NULL);
> 		strvec_pop(&vec);
> 		check_strvec(&vec, "foo", "bar", "baz", NULL);
> 		strvec_pop(&vec);
> 		strvec_splice(&vec, 4, 1, replacement, ARRAY_SIZE(replacement));
> 		check_strvec(&vec, "foo", "bar", "baz", NULL, "1", NULL);
> 		strvec_clear(&vec);
> 	}

I'd love to add such a test and verify that it fails as expected. But
the problem is that the API we have just `BUG()`s and thus causes the
program to die. We could adapt the new function to not die but instead
bubble up error codes, but I'd rather do that in a separate patch series
that goes over the whole interface.

> > diff --git a/strvec.h b/strvec.h
> > index 4b73c1f092e9b016ce3299035477713c6267cdae..4e61cc9336938a95318974903f9b35dcdc4da1cd 100644
> > --- a/strvec.h
> > +++ b/strvec.h
> > @@ -67,6 +67,15 @@ void strvec_pushl(struct strvec *, ...);
> >  /* Push a null-terminated array of strings onto the end of the array. */
> >  void strvec_pushv(struct strvec *, const char **);
> >  
> > +/*
> 
> Tiniest nit: I see the majority of the function comments in this file
> start with a double asterisk, should we do the same here?

Double asterisks are typically used in contexts where comments should be
extracted via tools like Doxygen. We don't do that in Git, so I don't
see a reason to have the double asterisk. Our CodingGuidelines don't
mention double asterisks, either.

> > + * Replace `len` values starting at `pos` with the provided replacement
> > + * strings. If `len` is zero this is effectively an insert at the given `pos`.
> > + * If `replacement_len` is zero this is effectively a delete of `len` items
> > + * starting at `pos`.
> > + */
> > +void strvec_splice(struct strvec *array, size_t pos, size_t len,
> 
> In this file we seem to commonly use `idx` instead of `pos`.

Fair, will adapt.

Patrick
