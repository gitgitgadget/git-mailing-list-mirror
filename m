Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988FE25A2C2
	for <git@vger.kernel.org>; Mon,  5 May 2025 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451506; cv=none; b=Csg/LFILWccAYmTGB/DuIeBdexy0LE8n1Bu8lr/LkW7BqbJLRnPgz3MZgV2I0Nyig21oeGbiAz50j2T2vXFy8Ndyvyv56ZGaumNTe6cT35CAMmpV9ybgrSc/kihRK438uphUZYWfTCHoQNMCU6RYMGC3spmhbq6ythP7qFRsycY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451506; c=relaxed/simple;
	bh=IqG2I3raV8Zvv4zj5HcMuXo5ddVu2O+29YGYAFHSmqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXyNn+IH0Eg3I3tMa0NGfqg3wVW2gjXJKFtsLTX4cp83BRXEX8CTeyiR+kLEAM46nR7UMcApD9GCTnJzDRl9d/Pku8rgWw0svkhubjCpcKTe+yeB4ehJoFvJf4UY7sou5ApJji4tsKpX6zKhVVxYrqYxdKnnqBxLBXpAavH4nGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OuB4PFEM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NzT4o3cP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OuB4PFEM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NzT4o3cP"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A084E11401FE;
	Mon,  5 May 2025 09:25:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 09:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746451501; x=1746537901; bh=PSXYHP1J94
	tgYtDz04igWZsP8t0zVK0W/dJagKnUIEQ=; b=OuB4PFEMpTHay0GsUY8Ndo1oYg
	iui75tjf2r86jpWoA/u4rKRjLMFPl26qCOxsGFVL1FZdwC0sJtEXXxDMRl+8meVQ
	n5wqXLihEbeT6FsTeDnZLo9xERtCbV9CtAMlzhmgjnDQ5m2JN1jZp0dXS0DuM+PZ
	95IGTAJCa6IJ7mMh/qXmllQc4iv5f7+sYnDbQPMxjFKBwa1ffSlvtZD+NOK9uRw9
	dZTyHRivHh6It9DtYGby6rgFzhzOmT4XmnFxTglZqEe+KF4PhQG+xPs297ZLdLZb
	WrPEDw6AT5O11M9qVEBZKNbFLgKk7L1Ta6SaTAl4ejlIeMCEkDpHkQwqUlEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746451501; x=1746537901; bh=PSXYHP1J94tgYtDz04igWZsP8t0zVK0W/dJ
	agKnUIEQ=; b=NzT4o3cP5+R0/yak/QbkJ6n3+L1nTx4PfJuZviBgRhA54EckPWu
	IMCsT8/c+N9jFbXQEYakOZE+3oviSMfiluCyYJ3bqOUnoMUsPtz98cFaHvQ4zJb2
	Ve5rfvSN9HmZcGYZe36QCZTg+MinuHn/D91MeC6xeE9E7a80Uz+e+EhkdPyr9iWe
	T3cSEH05R7hOTiIqt6nqXujYOzFsHW0YQWRd22WZFcDjFXtRoIv8Pc3Z6MzlxNUb
	p0N1ZN0+W5ZUuJvJlJr6QGpyWwEmUGCFF22iDilJ+Tbiv+hW+Ne1nCT6X6nG6Rj3
	Hx3S4zbqj6CQYcRRA4FA1TkhcYwPWdMjOvA==
X-ME-Sender: <xms:LbwYaMzHcwEeo04hHFm0LtxjGlPTmBwYhms-IthW5GXEnMydRT5C1w>
    <xme:LbwYaAR20wP_qn_1FpcwXM71BN-G-Frqe_AZ0Qvc5CN_eI72zl0z0Qnk1vszMBKlp
    LkHa0BNZB5HiaVPCA>
X-ME-Received: <xmr:LbwYaOUvIdjwCmX83Y-kiW9vqhM6EYwsi-0EI88-CZ40hQ4e2Y89DKqqMQ8CoKyIAJtEqxl0rJvsyHEEcntYFjNpPhzaV1xu-ngPlNN2iELsug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:LbwYaKiOKNnFj0sCtakd9sYUZJ46oS9c91wgQB3m1TfXb52vJRWA4w>
    <xmx:LbwYaOBxk1X09s_O4WCz2rRXuBQmdP4K9HB6GdE7tucIIDtNQmG73w>
    <xmx:LbwYaLJYfaMaBYqEUbKvIEXzGtNWIHmztt5tXY_3aGU0zikMUTJ8AQ>
    <xmx:LbwYaFBBxMwj9inBjz5DcHaUpLe724GQ01-jJhEVwpmnGdpmGn55Rw>
    <xmx:LbwYaGe-beAGlCDKrJYPAkUBCV5FhjA9y5tZiYOvqgFDxHk7Lv_6V3t1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 09:25:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e6cfcb93 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 13:24:58 +0000 (UTC)
Date: Mon, 5 May 2025 15:24:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] contrib/buildsystems: drop support for building
 .vcproj/.vcxproj files
Message-ID: <aBi8KQWP4YAi6Gph@pks.im>
References: <pull.1916.git.1746430790.gitgitgadget@gmail.com>
 <1ec2a4bb1d58ea8cfa6abb2a0e625ef3e0db2a1f.1746430790.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ec2a4bb1d58ea8cfa6abb2a0e625ef3e0db2a1f.1746430790.git.gitgitgadget@gmail.com>

On Mon, May 05, 2025 at 07:39:49AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Before we had CMake support, the only way to build Git in Visual Studio
> was via this hacky `generate` script.
> 
> For a while I tried to fix whenever things got broken, in particular to
> allow building confidence in embargoed releases by running the CI builds
> in Azure Pipelines in a private Azure DevOps project. I even carried the
> patches in Git for Windows with the intention of upstreaming them,
> eventually.
> 
> However, it is a lot of work with too little benefit. CMake is much
> better supported by Visual Studio. So let's drop this hacky script (plus
> support code).

Makes sense. This made me wonder whether we also want to get rid of
"contrib/vscode", which is similar in spirit. Both Meson and CMake can
be used natively with VSCode.

Thanks for working on these cleanups!

Patrick
