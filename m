Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB38837
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991581; cv=none; b=fwp8aSd+7hR0twgftTknFyVJ5FGLVTr2Unr+oAOTKXH7SrghH0TcpyKqIwX742FVX/4VTduN2unCp+1EFsguoMecTuaq8S2IJv08CGhLoxafzB1MQq9QncGOjGRmurtJDxw2KNmCJShGxw44Je+pV7tttRnGWweLb7Cy7UqEcKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991581; c=relaxed/simple;
	bh=7kmxl6uWUz+PElPJbbI81bCRRDtEnvsIZC7jtoECKEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fz9QSdK/P88jxM2ap/s99k8OnKgdCOutfjB7B1KfA4txo54ukTVFLwZyFjy0T0ibERiCGWo+OZBONYfLHaRIPFeo2m8SC6IdGvXOwLQpVXj4T1Lukt+gel/kXh4kUdb0WmpJ2U3HA9+vZCiqy0G2U2b+cTByMWlbp9XS8rf0iko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I2i82/sZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tXKaJEOL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I2i82/sZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tXKaJEOL"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 531DD1140065;
	Mon, 27 Jan 2025 10:26:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 27 Jan 2025 10:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737991577; x=1738077977; bh=NHOKu2Tt5t
	OLwBpGiETj6DaLXPp/LSAlktnNKEuNaio=; b=I2i82/sZdpJm3PngnwMpliT9wP
	bVptXhY+1LNo/fpnCcGRaCXLT2YqZlNKy0xdP+ClLcalS5jJK3RjQ0kmYmyqA8MW
	kel7CyOhAWFNaTzWHGUHjd1R4gHjwPmxtHnhVeBNzoZobzgIU+8byKiOfmbWGUj6
	EpjPy9OiUfBU7alLRFNVPzchan2ZWtKAdVn+z/9zoGtvOvR0gySbuhN7X0LiMGYl
	M5i+5bswSu6DoTIePn0/T9AI/OUqKV72XVcXa2UOkBLyNuag/RgL3rXphoXrfWDY
	2HCGPVyaECtJKILWo0STMNk8MwlbTns3chJgvxxA4IkNC0R9J9NsopoZi9Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737991577; x=1738077977; bh=NHOKu2Tt5tOLwBpGiETj6DaLXPp/LSAlktn
	NKEuNaio=; b=tXKaJEOLUJt5n/0IcIYSo8/iGTr6TmsMYylPKUXSkmSKHv7CjYK
	DbCT2HWlE/baA2c0qM1S5saFDpt38233FVwKkGIVjFl1Xu++f8U1msYe0cm4UYJa
	BrOhODDZHk2MsVPCFtlFusdjqxErykrS32rBBjcaoZV6CT+1cfA4VVuos9hNoWtH
	pF8cbcw0o7c2dCX0WikOn4JP+pdJmD60DVkrF1ly+Cfc3kqwKq6AReWkivI93Tbv
	z9PBpzKbdDWQ9XuLotxSr5McDnoivVXGRYYmZaRDletmcURXhVSEIoBqx0J3NGBf
	fERp4Tog84wsuMe5kU1Dq88cAVe7Amjrv8Q==
X-ME-Sender: <xms:mKWXZ-CNnhJ-xOYC9BAoOZlD7uWDA0FJ4qPqQ577a-NNqcyyq1CVXQ>
    <xme:mKWXZ4jEb7MfRUoEbzrNxL47wQ5c_uvyhpvn9tZDZ_6UIo8loO1bvfdWdba5Ueg6s
    96LTLjd4L_h0WplLg>
X-ME-Received: <xmr:mKWXZxk26eUyFw9koWgleTmo7sJ7I7WfPEwyoRck2CkVrhWgZ5VQ4C3s3TLp4nOKqYu3VOQlVOixFSfT_2H9-_ZfAF-zHGHSbXwD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehushhmrghnrghk
    ihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtgho
    mh
X-ME-Proxy: <xmx:mKWXZ8zq1TyrPNUSPR4jAMECaSbbVMQHSZopF5gqMYw76qooi50E0Q>
    <xmx:mKWXZzQFXLBzfSdFOfcS8EUHaBNtigBbak_MJN73_EZ7owAbsKlBMw>
    <xmx:mKWXZ3aLsSgGPrkrsgXtF51ybZQ-E8uuG0B1PwWFhbK4t8oq7u0uKw>
    <xmx:mKWXZ8T2SS4Px47NO1hVBR70TW615r37QZ7Gg0zELnTg1OCGE-mfuA>
    <xmx:maWXZ7ZnOWifzFJpuXDguRqpoRqjGz4FoGMfekKa-_LZCRKi2Y6m-8oO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 10:26:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org,
  ps@pks.im,  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,
  me@ttaylorr.com,  phillip.wood@dunelm.org.uk,  rsbecker@nexbridge.com,
  sunshine@sunshineco.com
Subject: Re: [PATCH v3 0/6][Outreachy] Introduce os-version Capability with
 Configurable Options
In-Reply-To: <CAP8UFD31A9KuqzXrDWzjokWzBtTYsF1FGJPX8PFAWXnn_2BH_w@mail.gmail.com>
	(Christian Couder's message of "Mon, 27 Jan 2025 14:38:58 +0100")
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250124122217.250925-1-usmanakinyemi202@gmail.com>
	<xmqqed0sxdiz.fsf@gitster.g>
	<CAP8UFD31A9KuqzXrDWzjokWzBtTYsF1FGJPX8PFAWXnn_2BH_w@mail.gmail.com>
Date: Mon, 27 Jan 2025 07:26:14 -0800
Message-ID: <xmqq5xm0wa5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> information in the process. The fact that it's used to pass
> information about available features has led to a lot of user agent
> spoofing which means that analytics, statistics and debugging are
> likely harder than they need to be.

Yes, that is a valid viewpoint, but ...

> When Git developed capabilities and the "agent" capability, the doc
> took care of saying things that it "MUST NOT be used to
> programmatically assume the presence or absence of particular
> features".

... the proposed os-version thing has the same wording in its
documentation, doesn't it?  What is being added is not to be used
in a way that requires parsing and trusting the result.

So unless your point is that users (like those who parse User-Agent
string by browsers) will do the wrong thing and assume these strings
are usable for feature detection anyway so we should make it easier
to parse, I'd have to disagree.  If we are not aiming to make it
easier to parse and assume certain things that we do not want them
to, I do not see why we need to have the pieces of information in
two separate capabilities.

Thanks.
