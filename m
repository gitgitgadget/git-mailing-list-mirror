Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA3286415
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211472; cv=none; b=JEMSza/vY5TwfKOm/7ThYt/mgGnS5dHjopiS5bCEIfiZQ1tRAXrgLAP9tpcLNVVMfWPOfUMC1sF6HVZs5X2cU/xR56Y5GtJJTgEpDKobTJQtiR8WxWeFUxFhKXZ4dk5Z5JB2a3uhvLlFjlefm/PkdQqbwIxPMR6rrhC01bqI+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211472; c=relaxed/simple;
	bh=ihP6hqYEEWRmrSYECB+sOXaey69fS+KOhiC7ZIxvsBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzGd6P7/92iPXKJI/85oVotToBrOL760UHuZBouPkFY7f4/WInWgbLlGfVgszpPFySLB2tTLbQiO9ym/CtnRl32dFiHz8VchB7o1+33pCLY/SAK5VuQVgbwJqfNGpaLvNmsmzJXpknTIhJB+SZYN25IV2OTMeBMNt1Gq9pdZjV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UaASxALI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0/Egb5Ch; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UaASxALI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0/Egb5Ch"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3FE8C1D000EA;
	Wed, 11 Mar 2026 02:44:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 11 Mar 2026 02:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773211469; x=1773297869; bh=qRsX+5WsPK
	V80tYKmpolGcQ9uJa+6oTcIiqLAGGihlk=; b=UaASxALI/yGqb7NnqV19eQcg5W
	4Ou/YjTLrnAkOrK0hzXlMqv4nHMwyQQsPLq0ex8ojyDCcChvsp2Qd8ET/7OCj/7r
	JZXviYXDOcLnm/MachCHxc/mOhY3fuSpSJZfpV7xrvHSqdWDT4R83QcKXaRGpYT4
	TIcvA7OHIuDfS/v9Kep46Wawyb5J1BVLkErY1qJo9YPaRAoeaniNncxYkelCSXz+
	9Ie1Q64i8jf/d5a0Mt5KUtDepVJp9ZRd1h421xVwixnd6VIkQjYsf5Rp+HRUURL2
	xbJqDBkUM42emT5iCemwgtZ/BLvCR8fcm6iKUor4NTJaOl5/0rKE1G5cOhgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773211469; x=1773297869; bh=qRsX+5WsPKV80tYKmpolGcQ9uJa+6oTcIiq
	LAGGihlk=; b=0/Egb5Ch2pYrM3KW8bo2xhh1Kf4XUemdQFS2mdEWE1xYDD3TrFc
	DbmYsf/bvYDUZA6010ExG+VjKOu3z+/n4QdOpQYxGkwICZ5fsosbISfqCtx5HOtA
	B1Mg2ZLv/LfU4loz+jYFXxm0Xy/5blzrdYEESpTTSblNPxRJofwYcR35LtPELU+z
	3N7faMl8Zu7k6r8nq4YAwA9n8v3Rb+hzWJwXHtMofqVtFJDq0/y3KHhw/6CLp1QP
	GWjDTZWjMlFL4MTtt3weGq5EzzKJfkOiD1tiUZTi31ChsJ5l8TU91xTDi36aclxL
	OLtBxziwXOiAXX/Q2yPp3iMCxXg63Ud5Q9g==
X-ME-Sender: <xms:TQ-xaalDN4ygGlFGfcyYtcdLv_KeT23qbPVbzJNdd2CnDKaa4xRkjQ>
    <xme:TQ-xaX1EsSD5WzinJCPCbBaf_7D9qRzBV7DqteIOG0yO8IApXS6tGywIGkQZH1sBN
    2_x8WX4GLdoRdDry0-lO8bONy_Y_rdUdGr_3YpXrm-gOWZz9XQXsA>
X-ME-Received: <xmr:TQ-xaWRth-zOvr39EJ-OuyYArD2nad6IQlfhi0aMkM52rFZkn-RMl1jabsDJY4AwIwOFMo_u3ugNpEsHwQrBuwaYwO_34S9rz51zs1LkKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TQ-xaZu0-xl2LwBBTu66OLt6569_gExeEEs4pK7lI6nXoJb-cGJfUQ>
    <xmx:TQ-xabalGQdSse7AcgYSu9dsrJ9janRUkjsjnntZRXJmFMeJJkeagw>
    <xmx:TQ-xaev9LEbL-dsQ0CGdhKwBhrxKU6Y_J9MsfLzmExxYBa5RboDOjg>
    <xmx:TQ-xadHxgQdC8EAQrynCEKpm3tUNKVaeXgpVOWDGAUPEUinO8HGYNA>
    <xmx:TQ-xaV9a7JxYfbbEgMfSCauDYFVC9NDOLDxlAr0wGzSCjUcg4efN1_Vq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 02:44:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df6b9f0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 06:44:27 +0000 (UTC)
Date: Wed, 11 Mar 2026 07:44:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] odb/source: introduce generic object counting
Message-ID: <abEPSZdahq50L3aF@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
 <20260310-b4-pks-odb-source-count-objects-v1-5-109e07d425f4@pks.im>
 <xmqqfr67vahm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfr67vahm.fsf@gitster.g>

On Tue, Mar 10, 2026 at 10:51:33AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +static int odb_source_files_count_objects(struct odb_source *source,
> > +					  enum odb_count_objects_flags flags,
> > +					  unsigned long *out)
> > +{
> > +	struct odb_source_files *files = odb_source_files_downcast(source);
> > +	unsigned long count;
> > +	int ret;
> > +
> > +	ret = packfile_store_count_objects(files->packed, flags, &count);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	if (!(flags & ODB_COUNT_OBJECTS_APPROXIMATE)) {
> > +		unsigned long loose_count;
> > +
> > +		ret = odb_source_loose_count_objects(source, flags, &loose_count);
> > +		if (ret < 0)
> > +			goto out;
> > +
> > +		count += loose_count;
> > +	}
> > +
> > +	*out = count;
> > +	ret = 0;
> > +
> > +out:
> > +	return ret;
> > +}
> 
> The design to assume that the majority of objects should be in the
> packfiles and the number of loose objects can be ignored when we are
> getting approximation is inherited from the world before this
> series, I think, which is a valid choice for this series to make.
> 
> As your "get an approximate count of loose objects" counts a single
> shared fully, instead of punting as soon as the limit is hit, we
> could ask that function and add it in when the APPROXIMATE flag is
> passed, and get a bit more accurate number cheaply even when we are
> approximating.  I am not sure what the pros and cons of doing so
> myself, but you may already have thought about it and rejected it,
> perhaps?

Yeah, I was very torn on this myself, and I switched back and forth
multiple times. I don't really think there is a large downside if we
started to also count loose objects here. The performance overhead
should be negligible, and it may arrive at a result that is closer to
the real world.

But the loose object counting approximation is somewhat vague overall
with the way we extrapolate the object count, and as you mentioned it
matches the old semantics to not include loose objects. So that's why I
decided against including it, so that we retain semantics.

That being said, with the current set of users it doesn't really matter
too much which of both approaches we pick.

Patrick
