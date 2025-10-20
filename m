Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A522D77ED
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990445; cv=none; b=Uue5mmMPFojbuZLcRfqFfzGxSMM+UQBI1LWY9JELNuq2FE2YCid9tYV89HIp31MPfGlN4uaLzsQtu5mQPRevvHR3ET3/sJizsvL1m6DXsNjKtatr57qtOZI8rs7yjKpcvHUAdCRICnTpZxRxr7LsS68t5qjSsDem7Srtq4AI1Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990445; c=relaxed/simple;
	bh=PYhbmUBvGXywgHdYEvj6zc0bi35/0w0UX97Wh8bWZnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uhNrRD6oJi0FEnkeg++Xz9Qf6u2O8EBLEiomjkswxYjl03ZYb5s07snCLQ8c/Drn15i7pTgWW7omkueOovViAK6PegSrmrRI9rC1zwhuF1kBlZKs6ixviWJuknN9vce7Bt/Alo1QYYvXoD9571lqLL8RrSgq09JeNuiUsKIVQuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NSso2EZ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xXhTQcps; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NSso2EZ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xXhTQcps"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D9BA37A017D;
	Mon, 20 Oct 2025 16:00:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 20 Oct 2025 16:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760990441; x=1761076841; bh=hw/atu1gJx
	t3zI282kHXBLxUqZpGy0/GrwK7ASOeP4k=; b=NSso2EZ2A6FQu2705I85j0E3ar
	baMfTQD0KwlPyOQ5fr3jG+G0XoCAOercazfNUepzAe9o/9hFcYQRJx/69hPWqCol
	o35CjqqSohyGDE0upAnVw8sGqQrWrCqlrG6EgmH+goSx8A2qqczUHufyHwzKlBGt
	Ys/3mjw7ZQjSy7jN7za/aPPoPMxfrqgBTb9rsdRqdmNyRyT64vozWLE62AxLmRtq
	jllaz9OZ46TR5dk8Lmrfrq91vHV/LINLEgHhPxBMcpN+n9BegJcn74KHEjjmUrQc
	0OOlomNZQCdpAFrbCmgyb3EbI2C3Pn8EAMyAoN3KBncVnls0344XoOk4OvBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760990441; x=1761076841; bh=hw/atu1gJxt3zI282kHXBLxUqZpGy0/GrwK
	7ASOeP4k=; b=xXhTQcps0mgYmnAnfrWcCN5arT21hfjwe98u/VwgXMlgY5YiCwW
	GE1fKBu8yx/cplU5UWAEvwuACp5ZWGkdk4H3PSchAa+MmMd7wf5+nJMaxNrN2SNn
	VYci05D7zoREdEJHyMbbN31H7uu5KOy8QD304l+nBXSh95meVuUDk1GenQxNNSmc
	nbm648vRWoUVJt4rRe4oFadW2xNPtWdmqqOrybuoBZBDUhEnYT9kiPm63N3NFgXU
	xp7xGGtxmCUp5v+4zEq4JaYneXv3Ww985PNDMcbt2VOcNzDj7248B+jtXFbOjZlh
	13Daaq3DyfTDJUIQih7qW9ksO2loZ41rgVg==
X-ME-Sender: <xms:6ZT2aCyb3adHPXpyteOJOhmPkV7leP17T4rwu8HuK9aPdw1c271efQ>
    <xme:6ZT2aFRagyrE2SdblvRRxZx8jKj0YQj4mMKeWFSRJfN4_n3Y_2LuDU6PeTlb_PKqK
    gG2rImbUdtpCNThXtdwKXXXMQw0qlkAdZx9uiH1FRPfUMVWqhtc>
X-ME-Received: <xmr:6ZT2aJX7bqhh_XQNJHrWlcXwy6ROPstOhaPzzgkxFBccBi9UNr2r_qDqgc3fFp7vBKDMree-Npan4TkCTXUaHyD9J8mHxFVkIatZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:6ZT2aHYKxWlNKShtdxw69H0R4F5_JedjClr5AGEiMN4ZLelGqEqZfg>
    <xmx:6ZT2aP2tVLZ-HL7jQMgvKPEOJkIHC63pnAJbcRDxCVDYs2R_YQEWHQ>
    <xmx:6ZT2aJiwMdBksIqVT8DdxFvLuzH4nPww-ZqSmH-pLxee7keYy5-FKw>
    <xmx:6ZT2aDbU22034acc-2_Y1miqHu6O2TFy8V4vHZD9B6Ju44A6Mw3AEA>
    <xmx:6ZT2aMCnpyDK_ovWUWU74yx5A_K7aSxf7QJI5tQ9me4FEdInOXmb9Xu->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 16:00:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/4] doc: git-reset: clarify intro
In-Reply-To: <4871df7e-4ab4-45ea-83bd-9a49e4d60561@app.fastmail.com> (Julia
	Evans's message of "Mon, 20 Oct 2025 15:29:00 -0400")
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
	<6b5459b7ab478de33d17f9518906396f8a01e0d6.1760731558.git.gitgitgadget@gmail.com>
	<xmqqecr1xiqc.fsf@gitster.g>
	<4871df7e-4ab4-45ea-83bd-9a49e4d60561@app.fastmail.com>
Date: Mon, 20 Oct 2025 13:00:39 -0700
Message-ID: <xmqqjz0pz6l4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>>     Reset HEAD or index back to a known state
>
> That's true, though I think we should avoid using "Reset"
> to explain what `git reset` does. Perhaps
>
>     Set HEAD or the index to a previous state

OK, though the state is not necessarily "previous".

> I agree that "git reset has two very distinct modes' is important.
> Here's an idea for how to communicate that.
> It doesn't fully capture all of the nuances of `git reset`'s command
> line syntax, but maybe that's not the job of the intro sentence anyway.
>
> I don't love the use of "things" in "two things" but it would be weird to
> say "modes" because we already use "mode" to mean something else,
> and I haven't thought of something better yet.
>
> `git reset` does two things:

I do not mind "things", as long as it is not mislead readers into
thinking that it may do two things at the same time.  "modes" avoids
that problem, as "you use it one way, and it does one thing, and you
use it another way, and it does a very different thing" is the
natural implication of that word.

"The command can be used in two ways"?  "can be used for two
different purposes?"  I dunno.
