Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9B64A11
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745183145; cv=none; b=r+keDeICNkTvFSa52+uEFPPczo1hCyPnc6MIwwJqKjdcYouZI132dD/khCCyMG3wUY7KyoRHosXh5I8XgqGd/iPO/OIhTn2hHGYHQzfGNkYlcxM7bLwWN+B/TyUVpOSlVcteMnBVCd+wtsFdAaMMgD1/np9qQ6ZnTrZJAQ4CqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745183145; c=relaxed/simple;
	bh=UH7iDeRLvK4tb4hCQAscemmdOF3Wr8QHWHG3Lb0ZBXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PWITxvGKrqfpGCFZO5ZspUlzPPhmJFFdz96XlUaYu+c+lAJeIR5cXkTyVT8/KJxugiyk1yVfj6EdAImb9kmzzHW6TwAGaG9dgWXh/qq5QYRiRNO/wjmjxkkvZXLIb7Y3lof0bGzOvBjOKqoQP80JIXsYfUZMFjA9OBXEd6hUpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UP4vfRCT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VgZ/VXL6; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UP4vfRCT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VgZ/VXL6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3FF8125401F0;
	Sun, 20 Apr 2025 17:05:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 20 Apr 2025 17:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745183140; x=1745269540; bh=3PtQ9BDRwR
	z9eRO/IVQsyBSflNggdbQJKccWUfjmqjk=; b=UP4vfRCTB/+3z8cTj+EEaLP3r4
	Fdb9LkY0YuHnojS9uz7ukV9wmLQAUGuKx9psFMCsHNq+HPE3kTOSyTfOI3DeWgVU
	hIbfB8CYRJoRiOxn8R4ZB/SBpqvIYwX4PEEiQG2pyOAQFXD6ay6y10bMjJlY3FF1
	8FdlelCkCRY9ygJI5DZ2fZPmB3roYdRi6vu9wd0vqmW0EN/A+sb8dyiQUk/tdZba
	d6+ruJ5kRIpblfcJASSn/Zak5UCm4zKEH7jNikXhtDM6qmDdw2yibbwdIgYsKYmD
	51bQwgp8NAtAsIsFoRjaZTfCHK27UnKQ9IY0ThQIlU021w2pVdc1laHwbrlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745183140; x=1745269540; bh=3PtQ9BDRwRz9eRO/IVQsyBSflNggdbQJKcc
	WUfjmqjk=; b=VgZ/VXL6u9Vgp2gZN4UcJV2YlylKZF42vxqZz2EId6ZEgDXdwde
	EHpVkgawLLQrEHNARVHU16sKRIxTMHAcuTf5BLqOoDJnZnnnOJpZXuRzJwbJ3+oW
	Rbh+mWHXnc3DvODGfjsXNrXaZnefLFg4xjZ9VZy0zLgHKeM4n+3rOtUYMVVkdITL
	8CQGuCRZysqafnO+sjvEu2K40AEiSvP0BJjz3dTq4QrpqDMgiwD48NC2S0LuvNiZ
	NZRIeOxL/ZmQsX2CEUY6rc4ifqUJEb263x0uxt9sMY+Vri/YQEmlfENF+1GYqNJE
	ZD70o40GnP2HMvYU9dnWv/b17QbQQ6Rx6Ng==
X-ME-Sender: <xms:o2EFaFYUvRqbYaV2Bm9K7432fIQJjR7u0FV8gfckmzxBeZ3-093M0w>
    <xme:o2EFaMYIBd5KwMpeTAPGZopRZ9i-jCf_yU08IO36Ed7vw0eT2pAVHjT87bC39S4wL
    ReCC_Q7_oBbpvJFzw>
X-ME-Received: <xmr:o2EFaH_47s-RCnqoPHQNvvReIea3pkt_RLXVJnREiUv1q00t_m2l4lOaGZ4qvCKhlckVXq6N2Bd_pyz-HU1BNWhiS70BodCAwwpG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmrghilhhinhhglhhishhtshesmhgrrhhkuhhsqdhrrggrsgdroh
    hrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:o2EFaDpU-bfFOVxFUWRUKhpv3YOgmfPmIQJo5Lc49qrSsxIz0bxYLA>
    <xmx:o2EFaAq9kISxqIwvEI2Op18T0wUDCaxUPoA4G6EJLcCIFoLG0mT4cw>
    <xmx:o2EFaJQVlu0D-r287HQgnjnrYFwTVZKLQIX4js1dfS3MKA_DCz3vRw>
    <xmx:o2EFaIq5V69EXvIgq1rT9FGv_GQOLX7bmEHtymXdFbr7YbY31cuiog>
    <xmx:pGEFaMLrFLK2652SYL3uDpVAlQtC_lanGPWSUP2SXUf-07Td4TYen2UZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Apr 2025 17:05:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Markus Raab <mailinglists@markus-raab.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: unwanted interaction of git stash and cherry-pick --abort
In-Reply-To: <95f731c2-ad2f-40cc-a7d9-85f52cc16389@markus-raab.org> (Markus
	Raab's message of "Sun, 20 Apr 2025 15:48:24 +0200")
References: <d8c1df4e-a4d7-4c4c-be44-b13de3d9ffea@markus-raab.org>
	<aAT4kHFPEb5qwoMv@tapette.crustytoothpaste.net>
	<95f731c2-ad2f-40cc-a7d9-85f52cc16389@markus-raab.org>
Date: Sun, 20 Apr 2025 14:05:37 -0700
Message-ID: <xmqqjz7e8rxa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Raab <mailinglists@markus-raab.org> writes:

> Dear Brian,
>
> Thanks for the quick reply.
>
> Unfortunately, I forgot an essential line in my first e-mail, thus
> I've resent my e-mail shortly later again.
>
> To "fix" your shell script (make the files get lost), git stash pop
> should be inserted before the last line:
>
> ----
> #!/bin/sh
>
> git init-db --object-format=sha256
> git commit --allow-empty -m +
> oid=$(git rev-parse HEAD)
> echo a > a
> echo b > b
> git add a b # some arbitrary files with content
> git stash
> git cherry-pick $oid
> git stash pop
> git cherry-pick --abort
> ----

So, this is not limited to stash at all.

When you start "cherry-pick", which cannot complete without your
help (most often, this happens when the cherry-picked change
conflicts with what you have in the current commit), the command
stops and gives control back.

At that point, it is up to you to do anything to bring your index
into a shape that you desire the "cherry-picked" commit to have.
You'd do so by editing working tree files (often with conflicts),
creating new files, removing unneeded files, etc., and then updating
your index with these changes, and then "cherry-pick --continue" to
conclude.

Or, after mucking your working tree and index to "correct" the
stalled "cherry-pick", you may decide that it is not a good idea to
cherry-pick the commit after all.  You say "cherry-pick --abort" and
you expect your index to be clean relative to HEAD, and working tree
files also adjusted for it.  You may have edited existing working
tree files, created new files, or removed files that you thought
unneeded, before deciding that it is not a good idea to perform this
cherry-pick.  And the way to ask Git to revert all of these changes
you made to your index and your working tree file, and get you out
of the "cherry-picking" state, is to run "cherry-pick --abort".

Instead of doing "git stash pop" there, you could have added
arbitrary files with content, or edited working tree files, or
any other changes manually, and "cherry-pick --abort" would have
removed such changes to your index and your working tree files, just
the same way.

So there is nothing unexpected.

There is another aspect in this story.

"git stash pop" will remove the stash entry after updating your
index and your working tree files, and unless you save them away
elsewhere, if you make further changes to these files, there is no
easy way to get that exact change you took out of the stash entry
back.

And this is not limited to "cherry-pick --abort".

You can edit these files manually (totally outside of Git), remove
them, or ask Git to give you a clean slate with "git reset --hard".

So one lesson we can learn from this episode is

    Never use "git stash pop" WHEN IT IS POSSIBLE YOU MAY LATER
    CHANGE YOUR MIND.  "pop" applies and then drops the stash entry,
    so what you will have in your index and working tree will become
    the ONLY copy of the change you previously stashed.

If you are in doubt, use "git stash apply" instead.  The stash entry
will stay, so when you decide to get rid of the change you pulled
out of the stash entry into the working tree, you can safely do so
with "reset --hard" and nothing is lost.

Of course, you need to remember at some point to drop the entry you
no longer need with "git stash drop" if you take that approach.

HTH.
