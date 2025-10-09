Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D0286883
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049667; cv=none; b=CU9RwCWLs5uCeKQHI/jN1OxfzyZhYF/Qeus7jhqzWKCDyC1b+BIrbqY4A27D/wD7Sm5hzF5fKosfZQmjNnKONdMhWJUO/xv6vD3JA1wChlJBhuN+Thz1wYGhKPGSCowsXegYu0iJkHq0n/4yZ/gfc+CTv+iasorfZjwtYQjAMH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049667; c=relaxed/simple;
	bh=p88IOaugc0PczzQNuubnAKpFcCus58Pb6wnV2CXwcN0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HyXH8YXD9IJqJVO5rMmmjy45SqYceNIUMiVJG9Gh3TdjBlOmv7MyLFIYKRS7CD6ykPodd49NZnlPdd94TqPp9qEzQ9vLX7g210T/HgFmz+iulnmqvjVSmnWnXuVwrCzP5lYQlYhUmS1aEBsEAbfOpJtxSSbzbC9AG+YkgA2HmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OyrgkiPp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j9dj3t7U; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OyrgkiPp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j9dj3t7U"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6AD30EC0272;
	Thu,  9 Oct 2025 18:41:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 09 Oct 2025 18:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760049663; x=1760136063; bh=Xr4JXnl3ns
	m4R4i3D0WIER3Q4sBC5j2WWUpAhHkrT3A=; b=OyrgkiPpWs5YCW3HYIVE/PMT3P
	CRdcF/fbPX/Szay1aGaw/y45+PyCVHH02DOfU4TNFfwM2td1NdxbIudVvfg+dt2O
	EGu7hPg1ihf1jdY84ev0T8mcamB9t51QpEs5aLKSNJU1gyzAfenhLedg5JfYUz3O
	Fio1nUEVdUdbLM4XnACQOZT1zm0On/OsWM7ool+b9dbXAO74uA9f2ZOnVVttLCSJ
	mBOeF4WYi/uwk8m88NK6HmUjqi+R6WmuFhytFqrEVNWPQznmDQMyZUd9QM0RkzV0
	bnWL57I+ATuuMm1GzoChs32/QOpfK6l/MHARjZjlj5gX7l7RRBjJgK9/ftnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760049663; x=1760136063; bh=Xr4JXnl3nsm4R4i3D0WIER3Q4sBC5j2WWUp
	AhHkrT3A=; b=j9dj3t7UtO0hT0YDl/iRRnkN1DWLOok3cVqgZ5RX8yRPY62sXeb
	9iKnqytP7ESJAFqdxquQwb0z4TwiKUaalTGGh8D5aZt7x4cXn/nMHEfBTLjxcwgj
	wIBiXq0h8P2BzHEk2Y8qKwDLUv6uB1AbYoI1C0ZKIiDsiiNRjY540dGnjL5KWkZs
	iwrBDJOMdYGtoeR4V9RPNK4xIld4SCZVbUgJ79+ZYjMB5sPzrL0fz57nLo6jP5PE
	OUEQHaJSLtm6n69QHNp9Pg4iB7j31bXJmotAQUvAhfPHtO6PlgF2nOnmeJCODivr
	nKFfixSQzfUh3/5JDF5+OYjZ0nSC7tocbFA==
X-ME-Sender: <xms:_znoaIycAd9oAvPMLWWdqicYuR38lLpo7XAFlCucR-4a2Eg9LxDZrQ>
    <xme:_znoaP-w1ha5nkqQNHcSBv3BGi5xmQr-HkWjj_JoLl5UB67qo-rwAXa3Hpb-sRxir
    73uzocN97iuFE9fdTGCN0vGE68yIZICnw_9H4heMO5M0bsKpAKTufE>
X-ME-Received: <xmr:_znoaELRRTIxXSbHpJLoW5XxWssMOLrqhqd8VjpWiutS_g4EmzfeNY3_q6y8nVptPZevGkGtGgFE8S_Uiallj5bBKEmu47OqYAua>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_znoaNfUgCpJrUMuAneqTrK3n7D-A7oEqAB0JW0zHWHJbszXkgl-LQ>
    <xmx:_znoaL-YvebDdpuR5Zu353S6Eiap1hw1iKd6-z3HrFqUkxSD70Cstg>
    <xmx:_znoaCrCOZfVxAVyPOa-YAb1YabAYyHwVHhanHyYrLyCTKt8UwsQbw>
    <xmx:_znoaIDeycC2r5AipcSkvRp4kqrUFD_vwA0L-OQ3lj3o4sjYObjnVQ>
    <xmx:_znoaKUBFymF0YA3kqJeMuozwZtrlqK3sKjeVBRKvtO2q3qvlR4da1HN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 18:41:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Chris Torek" <chris.torek@gmail.com>
Subject: Re: [PATCH v2 2/4] doc: git-pull: clarify options for integrating
 remote branch
In-Reply-To: <b432f1b9-804d-4249-bc1a-4f3629aff50c@app.fastmail.com> (Julia
	Evans's message of "Thu, 09 Oct 2025 17:31:30 -0400")
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
	<pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
	<122774d4cc8fa4e9184a0f82e9b6e562363ea433.1759951536.git.gitgitgadget@gmail.com>
	<xmqqqzvddqon.fsf@gitster.g>
	<b432f1b9-804d-4249-bc1a-4f3629aff50c@app.fastmail.com>
Date: Thu, 09 Oct 2025 15:41:01 -0700
Message-ID: <xmqqa51zd7gi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> My assumption was that the word "integrate" was meant to be a generic
> way to communicate "combine the changes in the two branches in
> some unspecified way", and that's how I was using it.

It is how I was using it, too.

> I'm not sure what
> you mean when you say "integrate" (is it "merge"?).

Not limited to "merge", but I view it more as between two parties,
one side supplies changes while the other side serves as a base.  A
merge looks as if the changes of a side branch gets incorporated
into the trunk.  A rebase looks as if the changes you have created
gets incorporated into the trunk by replaying them onto the trunk.

> 1. Try to find a different word that communicates "combine the two
>    branches in a way that you have to specify". I'm not sure how
>    likely this is to succeed.

I am not particularly good at finding verbs, sorry.

> 2. Instead of using the word "integrate", instead always say something
>    like "merge or rebase". I tried this but I found it a bit unwieldy, and
>    I think it might also be confusing for users who aren't familiar with
>    both merge and rebase, they might worry "do I need to understand
>    rebase to use `git pull`?", when of course you don't.

Very true.

