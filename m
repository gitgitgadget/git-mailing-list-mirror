Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A030B532
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223333; cv=none; b=tTxLgLP8RdRoL4OoiT1qaT406AdtbOwYNu+KMiOTXZJbwyasFcWUBzZsDL8/eqsKAZC2V+zR+Z9Od3+t7Tvwh4IAlaAe/4bzLa4nEoSC02B7kNSuR2htqsqD8U3ZmFi+8k6R6ZPdW6NGpKwpDRVd4hBQ+N6a2TvZ7swu+30r9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223333; c=relaxed/simple;
	bh=eKMOesxMv8yWNxdmYlvKIMhe4WUejkTkaB7JpxUK1sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb5rOLj3SHbsJA6kIbMjM1B4bzVvPZ//KqFsI61FdloWSldG2CA4ggADdl53CpMIGsIsLXFWUE514t6E/SstP/gEYG+TtcrIry4j2iiYw/aV3CKBCmQPcNu20zcJOYeWdh2WHgeH1FXFhvKf30WRXH0sRu8olJXeem+FGCZVPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nyywk9xA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a0ryxFQo; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nyywk9xA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a0ryxFQo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A9901400126;
	Mon, 12 Jan 2026 08:08:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 12 Jan 2026 08:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768223331; x=1768309731; bh=+Q2LLj9F/k
	bMDVIZJwiyjGKYL4kSadjH6rNHFJenAEU=; b=Nyywk9xA2q/GToYwQnpeWB3dAA
	NiJWn1/I2DC2luAxF3gkhJMJg+wYnLeefmAUIjFDH8TmqaemEpOhrTwiIIul5eIH
	STpyEEVXFkVjihA2m9TQeEm44E1u07aEey0E7E03BFqs6wXBtAkiDXoRi+LMFDNC
	+xiQZTknZuLYurjxn7GBLQQVJqupmDfCBW7s9CauELyfS6oEcMIsS4ZA0WHLr2MJ
	AbDULvdOC4xZ4xuAiILZczgO26lHk0hsrP7/PxMOAHsU2U/qGUWV3W954P8I8m8u
	s/+VVEg0x2tY5iRsmFzqInAKajqnL2l1g0rczRr7zIvkuqWFNn1aHjLrJEKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768223331; x=1768309731; bh=+Q2LLj9F/kbMDVIZJwiyjGKYL4kSadjH6rN
	HFJenAEU=; b=a0ryxFQoqOwzcpDkMrsc0QbI+qwUBVI1OhLaPXC3lIzZ8mSnnoc
	09i4zuSDB88Gvrx53LzPpxSEIUGZjxAkObr0IjMoJxwYYTdBq8IWq3Y3iMAuCZOi
	L8EivznzEqJ/ENzZr7Hioe1RIF1q/VF3/AoqFCkOKwouMsCRS9/+ZFDo/nCKNCcn
	/Ynecs3MzcOgSu2fEweDwXpFuOErZ8AjLvCtnWKDRa2sZgUKzjeJuHeTPnPZ41vx
	mjFyeFh7K1M+rXouuB23Gc8fqih88lDQBHf5qy0+On+rLIvMgDdNGymmvieO0Azi
	rbDpmXv/TB1W7hCaqYb2pit2oaYV4TEO81A==
X-ME-Sender: <xms:Y_JkaWyIGcm_ZZTdlrp2trSqtHz4_BQhzQNObOuD9r9As6_UT1cC6Q>
    <xme:Y_JkaZsV0q0J-ZkwoZ-1nCnkbdX21DdxIVZSlX8Xt1b9svh3gbTUWNkdXc8O0HipD
    Bl4RFNq_9S2ncp5RbmqoWbFkjULj1YvP6vJq8ys87s77nsrL_5e0w>
X-ME-Received: <xmr:Y_JkaVt9PksHJTB6UPP2jOYSridofu4AfKAxhgSVy0GP83odZdDUYSYUvmxBxKtioyGCrPIx_PLosYK7BcmdMSrSb2Z9Mo2iRKxJD2JEmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:Y_JkaWOl6ZC4Skfn5a_uuFuTyB9N9s524upQWuxWR8mqG2V_KoLwKg>
    <xmx:Y_Jkab3Yt1ll4Ra1tDX6Z1LQR-tnAlT4-w4EGUSgjHCOnFbs9fmvKw>
    <xmx:Y_JkaaOXzh62ogxvyGrvRLZChcnUPQdBPe65758P4fPjoKgSUmnxkw>
    <xmx:Y_JkaT0MSkx_GxrhjE-EwNeD9j7yzdHj7zwV8BGwGjFpEUjLwGXv3A>
    <xmx:Y_JkaZKPyONu2J4XAoH7wfyExXPEcTlTwKo094OrE15YGE8-dyNCOQv9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 08:08:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c032490a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 13:08:49 +0000 (UTC)
Date: Mon, 12 Jan 2026 14:08:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v2 10/17] refs/files: introduce function to perform
 normal ref checks
Message-ID: <aWTyXufNdKckmBTC@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
 <20260112-pks-refs-verify-fixes-v2-10-2e9e453bd6c3@pks.im>
 <CAOLa=ZRMvbRT64+XdKobM5RZhgiPd=2k5_Yf=rgKyjWnbpMg1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRMvbRT64+XdKobM5RZhgiPd=2k5_Yf=rgKyjWnbpMg1A@mail.gmail.com>

On Mon, Jan 12, 2026 at 06:42:04AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In a subsequent commit we'll introduce new generic checks for direct
> > refs. These checks will be independent of the actual backend.
> 
> I don't think we've used the terminology 'direct refs' before. Took
> me a second to understand. We generally use 'regular refs', but that
> includes symrefs, so I think this does make sense.

Yeah, I didn't really know what to call these other than "direct refs".
We could instead say "non-symbolic refs", but that also feels kind of
awkward. So I guess this is good enough...?

Patrick
