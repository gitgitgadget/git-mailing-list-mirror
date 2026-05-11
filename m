Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6321E492D
	for <git@vger.kernel.org>; Mon, 11 May 2026 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493741; cv=none; b=ji5eb23aODkVc0Rys7C/3hDKjUpWHB1M5Jqkmhw/wtZHwtaTe2NVlIN1OqWhZaB9KmEMJU5y7ehDf8QTRvzYFpGSj2EtJ6uMeho3q6l7bbg4NBa7odMw5JmeCfU94vGVGh502FoJMWIRgYKgT7N/aBLi/kVvoUbnb04iA9ubZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493741; c=relaxed/simple;
	bh=RdGtrZlmGTYMFGKoR0Rc4BMDYYVP0jI3kdY3IYAc3i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLGE9SB7ZieGdz5SyK6kQF/r43vI3lFnuZqjTwGb+tFNoo7hbRdBHzJJdMjclYPN1xz046kmL1dp+5JV4VYmP1mqcccOTOPIv7giwlJ/iGiWZecDrmSLZYMvSKyefO8d36z9v3LCx1amQhfXnygl0qKKwrgtj5fMPFkLtUGT8iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=INGSZcwh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FFzvtWB3; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="INGSZcwh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FFzvtWB3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E964140001B;
	Mon, 11 May 2026 06:02:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 11 May 2026 06:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778493739; x=1778580139; bh=9AQNL27nwZ
	W0CeD8ORGBaGpN8swiCUMfUV35uQwIcb0=; b=INGSZcwhAf/uCWQU/5Bn9NvmQ2
	uJaAIPM6TTHAtiVOs/YwTIX7bhU90GTYY4xXfmd1gtz5kzP0ZTULyDrP67RWaVKB
	ef8qCp7bcKxVaAOC7w6zPCoZD9G5TyqMFXs7s7m/9EALuiUS/cFUOfg7k/SVVz24
	WTYwxBv3TF22Pu1nfkok0zRPM/g0bziCxL0uj2df1NOAFA8kBJSzWDFC+byef74M
	Sun3YIWww64NW/0a8n51BghM8bYFUS/odjIxQ6jrRMakiRFU5G4sCVmQdOe9t7Uk
	0O9Fab0o4ikET6pNDpxtwcZLKzbUu5Kh8zQwXQ7KJV1edCoHVY7cLXR/y5Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778493739; x=1778580139; bh=9AQNL27nwZW0CeD8ORGBaGpN8swiCUMfUV3
	5uQwIcb0=; b=FFzvtWB3wdVkita/1fuMWAEmdzhUZhaG8o1CTzziRIDNqz+HgIv
	GBqRegYGUCa8CV4My5dEYAP/kjLx9Dm59ItUhik4tlmuEf3vAGzxI5SzLLjmdmnG
	5XSWNS2Q2kQvMdfk7fG6UcM/ifdKLoIDJy5Bpvm8G067TZA5p4lFx+EzHSanco7i
	JS0sTOG++Tg0KaEgomF0+hY0Njb7DMe5n+744nUb1qVLiS4dIXM9JV9okGVzhPlH
	Yi1h5fgyQAWGq8/jjrVdxlEc79EziIn0bALMDdS/uSSHjeojjXg9sjzAuZzuQamB
	ac5gV3FKQit9FPxPdWgvnVPBl6XVdYvP+ZA==
X-ME-Sender: <xms:K6kBanRJjm3-BO3_PUjVp2z-QICFdokQ5EgoikgDmwIFlwmz6DDnIQ>
    <xme:K6kBarCCUclZWol1tcpIJudO38y-oxJm2DN0fMTCtus1LDxVPKXCF_w71v2_JGrJs
    rHnhFSkl3wnJRdnIZeXq8-0V5IkgKtVcFQUpUBxTmea9DLgLbQ1jVY>
X-ME-Received: <xmr:K6kBavGgovgwNpWOuCNeizmc51pN63eTQLrsVwWxso-vQw6UL2Yk7jKroSyVn7DqJ5uJ3XLTCiZDg8f5Xt1J8dcwI-FwKWON5bXEosZADA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtsghovghgihesfigvsgdruggv
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:K6kBatB6suTo1TWoLk5BydgbUJFUqJdAnAkOaFgr0RtNkc7z9r8XVQ>
    <xmx:K6kBavX-yZnfT_a-Rk-O5roGTXQVz4n1-ok9yvrF0BcJP-tM2kNZJg>
    <xmx:K6kBahoMO8goYTrQz4UHzVBs4j9KmQAolZZb2zgqXbvBd8-W8Rv9BA>
    <xmx:K6kBarTe1XVqo6Usd-SnjObn4f7hoWRZ8L2CkdOFwK5uFCtUO0Cicw>
    <xmx:K6kBagOEEVAHyTezdrifkDNnNLXBrxjBkDuUt2wRVumxyLs_51rpm-vN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 06:02:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 426c6fb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 10:02:16 +0000 (UTC)
Date: Mon, 11 May 2026 12:02:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: enable EXPENSIVE for contributor builds
Message-ID: <agGpJlY_iTnzVoGr@pks.im>
References: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
 <pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
 <2159f6a271b06d156134392ce3c44fe957c83378.1778228209.git.gitgitgadget@gmail.com>
 <xmqqjyta9630.fsf@gitster.g>
 <agF_0x0yq78J-RFk@pks.im>
 <xmqq33zys62a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq33zys62a.fsf@gitster.g>

On Mon, May 11, 2026 at 05:29:01PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > So with this change we now run the tests for all "official" branches,
> > and on pull requests. Which raises the question: are there any events
> > that happen regularly that are excluded by this? Because if not I think
> > it might be sensible to just enable this unconditionally, also because
> > that would make jobs on GitLab CI run expensive tests, as well.
> 
> The simplicity certainly is tempting.
> 
> We could instead do the "let's enable only on linux-test-vars" kind
> of "optimization", which is on the other side of the extreme, but
> that is only valid if the kind of bugs that can be revealed only by
> EXPENSIVE tests, which may not be caught by others, is expected to
> be pretty much platform or configuration agnostic.  I somehow doubt
> that it is the case.

Yeah, it's probably not.

> In any case, I think spending on more machine cycles is certainly
> cheaper than human resources for things like this.

Agreed.

Patrick
