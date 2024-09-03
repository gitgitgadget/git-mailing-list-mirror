Received: from pfout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2851A0BFE
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358185; cv=none; b=Cz6ll4wIUXHPIruIoCuhSopIowSB+/LznQSMmkzZ/PZiVJspyShDk5jTLcDPmzYTHRq61sLNfCNqdPnwhk3iG0FKcysM9Q98Xq09M6gtZ52ZvANGPr/RyHcZjbSX8X9uxfo9E6vogQ4GUXbx4CLKxNm22VrYb1poSpz7eMoBw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358185; c=relaxed/simple;
	bh=c1VZtpySb6khlt6XGL6c0iAuRn0kYchiF1vLWjQlPmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsCf2gVpGbM+Ec54uzXo251xw2t4BMRWQni81gkSCGzSTGDNLWt6VU7uijxAweimvSi+fOeq7pcPvOLTAfuTgDDhypaq+vW8gHmDjYV832DJh6/75+AKv034MlZC/4xVWQf5w8b7Pvm4Dghuwu2mkPFMeXeayIRFDCW5pc9aMyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D0wLLPy8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uKQoKVof; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D0wLLPy8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uKQoKVof"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 164DB1380471;
	Tue,  3 Sep 2024 06:09:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 03 Sep 2024 06:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725358183; x=1725444583; bh=zYl9LtWqS8
	EsHnRRlFEGqSr8NAN8m2UIyoYKFchCcQ0=; b=D0wLLPy837yUS46YOxVDdXBX7L
	nPApSnaWakKFmZumC9E0pqSQjlzR1m4LEEPku8iExmtmY+R5mL2Xi5EXgM9iHx0J
	0VgUkhC9qTrO/n80KD8Ub2cAdIx96BsHf8stxHMO5uRHn/AsD/Qq5LxH+NJzj097
	HG8S3j0+YBl+QIOdqJ01o44W0hw6ak3BflmQuYOvPiasGZGsQcZxdGl+gdv5Mi1v
	lRs+/QhkIKjagnCldjZCEy9xHuH8FCkcYm/59ihHGFSAqNqSEUGkwiWHlOfuTmSa
	tSTohHvOhzw+4oPhvrjjAKl8DStvsUJJGvyID5Auq82q4FDMtgI6nrYqOh4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725358183; x=1725444583; bh=zYl9LtWqS8EsHnRRlFEGqSr8NAN8
	m2UIyoYKFchCcQ0=; b=uKQoKVofL+MrV7dVuHoY1Og3YLLG9UVrJZDcVodHvigf
	LyYxNiFW2J6Gd6jNaI1BJjf/Xx0L3Dw2lfsXkROOE+7d/RI1T+bKFiRDBcbAtTQ6
	JF46aGhJdMXgBxMWyUgEkOxFa9gtfmRYZ2+6Y8JoASapTLiu5e2st1OrFcquAKOk
	cks4hsatkE/PqnF1i4/OfuwIOYM0UUonq8txHviOSnvNp/NkecGfa55ZPHAB2G5n
	0I2qUFsoO4M3WmaUimDmcEgMM6Qxs4RwMiF+OzQ3LGgJuHHWklJuEEG3lBYSvY5v
	hfliAfkkmXy7LmDrXcX9FkOnQujX4ZBc+zBnHwUeMw==
X-ME-Sender: <xms:ZuDWZsXldV6wG1W3kit5G9c5OD8kRNGHwVfkJUgLevkV0K7Z_gv4eQ>
    <xme:ZuDWZgnvMxQ1YWpaH9gI8EW3njY65in4kZ9bEZomJdjkHbAqKt78T13REYSCHGDGk
    MSKWkCSzrtOEBCZ2g>
X-ME-Received: <xmr:ZuDWZgY1i2Q6HPa8W19WIAuOGRpQTPh2cAYRE3KKnrbYGVZO7QzNEfKfkm5KponKz0TI4plcx8lSb_P42wNeXPXKlgL3YMcrLmsAMnWjwGnUrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegsuhhpthgpgihinhhggihinhesudeifedrtghomhdprhgtphhtthhopegs
    mhifihhllhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvg
    htsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghho
    ohhglhgvrdgtohhm
X-ME-Proxy: <xmx:ZuDWZrVjVDvRlmNa_UYH1nBjgHiIUp7-PP2KofLip6h4AwmcYq-IVg>
    <xmx:Z-DWZmnWojEiNhoRTzgkBUSInOVSi_iEu_GCmRF-bUsIjoRINdqhqw>
    <xmx:Z-DWZgc9qqbkB_9ad-pp3fqC_J-A8OOk_v_7s5LkpDvUs8azfzwf-Q>
    <xmx:Z-DWZoHXYbAleKvS5Ta2ABN50yKShUZuR8uhOSSe1yNKdUmnOJ_wmQ>
    <xmx:Z-DWZtuWWU2vC6fKzZNd_LIFx4A_BLADRYM59MZqnf0U_NnVdN6deIHv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 06:09:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b4a045d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 10:09:33 +0000 (UTC)
Date: Tue, 3 Sep 2024 12:09:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: blanet via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	blanet <bupt_xingxin@163.com>
Subject: Re: [PATCH 0/4] Support server option from configuration
Message-ID: <ZtbgYniS6UKT9i-O@pks.im>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>

On Mon, Sep 02, 2024 at 12:13:52PM +0000, blanet via GitGitGadget wrote:
> Currently, server options for Git protocol v2 can only be specified via the
> command line option "--server-option ", which is inconvenient for users who
> want to specify a list of default options.
> 
> This patch series introduces a new multi-valued configuration,
> fetch.serverOption, to specify default server options. Designed similarly to
> push.pushOption:
> 
>  1. Server options set in lower-priority configuration files (e.g.,
>     /etc/gitconfig or $HOME/.gitconfig) can be overridden or unset in more
>     specific repository configurations using an empty string.
>  2. Command-line specified server options take precedence over those from
>     the configuration.
> 
> All commands involving server options, including git-fetch, git-clone,
> git-ls-remote, and git-pull, have been updated to recognize the new
> configuration.

It would be nice to learn about the context this comes from. In which
scenario does it make sense to specify options by default? What is the
intended usecase? I'm sure that this feature proposal comes from a
specific usecase that you have at your employer, so learning a bit about
it would help to decide whether it makes sense to have or not.

Patrick
