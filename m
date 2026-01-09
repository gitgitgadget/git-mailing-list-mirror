Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253A218E91
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767939476; cv=none; b=T7atrQrT+mDU1XqIIFcIlp4m60iw7dAeMRcZB7pdfEFzwr8u5miIDLoQAU0mNezQLOWtLi5xaVDTEL2AXAN0yYQlC5LvNxlzauqmF0zjBrWehg/yKFGXllhx7hd/CtQPkBJIw3c+ARrS/v21M/HGPw/hKFv8xTLfu/uNeqJ2q2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767939476; c=relaxed/simple;
	bh=59mjkmG8CniomTdYJQwFY052Rl5uFukdJqgdfmrtiso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7kZ/MwJMHsWpF8EwMIKCahzFQGTRaBA44vGYpdgJ81CAzzpBC53wmL1XBZU3r6LY17d+6brVWxmIJbXxpSeHK3FXQAEXeFYbatfINMhWz43gR4jL7SQ9JifPEY+C+/jJIxFyH29FvgcPnpIQvub1KV8qj8TSXusDk4BAL7KQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jKS1JrTZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jesxK2F2; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jKS1JrTZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jesxK2F2"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 111ED1400126;
	Fri,  9 Jan 2026 01:17:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 09 Jan 2026 01:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767939474; x=1768025874; bh=0nlqZvyJ3T
	/JKLQPXhR4v9YWS4XzRnZHPf/vITrQ234=; b=jKS1JrTZjIfBcKndF/6tL3+RwM
	8w1f4dmMZlQFJZj1rHtaFxIH9ScHmPkC5QHEQ3O4fp3X7kqDjo5CTOHjX1yGPm/4
	6fLnW9t+7yIIWb2klh+cADfr7xUlPQ3fo7SwZALsWuRLvE6uJzNY5f+HoGAjhjID
	l2Xh8XpLibyaLQtZ1EgY/ZDG0gANa8uCVipFnipxx2aJZPcicWtv99nHNIcQLJF9
	jLWT0uSCoC+jxGd37RVFTuShDwc06N6j5usbJj1In6/Jzyggv5BjQDvUfnO8MwSi
	/6PYEjgNLq8cQfCqiqVS32bJVLFV/ce5GvzLqSCh2MH8UsZME3mX2YriXCCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767939474; x=1768025874; bh=0nlqZvyJ3T/JKLQPXhR4v9YWS4XzRnZHPf/
	vITrQ234=; b=jesxK2F2SN0jHd7lpPGx7QXN3fPBWQI306JGkSfaMRNiOctJNz2
	eSC/wwM/OmaFDvXs2i/2j//KfiIVo0Z69+IMFZp8MVIHweHKm31Ebc8xYQNX6Qbh
	h5WUsIQ1+bmqyACGKp24FxUTA9AkOFNwEB/HKj9SuQ3MIzsRt3XZXafE98NchO4E
	sp4HITTllcut968trPUFwbhpX//fdphAWpmoADQmFxpJPpl0Ab+AVm57FLQKLrug
	BTeKzY/m6agocNoM74WDXQGeVVIW/7WPU7IddVewEo66L7mZt980l1IA+nr7HJa4
	9rMV33HLgd+URLOo4WvfgJ3VBolwmVnqIlA==
X-ME-Sender: <xms:kZ1gaUoLAlisVovHGEvEguxOrSSPoRmEN6mqpwUl9W5ukU7M5QfnZQ>
    <xme:kZ1gaSFCDZXL73O2dDfu71j-v0RZ36EMxZ8zavm6NCRB8t-_fJz0sbQV3-0OEuFw-
    7_lr5yJV7IHYYqFijm666uQzn9JmVKdxT2NEphB53JW_19uItbd1ek>
X-ME-Received: <xmr:kZ1gaWnW-CjdBgSuPQIxJoSJfogBU5IypAg8ObjnHatOW3EAOp-Zp_-2iCXWMzPw6Yvrq1sPaNMyB-qa13wp-kRIRe93qUEhv2q3lnm0Rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdektdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:kZ1gaVkkLKIhGThAHD1XVKnVcRr5vLds7ndCZHvml1-C2iMgXBb9EA>
    <xmx:kZ1gaXvr4M-kJc5k0FnT6aSfD4lUQeaRXvxOKcXmSx_TGQHxVST3eg>
    <xmx:kZ1gaYlGSmD8EASFhQr2M-u4C3car13jZqm4IunF9qExwTKW0V3DPA>
    <xmx:kZ1gaSsoHv0Y6zLmhEvVCABce8RVJz0HjSbCqvAnLcJiOc67a5s40A>
    <xmx:kp1gaTMIqc6jjRVhKJcL4hDF9w04_NHwZPnML38BfFlqfKNQUyYeLWAN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 01:17:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3232b2a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 06:17:51 +0000 (UTC)
Date: Fri, 9 Jan 2026 07:17:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 08/10] packfile: inline `find_kept_pack_entry()`
Message-ID: <aWCdjDF_eJAmvNoZ@pks.im>
References: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
 <20251218-b4-pks-pack-store-via-source-v2-8-62849007ce21@pks.im>
 <76bd89da-462a-4eb4-86b0-915f649629c8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76bd89da-462a-4eb4-86b0-915f649629c8@app.fastmail.com>

On Thu, Jan 08, 2026 at 08:16:37AM +0100, Kristoffer Haugsbakk wrote:
> On Thu, Dec 18, 2025, at 07:55, Patrick Steinhardt wrote:
> > The `find_kept_pack_entry()` function is only used in
> > `has_oject_kept_pack()`, which is only a trivial wrapper itself. Inline
> 
> s/has_oject_kept_pack/has_object_kept_pack/

Thanks, I've fixed this up locally. Will send out once I've got more
feedback on this version.

Patrick
