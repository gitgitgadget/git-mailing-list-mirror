Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86524025B
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736808744; cv=none; b=AYiDFhscMz8rW98L/rP8++lBvn46c8Vot+5UQZ9CUyOhxgrJoVv4fLH7Igwj8/WrE7lt/rdF+eiV+LBSxqKOqB5Ukx8dhwEf0hPZtI1XQtAmmQKSinlqOay/RMMnBuLkfaI/G4xZ/oZGG2GxTCAP+Su2ImQW1qzpOD8VxWfzXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736808744; c=relaxed/simple;
	bh=yHURe0PYzNxWb7eKrnZw/4zAmcfKNJ4zAuG5BGq0x3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eYcELi777iiNzeDM74XHsG+Ac5eCkaGSeOZmR5ASgh0KrKfsAXuLK7rU3s+lpYntiZ7ZQFanG0NqcXwLYvQFcnVxWYGc/eDf8ruz/qHCME0+H7zABTg7h1p0hDLbCCIH1BqoOn/XWxMrCjlSVT7GMmVMluNn22YfYQbpTQnzA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ljnnq0v6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SwQhnaBe; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ljnnq0v6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SwQhnaBe"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 89A38114014B;
	Mon, 13 Jan 2025 17:52:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 13 Jan 2025 17:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736808741; x=1736895141; bh=yHURe0PYzN
	xWb7eKrnZw/4zAmcfKNJ4zAuG5BGq0x3A=; b=ljnnq0v6KvG07Wcq0zcHsu9q+x
	sRDeN1ySBKxtxa625CFVZuxaQ393vOxvmR55umLL9u5dRRpMxrAomOywhJSYyVB0
	Fm/XcYgyFfi05jCXTf/Euq0Ccj3T8NSFlxAULXMoZxCPysXAKx1u06himmJPFmxq
	5nzlt9lN3p8pCAwVIlwLbCjQOjIWD3lh1U/JZaGN4af7n/fs70lCs4CxNN3OyN0m
	xvE0dpCQB1yI5uNYkY7ONyz1rxYugFKBKVXC7rFRYKOv4O7gunM8D5oXuKJrcakd
	725bNWV/8B5p0P0prfwnkky+LnBE3GPfrLyfGTeaRNRQ9k58cwZxIJmMy2zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736808741; x=1736895141; bh=yHURe0PYzNxWb7eKrnZw/4zAmcfKNJ4zAuG
	5BGq0x3A=; b=SwQhnaBeT2fvPHX8O/c+iarfybLopNw8rsgrv0lik/tHACEFWXd
	W2nBUvq5rHrG2kmPsS0siJlRLo56RPsJ/db7eiJN0Eau5VSPvhoJuhTZqAWdxwAi
	70nnio1nUgixOmkRSwF7QCbDottsXuDkmvE3kAlZSEDuw6ti34cAjxzZe570vsPy
	aap3QOpIA+tJPFUOjGkN4SphAaLXk/8r/dJ1UCBTJzNm7G2ntQIGzBDa729OnipS
	9MOR9/vBpVHDCWg0jN0JlsyQ4BeHc5VorFxVWLKj3uQOrduepS2xXOmKABMQLQsk
	xE8TFGDqvbxLbLQtO1dIhu+rUyYu4TZ41WA==
X-ME-Sender: <xms:JZmFZ2_hsS7BCRA35uvb70OXclDjGd7fOUh0-kuv3GnYoQk6ATjYwg>
    <xme:JZmFZ2vSkA7UKlM5c6SkLJOniWLMJ58R24CRIJT06O42pfozG90XVtoSB5rGie7y4
    7mC4Gpo0XdyxQ2QCA>
X-ME-Received: <xmr:JZmFZ8ARugxGi49ofdRN0d3WvZMwayKI8xGAtFbmazERfUvwcinMe86L0i9pXLD5Ad3fiVI2hkqKE1nKrgJhLWfTyMeYHvH0KT9W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehhedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JZmFZ-d6D7nOqGOAwISdjyQUv5MC3k00av3hsMfUrbS3LrjPXi71Vg>
    <xmx:JZmFZ7OiOo-UiqbDDe8a9kgH6bVJlOVRYl8WMsNYGOsMOsjka2g69w>
    <xmx:JZmFZ4m0DmKgkG77utkbOnddcR4kWx_NKCXyhEwDbssHz6RNxoQ0PA>
    <xmx:JZmFZ9uFX6W38g2cr5QNMdb8Ve68KlxRRx0NLJlpp4uv86asAnQ1Yg>
    <xmx:JZmFZ22n8WPaGVkS6hxPf-9z-nWa5YzrC1zxHpcltpKl6fPqhxJtwFap>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 17:52:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] docs: add vim syntax modeline [RFC]
In-Reply-To: <Z4WGwCwnNj_XeHiI@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 13 Jan 2025 21:33:52 +0000")
References: <pull.1874.git.git.1736802194760.gitgitgadget@gmail.com>
	<Z4WGwCwnNj_XeHiI@tapette.crustytoothpaste.net>
Date: Mon, 13 Jan 2025 14:52:19 -0800
Message-ID: <xmqqv7ui72e4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> A simpler alternative could be to rename files *.adoc. This would have
>> the advantage of being recognised by even more tools.
>
> This I would be in favour of.

Sounds quite sensible.

Thanks.
