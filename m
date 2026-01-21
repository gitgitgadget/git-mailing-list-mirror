Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE013DA7FF
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768981161; cv=none; b=EQH6At5AnARXTn6hyklIG3xyksUJlxkOtBG7VrPwNrKsXksKo9o4vr+7/cIGPNwJc8PNplk2bMLoXgsGMDdyIkfXBzTLA+yX1Nxg/w4OPaXTib2wcwO842AsQP9uSLLiwaDC+5C2M3B7U8x/a5+bje24Ve12+tv9sKN/IoMRXlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768981161; c=relaxed/simple;
	bh=rQIJdFcdSkYHHyTpl7OXd2hj7d3XqRx0gkIX90+6G7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKxxhmxua/XBUS3Xey3MHZAtUX5lFNtDYrkgxpg5/2WgwGyXRminKQTf5UKbNmjJwoCQsx92loptuSNkkobbiarNqT8YTjChcJ+aS5iT1zjLugvRK0FeR8toznVM0ZbnUxRqX5TcTvkbAgZ4eOAl1MICkpsFSwTT/OSBl9529v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=joiLhLvD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AQPGW4JG; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="joiLhLvD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AQPGW4JG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 55C221D00125;
	Wed, 21 Jan 2026 02:39:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 21 Jan 2026 02:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768981158; x=1769067558; bh=t8V4WfTnsH
	DZf5L10c4SMDwCremPZNfu8FZ/h2q1yOc=; b=joiLhLvDgiyNMYg9eScAPkAjJy
	GM7QJefU3FGVaMsD3N3BY9phVNmeAUmKiXiJCM2gjxcYWgYHw57SFDtbTpYgr+YX
	YbsFztz7ysjCTV8OXFHTdOTM1KQdaVmP0l9xKz/gBquZd9eG4RHlrErclUysgzps
	fLAFJo9kSi91srwhKLFoaPoRnypg2Eona6aBa2SHQwZndrqUqTO+HcQTQZN4DzaG
	NV9LhWtrFn0SPS5ejTEruqQaFVTaNSAfxQi/4KZCUrSlFBIxD8OuXPhYQIb4GSBk
	Tvl7QJt6wbivDfMmt7dGUSPSYOZ/6rB1aL4iIGgBieXHlQFW9s8y1edNXkkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768981158; x=1769067558; bh=t8V4WfTnsHDZf5L10c4SMDwCremPZNfu8FZ
	/h2q1yOc=; b=AQPGW4JGfVvGe4uw4rjEOqBIYISYDqc+/s028P/AWvbUOqhaFu8
	en+z7l2d5elpieEkSSjZ06yf23SOflI9ZbPTzETiWHhjUn1MGfwVoFF2jxF5L/79
	WiWZ4nXh0+lq/VhwILLFH4yCccuQI1YTNZAFYGHVkwxAghJ4+u8pw2yPRV5xHxhQ
	0vRhM7WJUWuxEXDCaSTFT7RdulYjAh5rKhCfR9AVBWTViNNpo53IiYWQkft1U6qg
	xsJurhNcZ2lKwZJOejyXug58gdligvz49WzBDbg6S2Ub5AWNAa2xMfdTgHKiNlP9
	wB8ylSjM/8dZXJAPHxBl8OrPpbvGZnSzKcw==
X-ME-Sender: <xms:poJwaaZqrJivBl5ve3U_qipLD6-L8BRU4tdZVtmSbQ3H6kob3IXVGg>
    <xme:poJwaTYs1gaMEOfCR3oExT8Gw4O2LqnOoDzFsm1nYsbur6ZqIuu6nqK9kIegHzI9n
    VFPVDZ7hySnlEAGavtL_1Qo4aN3Z2QrMBmzwImB8Zo9SI86SUEq>
X-ME-Received: <xmr:poJwaSlN-h7VhzwirC7yK25qKsEMkeNmm7giFrXDlO5MqDzECfMHBdM8QbSgFiS8qnEI9ZpvHJDiZlie_FKlxAQgtQjs2L-DYJDSWkNvv2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:poJwaXz5i-leqm9NY73xk8lUXOj6qUmsWJx22WpkWrJzhn9hQg5WrQ>
    <xmx:poJwaYMf1aKNwF8ckmAEgNB1zKjaRk-DfrFSXUM-VvWx4RigTUkPfw>
    <xmx:poJwaTQIahMA1_pT0k9Ef9RgyVl5DoSMbNrFEIwyxkjr4ecWjuvADw>
    <xmx:poJwaeboCAuSTE3XUXbk--4F3rbDOxISSaooHqxOHwjGmiBYXm5v7w>
    <xmx:poJwaQIgY5vQRZt2MGjEdzYhReORgsYodLXXu6w-ZUB7XQR2BjxcqC71>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 02:39:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 91ac15c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 07:39:15 +0000 (UTC)
Date: Wed, 21 Jan 2026 08:39:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/14] odb: introduce `odb_for_each_object()`
Message-ID: <aXCCoI76k2zjioWb@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-7-5418a91d5d99@pks.im>
 <CAOLa=ZSgODbmRAHopGejyr1swhDzRa9rccM8TBc3CW=WkRe=pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSgODbmRAHopGejyr1swhDzRa9rccM8TBc3CW=WkRe=pw@mail.gmail.com>

On Tue, Jan 20, 2026 at 09:20:05AM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
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
> 
> Super-Nit: This is for the callback function. It would be nice to be
> explicit about that.

Makes sense indeed, will change.

Patrick
