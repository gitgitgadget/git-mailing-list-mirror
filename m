Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D56C2045BC
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258230; cv=none; b=uYWApICKF7kqTovf2bbmSPez2shaejcelK9QBP4FSEmjXGvXi4cWR6KWi07+Wa4vjS4DQ7Utq/Pb6Ly/U7U6lfZPD+HMKCDfQSdvx6OitvMX6tmeUHnG2KuOGbFXXiI1it4aHQJF8H1baOn1hY5+9Of+jIpVa96XzHcj5RRl9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258230; c=relaxed/simple;
	bh=sykC/bx3YQEWiZbFZMreenzKy3dCttnaZOpMJ8Yovb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyhslOLEDqPrLP5kdLUQ/id8wIdbvIyuHC1zY5hpfrwp6prSds+32Zco1S/rnSn/L4vyz8l/OvAZjV/EkYILkE4xdS7/P+deanojumd61ONNjIGPz+/HA85v2RzM9Mud2ls9YsdyrGUl2p7hCAl1F3rSw4TYsmz+49Tio2MCmH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DzYzvTfr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f4dTn1Da; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DzYzvTfr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f4dTn1Da"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 294E2254017D;
	Thu,  6 Mar 2025 05:50:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 06 Mar 2025 05:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741258227; x=1741344627; bh=sv+ghjJ0Jb
	YRbfFlrg985jFsJHmYatlFeAaGpkmoqrQ=; b=DzYzvTfri0G4WJaGNIcw/RX+ri
	Agg08KmBH9Q/hlOVm5rBaokp/Ripxczmddxh55ZaJudC1l6peLCqQR3yBa1qle0M
	s5YEEGnyTmIkAJx+K240AMLDtS6r0pjZ5bszdmkLegqGbTfbwkm0OXEdRxI8RDak
	1r2ei13x/DAm3a9EHFrNLYFyu1Zr6sWlrrTPKgBU2oRBRm52NKn/P68iRsmoNpKA
	d+9cAMigpqqcV0bUzUDxQCfkDLDf9tLRaDgknp8ugtNpGJr4YWa4kDP83l6XsBUN
	ExukRjn+lhBcvK6oG88NItjIutZit6RGS0Fby3EMmBjehHfoAv6emwlxCVuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741258227; x=1741344627; bh=sv+ghjJ0JbYRbfFlrg985jFsJHmYatlFeAa
	GpkmoqrQ=; b=f4dTn1DaK3GSvNAHFvmjLQ7dnvPFDHb+WfHc4yIH8JFHhd9p47j
	AmtfO5gt32gL4iL9Ha9XZj8oKtMCcU1rZYwyJlcjH0BtuW2nbLe1M/BP2DO4IV+m
	CxUbNWWNWl+GPDfzPtP9Ofto3Qlehs4D3aaJr0n6cSuHmhN4SkXAz5IHUNO/mV5c
	NH2MYTr8ABeNSqDIItbmOw/HY+AtkoKlKROmSlA/KFSnO09MEoeXJmY2PodK7oby
	uYr7q09srRe7Mldb1KD2p5rdeGyttw5C7tbqluGRqJgk1c6w/ifZ2gToazUKVpEZ
	LyrpItpburrcFNsPhrgdoGD3z0ILD+/vstQ==
X-ME-Sender: <xms:8n3JZzfuta_WoCAB80xWSz1e5gRLenJAEQH2dChZNY5IOWsSrWVq5g>
    <xme:8n3JZ5PzJdnAMenZm_7yuHxLUpbaOOgN_VVSd84omGg1BCnuyKd3x11DOS3b27jMp
    QEuaXFQY_X5kzWS8g>
X-ME-Received: <xmr:8n3JZ8gf44prARinYPv1xRz545q9oC-5cK3iVb6CTz_jz9NJWhjGMW1qjJ70nzVltC30yIHtVcuVOtXuA7z8vgZSnng1Vnnlkvw8g1AaT1lydw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepieeffeegieeuueevueejkeejjeegleevueekkeeh
    hfdtgeeltdeuleekgeefkeeinecuffhomhgrihhnpehgihhthhhusgdrtghomhdpghhith
    hlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:8n3JZ0-khTJPfdEfJaZQOOmujs9SqmSVmg1BprEuzNP0MsBerNGfqw>
    <xmx:8n3JZ_uzncuBBF6bGJ0BY8sn22wcluhyifZTvX9FxV7EOYw4IvMcqw>
    <xmx:8n3JZzHAI3g4cwSrBqCM88dHvXZ2YRVs4fVfYEbtd2zhB4d0-Vr-gw>
    <xmx:8n3JZ2NsrmMFp3Oed87N2shrvPxGiIfx__rUnP3FVyyw6FLmm_Vgng>
    <xmx:833JZ_Kat8zoMSY7gtPjMQ0L9CvVgCPd2e9ODybceAi5ScX3X7ZfEtbq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 05:50:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d2a5798 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 10:50:24 +0000 (UTC)
Date: Thu, 6 Mar 2025 11:50:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] ident: stop assuming that `gw_gecos` is writable
Message-ID: <Z8l967w0rjrnWGpO@pks.im>
References: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
 <pull.1867.v2.git.1741256780.gitgitgadget@gmail.com>
 <3e9ccffc7474698947bdcb6d49b5d0728deadd08.1741256780.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e9ccffc7474698947bdcb6d49b5d0728deadd08.1741256780.git.gitgitgadget@gmail.com>

On Thu, Mar 06, 2025 at 10:26:18AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Now, why does this not trigger in CI? The answer is as simple as it is
> puzzling: The `win+Meson` job completely side-steps Git for Windows'
> development environment, opting instead to use the GCC that is on the
> `PATH` in GitHub-hosted `windows-latest` runners. That GCC is pinned to
> v12.2.0 and targets the UCRT (unlikely to change any time soon, see
> https://github.com/actions/runner-images/blob/win25/20250303.1/images/windows/toolsets/toolset-2022.json#L132-L141).
> That is in stark contrast to Git for Windows, which uses GCC v14.2.0 and
> targets MSVCRT. Git for Windows' `Makefile`-based build also obviously
> uses different compiler flags, otherwise this compile error would have
> had plenty of opportunity in almost 14 years to surface.

Oh, interesting. I didn't even know that the Windows runners had GCC in
their PATH, and thus I didn't expect it to use that compiler at all. On
GitLab for example we can see that it uses the MSVC compiler as I did
expect [1]:

    Activating VS 17.10.2
    C compiler for the host machine: cl (msvc 19.40.33811 "Microsoft (R) C/C++ Optimizing Compiler Version 19.40.33811 for x64")
    C linker for the host machine: link link 14.40.33811.0

But you're right, on GitHub that's not the case:

    C compiler for the host machine: gcc (gcc 12.2.0 "gcc (x86_64-posix-seh-rev2, Built by MinGW-W64 project) 12.2.0")
    C linker for the host machine: gcc ld.bfd 2.39

We can easily fix that by passing the `--vsenv` flag to Meson. I'll send
a patch soonish.

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/jobs/9324989037#L95
[2]: https://github.com/git/git/actions/runs/13686408338/job/38270746786#step:5:15
