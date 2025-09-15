Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876F23FC2
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938601; cv=none; b=cozB1EMOhFYZZSBDqp2/uKhwZhe8UuTzVuonOfYkeLa05e/901VAxlc6d/ZOIwy3s3evivfpqXEvkYEYFog5sg4OemMcL5w916jpg66voDJZyaA8HgcRUb12riMtuSfXbCj/azHkye3hPTxEjer05Wnu5KiH/VV5Mgw8qjlMmI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938601; c=relaxed/simple;
	bh=F0AeI5q3ELSJUcEWkbw3GiUa8jo8gjz7Bwlg1XXNpnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1te4Jh/WX5pwYe9VMUZUt+xxJuRZWLgShPfSedtPerVfYJZTvvLB0ShjE71ODXxn+PbswuAz7RaJaz2uXRvn6wAtDdjU7xpO9nUeeew5fWjVjj6sT9rZyxt9IopSK4+gPRSFfJHuCLceuTAy8IDDAQNjalnBTi1kQVX7xUbtY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=avOEY29/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kICSqIw/; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="avOEY29/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kICSqIw/"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id AE66DEC0369;
	Mon, 15 Sep 2025 08:16:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 15 Sep 2025 08:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757938598; x=1758024998; bh=oXVh/7dHIA
	n9Eeph/l1UOmaQseKYwjAFfKt9OwL/zdY=; b=avOEY29/1g0HO68EFjhuDje92D
	aJgSZcIOJSXKCleWRz66/3yZ/ueldnWk2J+Njj/XeZHWXusuk3/t3ei3XQ0DXr5K
	kcgiJoIHggz/+pH2UAvodNC+o+Axk7aPKJQImU047/GqZDgMHIZzbvHrYV/azv58
	/KuRZcdTtuWblzjNbM4alF1yFoUgLWXN88qfI5eIDFHDCSutkzW9ZntUIlj5uUoh
	BGNIdEgd/1YSXQqtz3gcad3m6sK0xzeeM0aiaXQR0p7uGCmNvreabQT9+kFVnt92
	HTP9gWVRJQ2CcEvw8HII2POdCsoTtVI+rAINTD+4JnaRSSTZXa65tk0Yo34A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757938598; x=1758024998; bh=oXVh/7dHIAn9Eeph/l1UOmaQseKYwjAFfKt
	9OwL/zdY=; b=kICSqIw/bSSytx5vsSfSzQkZPs4FGxwq7soPtK9rmlQpSD/hsZA
	98Ttf7sZrr0KdY8kHDFoylf1gzacXMW9gT9IWClUdCWwmgiIFfa+qHWSQi3QC6a6
	nEFKUGTF29+/RqIN03JCN8TkDDM8z598emZeWHO55xchkdFeRjg8CTfb4THnaXhk
	xXjdDUEsxP7h6HdkEXSZzh5iuuFtbWouBzND5K4IHCjivYcdj2YtreaMMPH0zk6I
	3rq8P5nmZtSe1f7ZJFmSeHtselFyvW/IT1ifUPu3PIkqUwGhMrXkq2/twVC+gjUy
	x74N3lJdPU0Lm3vTiCyAA1V39/nEbZe16rQ==
X-ME-Sender: <xms:pgPIaHyHBxMRCbeIF-CbuO504NJGsgVc1Feb_kj_s3lSj7BCm1MVUg>
    <xme:pgPIaPcNh4Cr73_q79jwU_SR_SilrF6eYa19vUEkxBzINJYEr8k_e7oY2tc9tyO4y
    URVvzVd3AyeAOd4dg>
X-ME-Received: <xmr:pgPIaDIlm0n2r1CpWM19_cCUS4YUSoWwsj-u41VdjOM5g4tZYQhjZY7p_extndh7D_jil0849FNj6XnwvBlkwdvxAi2NWwIVT4Ej347YK2_XEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pgPIaAFAWEoFRlFOetL94y6VGlArRy-4QSv1k5YC-YIwyft7Nwad8w>
    <xmx:pgPIaNoRmG0CUpSHc4ttcFSgwZPnanJEYAjyYFm5X0vj8g77cincKA>
    <xmx:pgPIaJQoVqap76wjf2oAZ-ItLMdIxHTqEMd59RZCAAbeRcBDVsifDw>
    <xmx:pgPIaKM2Zq0pQAet_I2nev5_KCfTPKmMj5Pm6u3v-enh04KWdkMobA>
    <xmx:pgPIaLjwEmkrc6T9ApyLMK0q0mLqxW7fZ3qpE8EA-ONxvo-1E4hSr5r_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 08:16:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 38403d3b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 12:16:36 +0000 (UTC)
Date: Mon, 15 Sep 2025 14:16:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: The case of `git update-ref MERGE_HEAD`
Message-ID: <aMgDoGFy84EenCHF@pks.im>
References: <c9794ca2-0822-485f-a10f-6ecefa7275d1@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9794ca2-0822-485f-a10f-6ecefa7275d1@kdbg.org>

On Fri, Sep 12, 2025 at 06:19:52PM +0200, Johannes Sixt wrote:
> When I commit a merge, the commit message shows this advice:
> 
> # It looks like you may be committing a merge.
> # If this is not correct, please run
> #       git update-ref -d MERGE_HEAD
> # and try again.
> 
> However, when I follow the advice, I get this error:
> 
> $ git update-ref -d MERGE_HEAD
> error: refusing to update pseudoref 'MERGE_HEAD'
> 
> Also, I found a use case to set MERGE_HEAD to a particular commit, but I
> can't do that, either:
> 
> $ git update-ref MERGE_HEAD e9c115e666fd6a3faaf187f5d145b32861a45cc8
> fatal: update_ref failed for ref 'MERGE_HEAD': refusing to update pseudoref 'MERGE_HEAD'
> 
> I know I can do
> 
> $ echo e9c115e666fd6a3faaf187f5d145b32861a45cc8 > .git/MERGE_HEAD
> 
> in the primary worktree. But I needed to do this in a secondary
> worktree, where this is more like
> 
> $ echo e9c115e666fd6a3faaf187f5d145b32861a45cc8 \
>      > "$(git rev-parse --git-dir)"/MERGE_HEAD
> 
> which is a bit unwieldy...
> 
> 8e4f5c2dc26e ("refs: refuse to write pseudorefs", 2024-05-15) removed
> the ability to wrangle pseudo-refs with `git update-ref`. Much earlier,
> b6d2558c9ea3 ("builtin/commit: suggest update-ref for pseudoref
> removal", 2020-08-21) changed the commit message template with the
> justification:
> 
> > [S]uggest a "update-ref -d" command, which will work regardless of
> > ref storage backend.
> 
> Looks like we couldn't uphold the promise. Any suggestions?

The best we can do is to special-case pseudorefs in relevant code paths.
But we have to be very careful with how exactly we do that. Pseudorefs
aren't real refs, so we for example do not want to add logic to update
them in the same transaction as normal references.

But for something like git-update-ref(1) we may specifically carve out a
way to delete and update a single pseudoref and then handle this outside
of the normal ref transaction logic.

Patrick
