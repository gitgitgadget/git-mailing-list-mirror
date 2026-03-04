Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B569B37F00A
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772607472; cv=none; b=O+zx4iudPS3Rs+m1X0/G0CRFayIlZE4PinO8Tdgj7ObrFi2VQgm7i9kaK6KDIVWRFl91xvgZk/o0bEqqPJv3pEZ/x47dFrVJlJg7w5ZaBIlBv8NWqUVb0CabWlgzSc8Jg8WFkHsdmDoLzGRy5x7GR7G3p+/8ZQPogv7y5YfRBKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772607472; c=relaxed/simple;
	bh=KEvpYwr+AdiIRXn1by11qCxZ2NhqERctlgHUuDv0lD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nh2ycJh4x8Ka69OSke5PRHTRqOsISsn6VL76q+l7pwpSIDTm58awWvtX0cpltCZKuP3acp/UYvQJnksCEUhdGJvPyUKQiaEvw1QSz2j6+SYLDnAUFAPIZt96kx7VLHa963FUIaprfKlmVOny3dJonObUgkc7vAyNUrR2Yo7wnP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OwR/8jJB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c4GFxeYm; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OwR/8jJB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4GFxeYm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 098C81400173;
	Wed,  4 Mar 2026 01:57:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 04 Mar 2026 01:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772607471; x=1772693871; bh=3vQmXsfeDY
	4sdIhSxgFUcT+LDBOnyJkhM/XPG7Hz+tA=; b=OwR/8jJBxP+PqSiBAmxkEWKDfC
	nXMHI2e10SAlWB80cpWxm/qm+sHVD5/8KHcB886ggJ8iqe6wZVcp0ZRjrMRPsHqx
	3renwkNhlwA0nri8hh6QkBD5hdb41by7XSsxZlFCO9lm4NAK4OYghCofSzgN6csh
	G/hxlIO79aiKAevt2PWFdH6bcAAMzAgm54mCOfco4vYkrdtyjQffl4R+c/5+cSW3
	r2J1g4top603JcP+OCrwhqbkYeKZwqrNOBtjfl/hh1LQu1ao72m+5b0v+D1K0l8x
	kaw4lBurarYiM5oPQK/7AYz/RXekJK71xbBYL+4Lg3Yliw62N8x2XJ5HEh3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772607471; x=1772693871; bh=3vQmXsfeDY4sdIhSxgFUcT+LDBOnyJkhM/X
	PG7Hz+tA=; b=c4GFxeYm0lfsQYswLLVmYI7ExiyOMAMe0NZuJQ3lkAJUZE/1iyk
	CPyT5XwUjS/JiucFIvasd8STxC857coKlMwnyz7BtyMb+lQf1bJvuo8On2xXwfC2
	jYvQn02bjSVo8MEYPgHDIQu2W3jU6NGMHnCfILkB0U5eJc2HHQsxj9C1WsDPIeLN
	YSQtQ2eeHCsM/r1Jnf+BAlBi9R3EjXe0v4467LDmeTPIwj8ZbGHqQjrKKEKIdPon
	KzDSGjRXs3o66JJaXciF65tCyINBzwQASHnT9RxkLD1aRQFz9q5XFxBHvtvNPPph
	LsQrx96n+qfUHPtK+Ek5DXZX9IdtdGW/qHA==
X-ME-Sender: <xms:7tenaU5sleZaFdtsw0QgJ0TcITnvWR2rPXu0k4TKUPjqbLph3WxS0Q>
    <xme:7tenadUop5rroe16ubdH6BETiZc2_YSUddxmFcwBXAGHipIpNKuDzZ01AlpTuT1Bz
    nwde9qUDCFSDX6IKObS-DPhzkU7pOTbzv75JDj7xvoSHzummsGDlQ>
X-ME-Received: <xmr:7tenaQ3JtZY5ivf56LEJAfJtpWrGRM5hj1Sm1QFrht5tXdsb1_5TfBS7JCLbjdcGTsJW1IFpLd2rmEoJMA2LsmC6pcLSGQ7ukPG_h8PbSDOz_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:7tenaS3MzgQWP5MDcbYbT0xHSawkHSuEGCDi8DQF1MKqqRVkN12vPg>
    <xmx:7tenab_YWoEZUGBHRtZ944ElDmXKJMLbvFbjgCZZDojgg_inPNCOTQ>
    <xmx:7tenaX1kDy-C_lINNLzGHrLeOAD9T6nhquvmNA2qcwhKq7tiJT4hsA>
    <xmx:7tenaQ8h5VSRtTngTUVRw0EsoYgJ5905prD3ZceRgCMUYAmh4aS4NQ>
    <xmx:79enaVVPG15GdnWlKo7JL2Yy8JB17ala6r09NUS350ruXLoYtdQ7fRhe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 01:57:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dcb56232 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 06:57:49 +0000 (UTC)
Date: Wed, 4 Mar 2026 07:57:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] list-objects-filter: use oidmap_clear_with_free()
 for cleanup
Message-ID: <aafX6qva_badx_RM@pks.im>
References: <20260227234213.17633-1-kuforiji98@gmail.com>
 <20260302200018.75731-1-kuforiji98@gmail.com>
 <20260302200018.75731-4-kuforiji98@gmail.com>
 <xmqq7brtyids.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7brtyids.fsf@gitster.g>

On Mon, Mar 02, 2026 at 02:30:07PM -0800, Junio C Hamano wrote:
> Seyi Kuforiji <kuforiji98@gmail.com> writes:
> 
> > diff --git a/list-objects-filter.c b/list-objects-filter.c
> > index 78316e7f90..0038bfaac5 100644
> > --- a/list-objects-filter.c
> > +++ b/list-objects-filter.c
> > @@ -143,6 +143,13 @@ struct seen_map_entry {
> >  	size_t depth;
> >  };
> >  
> > +static void free_seen_map_entry(void *e)
> > +{
> > +	struct seen_map_entry *entry =
> > +		container_of(e, struct seen_map_entry, base);
> > +	free(entry);
> > +}
> 
> As there is *no* extra resources held in seen_map_entry other than
> the shell itself, this step alone does not make the code any clearer
> to follow.  But if we are going to add new members to the structure
> in the future, the story will change and we'll leap the same benefit
> as we saw in [PATCH v2 2/5].

Agreed. But I think with the current status quo I'd rather drop this
patch though as it may otherwise make the reader scratch their head why
we do the exercise in the first place.

Patrick
