Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418452E370F
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576620; cv=none; b=TWJ49AmambYs6mubVWLYhUDfMDSOACI9Q0b14ftTHK/P8QsCsRMW0puy/tLA168oJ0N6T8ZkbwrPeAm2H2RiPjDEHbC6kR9kskbimEgGN1j0XD2HdoQv21dso2laz5CEZNjimiOMXrTlO8JNYz1Lwm/EV2Lm7N96JGHnjCRLvbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576620; c=relaxed/simple;
	bh=swtOG8k3I8dEMwL/cTEdcbCJYr9/8DglT8DzNTkYPtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0r2jzNw81AobqkE2i0Cxh9kFO5LhO6Jg/D4FU3eaODubL4SqiKEdtAvazqU4RRV/vYXJUrjyqmtYAQdjYILipdcbTzYSWG8WlnnW3hQqgpFxEjBCQzlSlkDwn0JVBZa0Q8OPFvlL8EBXq2WUbCludznGhSPqoxSVCChdrGBijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tQeY2GLt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hfGoIkJq; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tQeY2GLt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hfGoIkJq"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 66089140023F;
	Tue, 15 Jul 2025 06:50:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Jul 2025 06:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752576617; x=1752663017; bh=WKUpAHqyLt
	QlH50hc70EFFqhbM9Ih9LvqmhfuPjqLh0=; b=tQeY2GLtOPLmL8ZnLEy+nioWEd
	+jRSk2t3ar+SxGmmhvmywRrpqIqe0lRmuPu0BCYGP4QtiZAc41qCpC0ieWuglYyG
	Kx3ZjoL8blb2+2v8Jho+7I/c5ChOnM+QcwlhAx5NH3wfu67WCY4HwVnFoDcUSp0z
	tooTngKE9hd4VKlCC5NarALYiVN9yNS3lTR+tfxrajE9Ecso3kZfjbyeNTT9Ougc
	oW8yuB3RYpFlr1tkFTZ5KhKt2479ioWj9nERWLKKoyB5yTBFtH4lj8XDmo0/cLhg
	1ME5Vtpzip6FGGw2b25L2niGZk0PXnWDVVmRRxiHM/T050fL7VNR8gux9mHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752576617; x=1752663017; bh=WKUpAHqyLtQlH50hc70EFFqhbM9Ih9Lvqmh
	fuPjqLh0=; b=hfGoIkJqKA4Tn4oLrmYomvBTkm5P7VRDJ+RPhNhroKSK9NYCaWF
	/EMcR6A2n+IcxNi1I43x+gSScW7fGA8YD7ssskfwuz1mY1L7NZn4CiZ9VDb8dx+c
	iyYwYFtoiYPI8xlGh6yPZ0r6yfb/cc1zNKU+fnZs+SKJI33X1m+Qq5z7OdaGN3Gk
	5n3hAdrQtICVU7O8coJQ6ma73hG4PIF/gBdIexlECfKlkEQsKQU+tzae58FUwwpq
	NFUoPaBX4PeEy+B3BidjIFSQPshmmodVO6LdSrZcIe0VLhVDuzlcEf9wsvWTnPvi
	akB1D/sa6ErXcPz5ilK+QGX1WqsA4yYXQTQ==
X-ME-Sender: <xms:aTJ2aOchu-vUU9Zqg0iUR2phw0dfmXjXD-zGYmyfh50pAQvu5rgYyQ>
    <xme:aTJ2aIbvX0ae6CorX15d8d5pe51E2Dp2RnGlXUn2qYKb6djQXGmvY5EsigXVYRToA
    GuhyucsfOx6dqzkkQ>
X-ME-Received: <xmr:aTJ2aBWpbVNEQZ1p7eMyZvetsh-3JZNhVkOh1nETjVo2r1_4Yz9SiJVhf8oL9tBLZikh0GN_hMbjdYFbKWzm8a2W0UQvYfxwt5mKAg_U6FT2gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:aTJ2aKhZvArcttrj8wD6-_cwgiyYntbfLQrKyexKndzWlvm8LsUsFQ>
    <xmx:aTJ2aPUHN7_upXrRBkaF4QMFik8Q714O4LMzsU2rf_O-BjuRJGYrPw>
    <xmx:aTJ2aBM0BYNQRvD65ZIUcW_RoKkFU0ewV0J7osJiS6rvjbOVh7T99A>
    <xmx:aTJ2aLY1VqOb4Af4zTgb1HZPP-BEnegZNIhfve0neEq5g5ZwucKrlw>
    <xmx:aTJ2aBAdfh49jqDDQ4FATWDp5RC7Q-qA2MVcesL_8VwpRY4gaB3si_pJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 06:50:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f3947ab (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 10:50:15 +0000 (UTC)
Date: Tue, 15 Jul 2025 12:50:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/19] odb: introduce `odb_write_object()`
Message-ID: <aHYyZJnQqKCVdFwK@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-9-62627b55707f@pks.im>
 <878qkvdh4z.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qkvdh4z.fsf@iotcl.com>

On Thu, Jul 10, 2025 at 08:39:56PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb.h b/odb.h
> > index e922f256802..c96d2c29e9f 100644
> > --- a/odb.h
> > +++ b/odb.h
> > @@ -437,6 +437,44 @@ enum for_each_object_flags {
> >  	FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
> >  };
> >  
> > +enum {
> > +	/*
> > +	 * By default, `odb_write_object()` does not actually write anything
> > +	 * into the object store, but only computes the object ID. This flag
> > +	 * changes that so that the object will be written as a loose object
> > +	 * and persisted.
> > +	 */
> > +	WRITE_OBJECT_PERSIST = (1 << 0),
> > +
> > +	/*
> > +	 * Do not print an error in case something gose wrong.
> 
> While at it, shall we fix this typo?: s/gose/goes

Good eyes, will do.

Patrick
