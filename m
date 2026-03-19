Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BB719CC0C
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773904789; cv=none; b=e6QTP/RunU/HFFh5e4wgqDh8GhyEpIQYnxRjoFHuvHfbrkcRSikFLKUEUU4vu/nPQeJmSgt7o10+qaPvOqiDjJIRcT1wTblqlqgHcsZGaDJtGmSxFdrrzmLQKHyya0Q5URVNZxo4FUQJOY/d6jtFVlO3KP/5ZFWXE7BtMRvtnJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773904789; c=relaxed/simple;
	bh=c5aeX9ELTiNDyPZtUAdbVnFXWM8mqvo32tfewvI4rhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3F/GHU7i/YBsUBZGQkIquBXyJx+cfmpTKcV+4bfCBPqQO3IBvcevpPY3wAvDPTuRPdtpTdNGuI5IBEMIIIBHgupLe1iPTRyIpXFuS242ghQ4eIrmNxfIbaHB6ZYRh47De5xzUxkfrv2ZnqqlF1vFf22diPwZeXejabxX5TLRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bl9JWXpX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j98VzvdF; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bl9JWXpX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j98VzvdF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 61C311400049;
	Thu, 19 Mar 2026 03:19:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 19 Mar 2026 03:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773904787;
	 x=1773991187; bh=AR6LKWlHrsLhgxLDYpgjol5fx2RfrmPYSwyLv34LtLk=; b=
	Bl9JWXpXA9UdYS0i4zXQrEoMPkT4x6vCqz/jrxr8hhkneVJJu8fHZbzEJ+woXcAk
	POUx1loSwIgky8JYrXSzSDLtoJ+NYTi8lVVrsp43+2ZTWDcCR4REm+BFSXMzWHUo
	7wjQtmrwHE0uq2xKHAGXT/i65PlJcE+XRmQa54Tu7nElaE+c7J1s1za4CsH5/EJU
	cTwdrnora8QOS8BxcSGtdxVJGSJJahWqlckMEiLYNFxSXkVOhSLl0R1nX9dWhvhD
	sqQtgjcM/0CxN1PKNkBVAp0zzIytsNEwwL/pYRrTmQyn2sg6EJjJIZYLzzHdml6t
	/7Lz3FJLwclkkLHviMBuUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773904787; x=
	1773991187; bh=AR6LKWlHrsLhgxLDYpgjol5fx2RfrmPYSwyLv34LtLk=; b=j
	98VzvdFyRqtFcP1UVioufxLkweGGnJE3OakpNo17jGlcX2bEaKDOpMbVZowtTXeQ
	8qgBnsCaNERYLhP46JuLhg7At4+AiB39iI5EWOf/+45FeI9TUosi4zJxrIRwihuP
	uhf/mGgw///khWLqOgLl6PUoWuy7XDvWHhmSvE64brXf4mEK8fZpDwoIi6hfZ0VI
	q1PHS4t837+aDyUapxOsUWVG/+tKk37taKywRO8JQDXhnN7bAuxR2J18vNo111ZX
	GMan1QT99Z3HJXLAIzvm6JGE1vRCKbyEm7+gLjxJzSU2iTFLr/dg6KgsuBm5lw2l
	R0MJWZq0vQ3Ex9ZatKdeg==
X-ME-Sender: <xms:k6O7afUuRCurAdf5kDlzP1ojyQJC0nEtioJusMnDACH6OEQT6D7EdA>
    <xme:k6O7adm7p0YSLjLpjGjmNEXSX_9ItP0B6cU6Z4S_BxAm9JJqLeMVI2DotlF_KjZSM
    j5M6arvIFdIx3YCWPsUjxcjH8vD1dS9aJ0TuIXK3M7olP3Wv-0xzg>
X-ME-Received: <xmr:k6O7aZDnhFYPxoxkm4-1cC_zWKZmAMeKpBGSH5iaWyWvZrN4RQgSnQLsLhbVqxO_POOX93cCyJu1mHKQSjZXUJpNUsV-oEMWKCB88dYvF-fR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:k6O7aVdBPL9t-5SPfTAlPbibE1SjwfSw0_UXWPiBo4BFUvgzQ8zkHA>
    <xmx:k6O7acJ5Vif1r8EyBye3bEAmI22n3inc4VChvxM-oeTA22cgb7UqCw>
    <xmx:k6O7aQcPpomF3Y4bBvSr5ewJ7hL4wmUUSgNq6_mWTwtdmyb4JvoMRQ>
    <xmx:k6O7ab1iPZXe3xowylt9NhUp9eNusTMNplqJpJguu1cv0e9FNXMYfQ>
    <xmx:k6O7aavbLJJeIHXjyR6WIy0iorZYiJ0fCgLaV0baxvvEXtny7kl6AWoV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 03:19:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af897b5b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 07:19:45 +0000 (UTC)
Date: Thu, 19 Mar 2026 08:19:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] use commit_stack instead of prio_queue in LIFO mode
Message-ID: <abujjg-8hwPPlkMU@pks.im>
References: <05fc946f-6670-46e9-a058-231ee464029d@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05fc946f-6670-46e9-a058-231ee464029d@web.de>

On Tue, Mar 17, 2026 at 10:40:07PM +0100, René Scharfe wrote:
> A prio_queue with a NULL compare function acts as a stack -- the last
> element in is the first one out (LIFO).  Use an actual commit_stack
> instead where possible, as it documents the behavior better, provides
> type safety and saves some memory because prio_queue stores an
> additional tie-breaking counter per element.

Right. I doubt that the memory improvement will really make much of a
difference, but I agree that using a commit stack makes the intent
clearer.

The changes all look as expected to me. Thanks!

Patrick
