Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FDC193064
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520508; cv=none; b=dfOPF+U6bOOnZkZmVVy01/gHoOnU5E5fRQJZ419ZaV9pWK0SVzcn0Fq9vOTi0+RcYaaulgfioQ8BvX6Ff5YnkyXl+zJVwPl9vR1HqyFLZUGj8HX1U1hxTZlxBXiZjMk0rHhN6ptd2b7rpPZCFJslInL8GwCZmJNlzuHcVLqbjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520508; c=relaxed/simple;
	bh=U7ue5xlniiNDeKNkjRJUY5MTKnbU0jDbBn3x+1PuWGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6VKfDYpIEQU/uIq4AiCXV8M/JdmcEprk6/ugJla6nmk1OLue9svvTG043q1WtjTyomi9lNk8YNT0NIYxcv5r8cL3jA0RsYjTXIS3msJSS5hQuBaa67/S3t6Rk0d/vy7ZMCpw9b1OE2W9sB79i38dmoZ1iCpOeKhSHqpDOsqLvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fCuEWgOw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RAOcVgmK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fCuEWgOw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RAOcVgmK"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0FB431140236;
	Thu,  5 Sep 2024 03:15:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 05 Sep 2024 03:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725520505; x=1725606905; bh=y7EAMaFZ8y
	B+o9B41FLdhj9bxv3Y8fAlo2guOkZCPvU=; b=fCuEWgOwXFn8xOK+hSPfFufFxN
	41wYR92KSAMjFoKwukXuf6qjQKe3SD5RT1R+T75b1QbN2o5VlASNcaCLntuCt1V6
	nJTDB7MxUE1oQLoWkhKZbme+g9CQDSHLEfZvb/GoCnSPvHrdWVT3obHT8Uaokkss
	60luEmUAfln0CdLN5RSXgEFwT6ixZl2ZxdynaTTYRLvOhBjRWOLCvJ08PFPT6j+z
	VUqyqtkT/9UoF3+knSi/02vtc0Ytm9MM23zRLmfSQjyNjvM0Khk/i5kEb3UCPW+h
	MaYrn7LdUGiX8OJFhx1oCjvioIOoEXRjUKkFJEHcblT4dp2BZ7VAhOE2Vodg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725520505; x=1725606905; bh=y7EAMaFZ8yB+o9B41FLdhj9bxv3Y
	8fAlo2guOkZCPvU=; b=RAOcVgmKJf85z3mOdOwqueT3NgxNfqdGauXcydxb1S3e
	9QTWMPHAdHMDgbMkKqvwmH1lUieB4wOufiNFFKoRX4ek5kCSsE1iDI7KiGmZwfwf
	D+HaYUKW14EVsowG2f1dH4SqfthM8mifd/gqeiZ04Y0+SVJ4b7SpTEo/2Rr3cIwz
	Ix5K77RwzZpdbl3wyNfZsTDIrgkWEU0hhf0aVsnLx/ZJI5bHt4HPEYOi3NqZJ1n1
	3gRux/lCIRopaE7nhQY1fa4vIAsGjgovUeLIO3EYPwXr6igjsVEqsS9Ffdkg9fUo
	7FHt7Cb77dfLs1v90EVkfs9lV/low40SgzdKpWpACQ==
X-ME-Sender: <xms:eFrZZq4jP-gZkGBXq2ZqO5dj_w43F_5OSFNcEvAoNJk2wfTkmccloQ>
    <xme:eFrZZj6hTq1Dec1Vtvri242Xp4DA7RN03j2T6CgiNKoLB2s5b4sb0rXuKJIEAEimm
    e1jUAzVLogaJVW7sA>
X-ME-Received: <xmr:eFrZZpez4M_FkLDqrqUu0YuVp5HzjWGxtXUUBhfuQO-CIgoajnS7NWAtLdRfiR0_kI9M3UTC3Jvsyg1xbg87hyxqGT4QFK3LVsZ7AZsMbi3ur-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehkedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomhdp
    rhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:eFrZZnKNHSrqpG3nj5eXs_9t6w7rN-IC24goOGdlIZRVAZslYIQzRQ>
    <xmx:eFrZZuJpBfnxu7l9SjJ0Zg9PFir74nQ9ZLgBRbQGzfiFFk9G8Tc0ZA>
    <xmx:eFrZZoy9rf2Ioix0QBFuu4AfH2Y82FkZWaDAWPNY2F9gKxrIlUHkiA>
    <xmx:eFrZZiIO87K1rzZ_WzLoF7hZnN91aclATr37F22Afx8x5VfREKIHSA>
    <xmx:eVrZZq3IA9tfyjOAKK91XIdUHl-H-5yg3FX3xb-l-86Ce28LCWJN1TZE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 03:15:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6be02968 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 07:14:52 +0000 (UTC)
Date: Thu, 5 Sep 2024 09:15:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 4/6] t-reftable-stack: use reftable_ref_record_equal()
 to compare ref records
Message-ID: <Ztladu-lhTbg1fXj@pks.im>
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-5-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904150132.11567-5-chandrapratap3519@gmail.com>

On Wed, Sep 04, 2024 at 08:08:04PM +0530, Chandra Pratap wrote:
> In the current stack tests, ref records are compared for equality
> by sometimes using the dedicated function for ref-record comparison,
> reftable_ref_record_equal(), and sometimes by explicity comparing
> contents of the ref records.
> 
> Replace the latter instances of ref-record comparison with the
> former to maintain uniformity throughout the test file.

It's not really about uniformity in my opinion. It's rather that the
function is a lot more thorough than only comparing the refname, which I
think is the real win here.

Patrick

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-stack.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
> index 8047e25c48..4f2ef1a8cc 100644
> --- a/t/unit-tests/t-reftable-stack.c
> +++ b/t/unit-tests/t-reftable-stack.c
> @@ -174,7 +174,7 @@ static void t_reftable_stack_add_one(void)
>  
>  	err = reftable_stack_read_ref(st, ref.refname, &dest);
>  	check(!err);
> -	check_str("master", dest.value.symref);
> +	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
>  	check_int(st->readers_len, >, 0);
>  
>  #ifndef GIT_WINDOWS_NATIVE
> @@ -285,7 +285,7 @@ static void t_reftable_stack_transaction_api(void)
>  	err = reftable_stack_read_ref(st, ref.refname, &dest);
>  	check(!err);
>  	check_int(REFTABLE_REF_SYMREF, ==, dest.value_type);
> -	check_str("master", dest.value.symref);
> +	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
>  
>  	reftable_ref_record_release(&dest);
>  	reftable_stack_destroy(st);
> -- 
> 2.45.GIT
> 
