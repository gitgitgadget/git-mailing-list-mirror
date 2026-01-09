Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0142212FB3
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975541; cv=none; b=jon0thL2svYIJtFjdOu96zt1X/th19NoHSUpbhfxHAuvzIKjXrFJMvTjlAAO5ISCORggLS2udP+PW21WA5Dh1rEXjM9e2WS3MgoMaG9lFprgyosLKCNYhIapBf0uZBsTvhJsX5enerYkO8Vz2jcHtWRW/wc6LLfsACLZ2UKnRnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975541; c=relaxed/simple;
	bh=elnvp+XUocv9LGCAa8KPyDqteHBuW7A6MbDduTBhv1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEcRAs3iBuDcCHhpBD6knz6Ff6wxdJKASk1uZHIP8aiweejz2LTZC2Yb78wIi3gm/Fgus5ZMNu3qeJITx9aFLew8mpaWcld5QuKj5FY+vMxg71B7LEGfwDXxZP3EtgbM5SI+OfxREu+26O6vSUbPIwjnWfedbY7zP93ygtnZ9n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iHWjsMvV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PJiA8YFv; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iHWjsMvV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PJiA8YFv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D9EED7A0125;
	Fri,  9 Jan 2026 11:18:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 11:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767975539;
	 x=1768061939; bh=deuc79eh5leBSX46vMhLbP539GxeRmUkWA8Rtd7YzTQ=; b=
	iHWjsMvVXZItlN1BxHRSchGsDfQGlTQeLeco05s22Qq4/3QvZPXSaLOJ7dnpqFjk
	FNItmviQTRTEqqan0a3Vx+Jor23nfCI/qnDm87L7P3T+j8oyfdIMz77s8ogg3EVE
	G4K9IX2sg0HteBfOzGFGN5nI6+aXQiG+S2E5T87bpyw90XP1FmmhlnEgKEonRQYA
	pJTHmkvQpmRkc4NoVao8YhLdtFZxQosDxpaDEDRekmIOeYE/qQALS7FrvG98lsvq
	ZOS8iiFk8Fw4gz4U40YEZPTjnjEfP3gwEOExpTAXWz/3Qb4Xp9fvgQYbYSTS/W/O
	LIt097O8iKJF60Rxh4t9mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767975539; x=
	1768061939; bh=deuc79eh5leBSX46vMhLbP539GxeRmUkWA8Rtd7YzTQ=; b=P
	JiA8YFvzdFZEXciYHuqnBEECKH329sl8zBZh01FSVpYFwcqDLSoCtzTnTmXORv31
	9tdt34ffvtIIHZzZVs2CvUjgEMozeM4h6/oeoLsgggTOGFThoD18nrLV8TDuYaqa
	EwukE1kAG/W8hI1Ei7T1M0kuktdGeJVHuXE1kfi6FW+qKsvkVTfA35p2ZLT/yyF1
	l98YhlJAeUpHisCjUNN5FLpim/g2cicINSPbNYEjbn8qg8I31lSGIwLQcmyGpwo5
	IP/HLOnSG1XctoHSvATJBpfr8WcwGUcg9JPYFR8DQ5AUrGkqEn7KkexFiDdX8ZGt
	vYnBmDW8eaxFL5nfgFaBg==
X-ME-Sender: <xms:cyphaeqozeyrPx3tTtIfbE1KjllRICkfqqTSOcYWLQKD4P5OzKjAtQ>
    <xme:cyphaTroOaABvtMtKlr8qYzPUwhjU3dkYS3kKRzy9M8544iDZFeZvF8dLkYzRbsaO
    Vjhndk8wm2Ox6DfpFznciCOs8OhBSRb_BbNrJUDsvHaP_qZDYNkyg>
X-ME-Received: <xmr:cyphaYMKrg7nr2fqhd90bXDAg9V96B4sjpBiF-PvTEPbej4IJ0ZgTaG7GGCNc96Lnwrh20fyKuZAvXSAB2Xdd78avL2C-jI5LPnzh8DnNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtmhhlihhsthhssehsvghnthdrtghomhdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgho
    lhhlrggsohhrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:cyphacw5cMFVBP-p7W9fVscNGgv4o1YjdoxMytr367wIehs-3u_uDg>
    <xmx:cyphaZsZBw7vHryF7uc1NqX405kanIk_hZ9uQt0mFwDKiGQ1FPp6hQ>
    <xmx:cyphad52ga2K9984LbtsQY6BEV6q6DTny1upPAa5N9NzfIUy8CvrjQ>
    <xmx:cyphaQQkftEmkY3b9XdIxg3xwSWYdSq__HO9FRELasNPWCJ2Y1AHLA>
    <xmx:cyphaWe8rhrO7FNXvB37KYedNjfIT3rP2BOumn9qplCs6A9lVKAPSvw2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 11:18:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a08d572 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 16:18:57 +0000 (UTC)
Date: Fri, 9 Jan 2026 17:18:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: correctmost <cmlists@sent.com>, git@vger.kernel.org,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: Re: [Bug] hook: -Wanalyzer-deref-before-check warning in
 run_hooks_opt
Message-ID: <aWEqbqPRq5Ie9XTo@pks.im>
References: <aWDm_n2YgjvaRmpV@pks.im>
 <7BD989A0-30B1-418E-9257-1731724DCB72@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7BD989A0-30B1-418E-9257-1731724DCB72@gmail.com>

On Fri, Jan 09, 2026 at 11:02:40AM -0500, Ben Knoble wrote:
> 
> > Le 9 janv. 2026 à 06:31, Patrick Steinhardt <ps@pks.im> a écrit :
> 
> [snip]
> 
> > And we'd reliably
> > segfault anyway if we dereference the pointer, even though we would not
> > get a clean error message. Not sure whether that really is worth the
> > hassle though.
> 
> I think you’re probably right in practice, but doesn’t the standard just say dereferencing a NULL pointer is undefined behavior? Just wondering for my own curiosity :)

It is, yeah. But I'd claim that on almost all platforms out there it
would segfault anyway.

Patrick
