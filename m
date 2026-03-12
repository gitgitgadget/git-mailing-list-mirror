Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4265940DFDC
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303646; cv=none; b=gZGm9uE2BZL0/g4F64kEh+v9VI8Us3y+bWsQ93iJ49mpviYOh2JaX/t+miOlNqaLUoF7MYpE9407XMZmiuoxh1bETHNgCfzS/3fI7LqDnDCbdWci5YnyAOrvnSf0KAN9Y0HTOD75/IWKowo3HWX3TpTpmkGDKB//F8c1J9AJIOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303646; c=relaxed/simple;
	bh=pdfppu5P9RwdxSp4TODDxGqfxcBX3omXq89N84wsreA=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TCoQ/6Hs1iCpMsY/rAXiU3ikhrX6CS/QU1Oy74DLYYR8TN4KfLFVTvj0WY7gKvgba27pLW08kWEzHzxjz1N0KUW/21ma2jjaFVR+jqMe2TVx/8UWUWIFI7M5lw3RR7Fw/+STQ2Jb0v26mtok1CKdfhIPaO1cQzcjBtNevlowmug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=n7aqmoWz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OtTjanS6; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="n7aqmoWz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OtTjanS6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3DE777A0204;
	Thu, 12 Mar 2026 04:20:43 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 04:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773303643;
	 x=1773390043; bh=pdfppu5P9RwdxSp4TODDxGqfxcBX3omXq89N84wsreA=; b=
	n7aqmoWzHYkx+SkciDaN450egVHFPAjbi23MFmc4EJo4iGt+Da4j6W926npPuRY2
	PFGaaAPYrbKVmET0z3MnEYfuLQcyufiPnhl7tK2e2BiWXkHnGYq9cvDHe7u0n8Ey
	mVKztzjClrwH2RNLRK6+Af4OJqLPKKVBJMe44CiIcjpx73th3yk8zH6xcH94XKOz
	+AqdcmmvohE3UulABu2WUUjid0OThXw0JJdU9uTijr9pTbqSztmnOYVbjkBq4sGZ
	GfQVgx/p97Gmy5MY1FrZt0XQLssmLCtEiS8cggYxosl0wI84fhMBBa9OI8R6jzu8
	dwNsNrV62J15DFAsL9Q+iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773303643; x=1773390043; bh=p
	dfppu5P9RwdxSp4TODDxGqfxcBX3omXq89N84wsreA=; b=OtTjanS6PZ3OrdchM
	e5plqV4VNv8kqtuZx8A17xQMNE4/ss5iOkNEdgeLw14p0BuACvicVAWrnPLqCvY2
	N9zmdqL6QiQ8qT6vA8VKzxaS5p0O84UdxABUxWRk4A2M2oOxpjpqlzC9rpFEhyTh
	AUO59TfGhi2SYU94f935R6hhpOzvNCAef8EAA/PZWQCJ78CjfVCSD0XdnZ2gQpUv
	TWqoe0rIpBMvFsqZtLnI+p/mtCeDiyVDb18JwZTRvKFAGDIp6DS5aATxE7kVEVmU
	C9kW97WMMeFHV07rNyd2ZDjJCijtV1Xn/oBDuyEBvwUPF2t106XadRjAgWzFgpdg
	5XZyQ==
X-ME-Sender: <xms:WneyaeAdm5WM5aJrB1lrtrGCFyO83mzQmMEhq5iYOLo-10GrxPKQbdU>
    <xme:WneyaTXM8bUJLAVOMhnT5myyNEi2sWyRr8db-wC5shxhYXeKjaPXAP6D9KWam5YhM
    EBXct2ye3KpvKQgeNPbU0qC8q3EyX28EV0rGp6XyIKxzEpFNakSPyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeivdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeg
    hfffteetleduveehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepgihmohesohguohhordgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WneyaQu9aLfE-h9OkPQSU9jGYZ69yiAiSxGBQPPRE1NUPrQfpv0u9w>
    <xmx:Wneyabaobik0URVQOmZuNJH0atQp1zo2VocxsyQ9mVIr7Xyhhp7YqQ>
    <xmx:WneyaTXXP1Wm_fq3qgyh5CDrnYfktwPrzsxws4t5-khUGYt0wr1blw>
    <xmx:Wneyaf4q_J-7PT5Y0Xh2Wv7d3yuPzbX7Qzyg6fPEiN3nWD2cQLG0AQ>
    <xmx:W3eyaQEfHHVWEp75aH2lfAOzMun38b9Dt7veTK3S_qQg62U9n0ffSbcj>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D4DC51EA006C; Thu, 12 Mar 2026 04:20:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ASmKjzAipejg
Date: Thu, 12 Mar 2026 09:20:21 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Xavier Morel" <xmo@odoo.com>, git@vger.kernel.org
Message-Id: <d8e84ca2-2e86-4cdf-a1db-b6d466677fc3@app.fastmail.com>
In-Reply-To: <5152ce98-b0ce-42f2-bd34-1cc324042f88@odoo.com>
References: <5152ce98-b0ce-42f2-bd34-1cc324042f88@odoo.com>
Subject: Re: git submodule using worktrees?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Mar 12, 2026, at 09:13, Xavier Morel wrote:
> I have a number of fairly large projects I work with, for that reason I
> have a bare clone for each and fork off worktrees as needed in order to
> avoid unnecessary duplication and pulls between them. That works just fine.
>
> However when I tried to use submodules to provide a unified view of some
> of those projects I found out that there's seemingly no way to have
> submodules created as worktrees (off of a shared repository), at least
> not built-in. It seems like the submodules do set up some sort of bare
> repository / worktree situation but do not support passing in an
> existing repository to worktree off of.
>
> `--reference` with `--dissociate` does avoid unnecessary fetches on the
> initial clone, but they do duplicate objects (and without `--dissociate`
> has all the issues of a non-static shared alternate), and do require
> duplicate fetches afterwards to update the submodules, even if the
> central local repository already has everything.
>
> Q1: is there any way to massage the submodules into working off of a
> central shared repository? Poking around and messing with `.git/modules`
> didn't really work out but I may have just not poked the right bit,
> having to set up the submodules by hand (or via a bespoke script) is no
> issue.
>
> Q2: is there any chance submodules will gain more first-class support
> for worktree-ing off of a local repository in the future

Does this also not work if these are regular, not-bare clones?
