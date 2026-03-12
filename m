Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643DF28B4E2
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345014; cv=none; b=s/ldXkKO+LrgQ7ii8YxjWwHMHpJf/7LfA6e7CfhvtiEgJGeXTuVjQUlNB/+fQ7V3xjfJOM3k0+jmXcmQJHwcSswkwfsU2k1mE0HdbmvRB2TAvLjdN6rZ/mU2wNsrDbv+o6FpBp9PEqP+NhONdf8rA52kJZtQtNnj3Rr+SzZoxc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345014; c=relaxed/simple;
	bh=ZWg3YiFflGMGxM4aI5yoAhToIjFVj4g3Vwy/73NzixU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sZVbHCYD/XoMJn5Zq7QgYsxBtIcMlObJlnkCP/FEpY12KfNgkIpD+DJYoSWSW8hZztnlAI13Zf+MHyIXAhR7NiDjejBr2sp6ySvs3RO/dqgdabsa1FiyHN+eZuDpS05/rJ3y4P9coixns8Y/8dqwBDnZrCNyC47hpdVV5iO6T/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c0Y659F+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vJrJHijb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c0Y659F+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vJrJHijb"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 978A614002AB;
	Thu, 12 Mar 2026 15:50:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 12 Mar 2026 15:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773345012; x=1773431412; bh=d1Yfkr2tpV
	jLAe+xUk9C93dO0QSsY/sn/I/wDRKuv6o=; b=c0Y659F+XdKiVc4LCka6aGoLKX
	1T0Q8G9Y4jRNTqjy9k4mlLsytqOEHmJkCC5imgB5MxmngGLwSxRz/3SE/AqJZCjN
	1qhFcf+DvVO8rDtaUWReSBJCm059LZkFSBvPbB41dxVOxbgSir2fCW4oDE2sH6Cv
	xoVMBUxRofEj+Jyar/gbqjzPadr/y8YlCHgt9wIV3mFIHq0vZgHYoaR5PdCb/gbV
	XvZ5G8+PDKAG2h1cmeJSdx1QFUfSrkQsY49HJOCe0yZPXnqZRMq6FZTHuCEqrxjj
	LAojfDYO1pk5CaT5Eo6L9HZ/KHNgKR2yuWDOmJAL4BThbTTctqQetybU5ZAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773345012; x=1773431412; bh=d1Yfkr2tpVjLAe+xUk9C93dO0QSsY/sn/I/
	wDRKuv6o=; b=vJrJHijbrUFaScgLx4GlDzR5il6RufKbanV02Vc1hNTlENbemKC
	lnd+h7xul4MhnHd74m9fgY/hVYjJMeDrz4oJodNxWTY5xvRoAp00g5TUQUI4HzPZ
	A1fud1onCOZlcOVwKmer+i7FzG/Su5e8rlOxh0h26ieovkmHyjwAY9No18P2G1De
	QB3zZMbQNBK/LGmlUK7KUUb5nkgtUOEs+YqQ+ojn3pWpEWcC3ZNKnm3dPOIt13w5
	mfwhuPi6bfL0KrarIxqhOxdPgICESDcxugHzl85EdmK0LSktiNJJv8sW087gA7lx
	1oLPvcpIQxIBPea64UwKL89Z+kKhIjZNd5Q==
X-ME-Sender: <xms:9BizaaOs9-fUM8bonPE0GrAKNVnx7oiokrOFxKyuWKs-0o9H6HHs5g>
    <xme:9Bizaf-zAS0ytHWfkcDUAjFiJWnAGVVC3NUiVclDpfNXrAvyQcxHkTU4aIfXDtLhV
    KZMOZ9XoV5sSaX5doq5pa2iugo492eg0bKUl5UtxiDRpU_RW68gZA>
X-ME-Received: <xmr:9BizaWTLbjBAIgzzVU1opaHBYhiojVVSQF2Chu7OW7-REeZY0wVy1Jg1L4b1h7dMRCgpPiAoRvmzJSYMIVv9NRSXqFS28NQAaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9BizaZl_ODvBwbXtnYknwc2H5x_oIuMGYeG5HeWcmKQbqgBYAC2CSQ>
    <xmx:9BizaeT__vUnF13wuFU2Z_FhNNshfqfH1xfD4lrs1ZBqSPYxW-q_XA>
    <xmx:9BizafMZQMSJag5Y9vr6R4KCcVRQeQFvtSFYcYGMgit4AhHZ-Xyvdw>
    <xmx:9BizafVxilQTOKhUh4ecGk2AtFd1De9JwDitLKP05C4vc_CfbY4iEw>
    <xmx:9BizaaPGEOjJoTW9GWt_mVQ4Khm68nSeoFxfxPMZZMV9aS7sst7JA07f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 15:50:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] checkout: add --autostash option for branch switching
In-Reply-To: <pull.2234.v2.git.git.1773344022931.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Thu, 12 Mar 2026
	19:33:42 +0000")
References: <pull.2234.git.git.1773321998854.gitgitgadget@gmail.com>
	<pull.2234.v2.git.git.1773344022931.gitgitgadget@gmail.com>
Date: Thu, 12 Mar 2026 12:50:10 -0700
Message-ID: <xmqqjyvgesjx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> When switching branches, local modifications in the working tree can
> prevent the checkout from succeeding.  While "git rebase" and "git
> merge" already support --autostash to handle this case automatically,
> "git checkout" and "git switch" require users to manually stash and
> unstash their changes.
>
> Teach "git checkout" and "git switch" to accept --autostash and
> --no-autostash options that automatically create a temporary stash
> entry before the branch switch begins and apply it after the switch
> completes.  If the stash application results in conflicts, the stash
> entry is saved to the stash list so the user can resolve them later.
>
> Also add a checkout.autoStash configuration option that enables this
> behavior by default, which can be overridden with --no-autostash on
> the command line.

With this, shouldn't "-m" become a synonym for "--autostash"?
For users of "checkout -m", this is a strictly improved version of
the same feature, it seems.

Also, "stash" is merely an implementation detail of how we make the
merge safer, so from end-user's point of view, this feature is more
like "switch to the other branch, while merging the local changes
there", so calling it "--merge" or something may be much better than
calling it "--autostash".

Other than that, I like the implementation in general.
