Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F39B2F3C3B
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926386; cv=none; b=C9TjdyrP9eVlYqlj/fGAcboRdyVGKtVMWjiKLDWPNPU730Ps4/yRQvSY6YI/v9wa0Five7D8tmllDu3KSDfEU5swxfSpOnaubOWTnPC5gZ4C+bCLQPzHmrr4nAOv2SVTS6ToUXqr6yCfBGV82MBagA8DzajznbXAHn03WbQzc1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926386; c=relaxed/simple;
	bh=78f34afOushnkys3yN5KQ5+uLqCgS4dFJuI+5xxJ2fs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D0aQtA+uzQQiER8pOPTQxEz2757jS1wXaiy0R8JMauGnVdIDNA6ky/PMKpvcUXS2L92pLbzng5OD8k6z4/I55vCr8WfGqxTw0VZQZdIJup8DPpvA/wVSOsmfOa8xRsSIWLD2+qoUp9fs2tfzZesqZUZiHIKOkXLdG0SIf2XAxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uDp/sXc0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aenc5+Uq; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uDp/sXc0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aenc5+Uq"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 77FA47A007A;
	Mon, 15 Sep 2025 04:53:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 15 Sep 2025 04:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757926383; x=1758012783; bh=yfbI9XIP+d
	HP+EjOHdb3qQ9+rPaeuNZe1gmp22wF648=; b=uDp/sXc0CfvRon7tfEWI2CzFy4
	TKou24bpNH8TmYqQDgk/aRyCRvAfSRsiJPVeGUM1aqjf5ypM0qydKdgPnDTKdWb+
	7Kl2rKATUxWUUWL9jT/wif6i6bVHNzumH9B1z9AgHvxRAW2BahIIJsgVWit2X6Gn
	+P4jGrzCt2PycOzpYCR+yBlp5pIBP8NuauXq9Yzryd+nKyAJQMJ323hlRBt1xfnJ
	9upn6R88cpZ8WiTJADtBFJlbKpwteYcovOd1oGCKKrnTUCLlUpqk+cyL6vXQg2SW
	60kcvP7oCAP1sMWyoDmOZF+rt4VbvvzVDkr/ZoMwVYwTX8+r4IbrNI+eHIKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757926383; x=1758012783; bh=yfbI9XIP+dHP+EjOHdb3qQ9+rPaeuNZe1gm
	p22wF648=; b=aenc5+Uq6s6rA1OiG2Ez2LFTL0E0W2uPyjOpyGe8MZr7m3kraRZ
	OR/8g6Ta8KIWY+cd2wBAj0c3W56W5j4BniP32JF9q5lgQi19ilfMvAdaFbYidSeK
	nQ4cmV98x61iDeThwCX6DsDBJLGr5ZNWuP+kJjv0dE3xHYJ0toww0jMc1d/TPoM9
	f4Sr4x3j4Ycx4karF0wlzMqP/zsBji84mZK9ux0BEGs2zWGkATBdoqteEdW7+jVM
	Lecow/bB/9uVLXkQZyTpHZZS6N4UUZ8O+GHJR890udGkWVTLi2oGf7n3C23BPCYC
	/YaZdN4M+P3eMRRiSKDvn1/htvK0RS3Xwbg==
X-ME-Sender: <xms:7tPHaAjo1wy3GoCXsDgDx5OtkmMfJlwaiSJEc_h2V-usHwMMySeauA>
    <xme:7tPHaJzKOrCoOZXDFiArOyMVWxxaDAcQGAa1GCXT2QkjL5uvFN6T5FhM3apPKCFj9
    G73Jmbl39unRrcz9g>
X-ME-Received: <xmr:7tPHaEOLEHrtQKALD-L9bFrTTAmpMKHb5TDXK2RyuGphPjdqHL4joZ8xoRB58MrGLYd-PjKhhmisto4FLwP9cWXkvDImu8D8j1bFqOI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgrggsrhhivghlrdhstghhvghrvghrsehinhhrihgrrd
    hfrhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7tPHaCX09V9yvA_tOQBoLsDHwdSE-PIBRDmFe_qATdtj1cNlWCWJzw>
    <xmx:7tPHaA02_PvXniys0jWNVuA8yIScBH79mO6eokr8Brhie0Kjts1Mhg>
    <xmx:7tPHaIqNMuh8NXKy_5aHUs6SR8qUq2PuO1E2zU7AAHr37PSoFmDlVA>
    <xmx:7tPHaPWtl_7K7iWJQaDytLBwnqmWXQzOlr4wy-nOnA31eueq_HxvtQ>
    <xmx:79PHaCsLwTH4_ZwLLmAAcuzbrJvjh6P9-RlNjl5DYqLgjyFwQR-PHgR9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:53:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gabriel Scherer <gabriel.scherer@inria.fr>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/3] checkout: provide hint when failing due to another
 worktree
In-Reply-To: <d44109a1-0ff5-49f8-885b-9aae195ec492@inria.fr> (Gabriel
	Scherer's message of "Sun, 14 Sep 2025 09:50:57 +0200")
References: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
	<20250913141327.2775228-2-gabriel.scherer@inria.fr>
	<be510685-3be1-4f71-806a-6b580bb1cf21@app.fastmail.com>
	<d44109a1-0ff5-49f8-885b-9aae195ec492@inria.fr>
Date: Mon, 15 Sep 2025 01:53:01 -0700
Message-ID: <xmqqikhkhzbm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriel Scherer <gabriel.scherer@inria.fr> writes:

> In my in-progress version of the patch, the reworded advice is as follows:
>
> fatal: 'foo' is already used by worktree at '/home/gasche/Prog/foo'
> hint: If you want to proceed anyway, try again with
> --ignore-other-worktrees.
> hint: Changes to the branch will also impact the other worktrees.
> hint:
> hint: If you want to detach HEAD at that branch, try again with the
> --detach option.

To those who _need_ these hint messages (in other words, those who
cannot choose the right way to do what they wanted to do without
getting hints), I suspect think "if you want to proceed anyway",
"impact" and "if you want to" are not concrete enough to help them
make the right choices.

"If you want to proceed anyway"---of course they all do, because
they do not know what risks they are taking, and this message does
not tell them about.  So that isn't very helpful message.

Changes to the branch would not change the index or any files in the
working tree of other worktree, leading these users to think that
they safely live in two separte isolated worlds in these two
separate worktrees.  Is it clear to them that the "impact" you are
talking about is exactly the fact that these changes are *NOT*
propagated to other worktree?

Then you have "if you want to" without telling the readers why they
should "want to" (or not) detach.  Which is not all that helpful.
Why should I go into the scary sounding "detached HEAD" mode?  For
what for?  If a user can answer that question themselves, they do
not even need that hint.

I think the message should help the readers eventually realize the
following things to make intelligent decisions.  Making them short
to fit in the "hint:" messages is left as an exercise ;-)

 - 'foo' is already in use and in which worktree.  Your message
   "fatal:" is very clear and is good.

 - if you checkout 'foo' here and start growing or otherwise
   updating the history of 'foo' in this worktree, the index and the
   working tree files of other worktree(s) will go out of sync with
   the tip of 'foo'.  if they 'git commit' from that state, for
   example, it is very likely that they will record a change that
   reverts your changes from the history of 'foo', and you do not
   want that.

 - if you want to grow history of 'foo' in potentially different
   direction from what the other worktree with 'foo' is working on,
   you are better off creating a separte branch 'foo2', with
   anticipation that you'll eventually merge them together.

 - if you only want to browse the files or build but have no
   intention to change the files or make commits, then you can have
   the HEAD of this working tree detached at the commit at the tip
   of 'foo'.  An advantage of this approach is that it will keep you
   honest, if you know that you are *not* on 'foo', but not on any
   branch, it would discourage you from making commits and
   disturbing the other working tree.  Another advantage is that
   when you do need to make commits (perhaps while you are browsing
   the files, you may find small typos you want to fix), you can at
   that time run "git checkout -b foo-typofix" to create a new
   branch and commit, without disturbing the other worktree that
   have 'foo' checked out.

