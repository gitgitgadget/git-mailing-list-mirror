Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877503E121F
	for <git@vger.kernel.org>; Fri,  8 May 2026 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246433; cv=none; b=dybMn9EDVOD8YFaUtGeOFoqt8VnMnOOuz+Rmbkch7E2coy08lWQE/caHCUw1Euprp4XJpzg7UKliOOp1pSddV1Whfi5mI9kRFJXObnYHzkOh0Oh5rJ+Yvxb8EuTkypB1ZUB5xUbgRR9WPD6/9GvRgt3dT/kfgU5H4za5jeixKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246433; c=relaxed/simple;
	bh=cVD9tQAXWjwv6q87xQiczYV9WNmhiRvfGg98xkbxrKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQzXeUN+FEorXLatc3DQn++AhkX55IND9Y5+xWZt1Ta8TtcoLDAa6noM/WGQbskQE9Kd488+W3iC5tr7HGGdW/IGLFhE6f079ZT9wTt9BF5FEI7UEyoyp22hQi9bHz4RY8KYeJ9ViB9g+ihy20bHCIcz1IZ+A6TDyhVilgyhEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hkhAoNeO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ITqifbgU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hkhAoNeO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ITqifbgU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E1F7EC020E;
	Fri,  8 May 2026 09:20:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 08 May 2026 09:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778246430; x=1778332830; bh=0B/AE2ICti
	KRA7XpDLGV+rgIxZibERCVoVnZGB6whOI=; b=hkhAoNeOA5hvW8w1aBGLlc607A
	hEzxiyNR2mxr9tbnNvcwcVi9PHUYpWZTRnQwp49YO26ijrXNPl722xqA/Fp76NYh
	ETiYg8ByYNhbKKD1hXtBCIygAWA1poPoQX4xlf1UukjLspTpopeq5Rzh7WGm8DpU
	erf8DWwMdlb7GB7qfeTao5BZbRoJ4BooZ8R+d4hS1+yHBe3WZy4wQb+xrszJUpFU
	vGBg7fBgHuwFTmub72yeMtt/xuJqTiUI1CEtqmg/fnQoBSOxyH9IVf96o8dHjl+h
	dhT2ApYNVHV0T3eN/BtOk/JNReLTfsdbw4i+FmVAbeyvBN1ZoCTKZ2UJLDWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778246430; x=1778332830; bh=0B/AE2ICtiKRA7XpDLGV+rgIxZibERCVoVn
	ZGB6whOI=; b=ITqifbgUHPStC61WSRoVfEQRuIEmQ5G4aO24sL/ha5aOmVAaZNE
	TgJwblrjJOTYYI2ja3b3KzuaMPh9hBPYW+T0piqlHOQXxXjLUaDhTbawxm6EoNx/
	IH3lbjwm1KZ3loYJWsIh78PuqKxYT6jErOt0Len3ecu6D+T7L+/KBNhWx8H9duVz
	nMTg5RcvSO35xgdbIQO+SqJmWIaGwF1lrMffcuL325LggezfQhqnERX7hzS2GgyZ
	XjzNxoBNYQWJxtKRK15VEBCicT3AfOagmae8232uYoMJm2YeLki13rzAuNoP4l4E
	cckkmUewbCbMzI/LHpbouwt/jxfdLOIG/2Q==
X-ME-Sender: <xms:HuP9aSt7ePymP5PYSSxuer40ZLGFIDnmg0pWfRaRCu6o2sJ5eLMH1w>
    <xme:HuP9aefTx_bnT-5rHKMfdxcerC0CdJhhgGFCFazVPoTPPjF415wuKldp8ooTp1X96
    KrLhdeLDn3ixeQLqK_S7CwyAZl-peC-ZnJEk629DNvoWy3dL6a3WA>
X-ME-Received: <xmr:HuP9aSzRVLTjd_Tq37c0QXpBT9Epzkg_RUVkailrukh14-_sF2O5-vo5DAmPwiA5SXMkNf0T4mH9VVFbkyZUBe47T4GVbONmNX2I6OlZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgeejteeguedtfeegjeekgfduuddvffeufeduieevgeejvdehtdetueehieffhfeunecu
    ffhomhgrihhnpehsthgrtghkohhvvghrfhhlohifrdgtohhmpdhgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthh
    hinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:HuP9acGlutGxwOlly3gah4AF8ZvxbmNNfL9pUoNRWR89vlvJ1ICieg>
    <xmx:HuP9aewukdbSnHftSSDCxgJMBVeDa0i3PYWF1Ue0k7YGOv0GcfYrRA>
    <xmx:HuP9aVtQHwSNcL3El8fynGAnQbJJEYmOJ_-AxrXn1AA6djMMH_36Hg>
    <xmx:HuP9aT0MVmmwA57sYW_6pg0ARFRWMLfowd74M5NoQU2HzPVhN-XusA>
    <xmx:HuP9aWWt8J8lecM-9pVY9Dl_HCqWlcz4swrX9Z88x_DHss-_wGXQecF3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 09:20:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f69ab2cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 May 2026 13:20:28 +0000 (UTC)
Date: Fri, 8 May 2026 15:20:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] maintenance(geometric): avoid deadlocks on
 Windows 10
Message-ID: <af3jGSif1UH5tY-K@pks.im>
References: <pull.2103.git.1777380768.gitgitgadget@gmail.com>
 <pull.2103.v2.git.1778158273.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2103.v2.git.1778158273.gitgitgadget@gmail.com>

On Thu, May 07, 2026 at 12:51:11PM +0000, Johannes Schindelin via GitGitGadget wrote:
> On Windows, maintenance_task_geometric_repack() opens pack index files via
> pack_geometry_init() (which mmap()s the .idx files), then spawns git repack
> as a child process without setting child.odb_to_close. The parent's mmap()s
> prevent the child from deleting old .idx files.
> 
> On Windows 10 builds before the POSIX delete semantics change (between Build
> 17134.1304 and 18363.657, see https://stackoverflow.com/a/60512798), this
> results in Unlink of file '.git/objects/pack/pack-<hash>.idx' failed. Should
> I try again? during fetch-triggered auto-maintenance with the geometric
> strategy.
> 
> The fix adds the missing child.odb_to_close = the_repository->objects line,
> matching all other maintenance tasks.
> 
> The first commit introduces a GIT_TEST_LEGACY_DELETE environment variable to
> simulate legacy (pre-POSIX) delete semantics on modern Windows, so the
> regression test can verify the fix even on Windows 11.
> 
> This fixes https://github.com/git-for-windows/git/issues/6210.
> 
> Changes since v1:
> 
>  * The code now uses git_env_bool() as appropriate (thanks Patrick!)

This version looks good to me, thanks!

Patrick
