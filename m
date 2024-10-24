Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E826189BB3
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754453; cv=none; b=Pf1jvzw71xnRhXK12jzjGRpIfIuIgQ2SjFRc/Beoa0W68RYtEzckK7goRM6u7YYtTKU8NjvPPCY2YR9D1DytRSsdLrbE48W/Ksw3vAD519EaFB8G6O38pDPygYW27nfmpLnvQ/0saBN5JH8l0KAljt852r/iZppogcet1MLkOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754453; c=relaxed/simple;
	bh=mvb+/LFxakqlBK4g0ZQ2EZMREE414P/7VW3x81jqCCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX6qk2jQ+Ka71USAOgWIjF2XnMeHWwZfbTU1/NWfYmSfxi5l3ztk6pdJgz6IMyoEPUp92AqnZAZxeN8pbyiiZBLYAc90b5BpD/e2f4xzVvcgIxxGdMlm6fJ9331Cpq60EIlZ8duv+2KIejdhQKYPc8WiRVN+fz5JNyt0ocq9gOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r77PLX60; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IeX16T60; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r77PLX60";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IeX16T60"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6EB621140213;
	Thu, 24 Oct 2024 03:20:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 24 Oct 2024 03:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729754450;
	 x=1729840850; bh=1nxahH0p5F8kpHFFIVuQpI/onXRiv3EM1QsR3WB+yZk=; b=
	r77PLX604UbHT3syc67gE1TLtfRHTOB0yd8cTL6+yp/T0TyLsMYqo9gE7LejLlQw
	SkFoP8Q09bzmwczYz5LlAPKgFp23eQVh6L3rRf68s1AWmHI7XAP2GtlRXXq6gel7
	8Z8hEf9IAhcs4Dh3a9P0n1WNyPSx777xXS53UkhF8sru15nokFBBJ02gFgBkPZsz
	s5tWjCNz6k7Ff+1hU2pdROgBgNrqGhNT6yenpY55E/zSD/FePXAA1g0TsIgJPvV0
	/QRMadWxDyV6GByO4wnwd6CUvf7TtvQgGEVyD38c9iQwArVuxUXf4UENF0FUq5h7
	z1Cbnro71Gg+6z7g6DYJ7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729754450; x=
	1729840850; bh=1nxahH0p5F8kpHFFIVuQpI/onXRiv3EM1QsR3WB+yZk=; b=I
	eX16T60eQA7NDi8Bw246wQKWxBjyOlWv0fTnmBz4z2SCxAKFP+DtkyYMaybmDQax
	dOPKnfBVSqy1rFHW0Z1HZk4aHRywfl8zEId8f0ApSwOKOEdHpKUdOuP0iyEOOAIA
	i1sEa1zVDctQFGlVtti2WDUa4gGi18BFTlCdImsz7RgOkr7HTJvX8sgcNIzlx50E
	bivL8+6P/L/6gGu4egF8xGbWM3AyBUIA1Awq7tjCn+7CGSZ38fTZbFWd/2WWE2G5
	L1xVCWwe9Ct8z1hiJYap0tWISbdwLrJ886awlbAZWweiGtW8GMyx89GoFo1GA2Z3
	sF6bmJUZ8z3pqP0Jdl/lg==
X-ME-Sender: <xms:UvUZZ4LM2eLSOmCmciW56r-eTGNfK3HqQDqtQaJJ_-3P9Q9sOn8cBw>
    <xme:UvUZZ4L7RtBEUFNRLNKIO-tbZr6gT5FWrA3FKl6oxIxPuoV4w9ilL16fPJVX2fh8n
    pmcs0GTjoIfz1h0sQ>
X-ME-Received: <xmr:UvUZZ4s6aANG7kjObhTnaKRvRoX6eIvRzquUqRtZn9UPtu18SdIxrf5Mb68J0qokYsYTOrjyiUFBqULVI3hNTfbijqk7lvJiVA4UIOGeHfi95YQj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeikedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:UvUZZ1Y7Ad_Vd2n_zhSqQ94HPldR0Ehffrvq6aEZyGKAKa7OaZy1Pg>
    <xmx:UvUZZ_ZLYZKMF_o36BcVXhaLUtaeh-_5bM2o3hEQDtU6PUHpDIln5w>
    <xmx:UvUZZxD4WpkMR8rqOU-9VhCLiLgLY3GCdhIjDfsiLjugDyzlxGChDw>
    <xmx:UvUZZ1aQ9wcBgg3KQQnVYTiCj_UXy3VljXFvtHszKVXGkssGnw4HLA>
    <xmx:UvUZZ-WT7mR3wOc-ni3pYguscPqyyQ5ngrRRiAypZOMszNT3Jq5hBHvF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 03:20:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c20df86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 07:20:51 +0000 (UTC)
Date: Thu, 24 Oct 2024 09:20:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/3] compat/mingw: support POSIX semantics for atomic
 renames
Message-ID: <Zxn1S5DMtN8XIrxL@pks.im>
References: <cover.1729695349.git.ps@pks.im>
 <d17ca1c7ce38e12fe113f15b078c12bc92e8f0aa.1729695349.git.ps@pks.im>
 <51b63d57-fa01-4a8c-95fa-770a62afd80f@app.fastmail.com>
 <ZxnpitkbPPNTLuGT@pks.im>
 <d6669573-d5cc-4ad9-b248-95bda089bc6c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6669573-d5cc-4ad9-b248-95bda089bc6c@app.fastmail.com>

On Thu, Oct 24, 2024 at 09:18:18AM +0200, Kristoffer Haugsbakk wrote:
> On Thu, Oct 24, 2024, at 08:30, Patrick Steinhardt wrote:
> >> s/FILE_RENAME_POSIX_SEMANICS/FILE_RENAME_FLAG_POSIX_SEMANTICS/
> >
> > No, this is actually intentional. There are two different flags:
> >
> >   - FILE_RENAME_POSIX_SEMANTICS is what ntifs.h exposes and what I've
> >     been linking for documentation. This flag cannot be used though with
> >     `FileRenameInfoEx`.
> >
> >   - FILE_RENAME_FLAG_POSIX_SEMANTICS is what needs to be used with
> >     `FileRenameInfoEx`, but it is undocumented.
> >
> 
> I made a copy–paste mistake. :P I should have just pointed out this
> (missing T):
> 
>     _SEMANICS
> 
> So you wrote it the correct-looking way in your first bullet
> point here.

Oh, indeed! Thanks.

Patrick
