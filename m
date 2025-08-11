Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C762E0935
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903434; cv=none; b=OpvXWtm7MZ4PkRZ7Gzor9Jn3Pj6fg/I+sdnRQUlHuZWCWjKdjEpN9N1gaMH772Wig+RsKYha1M1CqAbRfrxaeQt9GfYWPc3psSUFULJy3SmtopVATmq7ZXzRSmi1HwWcq52VekhEk4SIcBAW4D6UJ2jHj6zNO2+2xr+TCXjdpbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903434; c=relaxed/simple;
	bh=2RYhOzyX1zYGUT//+HGKuCNwpWZi8d7jZmDJxIMvhzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyoJbIt1MCF0uXN1Tf/iEYQK0kOjAm6ww9x3YKhHK9qdTRBI19ykpqGsewrYqtBuZDSxx0fo0MAUE08nJ4UXeUbaEAANoBv+pdfxuVws38bawAjSext+Kkqq9NIoOSxAEsF1tRpVGJp+n2B6ohD/Ce7+S2P3qd/G9kFdLCumHuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aBIV/Brr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SrrN5eRs; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aBIV/Brr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SrrN5eRs"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E0DE1EC0099;
	Mon, 11 Aug 2025 05:10:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 11 Aug 2025 05:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754903431;
	 x=1754989831; bh=sPKiv/0cAaYHUmzrHwql4+QGErldkrjOujgrJGl4A+0=; b=
	aBIV/Brr68dFg8DHgqqFYW5a0r9FFxHM5Vx8aaAlkfl4TBSleTjGHD9VsFubSZDJ
	XHu7sIFNPUs+02w4SvdEee6s6JOjEzv6X+u+CFrSA/N/ICjK8tNHqrQcjliCWATf
	mEuHmJph4QzV4wBsiHm+QtGPQp9D9LlpID9MKgQnoXAwLiazl9RZG8qoKlW87c4P
	xtbPnk6NjwWrhR55MH3HPzEmPRxRQyY2ObSRVsbE98WUDNk8vLBsutnqQvNc7luv
	YJWz4HHwvhcDW/tJZEIxhPkVHD4+XPKiD8FRUSNCESAutObN4TCaAvNcoXsQcz76
	ItljZ9wnZmNzk/qHFwbjUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754903431; x=
	1754989831; bh=sPKiv/0cAaYHUmzrHwql4+QGErldkrjOujgrJGl4A+0=; b=S
	rrN5eRsY9SljhqD5aIt/VSHlU4CpQJOrD0PjdtVdjmBQ2WWOqOz09S9DxQGXshmj
	7iuY+CrIcBrZisWdUTd38ndBlFkOM7+SjVf1R3+amZi0NeOINwRdwg8+yFIqrwy1
	bGGvYRcfdQ3Oy+Qe0faxv5WvhdlGYq+6Qjgns8oDwtFPZ8SkXDhJ5ccjfzBbGJJa
	GJ8uN3Dm7M3+1aGBM7X9Ef8bMt0QE3htd7KbtwZ6nGIvqJh1T9LMQ5CbsSi5+NxB
	ljmnyHSDve5iAh5V3S9UvWT/Uc3jk6eXmgah6wD+0tn6EeHyLJUgyNIR912rcm/b
	d9ITl5ae2gvqTNm4i++Eg==
X-ME-Sender: <xms:h7OZaAAclm3urovEYRvg8BGLb7AuXqC3SGS2lHMY587xHZ_AeBM5rg>
    <xme:h7OZaCviWoqlJnIFtIRdAturUmwNS76JiGt32TLbhNgEae3-UpOVHnDGKK_Wp9wdo
    yY-8ULsmLaLllMP_Q>
X-ME-Received: <xmr:h7OZaFY3Y4GWvrhnVgIFLXRHd09yZUZdQ6L4px3VZ3-d_iOk74lRmnKwe5DI-5LMpzBcP79P6Slq2pJzEuaL97nkf5gZlopBPjXM7tN6Hu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohhhnhhkfiesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:h7OZaFVRBLzwGHuKoJ4utN1z89iSXR8DwDs5fY_wQ8sEjrYHIiMwbA>
    <xmx:h7OZaJ7q3DxNsyL1azbp_Njzy2KLfYzDEYMZD5dNaoQ0lJdAZUW5Rw>
    <xmx:h7OZaAiMFo5EF8ti44yqSo2hCQ9iqfOExE3Xou1IvNmG0P9sV5Bl1A>
    <xmx:h7OZaAfHmnoO5oFbqfF7bzyNnVc695vzFxBE15bt7R2FkPUem1Wppg>
    <xmx:h7OZaNRouIuKaHKRWlklH_lygw8fb9GUwVJBpEjXCYSiUSgwZUQsUR9f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 05:10:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3b66c1ed (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 09:10:29 +0000 (UTC)
Date: Mon, 11 Aug 2025 11:10:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: johnkw <johnkw@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: `git stash --include-untracked` touches .pack files
Message-ID: <aJmzgfucZIJf_iQA@pks.im>
References: <2ea19b6b-716b-4736-8dd3-8831056c39f9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ea19b6b-716b-4736-8dd3-8831056c39f9@gmail.com>

On Wed, Aug 06, 2025 at 09:27:05PM -0500, johnkw wrote:
> `git stash --include-untracked` causes the timestamp to be touched for some
> .pack files.  It's not always all .pack files, although I don't see a
> pattern regarding how some survive the operation with the timestamp intact. 
> For a given repo it seems consistent though on the .pack files impacted by
> the issue.
> 
> This breaks backup systems such as rsync, causing pointless churn.
> 
> The issue occurs with or without ".keep" files for the ".pack" files in
> question.
> 
> `git stash` without `--include-untracked` does not have this issue.
> 
> The issue occurs with no untracked files actually even in the repo for
> `--include-untracked` to take action on.

What you probably see here is Git freshening its objects: when Git is
asked to write objects into the object database that it already knows
about it will freshen the access time of each such object. If the object
is stored in a packfile, then the whole packfile is getting freshened.

This is overall an expected outcome, and Git relies on those freshened
access times to do garbage collection. So this isn't something that we
can change. One _could_ have a look at `save_untracked_files()` and
teach it to skip writing objects in case there is nothing to be done.
But honestly, I doubt that this would really solve the underlying issue
for you, as any other command that writes objects might also cause Git
to freshen the packfile.

Patrick
