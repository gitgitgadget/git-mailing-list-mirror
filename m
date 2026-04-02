Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEBB31F99D
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144482; cv=none; b=OR1upRVy6lwpe6CxD1JLJUcmg5q0BqCkDTB7nl3KJDe/Hdtz8mtnOMOXvI9IKwUwrFnBI4T0QWj4BzI4nDwB4mZay9Msw9V58sD4DZ31OyfZu672DF02zgqycgFR/1nnvaKuSHi4a9d7cDtHj864C1JevRpD0J4g5vH58AO+mdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144482; c=relaxed/simple;
	bh=CVRPuXW/+nibm3E1kbmfxJkSv692z6MnyGorpenG++4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gc5gMMdSLD1cew9qpQ4EN+10DKKIx/0Wlbr4Xyjju6K+8/Ny/euJjC/1sNthiRZYKn7eBLmRKYiaqu2583v66q10jn5rZX1OUxcFj9T2e8UCCZNpmviVQTsVdTF7AGQDuxV0V8vqC76QnF2gVoFAv7ICCXeiW3zXLjqamznL7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qydA/3WN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p+UFWvDQ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qydA/3WN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p+UFWvDQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3AFC31D00360;
	Thu,  2 Apr 2026 11:41:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 02 Apr 2026 11:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775144480; x=1775230880; bh=OkDIE/FK4Y
	F825idkj/5DUJPz/uk83XjfFsZiTr1McI=; b=qydA/3WNQMK008eE7nPDo/3Zsj
	45D5ZMAgrC/SHx6F6qIU32wEy4w1poohof3v1/0NLWbFZNrko2HdNRLG2g1WElwD
	0oOIUeWeqQkK/n7E9A6iG5hxj0Kzh80duGQ4yTirBE4YrRlyJuRdzADIof7swD83
	j3QMM6WTklet5v91lDNYWPyvSpYr+nFhuU/UtEDSVexYuCAupacKse6QzbME1bXO
	KtK+nTkqyS1D+AMLBb9f5fNYGmUIaf3yGjo5PUmRt9nMkPOj0mp/tL3Ov+i9SgjD
	SYlHBielKxyQpvqVy+llvzpRv+izCzUQ2A+UFh+u0UuDOe/yuLZtacRDQXkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775144480; x=1775230880; bh=OkDIE/FK4YF825idkj/5DUJPz/uk83XjfFs
	ZiTr1McI=; b=p+UFWvDQMNl5x4J6bP/ziH7mEfJ21OFbUPQuCQXVfjVMHCqHDwk
	nDu23RZcHPyf4O0CZ9NtkyrhJFfm4PrAjSrfP6y+OVrWEZqlDagYeZXikL6RXWGm
	F0UVgXN0o1YOhLVbLkLGoMo80OOSoQm2Kw2hj6BtHbzZ8YmuVDYvkQQ11TIGl4ag
	tFHv9d/hUINvHIfTzT2XrgW5o0Thn+CG30HN9Ji3lC91Xrj6wvBe/bvLQlOXQ32u
	cucznNBPNSUOmSb3WvczkAeJquCwDteyN2cqVRc/pqKx2fxoYWiwyF7+dewiI/34
	poX/L4v/+c3KM+GgD6pdf40Eq18QQDrizgA==
X-ME-Sender: <xms:H47OaUaJMNLDgfRRojQjTQynBxo3BoUv5_waC-uG_DaxFIciMqd-OQ>
    <xme:H47OaTGY-FE7OuXy4xTxf6ElfoiSr9t-8K_u9syzrlq-X6qIQTY10uxMU1EPOG8S9
    NOniuko0H72aBMcTboCRt015YURDdKj0Dm25LyIU57s-FUdkI9Fbg>
X-ME-Received: <xmr:H47OaYwthFOujwgI2Ts6RSdyE8wplKLzAZdP60qt9VtwZGnAzZV_DEaaANJ-HwltZO00eNs9hQv3P-04SW6lzTzrlXDYMzEj-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehgrhhusghigidrvghupdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:H47OaVmcMJmRWD1J-R7K82ciYTN41QTv_xZ9qmaka_yJzNE9LNIQPg>
    <xmx:H47OaRlXrJyt3qt15vULRbxr1R5_uwO1Rbmo-BrkK0Js8h45DjbjRA>
    <xmx:H47OaXyq3ROZreyYOKSyi5edsm0psYnACUYDl89Dam9AcGa3Ja60cw>
    <xmx:H47OaWp15VzJCT9ehzSdsQ5TKSG3vxsKXuBxemOg0Bz-7WNrtIIpPg>
    <xmx:II7OaY2rgezRjH3Xd8nP6PaLm1FUycbxu9vB5QwSMj70iwEzQWEKTwCT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 11:41:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Collin Funk
 <collin.funk1@gmail.com>,  Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH v2 08/12] skip_prefix(): check const match between in
 and out params
In-Reply-To: <xmqqeckyt08e.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	01 Apr 2026 22:11:45 -0700")
References: <20260402041433.GA3501120@coredump.intra.peff.net>
	<20260402041507.GH3501239@coredump.intra.peff.net>
	<xmqqeckyt08e.fsf@gitster.g>
Date: Thu, 02 Apr 2026 08:41:17 -0700
Message-ID: <xmqq1pgxtlnm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> +/*
>> + * Check that an out-parameter that is "at least as const as" a matching
>> + * in-parameter. For example, skip_prefix() will return "out" that is a subset
>> + * of "str". So:
>
> Sorry for not mentioning earlier, but I couldn't quite parse the
> above with "that" immediately after "out-parameter".  I am guessing
> that you wanted to say an equivalent of
>
>     Check that an out-parameter "out" is at least as const as a
>     matching in-parameter "in".

What I meant was that I'd understand if that "that" immediately
after the "out-parameter" is removed from the sentence.

Thanks.
