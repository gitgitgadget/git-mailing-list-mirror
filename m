Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947BE231CA9
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728292589; cv=none; b=nTyf22NljhZgHFC3pNKfa+hYAhUhU8/2/r/Nxm03S7EiYddNhYn3ukQUNJzMrNbk1AGjmax6qCOTJhJ5PX5EB0lLiD0deqZb8rj/m42ffk8qf78TaSr5k+QkctI5a2j61c0WGh69Av4VAHV2dXUzsd4CTrCyM54TMz8KcGemR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728292589; c=relaxed/simple;
	bh=6CcN5a9oQuZFHI/oHO+aUsvvll0WmFAxYcerbEzIxrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipKfOz/+hdqmTqDV3SKU5NjWDIPxpknN4Plvrgw0ptIcQIBIKACb7cbtqPgqxjMJMDk7p7p3dvWo0DgJse1xlWzzUyWfIxUKYDvZwf6aVkrnj0wQAFZwN6dUZTprelOgZ812q0MVKGx/qqWivI398qXq4f78u/wqU9x0ykKVO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XkoJ+6ad; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y3dyfUmv; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XkoJ+6ad";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y3dyfUmv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A22C11400E3;
	Mon,  7 Oct 2024 05:16:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 07 Oct 2024 05:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728292585; x=1728378985; bh=+uB1JH66Lp
	fI0M13LYUS9PnuGEhk5p3wUdJtjbp72rk=; b=XkoJ+6adLO1SgTs7fHQGthomQD
	picdBEVKEVNRAqH7XOJqEfZbcTEilPA5e/EtivSDPaSmi2wwqnbP0TvZht9xH06P
	rI4Vxk5PiX0vHPOUifV/2GvLJAGVV3zCYKwD09wyC79eJCDnopIdYZwAJ3Vcvufu
	9sSuoKHuL1jq9VCtgYnwa3uQ8YYmNX7Vkst7jrNJ/4HLpjCblTD0HZpXZ6QSWCES
	WKyON1Q16GY7zxYH6KFRmd0In3wI2wPHbvk3Ptt7fmFCpst/lfCWXngeg9GlbKLS
	jY87oxxSwBY9X5iRXl4kEXAuPjp2BB0IsG6FhiTkkZeKwY3JIriq1Yj0tneQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728292585; x=1728378985; bh=+uB1JH66LpfI0M13LYUS9PnuGEhk
	5p3wUdJtjbp72rk=; b=Y3dyfUmv/va53R14CrWOWaSwtIS7KcXBt6Q2c5iCSnno
	Aa77RIcic3Nio46Qg+Cjy8WeLQ8qUQS6tnb2NlNESxkU0bbfzp1IjTZs9+gDk+1O
	sapRUTpdJ9S0pc6VwsU5eEgM4BetDTiQDLk/T5nOJHtPPV/MmfcBCyqCuXd4GX+7
	PmI0lPBoPU/Vk8vkt1TJkbP/pHuVVtfxgFCg+f+Kk3LJ815mKDuht7P/ezlm5Rtg
	OtxLb6XrA7wQ51X8rZ0VLVWuxJJj4HaBjf/wp8ErYqi3yrVHYpzd2f4KFbVJPGaM
	PEFlDkypDcgzCMUVxBLHD7ZrYQExRbkAeN18NV02tg==
X-ME-Sender: <xms:6aYDZ2LH3mERAyNdTxX2YrPsNU03GNSAgtW_N4XiKWWI6wEOCkhQIQ>
    <xme:6aYDZ-IMS-VW4GyiFJrUFBenXgh5RiUhwZi32bRWLrVep1QJiwyTgTWHPrjntcMtw
    d4WtMw8iG7UdJFT2Q>
X-ME-Received: <xmr:6aYDZ2vgP-Lc8JrE40jFYW1FNYGWry4CWxQYdZSF98H_Rylz7GjEZd2AoIon4GQEEBhrEKWOFjDXVRCsu2EUAQL4VQ9iZHaHheDk3w24USKcNFlf_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6aYDZ7YbWqoAAI5JzMn9JrwdTtVkBkK0t9jFs82nHclhH2syStTKtw>
    <xmx:6aYDZ9YUTxnuyEFzQW0dzKVw3yQbCyc7O05pdDM5eVOfo5zBa_748Q>
    <xmx:6aYDZ3C_kh3LvN2qlayR1p_VXFA58WJjYquct9YzvdoRAJbcihbAgg>
    <xmx:6aYDZza0V33lTQiX_e42_3-f9nKTJFNQGKa-ea63f-u9bCqeobgYwA>
    <xmx:6aYDZ8VT-4tb7HyvlCfb1UcilfQBI7oqfB4c7Smp707_QKwJJ1m7RGmV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 05:16:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7e214b9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 09:15:24 +0000 (UTC)
Date: Mon, 7 Oct 2024 11:16:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/9] builtin/refs: support multiple worktrees check
 for refs.
Message-ID: <ZwOm43a2ZmpvnlWc@pks.im>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-jkFE9NN30uDl@ArchLinux>
 <ZwOBwxiSZpxJlsfT@pks.im>
 <ZwOe7YVWmhshRhI9@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwOe7YVWmhshRhI9@ArchLinux>

On Mon, Oct 07, 2024 at 04:42:21PM +0800, shejialuo wrote:
> On Mon, Oct 07, 2024 at 08:58:30AM +0200, Patrick Steinhardt wrote:
> > On Sun, Sep 29, 2024 at 03:15:26PM +0800, shejialuo wrote:
> > > We have already set up the infrastructure to check the consistency for
> > > refs, but we do not support multiple worktrees. As we decide to add more
> > > checks for ref content, we need to set up support for multiple
> > > worktrees. Use "get_worktrees" and "get_worktree_ref_store" to check
> > > refs under the worktrees.
> > 
> > Makes sense.
> > 
> > > Because we should only check once for "packed-refs", let's call the fsck
> > > function for packed-backend when in the main worktree. In order to know
> > > which directory we check, we should default print this information
> > > instead of specifying "--verbose".
> > 
> > This change should likely be evicted into its own commit with a bit more
> > explanation.
> > 
> > > It's not suitable to print these information to the stderr. So, change
> > > to stdout.
> > 
> > This one, too. Why exactly is in not suitable to print to stderr?
> > 
> 
> I am sorry for the confusion. We should not print which directory we
> check here into stderr. Because I think this will make test script
> contain many unrelated info when using "git refs verify 2>err".
> 
> The reason here is when checking the consistency of refs in multiple
> worktrees. The ref name could be repeat. For example, worktree A
> has its own ref called "test" under ".git/worktrees/A/refs/worktree/test"
> and worktree B has its own ref still called "test" under
> ".git/worktrees/B/refs/worktree/test".
> 
> However, the refname would be printed to "refs/worktree/test". It will
> make the user confused which "refs/worktree/test" is checked. So, we
> should print this information like:
> 
>     Checking references consistency in .git
>     ...
>     checking references consistency in .git/worktrees/A
>     ...
>     checking references consistency in .git/worktrees/B
> 
> However, when writing this, I feel a ".git" is a bad usage. It will make
> the user think it will check everything here. This should be improved in
> the next version.

But wouldn't it be the better solution if we printed the fully-qualified
reference name "worktrees/worktree/refs/worktree/test" instead? That
would remove the need to say which directory we're currently verifying
in the first place.

Patrick
