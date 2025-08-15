Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9242C21C8
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274246; cv=none; b=Mp7HK/5dxWCOes3OC1kyo3IstfZfqnzs/dkTeSGhYP4StI0wYNd6A6iKrLwwbUZhrfO7qPq+0OaVrGf+jqWAEgJWceFuNRr8HVgZvsya4XgAJV6CgO7PtuTo4itL4AMnYSeB3kumD8wsZdkILW5MTdOt1Cao10/M8JLX3BXdYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274246; c=relaxed/simple;
	bh=Al29wh4480GKXgsET3n2BWoidLKk7oUdQroo94In4yg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qO7gEajQsQfzkHEGX3Tnxx5Mpch6CAL7Qoo8haEOfPIWiMgp7RAjydDDyHJk01OOzgSCFu2uqiQWyzNk6gYtTkGhaxizwyp0r80TdrFjcJeGO4zuSttzJSe0MLztFK8LPKf1qalFAIIRIhN03EEHNqkqTIP/3hrEcrdnlJcxT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=n3tidNwZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cmLBPZM2; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="n3tidNwZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cmLBPZM2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E68C07A015D;
	Fri, 15 Aug 2025 12:10:43 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Fri, 15 Aug 2025 12:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755274243;
	 x=1755360643; bh=vdrrRwb3UQm4WJlqJKSRJ6srA2t35Mcq7Xv+yJWM2is=; b=
	n3tidNwZKk5gTEs0gRhbYKkHUjAjRnIIcykZY/2w1SqJ0KtfhvDrUMX4jKhHuxeZ
	e3KNQxOH21vf7EwriA70DGkJwoLGZZyir9/fTz2Oc6WYAJFHIA2fsm3BAZCy23Qy
	9qSrfSGwLI/MIe3XwL8zyPEFblwi/bbfwd512zQb6fDc385Eeke69d9jDWNxWWEO
	43iD6ypx7hTF1yidDrBEGnFIwuhJwKHM48254Rbo9DocvyhlLnr/tepWCOObcZwa
	DElmEmUbhpkviLhO3IQ8LFcHoVA2bHEx0R4p6CHpw5jG841VmlXH+Iv3Q193kxJz
	1TFzUtJu0PiU2+rE6rZwhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755274243; x=
	1755360643; bh=vdrrRwb3UQm4WJlqJKSRJ6srA2t35Mcq7Xv+yJWM2is=; b=c
	mLBPZM28HB9nkW6iuQWYdSSZHToak/cgI5wYNB85DJLCZXPI4WPkZrcv0m1NK4SF
	4eRGlG0D7kY3oSUIa6S+OhGvj8CUny3VamXAY0Lq2uxNya1mrp89rRC3OZH17dnh
	RuV+W8xC3JeqiMWTxv85hx7uDOO9qi3Nqs61Q3IPp2IZI0NYR3lzcROQIl1LBMCl
	M7MGOO2e7KWupyOjWL3C2OCaK+sC+s3lUSKNkRLlQ/0jnGi41w8NHJHEBnaZ4V6E
	bfQ8jK8ZITCJONC6p6agHxGgzw9virPolmM7ny3ugdRXSciL5RGt8ZeqyU/qR4WI
	JbXFAF7J1ympddyY/l4MA==
X-ME-Sender: <xms:A1yfaN6QskuWIHZ-7szF45FdsA7nGf_huWj-qlOPUzW3tNI-CYQmhQ>
    <xme:A1yfaK4-zQHnS-pyp27cuvYBKM7Pq30nCTa38e9JsuCzWGyQqtKfosPfQx3NyUOUk
    bYYqrnMO9zqpLxFoPY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeggedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:A1yfaAVT_piE88ipc_8PtN1Eed30kR9hkWTS_jNzPXlXIIaXHQLKMw>
    <xmx:A1yfaFWm8edNDD3dlFbGzFPnDHNUZoRiv8SdfMJzk_U9wY-9hSx3pw>
    <xmx:A1yfaAhP4HhA0LBueNfCYYqjjd1ijm5OuhT3f7KkML4x6Sg4jAriLQ>
    <xmx:A1yfaAZN69fFsHBkIwacdA8Z7CJxKQ4Dq8dB414iBy2ARTCYdx9TiA>
    <xmx:A1yfaFPLvokiADNnD0bX5qE4wxObCLWQ2DZFjqEP1rfhP0xZcjFLLIqk>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5DA597840B2; Fri, 15 Aug 2025 12:10:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOSFC39IWGa7
Date: Fri, 15 Aug 2025 12:10:23 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Chris Torek" <chris.torek@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <886787d2-26b5-4451-a105-9ab522e38ad6@app.fastmail.com>
In-Reply-To: <xmqq349ty254.fsf@gitster.g>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
 <ce1eafb02860b390da9359f92fcf098b7cdd3a94.1755127218.git.gitgitgadget@gmail.com>
 <xmqq349ty254.fsf@gitster.g>
Subject: Re: [PATCH v2 3/4] doc: git-add: make explanation less dry
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

> I somehow find the text before this change easier to understand
> (except for one thing).  "If you edit `file.c` after adding it" in
> the new text says the same thing as "if you want subsequent ... in
> the next commit" in the original but in a much better way.

I really appreciate all of this feedback. It makes me wonder if there would
be a better way to approach this man page. Usually when I'm revising a technical
explanation, I find people who are currently users of the software but who have
trouble understanding how it works. Then I ask them to give feedback on what's
confusing to them about the explanation or what questions they have.

I do this because I find that often people who are extremely comfortable
with using the software (including me, which is why I usually spend so much
time collecting feedback like this!) can lose sight of what's confusing to an
"average user". And every time I'm part of a discussion about documentation for
an open source project it seems a bit strange to me for a group of people who
all already understand the concept to be discussing what would be clearest to an
"average user": surely the users themselves should be the judge of what's clear
to them!

I'm still pretty new to writing open source documentation so I don't know if
collecting user feedback like this is a normal part of the process, but I always
learn a lot from this type of feedback and it's pretty easy for me to collect
it.

> Rewrite "diff --staged" to "diff --cached"

Will use `diff --cached`.

> In addition, we also should talk about
> "diff" to inspect what the user will be leaving out---in other
> words, what the user might have forgotten to add, which is equally
> if not more useful sanity-check you can do before you commit.

That makes sense to me.

best,
Julia
