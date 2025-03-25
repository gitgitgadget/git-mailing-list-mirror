Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2511B4234
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944104; cv=none; b=TFAQ4SbsejaH/msS+p3U2hHv95/ZcUGrk0zAQ87kiG6hzchCV8oej3J6/EVGZ2NBLo3wna0oDi4Y+vpEce31dO+7EWA/YaQl+0KMq1mEEilu9H5RnVcIYhf1ESkIwTuN4Ro4djOWy6z8FJO0XqBhFyM2FcpGMXrz05EHzP5IML0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944104; c=relaxed/simple;
	bh=uoVKzBOianoIUNGOIndNXL6CQZ63FGdAatdQGO8x5pY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=paBDM9CphByO62h/PjSoqa+5EtFUAdNCiJ3X/c7FQvKjDrNK2RfxHH+GtRJc7hEsrOOO1qz0h2MJcI1MYMntBrVMhhCnAg6faWgdyH48ETQzdfGYxgVte4gCvJr+GAdZeyt3xaT+R7ludHTW4trlJ3JMu/QbfRT0RQnY/aa/FJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AANP5j+y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZlSWu+UF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AANP5j+y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZlSWu+UF"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E84E1140152;
	Tue, 25 Mar 2025 19:08:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 25 Mar 2025 19:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742944101; x=1743030501; bh=C8cxJGFee/
	YOz0OrVFtQyzVq6ZxsN3nrOwweYE1fH3Y=; b=AANP5j+y4NmjodC9bWJx/Wqijs
	O7ySSw87JzTrvORj5IHQWGzwJ8yrwmVpxxybTKawMYdcideEQbUqnnymg8MYmpcv
	L923EhdCYIM67JVD4ZVd7cZdeeQTD8R6vuRciOvlogV23eCGBgKrJzKqCt2MbBpz
	VShN8Gu4ztYWGNT2/vLEefBxZGjkEBGTaeshKufdGWEuywjCvv2HrnOeFTuIBPRa
	yVo056IndgBI0PBo2IehuPv2qGWnj3xZZayPhyGplRp4vgVMxaIq3OcOzr4D3pO1
	Fz/YpdUq37dbTRwmmrbkdCJAgYahaLSbK+HRuMShTtosqlt74/kV+W5OV7Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742944101; x=1743030501; bh=C8cxJGFee/YOz0OrVFtQyzVq6ZxsN3nrOww
	eYE1fH3Y=; b=ZlSWu+UFprR7PWK2esXwYRZgpGN/XHe3v3J7uXzga5kH2dQZ0Wk
	Nodq2qD5gk6yBBBeb3b8VEoap3QwMEDb7Jbq4Nz3n6UikNoFf/wWQOWpBjR0lgR7
	3HwZhfTs/SyzHqYtHjPw7vGHmQxWCTZWI61n4ZYlmZNYIQU8awF4kIsf7l3kmVik
	fTB9vFRbp/8X/iJG92il+0tFVit61xL6KOck/Dwv4DPMFwDDx3+cuhqzUFal5Ip5
	TtNqVEZlkld4V2iVtDje5Ak/kMuTczGvgUn2qRPUahxlYT0zGEqA5ec7j+3MXKJq
	UvpSuX/DKIeZLCYbeXfnZJUk/h/kzene19A==
X-ME-Sender: <xms:ZDfjZ8W7-OiBm6wB27ORZqoPz8NeiNvHm84hvAxjdDbMwxBtpP5X4w>
    <xme:ZDfjZwkNLeLB3n_MJbNv1sdHran_AIhG_QBaY_JsLnbVwyabxbEYej98OIxF5kupW
    wE1YihbAgn0Mf-UyQ>
X-ME-Received: <xmr:ZDfjZwb7kJDEVBb-xjdDJd_pANkzllDLwB9wu7MwMfoGRJ35hZWiIt4hRWskraQZx-8YZZ2rMfqNcTcsKqXOOp7Dy60ioyX1Qy4tvEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshes
    tghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZDfjZ7WxrbGkXrS9eE0AuGOtgOAt0KnhZ5THMCTH6M3flaeGvu2ryg>
    <xmx:ZDfjZ2kMvbm6zfl1gcTciIpYC_BRbq_lGKYX_D1DxM0Cngk6zUUoaA>
    <xmx:ZDfjZwc7V-6LE9caRQckMqGvfJV-sNhjXF6G4r9vWuRLI-Ad94g9GQ>
    <xmx:ZDfjZ4H9Pcn9ZaqeK6mAyCe5-M5i6rVYcMins3FtHuyiiqMtzNQtUw>
    <xmx:ZTfjZ0acULnx9WtxhYVJyj_1X2MXdggwWhkr0Ek52VPcDSvUeOqA3vTp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 19:08:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  git@vger.kernel.org,  "brian
 m. carlson" <sandals@crustytoothpaste.net>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/5] libgit-sys: add symlink to git repo root and
 build out of tree
In-Reply-To: <5qvxvuquk2yuyoyoctz2ji6sj4yld4ridig24elpoiytghlovw@a5hgdufrchwr>
	(Josh Steadmon's message of "Tue, 25 Mar 2025 10:57:11 -0700")
References: <cover.1742339107.git.josh@steadmon.net>
	<cover.1742594960.git.steadmon@google.com>
	<6befc95a2d0893aa269142a18d60ad07e79c6e88.1742594960.git.steadmon@google.com>
	<CAPig+cQ+05r0iJO3me2=yz1KWaU_S_WQmbeciOqZGxYWgbT8dw@mail.gmail.com>
	<xmqqo6xqo2o1.fsf@gitster.g>
	<5qvxvuquk2yuyoyoctz2ji6sj4yld4ridig24elpoiytghlovw@a5hgdufrchwr>
Date: Tue, 25 Mar 2025 16:08:18 -0700
Message-ID: <xmqqy0wslndp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> 2) keeping the top-level clean of any Rust code or configuration.
>
> If we're willing to have a Cargo.toml file in the repo root, ...

If it is more like adding a new build configuration file whereever
we have Makefile (or meson.build), and is not like we are adding one
new file per one existing source file, then I see no reason why we
want to avoid adding a few files to the root-level.

> ... we could
> create a "Cargo workspace", but I'm not sure yet if that avoids the same
> problem with accessing sources outside of the crates themselves. I'll be
> able to test it out later this week.

Yeah, that would probably be a reasonable thing to try.  Thanks.


> If the workspace approach doesn't work, the alternatives are:
>
> 1) avoid the issue for now; anyone who wants to experiment with
> libgit-rs can do so by building from source (but it will prevent them
> from creating their own packaged crates IIUC).
>
> 2) move libgit-sys and libgit-rs to separate repos and depend on the Git
> source via submodules. This is what I've seen done in other -sys crates
> such as zlib-sys (https://github.com/rust-lang/libz-sys).
>
> Of those alternatives, I prefer #1 for now. If we build enough momentum
> on libification and expanding the coverage of these crates, then we
> could think about switching to #2.

Yeah, or putting it another way, #1 would help us gather enough Rust
minded folks who are familiar enough to come up with ideas and offer
better ways to manage this part of the system.

Thanks.
