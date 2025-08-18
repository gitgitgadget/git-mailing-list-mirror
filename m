Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1721C3314B6
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542067; cv=none; b=V+E7+hTuOzyLfXH8/97WX3o3tdX8z7plsay/EdUaP7iYsPfOGPqTkEkvyj8bpAc3UgrOh7KwCtuWZwErTbsizmetYERLT7GzUWNKH6FGZGPOpHy0wSKfzRMx4coWUS4HqJqWJf4RXF8pUSIRvxL3GqeNqTYHbNqq7XGGsDwa0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542067; c=relaxed/simple;
	bh=f1Qtn/zrhuWzEVv1+KIF4+Q25kd18ZnOztBtQ+x1a6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CfrDtiWdQcYKv7H9BMkTgI7R5T83Agn4zytM6eT+vFHghNcJ3tT0DmgRQX/m3JdQKsc6J8XHugO9WzzYPwGBJi9p7/bP46DTqG6fu9zN4v/3HU0ny4NoXoatWFNu0r7E8A+jmYgW8Tn7hZJnFYPNfqs/QngzbEfQ6hEcZNrQhD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Skk3x4Qv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SdcuD3uu; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Skk3x4Qv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SdcuD3uu"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 23C6E1D0006F;
	Mon, 18 Aug 2025 14:34:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 18 Aug 2025 14:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755542062; x=1755628462; bh=f1Qtn/zrhu
	WzEVv1+KIF4+Q25kd18ZnOztBtQ+x1a6c=; b=Skk3x4QvIzs+ZqsboYIBMG+iWc
	rODRKfy2RasskybCKd6HHa/kMgWAA9QaEYx3NyFHkn/cY0tStPspmsKmVFfrz+17
	NTByWu1bCPcjQOZGS6bIGz4t92F91/kZmSpSmQZu6nozUXooVzKBBmPhB921aN/O
	cjGzdsyI3gJX5dCavia8Tafug1xUjJ8DC0vmQhb9j42RbuesjVI9Ea5+wf6RiDkU
	uHJyWkTB/Pa/Vuhn4Rc17Lr74vmlSDcND8kmLPuHM0q4hgwD41M8V0YhfvPVa8bn
	u8Y3nLP31+t9H5rkm+eRCQeOwjXrchlYIE4kqLM4FX6Qi8WHfOtbGxyMP2gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755542062; x=1755628462; bh=f1Qtn/zrhuWzEVv1+KIF4+Q25kd18ZnOztB
	tQ+x1a6c=; b=SdcuD3uuKBLGc8Cddun8F8x5xpMk45oxE2trzNs47+CoUnLQKAm
	5mBs81fxyrGhQteEjpBUj3sBNce9Q3EU4elchz1y/Y4OlGugZKVLa66QvGMuTUJU
	kw4Scin7X3cwkOwmgEYYfgKreqlJpcogqgKh53Zw+lNpxYmgAEiRx84wr9mJ5egk
	jcSq+RvTw5JcV70o6Q7IhfMFEcYL6jTesf4hL9rWcGYTY+X5WQ6XjGxqsoiurA8/
	1aEzLXJ4eUMDOK0FP7LV2AtiRcaUphccmPtnhFMUwnlWD1yEeL5Z72Hx7Plg6R9I
	Sh8pKZ/KiA47ot6WJFg3gxLBnzOt6S/XhWA==
X-ME-Sender: <xms:LnKjaGP8202xjDAaRSxI1pFwa86NmWN_92dbAN1QQTQfjF53JnlSEA>
    <xme:LnKjaINwLYWZzNDnD6Kq7qpKbo7f8yjFHEVsSzuzN1FjDjekuOudZ6-7ES_6S4BEU
    dfdribpt_E2oOPCGw>
X-ME-Received: <xmr:LnKjaGsd_cL4I29sOMc-PQ6r_C8zG-Gw2gddxohcXObAq3E8sAWlCN2C_vUm-AM8uNCsEDdrf-tCzQEAJ-jPg0giRBvLOQC4CratmWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeffeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhguihgviidqvddttdeisehrugdutddruggvpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LnKjaCUkOcG4wz8RtanMtGKYwM6F2wN8T767MO737fTG4tqzO5eDiQ>
    <xmx:LnKjaOsiew7gvJWncfIpSDQ8tjqG4nw0BCqFzCKZQTUuFKReSEfbKw>
    <xmx:LnKjaOUJRDRIxJC9x2d4DkHq1t_v3MwkFcfrrZh4ihdROUPA1jOOKA>
    <xmx:LnKjaBm1Jno9mGTKamSbo3aZgi9mL_8fOgQeO6R3S1noE8D1mxXB1g>
    <xmx:LnKjaEPuhfmsTUH2YGgB8ve5f_YxN_FYTeQwPn6Kdf0kcym-RoSCQz53>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 14:34:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "R. Diez" <rdiez-2006@rd10.de>
Cc: git@vger.kernel.org
Subject: Re: Graphical tool to merge and reorder commits
In-Reply-To: <4398af77-3183-4ac5-9a25-aca6289d8c8f@rd10.de> (R. Diez's message
	of "Sun, 17 Aug 2025 23:02:53 +0200")
References: <4398af77-3183-4ac5-9a25-aca6289d8c8f@rd10.de>
Date: Mon, 18 Aug 2025 11:34:21 -0700
Message-ID: <xmqqplcsiimq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"R. Diez" <rdiez-2006@rd10.de> writes:

> Is there some graphical tool to merge and reorder commits with the
> mouse? Or failing that, a good terminal interface with menus and
> the like which allows merging and reordering in an easy, visual
> fashion.
> ...
> I have tried or investigated numerous Git tools: git-gui, gitk,
> Gittyup, GitUI, GitButler, SourceGit, git-cola, Guitar, gitg, tig,
> giggle, qgit, RabbitVCS, Magit, lazygit, ... They are all fine for
> normal commits and the like. However, most fall short fairly
> quickly. For example, the ability to highlight character or
> word-based changes inside a text line is rare. And none of them
> really appealed to me when merging, let alone rearrange commits
> visually.

It would be a fun little project to write a GUI front-end that emits
"rebase -i" todo file and drives the interaction, if there is none
already (which your research seems to indicate).

Sounds like you found a good starter project for the next GSoC or
Outreachy students, I guess ;-)

