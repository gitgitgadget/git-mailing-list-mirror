Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9830B216A07
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898455; cv=none; b=Wm8IxntGHbnT0AwTeEHQSs2UtAfTzgrDWS38Pw7husqhMlp4/nxN0MubU2MxAyZznwOgHURVx8VybgkCKiP1zupo5gd9CC1a+9/NCXuuorF+/IyCPZySlx6t72N7q6SC7LaQ9+6YHA1jSzfnl0+Spqpigwq3fYp+Q5GyoZ555B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898455; c=relaxed/simple;
	bh=3wjmR/qYqb1xF3CFA2C6FOf4nWjZWWhXiLqz/axLnn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KKhlYhUWLJWzBKCrZdn7F1lDHef8gtuFc4WZws+Wo1NwXLBrMJst/9KKoCmsq+qqc9KufzjKxoh3IUML+NUcRGXiMUO80UKkBh6y4cwVpl/njpHQjJ6zUeGvNi7VgWURPeeD4Q+YUkrYR6aYVNlEuCwTACox82OMJtnz2T+jJvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eX5ube1V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B9AsKZeX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eX5ube1V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B9AsKZeX"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 14EEA13802A6;
	Wed,  2 Oct 2024 15:47:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 02 Oct 2024 15:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727898451; x=1727984851; bh=hUB5G3Pyka
	EU34Iuzk1gy9ZwY1PBs4HyKcoEfcZpgt8=; b=eX5ube1V1cdtJB7v+5FKkmGCtO
	uL53Yt3r/NuEhXgVcoAQ3ogjHtdOD5sUfmIu6t8YZ1y4ZsqBPsYgMyaX2ePwlw4Q
	+vwdBuFPGgAImLMbZNL0btKDyA6QA9MZtJZMK48YoqW8HigtS+xdmumql7Ss/hVK
	g2eifdIM41h4sUwMVxWiuyKVH+2MqAtq5Q7Bk2Bv5nwepSymuzJTx5jqt1LD4dRT
	0BqSqfcmP72qXqPLYHueXg/OK4BwU7WXhM9R+IqO3DljVpLGhI1LjdR9S+qocFlZ
	6M5WblzdXVZ45QI5Fh9mtp5MUvVvIfEDTHtdR6pXVBFLLJXedOyQi0ABORYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727898451; x=1727984851; bh=hUB5G3PykaEU34Iuzk1gy9ZwY1PB
	s4HyKcoEfcZpgt8=; b=B9AsKZeXODkRNay1N5UQbTZ1MyOCmqvXgLr5OK/EP03k
	RkEKh0iNF+MbzyprR10OWDiBzPrCPB160aZ1mn4nr3Y9+8pKj/WSAUVJ+JCwQn3o
	bR2kMyQu/x5wCLYZfbEQdBK2r+cEcmFGnwmbGgqffovJUwcWZHkAqzA7LU8Dr3Je
	9p0Mbjtx9OrFcKkMy6IHpxIAq95Lf5Gwe4aH0mCFsF2TEOM7E35jvZu1LHUE3GMO
	vsgTGCoL4c1oQBLjkqqGiZRaUtqyemy7DuZRknkAbG+KwsRdijVKnumkCqp6KEtD
	RmndGaQVoaIDU/BhfXroyFtNF/nW4T5dJmFOJptAag==
X-ME-Sender: <xms:UqP9ZrSo4dAnkujOZDHiDk4qO40EZ7AEYgNWXNxfIMZ3oxExV_RopQ>
    <xme:UqP9ZsyojJMg28KrvdeOg9SNA0n3di6UDb5P-OQxCXrxY_VwTeHpeZF6nXwe-_bzK
    2sL5menmC_ZXL1jVQ>
X-ME-Received: <xmr:UqP9Zg1_-63dpTQRvOYTNJ_G_wELJx-cuGY84-HwG2erunlFrv-sa1EOaEaqtVq7lk7tv8CuusLaWMCAkNMhBCItU3-phCaa5ADdu4I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeef
    hfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrshgrmhhufhhfih
    hnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkohhnshhtrghnthhinheslhhinhhu
    gihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:UqP9ZrAyGrNnlXdGnPM7_UtC6B_Jd54aJ9fholHplWgbcjWY_C2A3Q>
    <xmx:UqP9Zkh5NWJO2-bWfvcxmlncGnrhT9MSmhKUCu1MuLd4wC43zMj_qw>
    <xmx:UqP9ZvrvAZuuVsgutswSWK7Cy6nevxHaWoMUWDMmA07-RSMGluaJaQ>
    <xmx:UqP9ZvhagzYSrMTDkStlj7qsDMzFezhPAF_vPhm9PnK_Iy11Wnuucw>
    <xmx:U6P9ZuYkSiEH0PE8ouRlV3RbQ-e3xMWVyazB3AoSADOMGAqC-aRliSyg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 15:47:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v2] Documentation: mention the amlog in
 howto/maintain-git.txt
In-Reply-To: <5cc8e2bcb88424d8dce526f518282e4b26a1760a.1727881364.git.me@ttaylorr.com>
	(Taylor Blau's message of "Wed, 2 Oct 2024 11:03:44 -0400")
References: <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>
	<5cc8e2bcb88424d8dce526f518282e4b26a1760a.1727881364.git.me@ttaylorr.com>
Date: Wed, 02 Oct 2024 12:47:29 -0700
Message-ID: <xmqq8qv6l226.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

Now the policy explains what is done (i.e. amlog gives a mapping)
and for what purpose (i.e. we want to be able to go back to the
origin), "... is expected to" in the actual procedure is redundant.
In other words, the procedure section can focus on what is done
without repeating why.

> +   The maintainer is expected to update refs/notes/amlog with a
> +   mapping between the applied commit and the 'Message-Id'
> +   corresponding to the e-mail which carried the patch.

I'd replace the above with something like:

      Applying the e-mailed patches using "git am" automatically
      records the mappings from Message-Id to resulting commit in
      the "amlog" note.  Periodically check that this is working
      with "git show -s --notes=amlog $commit".

> +   This mapping is created with the aid of the "post-applypatch" hook

"created" -> "maintained".

> +   found in the 'todo' branch. That hook should be installed before
> +   applying patches. It is also helpful to carry forward any relevant
> +   amlog entries when rebasing, so the following config may be useful:
> +
> +      [notes]
> +        rewriteRef = refs/notes/amlog
> +
> +   (note that this configuration is not read by 'cherry-pick').

"(note ...)" ->

      Avoid "cherry-pick", as it does not propagate notes by design.
      Use either "git commit --amend" or "git rebase" to make
      corrections to an existing commit, even for a single-patch
      topic.

> +   Finally, take care that the amlog entries are pushed out during
> +   integration cycles since external tools and contributors (in
> +   addition to internal scripts) may rely on them.

The purpose of pushing amlog out does not need to be repeated here
in the procedure section.
	
      Make sure that push refspec for refs/notes/amlog is in the
      remote configuration for publishing repositories.  A few
      sample .git/config entries may look like this:

        [remote "github2"]
                url = https://github.com/git/git
                fetch = +refs/heads/*:refs/remotes/github2/*
                pushurl = github.com:git/git.git
                push = refs/heads/maint:refs/heads/maint
                push = refs/heads/master:refs/heads/master
                push = refs/heads/next:refs/heads/next
                push = +refs/heads/seen:refs/heads/seen
                push = +refs/notes/amlog

        [remote "github"]
                url = https://github.com/gitster/git
                pushurl = github.com:gitster/git.git
                mirror

Other than that, nicely done.

Thanks for filling the gap in the documentation.
