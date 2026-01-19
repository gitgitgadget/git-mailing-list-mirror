Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B48A218E91
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806658; cv=none; b=ojYXJrEuUEzB76l/tzY+5EM5q0Rg/gmKY6rO4rj1xlPo+pLG62ZRXSzGjbkypPT9lzw7AT7fdex1vObo9Be7jn1WIioQGgOfDbV5S768B6JnfFBjbA9w3utyHgZ7QvkOmuweHieegbcHPIQ5EKGFtv9SQ4PAqZW1OVQJF3mfL7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806658; c=relaxed/simple;
	bh=jYYHXcG977zwLLmp/RJAVt9ubYAKCLK2pUvMPPWjn+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcwCKHUbbJRGJBE99tUZXb11ZQ6D2SP5ZhJDjUk1PkIjhNwN+pOgaB5a9U0OnWM3ds8GQimT6ANVEGZdlDfi6RaBm+uG8rYPR/JXsp+WAaGOXiYB7X9461ckYxiFeAzpDqOZJPYpaBDKKk+vTX3WvEBaZrhoJCTmICeDy6GYJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j1kr/zDg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MXU2CHYx; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j1kr/zDg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MXU2CHYx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F48F1400769;
	Mon, 19 Jan 2026 02:10:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 19 Jan 2026 02:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768806655; x=1768893055; bh=4AWLCg4m9b
	Zn/vF/zpaGlUcDSdIfxGGHggqYYEnyjgM=; b=j1kr/zDgVytfKZ+RWZmPhBTr6k
	TzHLGBb65Xc8mb2AUYSAl6Gf4r/4PRbXfCSwCFU2LQygZNkU3z1YLcbHak/SxKjl
	Sl4h3QurIIzIJeDG+neRdw+bMioEOAVfXLpRq4JKRm01aTyABWksZVCCHKtSVju2
	9U0KGvma6s8hBxp+lbO8Bh/15RIkgA/3q+Q3q1PnWCg/85jdJzRt6kUncWNaU1j7
	QtsniCE6rHtdN00JhWhshz1eaILOgPlPvS1g6lUWWnTdgLtCriSxfahbJMmMrnIT
	Y2RmCRCOjPNezhcOLCZ5+9pXvLHJNF3I9UjOFQdL3C5lEkr3N+gniTJ4VZfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768806655; x=1768893055; bh=4AWLCg4m9bZn/vF/zpaGlUcDSdIfxGGHggq
	YYEnyjgM=; b=MXU2CHYxUikp2uLBBdKje5rFcjIzZt4yKYyvwnzRpBzi+qB5nTX
	Xg7etfUTSReR0OTBxKI/srUebPGxzoXx7e0P10RGt6jNA7jfXhcI1/dq3u7pLKDr
	IzeIAqm4GW0jBDPoI39GJVrQtZ1rs6uuypawZdnxbVrMn25LiFZqLzoOJ/CRBdeh
	g3KuJ4c71n4Y6eY5q9VISJ0RzNuuI11lZ9UXNQITlFaERKEDrtUBOugHgH9ej2gr
	VPB6x9fzRHrH+VpA87ljjkMjipCRtBlXEoCuVjRajPTCqMJThg8w/qhuo+YeAjmL
	zvW66atE2/N9J7kvpYA0i0jgzbsBPHTyb7Q==
X-ME-Sender: <xms:_9htaR51vMB1c1jP_ji9k0YcnQZoRMeipg8yMSFtVgdhzFkeeB0W0g>
    <xme:_9htaU5xsjUwnAZik8RZN_EBCaxxc-eVdOlahwqBq8K5J9tiRBlNVVEK6iOIeaBBz
    OTUgJNsuuxWaO4XupcU3ZvSl72r9LCP9-vr9ni3xcsjNhubZKA2sg>
X-ME-Received: <xmr:_9htaWFI93o1qF6Ewh03tMryNC80zdXbK8PKtr16UBuyy7nhQP8sPf_4u-VhPrUn9QSDhxeeJknCYasOvrgcvq-kDY1UKg7jgY0ePhTaklY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeileefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:_9htaVRAl4UpFMKNO6pStHdN0rA7RsicEbDdroe4SZVEcmcbkaq_eA>
    <xmx:_9htaXtZaNT7g8_fEx49T5ygnjnJGvsRLQW546R2YhDtjtbrgj3w4Q>
    <xmx:_9htacyGzvUfRgrreVXSEcciqs3lwz7RKWeE4BOYGvC-W6COrhI5TQ>
    <xmx:_9htaZ5frz3PWUqRqUD8EbBLqzKXmaIyb3feTlH0m8rSUwkDTfB_Xw>
    <xmx:_9htaQLjXGTkLvosbhJ0LvqRa18dS-RBset4yfzI3puRe3t9oK8nqWno>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 02:10:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 942c1cd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Jan 2026 07:10:53 +0000 (UTC)
Date: Mon, 19 Jan 2026 08:10:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/14] odb: introduce `odb_for_each_object()`
Message-ID: <aW3Y-vqyrRmWP4yZ@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-7-5418a91d5d99@pks.im>
 <aWpz65mPZfy7Hfba@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWpz65mPZfy7Hfba@denethor>

On Fri, Jan 16, 2026 at 11:46:12AM -0600, Justin Tobler wrote:
> On 26/01/15 12:04PM, Patrick Steinhardt wrote:
> > diff --git a/odb.h b/odb.h
> > index f97f249580..8f6d95aee5 100644
> > --- a/odb.h
> > +++ b/odb.h
> > @@ -475,6 +475,23 @@ typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
> >  				      struct object_info *oi,
> >  				      void *cb_data);
> >  
> > +/*
> > + * Iterate through all objects contained in the object database. Note that
> > + * objects may be iterated over multiple times in case they are either stored
> > + * in different backends or in case they are stored in multiple sources.
> > + *
> > + * Returning a non-zero error code will cause iteration to abort. The error
> > + * code will be propagated.
> > + *
> > + * Returns 0 on success, a negative error code in case a failure occurred, or
> > + * an arbitrary non-zero error code returned by the callback itself.
> > + */
> > +int odb_for_each_object(struct object_database *odb,
> > +			struct object_info *oi,
> 
> Something I probably don't fully understand yet is the role of `struct
> object_info` being passed in here by `odb_for_each_object()` callers.
> Outside of configuring the specific object info attributes that are
> needed for a given callback, is there reason that callers would care
> about the data that gets populated in it? I was under the impression
> that this object info was really only needed for the internal
> `odb_for_eachodbject_cb` that gets invoked.

Some callers do care about this info. We see this later in the series
where they for example want to learn about the mtime of each of the
iterated objects, but we also have other cases where we want to for
example sum up the size of all objects.

Another use case for passing `struct object_info` is so that the caller
can tell apart which backend an object is coming from via the `whence`
field.

Apart from that there's also good reason to keep the current layout. For
the packfile backend for example it's significantly cheaper to iterate
and look up object info at the same time compared to iterating and then
calling `odb_read_object_info()` for each individual object. We already
have the information available when iterating, so it's just a matter of
also populating the object info with it in case the caller needs it.

Patrick
