Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C7257ACA
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469195; cv=none; b=bBYEUPdl6s4DRvV8I3nYxH5EJ3QxQry/SJO2CVwRgdKTJKyO9AhpOuk1t9KFhq6fE1OeXwc2cfnEarcHm104aLv/I3Vab+yiJW08vZcd0w/WUv98V5jYV+y7of8I7QjuUjr4UuogR8Rfpb7ZU+z4Hed/sV+MYUfLubwZbfkaBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469195; c=relaxed/simple;
	bh=mtfDWqQH5+4W3c+GCcFiEJ5kISjMV+2JXw9ArzJYiIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8apq2fNnI1FRmiRZF6t52lt5iL+UEhHi0ctGyGf5xERCjbfQfnWHqFcE5vyTihYsCMgKOW1ez0Fa5e7G+PKyeDb8iEc/lLGTFbowIImYymC7XObN0t9Dy7PH9zYiDSmfA4NTmhUHOiyroVFUNLxWuOw/a8P+4iVaWz5kT90E+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AmhDSPOG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3m1Ik3l7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AmhDSPOG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3m1Ik3l7"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id CBC3E114016E;
	Tue, 25 Feb 2025 02:39:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 25 Feb 2025 02:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740469191; x=1740555591; bh=u8ZfN3+reX
	9L5bPiP93OC1+kWt63HC0YJkpemjncpEw=; b=AmhDSPOGnHwU76Jjf+QPIzcuZ+
	36twPTYmtjChPNViGiyAI7uODLzwmY1fJnxcz1XDjcAX+TI5CZWde0AiIN6TDhdD
	KZatvYR8hMRfGJFVjQBenVWbcOl8aPeWTsEWC36WWj5HyO8d1JVVyUiKA9yxTEM7
	9456PBpqy1pgfU+UVPTKSq34HlT8EF/uVAqYJSolhgUxrJzgvDyh2HxZtJ0UDeqK
	Nc3GApy4+oOoFddzaMKo7sCRnE2eU+7DkbVfahq8QEaG1a2dXF61NH60IqM14wFC
	KBcw62fcysX6BoPDUh0J2vdaNrBHpDjPEISo/ig/JF2KCqDm6AZ9NZg20z6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740469191; x=1740555591; bh=u8ZfN3+reX9L5bPiP93OC1+kWt63HC0YJkp
	emjncpEw=; b=3m1Ik3l7y0sHcOUCCXMFRNhnWt1YQznHdx24mbWeoJzAMeu3De6
	D2ZVCSbx0zZfAO2BiU5E4uE1m7jBiKqRnkaIydH0yocYXzTo4XhE2//F4NbQJ8ys
	WypkCykTjb/8i3DIxFP2QBc4xNVWCZWXQDFJxJGWoQoMZT0pGR6+eHR7egT3wl7J
	zJYaqgQw+IBO5BbPh5nUnnvdNApNFQkoquM50hsEDSUOGLsEegwiF25oL8snQroc
	EUBBmJ90lMJ9Huge/r2WR9udvanroo9pF9K7lAj79RlHj358KqYmZ64gIuVImDdN
	1oP+uBTvQd8cnipFwJpXjZX5+kw9Irl1hAA==
X-ME-Sender: <xms:x3O9Z-s_XDUkosTP50RYXvdcggSR9hm_h9dB7QKWcxLGveY2hdpnRg>
    <xme:x3O9Zzd1Tpj_y3gXVJB-OqmtWLN3i4GPNhgFbjSYP5QKZl0X9T5AaHuXkFNv_4SQE
    sBNBNcOWbI2DQTaXA>
X-ME-Received: <xmr:x3O9Z5yqyw6HenEZ5fncM-3Ws4GaUAW5FW7FckHPahyj-9q8ctDw1PCe_Tsk-81PsGQF-eUpbloGUsucM_M8Kuxd5MpOfKsuvjiOluuIInbrCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmih
    hlhidrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:x3O9Z5M4sxwm21BphaAyG40amgyWbiepbAUYAGmC5FM_PsQFKRnwQA>
    <xmx:x3O9Z-_s6hoI6a07O85Ir98w_YaKf_82Q8R9Akzx9Uznjrj1jWufog>
    <xmx:x3O9ZxU4ILYkqMkF0zxceremfFZZiEyu1ths45ZzIKP24vUWoGKouQ>
    <xmx:x3O9Z3dQFNo6JO1vWV22InaGOgYSrTUiJ7WG99zrdd8JllJf-zI4qQ>
    <xmx:x3O9ZzO7K_iD2gywRHZr1vGQUHNxFPnViF2FWXrLV2eJLdJt_wbmVH9g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 02:39:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0f25cf6c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 07:39:49 +0000 (UTC)
Date: Tue, 25 Feb 2025 08:39:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 12/16] refs/iterator: implement seeking for reftable
 iterators
Message-ID: <Z71zxD17Ib5iydyr@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-12-e696e7220b22@pks.im>
 <Z7x7fDiW0iN7qGIg@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7x7fDiW0iN7qGIg@ArchLinux>

On Mon, Feb 24, 2025 at 10:00:28PM +0800, shejialuo wrote:
> On Wed, Feb 19, 2025 at 02:23:39PM +0100, Patrick Steinhardt wrote:
> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > index 06543f79c64..b0c09f34433 100644
> > --- a/refs/reftable-backend.c
> > +++ b/refs/reftable-backend.c
> > @@ -718,6 +718,20 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
> >  	return ITER_OK;
> >  }
> >  
> > +static int reftable_ref_iterator_seek(struct ref_iterator *ref_iterator,
> > +				      const char *prefix)
> > +{
> > +	struct reftable_ref_iterator *iter =
> > +		(struct reftable_ref_iterator *)ref_iterator;
> > +
> > +	free(iter->prefix);
> > +	iter->prefix = xstrdup_or_null(prefix);
> > +	iter->prefix_len = prefix ? strlen(prefix) : 0;
> > +	iter->err = reftable_iterator_seek_ref(&iter->iter, prefix);
> 
> Should we rename this function `reftable_iterator_seek_ref` by the way?
> It is a little strange that we have two functions which are so similar:
> 
> 1. reftable_ref_iterator_seek
> 2. reftable_iterator_seek_ref
> 
> However, don't worth a reroll.

Well, they do similar things, but at different levels:

  - `reftable_ref_iterator_seek()` operates on the high-level generic
    `struct ref_iterator`.

  - `reftable_iterator_seek_ref()` operates on the low-level `struct
    reftable_ref_iterator` provided by the reftable library.

As such I think that they are named appropriately as their prefixes tell
us which structure they operate on.

Patrick
