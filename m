Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA371D9D70
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459175; cv=none; b=Yq6fmzB9mggL2x4/Ca4d1WdYAE84G1YJoktxDFZQZoHR4bvbp79fHVE7sTS8HdCoAhNuiAzQwUuZtW5youizOwi85Na+8HtgPnbhWTGLeIP76zArxIImuzmxxdE/GMD3R+dUi1Xi4vsohw7IwcryRKgCyWxdztBYLufPyQJKujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459175; c=relaxed/simple;
	bh=TNIHXLDTmCRZe5UxOFzB5Q/D+R1da5cxJh4Ml1YOH9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3paJTx0n/85o+tQdOQ4vKY+HrPThJUeXmVd/VSvJoynAdPLoRuzZ7BeiO/a8629/IQoaunz+d4WB6O+bYzuSPGuToEBcHwj5v6BEumz1iKZhvdGChW2+aqaB1M5DvubVBCicWB0eyUQQp/zwuB5OTfJtR34FKknrER7t75d4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=My3TqCe/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rCtWatW4; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="My3TqCe/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rCtWatW4"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 623481140154;
	Wed,  4 Sep 2024 10:12:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 04 Sep 2024 10:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459172; x=1725545572; bh=ixF0d6W/gG
	7QnRVle8wDfx6N3jpuD2CUy0tSCo2TsSE=; b=My3TqCe/OH1QKdddX2/WeeACy4
	7cowhNizgcQdyg52aMNl6TqrhOOp0/dlh83WY22yJ+SqgNNBNcWprDzySwr1iGr8
	Dir0Ls/WXSvTRGFT42+nxsYAohUGF0bxslEPsL/vZQ63y1w2hSdQWq/0uND4WUHh
	gPKZPogWhZb+saxrfwZmSuQN4FeB8tOQkQ82seG58DuEoK11ia6YLfddjpzZWVQE
	QMSDQMlv/TOqPUB1JZqWlNToxWLxCoCDNXxW0OzbpdbB63SbV/IZUGzC4ytN+UnC
	+kVbBgoZ0CBlR0NJvqm0/EaFN9Lra398stGHAy9lUurlZRUNy3JWJC5AhmAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459172; x=1725545572; bh=ixF0d6W/gG7QnRVle8wDfx6N3jpu
	D2CUy0tSCo2TsSE=; b=rCtWatW4+JNEfYSbuov4OagW812I9MVqMyUCdUrwUVCD
	GFdCJJ/sUGn12SdQIakzp9qKV3JRWRtPlhTj64nKCgw842pB0MNLC+f6YRazZlY6
	uNMO2w73Af2mMfM6748hneZzwp/mMtQXce8PXvQ7QPpaaqf/8ktPGWFcr6pSBV6E
	dG8p/QMPYBkATDiBn3/cL9I/OUHyZgQmJlJSv7a0ODur7HhbJlbWp2Dg55HjspaW
	KusOe+YTrB1VB/6leLnoqFFWGMDNQe01OaiyoB9UrUSQwTj9L5kTUCy7r7A+wvYe
	bYEk2M5aW/V9C+WSpjDJV6Vrr/eDVX2WrRp2TkNQBQ==
X-ME-Sender: <xms:5GrYZvVu59kOvkga5If-EuSb2pW_QMeQjYoiLor08F3zgoIjnrDaeg>
    <xme:5GrYZnl4DL0nh82lMGFYnuVTYAlZTcFHH2TNBPqZWzRAj31xX1bDZSWMMaEncX80F
    xuWcvOK6PGJJQI69Q>
X-ME-Received: <xmr:5GrYZrZZeKc9xIg_2q3hm7eutWUT5lU20PKQ0l3sFMcL2AIudUDnrjRYdVGAMNM3nbFrNhpB7idAT05aBD8XL4OiGkZWJBQSNSt6BXHYslBMTzs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhssggv
    tghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsg
    druggvpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtth
    hopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5GrYZqUigzs2CUgNbWpPwOmn_-3ua6ILn1m2hAgMcjnrTcR48JtNVg>
    <xmx:5GrYZpnCVWq33M3ej8xeJLPx6GfZ1amxXjy6WfDAVozKZScjtL6C7w>
    <xmx:5GrYZnftS-fcIoZdl7X63i1zBBVcsg0wHFOXDMSZYBTYmFJZlixuHw>
    <xmx:5GrYZjGX_kAFWlCHd5PMoVdA4gUi5sdmEBPwInbxd1jjcF24Yex_Dg>
    <xmx:5GrYZqg2atLUdbxL2HjOGEOr-ls1FlWIqAmlpRHsR6MlHMvRibIHz5BV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:12:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f0aad6e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:12:40 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:12:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 00/14] Introduce clar testing framework
Message-ID: <Zthq3tGQAe-0N6C4@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725349234.git.ps@pks.im>
 <b177ffce-f5cb-4df9-8b81-79128f9185d0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b177ffce-f5cb-4df9-8b81-79128f9185d0@gmail.com>

On Wed, Sep 04, 2024 at 02:35:33PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 03/09/2024 10:14, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this is the seventh version fo my patch series that introduces the clar
> > unit testing framework.
> > 
> > Changes compared to v6:
> > 
> >    - Add some explanations for why we introduce clar in the first place
> >      to the second commit message.
> > 
> >    - Split out implementation of the test driver, that is the main
> >      function, into a separate commit.
> > 
> >    - Reimplement argument parsing ourselves. This allows more flexibility
> >      and gets rid of some options that do not make sense for us.
> > 
> >    - Add an empty line between declarations and code.
> > 
> >    - Improve the test messages in ctype tests to also mention our
> >      expectations.
> > 
> >    - Adapt `cl_failf()` to not use `xstrfmt()`, but `snprintf()` with a
> >      static buffer instead.
> 
> I've left some comments on patch 11 which is new. Apart from that range-diff
> looks fine to me.
> 
> Thanks for working on this
> 
> Phillip

Thanks for all your reviews on this series, highly appreciated!

Patrick
