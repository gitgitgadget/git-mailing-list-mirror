Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E9394497
	for <git@vger.kernel.org>; Thu, 14 May 2026 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759599; cv=none; b=S/Z8z0qG+HZKtXWxvOq8ghTxYxhe/ALz65YjJ+t27uRDCZsu514bQuyaQMuGCkwYl7gNow2bz22MivkgU38X+gwT52RfZtm4fezaK8x3jWWEqmCmJFbXmihwrufaER8TogvaeOntMbaV+qnu8kn3IRNd2OtiAXRwoX4g9CTMiIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759599; c=relaxed/simple;
	bh=kuLdoyx2xQp9wGXo85mJH6lUeI+nq2GVanF9RmV0n4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nIh/rz/UEUkQEW/qaVH9knhXrM1GrOAHom4hFVTvvzw8bIyNjk4mgo7o4sWSNDACnIEgu/RGU7LykaGD2dxQZisRLWYet476DqPNfH+Woi85RmRWVfPcuhWBhfM8mNprr71mKxNBJP8LukoY4kz4pR2YI5qsOO1R93sm6pXMRHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eJNddHfa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M4uQH+8t; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eJNddHfa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M4uQH+8t"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F7AA14000E2;
	Thu, 14 May 2026 07:53:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 14 May 2026 07:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778759596;
	 x=1778845996; bh=EGHZtPSvjLOR+q5pyNkKt3/Rv8l5NNJuVtAJu1IlDJU=; b=
	eJNddHfacnDvIIPHLs1FZoL8pIn0yy3bPaldLqrl/46KoT4q+W/6BuK6RKIu0DIc
	Fomko7BP6ZMJgb6y2TcJxIAUXbuDzr+0uFrO81PS1+Wg7mC35ptTf35boZkefK3u
	+wyTNgIHIAN/O38fmjPcmQfMqsSGFe2YkSOI6YNXz62oeUxdxPk4RRdBPG1RF8K2
	i6z09ogfjXm2vQ+zx/oKFU1mZAfAaNIw9zF6tBVijTe8WuhKS2DlBPwr/wZGDKkN
	rwYWLr0bYW8GKiOC3nLZfeMySSsoOM5lJi8I6Tp10eQr8T2mxpOI406r55RCjHL5
	AmrefEtWL8rms6byNWOv6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778759596; x=
	1778845996; bh=EGHZtPSvjLOR+q5pyNkKt3/Rv8l5NNJuVtAJu1IlDJU=; b=M
	4uQH+8tDLY0rwa3KPV1jAjeMeQUA1XKPo7q7lvrGMay1Am3vYfrWsbDyXXCZAh30
	LAlnCxcKIETd25js1/coLoWDlTZimNElzXAUtK4c9cYook9PE9AJ6kjzcXnrcBkw
	8OE+bzD4hPpcOGpjWF62TjPS9YvPM4zfwvAqLraoFaClL8XKpwtX90Ca0KHFriGj
	Xw4d9TyGc6HqSLHRAP0CCfgawsYk0gewz6rs5gnB1hzHpMTvIubWvPDT7VLcCWOl
	srMbjwGHeMOPnAQaRnkOnE7oTIdDWkZich1GUXpzSvv1Nhyi5uj2rdVqgmoULX1l
	zpgHeS54YQ5r5ZllDh+UA==
X-ME-Sender: <xms:rLcFatM24j6XaHt1EEmw0rsQ3gvZ0cxQ7Numr0cXD2p_b6X9RsjZsQ>
    <xme:rLcFam-qRevc2u3JvFYDGYylGenwqsBaPRQzixP-eYAdHK1_9pRY6A5lt-bq26vvq
    xXrGgPubW06MSewOaHB9nmVbyj0FJbW7DVutVsneu2f8N58V--PUA>
X-ME-Received: <xmr:rLcFahRZB5J0OQdjVrjI_jkXrqERwZxaGVeJaarixklzD7Yfr31mvaVG3AkI4kq6vUXWj-wJW8tqJ11-HBphs3QNud0U0ahzmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdejgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnhepkeeujeevtefhkeekieekfeekgf
    eukedvuefhheetteefgfetvdelveevgffhfeegnecuffhomhgrihhnpehgohgusgholhht
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rLcFaonzuBY282poogzZhLfSSgZ_pfeI-h8H6g7q8ipxR5hb4OcKGg>
    <xmx:rLcFahT9GdX8VMYhk26X7YEtvv3hHsvPAOswjI8rO0h2yOvJ_mzV5A>
    <xmx:rLcFamMHdwqK0eYBje4xehLDk5ZwpUyCA8t2nFuwqv0mU5g-iZJQfw>
    <xmx:rLcFaqUqgJa1cN2j65gMKCZEmCsEIjNmmFcbUTjHPI7FUnkQTjEvbg>
    <xmx:rLcFaskktKnd-uFZEyK0AU81Sne9r1FAdz40pFB8FkHpqGVeC-_hqCmR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 07:53:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 1/4] strbuf: add strbuf_add_uint()
In-Reply-To: <f51cdd89-dab1-44f3-8f63-7d34f6fbbba5@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Thu, 14 May 2026 13:09:24 +0200")
References: <20260512115603.80780-1-l.s.r@web.de>
	<20260512115603.80780-2-l.s.r@web.de>
	<20260512184238.GC70851@coredump.intra.peff.net>
	<60b1ef2a-3b12-449e-be0b-cb206425c80c@web.de>
	<20260513162232.GB103037@coredump.intra.peff.net>
	<20260513164948.GE103037@coredump.intra.peff.net>
	<f51cdd89-dab1-44f3-8f63-7d34f6fbbba5@web.de>
Date: Thu, 14 May 2026 20:53:14 +0900
Message-ID: <xmqqlddmgqc5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

>> Right now we use unsigned_add_overflows(), and then do the actual add.
>> Using __builtin_add_overflow() might be faster.
> Curious.  Clang and GCC emit the same instructions for our
> unsigned_add_overflows() vs. __builtin_add_overflow() on x64, but clang
> on ARM64 fails to elide the comparison: https://godbolt.org/z/91d35KofM
>
> Which explains why this patch:
>
> --- 8< ---
> diff --git a/strbuf.c b/strbuf.c
> index 3e04addc22..4c2bd1e66f 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -106,12 +106,13 @@ void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
>  void strbuf_grow(struct strbuf *sb, size_t extra)
>  {
>  	int new_buf = !sb->alloc;
> -	if (unsigned_add_overflows(extra, 1) ||
> -	    unsigned_add_overflows(sb->len, extra + 1))
> +	size_t len;
> +	if (__builtin_add_overflow(extra, 1, &len) ||
> +	    __builtin_add_overflow(sb->len, len, &len))
>  		die("you want to use way too much memory");
>  	if (new_buf)
>  		sb->buf = NULL;
> -	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> +	ALLOC_GROW(sb->buf, len, sb->alloc);
>  	if (new_buf)
>  		sb->buf[0] = '\0';
>  }
> --- >8 ---
>
> ... gives a speedup on my Apple M1 with Apple's clang:
>
> Benchmark 1: ./git_main cat-file --batch-all-objects --batch-check='%(objectname)'
>   Time (mean ± σ):     119.6 ms ±   0.2 ms    [User: 112.9 ms, System: 5.6 ms]
>   Range (min … max):   119.3 ms … 120.1 ms    24 runs
>
> Benchmark 2: ./git cat-file --batch-all-objects --batch-check='%(objectname)'
>   Time (mean ± σ):     117.3 ms ±   0.2 ms    [User: 110.4 ms, System: 5.8 ms]
>   Range (min … max):   117.1 ms … 117.6 ms    24 runs
>
> Summary
>   ./git cat-file --batch-all-objects --batch-check='%(objectname)' ran
>     1.02 ± 0.00 times faster than ./git_main cat-file --batch-all-objects --batch-check='%(objectname)'
>
> ... but has no effect with GCC 15.2.

Interesting.  A few percent is indeed impressive in such a micro
optimization, and it is satisfying to see that the compilers can see
what our unsigned_add_overflows() plus the actual add does and makes
your above patch a no-op.
