Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E72E4F55A6
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923964; cv=none; b=sN45pko6+kYkKz+Mhfi+QhSHeOkE1Z7FrP/r2j2kGsfDARcQWMovX/twnDOIhUacUXpbr3CasRptVeZd/geGJqOCk7SivXB3Wz+uMurkRrDz3e+/TikCB49z99ThyKbxcqMuNKTE9gcnkLuBx2hJ/yLU9R1wmaI4ezEsElDoz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923964; c=relaxed/simple;
	bh=PMIq5THuyw3JjaD8wjdvKpLb8fhHyQVmwqdL/HjUQyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D2cRVE//1s8so5JaLZRbErIDiFYUayzO6PnCxw23l1RefAfsbwW5lZxvKKUYiDs6vUT4ubfleASXxrnKfFUBSExxMndHizDupcjFdPBQ4TRHnd0S84GiZUIRiFM6xMLiYynnxQBW0uvmJkojkWudEJt55xiTrJczR8pMZHBt8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I/q8zOKe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GsRvgm3Q; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I/q8zOKe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GsRvgm3Q"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E06A67A0273
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 16:39:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 16:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791923962; x=1792010362; bh=B1hW98Iasw
	fMzFWmahtAGleDDXpnlYZ2A2pHNW7vGBY=; b=I/q8zOKe/38APNQozD0wTL/MDI
	gcPjK7IJ56bBkyxmwPwnsbGbfKSmjYPu45d19c9xE0zao7bLMGGrEF60A1hg2SzF
	CblKYlwAIFyDdbB4yWjzpqbSwITQ7u1A1MXfEz2FO6eCmwNc6bSVRLDids3Wujl5
	K9dZVLOKu8kurWTLbUq8cHw9BLpEUbLKm1i2Mu+G2YCaDdid+Z1Tj+vajS+ahQG0
	xvWSdjMDheQPgDr2MCdGLi/Qq/xfshSZCtxUJ6cejzOLBQzYIesDqq5924Awwo1x
	UBivUoS+qKm6QXXkzVNIwz8n8teEvdSm2uQYXXKSpvxmToKF6ztWMzO5OUiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791923962; x=1792010362; bh=B1hW98IaswfMzFWmahtAGleDDXpnlYZ2A2p
	HNW7vGBY=; b=GsRvgm3QUsOY9gfR/IYmW+95zGHkJctUAyj6OHoro1RqDDUU7wD
	MVa+zDzA2I+j0S5JbiiuUaloNueiRaeRk82iEkz83vrJGzconWrp+Bt+tB19Nfe1
	pBryAc8bhHQjd28TvDJ8w86JDR0MyCJDiW2qHnXUoku1rn/5a3Xc9dtw9Tj8etJp
	axz14rg7sSD0H/OryiUD99fzVChXHjydz7d4xucdW4usxS8myi65/AXLSJTPsEke
	w8ZT/dPN4sJMZ7HzxiVFqXU4bjczsZ8fk0gwqReEhap/d6h+rYVWknNMl3J0EBdS
	Zg0VOlsoJ7DDzhrqWHHP3GhXcE6X8M/btog==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791923962; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:afGnd7DpMgTMgLGAip0TszpzmTDkGNl5Sx68QWWTRemMdQa
	H2YhVhOmP6FXThmqHse5rsT3RcdrzgOsfYOwUYqNvJLmtGWKzC+fg4mZXmnnH2GU
	JbLqyg7ndCSTCjI/hauLwKT+vYVdK3o0Nt6nI5+4zmPiNlcSmEWutPRN1hGZG+ed
	yAjq5Fl5z3ksSb8/mIZ2hBKwIFKqbCFCv+dEtpZCOiNfhf7myJbs2HyMzhyQbgjm
	SR+iMX5LVJd5NGQTdz/dXwvBOkZ6PdkjeaMbcEqgjvdnyovT7yoWKFZFiySK98FA
	ip13PKEMssohENxxrVjLr31PA8UR4PQGrQzqOvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lfX7uZcbI08LsAAEtIwJehP9yd3stHE9HqzIc9jhplA=:PMIq5THuyw3JjaD8wjdvKpLb8fhHyQVmwqdL/HjUQyI=;
X-ME-Sender: <xms:-pbOaj3N5-ibjwtZDlbMrVWnsNfmYg3zX87kcuWRkKVGiOLjoCWAYA>
    <xme:-pbOanDm35T1929BXsNKKgkbtzUdTcy5v98PAAYbEt4ngQKGhqnUd1dYy-0_cwaOP
    uAFxAFTxtTzVI3KBxDr89DR9cG0s0o51ooiwGsWm6TDYCQbWVBZOvg>
X-ME-Received: <xmr:-pbOaoLtHZ1Ma8hLFqbAajTogh6i7gW3rYrIuEaJEwq7ykXkT7sWUVQxq9dAZVRB5knX5uduOh-JLHZ74UIZ1LceB2wNefpOzCUl>
X-ME-Proxy-Cause: dmFkZTFWAljA4GlJa+nkIZKNlhN72Q8oCshyCY8o1wcy4ZmsZtv74+vrm5GbgmKmdW3j8c
    1b/d8/q2+TgWcnFDNGpoXGAKbXQLmgA5yC8gHh8Kc0zxAsFvSl7abOgnCWebyw88ianmCj
    tVuEIOC5ngA7YRiA+CaXbNewCsyeag+zUVTL2saRGP7tnjXF5zO4JWzl0+oKwVmAiaPlSu
    oATxD0SIj0IG6Cyo8WXri8FlLVHRmVfhDhgKkQTPso6aPxV+yCmmTaKVVh5h0Vtkm4kBSr
    Lu6A3XqcodJZ686lMmGeqIQ/+YKDcfQjPeg8uOOHFINX2a0YOkJNsIoKhtqLLOasVfRujK
    rw+b6X+c9pIgSI7K3GtuXI7y2ioI2TCrQupjPzLlFImqJTSplw1sVC9Vnvx6FgJgAI1Lfh
    lIqORQA78ISVTCiphApC8QZQsfuiEJjk/LK85KBjQLNK9HEyIHBlYkH1TywP7QdNBqCaIy
    htkGHZ8evZYJGHwm48kmrYktihM8PC8rzNMbuw1uYf71YgK1/tQ8GboqyJ4XH4nw5aGk98
    6+Knm8fyUDsVjCNg7VIDdD1s05srlqQ/2JmKonGI4CoMuaKZCL/V18DwXzVHuptK3KMk9e
    p88vah2LWH2CvP8smeg0xrFeOU9zVUt55iKpaF6iSLzVXUuPNSWpzLWswzQA
X-ME-Proxy: <xmx:-pbOaomimormRmk1_gWieykn8etgMjuryCIFRSEnB1-uAhPCmrAO1Q>
    <xmx:-pbOapZGMV9DyHhaapwk3kx_-rQgF-C4nvWPGT9GYe6EaiHapWkVog>
    <xmx:-pbOas-4eWuXfQJhvyd28VSZI2z8Cvpc9TE7AsS6TLABU2YzsAyh6Q>
    <xmx:-pbOagbjV3Mbajv6RMhsINfiSwu3AJBqR2NIzKiagQk_uUgcHqxSWQ>
    <xmx:-pbOarcr4hloDiNkt7ByD8RjIBEYBLhKA0DDX6eKO4s8epy7C--Vy0sS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 16:39:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ravi Mistry <rmistry@google.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,  Ravi
 Mistry via GitGitGadget <gitgitgadget@gmail.com>,  Abhijeetsingh Meena
 <abhijeet040403@gmail.com>,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/2] blame: ignore revs in .git-blame-ignore-revs by
 default
In-Reply-To: <20261013202448.2116038-1-rmistry@google.com> (Ravi Mistry's
	message of "Tue, 13 Oct 2026 20:24:48 +0000")
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<pull.2224.v5.git.1791902175.gitgitgadget@gmail.com>
	<xmqq4iepzex9.fsf@gitster.g>
	<20261013202448.2116038-1-rmistry@google.com>
Date: Tue, 13 Oct 2026 13:39:20 -0700
Message-ID: <xmqqse29uyh3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ravi Mistry <rmistry@google.com> writes:

> In v6, build_ignorelist() passes i->string to
> parse_default_ignore_revs() so the string is actually used (both for
> the working-tree path and for "HEAD:<path>" in bare repositories), and
> cmd_blame() sets ->util = (void *)1 with an explanatory comment (rather
> than passing the scoreboard).

Very cleanly done.  I very much like this new design that still
honors what the item->string says, instead of "ah, .util is not
NULL, so let's do the hardcoded default thing".

Unless I hear objections in a few days, let's mark the topic ready
for 'next'.

Will replace.  Thanks.
