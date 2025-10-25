Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FCC238142
	for <git@vger.kernel.org>; Sat, 25 Oct 2025 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410137; cv=none; b=WFPVOIaEFq/u5WfkC6FR59HO8MIc5MSx5SV+MzUfTCRVgW63r8wEI6zJ28J0e6MWRh4Pk+ONHVRX5TFTQs3WufN7l7B94XoW15c4cSF6qGpf4CWmuHonUAQ7Kwa0rCnYN79LjZoHem5Qx133xZYQ4gvzv6be6/T0yw0HxjW7TQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410137; c=relaxed/simple;
	bh=o6nZFG7VwowFVsEz72DJtbjBjHqTtJN+rqBRRWTFrBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LgUGn1MDfB9bF+DGro0RHyuZvhFZ/rxJIFiEfhWIl/TL8XXjkDUaO2bg/ARh4kQH9MPQtkX6aoKqIGBwzHoDMuak5PGRdGT0VacdZt4oxner75PtsqggYN55Uto+KmZ34LfIg5r4m8T/iDj1Ou7gd78nPGa06CJFHPDUxrQbkUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cO0F0XYk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ccO013GV; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cO0F0XYk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ccO013GV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D163FEC0278;
	Sat, 25 Oct 2025 12:35:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 25 Oct 2025 12:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761410134; x=1761496534; bh=o6nZFG7Vwo
	wFVsEz72DJtbjBjHqTtJN+rqBRRWTFrBw=; b=cO0F0XYk/DX9jAC4YEF5jas6LM
	syHNOQ4jlkWW5v56cXVLOcB6L8O7wO7KmlRwLSqaCQwtEbCsmdP7+bNQHjjlDgiE
	v9YBKvyAijPOCJiDl35Nx081BFQyLh+aQrAvZbqfD3bqcgRzC6rp3dgYmGQWQfqN
	wb0eAKFLU8RtlhvsExhc5BRqmOvgynJKj5F9Dqu9/09QxiuIlJ87v23NZbk9Q7Nn
	7SGAQAtpCKrYGfrRXqkbA12UcTEvYCARKJ7d7EEFFPFwdJuBkBLzwXXvJ2ZGkkTB
	JHmmCDyMLF/E/W3Lino42wAXt+2AQvmaojnvN2fgKUM6Sg8nxIXD5DSRpNSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761410134; x=1761496534; bh=o6nZFG7VwowFVsEz72DJtbjBjHqTtJN+rqB
	RRWTFrBw=; b=ccO013GVzfCbRk2GxYMlLjZJ5iglZCf4nO0OVCNzRme6XPZ3bqV
	wQ/Ho4tGUnBxTmJmwob3p9vb29A9fin4oEWHtjxSdV5F55NfXnqVC9gPAbj2zJzV
	8Eo4EAtLEViMRxXPIjl5FdulGaG3NkSQg2PgF66uSmLrE7PFsomDUi+kTw+6aDe4
	bXwvyJUghJQm+S5M6FjZzvEAerReHqk4CnbhTHdGxD6MI4ogOxOXfd8d/09DBUIJ
	g7oYiSshk9cYn0hJTJsTFn3i5g4p1fp+1m/bCyTprz3DamWFyg9gO/dBbVhc3V1x
	CFPqOtaxrJ57SDq3g+m4kOP9qqA7gIZmFHw==
X-ME-Sender: <xms:Vfz8aFB-qbhAZ2gu5bgkYFR1KwY3_iOs_vuR8GCYjgBpXGT4F2pQGg>
    <xme:Vfz8aKholRxUzOpgwkbuoVv7OIXZ-2cffMBMG0C90PI21jBbaRif_1zfF_ybgvAEv
    e2FdB4u0r26Y1GTfPcPWq-xZSC2cZ0Ab51lz86ZDtYKonIqdQmuSA0>
X-ME-Received: <xmr:Vfz8aFmNbgAqvBEwCTIt8T3TKLREagKzFGj1d8Krd3dVBTv7GFgTygAiS0tRYxXpOOJ2mIRnwzkgyqWh0KuBevywVFY__eZmMSnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedvjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepuggrvhhiugdrmhhosggvrhhgsehmvgguihgrthgvkhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Vvz8aOoyPNfr8ZZKFr1N_4u4dTcK1SPtL0Ai_GM0K0Hs82l9iIBuAQ>
    <xmx:Vvz8aGEfWUOHtvXsm3tkZQyptc1Ycx9gR9FKAjpovZ2W0V3bliZShw>
    <xmx:Vvz8aCzQJRlEe3IKh_qAaCIqnIbEqa1mlaVzOYyCGG_9QrfA6Y_Ayw>
    <xmx:Vvz8aDo-nEbdJp0wNj5Ni3Qw7yzb_oeAfNEz8ZeZayHyNkwJnkOVaA>
    <xmx:Vvz8aAmKxhRsTnA-anHkGNeLY0O5Yv-72Jqk1djHyP56YeTxbWoutecJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Oct 2025 12:35:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: David Moberg <David.Moberg@mediatek.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: git log format documentation/manpage
In-Reply-To: <CALnO6CBLUGgBMeRf0uLA=TKVaMQvap9Wpa4uTAGQD5he40xeWw@mail.gmail.com>
	(D. Ben Knoble's message of "Sat, 25 Oct 2025 09:42:03 -0400")
References: <KL1PR03MB5748DE5406618053D0A6CE0AEBF1A@KL1PR03MB5748.apcprd03.prod.outlook.com>
	<CALnO6CBLUGgBMeRf0uLA=TKVaMQvap9Wpa4uTAGQD5he40xeWw@mail.gmail.com>
Date: Sat, 25 Oct 2025 09:35:32 -0700
Message-ID: <xmqq4irnndm3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> I don't have the answer to everything, but for your goal, does
> `--oneline --notes` not give you something close enough?
>
> Since notes can be arbitrary text, making them "inline" with the
> oneline format seems like an uphill battle to me.

A commit log message is an arbitrary piece of text, so we gave the
distinction of %s (subject) vs %b (body) to allow us to say "%h %s"
to show only the commit subject.

There is nothing similar for notes, so in that sense, you are
correct to point out that only with %N, it would not be possible to
come up with universally good formatting, unless you somehow control
what you write in your notes (e.g. limit yourself to oneliners).

If the rumored unification of format languages between "git log"
family of commands and "git for-each-ref" family of commands ever
comes, then we might be able to borrow conditional formatting and
text manipulation primitives the latter may have in order to do
things like "show the first line of note string, inside a pair of
parentheses, but only do so when note does exist and not empty".

But until the unification of format languages happens (which as far
as I understand nobody is working on right now, even though I
vaguely recall it was a topic in vogue for mentoring programs some
years ago), I do not think it is feasible.
