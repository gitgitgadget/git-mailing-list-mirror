Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD74E18DB16
	for <git@vger.kernel.org>; Thu,  1 May 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746115632; cv=none; b=Git8It7KdqAHm5n213udkBH35wIU5N0wUS9HX5WCAD+XfGFfQRSNei1l3pg6ehJzFVYEWsxJ3Xt6ZrFZC2EMCcvRWmXx8K/lOnceuKetAHgjeQjFiXeeR8BqYlz8i01rQoyefZqez9tuNfV+bJr8cqudhxZWZ+8Bwqw5ipAvUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746115632; c=relaxed/simple;
	bh=NTJMRUtVdbrNlAu2Tr0xeWNGOpN9CLrJ8je4q/6HUD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N1ZOCe3tKVaJofIIMlo3vCMGLhPC5YuN22Tv1KkPmBIPywNjuKJS+g9MmvO28uolNfjTIYR1RjWQYFrhzA5BUfh+f+QQxc0JtStZPPkffJnpCOMGkqJxruOh5QXXiw47PFdXTHnHqXaWbHSoWIpJK28N977awRvVs2FThs4govk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i8l769JH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=erdtjA5X; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i8l769JH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="erdtjA5X"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D5DE1380E7C;
	Thu,  1 May 2025 12:07:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 01 May 2025 12:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746115628; x=1746202028; bh=7k5Zj+V4P0
	ReiroKlr6ANGmrZNzfVXZiFlOH9YBNq/8=; b=i8l769JHy7jlC1D9CYQtsFpzyD
	R4F7gnCZMwCkuh0LE/onxUrB53g2S+xpvEKwdcNLbcD4u8659avhFYRZie0+HLy0
	HTsyKsTREomlNycdxhYfeVy7PnpJyphjKtCmJgXfySYdNMt+avKueB5aOGQyunKE
	mkB7IfitKZ+WyyMbHj/HpCQz7EbgkYS5Z8+fCNZvGmz4+tv81omiAMa+6LgOtGk/
	l7dMdQLgjHeFPsfn9LHLmF/crVx6Egk+s+jAUo1/XPgrtdQ8EQ/hdFGUSfHdIFPa
	vQImsHEvdeYjaXW1KXXO7NvLmJlA1ra65skrm5Z8AnSGhFpaGAJF19zWKnVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746115628; x=1746202028; bh=7k5Zj+V4P0ReiroKlr6ANGmrZNzfVXZiFlO
	H9YBNq/8=; b=erdtjA5XrwjIHTN+o7tRnlbKwKx/6yy+DC+pGVFrqMkItdC2IPY
	X2yZ63njEwqJFwibyU2KEfGj4Cdd8/LckZZNO39NqH4gSO6aatD8i3bjN6aiq2nU
	mW1IBwlMwDV/9Kz0iWgtlBHq5zIAg41sspAsk81gpi7ucQoKu2gBHKamQvESfL9T
	z58fL7YjI1Yliq5DfhxDFQyl1in0DyVqjQvWNk7mdzCTBp/nPjbkSQvRh5m5JZVh
	xf6hszKZV5AyJxl+7CMLmrIetEBxoMwrW6xZbX1OOWSjQsV5JIyD+ocRU3gMs7R5
	z5bcam6JguFXur2qRkyDsuCVG9mvQHIQqbQ==
X-ME-Sender: <xms:LJwTaPNrjMM1OE3lWYuj0kWHBeJU1WZWPQlZOVnhs4fMcrYFaGyTPg>
    <xme:LJwTaJ9kwPGI6lbe68ZtI-Xy-s2ig1mrPDKXoyuvp4ZgnsQIOLjQB-I-mquV2RZHT
    __IJyYBpAGvcXwFxQ>
X-ME-Received: <xmr:LJwTaOQJRmUnFG70VkoPZsxfg08ENXk25Cx35jttQ5DmFgSZVAto9o2HZ7YEfofewmoLTk4oBATKhmz9mragiSF8ltyHhoFjfrZf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedttdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LJwTaDt6yCYy1YFl-t2nYDHY_bnX3-I_md7D9MJhuh5AqUYUZ7fsGA>
    <xmx:LJwTaHfR1LVFTjbGIjpf_LZ-sHuor6aZl4b4kJSgQTRw8URhvXocPQ>
    <xmx:LJwTaP21aGxXYitFs-MIQL22lizcjpENzEnMD_cGK7O-SrSbkXfzEA>
    <xmx:LJwTaD9c8NkRI2oKb9V1ktX0EOxdx2f_yiApoQuVrHPdED9Vk68UxA>
    <xmx:LJwTaI4nOOKnPK5VllWfbJNv0CBt-4cP52Bg_WWg2g4bHYs2IsgYhSyR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 12:07:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org
Subject: Re: [BUG] rebase: can write reflog with uninit. `action` string
In-Reply-To: <20250501131751.GA1725607@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 1 May 2025 09:17:51 -0400")
References: <20250428194048.149348-1-code@khaugsbakk.name>
	<ce0f41e4-7d90-4398-a0e9-e8ba69791e57@gmail.com>
	<fbc97d6a-2022-4a64-a2ba-5a7255cd81a6@app.fastmail.com>
	<20250429215155.GA36727@coredump.intra.peff.net>
	<6743a9fc-11ca-45ac-bc40-4148f5d85d27@app.fastmail.com>
	<20250501131751.GA1725607@coredump.intra.peff.net>
Date: Thu, 01 May 2025 09:07:06 -0700
Message-ID: <xmqq4iy4z55h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Probably the smallest solution is for ctx->reflog_message to copy the
> result and always own the memory (and then remember to free it, both at
> cleanup and if it is ever overwritten).
>
> But I think the way reflog_message() returns the "buf" member of a
> static strbuf is kind of an anti-pattern, exactly because you can get
> this kind of subtle re-use. It probably should just return a non-const
> pointer, handing over memory ownership to the caller. That would require
> adjusting its other callers, too.

Yeah, yesterday I was looking at the same report and was thinking
that the memory ownership model here is somewhat screwed up.  As
a few more allocations/deallocations should be dwarfed by the real
processing cost of replaying each commit, I think this "smallest"
solution is also the solution in the right direction.

> So the "smallest" version is perhaps something like this, totally
> untested except for confirming that t3430 no longer complains:

;-)

>  	va_start(ap, fmt);
> -	strbuf_reset(&buf);
> +	strbuf_release(&buf); /* guarantees realloaction */

I initially thought that this comment may have to be updated in the
production version, but because we have to freshly allocate for each
new message for ownership change, this comment still is correct.
The only difference between the "here is how to expose" and "this is
part of the smallest solution" is why we want to guarantee it.

> I'm hoping your or Phillip can decide on the best fix from here.

;-)
