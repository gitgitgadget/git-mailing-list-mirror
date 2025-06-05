Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DB621A435
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121210; cv=none; b=V6ogrbe7OhPLcNqZBen0Z9l10qyg/5j+G7bEJFlg08t5jD1xh1662Sry+pnP2MZMNHj4IhfYBCTRDvflqsojX2h94AEs+Pk59VYwLkKU82a0JARfps/zKgQ1wz0CCigympIccFTmau24OP37Bvro+c5l69lkKbZSgfFN81PICy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121210; c=relaxed/simple;
	bh=BDXOn7K5rp8sMrdk+89YaYxf79FL3rADH6zg0OzTIaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhJdDI6uWnS9xXe2IAmcYLwfzhDrAR/HLcINYNGKL1IR3ZoXwYQHPVXC5pMNB3GnRgDoPCZQQE0zYNR+8h65++gAPmBNH31fS6+bkhWgiTViu1M/Hp+NJAaiKx3WX/o4LpA2bD7XHkgBiVw9pExhr5aRXyLeq1OkwGGalzIXeLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GkqdxjjX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tji811T8; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GkqdxjjX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tji811T8"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6CAC2254012A;
	Thu,  5 Jun 2025 07:00:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 05 Jun 2025 07:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749121207; x=1749207607; bh=AKSquo/B1P
	MB4JBQGAaZX38+oMWNcKpIQLgbx1NEw7I=; b=GkqdxjjXftvEGX6Y20toaCikqe
	DBPpV4DGs3Z5panotpipgztSCHIiT8HDXCf9mF99xTOn7lTvuvIZJ5k4OldBPTmt
	cTw9mhnVwQT4lFOW+NawzY0qQV/2eYDHAc2nVd8xXFmal/KrI9fUdPGEENU6GyQW
	PoYqwkez4a5OrQmHstDfjk4H3s9riZiHD7es8Q09tSoEBoByV7rxf+GuMl4VM2ZI
	Sy3Gt1ZMDjkmxycAh7uSp//5HbXWfUh8DDq3g7UXm2m4iw4gBtYUtJ7EasTH25aD
	M+GZXcyfSrAEwydbzLSvwYbeteC4w0XH1N5WSwhaInlkgMK+O3QfwXXseflw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749121207; x=1749207607; bh=AKSquo/B1PMB4JBQGAaZX38+oMWNcKpIQLg
	bx1NEw7I=; b=Tji811T8CfdUpU4YBUvaxIXk3jcrh23SXLVjj8DnUSnEf6q/LTM
	ZmrkBx2A9W42EiPZogLfY0IwtiPxKzJpHhJxInCvlFaxKgk2ywh3C7PzyS21DHpH
	DsWIDJczVkFXKAXo7/4kbdtWCdcm9i1yuGjp7t3Kkfnzo+3TpChRB0TmlYQBwDU6
	17Dr6X79qA6h84Pe9uH26H/qbZ03zti5glPjCnJHWF3tH579FHDwSGkZ5PXSgRPf
	lciUz3pCtroVuVEniKDtH+X1q218ZcW+bT4VVCuFE78Qv0nPOG4SGhzfWBuMLsNW
	ePIEbKH+u7Yn4qGGUlSDI7o7bqN77bc0TjQ==
X-ME-Sender: <xms:t3hBaNIol9Tzpi6wk7ORP-40SVWJnepmQC_INAckUto0_pss5cW52Q>
    <xme:t3hBaJIpl1gus8gLtUk4xG27O37J4k4HrO3ksFP8TI4qFTasbJPrlTPPQNS0OsvSr
    wTk7czSgdCJYzEUFQ>
X-ME-Received: <xmr:t3hBaFs3rm1Y_yZAxZrfnN7Rib8_CfCbLWmVd2Lnfxv1SsbTtq2F7x74TiKyIizeAvrX3GkF-UejyCLMW-_1RxPpzhmEzlChcWpzLpPirg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgeejieelffdvudfgleeuveevkeffjeelhedttdeuleet
    vdffvdefledtleekveegnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:t3hBaOa_sG-DCFJNw_ClLtA7gr9u9ugXanhlu2o3Uz3PGeWnEJYTSw>
    <xmx:t3hBaEYd9vIt-B6gGdSfBZZSpzuKAtm7cJmOyOHavas6SdebTqFepQ>
    <xmx:t3hBaCD3hcIME4tXdr0dhehywlujvkD1v61dizni1ExpJp5bFaYvUA>
    <xmx:t3hBaCaKLjNL-ei7K3PFgJjD0B6pJziUTie_ovQci6S9X2MyuFfSxA>
    <xmx:t3hBaJT_u5rnwq5KNMpQ0whC1yhR9IZ4p6LZapeSxCW7zuiz_WOHicRH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 07:00:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 063604f5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 11:00:04 +0000 (UTC)
Date: Thu, 5 Jun 2025 13:00:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	karthik.188@gmail.com
Subject: Re: [PATCH v2 2/2] builtin/receive-pack: add option to skip
 connectivity check
Message-ID: <aEF4sxopIHndDpeb@pks.im>
References: <20250520014920.201736-1-jltobler@gmail.com>
 <20250520163218.263921-1-jltobler@gmail.com>
 <20250520163218.263921-3-jltobler@gmail.com>
 <74668a00-5b90-2450-52c5-d9f00dcb42b9@gmx.de>
 <gw6j5enpzcit2zquafoaiujreoa4kbv3n6feq6yeqylcfynqim@s53ctnlg7tmm>
 <aD7tKfXD7YxprSZh@pks.im>
 <0c2cc369-f57d-e03c-88b4-2e3206953101@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2cc369-f57d-e03c-88b4-2e3206953101@gmx.de>

On Thu, Jun 05, 2025 at 12:17:17PM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> On Tue, 3 Jun 2025, Patrick Steinhardt wrote:
> > On Mon, Jun 02, 2025 at 10:59:53AM -0500, Justin Tobler wrote:
> > > On 25/06/02 05:01PM, Johannes Schindelin wrote:
> > > Thanks Johannes for the report. I'm not quite sure yet what is going on
> > > here, but I'll dig into this a bit and see what I can figure out. :)
> > 
> > I've been banging my head against this issue for a bit today. A couple
> > of findings:
> > 
> >   - The issue is specific to Git for Windows, I could only reproduce it
> >     when working with aa550efd0bb (fixup??? survey: add command line
> >     opts to select references, 2025-05-08).
> 
> I can reproduce it consistently with Git's `master`, see e.g.
> https://github.com/git/git/actions/runs/15454602308/job/43504424816#step:6:627

Huh, interesting. Now that makes me wonder why I couldn't.

> >   - When working on top of the above commit the bug is consistent. It
> >     doesn't only happen in GitHub, but also happens in GitLab CI [1].
> > 
> >   - That being said, I still can't reproduce it locally?! This one is
> >     quite puzzling to me. I have tried to get my environment as close as
> >     possible to the environment we have in the CI systems.
> 
> I, too, was unable to reproduce locally (probably because of the way the
> runners start the processes, without an initial Win32 Console and all). So
> I took to mxschmitt/action-tmate to debug on the runner itself. It is a
> bit tricky to do, as MSVC's debugger runs in a graphical IDE and gdb is
> unable to find the symbols.
> 
> >   - I have a fix, see the patch further down. But I don't understand
> >     that fix just yet.
> 
> I would like to propose an alternative:
> https://lore.kernel.org/git/pull.1932.git.1749118606047.gitgitgadget@gmail.com
> 
> The reason why I prefer that solution is that I suspect the extra script
> to make the conditions only less likely, but not impossible, for the bug
> to rear its ugly head.

Interesting find! I'll comment on that thread, thanks!

Patrick
