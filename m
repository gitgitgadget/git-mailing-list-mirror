Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7B71D90C8
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649078; cv=none; b=Lzs/GP0+f19iJkiHRMpp/31/WUhfzZahLkt83aSC9HYhvZ4ag3bqu9DI4cBQCL33VKWcdQ+/UKeaPloeYm6S8fWOF5Qx5KbAtGSr9WBAgzbz0fLmupRBpetRv4ujS82H1iKueqfhJzzJN92chKYPXezR/07/strx8Vp/LBt/h5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649078; c=relaxed/simple;
	bh=b4b2XpAl1WThBTyX7gGtX/kV8HRW/Nla76isQCFbKLc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=padHqLn6sxqwbo113MNfZ+UXsGRm/9wBiBOoKbKo07GTUuny3Iq6cqsHbEZ4I6fcNLRlyHoh51H2PbZ2Af3oLD37yS2nSLYqYhtxYYAMyA02lA6HmwXEdIhPye1HnMLWjE+ZBo8ZzT6Tefcz6vDRoDlaxo1pWcS7ZXCB3Fc/HsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=T6/UGU6k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=egEJh8uZ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="T6/UGU6k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="egEJh8uZ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96AB31400034;
	Tue, 23 Sep 2025 13:37:55 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 23 Sep 2025 13:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758649075;
	 x=1758735475; bh=N/F/eH5eF1T6dL/Et7a0TNL8whNse/ygsr8JokMvBJg=; b=
	T6/UGU6kRmwd3YZpBo78rhwQzA20+LiecCYJV01RW5QNGK2KTxGuHdCwwdB/lj3q
	OvXEYB7a81Z7E1LCw0dROOS4C8RO991+LMOlw0RFVRYbGbbH4Jd6uIjfzGKjGaxe
	fhNljE1tRQ/BRUdQSdeextLg60/fd+049tKSP8EsxZbuVTlJuRIlEDsNDeRsYUuh
	qibO0Rsvklu5qpWdl+PtPFF1aKuRGMcS/7oF6IZHcMk8WsS7AE0xx4gXytkH00ly
	BRuxtS3dMh1lMgkzPKK3gmkfairOHyOeN99iDDS5nALSQP1eSoUBj4XW1ex94mKa
	Lk7d0Rtdqq8mxeGq7oou8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758649075; x=
	1758735475; bh=N/F/eH5eF1T6dL/Et7a0TNL8whNse/ygsr8JokMvBJg=; b=e
	gEJh8uZNpC6FYmn0hafGlmAxjxKG9CV+h1Jfv2c0nNuHbm2JTH92hoeM5gRGLC9s
	tjLCX9/PNHx9Usr7WVq2lM9x9my3GS87b07zVMrhsl70/utu9ulWgWnxmnZGqaai
	9/juGz6gbgGInqpQuDSrFY/ROTrJWmoWLJScX9Bk9mHCIe7Z3RTwZxkiIixrIYpf
	MyKdsa985LgAsyBBJykwQg/YEV7lxG2vs0ZKfOOxw9qC3eLDUb6Y6StbXdAkviuP
	aThw08vs2tgcKPD0PhYEpOC6SUsX6urst7sQyo+SD84007gNYXSgWtM4tpAlc0a3
	HhP0upW398crC7Ee7Ixnw==
X-ME-Sender: <xms:89rSaIJc-4SfNAmJ_FFEzjHxy-cBb2QecB3qXAl_FsUkA5zHh-anav0>
    <xme:89rSaC8DilNQqDoVoxQsnZrxX5k8kt94mFGSMLXNjeUpFr_5QNVcLs04jAvGT9e-v
    lIo0kcXVDM76Uc-nosOrkPTEdjDl-kV0WsXm4SRg4s8CeIGeV9-Hm4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepmhesghhithdrshhtrhhovhgrrdgukhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:89rSaB3ghd2zwtqWaUovj9h9E34Fcu8oODltjg4NQXRACFaf0h05zg>
    <xmx:89rSaO9gQ3WIPmZN1gMtjcvaUb7YegtMkjbDBbNa1KCxhvsmSL6VNg>
    <xmx:89rSaKOSLbg7_f_4YQ4dk5GeVFbiwySJDOYUCYRf1eS-TqiBlXeduw>
    <xmx:89rSaKcLC2uP3eDHuqkhSsSX3WM0TI1XTZVLpKxdzkgb7T-MaqlTMw>
    <xmx:89rSaD6qX0b5NjcNm2ASlGahyhHbmdmahjWA0zYev2BKLM1b_UI7VFGG>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EE2031EA0068; Tue, 23 Sep 2025 13:37:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADSuoCYrCBSs
Date: Tue, 23 Sep 2025 19:37:34 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Mathias Rav" <m@git.strova.dk>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <4e74c0c0-11a8-42bc-a229-196402628b7e@app.fastmail.com>
In-Reply-To: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
References: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
Subject: Re: [PATCH] rebase -i: use same commit's message and date with f -C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025, at 10:55, Mathias Rav wrote:
> In `git rebase -i` with the fixup command, the -C flag controls whether
> the commit message is taken from the previous or current commit,

That=E2=80=99s also for `fixup -c`.  With `fixup -C` it just also does n=
ot open
the editor.

Maybe this refers to how `amend!` is changed to `fixup -C`?

> but currently the author name, email and date are always taken from the
> previous commit. The fixup command is used to squash two commits where
> one commit has a good message and the other's message does not matter,
> and it is usually also the case that the commit with the good message
> is the one that has the good authorship information; the other is a
> fixup commit that was presumably made by the user moments ago, whereas
> the commit with the good message is the one whose date should be kept.

I think the rule from the manual

       If you want to fold two or more commits into one, replace the
       command "pick" for the second and subsequent commits with
       "squash" or "fixup". If the commits had different authors, the
       folded commit will be attributed to the author of the first
       commit. ...

is simple enough.  Adding this exception for `fixup -C` doesn=E2=80=99t=20
make sense to me.

Why not use `git commit --amend --reset-author --no-edit` in
that case?[1]

Granted using `fixup -C` is more advanced interactive use than what I
get into.

=E2=80=A0 1: On author date: I had a commit from the first of June that =
I got
    back to.  After rewriting the commit message and adding more things
    to it the author date still says first of June.  For better or worse
    this is apparently the =E2=80=9Cnormal=E2=80=9D baseline.

> Most of the time, a fixup commit is made on top of the commit to be
> fixed up, in which case the rebase -i fixup command is used without -C.
> The fixup -C case arises when an earlier commit in the branch is split,
> leaving part of the commit to be squashed into a later commit, in which
> case fixup -C would be expected to keep the date on the later commit,
> and discard the author date of the ephemeral newly split commit.
>
> Change the behavior so that fixup with -C takes both message and author
> from the current commit, instead of taking the author from the previou=
s.
>
> Tweak try_to_commit to allow specifying author in addition to AMEND_MS=
G,
> and pass author from the current commit in do_pick_commit in `f -C`.
>
> Tweak the help text in `git rebase -i` to reflect the changed behavior.
>
> Add a test that ensures that the author metadata for the second current
> commit is kept, and remove some author metadata checks from other tests
> that now fail since the author metadata is different (as intended).
>
> Signed-off-by: Mathias Rav <m@git.strova.dk>
> ---
>[snip]

--=20
Kristoffer
