Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881F30F94E
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727370; cv=none; b=aPEUgyyu8peNtf5dzgEK2wd2pm1NUai18oG60P8jFLX+N0nuB9aeE9SJ/CuGxaVapE7zViCPicqE8AGpVEb8+Ld3mykGiqdt1M0vCkx8/o7lKgw4gkOve9MjmfoJXzIQbdvWPpYjB2b56KsY8AFByWWnK9JGSoqIS02736KvllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727370; c=relaxed/simple;
	bh=SU152vtNyacVAgRMCQjkrw1jK4IvXohOZDchreuVjO4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nHOZ2hNl/9YE26a2cn4t2HrfCR3wZkZlHaLczluEIUBfgAMpvdhoH7GhryGM6TCHtQTrAz7VLMa9FG69aeVfmPW3KpTpjbig2AppYpExLaaTQrY8TmAwRXcXizRvvZokgE6zgmqrL+ysAfAd1UPloyzx0CEVh8bTgczun0hQ9dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=git.strova.dk; spf=none smtp.mailfrom=git.strova.dk; dkim=pass (2048-bit key) header.d=strova.dk header.i=@strova.dk header.b=PqY2JxS/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fQ6gQwv8; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=git.strova.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=git.strova.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strova.dk header.i=@strova.dk header.b="PqY2JxS/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fQ6gQwv8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A6C431D000B5;
	Wed, 24 Sep 2025 11:22:46 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 24 Sep 2025 11:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=strova.dk; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758727366;
	 x=1758813766; bh=SnHK9fLLKq5Z5MTMV4jvA/8eTuppjaliGPOBAX2ZB7E=; b=
	PqY2JxS/TmUAOAELwxXOK4KaIyYu2OjCcCaJbbzV50vPjTmfipmsA+8YnggFy/tj
	Juy1zII3nbMyTjnMr/W7afPMgdHNMWND85qODZNZ4LI1mjPfBJ7nYzqYw4LMjkiJ
	zJZFrnaDYy/e4K7kL8PgxSU0vRq4cu2D3y3QcoB2BIru12MYFTRJus29RJA1V/fs
	SKbtkn0qUSSoMCZLgv5OJgmPlxqEuoWksL1zqCN4n/QNZbQw+Jb3J2vA7soMFNtx
	y3WM8plGUEqe+oVAQmQ68Dex2FgiJCcQDb95Rhbe01DRwP0TGVqiyatRypSdC6rM
	/XXkP1E0mluz17lkkAFJfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758727366; x=
	1758813766; bh=SnHK9fLLKq5Z5MTMV4jvA/8eTuppjaliGPOBAX2ZB7E=; b=f
	Q6gQwv8CATjLZeQpu/kTbQyHAePSnRsFl8vbvy/Vua6hGV97LF9B9puMjvpKy1XD
	/svDmDnlBzLhS60A/M6rxWWEv+DH5zKSWsuMSyqL+saECZKx0YvDP5IJtdMufUhx
	6CiKLa+YZnl0HD+fhZKb25ch95nu5aKmJs8Cy8kn/Z89Y3F0RFVUaFiru6+0wNPk
	4xK72bK7Klwzc0JlA57mANsl909sEcvyKWZcuR7KQBubca3nqXjdI0pZx1idrIN3
	jjrdDzkkZlwUCl7cluXgDHMxHrqStwcAVJxQg1EHGtKE98EamOhnSajajAgy5e/C
	Hp++BQ1J1a8YwjF35i3nA==
X-ME-Sender: <xms:xQzUaMILB0eJmZ8WB6fxi2HyWZdNAoU_txJ8qBpKr0C6dcxoGLowmQ>
    <xme:xQzUaG8h94B1nDkZ83-kCBElBXrSphKWJyTvPtCMR2cunffgcyNZ2VdAxRVXMeYbR
    9LY3AnPXiAdT91p1F4fDYh4OsXYtbFQpUXrvh1Bhm9_NQWv2BHPkM_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdforghthhhi
    rghsucftrghvfdcuoehmsehgihhtrdhsthhrohhvrgdrughkqeenucggtffrrghtthgvrh
    hnpeeuleelgfevgffgheeuhfffkedvkeejueduieehffevhefhjeejuddtgeevgeegffen
    ucffohhmrghinhepphgrthhhrdhlohgtrghlnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhesghhithdrshhtrhhovhgrrdgukhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepjheitheskhgusghg
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xQzUaAyV5p3ru3dVtNjjETOsll4yJZ6RMsGy2uf0v1rzyK1Gn0sxfw>
    <xmx:xQzUaPuLvIIJ5G0rHK4E1Qv8TfzYu8cNq7IubNBzKuNkIEdbIM5_0g>
    <xmx:xQzUaF0vWk1rOMbLZNHWbJXBKvwq_Wv125i_FI4qYfIls1ffKP67iA>
    <xmx:xQzUaC-f3GA9FVpgpOVZ1FQ5LsBdcZ5lJb2AFLIlF7L1v7NR2b82jw>
    <xmx:xgzUaP7s8IR7Kz0TZoL-ygQvVU4oiQmr7l1OxPIMlwtAWhLzEiZ8hi2V>
Feedback-ID: ic5d648a2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 84BFF700065; Wed, 24 Sep 2025 11:22:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIKuU7SDf1aB
Date: Wed, 24 Sep 2025 17:21:24 +0200
From: "Mathias Rav" <m@git.strova.dk>
To: "Johannes Sixt" <j6t@kdbg.org>, "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <7de3da11-6191-4fa3-bd0d-842dc45690e7@app.fastmail.com>
In-Reply-To: <0a14a93e-7da2-43e1-9d71-c58a69c7a4af@kdbg.org>
References: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
 <xmqqldm4onma.fsf@gitster.g> <0a14a93e-7da2-43e1-9d71-c58a69c7a4af@kdbg.org>
Subject: Re: [PATCH] rebase -i: use same commit's message and date with f -C
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 24, 2025, at 10:47 AM, Johannes Sixt wrote:
> Am 23.09.25 um 23:38 schrieb Junio C Hamano:
>> "Mathias Rav" <m@git.strova.dk> writes:
>>> Change the behavior so that fixup with -C takes both message and author
>>> from the current commit, instead of taking the author from the previous.
>> 
>> I am somewhat negative to this change.  I am perfectly fine to have
>> a separate "I may have started from that previous one, but that was
>> so broken that I essentially dismantled the original and replaced
>> with the new one.  It is better to attribute the credit to whoever
>> did this last one that is replacing" command.  But the "fixup"
>> command people have been familiar with would be different, I would
>> think.
>
> The common situation where the proposed change is handy isn't where a
> previous commit is fixed up.
>
> Sometimes, a previous commit is a fixup for a later one, for example, a
> change slipped into in earlier commit that should go into a later commit
> and has been split off into its own commit. Many times it would be
> sufficient to reorder the commits and be done. However, sometimes (and
> not even infrequently), reordering the commits introduces conflicts that
> do not happen if the order remains. Here, we want the proposed feature.
>
> Since your argument hinges on the word and meaning of "fixup" (which I
> can buy somewhat), we could extend "squash" with an option that
> specifies which commit supplies the date and authorship metadata.

I have never used the "amend!" autosquash feature and I was not aware of
it until I stepped through the code in sequencer.c to implement my
proposed change. I think the `git commit --amend` manual explains quite
nicely why you could want to keep the author of one commit and the
message of another.

Before discovering "f -C" to achieve the "fixdown" behavior, as Hannes
describes, I used "x f" to invoke my own single-letter shell script to
achieve the behavior I wanted, and I guess I am fine with going back to
that for the cases where I want to preserve author dates (which, to be
fair, is often not that important to me).

For completeness, the implementation is ~/.local/lib/git-rebase-utils/f

	#!/bin/sh
	git cherry-pick -n "$1" && git commit --amend -nC "$1"

...with shell alias git='PATH=~/.local/lib/git-rebase-utils:$PATH \git'
allowing "x f" in git rebase -i without polluting the regular $PATH.
