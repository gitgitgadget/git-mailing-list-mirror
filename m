Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76772045AE
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257468; cv=none; b=HztqgI41OYTDUAtgu5RsKeD09ePSPdkwLrq8Mep7X+CVfUoQb6iv7spyDl57+x+arzHsECKap8pZtC60LBYwe0E5QZ7oh7LoNvc8Shd9YVg1P0mofkfBWIh9nGm/9VXmPbmTnBMTgTnFSjMrGlMXunEjDnA6y0Nv9RKPIUMOqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257468; c=relaxed/simple;
	bh=o0GtuykNnL6ZO/b/QKFt1o5CrKcWTeprg4GhjxwZ8xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wt90tpgEIBJ29iBhw6nqhcVKkB4I6SsSX0WsBVM9YDjTZANRevoyftHvDBqLBFNCo+x8jX8JG1YqCspQ16ABo6MDei3PgLTtB43pFGO0U3by9JIM86ou+JaMpb2mJTacpZ4eFkWeHdg6mWUkGcHec1ygc2KwxU3x6sHw/EN5bBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZHVSRhGC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PhlRz1qK; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZHVSRhGC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PhlRz1qK"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id AD9D9114012E;
	Thu,  6 Mar 2025 05:37:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 06 Mar 2025 05:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741257465; x=1741343865; bh=OwjLuISKFg
	FsfixPOIF8q1dGkBJKnDFPtO7qvjxp6R4=; b=ZHVSRhGC7mdIZSHT+VSOLHEuwm
	jFShxgbwhGpJfG/ZapMqRveoOFMm6UPMnEEVqMtrSRDk9UilrK2HBtGWf6sRnvvV
	txZc3Wu2nnjfTXRsx89zC7VqH4r6bYFFxS0WhRjyjG6BWocmQ73Tfp5tX6Z0VyHs
	ncO2R+IDE326Buy2FH6qG9WZzgfYDXVqSDmzRs2+wwbG8C3KMkv6ZHWnvsbQRQv8
	kvs8ujWP/9TainUelzBea8mErJxYSlok5Ul45OzGDW7NSas5Gi2DrqDCg3e9B9kc
	tbYm0NWgcJcjbKM72hsnRcWymVdmA86vh6DQpN3CzVt1GhTGeurqkMEGMh4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741257465; x=1741343865; bh=OwjLuISKFgFsfixPOIF8q1dGkBJKnDFPtO7
	qvjxp6R4=; b=PhlRz1qKJiOHrDuxVDsx5MuB107AGWiaNvUnGEaXrhXAkAfJxZ7
	RqWfLA/XiVe9azlUzKNcdkdtCmFwvWkxatCb68u/ANk6zCk9hWSp84/+49F4G6/T
	LXLxdZTFYOGj6GZ4pDfJAJ0dR4G/XdoTIzH2u656VdLkVWVmdl1Ule3bsOugTZ3Q
	ARcoKiDNWdcNRpA9HGAQ8MzgS/FDcUP3fhEn94ovRL7hBXs778wuzDZwRb31bE83
	Pfzkdp2WSjM2WE54KfuzDjLjvWMhjLN7axSDJEx2TfjpPglvy1c2Bqtse87b2isV
	PUFiJXwSpaS3W4Au4TQEafvWpQ75dmiI5Tw==
X-ME-Sender: <xms:-XrJZ4EqA514HFOnLtLQEanJHza-ozGEog4JJRZNK5udxr-qOOuvzA>
    <xme:-XrJZxUbawcaQzdzhYGue5XI0-n5E2Lba2qpV2o_jcI3Gcgz2dY8sIuV_MOl_oH1q
    oOq_PQ50tuK7bZ5Rg>
X-ME-Received: <xmr:-XrJZyK-q4dd6UxB8eoJhAA3jo7cJWwL0KT9lMyJXd3JJ-Lt6ZWGDmrlQ3SG2MQ38Y1BCAPqpkzyAvVMQGW70BiG6AynlWDQShMHCHxyuKYH7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsthho
    lhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepvddtvdehsehugihprdguvg
X-ME-Proxy: <xmx:-XrJZ6HsLRnp3j0mu1mEqYvVZQZSfiyCTdCa1AwC9tQE9UmFt_YWUA>
    <xmx:-XrJZ-Uq1vn0JdH9HjIIeMaV0-pmXpvqTv8NEO5_4d8d9AXNJ3GDLw>
    <xmx:-XrJZ9OdvGxYAoS2NjYrPPic2OzN9lGgvGGOGEspITud4yxtuIDaUw>
    <xmx:-XrJZ11WPK0pkVUO5ftVp1H8JPjOryjzB2YwLWgRBz00dIc2gS9o2Q>
    <xmx:-XrJZweM3BaVMFYcQGQtVcfJNQQYUvzAlmiJtBDBp34WDBS2b7uctoCp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 05:37:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f1c2e0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 10:37:42 +0000 (UTC)
Date: Thu, 6 Mar 2025 11:37:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Markus Gerstel <2025@uxp.de>,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/6] builtin/reflog: stop storing per-reflog expiry dates
 globally
Message-ID: <Z8l69bRy8PY3Ep9J@pks.im>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
 <20250226-pks-maintenance-reflog-expire-v1-3-a1204a814952@pks.im>
 <usf4pzrp322xvfrvsasgy22rnw7d2a6krzuctwpp23ppdgh6ji@ram73wv5dn54>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <usf4pzrp322xvfrvsasgy22rnw7d2a6krzuctwpp23ppdgh6ji@ram73wv5dn54>

On Tue, Mar 04, 2025 at 05:41:08PM -0600, Justin Tobler wrote:
> On 25/02/26 04:24PM, Patrick Steinhardt wrote:
> > diff --git a/reflog.h b/reflog.h
> > index a9d464bbf8c..b08780a30a7 100644
> > --- a/reflog.h
> > +++ b/reflog.h
> > @@ -2,7 +2,15 @@
> >  #define REFLOG_H
> >  #include "refs.h"
> >  
> > +struct reflog_expire_entry_option {
> > +	struct reflog_expire_entry_option *next;
> > +	timestamp_t expire_total;
> > +	timestamp_t expire_unreachable;
> > +	char pattern[FLEX_ARRAY];
> > +};
> > +
> >  struct reflog_expire_options {
> > +	struct reflog_expire_entry_option *entries, **entries_tail;
> 
> Now we can also store the configured per-reflog-pattern expiry entries
> in the options type instead of relying on global state.
> 
> >  	int stalefix;
> >  	int explicit_expiry;
> >  	timestamp_t default_expire_total;
> 
> Now that all the reflog expiry configuration is contained within
> reflog_expire_options, I wonder if it really makes sense to also keep
> the expire_total and expire_unreachable fields.
> 
> From my understanding these fields are not really for configuration, but
> hold the reflog expiry configuration for the current active reference
> while iterating. This gets set by set_reflog_expiry_param() prior to
> calling refs_reflog_expire(). It seems like this could be figured out
> during refs_reflog_expire() now.

Yes, these fields hold state indeed, namely the value for a given
refname. These fields thus need to be updated for every refname for
which you want to check expiration, which is done by calling
`reflog_expire_options_set_refname()`. This interfaces is extremely
awkward from my perspective, and it would be very much preferable to
instead have an interface that, given the options and a refname as
parameters, tells you whether the reflog contains entries that should be
pruned.

In fact, I did have a look at fixing this awkward interface, but it
always ended up with way more changes than I felt comfortable with. So I
decided to only go a couple steps into the direction of better
encapsulation, but to not fix all of the design issues with the current
interface.

Patrick
