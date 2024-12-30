Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EDE8F4A
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735543674; cv=none; b=J3Fdy6TnUv5WlcPtB2aVJVXmGCSewG4K8njIq4vx+zIxSxoB1n5iPiHvrEUn4ZRYUrAi2nh6g6mJRXG9nmWJpn/bEUZ9AsNBLzEfZC49pQVrVKcxu00/9RbfJysewQShX0F5vO85a63IyX7Mk3FMclYYEGfGrwcDVtZpHdK14FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735543674; c=relaxed/simple;
	bh=OvxrCikcpBpYQPd0szmKuXc/7q0I16rqFMq+Gbkwr7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhPlOisH7LKrAP69F5uezT8DxpUxmjiBky1bzUoOJh7g6M1jIsQO1NfTZeTxHmDq3xKF79vu+wZcXKWiwvLJFYZq8wA22EzmvXeveiCgu1z/HW3xWv5L0GwVA1GxB0d7MRd1ZdEk6osOnLFPUlEQQtCSCF3LM32SSyeIBYx3qG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i3aP7ETG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K8Vvn2s/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i3aP7ETG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K8Vvn2s/"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D59A114017A;
	Mon, 30 Dec 2024 02:27:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 30 Dec 2024 02:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735543672; x=1735630072; bh=OWKDFnN/uz
	972vyOIDbWEYhhNsebSRXm01IJQPoKqhY=; b=i3aP7ETG7mo/8Lz8v1WdiwMBIg
	v8t1aoCDI7rkvH1dhaPo53uMvN9P4Ieh1uZYn+OD98dKlcdU+djYn8ayCNLoXPo0
	ZSy3VcUFWthji9eg7AgOe5bFNx6PkBoeEjGEWEfxCaSHE5rxfKC2akg4WXPvkHXl
	hi5JQ8rT9OkRRx0+7VY7B7Y9xNdDi6q+DqALh07g8/AGhTcouO3SegFi4NvsZ3mf
	LP5OlnRtIBEZ+WQQGSFvY21cRZUsT8xhPBDqkMfJHYACMI95GMnnmGo0GW5krOnU
	vHBpi19Q0JfuL2UDPNM6kk1EsDic1EK9F3AFOiqvG7nYyISznFUthVXRAysQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735543672; x=1735630072; bh=OWKDFnN/uz972vyOIDbWEYhhNsebSRXm01I
	JQPoKqhY=; b=K8Vvn2s/6yVakBKQmuBhAhtPqNsbOtQSMOA7U1QoC+ZTgCPDiAs
	IvN2kF2WBuRK9kJELgCaT+yaHipQ82zoCsze+Pn/aGXF3FbkIZoEAZbtILCKRghR
	Hb4AzksjRanyuy+I/lFA3uMAbRLYeMpAwmAHfbyU+yJs2gqd5cbHIoemYP6a3+t9
	LkkjotqqW9FYzlU54Rl7Ox99aYwYeXt07MwhNU+ULYbWgpwbjDSajmyFNDfUk0SG
	YkJEZE6GupmrmDf6CFoADzZf/7sbaqYwJ9M3N0qGf1TjAseOvLzymSe/Hv1dxykj
	ce/WJEHnJnZP4Z9HXgqSS7wlGrlriMJkVTA==
X-ME-Sender: <xms:d0tyZ7dNhqxudQxafxkF0cGC0Wov33Y06zRAnuLv2wLmd0Vd2Jzq9Q>
    <xme:d0tyZxOdq72sL3KcjrawbF2G5gqXOLTJ-zfAaThhd2mpYEcq6bEYyY5jkfkYEQsFv
    WPuekB-ZVnWZHGyvg>
X-ME-Received: <xmr:d0tyZ0hLFTA4dK31S_2lb3Bvh0CbipZIt3DybmD3uKCR6PPujLR3LiQBx3pq_6eSWx3FGHYpbqJpBDwhELHfI6Y36bRL1xzVVzum5jtpIC1Su8dv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvhedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtff
    homhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffgeeuieekgfdugefgvefgjedtveduvdduffeigeff
    vdevteelffegjeduudeitdenucffohhmrghinhepfihorhguphhrvghsshdrtghomhdphi
    gvthdrshhknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:d0tyZ88p97VpTdyK1yvpNMFxdK52Swffa-Nuf5am6vSY617YqZZBrQ>
    <xmx:d0tyZ3uL5NInRZ2CBZBpjX-1Lp127Xb7DlZkar5-pVI1J1RWg4yAOw>
    <xmx:d0tyZ7GB6uD-d2X61Zo03_UTARxRxw_oX5ziEQfKrHy88Pectby1PQ>
    <xmx:d0tyZ-PPJ_R2YNffzvSjPNegYOGfmHbgE4OUNipqXXYebrZbqBhlNQ>
    <xmx:eEtyZw5tqWzxSiGIvnoo5FpK_daNXFrHJFcWHKDILnhrH6RVGmc-MYQH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 02:27:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f8e031f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 07:27:49 +0000 (UTC)
Date: Mon, 30 Dec 2024 08:27:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2024, #10; Sat, 28)
Message-ID: <Z3JLdIG4C9D2-1ZT@pks.im>
References: <xmqq34i730qr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34i730qr.fsf@gitster.g>

On Sat, Dec 28, 2024 at 02:23:56PM -0800, Junio C Hamano wrote:
> * ps/more-sign-compare (2024-12-27) 10 commits
>  - sign-compare: avoid comparing ptrdiff with an int/unsigned
>  - commit-reach: use `size_t` to track indices when computing merge bases
>  - shallow: fix -Wsign-compare warnings
>  - builtin/log: fix remaining -Wsign-compare warnings
>  - builtin/log: use `size_t` to track indices
>  - commit-reach: use `size_t` to track indices in `get_reachable_subset()`
>  - commit-reach: use `size_t` to track indices in `remove_redundant()`
>  - commit-reach: fix type of `min_commit_date`
>  - commit-reach: fix index used to loop through unsigned integer
>  - prio-queue: fix type of `insertion_ctr`
> 
>  More -Wsign-compare fixes.
> 
>  Expecting a reroll?
>  cf. <Z2-2dbYVuuLxpNmK@pks.im>
>  cf. https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/
>  source: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>

There wasn't anything yet that needs addressing, unless I have missed
something. Peff acked a couple of patches, and the questions from Jialuo
have been addressed. So no rerolled is planney (yet).

> * sk/maintenance-remote-prune (2024-12-28) 1 commit
>  - maintenance: add prune-remote-refs task
> 
>  A new periodic maintenance task to run "git remote prune" has been
>  introduced.
> 
>  Will merge to 'next'?
>  source: <pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com>

I've had another look at this series just now.

> --------------------------------------------------
> [Cooking]
> 
> * rs/reftable-realloc-errors (2024-12-28) 4 commits
>  - t-reftable-merged: handle realloc errors
>  - reftable: handle realloc error in parse_names()
>  - reftable: fix allocation count on realloc error
>  - reftable: avoid leaks on realloc error
> 
>  The custom allocator code in the reftable library did not handle
>  failing realloc() very well, which has been addressed.
> 
>  Will merge to 'next'?
>  source: <f4677194-0a3a-4f07-b003-c0295b51c100@web.de>

I'm not a 100% happy with the split for reallocators that this series
introduces, but don't think that the series is to blame because it
simply fixes the underlying problem. So this is a good first iteration
and we can improve the status quo in a follow-up.

So yes, I think this can be merged.

Patrick
