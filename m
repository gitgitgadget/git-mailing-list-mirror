Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7872E0B6E
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230538; cv=none; b=KnDjUh4vvmScrwUuFtiOhDLih4DCdRdLHPI2CoidABZU0hndKJtqlC3CbcAGQydMSYqpy7aLr4qU7T2e87UOTKCgQeCnuiU6CCh8MLP7/nR2YD1htIeDt1umggvO2QZ+1h92LZDu4uuopwvysF4CuMNHg0mnt28Gkqvp4k6muo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230538; c=relaxed/simple;
	bh=VnZSOisEHcAvtjaT5aNlFeBsjVeJ8UUpqRv9wsPzlkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sEfN++8gIAeMup9rSB5q8dPLDjvtdv/5VoPh+oHIpXqIxwsC5OGVKM9HNQwKlybNmbPGykG0SPSpHRf9ts35yZojBi+ddB6pFVtm8hBQxtfCcZum3xTkzp9HTXcxwAdx7c8UPb9uvsPZfpvu5KhhVhoA2OTdY5mQuj/+47ZX9VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cMSXdk/I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=at1c5aMQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cMSXdk/I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="at1c5aMQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D843314000B5;
	Mon, 12 Jan 2026 10:08:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 12 Jan 2026 10:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768230533; x=1768316933; bh=BhGRGiIzBw
	d86dn54rip5NQVVEBflgbLUNtG0A5TxnU=; b=cMSXdk/IfL2eb9ndoDzXJdFcAe
	BK76vt9oTrvknVUKMkYlAaDfB7TrxrfEmXmGH9QpvmzLg+roS5xTgOsPpKLYjVZR
	5lICilavRHgNlGFlf0Gw3i1TJahOWzC/Hl8wNbLGOwdZsqKfTV+1o2C3FcnJ98G3
	uZ+5VusL3tiHseJ9IdPaiGjzvTu7CihQmvDUggwN77JmhM3usAg8zkqRmjDsM79E
	WDqSKZlo75xZZoCGuypyWSzW8Y2YTT9k4CLs4g0OF6vrdAOY5qkvi8WlTpbwpAfs
	Xwp+iOSXB0Sub4OACFpmFSyZBbEFW0KgNlAOF8degkHs3xespPFkG/SSFjvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768230533; x=1768316933; bh=BhGRGiIzBwd86dn54rip5NQVVEBflgbLUNt
	G0A5TxnU=; b=at1c5aMQLCaauafbF/NxsX8h6I6A5U2/yO8TdofGaS+XYZ8tf4m
	OTh6ltHxE+Chos4JsVFs8Yf4ZgVr0N+vBY1gEkRnJ3YXtPl9FSUf74ywgTyZFD+3
	ECuL/sV+p0HrrYZTn55agPOXOTx+rx7yp8Fh2Gb3FZLBYEO/YboDrU+NumpXs6OG
	UjF+bPk+uPAJSgkHBrWNkIMfuiKJoZswOlyA6noOEMBeaAlPRzJh3GZtF7khyn6j
	I705BfaG6GmovPd5siTDFNHzomK5wGtqFXuasiL1lXkLteFgqJKfNIBx67dVCmTv
	bz+NGIotPax+JAs86+1V8+Ge7XXMGDy9mbw==
X-ME-Sender: <xms:hQ5lafHPSAkmMvywqke_emO0Rx_OGBU487tYsRg46COWQoQBYVnmaw>
    <xme:hQ5laSuOaWF1EgWlmWzFa37EuanMw5mIeF9sEBe1Wj37WykXHY3znChUP615Vn7r_
    HtzVHwWQODce9Wyws6h45MyMvZaUNoAm1yQByfHpZLlpRfwUfWokw>
X-ME-Received: <xmr:hQ5ladZLQCYxLN7k5vFPv3CYPtG8LpLStuZm6AKVz8W55P-aSdPl7Xyac5anxaR6AIooZYOFkfCCzQSMM9ycULmOwnX_AcccwE6YkDE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehmrghr
    thhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:hQ5laa4tOPCHDKrdih4yi-1z-iXOIxaNf80tz3Fh4SkORHoEqK_yBQ>
    <xmx:hQ5lad_RR1pxnH4fD0BSF9dZMzXXSDPLgqweaT8PzPUfik-StYVohw>
    <xmx:hQ5laeYBYeCYRkO7-HIiunkeJIaNyIFkzN73zKm5DSNEpQqLcPwS9w>
    <xmx:hQ5lae5V-F6noWlDztpEkYybRTYjgcZSrT2Oq-L7qSn5sxxbtyV6PA>
    <xmx:hQ5laXuUgb_1S8AtmFeEd9cg6LQ3cCJSqXM7RQ4fx4Qhj-CLTCX0YiEy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 10:08:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Elijah Newren <newren@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v10 1/8] builtin/replay: extract core logic to replay
 revisions
In-Reply-To: <20260112-b4-pks-history-builtin-v10-1-e3c6aa5b4cec@pks.im>
	(Patrick Steinhardt's message of "Mon, 12 Jan 2026 15:15:13 +0100")
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
	<20260112-b4-pks-history-builtin-v10-1-e3c6aa5b4cec@pks.im>
Date: Mon, 12 Jan 2026 07:08:51 -0800
Message-ID: <xmqqv7h6na0s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> -	die_for_incompatible_opt2(!!onto_name, "--onto",
> -				  !!*advance_name, "--advance");
> +	if (!(!!onto_name ^ !!*advance_name))
> +		BUG("expected either onto_name or *advance_name in this function");

This brings our crypticness to a whole new level.  onto_name not
being NULL is a sign that "--onto" was given, while *advance_name
pointer points at the string that "--advance" option has received.
We are saying that only one of these two must be non-NULL, and the
other must be NULL.

I know !!VAR is an idiom to turn any pointer into 0 (=NULL) or 1
(!=NULL), but isn't the latter (i.e., normalizing all non-NULL
pointer to 1) a bit overkill, which becomes only necessary because
the construction wants to use "^" as "sides of this operator are
different Boolean values" operator.  And then to add on top, the
whole thing is !(negated).  I wonder if

	if (!onto_name != !*advance_name)
		BUG("one and only one of --onto/--advance must be given");

is easier to follow without being overly cute?

Thanks.


