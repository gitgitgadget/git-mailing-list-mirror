Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C277E1B9831
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421318; cv=none; b=eKV/SpT/5CS4387gmaXPRav2Q7FMxKABioGt8dDbBvaQBkEAAePSodrNSmnMAnaylUGTU+ND8QNB6fU/AsQvBLyiS/wLZ3aADfb0p2sZXqblchhmx8d2PwkFX1s0TAVoy/JnHBFQSxE+FwcBN+owmdCja4UyRZN0YHIy6yLA8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421318; c=relaxed/simple;
	bh=QGFkQF/bZGE7GzzzieX6kVtBa+jHYouACJsoBal06W4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZRXLF1HJp5lVi4aFz9/tnb8u82UopaHLhdu1fOj1XXGLaT53sjpdaZf372sYb8ZCyqe7qT3tHdsc5kMJdgEO5/thWG7bYi6N56ftEjudcmnCrRG0q8s5jc6AOczEvEeAH7VwPDj/JFajlqw5BTqVXWAgxvK6JEoa+l6F4aIjkuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hozduqe8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1FIS4mfS; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hozduqe8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1FIS4mfS"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E0CA81140127;
	Tue, 17 Dec 2024 02:41:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 17 Dec 2024 02:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734421314; x=1734507714; bh=N+fo90Xxh9
	lzcQ/r0I8IYBHjiQt43gmsu0+XbVgSD7c=; b=Hozduqe8bJ/0DrAdn4VXNCa74F
	rAY6yesuSluuXvTiDP4Jbho9NMcYeXWrgWAEWORBScj120mj3VK4rTmPp4kwgrtP
	Xanv7NGxQ1VHNjDw4uWAusqvh/sfwiEo60xwBEXDEU103sAGQ9tNGOQmr5URVGqG
	m9D8WAGFDEuw20Cu0Hgq78Cp53X0plsfJ4XatzgMuaW4m6p053l8fO1hVK9STNu6
	Gjqgp7nZ48gQZHigH8ayBwwSFEHKCpdYDOPLrIh6O1G4XtYvbFGQirdu9rWj5XSr
	eGsQslrm0ZZH283Ie7LcKqH2tuK3tdICjaJOEZMof0tWwE8zjB8wGPoq0lew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734421314; x=1734507714; bh=N+fo90Xxh9lzcQ/r0I8IYBHjiQt43gmsu0+
	XbVgSD7c=; b=1FIS4mfSOoMzSxy3lJHqrB6nCC3sLSmocz4UcS7uHJdv6yx2OUO
	9hZjoTmiGC8sEvlpym/sO3E4w9w0i10oc69ifXFVGHYM/5NaOKVyhLW2TQQYVdY6
	G/DH36WrtlNx3QGiC7SB3Z9lHbJpUaSN+FUAoW08vPttKBa8AaZUATPrndR4x1Ql
	uGNUFKCSyuUQGTJ2PNlRaFX7W7zGxaAMLguL75EbkggqpCxe1f/w0d2Xo6ghZ/ec
	6v4td8TAnQLxrPqk5xR0V/VAp06pRN9E2QN44QT6Kl1fw1Sq7EH6jSFOOabtXuCn
	47VmXbOVnZnEvJrzP9Zk+M6AZbVPpCEEN6w==
X-ME-Sender: <xms:QithZwWYIeZHxsx3OkZm9664hLDD1TJi4xXEfMMkf4plURnvl6rISA>
    <xme:QithZ0lUdO1bMDNm8AwO1Py3QV3iN3rMzzXGjAhgbmbuWzM6aw4tOu3krFd023Eh-
    wmHalFsdEY7kLIb2g>
X-ME-Received: <xmr:QithZ0bR7ZaFK5e_Ri4mzD03meXGihHICUi6r17hsNOCGZh2c-6k2cVe3qOphv6UrWPj-S6VSbeVGUDa7b2vOyOBehMm_3ZdMyCv0yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehshhhusghhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:QithZ_VqstJMZdWIrujhOyOb8wbzl_bA3QkwdR8DyjdmQPiFkGkl7A>
    <xmx:QithZ6lsL04UegChYh2gGi4smAw7aTkX_6kiDZgFIlpg7I0fUsvzRw>
    <xmx:QithZ0e2gyAmFx8lOm0KugAE72kr_XWfwD-jTMIy6sc7P739Ye9VeA>
    <xmx:QithZ8H36Tum1G6tGmFR7dzTgu-y5arg4nf_ud-SFCuI__Ph6pQwnQ>
    <xmx:QithZxv6PEJ4_nyXMMXCmfHA9mX-NlL_poDo2Dk3o1tHLpKiHZXLUqaU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 02:41:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>,  git@vger.kernel.org,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: Consider adding pruning of refs to git maintenance
In-Reply-To: <Z2Emh42DJkHFGWq7@pks.im> (Patrick Steinhardt's message of "Tue,
	17 Dec 2024 08:21:54 +0100")
References: <CAG=Um+0v=BmmYjvBAXs4r4My6zYvpJvcE+0U6SAnxKUcd1-A4w@mail.gmail.com>
	<Z2Emh42DJkHFGWq7@pks.im>
Date: Mon, 16 Dec 2024 23:41:52 -0800
Message-ID: <xmqqcyhq3ge7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> If we want to have such a feature I'd thus claim that it would be most
> sensible to make it opt-in rather than opt-out. I wouldn't want to be
> surprised by remote refs vanishing after going to bed, but may be okay
> with it when I explicitly ask for it.
>
> At that point one has to raise the question whether it is still all that
> useful compared to running `git remote prune` manually every now and
> then. Mostly because explicitly configuring maintenance is probably
> something that only power users would do, and those power users would
> likely know to prune manually.

I am 100% in agreement with your reasoning.  If this thing is to
exist, it has to be opt-in.  We also need to add ample warning why
doing this asynchronously behind user's back while the user could be
working in the same repository is prone to cause surprises in the
documentation in big red letters.

I however am OK with the idea of having it as an optional "task"
that is disabled by default in "git maintenance".  "git maintenance"
can be viewed as a platform-neutral way to set up scheduled tasks.

A user may be a Git expert who knows what `git remote prune` does,
and understands and accepts the risk of confusion doing so without
explicit "do it now" from the end-user, but may not be a Linux or a
macOS or a Windows expert to know how to write crontab or its
equivalents on various schemes to define scheduled tasks.

Thanks.
