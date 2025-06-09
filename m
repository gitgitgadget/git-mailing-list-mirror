Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD321E097
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500386; cv=none; b=p+P8tjkMI0vGRlxFfaE/Qx/m2Sk3oI5jDgob8+TQ/HADMOr8expi6mq7UMY4sLszrWF0RKFx1vNo46D+oNfTd4Uj/0Ioyq4GssPNrMM//9/UXBPFzbkARLLqcF18PpFFmcJCNy8Sp+boKX8Vdfd5kAZR+2gmq7ki/4/n1pFRER0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500386; c=relaxed/simple;
	bh=GfPJhDYfJ/Cu0lf7c5xr5olIL+eiFJRL+mnpLKx55IU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l6Ksaz+zAtWn7SfyfCXcMNp3kPYVdUHWh5zCxnnypIQTVHO+Wx8xOyYaNC0pOoT/94UbYBXHa+G3cZUJw8DwYjGd22faROq2tHCNqqJOCvZwF4vzY3qNr81wgZ3iBR71AIDT78hECBwviju4c++8ubgJzpf08M3lk8MfVxPxFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HAo5dxYL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UyQOG6LF; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HAo5dxYL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UyQOG6LF"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CA851140338;
	Mon,  9 Jun 2025 16:19:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 09 Jun 2025 16:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749500383; x=1749586783; bh=GfPJhDYfJ/
	Cu0lf7c5xr5olIL+eiFJRL+mnpLKx55IU=; b=HAo5dxYLUJ832Fsb95MBNzD9eg
	d67uRbaOS0mIs3ErpYrC1rNkQBvdDhvgSXz8JM92RSxA5mnatHPDKhRUihBhf17W
	UfNuTl0ijnv6Vm08EyzA4P8jWlQvg9DI+//36T2cjxWGr7nrLYBnmBH4DTpDMg0n
	UeuT5DGZf8gBucUsX82qxoohLiYhOZjxzSi4mOmsnByDgg+YAvyUMXqgpOssOLjj
	qZImAgRtPBK/aZp4xIHQwAPwL3BxcLuZ6f2FpP6bJWDhmaqIlnzCGEexgBDzBjDL
	HbpKrqQX/7+lxZT/9OfrP1SDBmtjsl4HHrCT5yYs19VAD79qpW1LR1PspekA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749500383; x=1749586783; bh=GfPJhDYfJ/Cu0lf7c5xr5olIL+eiFJRL+mn
	pLKx55IU=; b=UyQOG6LFXiAo09W2M7qMr46Tl0r3NsKdFEp8+K1iCk43oObgcZv
	1u2SbTOThFH7+jt5wqYD08nuTFmHcV9bZ9heb4tStgLFkwJRdp/9u+thmqj4XLsy
	IB2wFGlIeeypwG+rAQSrjHt5hddCWGKjLZX7JojashSYTSjKx8ov0J+WyFhMUdNN
	2VKetFs3XKRWn6Guov4w/u+L3XnG02NmTiAWY+I9t+MXBv80fKZlgD8+pZ6pY4DC
	vhCPnZzfmsHYKbERyLZOO0+UZmI1vHEZWnVvmqFANBCArHqo3CXD8q2t9IiObLP0
	k90EwJPIPtpouxZRnvfwc/VwUOiFPDinT7w==
X-ME-Sender: <xms:30FHaCkZv9EkHlQqdvNkqafB5XNdmQUg52ZawqzHJ9Zz2OcbwNFLRQ>
    <xme:30FHaJ2ougbVM-mQZi1NXVj3GXmYfT8s4W0A3dmUctEUFYhwj5w6Bx9SpE1I0vRGp
    Ry71_n1kZrLghGKJQ>
X-ME-Received: <xmr:30FHaAoxEx-KXvhCoxRZOR2nxtb1Cai5IaYXDbkKGLDzhwhkweY5W0aKSsNFfp6ADeNgBvolUYsdNG_uIyQ_0yE-RaGkwD5eHQv9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeljeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhhilhgtohdrfihijh
    gsvghnghgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhho
    rhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:30FHaGlJVp_NJcJH4qipbSMVbAcOwq8hjmCM5N8nCOoWWTDwZJrljw>
    <xmx:30FHaA1cwVQHYwaLyRgUNABjNNA16kWN5mBwUIY5iF4y9xVpBQy9NA>
    <xmx:30FHaNt76nFvjxlEc9X93UiN3fDwKX1C8jKZVG4cgrj_Hl18pw8EMA>
    <xmx:30FHaMUPn7YMMyeD9MAf7nslCgu_Fw8WcVRqUdK2rNoaUuk3kk187A>
    <xmx:30FHaEiCKHJBMFOonwKtmDJIqwRYz7165fJLb4U6IgjNUapMm54Y1LUM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 16:19:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc: M Hickford <mirth.hickford@gmail.com>,  Git Mailing List
 <git@vger.kernel.org>
Subject: Re: Suggestion: error "tag ... already exists" should distinguish
 between tagging different or same commit:
In-Reply-To: <CAE1pOi34+btHyV8GbjpFPcJ+2ixu59ce4eAE=Q7F4JEcuJyXnw@mail.gmail.com>
	(Hilco Wijbenga's message of "Mon, 9 Jun 2025 12:37:41 -0700")
References: <CAGJzqsnvTnp3k8Ab2exaBAw5pszQRz00UcucnK=ECtY5vhG+1A@mail.gmail.com>
	<xmqqcybcrc2u.fsf@gitster.g>
	<CAE1pOi34+btHyV8GbjpFPcJ+2ixu59ce4eAE=Q7F4JEcuJyXnw@mail.gmail.com>
Date: Mon, 09 Jun 2025 13:19:41 -0700
Message-ID: <xmqqqzzspt0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> Does it really make sense for that first example to fail, though? "git
> tag hello v1.9.5" is an idempotent operation, isn't it? The second
> attempt is a no-op?
>
> If "git tag ..." simply does nothing if the tag already exists (as
> requested) then that would make the OP's issue go away: only the 2nd
> example would fail.

I do not think I personally mind that direction; when I responded, I
thought that in the example, 'hello' is initially pointing at
something entirely different (perhaps v2.0.0), though.

But it may be tricky to do, though.

It is easy for lightweight tags, but you'd have to fail an attempt
to add an annotated and/or signed tag without -f anyway, so you have
to be prepared to answer "why does this behave differently with and
without -a/-s?".
