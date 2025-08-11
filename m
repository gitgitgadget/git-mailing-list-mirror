Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903052D837A
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899576; cv=none; b=XPacjIXdDme4NgKY1/bZAAxHQAsZGueDn1cHXMTGMeSlCoylWYN9vPVXsY2/Ubb/D/POtPMxXGKiOSpddNsu9r8hVdJZEN7sBcGUEe4ZDuCU7hawigMpunfIKA+2ChknNSy7/OJWnxLm5hJgtVoopbNFH9gKNVvoA0Sr2agr4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899576; c=relaxed/simple;
	bh=PNTViB1y7wQNqDohhq+kuCZtzgbcx7WMnpa5x7EPfvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8q1HqXC2XHrt+pzxzMX0eV6NOJiwkprW2KrKEvtz3Dti4XLPAZp4RlnvLotiAVwfD8SmpaPcm1/7laUO2abSYGKOabqVXzMpsTFCrP+FqU4LnYM5KyZrbRKI+Kf063BwRmNpk2p3WVN5Azs6sPSuytBpb946xKwKuBSxwfx3VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LlZMONTS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDToOZcv; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LlZMONTS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDToOZcv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7ABA11400036;
	Mon, 11 Aug 2025 04:06:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 11 Aug 2025 04:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754899570; x=1754985970; bh=852OIxjGAV
	TUgQQcn3qtHQm0HeHzrkSUTcz1eemrqRc=; b=LlZMONTSl4aZHFjEVUiFF48YwK
	M4Wj7LWhppDcz4QUvMDOptaNwPWlsQZYfYvH6BfZL4TEZ8A7C5w2tVy4MtS2LoG4
	2siZi936a9Z94XYdL7627sSF4bu5933mQ/e4SCF4FXRhRwGVO1RRsHuIOa+ZBqld
	kCSPt0CUFIh34CGQauiULgw+NSXN3KIeWD5s5bWCA3AkvNMz7mBkQ5SuM1Ep2GhN
	61ZpE7l0CDYlFptjE/uJN07ho8B/c4BINhQ53sYiz3xg7yNujdrCNkiOFEc7ss0w
	qMMaguvUxkp74lDjv4esfBIkA1G3nd/fZ3tu9lTdEh0+XrA2kGjgX9XqLfiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754899570; x=1754985970; bh=852OIxjGAVTUgQQcn3qtHQm0HeHzrkSUTcz
	1eemrqRc=; b=hDToOZcvrnVh7dRWdRjYCgRtYu0boN9xZ3BQtZ1ve0p7t1D55U4
	u9TW6XdIPdSfJKKsw0E+PG1o+orNRDdrpLYqIQNKxao7juBrb+chlTZPA46xz/U5
	WRBIw9ia9DpTHYirvBlhJihC/J1K/fmLadxX+E45Rw5ju/K3noWwcrOC/Dhc5BQT
	IvcOVA9XuGxt2q83eVWClQV6coH6AX+6J84qqJpvqzA3ez9U7cnGBHqHjQRSCLFe
	07jIvVFQOzmR/UT2Gg7ZjfddOTBMLVrCwRLB03Z/e59L2WiqvQ3vx1E1NC+Bc/4p
	lV/l5HSPVMCNpQ/3avV2r9zQ9fokOUTFoTw==
X-ME-Sender: <xms:cqSZaA9oI1l4zNMoRoP1_JWR5XJALK1-m4G2Y0ng0RrY-bJclqqfag>
    <xme:cqSZaDTWTiEObvqIUTsIj1nYJJqIEgU9xX-CBrKvePBKtPYE_o2oUSerFCJzUHDEe
    OXXkrG_sRL_6iG5_Q>
X-ME-Received: <xmr:cqSZaCn6E2yIWMslV9cp4QYGn0DcgT_NWY4oagQ64Vmu-aM8pu7CKyfj9uUvtT-hDMkwYcQkU6zKsMx5HK0QqXZB5H9zgYtAL5ete1PmXiE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeduleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggv
X-ME-Proxy: <xmx:cqSZaDSPT9BNz0THHWx7pLDIkuBdukHx_I9RK3pRWWqqFASOt0G3eA>
    <xmx:cqSZaAP_DpcO1Ja5-RJB3X73KjhOlN7wQC-0YpdQIv2g11hX_wDcPg>
    <xmx:cqSZaMVZLgOqePsbf9r0_dqniZ_z_X9BdKTITZgd2PwuJmIuhMGcCA>
    <xmx:cqSZaHcdLLJPLTuCYzDLdv5pDL9B1ja-JdlHj4zcxPl8jb5Ke5qPGQ>
    <xmx:cqSZaCtt2_43coAoQFJ9oXC6Gpbypg45oN4ixWbF1LndjJ_uWb7Ml_Rw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 04:06:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a704c778 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 08:06:07 +0000 (UTC)
Date: Mon, 11 Aug 2025 10:05:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [PATCH 2/9] commit-graph: stop using signed integers to count
 bloom filters
Message-ID: <aJmkZYtQt_KRHCeD@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
 <aJB5uKFdGybf-IbN@ugly>
 <aJCW7aYqJB20LDNg@pks.im>
 <xmqq5xf35429.fsf@gitster.g>
 <aJEppnTkY+66IEza@nand.local>
 <aJL06Nlee6CR-KK0@pks.im>
 <xmqq4iukwj83.fsf@gitster.g>
 <aJRP_muuzCAy3mzF@pks.im>
 <xmqqpld6kb4t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpld6kb4t.fsf@gitster.g>

On Thu, Aug 07, 2025 at 03:41:38PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Yup, fully agreed, and this is a good reason why it should be signed. In
> > the case at hand though we never use such sentinel values, I think
> > making that explicit by using an unsigned type is a good thing as it
> > tells the reader that "Yup, no sentinels involved, it's a plain counter
> > from 0 to $NUM_ENTRIES".
> 
> I do not think such a "statement" has much values, especially the
> right $NUM_ENTRIES is different for specific cases and is not
> expressed anywhere.
> 
> Also, by making it explicit, such a move is also making it explicit
> that we want to close the door for certain future evolution of the
> code paths involved.  I.e. anything that starts to require the
> member or the variable to use a sentinel value is unwelcome.

I think that's actually a good thing. If we wanted to start using a
sentinel value we'd have to change the type to be signed. Combined with
-Wsign-compare this would then alert us of cases where we compare this
counter with an unsigned index, which are exactly all the sites where we
might have to adjust the code to take into account the new sentinel
value.

Patrick
