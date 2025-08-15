Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8D278E7E
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 05:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236330; cv=none; b=hqdYtB0rq95GIASm1NVmo3+Ktobm+3lv/OBEAwaX6feEcTy803hSwVLGZWfuB05Z+y233KDzU1VHw+1BLvGh8MkoYF5asC5R4VxCs8K3ZvpZgYjFVtxCOAAw1kDnl99e4O43LpFGdh6Rn05ZMmuE5X8DQ/2CU7WYjhUuHFRRapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236330; c=relaxed/simple;
	bh=VD54/oqnZeAVll9XaqB3jYyR8oPyk43OU6eWtws0rpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o8cAqg23o/OysUpzSxbl2+IYiERE6bBF2ItNriYXqWi81iEo3BC35iRV1F+KT6jP58OaSuVkOzIS3x5beRtKVqNDPU89PtxfkV8GPfDUe4IB4RVN0s2Y/ZpfTxyGuP7aEbRwehFFf2mo9sRBaHhuWUQcnk7VFcFgHcrlnIB0C2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pi391R7A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GM6Qjb0s; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pi391R7A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GM6Qjb0s"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 375B5EC0169;
	Fri, 15 Aug 2025 01:38:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 15 Aug 2025 01:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755236327; x=1755322727; bh=oRJH26vVaC
	3CgZ/6ym4MMdRdXXatObmF/xDiRSobhmE=; b=Pi391R7A6uYMcqJyQ/TJ3CklCn
	IfLHFCrdP4tDP+ljicrEk4N+Um+BPQlXBSH9+pUs1Z/WCCS7+Tpxc79f54aaZQqQ
	zP4hRNFcTaiMAprOf9AS0jlTiVGmyXrNJaRKzT4GJ0M5FMx7epEg7TqLYCISpiO0
	PwEPdMh7jTOr0qaBRnmfUCWnR5KmavupMUgBMulSvo4onOL2OSYz7u4QzFwCJePB
	glw1qEE4O1S5YrYCSGqzJfLOtJpmqQbSHJyzU2POX7xy7DpxXJMzRI5/iN4KcZrB
	zxPi7bl3VuJe2gsvA6QW2ecbtYMmmP+UopaHck6PGomRqTXLqYuAhM7EBejg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755236327; x=1755322727; bh=oRJH26vVaC3CgZ/6ym4MMdRdXXatObmF/xD
	iRSobhmE=; b=GM6Qjb0sFZoQztRYKi8XX3BCuHp1/EdlKzV5q7L/Bu8wPYEYyBI
	lSM6hjhiPCup9uaW5KbpFfyz77MYHSXgIjtdDDdIEp06Kz9IJ2XfxagxvizG8Rpm
	q2hppsJxJ/SjkH7R0UzGmEQHxwDp8SkWThKmeBSvEnSyHeJzGWvxAYMqNH7zvTRj
	mtPrrWPbJYodgZwGxIdIf6F3sBu/X+UUmchoKxivU4GwQcjl8+/Ye94GM6EeBol7
	UTRN8ZeS4JkNem7hB112qLVu2NavfDbwTHKNjsIs7daVkjyvZym3TF7jvBk9GvZ4
	6JTY7FgdUtF2RaVhHr7zhEqQmrtK8FLhqow==
X-ME-Sender: <xms:58eeaHP_IZU6ZaJyQe2Cmt_ri0t3J3iJw2-y0xI_2jojqW_XvCj0hg>
    <xme:58eeaMgj6bD3fzhXOPZdzIbod2g9E585DY5RHA4fBtLieFjOKVdj20D_mTz-dxslm
    oV1YIKZp4em-XSxKg>
X-ME-Received: <xmr:58eeaC366Q6dQqM-H1rLzJDR3Sg_BHjMee9WvHxVfA4R61eG98RQY6cNdKnmT8SWNfp8IgTrjKN7Fu0jtmUI2_bsRx9u1BKQqNWKNF8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:58eeaOgoIeUMuhPMWlXkSQfsid1ypJTFCZsYtRTImysOkdWYKyfKfg>
    <xmx:58eeaKcoVY7gb_9N9F42V2sv6rGOXEfEhO7BM9SILwwriVyjf66lFw>
    <xmx:58eeaJlsp_Do7bFTuUpRl-bmQ30cSaZhEGbgXlR-ob6ZK2ohzQva7Q>
    <xmx:58eeaLuZE8ktrsC7fCAN_4QkC0XeyQU93Ogh3_VsfGlx-2fbRw1kyQ>
    <xmx:58eeaDfCWftQcDljHPZx4zRX0CTx-4lpeZwZdam68gZdwbs4B-6lVfKi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 01:38:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/5] doc: git-add: start man page with an example
In-Reply-To: <e1c9f388-f72c-4bb4-b05d-b5b183501456@app.fastmail.com> (Julia
	Evans's message of "Wed, 13 Aug 2025 22:59:18 -0400")
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<310d2c1d8f7f68ae52ddd29f0ccb0a0364aba1a2.1755029249.git.gitgitgadget@gmail.com>
	<xmqqbjoks19f.fsf@gitster.g>
	<152d47a3-7744-476a-8ab8-43b7b52b67ea@app.fastmail.com>
	<xmqq4iuabup7.fsf@gitster.g>
	<e1c9f388-f72c-4bb4-b05d-b5b183501456@app.fastmail.com>
Date: Thu, 14 Aug 2025 22:38:45 -0700
Message-ID: <xmqqy0rlta8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> This example makes me think that if we want people to understand the
> limitations of the index, it's important to communicate that the past
> index snapshots are *discarded* and not just that the index is a snapshot.

I suspect that you need to look at the whole thing backwards.  I
realize that it is another way to say that you are looking at the
whole thing backwards, so take your pick ;-).

Nobody stops you from extending the system to store more than one
snapshots in the index and allow your users to roll back to one of
these snapshots kept in the index.  The reason why we haven't done
so is because there has not been motivating any use case for such a
feature (and coming up with a reasonable UI for it would also be
more work).  After all, if you want to keep a set of good points to
go back to [*], that is what commits are for in the world view of
Git, where creating commits and moving around in history are cheap.
If it were something worth going back to, you'd do so at the commit
level.  "git stash" and its index operations (like the "--keep"
option that allows you to test with only what is in the index) are
implemented as (temporary) commits internally exactly for this
reason.

Having said that, there is a focused support to record the previous
state before a snapshot records a resolution for a conflicted path
[**].  This was added because of a concrete motivating use case to
allow you to recover from a botched conflict resolution (aka "gee, I
thought this resolution was OK but I did 'git add' way too early,
before I actually tested the result!"), where "you can commit to
mark the place to later go back" principle does not cleanly apply,
since commits in Git do not record conflicted state.

Please don't keep asking "why" on this point (i.e. "why not record
conflicts in commit?") and other things---at some point, the answers
will become a series of "that is how it is, and it has been good
enough for us", and then it becomes a waste of time to further ask
"why".  Until "here is the change I made to do things differently;
please see how well it works" materializes, that is.


[Footnote]

 * This is another example why the snapshot worldview gives clear
   workflow.  After you pile on several drunken-walk experimental
   commits on top of a good commit and realize that this particular
   line of effort is leading nowhere, you "jump back" to that known
   good point (i.e. "git reset --hard HEAD~7").  You do not have to
   apply these changes in reverse direction (i.e. "git apply -R") in
   reverse order (i.e. "git rev-list --reverse HEAD~7..".

** Read about "Resolve undo" in the documentation.
