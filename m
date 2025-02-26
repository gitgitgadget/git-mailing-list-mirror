Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F125425D91D
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740614115; cv=none; b=O+2yx1+ZnTSlHdBAOrN/GTeQvzXVhTM/0m69y3rXVwlcAkHIIUq+zXLggfs0ktcxqaD4Khc1vHPoNnC1QFvufUhmV+1k8iUlnRCXSuTxCLTlSUSXNEAFoQra+mLDnOyn6VCER1TC4IK20oGWhgywW6oyM78ChDRHHq+yJJu16SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740614115; c=relaxed/simple;
	bh=DXSiiiMe57SDwe2FmfvxMNGvPPTz01psLrtGwQ5A+gc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aNrxq/6KesQDmlHltncgrnQhiYiue05YaScrxLilpYfAx+aHKnEw44+3EFO8i+R/Rcw5End9Z9HVjaCWO5nkTX3MuaIYXDXnCadZ4/VZ8RZTVMssn+sNMmOD5znbymSBkbSryYgAF0IVGH2JTUejh65Ui5sUcIkwlr75fVIBkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xivrCmNB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IMU4ZlBF; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xivrCmNB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMU4ZlBF"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D01BC13814F2;
	Wed, 26 Feb 2025 18:55:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 26 Feb 2025 18:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740614111; x=1740700511; bh=MpF7l0Z7Rd
	tyxaIgS/rEoo6cSCCcm40+aIoxCfNIMWI=; b=xivrCmNBhYN8XJOhZdtT3VUXpg
	28TT27Iw2jyz/wP21whC2VLqYqhvib3iYh72wd/GM7DKiExf2+fDkyWS5cuOPHsO
	8bZJBP6lh9CvcAYzqn9uMHy21DetK/bXf2KPnVwjHLfmGPqFDRv00p3LtxxbWSw1
	zSonXZ65cqYz8HD91fl4xsF69sYhumjWd57YnXbHmA1av6apUcAhxpyeiW2n7njt
	87L5dVpofEWRlOgspu5e+vjmmbuATtrVgLeYpIUNAJ0DvxNwD2IS1ZJVlc4+hoSY
	/4vmJu419QJzNcnLVZpGg5ftVlidUfW5wQunZgmm3HT1ZLZyqxMX2/xptCXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740614111; x=1740700511; bh=MpF7l0Z7RdtyxaIgS/rEoo6cSCCcm40+aIo
	xCfNIMWI=; b=IMU4ZlBFsxwGtGZJmuNW21UWh4uIzg5UahHZFP1piHgToyvnR0G
	HHoQ1bo5Rh+ieHqnpTwMNxXna+rcyUG0vIjDsCTyuA59bvRRSuJUkLP9j+2NXBnu
	6w+lQTvhVnSKw4DsqOGcN84WsUT7p3BTthzq0+ENBjfDRbosr1/WetWMOVroP7X0
	IS1/3+b4VA7U3yw7iu8E6gdteIPTMMhq8KaDBInR8WreFNPAo1SPfJo5nAUFUMzR
	9/hqI+gS8YiBFsKTT4ydHByvKpppES+j697fExKMtXF9F1Pl4PFLB8rUMZxMIjUq
	veJ56IpUMWkrXm3Vjd7n/7l3HPy9KEOcPFQ==
X-ME-Sender: <xms:36m_Zydy-lAM71dGss62iNWolDoz2w0qCoZX4raVCFRVm2Wv7FcgHg>
    <xme:36m_Z8PAG9NoeVXppm9XBtZNbSFoeJc3vRdwtO5ZMlUQr87l0ScdU_BQCS93yrCi3
    37grLD8pl1a4DAc1A>
X-ME-Received: <xmr:36m_ZzidJJfVvtgHn3DAcbEmeGBuE0V7BBlgvqPCyqYR1RYPNGJ6-bbTYW5KTpD-uswc25r1lSUE93PG3NOEKZSJ4vF785XoYADp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopeihrg
    grkhhovhdrshhmihhthhesfihishgvthgvtghhghhlohgsrghlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:36m_Z_-sWgTW-OE0kmTB-r3Z9cRcu4U4SjoEHclqfQ_KiKMzUYYeOw>
    <xmx:36m_Z-uGYCvr5HlmJLHtQnR_4_-9QhMDMZqfLwIpOWitNRwFNwdSHw>
    <xmx:36m_Z2Ew29xxhmj6gf0BpF81YvQeMSPyy8IZpUUuuzLAaetASogtXg>
    <xmx:36m_Z9NQ1CBt-bGhh0qvahkAHmJoXT2T6IHllOnd6GyqVnDkkUeQWw>
    <xmx:36m_ZwW-SRu717ak2w5KGBEtshc3E5RYSbbsVicfGKXn87KdMCsTlT9f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 18:55:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,  Yaakov Smith
 <Yaakov.Smith@wisetechglobal.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: \b character escapes in CLI usage
In-Reply-To: <Z7-lbGnlzGbhrHZN@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 26 Feb 2025 23:36:12 +0000")
References: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
	<20250226073822.GA21138@coredump.intra.peff.net>
	<Z7-lbGnlzGbhrHZN@tapette.crustytoothpaste.net>
Date: Wed, 26 Feb 2025 15:55:09 -0800
Message-ID: <xmqqtt8g9s82.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We already have precedent for this in core.quotePath and could easily
> use similar logic here.  That format, while using octal, which I find
> ugly and hard to read, does have the pleasant side effect that it works
> correctly with POSIX printf(1) (which I'm sure was intentional), unlike
> hex escapes.

It was intended to be "the normal C quoting":

https://lore.kernel.org/git/87ek6s0w34.fsf@penguin.cs.ucla.edu/

