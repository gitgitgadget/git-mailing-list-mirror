Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF01F872F
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455312; cv=none; b=gA9lJpwu+NSUqAs6FK9JV2mSEYVRlU84J4j0vQEC3yFkbsJXtjhI6aw1KfJSmLez5cAQkpozhgdyjtB2eKsH5xgVLF+iG4DzmlsqCpLDZFilISoGqiuAdTr0rzGlEMFhlciTwhmTySX8qU8pLYQ5azUCcruJTm7Wb1DYi8FBUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455312; c=relaxed/simple;
	bh=RJbUHR0omOtv3Eox53vkOepDPwisAWXTL4eat8xk0E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLF1LiH/RI56ZGlRDKMw1w0rJ8iVThXmQ0YHov+rWUAz/d+ceERoL4vodRKCswmF4hqEZCETHzYfTj49osPEVvbwz32Qtu/AqH/L577i99FVBQ+6ATsApqB3/VMM+DgyWdWYj4bWB4j/+gjFb2H9iTL6jcXeTci42OJcs4S11ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QV3YNJBb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sx9NtypX; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QV3YNJBb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sx9NtypX"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1447B25401A7;
	Thu, 20 Mar 2025 03:21:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 20 Mar 2025 03:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742455308; x=1742541708; bh=3kvObRChxB
	A2GdGbOJz+VLcNcBmyAG4szSANWGwvMOs=; b=QV3YNJBbgzN5rBXpk1D0oZtQnO
	22Z8yJ1dPQbiM6KfXvH6jsb7zHLZCMZfnuQSFFfL52OIKjOenvFiA0Ee8KgSbrET
	BGen2elHZZGrL/eGrq2wOkjnILn9fP1z2iP1bPeZK9B6WPX3nB5tFwMO+4A6xM/j
	0TmbynxPKRqzXxWztDSo33zLccs/y5stoPAN6HxXg09nx5AGBryWG8Nff6pcfmA0
	Cw/UEf2aUl3EauHpaR5tiXw236gUMtF9ljKdMKQahUdZqLKoUYty3Lz/6UTQn6tx
	DiyrB/obcQHyvhxq3CtwwYlPKIxPM4pMvm25fIScQ8n3u+lNF9tOyhFZkyGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742455308; x=1742541708; bh=3kvObRChxBA2GdGbOJz+VLcNcBmyAG4szSA
	NWGwvMOs=; b=Sx9NtypXcb+awC3i1vbeB5qRPk4LJ4TLVECSm5LKxAvgMBK7hS/
	uEwrqMAkgFPp9aKpGDrgUANshDTKJACcYnn4wffWKTwu8mcQMcPnoT7ercp/sZoO
	zmCoeAXVzbRJ40inb513AQ7bjgPN3qyGM9mnynfeE7VnoGFY/eLB6/XcEBP+mtii
	JzUwoK+Vt58hSQKZR9hh6KLDYTCTj93J9nmaa5+6gbdkJz87IKPIP5cboErxEA4h
	gl+v8zyoVcNFvnk3nAYbkbOqt9aCoC7MKk2tYUXr+XjYdzGUWIGsvgte59bFPUeV
	/Lh7pOzb5WPjBPhUUo0go/KRJNEWOrNwl7w==
X-ME-Sender: <xms:DMLbZ31ub2Gy_-TdthO-VgkToUfHWLTkSJ0KmXHsQAcm8TBpYYr1NQ>
    <xme:DMLbZ2F16CLuQ1848PWRszRwC_6DrgTI3533pYDEPsiOUadYbnISN0iD-yixElUNL
    YTq0eTDcSQ283b9LQ>
X-ME-Received: <xmr:DMLbZ354OwHjxCJMURzymF4POaT62HDj23szF57895LKM7mMxQoKehsusex1v1jMxl6asrVb1Kk_2wfKhN1-XeNAS7ihY97HVncHJ8NR0Sq0nzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhm
    rghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehush
    hmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:DMLbZ83tnpHpxAag-JTNZuqHCNCEwDE_hE6mWhsQi0TJxjuLrfFjXQ>
    <xmx:DMLbZ6EykQWL6mRrrwsw6yRH5Fojs4XykVwdyVPGmqnkCNRx8kHbvg>
    <xmx:DMLbZ9_QoZ0WFX_ONFEnNqE0BPs7JGO0MkbDZgMsstR-JXcuTnac_A>
    <xmx:DMLbZ3nav-EFGADcz6Ig1MZe8OTAZVJNf45uAc8VQz0IYImpRaICyg>
    <xmx:DMLbZ9AbL_WsWI9Cpex8nGo7VcZSa4H8yd9F9BZy5sgsJTGsZegvzmkF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 03:21:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f96e5c91 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 07:21:46 +0000 (UTC)
Date: Thu, 20 Mar 2025 08:21:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johncai86@gmail.com, me@ttaylorr.com, phillip.wood123@gmail.com,
	shejialuo@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 9/9] builtin/update-server-info: remove unnecessary if
 statement
Message-ID: <Z9vCCfZJBsyp8Y3-@pks.im>
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
 <20250318115912.2978992-10-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318115912.2978992-10-usmanakinyemi202@gmail.com>

On Tue, Mar 18, 2025 at 05:29:01PM +0530, Usman Akinyemi wrote:
> Since we already teach the `repo_config()` to allow `repo`
> to be NULL, no need to check if `repo` is NULL before calling
> `repo_config()`.

I think it would be preferable to reorder this patch so that it comes
immediately after the one where you adapt `repo_config()`.

We also have a couple of additional sites where we call the function
conditionally:

  - builtin/add.c
  - builtin/difftool.c
  - builtin/update-server-info.c

It would probably make sense to also adapt those.

Patrick
