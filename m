Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7314383C74
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047483; cv=none; b=Bde0yU+VpMQabGd7dU6GzPxH/nwiYRMv+VoOr7T2Ek/WgC3jbvSpTNXd7RDGGVqhOdUAGMn/7yWgo0Hjh3u52chooNaoK3Bc5OQEffdhFeToBqxgcUTjUF9KTY6rVdfajRcbJkM23IYoF80wJcROTC0XwvrJWK3+GJAf0We8Hqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047483; c=relaxed/simple;
	bh=518jIDFWA3WCq9Xbdz65DYC7HPA1M18BMYw7lAoADTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pN/IEizBFWrB/rgKkz+xdeTsTWIecxUkPPgirOPTxziVttvJBEi7LpziDheYxJz60rymeY8bAiAF79G+1z1Slp1spL5RRqpkaFAkXPfy0+R3oSFqhOYqA7K2q5wyGPs8QDYD0SABZjA1qKa57gr8mNJ9ZiS4Yw7eOeno6VguJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KI71eNEs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tsf5PEId; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KI71eNEs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tsf5PEId"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E4CB414001B3;
	Wed,  1 Apr 2026 08:44:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 01 Apr 2026 08:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775047481; x=1775133881; bh=d6b0Svv3dn
	XocP1ZtC2RxDvUsxgyUW8o4MO8lwxlB6M=; b=KI71eNEs5MPqLE4HgkiHYYbI4b
	uyyuOlt70c1PBgQ0r5l+93gxdUDH479zg8MSEOqGku3DVaoSGFI1IhnGnnqXuDDX
	dJ5CM9hj+jw4/PzT1w7SlmodKBgCDTRgF7kyHy/2ZfPJtz4crqyTsIV0Kbxs/Hyy
	MvAJLBcXBeeaLVRdCgkVykiT4CBLaO/Zf4TwjL8U1vFibLaDf0H6x2xW1lGE9voV
	1/3lrQBHLCIW+OrD4cTNZSnL+dpVGlVflfRv0Bf5Y2QX2DQ6snvFkZZwKBTJ5AiZ
	jP3bZPuiS3yzDmkDdS2eZ2cpFHDgzhPwaeDNgCEVf1w4w406SjmwVvOvNVWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775047481; x=1775133881; bh=d6b0Svv3dnXocP1ZtC2RxDvUsxgyUW8o4MO
	8lwxlB6M=; b=Tsf5PEIdtKxlM9WUgcW8i8sQc7hNgm4l8ioBkoqYptZsjusrcKK
	oHbPz2vqcnNJlfC+bYRCh5XuHnviMpuf57eqrW+Y8q8cwCyUZ0mBt/4HzeuA7goF
	QciKDhTXTD5w/VFzh2hnWJ0PmtvR2Xc3BYGyxHqREfY9sz93GPr9uMqFHqKlPY1v
	ynn8KqkCH9e00zaeMdE57ymxLiKn6Wj5TDrreV5sQsyV0u3VDOTRTJvQ7Zm2+SoX
	NEoy8kVDdqyPUz/Y6scJn5p860uaSyTv0dWN0mGNYuzlh7W6wc3K5Df25TqRvy3F
	OSXjVR4uTjk/ufGlruWIU0dfN2jF2C/zKfQ==
X-ME-Sender: <xms:ORPNaZNZil3tsdyniBXODuefE-OLdGXBwN3ausxeKvc7HFjxGbAQpg>
    <xme:ORPNaR_VeQbfYAeJR_08g_u5dWF1JN1BFP4YWrzrl6LWBpgpl2G6WiQNaXeTa_QJz
    aSDVE_NHSKFNVfK7neyRKSAoEvQGWBTdtizUhAiIaJmZtP7DIfm>
X-ME-Received: <xmr:ORPNaV6ONsarGqVew6jlnlp7bnK6LkMJjX1ltq75xMK877_ok8jqjj8p_IUUOrFQ_Sp0MPy7ziQyk2qbATmUK8_K0XVhxd2cLMR5juSabEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephf
    etueeukefhueehffffgeeitdfhleeuleekheevleelvedvvedtkeelveffgfeinecuffho
    mhgrihhnpeeguddrshhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmmhhithhrohhvihgtsegsvghnthgtohdrsghiii
X-ME-Proxy: <xmx:ORPNaQ1bpVMJOrdWRdahzdUshJEyILDgacNoFTliMCTvQ3keHVT5CA>
    <xmx:ORPNaUDw90zpzImd01n-AibtKCspBWBXrDLOvVxtz1f_KUSSyMRuJg>
    <xmx:ORPNaa22AiDBem5trZ-_kEmV4u296HrBr4FFhJZUHrgGwNrpGEXk5g>
    <xmx:ORPNaWvoV1o_HMl7l9yX3vbAWZorHrAUzHnxXbK0FNf27CvABQQoYw>
    <xmx:ORPNaQx48S5JRtlifeEKZgLEIQU-LUkYWN0wmdCoiPfv_upMj_woCVSx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 08:44:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ae895020 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Apr 2026 12:44:39 +0000 (UTC)
Date: Wed, 1 Apr 2026 14:44:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Miljan Mitrovic <mmitrovic@bentco.biz>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cloning an empty SHA256 remote creates a local SHA1 repo
Message-ID: <ac0TNM2l1r_cgwYj@pks.im>
References: <DB4PR03MB101069CF70418ABE11AAC1CF3C850A@DB4PR03MB10106.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4PR03MB101069CF70418ABE11AAC1CF3C850A@DB4PR03MB10106.eurprd03.prod.outlook.com>

Hi,

On Wed, Apr 01, 2026 at 10:51:49AM +0000, Miljan Mitrovic wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> Created a blank remote SHA256 git repository, cloned that repository locally using git clone
> 
> What did you expect to happen? (Expected behavior)
> I expected a warning I am cloning an empty repo but get a blank local SHA256 repository with remote set up.
> 
> What happened instead? (Actual behavior)
> Warning was there but the created local repo is SHA1. Commits then made to it are rejected by remote. And there is no method to convert a repo from SHA1 to SHA256, even when its blank.
> 
> What's different between what you expected and what actually happened?
> I expected git clone to create the repo using the same hashing algorithm
> 
> Anything else you want to add: I know this is a fringe scenario, but it should work as expected. Now that repo's have roadblocking init settings, the important ones should be passed on to clone.
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.

This was a known bug indeed, but we eventually fixed this by announcing
an "object-format" capability that tells the client about the
repository's object format, even if it's empty.

> [System Info]
> git version:
> git version 2.39.1.windows.1
> cpu: x86_64
> built from commit: b03dafd9c26b06c92d509a07ab01b01e6d0d85ee
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 26200
> compiler info: gnuc: 12.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>

The fixes required for this have been released as part of Git v2.41. So
once you and your server run at least that version it should work as
expected.

Thanks!

Patrick
