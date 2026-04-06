Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99835A385
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497751; cv=none; b=cxmej3V548dx0QGu+inb1Zjgi7cAUFL7QsgIuMxqdmUoQxXrAQ21rNlm2PIKQd+yfjC4Kq1KDWSCV1C2sdcg6hy7vHaf3MzdPhWN/ZMccB1rkselLV386kYsFoWjbY1nr9uCs/T8RxlTs9SpgT6Jtt3rXcUNrivHTl58DYg5D9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497751; c=relaxed/simple;
	bh=zrqPAIswThkNHPqz9Bi1Xb6I9vlQ1ESfLE5g6m5h0OE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pvoHUAYodXMDprnc+HgxzFg2EMfqAUFcbMY7YfX1teafWzs7pyiEmti3ZbLpBo8UV0H/9J+/hpKGy30mkmKtiOZQR0b4pCZjdEXPQaRN5qbbLPnyMYvSDHKDtq3/hobtw2WB5W7vBT7sLDDBmVf/xvMmQ5H978xPRHH6NSqeHVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FXFTWni5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GZeH5QVl; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FXFTWni5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GZeH5QVl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A3EED14001B0;
	Mon,  6 Apr 2026 13:49:09 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 06 Apr 2026 13:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775497749;
	 x=1775584149; bh=b86io1xjHyPEKlcPByrMtsAmQs1udt+wmc//9P2VaLE=; b=
	FXFTWni55gC/tVoULmT/QH+BmurFpp3KMm5qC1Gt/OO0te1jaMe2Th+IKmxvlGuy
	JTpDC8ZjHzbWGoN6J7JJ3gROERCUJhclx0LEPRS9WV2WO7BTV9QWDlnTu+FrQ18V
	0Xiycdwf0i+K2ssLiOL3qI0Qegqmh712X05/bVcUZ0LU9aiqm9hupO8v15jEufkf
	hAURde/j2nO5BLCRrOOVJv4UF0iFoRIWW9USg0WjO2kR+Xr78Hwev0y6n+ofidHa
	oQreEj7ymFMGyZpC9Tpflg37rdQlKQtShzpE+Q+mHs+or5pFMNXSEQZKFG+6LOpl
	DBKZLxrLtRaQH5Aq8sw23g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775497749; x=
	1775584149; bh=b86io1xjHyPEKlcPByrMtsAmQs1udt+wmc//9P2VaLE=; b=G
	ZeH5QVlJLN2unWw6ttgTDyFo6Rdp7ywXyOE10zaKNLpxPbLsQKenvqGTNmtxYRt8
	6AVFceJzWst7sP/TFDGSRQKeO4nrXD4+fsSqT0opDep4SSx1bOTtuMDvlQ7VOeK5
	p/Xb0IJB6p1FQXjJSJbaSG8aLK2NAlII9ritk9AP/JQ8l0hDxI9oe5ts7g/AOrtL
	NR8q0iVU4WgfIb/LRXNeWVtpt/Q5Inv4pgmoiEKRCkVmDNlslYBmBAVJkL/fx5cd
	tQZnM81xyBejxVR2r8ZHhsxvy8LX7j2KghXfHnHvmAhl0WfiTcAbV1rR9FZY3bXH
	opanvWV8S873GmGqlyPiA==
X-ME-Sender: <xms:FfLTacFqbij9dLE9JHra1uvMZDMYD51Nytmh319Ouw0vpdosSnp3ssQ>
    <xme:FfLTaQKuZw46PQbnKFYIrhbvgxA4HyjEGEmYhO9l4qT6-u-yU2qEd5SNjs8dCrnCj
    iMuXmBwIpbEmjziW-H6t5Kw47xceUEKUJYJBCm6wECHaNK50zVQiRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefhvedvfefhjedu
    gfduffeuueelhfelhfdufeehueelveeuteevtdffueefjefhffenucffohhmrghinhepgh
    hithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehthhhitggrnhesth
    hhihgtrghnrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:FfLTaVDKcxoqPQTr2QotH1KtbgxqiAckwgvMNDsawQRS1AeudPelAw>
    <xmx:FfLTabSHmxWOqaveb1T5oBuatBUixPIqHpYosz21LSxvzHRRp4vyoQ>
    <xmx:FfLTaTr7dYuG8ScOn4sznDaIUzC4XIziKvThQDNOsCcYMLIWVBo42A>
    <xmx:FfLTadyU-1APDcjyNo_q4gEQjOVfc6qZtlRDZ9lts6Q_V7bFpJI93g>
    <xmx:FfLTaQgAnZd62apqZYTzWEYIdDcV8sIwodfhU7FHNZZp8L-EHPjbvlbS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5EC461EA006B; Mon,  6 Apr 2026 13:49:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AB0u5Grf0JAw
Date: Mon, 06 Apr 2026 19:48:49 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Thibaud CANALE" <thican@thican.net>
Cc: git@vger.kernel.org
Message-Id: <f0276575-9c75-45fb-8fcc-b465619d1b97@app.fastmail.com>
In-Reply-To: <xmqq7bqkcah8.fsf@gitster.g>
References: <njuf62lav6akkmdyqutwk7pim5yutw5cuicjidwpe5eh6qnkqr@4ir6q4uhhvht>
 <xmqq7bqkcah8.fsf@gitster.g>
Subject: Re: [RFC PATCH] switch: provide configurable detach
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026, at 18:36, Junio C Hamano wrote:
> Thibaud CANALE <thican@thican.net> writes:
>>[snip]
>>  3 files changed, 46 insertions(+), 3 deletions(-)
>
> Sorry, but I am fairly negative on this change.
>
>[snip]
>
> FWIW, "git checkout" that knows what is and what is not a branch
> name and does not require "--detach" when detaching to anything that
> is not a branch name is always available and will not be going away.

On the one hand, I personally mostly use git-checkout(1) because I never
use it to check out files and I like the detach behavior. So from that
perspective I don=E2=80=99t understand Git users who interject when you =
provide
examples for something and you (incidental to the example and point) use
git-checkout(1) because that=E2=80=99s what you are used to. And they in=
terject
because git-checkout(1) is =E2=80=9Cobsolete=E2=80=9D or something and y=
ou are setting a
bad example (or something).

On the other hand, the BreakingChanges document does call
git-checkout(1) =E2=80=9Csuperseded=E2=80=9D.  And in that light I do un=
derstand why
people want to actively avoid git-checkout(1), including implementing
replacements for all relevant checkout-use cases in git-switch(1).

    Superseded features that will not be deprecated

    [...]

    =E2=80=A2 The features git-checkout(1) offers are covered by the pai=
r of
      commands git-restore(1) and git-switch(1). Because the use of
      git-checkout(1) is still widespread, and it is not expected that
      this will change anytime soon, all three commands will stay.

https://git-scm.com/docs/BreakingChanges
