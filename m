Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F31C36
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735889927; cv=none; b=IQI2UADwbJ1ZsLz0vUd/zyx0U/s9TDOOLVuX4Wz7lBnuWfM7N2muSy3ag6cJX0KayPEhlvDrfzc0CGPfhrfT9bvOllh5PmrgGx3CgTIgq/4mtsbshY/2xHG/GNevV7NsFal64m+d7w69oA3LV78Q/lPeVpBtjxuRQ0Nlx3eg0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735889927; c=relaxed/simple;
	bh=Ro5it1MN3xLxzyc0C3ot0w8OjQJpPjnrt61qiuFAoOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjFAIaATcKBfT+sTC8rfglPtYT50WOP51lZrhQ9jLCGveAQqkDTiCnCQF+l4xE5KK7NjGJjCYUm5LYCPXjv76pG0E6p5TBRXnSCAq2SgrMK2ZcHQ6zrRFNjnpp42twad9q4CX7H6HiTz8bWLwBttyn5QdeCJJms2peF1IILdYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l3M4/rJ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WyCx0RAI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l3M4/rJ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WyCx0RAI"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33DAA1140226;
	Fri,  3 Jan 2025 02:38:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jan 2025 02:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735889924;
	 x=1735976324; bh=Ro5it1MN3xLxzyc0C3ot0w8OjQJpPjnrt61qiuFAoOc=; b=
	l3M4/rJ0pBZTtm3yzK5SElXHqP7o+A/wO+G2AOYai/XTYqTHyiwO5JwOhOri0HmS
	DVXZsj483whyfzBe9EDDceMeYp8VGyglwYn7RqzV+8r1Dwo6dqq2CZxMt3ikN/d6
	9ccDi7WSs5KJmvjxHvx+aNKBTq/oJbpLnYYq1oMUDAUfkx5Ckw2ZXXcXZxiz5LJ7
	gxKv5MIbwmSWxkkQjZ7aucyfcCct0LmhrRbP2BhAJtF96c4OiZpiM2qM9j5DVNTb
	4dRyja/kusRpLzDM/f52UIRZqxC7/g0TjS4HdU/jMi74rbIvJz+RcMa6Qrk/YJOV
	FjEUzzCTGFMvg2AVU8DW2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735889924; x=
	1735976324; bh=Ro5it1MN3xLxzyc0C3ot0w8OjQJpPjnrt61qiuFAoOc=; b=W
	yCx0RAIGn32vengIMmDkh0STMP2tIO3q6NagcC0HO58aTlxstsWV15bxec9p8jqY
	B3y64tQz4WDtdGOpEuQxvBywDFznN4mLeefrUYMZKFMwTVd3lDkOEiiu8DzvjImw
	0KAPAlWsSgvbBq0pEHqIF5HQbVeobl3EaTbnBESUb0EwBXO1Hul6ZPkOjw9HL5uw
	dfUiiAk9JRxKwja+roj/jPvVexxp0agtPDNbFXdE0tsTYOdw73EAeaInjXMUXCVa
	SAsrqN6w4JT+Pq2Bmm95vaZ+1gX7+N+MT3FLNdxMoML0Kp4SC47xYYHT3Nprfql9
	STTYZG8izWGbNENWRAXOw==
X-ME-Sender: <xms:BJR3Z6TMQPCW6eNVwS1JI5euCLgYcIXB2y3D0iDWP89UzUNO3tCn-g>
    <xme:BJR3Z_yVmKrOu8k_3jCHLufaaTiDahhLEkYywzf8e0OquJ6q5gmxed-JpwUtLvyrQ
    xkJk7viTsUyO8mNIw>
X-ME-Received: <xmr:BJR3Z32caH1j_oNhpEgSawllEfuqSXpzI_5h7gekm8BClzt1IGp6OQZqb1tN-MNzrFYdGzZkufNZPe1dT53Aw68H6rcXDXJPl1bK4HYV18IkIfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfeehffegfeelgfeiudelheeuuefgieefveejjeev
    leehtedvgeejgfekgeeugfdtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehshhhusghhrghmrdhkrghnohguihgruddtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:BJR3Z2BbQlBU2w84cykWfLVxJT7iBmNk3J779HY_NVkliUQToLXRMA>
    <xmx:BJR3ZzjsHIMxLlwa3vXDGngOQS6qzyyK6rhssE2xtnN1TzqJAqb7-Q>
    <xmx:BJR3ZyqAEaQHg2YMb9whOI6XNbHUw5189K_QCgkcyzGFvPUMoBcUdQ>
    <xmx:BJR3Z2jf7pkJ2yl5xx7hj7iWogSLLr9qvmLpuRAA-SuM0RhTBs-kNw>
    <xmx:BJR3ZzfzhWvVrMaCd1dAUogBtTRj2uSDcLtax1y_ykcCIS1OWAJLjbpj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 02:38:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9cb66872 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 07:38:41 +0000 (UTC)
Date: Fri, 3 Jan 2025 08:38:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] maintenance: add prune-remote-refs task
Message-ID: <Z3eUAHOhvOsJ26J8@pks.im>
References: <pull.1838.git.1734946566885.gitgitgadget@gmail.com>
 <pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com>
 <Z3JIpDQTDrQuoEN2@pks.im>
 <xmqqh66l1d1n.fsf@gitster.g>
 <CAG=Um+0fC3DcHB19du9YF19CdzCXkt9AYA1ndBJ5pbGAAMYREQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG=Um+0fC3DcHB19du9YF19CdzCXkt9AYA1ndBJ5pbGAAMYREQ@mail.gmail.com>

On Fri, Jan 03, 2025 at 12:20:07PM +0530, Shubham Kanodia wrote:
> Curious — I submitted my patches through GGG, but Junio was kind
> enough to apply a few other fixes to it.
> Is there a place I can now get the whole diff (with the range diff
> patched in) so I can pull that into GGG?

Junio publishes his branches at [1], and yours specifically is called
"sk/maintenance-remote-prune". I'd typically just update my local branch
to match what he has in there.

Patrick

[1]: https://github.com/gitster/git.git
