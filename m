Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C371E495
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604764; cv=none; b=awn94zfb/fe1BWylBWh7EQWQywO/ij7FIV7MO3xrjdJ/zMT4jkRidWRWp0pPSiTWlJO6IIDQe6MNjcEPJGKhTspWqtfJBuBRvXqI4o9TZvMPc2Hk6Zq0U2lGneTjPBUyzc08nL0uhfPhOkCftZmpA+EcR0rQVal3i7Zlo2DsOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604764; c=relaxed/simple;
	bh=dKcYnCXc65PRI/3QBpLndKDzWwasatRQ5lWWmHtEbKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw+gnVh6uMp+mHSwRRfKuNbRJVxVf3nYBbN3cnn1H8aKppf/w2TLqtvPpckWmQCQvogaISPfGgsSt43FGnjCxOilgEG986vlnoJIevsIXRgyeugkPPqbWRX6UuSWF7JE+/im25DKZJuhDA7jSTyCuOIy/iJ/PhVNdv4XOgaZJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=2mOGr82n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CxfPQdsm; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="2mOGr82n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CxfPQdsm"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8248D11400B0;
	Tue, 22 Oct 2024 09:46:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 22 Oct 2024 09:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729604760;
	 x=1729691160; bh=gjIweVld8BteC1mrjAMVz0SMcTMXaIYU6hyxwMu29O0=; b=
	2mOGr82nzr1wh+QPbpl4RA8G79qbZSkl1yJEk5ok9cc2bzahG5qaN979Zu4GJAlr
	tAD5P7adNzcMCjSqNfWrmpODiwLPam1tFOHH0IbvOSk7GMEYbu4h7LbqD9tn2h2J
	3sLsOoh232d3JB6gL+iPQEajf01AUUMFzB29BtIQEvv/ctkTlQEq0fKsn3AcCrXK
	PSR+8KgWrWJKd3uFmwhAUJkS5VPFVQq8uVxw5yDJlw4bDeGs7l++enja5emgaqcD
	v0iHVwCdSNAkWHF7Qpr7yoNHusOdtlupNCNf6SSiM4fMB9QBqvz7L0480rwL3ZNN
	Ptgs0mxxxykuOdkww72q0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729604760; x=
	1729691160; bh=gjIweVld8BteC1mrjAMVz0SMcTMXaIYU6hyxwMu29O0=; b=C
	xfPQdsmX7h3uXAyUCn/OIb6DalljxW7mprpfxI1mlWIm2wUvly0CWafA8uWnKxEv
	76GRvsDVOGJrCQBobDbMVvMcIbpZkBmQYWfezTEoVvKm4tcU4dxh58WpmmbG9rsV
	wU52igTVtoJjziDWQhoaGTHMCIGq9PTP/RtP3kAADYqsCqAiCFunhGD7IaU81IfV
	ci3fVnixTs/hKXa533zAgXSYJpMIz2UAa0dqNeyeju4Fh1nsAtdyNCoF2Yle9ccv
	3s+ce+lzTgXJYZHnHPD27QptRPxeJrPhZTgV1UHEh4Yp/XGwzs43so3gdiJ7K3oN
	H7ydtno3ewSKThEV8Yahg==
X-ME-Sender: <xms:mKwXZ8fTSFUx62JK3Gvoi4FA-MU0aYeD-BY1SOzpqY6TCubLdNi_8Q>
    <xme:mKwXZ-MRsdP5PascMaThDP8Ry8uFuTpJM1-cQ12sd4052nvRnNrG4H5SY2M5fYqMY
    qfbIBoZxeMs-z8gVw>
X-ME-Received: <xmr:mKwXZ9jnGoeZ8uXj-xLvKP49C0QPxhw-IkD3AFqA5CB9sGoBzDE99Ftc3CWCXEF15Weu4exlwH0q8myshLolO30WlfuaKmIP6iTIt0WvPG10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mKwXZx8zxAIysocahgbE0mc4XycsbwU4OHHRcg2CmKOWvUC_4sll8g>
    <xmx:mKwXZ4tiT7J8wQUWoHrZQI6LNshbOx_rrjManuisUVR2OOiAoEFVKQ>
    <xmx:mKwXZ4FzYCHkhxO6HRqHmXqCzEMp71-bjqExKvYgslWY1E9dG2_PEg>
    <xmx:mKwXZ3OlYKkyb0lHOgYgx3nW8ZUt_eU0AoxFxGpHv5wjJXltCoxYoQ>
    <xmx:mKwXZ0Joeeu2rll0TqLT0IP-eRruA4nHlImqp0ZvmAb2fzlidGP4hV_H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 09:45:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7a1eeedb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 22 Oct 2024 13:44:29 +0000 (UTC)
Date: Tue, 22 Oct 2024 15:45:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [Outreachy][RFC]: Final Applications expectations.
Message-ID: <Zxesj10G3bn27d99@pks.im>
References: <CAPSxiM-kf8U=vzp5MoD3tUuOtnNjcCgPhLdriyeQo5CGf=EhyQ@mail.gmail.com>
 <ZxeWDTFHpHmVePdF@pks.im>
 <CAPSxiM9WQMFu+qTgR9LPk9erVUFgPU5tqRBobTomOJhm-hiLAw@mail.gmail.com>
 <ZxelBccIFk1aXP3l@pks.im>
 <CAPSxiM8bu9LErD8H13_qgb+MV224TbEFzkSr4f74YxEL3Sg7+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM8bu9LErD8H13_qgb+MV224TbEFzkSr4f74YxEL3Sg7+Q@mail.gmail.com>

On Tue, Oct 22, 2024 at 01:39:21PM +0000, Usman Akinyemi wrote:
> On Tue, Oct 22, 2024 at 1:13 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Oct 22, 2024 at 12:54:18PM +0000, Usman Akinyemi wrote:
> > > On Tue, Oct 22, 2024 at 12:10 PM Patrick Steinhardt <ps@pks.im> wrote:
> > > > On Tue, Oct 22, 2024 at 11:45:14AM +0000, Usman Akinyemi wrote:
> > > Hi Patrick, thanks for your reply. As you may know, Outreachy has a
> > > kind of form for submitting applications (they have some set of
> > > questions someone has to provide answers to)not like GSOC where the
> > > applicants do not fill any form for their proposal application. I am
> > > guessing someone should add something  like self-presentation in
> > > answer to one of the questions as there is not really any question
> > > asking about someone personally. I think what is near to it is about
> > > previous experience.
> >
> > I wasn't aware :) But agreed, previous experience sounds close enough to
> > me.
> >
> > > Also, anything about applying to two projects ?
> >
> > That is a good question. The only thing I could find on this was the
> > following statement:
> >
> >     > You are welcome to apply to Outreachy multiple times. However, you
> >     > can only be accepted as an Outreachy intern once.
> >
> > I'm not a 100% sure whether this means that you can apply to multiple
> > projects or whether it means that you can apply to Outreachy multiple
> > years until your proposal gets accepted.
> Applying to multiple projects is accepted by Outreachy I think, as
> someone can submit an application separately for each of the projects
> in a community. I am just curious if Git has anything regarding it.

Ah, our mails crossed. In any case, I don't think we have anything on
this in the Git project. But if you apply to multiple Git projects I'd
strongly recommend to state which of those projects you prefer to work
on so that we can make an informed decision here.

Patrick
