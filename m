Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AFD17BB21
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824835; cv=none; b=M4KoFmiY+nrpgeUvZlw3OweR3uHJIHoN/LJom9LRh+kQPMPq4o1bcGKEHdg4K64HvYJQ1v7lBDfJwUdKAUOiYuRJ7XbNaJPjEF7WZj3s7Jr8K2MtZgPJX5IQvkdBMr+3GSqofA+lM20oGyeoqVRhbJorp/9JjvrsblskKWRydUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824835; c=relaxed/simple;
	bh=c+c7eHj39n9ZcO2V48J51eWJoxxDxJneNZ0/UHx32BU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HeTKgM6Che+/uzLFqMFarbEOPLpjiPbPj9hmoz7Gvv/ME/SVu0koDmU3JnMxiAiImjLkc1nVUmi6mvW5Gh/DGZw//VpqjsZQMnGJbEtKKCHuCO73RfLzC9Nnc07okeJr15a49XLNB+o4rmjQAjjLAM55AWvnQGRI4BVfWaA8x/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lw8/a1RF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oOqiMQ3y; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lw8/a1RF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oOqiMQ3y"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D2B5CEC022F;
	Wed, 11 Feb 2026 10:47:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 11 Feb 2026 10:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770824833; x=1770911233; bh=qeES5AImM4
	Xj82tTezMSZmE6pNMZ8h2mp+A4JFz5Gww=; b=Lw8/a1RFLgZXhr0V2F9SVAOwwl
	QYsGlquxPQ6VazC4AiZFj5PlMcErzRzzV8p9xGB+XHsBO9NDWk9geGXDOtz7C1d/
	1Kfrwv+cZ+iDow95BekghxGwkoGWfqs40hxzRb09zejszVC1zb+60QxUMei81Vwc
	N/27sjR6ko4+3preePMlSs3TQUl+3Lz5EB50C66EuOi2gmfVIRSZQ0oxvQfdGaHX
	EJSKnQAKpNWb8mKKK1sR/G71XHqrReCAcfmdU2xVjDbK429zflNv/sYTR/Hca79B
	WszxdL7P4bm4ApSdLbG24/dx4prYt85w4imHqozu//jcmWUn58sBag2EoQfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770824833; x=1770911233; bh=qeES5AImM4Xj82tTezMSZmE6pNMZ8h2mp+A
	4JFz5Gww=; b=oOqiMQ3yXiugnf2a8HqOCbaNgq9InfGM4UAtgeWd5b2X8heM7JI
	oLcLZh6hSZOPB4wWY0AqT9PZM7A8JwuZH0uqLiHuRKd2XFhR5FkSPSNDnlp8hd5W
	VW+CaPg5jGgRWpU/saEC6A/SQJxPYdFELKuitVHvd5ys5+qFMamADxeuYWBOu8G6
	wafanoW+QBSErOIj41BY+vkJsRMvxrEIzgpsTeRyT0OU8ez5y+rfJme4UAG7h/V2
	GmFkmw5vCkbX7Z9atC0Ryz7RZjZ5A4MAARdyjJNtCAR/u9zMLC0Hvd/6Eon94ZZ0
	r8RLfX07E7Y1VtuxAUZd1ZGOfyvGw+TLJEg==
X-ME-Sender: <xms:gaSMaYJPyPOuDpiaCYorX7Nt0ANOKh4GZ95LWQ3GtgmcJl3R1rxbjg>
    <xme:gaSMaaaqXsrev49AB8mTM3qPP5hIQuz4wpQTcZ9Md0JHjsea6HfMN1VV_2sPb41oU
    y_D5_qwRynGQiCXbM0xs3gwEC-4eqSTVmolJMXybYZMDoWMXHfa>
X-ME-Received: <xmr:gaSMaa-o62f-36Ph62N5hU2f5dq_I0s0y9SVTNe09esh2BBNCrYwLgaisVXr_HzdOumaS2xZmNmKbhwMDZFnskP-QWhUkjBtNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphih
    ohhkrghgrghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:gaSMabZ658qY1HMlBDpEuxImCD6ni6tv4u34KxsKTgIM8T-gdNz8hA>
    <xmx:gaSMaeOXS5jPK6QjxRwF39It8vYKjKNmbYhHnrUF_wtS8D1ZE6awFQ>
    <xmx:gaSMaXD9NvQQc5dxSQN1nEY9_V59bYOW_VV_GJpV4xGJ4vDHdinaeg>
    <xmx:gaSMaVLkNprnO7H6Y_Yv7fL_nxs02Og-ke30Vo_CsRX9m1MEjJzh-A>
    <xmx:gaSMadZCQHWW1nQQMBthNTFoMWDA9qS0ZCakBvrKeUVNtSsXvWMxR7-G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 10:47:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jacob Keller <jacob.keller@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Matthias Beyer <mail@beyermatthias.de>,  git@vger.kernel.org,
  pyokagan@gmail.com
Subject: Re: git-am applies commit message diffs
In-Reply-To: <20260211074751.GB1867915@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 11 Feb 2026 02:47:51 -0500")
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
	<CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
	<hn6q2mdjdqezzvtxfxffmatctnlf4ttvwedfk7wnw7xw75gy4g@hetctv53f7bh>
	<20260206090358.GA2761602@coredump.intra.peff.net>
	<aYoEO0CcVt2Qjgnb@pks.im>
	<CA+P7+xrNycJHTyJwn9AQcJLG0dDAE7KrTvWTHBi+CiQUqK8p5A@mail.gmail.com>
	<aYs_P8QujA6mL81-@pks.im> <xmqq34381tze.fsf@gitster.g>
	<CA+P7+xo0-9h_V8xGQaEdgBEaxjrbrNOdPfmFmhKup+Z-7w0zUw@mail.gmail.com>
	<CA+P7+xpYSyhBoC23RLycVXFSBB2=dgsQrnvLkk0D7afOqWyafA@mail.gmail.com>
	<20260211074751.GB1867915@coredump.intra.peff.net>
Date: Wed, 11 Feb 2026 07:47:11 -0800
Message-ID: <xmqqa4xfwadc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> All that said, if the main goal is just avoiding accidental diffs in
> commit messages (and not worrying about truncation due to "---" in
> messages), there may be a simpler receiver-side solution. If the
> receiver expects the message to be generated by Git, then it will expect
> there to be a "---" line. And we will not expect any diff before then.
> So could we just have a "git am --strict" mode (and perhaps matching
> config option) that always looks for the "---" separator?
>
> It's not foolproof, but I suspect it would help with the worst cases of
> embedded diffs. And it's not that hard to implement.

Yup, if the payload is known to be generated by "git", which is much
more likely these days than back when "git am" (or "git applymbox")
was written, can ignore "Index:" and "diff -" when deciding when the
log message part of a piece of e-mail ends.  I like that approach.

