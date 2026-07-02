Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861D23988EB
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996900; cv=none; b=ArtKWiIphMdnEYgTqTOUC2HuK6F9AuHJhIJO51lZtSxlooL6tJOQwhYb+tQOEpy3tehQDqpBYV4GRWBL0Vj7NSFz8je7VnIIVHa0lq7bnEzwZjKG0fuDSg3njET+kKiIKihkUYPjK3b6pXYMUA8egqw1w5nizG5vafdHhBWPyDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996900; c=relaxed/simple;
	bh=5JYIGXXU7i6c7iBWWPSAs8Sc1+O9QrVWOnbd9/SoWhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Db5XEmp1MmunOMPXpKmfkEfeR1YSusaa3Q8VG+enapA/2XEXp+53Y0VFhanI4LuAVDr8WgmCyqcHn0hk7UL+qmUTTNyk+3tnGdVRX925VvMOSYOy7+1yVvrVgE9+lw97PtU7H2MHoSBi7rvq2NKtQzP+2avdtmFEw0uaEMmFtms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XQ6rFig/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VvZKKpFy; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XQ6rFig/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VvZKKpFy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC6117A0106;
	Thu,  2 Jul 2026 08:54:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 02 Jul 2026 08:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1782996898; x=1783083298; bh=UtP6zbsTCi
	k+YEHQ/8TGalCx3mQA/ZJSl/m/wlxPUaU=; b=XQ6rFig/6E85RTa6htIcW1NcGb
	/35mVNG5F28LSPI4VPFccxT2VO5B5CZ/AOsDcfGjmXWu5w+uJ/t1FOe1KdGQZDnb
	6lkYwFa7KhTrfi9wGtpzsioggOEhafxn78XLQsrqSSFHbhhuX4uFixfn6F8bv5Yt
	RZ2TfzdZF3R3IGHg0TUzvd8ThVRQJZRQr/iX2plR0Fm/ZSUGcSxxeh4Paa+vqK+O
	tFQCqwtAUqD97W7QHt0zTyOpHozbf9tPg3u642bmCImfBzLNY5zueU8y9dJ/k4r8
	iXjhIyzZGDfqdSRTrvvn8Ud+69reYaoLOgHG56h0Hl33AD+dAMkWijObE+7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1782996898; x=1783083298; bh=UtP6zbsTCik+YEHQ/8TGalCx3mQA/ZJSl/m
	/wlxPUaU=; b=VvZKKpFyxmAKonnRtNObHtuEsUYnXDS28UaCClLlZ69qJVvlaur
	8/13fL83u7XaSJtE+qI8Q4MHBjBVZpHbOVcjalqtMjFZiCkD/2Q2tDrnTrvqVjXr
	pbSaHBG55N+LZhev/KdZBddLOaCPhzF3XlnTur0CVtaj1H4Qum19q7XMeDK5upmO
	qoMVciWtXhyApUplCzNDheeM+AMLN00S7wkqFSRquNVYLahQc2HaEIRhLH4lWDIv
	vl3Hjtx/mvmZ++H39Z6NC3P6QO9D8bUuVFJd+vPJmYs9s4GpA5jMx0D16bmums8c
	BdrlFcdcZeYLxI6KnkSA8zaY+BCMDpGtgZA==
X-ME-Sender: <xms:ol9Gah5uodsGCMvcHr0BvO2ddUzZDslTF1CVtHn2rwHh9znwwmVNfQ>
    <xme:ol9GagYB9JmIa7K1QVhXy2MZ7_4n_voTjeLzF_sCb-CJu_8Gfg8zbCoMXn1conVG9
    6URAzBX5WzwWPdd950EswxfoyJOieHrcF7T9KRS8QRh8k8ixOTg7Q>
X-ME-Received: <xmr:ol9GaoiQbSAnkagyFwFSJOjJZTPOFCDmMEVjcbmKceH5U8oswUFooH_VVC9qd4MzAxiZ_8r9G07u8I7lvG5Qt56tNPMXHsB-M0-25iWyjZW6vA>
X-ME-Proxy-Cause: dmFkZTEn+AVNAd+wuuCRl4XtckeSVU6/VbbsdOuEfESFuhKd0fdN+14Cikb+qiKw/FXY3P
    8he2UuNiecPxAx5fHuMu7EfsGnL+F7kV1YXUR8wIrX2iFB2Y9unwoOATgv5+sqiGlHHmxz
    CU8I06sMgyMzx4qS6m0vDPRi3qKrExtO7A7PwZgNl2FuKc32BRr4r7qweK/YRwKLmFpOpC
    VDJujmq3i0KhWcgNKUR54U4BdhnkHw0JkqG21YCQAiE2Vm6xDIxAH7PhlmOcuj/X4BNly9
    6HR5fxR2t1fS9AC3zx9niyAiH1RTAPTBJSTz5d98T5Nvwp5QYLs6+m8Qt9FcntP5K0jXFr
    uC9dhdNp+D9FwhriVQ7gCU6c8IVec/4RgWknt9kuPRQcskJPaXuvI7jAFgPgbPZMBqWqwL
    hNW4UA+PFvZBUxcvnCtMfFV2F2PnW/jqlCFfzQTYA9VzRUf4BIMynCky1h4rJIaR8MUZJ5
    nngh160snRSpjEEL/L+KTwHJ1PvI2NKK+SzWqPeYQTV4K1yi5jaUO4e6WIPBrzapTtGp3j
    05MRyK1X6+v1oLHB1bLN+iufxHRrmmVhFDNwam66pXgnVqYu//0x7Gx3Dpg66Ex/aKmJOn
    +aZAkrvo/Rvb550tuezClkG5H9aenI/hwEfUPP68fSHZ4GmPIGhPE9KDW+kw
X-ME-Proxy: <xmx:ol9Gap8T3W8SoSj2P1MSiH5BctUMSbfV9cFTQPmEXBZPWvk6xSHWGQ>
    <xmx:ol9Garp8j48n4F3gf4dc7TfV29wFIeSr6vLoom7HG5RKcsJO2SBEYA>
    <xmx:ol9GapV4EEkG5dQMtSG0bs6pOgWmbUEzfDnAT7ajhriBpG_YwDD7Aw>
    <xmx:ol9GaiCQeJCde9Ngph5PyQfLsweS8PApw8ZdIvo3VKm6RE6rmyMIVQ>
    <xmx:ol9Gamxc6fYj-y1g_PioHGc2bj3AuuPWqa2hrP1_REugUoYO26o2pGgC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:54:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7637cb30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:54:54 +0000 (UTC)
Date: Thu, 2 Jul 2026 14:54:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Matt Hunter <m@lfurio.us>, Harald Nordgren <haraldnordgren@gmail.com>,
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
Message-ID: <akZfm-igZKeHaDST@pks.im>
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
 <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com>
 <akIQLM6xZTHBudWT@pks.im>
 <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
 <CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
 <dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>
 <DJM1N17VMUM5.3V5Y6YMFLIFQJ@lfurio.us>
 <3c35bd17-e884-432d-a400-36a89964ed89@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c35bd17-e884-432d-a400-36a89964ed89@gmail.com>

On Tue, Jun 30, 2026 at 03:01:43PM +0100, Phillip Wood wrote:
> On 30/06/2026 03:55, Matt Hunter wrote:
[?nip]
> > This is probably a larger question, since (according to the man page) it
> > affects the other 'git history' commands as well.  When I run
> > 'git history ...' and discover that I made a mistake after inspecting
> > the results, is there a fool-proof way to undo the change and return to
> > the previous state?  My first thought was to run 'git reset --hard ...',
> > but the default behavior of --update-refs (moving other branches) can
> > make this more complicated.
> 
> Yes this is a problem to which we don't have a good solution at the moment.
> I believe Jujitsu and git-branchless both have some kind of operations log
> that lets you revert a whole operation rather than just a single ref-update.
> We'd need some way to tie all the ref updates from a single ref transaction
> together either by logging the separately or adding some form of transaction
> id to the reflog. That would be a big change.

Yeah, agreed. I think that the reflog is insufficient for a lot of Git's
operations and that it is way too hard to reason about. It's both too
detailed and not detailed enough at the same time:

  - It provides way too much detail about individual reference updates
    when all the user cares about is the high-level operation on the
    logical level.

  - It does not provide enough detail to give information about what the
    high-level operation even was.

I don't think that we can fix the reflog to work properly in this case.
But I certainly think that we should explore whether we can eventually
introduce something like an oplog, as well, so that we can easily have
the equivalent of `jj undo`.

It's something that I'd eventually want to get to, but it'll take a
while. So if anybody else beats me to it then please go ahead :)

Patrick
