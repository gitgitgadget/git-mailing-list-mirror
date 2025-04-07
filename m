Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91441586C8
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744059601; cv=none; b=AqL+nSQ6bsrT5L21X9YsEaK7huP6XjSYIJvOaq7mmA/qMmMvUzPNk6SlSPl9ax8Bgu7t8Y91xGfy9xUtiZem7UTtje4kybbdBYOkLFyka6uzpMnsbREsooZ5CdvO0+7zb5sqQ05Y945EuF5lFGq6zDAXpMVCxEdzeCqCc6pTcGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744059601; c=relaxed/simple;
	bh=wYSLOOp0TOjp4/zVQSw0Y5VO1XzTYLndMukG9tcJfdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fh4OcEehX5ZtuE4Ppbgf4bEV09k8po63E8lh95pdideZvLrof93HMUCqktoLE2xXbiONVCwqe0W4atm6xVW89V669DAyowUXt7mIS+BTuWkZalvre/llYPsg1TDQcXB1fobW/kJ0N2NtfJVYuUd+l/1cKumdxyeMBoIQApJRAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IXAljZvP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b5jCa3gY; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IXAljZvP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b5jCa3gY"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id B24D7114013F;
	Mon,  7 Apr 2025 16:59:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 07 Apr 2025 16:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744059598; x=1744145998; bh=jb57mCcCsB
	bBR0NOoNrg10r2iP7lgV0Hkjun58Pk3k0=; b=IXAljZvPM1KQq1rRxyOcrmxXK1
	TMt/cuBGV7qpeDYIll22CtFcuX610bTxiJTo0zNoTUE8tjxg/NbjXQeZsFh1VNjl
	cEhFVOhCb2TAUccS0OBlzm/W8K+Q/rrtMPV7ws8RXHdf4NQufTHEVwj/HpJOYBZv
	ZyEW3OAySB8P0vb1v/0LYKIe1Bk40ir72fuF+H/lau6bTbdAXV5oOJ5muTl1YDjT
	uRpEkIkMvraMkOrPtn0YDKMdgi+Jc6gxVbCD9nWSoHRiWx5zXULHUrgwfnng+xJo
	gVCCa2RbKIydE4PjXLgvf/PFuey2NKod0gc62JUhxTENj8t0o/n+UbihJx1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744059598; x=1744145998; bh=jb57mCcCsBbBR0NOoNrg10r2iP7lgV0Hkju
	n58Pk3k0=; b=b5jCa3gYKp/FldOsWUBVYwCsmvX24FzzXMNa4v6O1das9ABd95e
	Ju+P/1r9CYiJV7Tcf15x5ScDbZnxHV2EOivwVbto9BEK6rbkXsudtuqU46Agqmil
	ujz61ET+yRtXwtN2aywebYLGbDqEkC53kPlq7B0NzJETOuVXbGWuKyTE0aTf3/R0
	N7tw3Z6V3N7iZIKilrPYjRP3ng7MVJyAkg6dsXBhryRxdlJcb3MAHcSLvy2rwCng
	Z0ZvE290OYFIPvIEZ2WPvcTNWEV3fjcMSrWEFxsMUrgw6y5j/aYa7djPd90oLoJi
	onKFmk/R5alo9uQGXJgRvnbVDb9VrTIA06g==
X-ME-Sender: <xms:zjz0Z3QjNMhaGT8E00fRYOq25oH6ZjET2m90Dds9scyW0jM0K2LERA>
    <xme:zjz0Z4xs86T5ksMRzNYn0LPmd4j0MUyhEr5CTD0mwiuRu_VjSlp1tdbYoGyAwO5HQ
    oXEdRHEbdMJHwhpDA>
X-ME-Received: <xmr:zjz0Z81Xm19TkYQw4QV2zcAqgs0BwhKvBAzfUjqudf9XX_DGJXrcWTRj_rPr2w9ZUq8y2FB2f1uTPNBEnxzP9ksU0hlTOvTWaAZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdduvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhtihhnvh
    honhiisehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepvghkvghmphhinhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepshgtohhtthesghhithgsuhhtlhgvrhdrtghomhdprhgtphhtthhopehrvghm
    ohessghuvghniihlihdruggvvhdprhgtphhtthhopehphhhilhhiphhmvghtiihgvghrse
    gslhhuvgifihhnrdgthhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zjz0Z3D85UEn70eTwc5MeK6EU0A51uZLxuJ_4YZXVGVpOxIVrpn0GA>
    <xmx:zjz0ZwjgPMOI_I2LuRyX1U2huPFFskWLHJwq94OZnGQcStuMSzgr8w>
    <xmx:zjz0Z7ovecouQX1h3zGWwuZBmaNuOzcIjFqu5uiR_j5bGrXxmJ82dg>
    <xmx:zjz0Z7j_j9RBejkFqEyvtw8PWR3ZGDwBNZm7TR7KSurBtSg4gCo91Q>
    <xmx:zjz0Z3w-wzAWQ2LmjncsYtdsdKUOdj-k2w-YXbrRJ2jbDXjSxXIalZDe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 16:59:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Git Mailing List <git@vger.kernel.org>,  Edwin Kempin
 <ekempin@google.com>,  Scott Chacon <scott@gitbutler.com>,
  remo@buenzli.dev,  "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
In-Reply-To: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
	(Martin von Zweigbergk's message of "Wed, 2 Apr 2025 11:48:01 -0700")
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
Date: Mon, 07 Apr 2025 20:59:56 +0000
Message-ID: <xmqq4iyzn0vn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin von Zweigbergk <martinvonz@google.com> writes:

> For example, it enables
> `git rebase main <change ID>; git switch <change ID>` without
> requiring the user to look up the hash of the rewritten commit.

I do not quite see why this can be listed even as an advantage,
unless you are going to allow end users to name the changes, instead
of using auto-generated impossible-to-remember hexadecimal string
(perhaps prefixed with a single "I" or something).

> If the change id also transferred between repos and preserved by
> a forge (such as Gerrit), it enables the change id to be used to
> identify a code review.

People often talk about rebasing and rewriting in the context of
discussing "change IDs", and for 80% of the use cases where a simple
single-commit topic is involved, it would perfectly work fine.
After making a new commit C0 on top of 'main', updating 'main' with
others' changes, and then rebasing that C0 on top of updated 'main'
to produce C1, you would expect that C0 and C1 are moral equivalents
so it is natural that you wish there is a name to give to these
moral equivalents.

But stepping back a bit, if they are not just moral equivalents but
record identical changes that are so same that an earlier review of
C0 makes it unnecessary to review C1, why are you even rebasing in
the first place?  Just merging C0 to the updated 'main' would retain
the earlier review made on C0 and things should merge just fine.

I have more problems with the remaining 20% use case, where you need
to deal with multiple commits.

Perhaps your initial changeset is a single commit C0 that is so
large and does too many things at once, and reviewers would
naturally advise you to split things up.  You'll come up with a
series of commits, C1_0 and C1_1.  The net effect of applying these
two patches may be the same as applying the original C0, but each of
them is more cleanly separated to address one issue at a time, and
the explanation given in the proposed log message more clearly
describes the issue each of them addresses.  Now you gave a change ID
to C0, and want to somehow relate C1_0 and C1_1 to the original C0.
Which one gets the same change ID?  Earlier one?  The last one?
Both gets the same change ID?

Or your initial changeset is a two-commit series, C0_0 and C0_1, but
reviewers find that each one of them alone is not complete, and
because the issue addressed by these two is small and isolated
enough, you are advised to make them into a single commit C1.  Did
you start with two change IDs for these two original commits?  If
so, whose change ID the updated commit C1 inherit?  Or does C1 have
two change IDs now?  Or did you start with a single change ID
assigned to both of these two original commits?

Quite frankly, I think the concept of "change ID" is nice but it is
not mechanically trustable.  Recording them in the trailers is fine,
but I somehow feel that they have a clear-cut semantics everybody
can agree on to deserve to be in the header part of commit objects.

