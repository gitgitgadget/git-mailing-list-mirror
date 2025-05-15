Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CB4296FB9
	for <git@vger.kernel.org>; Thu, 15 May 2025 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339192; cv=none; b=hWdm2EuNMV3FGBfzkMqS6uD6oV0KhzXeKbDXEgT/IqBnrPvZST0TbEbs/bcztSQuuSs3HvSXZxk+J7EZFEqXtfs1YnkeNIUMsm0nK9wqg6Hapes33tyYU9WLjUsyhqGhS4m4KH99ezdY5PFkdOs+0wAtRc0WyHmUiqD3UNFQqDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339192; c=relaxed/simple;
	bh=yXRYCjuGV1U7H89heUcRJcE1yDSDVWHaOEMQs8+LVGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F8PFfEFDiBim4GEKcrbXGT76x2Ts3E+2cqSzxIUJGHN4SllnPx88Cu03oTbnpSEBBeHIkoLIPkcdv7FIZqd1gx6f4TahPHE2HGCRmKOXD6asNejxngwdIRSRqJVX2IURCmPairVgnx2ADydnRgrW4t7dgZr1Il/vIesj4yiSElo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mSz5oiu/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CF6oQzXo; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mSz5oiu/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CF6oQzXo"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AB07613803D2;
	Thu, 15 May 2025 15:59:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 15 May 2025 15:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747339188; x=1747425588; bh=YxZq+Tv1qG
	ojXHMbtMEusCFACS7FTvJHUCU7OTWdEQE=; b=mSz5oiu/VHSM8++cp/u6TWLAPa
	uPoL13bSqYtt/lFrWHjWiLauVMcjKV8OJoskbMD3mIgPhNW3TkFzshXWKXkX9BVB
	7/lZ8tXTs+xAR5DWXGbhw3gmcV8swcx/8phXrTnboDqwY3hPGerLhZYg47gLUNQB
	Q/P+Ltz76W34NwNQssMGl9fFOOB5I/ypbLAf3YOwmBdAPkalUa8LNCXbLgQ5pfjP
	FMNVT3t7fJHcyobXiEWJFNvnroyESbe9EMqobMUYr+isZOna+kyp/2K3QEWPWvDL
	XGK7IKPvg5l+YRbxHQqq0dhqFhx4FlYStmO4T0Y0PqUKZltcq7N+YKUbdJQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747339188; x=1747425588; bh=YxZq+Tv1qGojXHMbtMEusCFACS7FTvJHUCU
	7OTWdEQE=; b=CF6oQzXoZHEqLM4GE5rqxgEOUIGF1iTpNpD1JgusE78eZDx4LhH
	6JeYKefjzPGG72O7ON6qK2V7DbTo/JwYtVkKb87sgkX2WMHM4hsS+xTJDWJaD26h
	XjOdCPRj4UaIT5eSIcA2QlgNMS+xaNGMhNR1Nw6Z/ITxQHwQyNKsVZYHjw8U6AXi
	x1Oi6a0M4D5pGdOh9V4C8mpmyDTg3rYBNaxPvxDS9Vo70iQq3pVqsYLnUpJbIg2O
	mK/116QFliZqRtUQ+tSEEa7SkbSC4wL45to3JnNMzKEtVdHFnuegQ7VcwrdMvlrJ
	D5GLm8NCFi7Cn+TEJvPwqmAVVhCV+b3+vwA==
X-ME-Sender: <xms:tEcmaKJbI-zpcEkOcRIln8VFpjrH2bzEsqze5fzNkJvou2O7SnEXvA>
    <xme:tEcmaCKsr4ymBav4vZDVRKjI5ZIBW5sf5Jluh1kQdnhpGpq6zLLRzqFr-HWUUrcWs
    WSZoeh5x1OiP5ZtQg>
X-ME-Received: <xmr:tEcmaKsuK95KI44hyB0rZcctgGdBD4Dpliko8sePgedl2G5Br77aRwBRQJ-254s0tKODLwAJG-b11i3PVFJm7PJOTI1SYrZ3N0bDYA8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrggtohgsrd
    hkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehoshifrghlugdrsghuuggu
    vghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehnihgtohestghrhihpthhonhgvtghtohhrrdgtohhmpdhrtghpth
    htoheprhgvmhhosegsuhgvnhiilhhirdguvghvpdhrtghpthhtohepthihthhsohesmhhi
    thdrvgguuhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepvghkvghmphhinhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:tEcmaPbs1_jv4Etn1_aiTogPAUDMxZzScyNhQZ7nASmD2gOxE3u8Mw>
    <xmx:tEcmaBat4PU10P9J3vOffHq_07hVMV8MKYEP7Xoe0BWX6rpUaJo2DQ>
    <xmx:tEcmaLASWrHi4zS0X5C4BwiPb9e5c6INWm1cuN4hGRRZ4SwouG1Ypw>
    <xmx:tEcmaHamAb1QEJ_jG2FWHOHg480urYBTnE4y8tjGj47NmHPY9ztCbw>
    <xmx:tEcmaEKQEm6RrIWDaTZpn_GSE415qcnTYnpxY4OIlBjliSMc8DY01A0p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 15:59:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,  Martin von Zweigbergk
 <martinvonz@google.com>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Nico
 Williams <nico@cryptonector.com>,  Remo Senekowitsch <remo@buenzli.dev>,
  "Theodore Ts'o" <tytso@mit.edu>,  Git Mailing List <git@vger.kernel.org>,
  Edwin Kempin <ekempin@google.com>,  Scott Chacon <scott@gitbutler.com>,
  "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
In-Reply-To: <CA+P7+xrruw=NUJgzV4D6CQbmGJO4CEjhkU_+qFDruD5YMsidDw@mail.gmail.com>
	(Jacob Keller's message of "Thu, 15 May 2025 09:32:23 -0700")
References: <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
	<D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
	<CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
	<aAgWytQNqtLzg2TU@ubby>
	<CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
	<CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
	<CAESOdVCKTnUbVuXq-=F3df4i2T-GcDpJMENr8wwm-ZXR95+59w@mail.gmail.com>
	<xmqqtt5pu5g8.fsf@gitster.g>
	<CAESOdVD-8j9k2Dq9WgiR9WWO09mpfR9Xxe3pMUWg-KoTfELG8w@mail.gmail.com>
	<xmqqjz6jb6kd.fsf@gitster.g> <aCXCgKYpEqxWxIT_@ugly>
	<CA+P7+xrruw=NUJgzV4D6CQbmGJO4CEjhkU_+qFDruD5YMsidDw@mail.gmail.com>
Date: Thu, 15 May 2025 12:59:46 -0700
Message-ID: <xmqqfrh5zlu5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.keller@gmail.com> writes:

> At one point, the driver team I work for wanted to include Change-Id
> trailers to commits we submitted to the Linux kernel, for tracking
> against our own database (we used Gerrit at the time). They were
> rejected for this very reason of being an eye sore --  (possibly other
> reasons as well, I can't recall the full discussion).

For something to be an eye sore, it also has to be of no use to
those who consider it an eye sore.  The signed-off-by trailer is
noisy and it becomes annoying after reading "git log --no-merges"
for a week worth of commits, but it serves useful purpose so nobody
would complain them as being an eye sore, even if they complain for
other reasons.

Why weren't they seeing any benefit of having such trailer?  Would
they have found a good use of the information if it were hidden in
the header part?

If the answer is "it is only useful to some people", what is the
reason why those other people find it useless?  Is it "our own
database" being closed and there were no federated catalog of
change-ids that can be used by all project participants?  Or does it
go beyond that, like what a Change-Id trailer means to project
participants from one organization is different to those from
another, or something?

