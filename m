Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4C37996C
	for <git@vger.kernel.org>; Fri,  8 May 2026 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250660; cv=none; b=t6zIBJOn3ogF/r3svpeeKQ697k944RIW7MbWpmiqs+MJr0L2MMGPRmtsAa57OPJzTRH7oKPKy4hyGpB9ZdB5uorMW/AuVLW75os6LkFo+tPVABXt1MydTX3TZSaO8DuqDsWxNdlWX5vfDWoV9G95ptFOIFWhBvcqCQnkgAEheEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250660; c=relaxed/simple;
	bh=iWpNR3k+tikM4QLY5tDT/Oh2LILfq2+N69+0pXC+ktE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Xpa+ksQLY76ysLHVqTv26f9WlWN7TxmI9WqFIAM36Ma9Ic82tkI2iHTjXtQBjjPmzJTaQSnEcYMXkxN5bHOHwzhu0ZQq9BI1AEXVGo70aOUiHbtzaTmtKMfGNU7xZUnJKV7VQI8qLAV1hAgDfJGNDh1Qe1hHdobgM2oIV6Kn6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hurrell.net; spf=pass smtp.mailfrom=hurrell.net; dkim=pass (2048-bit key) header.d=hurrell.net header.i=@hurrell.net header.b=gvWvCUl+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPGvtrsT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hurrell.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hurrell.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hurrell.net header.i=@hurrell.net header.b="gvWvCUl+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPGvtrsT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA73C14000DE;
	Fri,  8 May 2026 10:30:57 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-02.internal (MEProxy); Fri, 08 May 2026 10:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778250657;
	 x=1778337057; bh=xU97ayUdT1kcqtsvIE4ACzUAGvp6rrjPR1hf3yeLmqU=; b=
	gvWvCUl+giDntQSDqvltuaTGhllUcycJDEBssXdoVD9BlP9JBsZICVedJmAd9jyp
	ID+p5uMrLxSeV0JYiIsmXNQ4JkYl147fq8aQBS9lhg/Y2rTlp+yq664GyToKdgV+
	PbSBIN01gOEJ+poiY2/dTPDSoln5FQL+SshEIX5x0vHfyUXW4b26GKszb7Owem/Q
	vLeAofzNjO0lKsCjsIWuU+NAwXEESZdvkQu1MaaR09NJSYClHD0RA1CNbfYBeh8r
	VXoo7YgY0FYxOekEOG6khYlkGyQSFmGRryUO//WJ/FweCivFj6L0bkQ4rsHBtYbI
	yRHeemRMAVN0hSZ9TVupuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778250657; x=
	1778337057; bh=xU97ayUdT1kcqtsvIE4ACzUAGvp6rrjPR1hf3yeLmqU=; b=U
	PGvtrsTva4S+KCBhTn3gMAU8QngB7vwFgoljM6J8EGCWaEd11DVjFkqx8KqKOED+
	QVRIA2SPOLgq27cYFsFju2j0CnzRiJIx4i8+o2xnDNYJIlqZXqQZQbCsJnPN7FSl
	74ZFeLzGF8z7KMDE0oDJTsdkURKIyQPnkV/d/LRvb+tFgbLcPVpW60OaeZMztFcE
	bLsDR7Lydk8rh33F2xT3bLq/mdlrUJFgfMURtSbvXJ8Jx1RSaT480c3C92/+ulLc
	N7KpKVLE5B7J5i9hgFzj7e9GP0AzNZhJZ4l1/kVKH8DNm9ji3zYGZT+tb7h34kxq
	tvgXVoJrnpC1C0YGqoveg==
X-ME-Sender: <xms:ofP9aYCZZ5qwHJ3X2tNY37Yz70cBwtWvoLPUutDWT8qNyLEOqBDGzA>
    <xme:ofP9aVUvlC90jTs8hUX5KH2rVsB2zir-NVvlr7izqhHHzA9J8hvyWPJblgAv7WEO2
    PElHwA-hCHf1LO5VxAgi2BibZ7C_aBmvH4ZuF1AqDMKJIdM-mRVpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfifhrvghg
    ucfjuhhrrhgvlhhlfdcuoehgrhgvgheshhhurhhrvghllhdrnhgvtheqnecuggftrfgrth
    htvghrnhepgfefvdehfeettdeguedtgeekgeehueekvddttefggffhkeffledvteekieei
    geetnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheshhhurhhrvghllhdrnhgvthdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhrvg
    hgrdhhuhhrrhgvlhhlsegurghtrgguohhghhhqrdgtohhmpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ofP9aSqXay1yIvwKsEVr8neMpjpBWMK5R6n8NTpLd0rft_fMoWLIdA>
    <xmx:ofP9aecmd6DItTk7eqG7rMN-IaSpDVUFGE-EhpdJDMRjq28KLEUYcg>
    <xmx:ofP9aRpQ5Dsgg-hQ1f_6aS-5eQzgmuXjMIbEewKT-9tkQlJNBuJAMg>
    <xmx:ofP9afHEu1LbdOYngHdmjLg46hHQ8_huyACkcIIfn5h3Mg7SAbNAnw>
    <xmx:ofP9aWO7FfnFB5qvRwoxvQU1ZJjjk3kzTgJgx1kKoqYSjAIlz6BQ0J6I>
Feedback-ID: i12114735:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 819D01B4006D; Fri,  8 May 2026 10:30:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-iWxsR32d1o
Date: Fri, 08 May 2026 16:30:36 +0200
From: "Greg Hurrell" <greg@hurrell.net>
To: "Jeff King" <peff@peff.net>, "Greg Hurrell" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 "Gregory Luke Hurrell Stewart" <greg.hurrell@datadoghq.com>
Message-Id: <c5e0a1fa-f228-41dd-b547-07b0ad6c0964@app.fastmail.com>
In-Reply-To: <20260508141314.GB709299@coredump.intra.peff.net>
References: <pull.2108.git.1778231254871.gitgitgadget@gmail.com>
 <20260508141314.GB709299@coredump.intra.peff.net>
Subject: Re: [PATCH] git-jump: pick a mode automatically when invoked without arguments
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, May 8, 2026, at 4:13 PM, Jeff King wrote:
> On Fri, May 08, 2026 at 09:07:34AM +0000, Greg Hurrell via GitGitGadget wrote:
> 
> I'd be a little worried that it is more confusing to somebody
> approaching the command for the first time and just runs "git jump" to
> not see usage or other guidance. But that might be overly paranoid.

Hopefully, they at least read the README before installing it from contrib/
(although Homebrew recently starting installing it for folks automatically,
so may not remain true for much longer on macOS...)
 
> Would having "git jump auto" work for you? I.e., are you primarily
> trying to avoid the mental effort of selecting the command, or the
> finger effort of typing it?

It's mostly the finger effort of typing it because I generally know exactly
which mode I want; eg.

- I'm in the middle of a rebase, and hit a conflict; 100% of the time,
  I want to explore the conflicts, so I want `git jump` to do `git jump
  merge`.

- I have unstaged changes, and I want to make some tweaks before committing;
  so I want `git jump` to do `git jump diff`.

- Otherwise, I'm wanting to search for something (ie. `git jump grep`),
  so by definition I'm going to be doing some extra typing anyway (ie.
  `git jump grep <pattern>`).

This is muscle memory for me at this point, because I've had a `git jump`
alias for this in my dotfiles[^1] for a couple of years. Homebrew
installing `git-jump` by default a few months ago[^2] broke this, because
aliases can't shadow builtin commands.

[^1]: https://github.com/wincent/wincent/commit/99183f86fe35
[^2]: https://github.com/Homebrew/homebrew-core/commit/e9fc066240f2

Best wishes,
Greg
