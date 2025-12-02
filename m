Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10301302CCA
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662036; cv=none; b=Pn8OD9fYjZhAxYQzty22voxH0e36LYoCzkI6RAejoqgjSO7ym5GpLaGuUvWPgVgY+PqDLya4c11vJOrLOorzOO001vwMPvAJcVrcCdQ62MD5koZlLb/LeHECO/wSXxiPwj4m4DIp7u2hAPpvNufopMMxcPH7JaThYTl/pqyryxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662036; c=relaxed/simple;
	bh=9bpnKFFEYQjD1uy5hMmpex5W98z3djT8mVj8rlVdHBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfVhH0LxOBFi3+JJSNMQHdPYP7u8A8wVQfE68MbeCLuNn+UIfcsNk2+qlZYavharIgZgseO1JhSQZwyf9GnV4Wo8luG+98HHpr18+iYtlM15Y7MxdxpQe/5q9DbdlAezpXlc+IHvQ75I/XT9sAOI65nvC1yAEU2vhiQOdXI7Yko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qF3pPwG8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DvSQchHc; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qF3pPwG8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DvSQchHc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A2F37A0167;
	Tue,  2 Dec 2025 02:53:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 02 Dec 2025 02:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764662032; x=1764748432; bh=Vm+en1Uhga
	c5+myTDG8qnWAVlltcXcgNFLSGxYSQz2c=; b=qF3pPwG8C4jsmrbToUK6+tCESr
	UhwWFn4c4VJ8Eg+M6QcIuJr+ito0armNPtjEIAuws3sZH6ofnhcLDmB5LViPhiQZ
	kpC61lfkchilLOBcY1uiDQrpoIZgCuMzBqpeubUsnHKUqmlA1z77BAkJlWhW/Bcb
	yxqvJBAB0olHBO+Anzf1380VcbctGwWp1EZxdaWo1e/4Gl2Raun3kIqR76VJRhEz
	IU7f+ZFvMc1i5i8HnMw/wp+ftW8YGH0j9Mo1sj3m09Ed7Wf2RgpCrD82bpgd4CCA
	O5XHG/mqNpnNCKavYLe4tZhPgULJ3Sym4aE9f5WCqtX+PmETG88dVUwi4h6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764662032; x=1764748432; bh=Vm+en1Uhgac5+myTDG8qnWAVlltcXcgNFLS
	GxYSQz2c=; b=DvSQchHc3Kw2i46HZx12ZjMLhOhLBGMS0W7XaTDktXbH6eAnffb
	yhHWqno/RcodiDFDDtgvIfO2zddF6L1Civh2rkm+F19BRz3lyWz3JzTAO63tWTaL
	3zugGx36YOmvDuh2IZ/c3LReCSMI8RYi3vovn12QT9mWJ9/xP4La7KTFELzsf8fg
	OOomtFdhFjLgynuuPox+I3f30XZC874GpOAd3gquJXbny1MrM6j3ElDKNkBFdl3e
	bm1duA6XhJAcjfuTiTkShieWGOP+Qqq63dOMZxPNsMAkIg30n7azUAJuMsDpw3Tx
	wBDlenpi1oE8xK5k2HjJrg6EAhJSsqDTJbg==
X-ME-Sender: <xms:EJsuaZZW5WM0hK529_YZB_MJUv74jyMrE15lPDqs191S3E44IxVbyg>
    <xme:EJsuad99_GUzFHTMH2RYcFGHJ2mqYa2iOUjDdzltPQas30LY0KJXmZ1Q5KGcCyDJK
    i_lmbi97i2oAcFHflcfUa9Q6bT19DT_Rc8HsgkdRBGKK6HoaQ>
X-ME-Received: <xmr:EJsuaSZg2z8XpqejCijJpGPIKXaLp6hTId8LQV2VuRhYTRDdcojhzGOjCVPAaRh-3IVyBi-KEenH7wpY6TLwDv5DBjMwwfBL4yDA78GtMhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedttdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrthhthhgvfihhuhhghhgvshelfeegsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopegrthhthhgvfihhuhhghhgvshel
    feegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:EJsuaZPohidJZQOSOzIMa090rktwWYO7cSrgtz8z9zjHifrRFKYa3w>
    <xmx:EJsuaWB4Nj0ynjtuBFeA1Y7MD61c7K3T80ARzMv60jM1ZFaKF6XkAA>
    <xmx:EJsuaYLcsaxrtNI10LIRiNgXsSbLGOwhP-2DPNHVI9vhtOxvkfvr3w>
    <xmx:EJsuaXOqGOYY19AanWOBwSGIaiSTDz1YV-Zs6SyQD-CLCGVnMJIZog>
    <xmx:EJsuaXCOvc9jgm9aOoe62IJSIfWbzPcQYtRfbbcSiKRQiEZwdbHc-0cq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 02:53:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a2708dc4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 07:53:51 +0000 (UTC)
Date: Tue, 2 Dec 2025 08:53:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, atthewhughes934@gmail.com,
	johannes.schindelin@gmx.de, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/5] scalar: remove stale config values
Message-ID: <aS6bCU19x-QM84tp@pks.im>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
 <8783db6153875deb52aaa354da189ae611de1057.1764607847.git.gitgitgadget@gmail.com>
 <ciegbs72xbepxawuf42pne7eu354ntbok5e3p6jxcuyddvaea2@6ykt3iej32xt>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ciegbs72xbepxawuf42pne7eu354ntbok5e3p6jxcuyddvaea2@6ykt3iej32xt>

On Mon, Dec 01, 2025 at 05:46:46PM +0000, Matthew Hughes wrote:
> On Mon, Dec 01, 2025 at 04:50:45PM +0000, Derrick Stolee via GitGitGadget wrote:
> > * core.preloadIndex: This value is true by default, now. Removing this
> >   causes some changes required to the tests that checked this config
> >   value. Use gui.gcwarning=false instead.
> 
> I was going to ask about if we could also rely on the default value of
> index.threads like we do here, but then went and did some reading and realised
> some config values, like index.recordOffsetTable, have their value set
> according to whether index.threads was explicitly set, so I guess there's an
> implicit reliance on that behaviour that we want to keep?

Wait. Are you saying that "index.recordOffsetTable" behaves differently
based on whether "index.threads" is implicitly enabled due to the
default value or explicitly enabled via the configuration? If so, that
smells like a plain bug to me.

Patrick
