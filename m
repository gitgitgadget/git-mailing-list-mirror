Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260725D540
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648594; cv=none; b=rchUrpw4rKFkN0+yK+o77dp9JSOUSIVBQ6knl+3Z6R8vg6mUvxacX/oAj86x10KKtqucCaAzUcLm8Jshpq2KROxo5FazS+w9tqR008/P8bSvmhU+kcHuhOYnXSP1Rj/xchp1HTe3Ex2AUrOAvxfv6uyEHRd/vNjsWO0bkOX3aGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648594; c=relaxed/simple;
	bh=YU5dfrHGhab5mKyfX2TQkOPgBxnoQgGaCfyTzYHWmfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WBzNW4WDXI4KdJLX780j+3DaZsuVP5OzeXPEj9SdXC/Iry2N0kXTYzwR3NJLqceaatgzO6RJ/KyFstECtABr0ex1y3HklRrwe3UUfsoIa7TfVzkoSFyeuCP48c90M7MVctiuuGF+EK4lKKd1UwD+mQfaSAI0RRYqnye8bcHYv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nLCU63lf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H1r5i3s9; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nLCU63lf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H1r5i3s9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 753B81D00343;
	Tue, 23 Sep 2025 13:29:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 23 Sep 2025 13:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758648590; x=1758734990; bh=aStgTJ7s5+
	9amLfim+YlYnX1jFJyDsqrnplAVeWntQg=; b=nLCU63lf2QE+myq8LzQT+UoLQI
	6es4LVpmzz16OOrAjR4rKgWaIkP9OI3wL8VlMx69jKTD3goV0PEeZqRUmbX6tp18
	K0ADI1dZ1c6tj0EVvC5nBHtT6NirV0JE0JIYbDeIHS+Ie9NXtA2dX/gJedkrNaIe
	NrmMnTz4aTRcsglIoqajJKf+gHLDuur+P0jfa07IjOE0z5m4fySgASiS6zOYsfcG
	fQlPVhowjZPmLZymJl6wZT6Gzg1YyTto7rX/zT0I5YiNuX/Sx8s2wncw0TxssIAh
	0Yn2I0LT/zJCCCEP2Vyl62gB92MV0OgWUOgJIK3k1lPLFmHwnBQRDvvjKDhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758648590; x=1758734990; bh=aStgTJ7s5+9amLfim+YlYnX1jFJyDsqrnpl
	AVeWntQg=; b=H1r5i3s9o1uaTXSdHQYvRRq0GxDYaMsjqnXfJKQv1g7ybVwRIcF
	HlIkVq2JJ8WqSGHeypNsd+Qtq+zICcwMX4gS7RThQ/FxAA/qHqaBf5fKhcdz3MMz
	6A9zcQ+B+w6YimsHUDb4VPQxvpg5QdVRtnJManSUXFP/xMX+k7L6rU0TiwE4h7XM
	pcMDsZRh3VPZXOrpGEtscrzSUODHIetZ9lrQXGXP2sW5yeLP6Mp2Itt8PzC61t13
	m8U9gYomm/TEQJwmf5zSuC73I1N2aLlxlNMX9wkU/gS/nnLntAGT6erkJW6xPOKa
	03hdno55eL1TxOtBpKmS4fmb/j/DkFqYpmQ==
X-ME-Sender: <xms:DdnSaJKYoE4QO_BuGxOZ1e2Su7LapmRLIMVXd0mluHsadjA3kiWvVQ>
    <xme:DdnSaAA-CHwiFFEvIgDucBucWaQlzzq9mu5aVsK5vlNZfywKrt23kqtuChmKZuhTu
    6wMf74y-WQWWG-vE9Bv_KLDzAkIgBJKf1eY8yr2WuapNsGB1cL26w>
X-ME-Received: <xmr:DdnSaL6xnDBJRhkUsUp20tAhdtGHM3YamEitX0ev9t4-wDtAMs5e441lABowFUZdVwfmKjFxugRCnHHBlY1JC4zGuonv5QcQ9N3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedujedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnthgrtghtsehhrggtkhhtih
    hvihhsrdhmvgdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoheptgholhhlihhn
    rdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesgh
    gvnhhtohhordhorhhg
X-ME-Proxy: <xmx:DdnSaMGfj-ml9B-EPyvq2M-tnGESrPY6nTSJjMVindw8j-wJuJp9_g>
    <xmx:DdnSaGTp0lu0xN-w3_L07jwr83s2B38M5OUQtGLBlzN3W0VvYRDzKQ>
    <xmx:DdnSaGc9WlVf7ZQLBvpOBdlrJ-xucevGA6httEncXt3vWLelgHN6OQ>
    <xmx:DdnSaMh4DAU2od3EDCIurOPKplOgr4HGd7Eovd5HhyM8UrEj41hUNg>
    <xmx:DtnSaD4Ntg8Xr25pgR4Zd-sJ_DmCvwountZV9ZZTqSO_fIIJc8WKBQmO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 13:29:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  "Haelwenn
 (lanodan) Monnier" <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v6 7/9] BreakingChanges: announce Rust becoming mandatory
In-Reply-To: <d323c453-a800-413d-82d6-b0db0a4b76c0@gmail.com> (Phillip Wood's
	message of "Tue, 23 Sep 2025 16:29:07 +0100")
References: <20250923-b4-pks-rust-breaking-change-v6-0-59076fee486a@pks.im>
	<20250923-b4-pks-rust-breaking-change-v6-7-59076fee486a@pks.im>
	<d323c453-a800-413d-82d6-b0db0a4b76c0@gmail.com>
Date: Tue, 23 Sep 2025 10:29:46 -0700
Message-ID: <xmqqecrxoz5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +We will evaluate the impact on downstream distributions before making Rust
>> +mandatory in Git 3.0. If we see that the impact on downstream distributions
>> +would be significant, we may decide to defer this breaking change to a
>> +subsequent minor release. This evaluation will also take into account our own
>> +learnings with how painful it is to keep Rust an optional component.
>
> I think this last paragraph is a welcome addition as it makes it clear
> we're not going to blindly pursue rust if it causes widespread
> problems. Personally I'd say "experience" rather than "learnings" but
> that's probably me being a grumpy pedant.

If this transition turns out to be way too disruptive even for the
3.0 that promises big changes anyway, can "this breaking change"
realistically be "deferred" to a subsequent "minor" release?

The only way I can think of that is permissible in a minor release
would be to pear it down so much that it no longer is disruptive,
but that would be very different from "this breaking change"
anymore.

Or is this talking about waiting until the downstream distribions
either die out without adding Rust support or start supporting Rust?
That, except for the risk of having to wait forever, might work, but
then to surviving distros, it would no longer be a "breaking" change
even if we ship the same change as "this breaking change", right?

I don't know.  To me, the last sentence sounds like reserving the
right to later say "we learned that trying to support opt-in Rust
component that we have to (partially) replicate in C is so painful,
so we won't keep Rust an optional component".

