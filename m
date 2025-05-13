Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FFA212B28
	for <git@vger.kernel.org>; Tue, 13 May 2025 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127584; cv=none; b=LASjqhrfzZ0Qw+gF159Jh63atMLEZnvCKkISimdwc/6TyvcfBg4ayBKPxYT6K2WLGszTNY859nsxTEvVt0VjP6hpLOEgH1Hx46hHFrzSo091lSUurD8oKf6FvCUb0+yHHSD4yOgkMl0aGlzFKK5Gdz0mrIXrce3blfad4ttghdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127584; c=relaxed/simple;
	bh=dfjgTly4Y6qGbrm+whVHV1rb5Pjjg3eaguuv3fHit34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUgNseIk2HvsASLpurg0kUKpFwlsa7l2oK/3g0j/b0iMlWBHU++FjPOhKoNJAyKPb2MX092EVxi/1vZR4QSYRe92NZpFS1177UeVRO0+Lx2opJ2DMZR1OxSreQGCShqvsPnVPxMltmQ6vm2SjLSjXaxojMT03JieeK1qj4heUGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OyezdJqp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PBjlU+ha; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OyezdJqp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PBjlU+ha"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id BCEB511400D6;
	Tue, 13 May 2025 05:13:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 13 May 2025 05:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747127580; x=1747213980; bh=Pg/q7hWLkc
	F7RFD1SWPIbtmhPt0A0hyqnXxKYIr2SCM=; b=OyezdJqpNGDIlldA3SsxWQ+Wgn
	lBiX2Qu0Hgvj/XWJfOrChJLASfj05d/VkfpQNyZj1SO6hrLvSfmpYAsdTHB8+xQ+
	xYs6gIkp0ktOT2ZsN/ZX6TaVqfLEUaoWAKLhdC/nX9pePyVxRjqcPxeEDqoZH1Cd
	w5qw+4izRwWPdTsGVxUQDoAI0fZSqPW9RdvFYOG4gGPWWhIgsS7JAdHRsfevN68s
	51j3XXGtsOkS5JTkEpHDZZ6BK08WsZt/93QjghRe+UGLKwe38wWWHhUbtOdRqkfX
	EUtgpmAGiABxFzN4kQ4gziKEzGJ5MMAFPFkYK1Gw5GB5T/wbHF4B/JKuo0lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747127580; x=1747213980; bh=Pg/q7hWLkcF7RFD1SWPIbtmhPt0A0hyqnXx
	KYIr2SCM=; b=PBjlU+ha9Im7SfbGAbEghZFLhsm2PN98nGJOISMePRotsQDNGxQ
	xay2987Nn2OIdC/+hhgzhpp1N2g7pC/wtAbzrj9nvtbv9Iv964FFeS1Y/NNB4xVd
	7mXaI0SFMe2qobnhRPF9ij+dlqeAY5ZJt0iEG16uz9qGYkl0BdtKKBIvS0UG1cFC
	luMhp8jNpO60V9OUSsbxyN40f9kKY8dtTokuuoYY3aot8X3VQvJnJLdh1sFpYVOD
	QBHmHsCQYwEk2m6TNgsIkMg/WMx4zJkdsx/+irCF72Ar5dGAMM+f6IGhdoIk4pFp
	N1brvamZ+EKEWamOk25R3GHbsRdmnLFLLzw==
X-ME-Sender: <xms:HA0jaEupzVXnzcg6QzuAllQ9p-Zqi4dJP32SqlrgqpSxD3NVMDHf_A>
    <xme:HA0jaBeTxLFeYIOKjRJAibujBfwZS5LDzX6KGaQVEO3Ed2UqPMsl-K2VK1Xyo8PEB
    uLsWPh1tVN99OR92g>
X-ME-Received: <xmr:HA0jaPyibc_GUmxI_Y8CotSe8dSu7NicPhgwUOTe_teQ3Ez7Jq71BHIFPWaBx1e0fmjkV-II34JSDz1cna171MT64KZ1ZmLFbdtQX0ovn9OY6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HA0jaHM5UN8NvoIdh7MifybEtvOSwzRTsVSVo_aiWx5yXTiSLZXVLA>
    <xmx:HA0jaE-MDRXHb-7jw3xQXsvGhdfAqWMgdyJjTbJWHtRfz_fnC6V1pA>
    <xmx:HA0jaPVTjn5x1L5FRdR778pTsb7CSzUVvO4MlVrxbFmj5heDtaZOVQ>
    <xmx:HA0jaNdugRBCpcrqbf2LlIYV5BoQLyW3nuTBhyMuNlTtOp4ZTR6y9Q>
    <xmx:HA0jaN9ecCpaUt213v_v379_xZmmKqSpVvTVF-j1-aBzCA8HuS-c158h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 05:12:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3f0008f0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 13 May 2025 09:12:58 +0000 (UTC)
Date: Tue, 13 May 2025 11:12:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitlab-ci: always run MSVC-based Meson job
Message-ID: <aCMNGUlfBcafn97s@pks.im>
References: <20250428-pks-gitlab-ci-execute-win-meson-v1-1-f68683552b9e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-pks-gitlab-ci-execute-win-meson-v1-1-f68683552b9e@pks.im>

On Mon, Apr 28, 2025 at 11:32:12AM +0200, Patrick Steinhardt wrote:
> With 7304bd2bc39 (ci: wire up Visual Studio build with Meson,
> 2025-01-22) we have introduced a CI job that builds and tests Git with
> Microsoft Visual Studio via Meson. This job is only being executed by
> default on GitHub Workflows though -- on GitLab CI it is marked as a
> "manual" job, so the developer has to actively trigger these jobs.
> 
> The consequence of this split is that any breakage specific to this job
> is only noticed by developers who mainly work with GitHub. Let's improve
> this situation by also running the job by default on GitLab CI.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

While there has been discussion around whether we can in general avoid
some duplication in our pipelines, I think this patch makes sense
regardless to bring GitLab CI in line with GitHub Workflows. I haven't
seen the patch being picked up yet though -- I assume it fell of the
radar.

Junio, do you have any concern with taking this patch?

Thanks!
