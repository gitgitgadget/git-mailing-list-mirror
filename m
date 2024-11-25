Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278414D6F9
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513963; cv=none; b=pakyruE3JH8YDc1dPsFdGgLLbZd2aRF2yiRiuCYXr5+xFoYDhtAJ61UYtjFdA90oLGbuPmRVaTAXIPTrIJnR4F4VE+P7K2IyGZasIgWdosjcy3N9IemW62P4iygNCeFPTmx6qWk4pmHNJ4UiPWmue6/u/9TKM5WUdTrI8mGe76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513963; c=relaxed/simple;
	bh=n9E5vGNpehMGyriLoXmwm/OfUWlfu+sYM/4zOUiZkI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTwCpTJz00C6CFqF9Uf3p7BJQE/TC8n4MSBNuiiFCSysLNxE+SjPhs5Ev23aiPem9mocrosmNfC4L2XGG4naSQIOBOz9psiWzdBvhd5WUSqFkIjqq8sHASPff2cdCa1kOlYxEI8p3sXTjfk0tLlOdAHMMBox/kygjoonl9+6iXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MMRrHj1K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kOl78YGH; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MMRrHj1K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kOl78YGH"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id E416F11400EC;
	Mon, 25 Nov 2024 00:52:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 25 Nov 2024 00:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732513959;
	 x=1732600359; bh=+zKqCgiKL4tb0q5WUaJp5WsTdoBkUrS+nHIzVFdwEFI=; b=
	MMRrHj1KplCjn0jEf7wrWGLTjzsZDK3q2ma4K1hp2IF07GcloILUhMim++5neS2h
	Ugc3KBsbz68RaJlzUxLGd5ju6PGR7TQw4lBXFwLCXAKlL6zdb5REYm4DPFZzo//Z
	HZ+ocawUSGTX+BoukmuZniazzgy82xu4N3aGbmrpsd0MpKZ+7sRB47HAddiFqdBZ
	5+t+M/HLdmF9aunsGvWkvLNWJl0XXdN4r0FLi4xt8y7Aw2hLzWwIFdxnsPxTXD79
	/jfeZU9Du99zLi38j1rZN1TBYlZLNXGdKma0Fc/g3RT+1Ydcxqgu9MhMM3Ffpx/n
	i0WhDk84nuuX1MGc4pdrxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732513959; x=
	1732600359; bh=+zKqCgiKL4tb0q5WUaJp5WsTdoBkUrS+nHIzVFdwEFI=; b=k
	Ol78YGH22xlkOaqi9qumgTSE8CIEqlQZ8ts8gHRSAPzCsaM/0NQ3172pZLwF/XLT
	hZKS2q9UeYWGIaYLBKnUCJUhtt4RIbLWnEBe+mdLnfmY2ESbAesous/uQ5M7HDfx
	631R3H/tcc07QAa/UViuXzeXQuEbEUkkOojQxi/H9vK3Td75mbjy9LF3wJLm6zNe
	eRPbyVqOMJY96KT2nW2EkeoH0VWlVOBe9rYcOK8MGrEE7kiGCMz6cIUzksnnCXhD
	EChY4hITBPrMG+ZFbwnGBmQIzESHxP/9u/wd79r17MhcG/vYu4YCIp8PsScS1TQm
	IHNcuBUsmlbs5+VU4xXig==
X-ME-Sender: <xms:pxBEZ1tWVmlBkj5o0O-xE8T-Pi6w8EVfG18KJgWHaJlE7EW99DG87A>
    <xme:pxBEZ-eiMjktjwNPnyQd1M5mbLHBeE0B5kQaSBWs1HV4QzIfy43d42mrmKx-QTlp4
    _DwozxtFOqDmGh5BQ>
X-ME-Received: <xmr:pxBEZ4w-P08sVrWueex9p0VY_Mj4LwNIOkp6sLi4PJtLBs3pGEcZ2-ajD13HusirpJbr0y7QLHkHsNjbtb-QFr1C6wkjIHfRFJ1mn1tbqbqyFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhkshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeekvdevhfeujeelhfefleekhffgffevffelffejudev
    iefffeekkeehueffkeeugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpkhhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:pxBEZ8PVEuaI9Gq9AKJNt_1ZTFYiwbab9YMdWBDCxTyJcT8Sa1dJuQ>
    <xmx:pxBEZ1_6GUgWWUkyElWBE21sm1cvt48Sh3Eh0aqTqzkLpHgw0hH6Yw>
    <xmx:pxBEZ8WQe7zng9Hx8iDLyQiAS1mBX7LFA91JK8M8BoOUn5K8DpiIrg>
    <xmx:pxBEZ2cz5wKnPj0Mi8ujE7kR_aULbukB8r7Dmdcgd5BTS_V5R5L8Mg>
    <xmx:pxBEZxYoj7QRTqgxOL-k1isJzz58Er4AYhp2J6ogi9hirdTcJsK2RrGl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 00:52:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c1498fcb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 05:51:37 +0000 (UTC)
Date: Mon, 25 Nov 2024 06:52:26 +0100
From: Patrick Steinhardt <pks@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/10] refs: optimize ref format migrations
Message-ID: <Z0QQmmGt27U3Nsfw@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
 <CAOLa=ZTGtGJDnMmuv++FS9Rv4KiRQewOepo_qOY=6h1xtNmNZA@mail.gmail.com>
 <ZzH-OaXmFcZkGE43@pks.im>
 <xmqqzfluidwo.fsf@gitster.g>
 <Zz2UtKNnREAJgtaI@pks.im>
 <CAP8UFD1vLm5G=+K=b17_JGCvkm01BmaLE7EcdWhGO6bPWyJ9hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1vLm5G=+K=b17_JGCvkm01BmaLE7EcdWhGO6bPWyJ9hA@mail.gmail.com>

On Wed, Nov 20, 2024 at 11:25:26AM +0100, Christian Couder wrote:
> On Wed, Nov 20, 2024 at 9:00 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > Sure, let's do it that way. Will send the updated patch series in a
> > second, thanks!
> 
> I took a look at the v2 and found a number of small nits. Not sure
> it's worth a reroll though, as otherwise I found it great!

Thanks for your review, I'll send a v3 soonish!

Patrick
