Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78CC18EAD
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145265; cv=none; b=PUvisQp9BYllJnf2Ow3jgwtAlKV+YBSVvomU5aOTE7M11UqwSgh94f7r3YzhpC6AFjABAur7zPDFiTh6ecVpx7zfUo6KNE5x3RmlVzhpI8ktiHPwOv4kAFvKmnBdk5DWx0ApR+mA1+DHdcif3+OR44sO4tceJnIAFl4kdaKomRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145265; c=relaxed/simple;
	bh=1QMcBDxs46QTwOX+u3Ua++rgaI+RA6cooPL19czouXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJXr6zjLRbwSKwPe7chOrJqZiM/0ZZYXfhUvISgzS5uIdl971HT0HYDOvF9686ag7unlznPiYsWHVDbWSEExMejhgKtwgI0VMJHGncOLVgeFlmOnabtJiwfLgSfzAGIrHcc9mLH4DbaR3YhYM4mhkS1VbSn9o5ffVX8O+QbS29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dvnCmVSd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AeTHH04C; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dvnCmVSd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AeTHH04C"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5914114015B;
	Thu, 12 Sep 2024 08:47:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Sep 2024 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726145262; x=1726231662; bh=JorT53hmmr
	0x18C8Jluq7HBTsi9MbFB1aP2NKjS0A0M=; b=dvnCmVSdE1DmgJVKscLwH33cHz
	fVbdTyjKJR7cR0VqD/UJys/ykdPXLLIUa6uGVc3h+QO/iH1lPSLH63EiN6/3kWaN
	aqhsnCFQxOXM6M1dSj68iN2/c9vxpj5ZmIG8LGTL68Cx7BDURdjP66zUpKePPKO8
	9OA18inBPr1FO36pJ3OhIWAZvizdpmHBA5umEqPK1rlEtxb+RvCefYpIhLYUF9TG
	h2VVwYtlT6kJslehU48U3/3TkWQHeUAF0BaZ0QCpxdK29th3GpAcn/fRrIumH/sV
	HeVifxMCvaSB9qmH30TNf7bx/WQZL41Z14PDsSZny6UabdpyFiam/qXvmjsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726145262; x=1726231662; bh=JorT53hmmr0x18C8Jluq7HBTsi9M
	bFB1aP2NKjS0A0M=; b=AeTHH04CPUtSB2iLyRaaAp+XmLBJ/DEDJEe9tdnEVqsq
	5w1O08Jrn/KUNb3dbEmsLtPxw/8dN/DHutFrAEdrjjQ2MzLDHE5v6zBkCu1J0LoE
	hnyfi/0FphGHc7XJBd9AEo3EewWoEtpyeBMpg9FMKZ1FlZkUNyUbiU9sxllilrHP
	Nf/HsQiQTtotmg/NIHfvhtLkPZFv4ZpyWCh+4dQT77lHCojkxlOf9LMrDaSSknoW
	buJNKgTlbD2h9W6E80QGjVU1c1YMuco6ogeMTd0z8/qS9zXWdmTrQ9e0vazLlnuC
	fM5HUDvDcEXME7DlghlXSZvb+umwlW3absKU41cuOQ==
X-ME-Sender: <xms:7uLiZnQkvGgWP6k3_pUH8x5XFzM6OOfL56pofDiK4czsqpgFaQYi2w>
    <xme:7uLiZozZwRsku1TSZ3lfVD0tnxIgepDAgLr6QBlZ6dSaxEkXKhbV_HwDhLIK_ITHL
    HUa_1g2dFdhBA7FaA>
X-ME-Received: <xmr:7uLiZs3AbeeH1wI2S_O7u2-LFClQBuH07Zj32pkA__2qh6JcPGExNAY9EpJf08HbE0ctRVQMf1iwEruHm_Bfiujyt2y547RTrnVK8f-MtVmd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevhfeffedtte
    eluefgtdeugfdtkeeugfelkedtheegieekudduueevgeehudekffenucffohhmrghinhep
    ghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7uLiZnCx0uz9g5oGCm0QxnGaGEvHiAEJwi-2-2aKRC2ZWhYuQAiQrg>
    <xmx:7uLiZgjxoxAYTlXJbvcnelLBYsV2-SiA6Rj4lp-nK-tSyy-T9KjRvA>
    <xmx:7uLiZrpsoQSgiAJUiuy-bn3DsqnEA4q8scZZjVWWLNwk2MLusyX72A>
    <xmx:7uLiZrj4f_ojpJN0iy1FRqtoghl9IiDUzulphp1mtg3ebE7qwVM5Mg>
    <xmx:7uLiZpvv4P0PNkBBElT8JwHKDF75PXWLP-g5EYAs5XAb5U7BgazpmEJh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 08:47:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id afa61b97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 12:47:30 +0000 (UTC)
Date: Thu, 12 Sep 2024 14:47:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] ci: use more recent linux32 image
Message-ID: <ZuLi4x664v8dbm2i@pks.im>
References: <20240912094238.GA589050@coredump.intra.peff.net>
 <20240912094730.GC589828@coredump.intra.peff.net>
 <ZuLFPxsDiMB9UBhF@pks.im>
 <20240912112242.GA622312@coredump.intra.peff.net>
 <ZuLWHBvrT31KVd9W@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuLWHBvrT31KVd9W@pks.im>

On Thu, Sep 12, 2024 at 01:53:00PM +0200, Patrick Steinhardt wrote:
> On Thu, Sep 12, 2024 at 07:22:42AM -0400, Jeff King wrote:
> > On Thu, Sep 12, 2024 at 12:41:03PM +0200, Patrick Steinhardt wrote:
> And with that the [fixed] pipeline builds and executes our tests just
> fine. I didn't wait for tests to finish though.
> 
> Patrick
> 
> [here]: https://gitlab.com/gitlab-org/git/-/merge_requests/210
> [first]: https://gitlab.com/gitlab-org/git/-/jobs/7808775485
> [fixed]: https://gitlab.com/gitlab-org/git/-/jobs/7808836999

Most of the tests pass, except for t5559. Seems like it doesn't have
mod_http2. Maybe its Apache version is too old, or it needs to be
installed separately.

Patrick
