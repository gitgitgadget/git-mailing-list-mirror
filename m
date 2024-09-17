Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67B1BF24
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568351; cv=none; b=R6uv+cwNfaxFZFQ3gyTTuVSJP3krcf5NV2r+NOG1QaiCeAzyL8nrK8xLerLnfciZ7zfavj0H789zjVASb5pQfxEwlh+CVI7wzjxeDIyaNk0zGYAyVuy72G+THGnC5lUgMzup38EB4OlUCh+bZ3RolngljLzzSf2bdpd+o28Ge3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568351; c=relaxed/simple;
	bh=+KBT5RxnLFST4yo4u3ghA4nsLH0xU1ZbNJYkcjXJ5eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj7FPfFDbN0Xz0m5+UxDqeFkEY19ftdzFYbjUmBb0sIrNeqrE1nrQ8q+eziluW8i21vI8lpJn7paUynOrP8BcN3rQY/87PwVOYU0HL1644wsTdNyn9eeJudhWTSt6BsPHmVWne3/q8u5pnMizE6nzTmS/V1djhNlwceqW85HBI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VPFGfZDA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z6VqoeXF; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VPFGfZDA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z6VqoeXF"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93444114031F;
	Tue, 17 Sep 2024 06:19:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 17 Sep 2024 06:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726568348; x=1726654748; bh=JTYRRfaVd7
	6vABSsnMRHUoCZNTRh6n6SykbkMhKfahM=; b=VPFGfZDAOdcQ/So95gQEtsWr8F
	cChx1YuaEtStEFbmzayxgRNLWaOPGP+nvs/O5DmgdrX+qpGuFWhDPukNu+fVkv8n
	SaEi0zH6aOP6GfvV4CXPlpTzfR6anC4JTz7mWOlXXwq/6GoxJVxCfdjQ2mbfdfW2
	aby93a7ujJ2AjoMxOAPC4eRLieyh5cx0U+uFLJcBBsrnv0IFzblf8Db8ZCPrBTjz
	gq1x8wYnq5C77SZ8v2chKHtFsAjmNvkv1e5m6HEAMfVcrO8R4TEZyLLR0ZbGlJWp
	1YZvTl7M6YQZR1PhZo5eRc/5RxSAppbTjnrG8vnwT5EWzhOskVYXzkdszT+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726568348; x=1726654748; bh=JTYRRfaVd76vABSsnMRHUoCZNTRh
	6n6SykbkMhKfahM=; b=Z6VqoeXFygy1I5l2dWB/Y8t7cKpafk2cAmspxe8F0+de
	jNaTrbD9QxPj8DIgmvx/FquMcpI6NJmTETd9eLWxVhJbigotLexmu5M+AZm3s35/
	LyiM/s0b7vQNp3rW04EJT130ECTBTk8PbK5bMLun7nLaIzi32TxQb/2isyCbpTe+
	YjiIo4e9HDyI68OrQKGMgFzz4Y4v2bNiiaIQMfMuS5tJqD1rRpRUyTHNYeSTq6tT
	Z045fxpGxGCBqOfA16/RYWdlfxQGJA6vd1piJ6IfzKRgbrWFpnb8ev120UqgO8Q6
	cj5t1rBrk/+p4Lwtc4KsrsoUNXTqGjULknpFtuR6JA==
X-ME-Sender: <xms:nFfpZt6UFaPKVu-kYPCkgnUWb-oHjUutXr7SGueYN5UfWuB69RYusA>
    <xme:nFfpZq7yjdxB9PFzgoGvv3Y7b-TCEpiu332tY1AWX0ajED2duSnv7t5er4tBUMgDG
    5bsWwQ0hl0-huDVqg>
X-ME-Received: <xmr:nFfpZkcAQQQ0VcOBjiB6uC2gRhn0chJD-gSfTFyjytuxN5wJEXW6fCPdnLiGB4Gh7A9KcS4ao_ScRqd9QOnYzHwNNecQaZdQ68hYXJRrAvaj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudelueel
    gfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:nFfpZmJURE5N4_9s7F_buUjBtwNsIUaH276ZiraBDAbaT3brZXWumg>
    <xmx:nFfpZhK-g7nR1c5NwEpe669LVTw-MrSMP_TAJRXk6dfUO_TDtxXIxQ>
    <xmx:nFfpZvy1Wq9CxRljJ9ZDhA_vey8fUETPKwVwULh0xV-4cdb0FFtFAQ>
    <xmx:nFfpZtJ1DeiFAoUCWFkM-Yj6nGkmTidgRHCNEq1DInjwjDg2XDsm-A>
    <xmx:nFfpZoW7bSDpzsrhLvy7mBzfqrSEVAwT2-JKuMfHSR8ACGnSNulqfjzw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 06:19:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id afd1f893 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 10:18:47 +0000 (UTC)
Date: Tue, 17 Sep 2024 12:19:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/23] builtin/submodule--helper: fix leaking remote ref
 on errors
Message-ID: <ZulXjXSozNrXgMUM@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <d088703d317a8598e1cc4eb068234c105cdeffe6.1726484308.git.ps@pks.im>
 <l5aljv4zlvkfpjsizofsypgfaxdzkihwghd3voxin5oxibuixz@fesroo5tihzi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l5aljv4zlvkfpjsizofsypgfaxdzkihwghd3voxin5oxibuixz@fesroo5tihzi>

On Mon, Sep 16, 2024 at 01:51:21PM -0500, Justin Tobler wrote:
> On 24/09/16 01:45PM, Patrick Steinhardt wrote:
> > When `update_submodule()` fails we return with `die_message()`.
> > Curiously enough, this causes a memory leak because we use the
> > `run_process_parallel()` interfaces here, which swap out the die
> > routine.
> 
> Naive question, is `update_submodule()` itself being run in parallel
> here? Is that why the die routine gets swapped out so a child process
> dying is handled differently? Also is it correct to say leaks are not
> considered when we "die" normally? 

Hm. Revisiting this patch: my analysis was wrong. It's not the parallel
subsystem that swaps out `die()`, but it's the fact that we call
`die_message()`, which actually doesn't die. It really only prints the
message you would see when we call `die()`, nothing more.

I'll amend the commit message and send out the amended version once
there is more feedback to address.

Patrick
