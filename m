Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073993C4568
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161981; cv=none; b=FIsjBbnIa1WvVNescDvj1158FHd/42rSP0o3sDhE3lR5F+Fr3cHMIeXF3VqHl5OrkAI2v6tSVaRdfIE6gcaQOcwxg03gmRgEGs7vsji8bjJFPLPyyxaKV0hKSKV4m/9Ix7HPtK2S4lNTJVtsEYAjP0pxRtQZybmGYQsD6NmM5vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161981; c=relaxed/simple;
	bh=RP9kLHe5s6HJb/etELoAavvbg31sY0Qy/3+Du1YlwqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m9M9p4u3rIyb3ppwvjGvXkOxDjA1ssQcvlZqJiiK/WuL++06L9tpbsnjFhyuUpCi6VmnVF9UbAITeT8EfStMti8jRMA70XUBFGxa97hTSuq97ZTYRp+nYlKq8bU75zN2DaNBsAXZ5KAbYHVaTVMyxid3sqZBkoU+LOnKgroplGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ITY+w5Lo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=coTgWf+u; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ITY+w5Lo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="coTgWf+u"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 492E8EC1418;
	Tue, 10 Mar 2026 12:59:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 10 Mar 2026 12:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773161979; x=1773248379; bh=syoncyL75m
	Txz6KzSsju3A1ItbphuAT7xdxWMaYgIRQ=; b=ITY+w5LoNHxyIvdh6ozs2r8bs+
	XH0Ic7wVkNxFLcVEXXV4F99BHqSSaJkDmHAr4cNt3KXCHTdablQj+mEnX3ar1TKr
	cPF8i/0iOTsab80S5G1XxsGbV2Gh2Po0H2NfeLH7B9eht33fc30rHYDFIbnwLlfk
	xxxKWk7ouLa3ppESYsSk77KPT23d2htEQV6y39UPTU5KlU1OT7//2BIZt3Mi1erK
	nh91LTNevK2kNaNWCpZRP1jgDMN2uwY96pxy8anU+lyb+pO1TlY8Og6R0q+PqLWV
	hSH3010Dn0aV0kltA6SsDt8i9C/+bWf8IyHJiX5znZKLo00Gyo4A1rNcSh7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773161979; x=1773248379; bh=syoncyL75mTxz6KzSsju3A1ItbphuAT7xdx
	WMaYgIRQ=; b=coTgWf+uPbnZHrvAA9xU3pN77F4yzkU6ytgaEEANHc0b84ZJ5NQ
	3PB5eqdvZfqDp3H76T9sTKBqa/ripgStovW35jYdG0NDupbaS0eP2TAZF+keshN9
	5WytAnVfMPQAUs1CA3WdmEsE1Ylexza4kewIr9aUm/+WC0Gda+Jxtf5SaZl9Lkhy
	Fopcjzugyj1oOG4jDxLPO0o6nQlZUQbimFnukjTgKV9Y7nKEf9g1t4ufjgoaiosH
	e+mmx0uiH8Ze75p74ieoyNVZFSTT2XwsM+zM/+caQZ/NHwmAxcRnuMOpCtu6XhWk
	EejoGi83ZNwiW56flozxLwmBTsBG0fHH3Pw==
X-ME-Sender: <xms:-k2waRbRB-gDrF5SEUBQmSZlJttcxdSAstTnx7kbmSozalQkDRMNSQ>
    <xme:-k2waarOQ6R3P1nYbu7Bdj--Pzf1wasofqygUIyQvIuQfuedfApeCK6kuQ8mTR9JP
    LUBlhuGAIBVUnHOpqEYZt89WC2EKkOv8J8GtoL0YDoLUq0Qf8haXQ>
X-ME-Received: <xmr:-k2waWOWh7iC7y3OiRzAd3ISSAFLxfiUWAoYB3W4XH26XQLvQdssOWjzfYc0uC-1o4gdhg289E58hvCi-q0K47VWARrTX9VSQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhsmhhilhgvhiesghhithhl
    rggsrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:-k2waVpoy26Kz0wBDxwQ31rMtcopYXfgTzNklm6OVbvfq5VWAbYpuw>
    <xmx:-k2wabceCXM9C6zSQTAnYp1oEj3tVmTiIv4m-8vu4UM9ubp5gG779g>
    <xmx:-k2wabTde4HpGAjdItSdutTAV7oLdI1U1voJzyOPaN9Y-A3iG6jDAQ>
    <xmx:-k2waUZ5t1hrrvPSJz1c7-O9ljxg3QGlEn4ibSN0jgxLwnqyf5GI4A>
    <xmx:-02waX-7KSLbw-etM7pq7tjkHvzgXGV9-bE_W5lhgEvadzhOIU0w3ZVX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 12:59:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Matt Smiley <msmiley@gitlab.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,
  Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 05/10] compat/posix: introduce writev(3p) wrapper
In-Reply-To: <20260310-pks-upload-pack-write-contention-v3-5-8bc97aa3e267@pks.im>
	(Patrick Steinhardt's message of "Tue, 10 Mar 2026 14:25:01 +0100")
References: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
	<20260310-pks-upload-pack-write-contention-v3-5-8bc97aa3e267@pks.im>
Date: Tue, 10 Mar 2026 09:59:36 -0700
Message-ID: <xmqqa4wfwrgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt)
> +{
> +	size_t total_written = 0;
> +	size_t sum = 0;
> +
> +	/*
> +	 * According to writev(3p), the syscall shall error with EINVAL in case
> +	 * the sum of `iov_len` overflows `ssize_t`.
> +	 */
> +	 for (int i = 0; i < iovcnt; i++) {
> +		if (iov[i].iov_len > maximum_signed_value_of_type(ssize_t) ||
> +		    iov[i].iov_len + sum > maximum_signed_value_of_type(ssize_t)) {

This made me pause, but I think you cannot wrap-around size_t and
end up with a small positive result that would fit in ssize_t by
adding two quantities that are smaller than the max_ssize_t so this
check should be sufficient.

> +			errno = EINVAL;
> +			return -1;
> +		}
