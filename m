Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4257D2E62C8
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766259303; cv=none; b=hH7as49Ssep+/QDWfLCT5EsRMtAhWt/8NXRzzkTtB33h+7SoDfRVCA/Lp+jJ95O4bMJP0qV8CbAX/+2igTW/dqbCUea5C3CvtcYui0YO4ElsNYOToB/hrSyz8tsjiOCilP2H+rWsmug1aOi2srlcW+9+1iUb8WKj0CKwo91h9qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766259303; c=relaxed/simple;
	bh=ytrD+gT8NiuAScRYY0gUYjwmEqDlcihQNPsppBCpnvA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jmqU1OSIhGMcF9q4iS0/9erwRRrAJMSvzJkSkb7r361CZutXOWHOBV4n9hwIrOhZ/6Kw7c4S3f2rxZ7IfPYCDECf2hHWgl1K0geQtlv8kQUFC9+bsGRzTJNwYQmZj2g6mXF5KJ4s6W3unABfGlc8nxDdtKcwYm8kiJ9t8EQc/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LCWfN2Dq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sp3RhiXq; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LCWfN2Dq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sp3RhiXq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 13610EC00CF;
	Sat, 20 Dec 2025 14:34:59 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sat, 20 Dec 2025 14:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766259299;
	 x=1766345699; bh=BiI6PeeGRenVx8zTGaATzDEfGhZwVm8FJB/3/uIHXHY=; b=
	LCWfN2Dq7cYN2QjOFW5ISuQla/q9SDif7RZjX/Onwov1G3vZCE4SeyFSwV1jU79m
	muUXlpy/ZJZUDdphAIWjNDYzYfsvs7bKWIGyY+poHHeonRa/EYZGV4lNG6EegWjr
	rkptv+Y2ITz2KMYoFyvOwBw8mE5qYA3D2rqJbjq9z9+vs9lcrWfSEGuS52r8Q0Me
	vp8XxZ0YfH1de2m75V9mdyBv/y7wjsIUZVkEjsxIMp1/P1o0Di7ksnW/rcLDQHpl
	3Zt1SHa9rQDDr8V2SrZV1WeUS3CDD3rFeOddpPZFF27QhTR2QLrg5GpnAaalxdVK
	cfRyweJbBG5wJjJVcXBAOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766259299; x=
	1766345699; bh=BiI6PeeGRenVx8zTGaATzDEfGhZwVm8FJB/3/uIHXHY=; b=s
	p3RhiXqIzy0P9shQq8gljKRHH4yKejqn/K6Z6en6mfpqEjzwLDm+owHAdWr4yCbC
	hz2szfYmpIhku8WMxRjefasPl/T39fEJZpDhU5xtRbJo0gMpJJcoGWrFYisQykG9
	Gqm+IACIvUajsYJvxSANFO08p5pQzflKwE1jVP8460Rs7HrmhIwSU8dGsukHoVx0
	zIwyENESnkYfLP/1p74wKmM8aqpMDcyeAB6J0GK68YqtmQWb6tjqOU5FJJ4Dddrh
	iqzY+XXPiz3Fgr40uG/CRHEwUjTlpV9r8oW2V8G72wUrRXpBsB6bsHioXtdG8ISa
	yRjUjdnkdrM5ma9L4qA9Q==
X-ME-Sender: <xms:YvpGaaS_J7_dm6EEg5gDTAD52UIFrGN1PZz3X8U2kes5qJZJqeY7g4w>
    <xme:YvpGaanE2NjOckQ2Vg4ImW146-D13x97gtAweL64iAwMA-LLKsA4Mk5nkoOgYz-D8
    lTHMyS82GzQrReCTQKvwELRjILAe7GBNtEIFKkrz_4y8T1pOCrMjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehvddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YvpGaSRIGQMWAixv8ffSIdZSTgKlDM-ffuw5jaUv6pArdMrd5P1o9w>
    <xmx:YvpGaSsu9FDpx3XfZKXHpWsJQBnrMTmqpaqMnOE44xInzluP7ibTZg>
    <xmx:YvpGae3AHsF7IUPg8y0g4YRDtYymIe9iqU7S9c1zIAg-nUmWoovnsA>
    <xmx:YvpGaTUXtzpKtS8ITU4eCQUBc6n7GpJ3yoPSRKg0EJEwxURBstJAcg>
    <xmx:Y_pGaasdXD0i4DLp_OV_UJ3iXXyUJvG_j__d1-N_iaFzIkKJj8Car2K1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6E1E21EA0066; Sat, 20 Dec 2025 14:34:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_-Iu8LU1e_w
Date: Sat, 20 Dec 2025 20:34:37 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
 "Christian Couder" <christian.couder@gmail.com>,
 "Elijah Newren" <newren@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <8e7e09ea-190b-4df6-b013-733334185bb8@app.fastmail.com>
In-Reply-To: <xmqqa4zj6zhv.fsf@gitster.g>
References: <CV_replay_conflict.101@msgid.xyz>
 <V2_CV_replay_conflict.12f@msgid.xyz>
 <8fa21ce8-1e02-419f-b82a-0e4a41f7e2d8@gmail.com>
 <bf3f3633-5d0d-4fa4-9706-d99e32a3f91d@app.fastmail.com>
 <xmqqa4zj6zhv.fsf@gitster.g>
Subject: Re: [PATCH v2 0/3] doc: replay: improvements like "mention no output on
 conflicts"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025, at 01:29, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>[snip]
>> Thank you. But I=E2=80=99m not glad that the commit message is not cl=
ear. I
>> would need some guidance on how to write it because it seems clear to
>> me. Something with my brain state I guess.
>
> They are already in 'next', but let's see if there are pain points.
>
>[snip]
> commit 03d7c9c457ba68f28269dcd607b9026ea6c6c9c8
> Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
> Date:   Sat Dec 13 14:46:57 2025 +0100
>
>     replay: improve --contained and add to doc
>
>     There is no documentation for `--contained`.
>
>     Start by copying the text from `replay_options` in `builtin/
>     replay.c`. But some people think that the existing text is a
>     bit unclear; what does it mean for a branch to be contained
>     in a revision range? Let=E2=80=99s include the implied commits her=
e:
>     the branches that point at commits in the range.
>
>     Also use =E2=80=9Cupdate=E2=80=9D instead of =E2=80=9Cadvance=E2=80=
=9D. =E2=80=9CUpdate=E2=80=9D is the verb
>     commonly used in this context.
>
>     Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>     Helped-by: Junio C Hamano <gitster@pobox.com>
>     Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> As to the title, "improve --contained" hinted me there is some code
> changes for behaviour, but there isn't, so that part may have been a
> bit misleading.  "improve short-help of --contained and add to doc",
> perhaps.

Oh right, of course. The original area was `doc` and in that case this
would have been fine. But I didn=E2=80=99t consider the `replay` area. S=
o now it
looks like the `--contained` option logic has been changed.

>
> I think the problem people found in the second paragraph is because
> it is so unclear what it is talking about if you read it without
> looking at the patch text.  You started from the existing "advance
> all branches contained in revision-range", taken from the existing
> short-help in replay_options[].  But without seeing that "branches
> contained" text, it is natural that readers find it hard to judge
> the validity of "But some people think that..." claim themselves.
>
> If I were writing this (but I will not rewind 'next' to do so),
> I'd say something like:
>
>     replay: improve the help of the `--contained` option and document =
it
>
>     "git replay -h" explains "--contained" as
>
> 	advance all branches contained in revision-range
>
>     but it may be unclear when exactly a branch is contained in a
>     revision range.  Because the command updates a branch that
>     points at a commit that gets rewritten to point at the result of
>     the rewrite, "update branches that point at commits in the
>     range" says what we want to say more clearly and concisely.
>
>     The "--contained" option has no description in "git replay"
>     documentation.  Use the improved phrase there, too.
>
> probably.  In any case, it is a good exercise to see if the proposed
> log message can be easily understood without looking at the code
> change.

Okay, now I get it. It turns out I=E2=80=99m still learning how to write=
 commit
messages with the right amount of context.

And thanks to Phillip for confirming.

>[snip]
