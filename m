Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2542264C0
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187709; cv=none; b=NY7i4vLRjBqbuDa7Ed90WRUnHd9qPemqQeK5tClsfNdpbSC5Pd9lOgMFREW5S4gjQNWsg6ruMxs73oxcjhG43YzHbKvdVvQgRLzzXvw6D0237HgPRpAlhNq8KsNgWPQYcaxp3+wEKsqQQZXsMsgR4nnSxZOkObInfyoytIvpxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187709; c=relaxed/simple;
	bh=raIeBSjVw7/AzIXvUJxC3+aJph4DHxbWQppYvhj6zmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=abetJpdv1vtBO+ydR1brxQHhnM9nfyb5fCR207nOifHiGp7mBg3BPyZmE5Xs/1mtIflvlvtPT56q+TyuCJsFyxwV5ySAz37pcbDppZQ4CEFygCDxIvhevPjfzZzM04Nnc7kvhFdrdXdVUwrbIhBCxGoRVyQD3xPTo13QONQh9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pgSzEtlc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArEvQxM3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pgSzEtlc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArEvQxM3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A41F7A0087;
	Fri, 23 Jan 2026 12:01:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 23 Jan 2026 12:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769187706; x=1769274106; bh=iiSQqfQlGP
	Nfq9UfP2NG1OGBTTK9sIyJKVJ7ye6wzkI=; b=pgSzEtlcIAvcoEXIwR4Re2p5OY
	ObB8hIfbPqaHmCq/w9L5/Bg7v06Lyno5eS9AZ8pb+cCJBd2HzkC/iHcsbjB6sN7q
	urqMD9v5QGMULxXJdyxlBRgH+cr68R0HJbI9oDdPGicZzbC+lx/5FH/NKoV01ocR
	B1zmhcW6voyRNBtFxxYGShlq5hl0ix5hws/C+s07Vb0DU+4nDm1FpYIeGYJMP7cU
	VFGUlGlfr4Fsd51PF7dQeY88QqfEuNch+bJaoKGCN0OjqC3JBif2GpBrDGkq1yld
	WIPANg0iChMqbaFobGJZYtuaG2Hx1LuFH+UUO+MsXA4iZ4+C8dt7fmpOyeAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769187706; x=1769274106; bh=iiSQqfQlGPNfq9UfP2NG1OGBTTK9sIyJKVJ
	7ye6wzkI=; b=ArEvQxM3BWTrG2GdcH4LVW1LtLTRBL6qhISOOhBpXqEzfsGg4/x
	Hw73sFSN9cyGfcXd0LS4Zgh2lZsyIJ90DftNP+A2iYZFbQiyURN9TmvjbcE6Xm2U
	syzNstG3xwqyIoKWaSMh7ujdn+Liz6Sl37gcjloe2YdFW7bjTPwhPd/ZKGSHiFn0
	wIyX0yMazu1h8bESbDuWypKubtINvzmY5KvBBDGzM8FOGXDltQ+/tGbCYGGl4x9U
	ut7kt9tsX+azoDe0SI6gjzg89EXNfCXlfReAzHkQ2cX/SDoOE6Agmnz6xgm3ML4R
	c2cmGcbq1dC3AMfiEED74POVWzCnFp0jPgA==
X-ME-Sender: <xms:ealzaeu1fxiTN98n9Geqdmh2bgQDhktGcIJPdxnc95f4aYVwZ1q_WA>
    <xme:ealzaaV9osXGGlePum-yGvPCeEVYFJsAH0jik3-czQmrG15EPZQ5qB3_aBPNeJ9IE
    bjNL0LxViJeJ0_y6SyQsSe_PhlLQOkgvlRP7K83z6qsWvScuWkEbnE>
X-ME-Received: <xmr:ealzaSFQQLCBcMRTtIAKGkh_gVFaou400gqvzPslZaa3sfM0yfHlawE1XwBLmDUW7nAkw97EeD1zAvy4k96O6HdDbz2n1NUxz_TgU4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ealzaU3ubNWHzKs2HSQ2Xb24snk9fH7NpjVQmaq_dzOP0chpmdUkOA>
    <xmx:ealzacNhjGcnlcig6TV9uD7qRICVRgrLz38mz5btwzhGIl3scWjguA>
    <xmx:ealzab4rW3T5yxtXnjdrpTJrgY2dVDrQ61WlAuFt5Y-o7pThZzprtg>
    <xmx:ealzae2bf-GHOm-XKA0rwX0J6feZPqzbd7_kwoAK2Q954wI9Nc5WLg>
    <xmx:eqlzacCNY4Lk3QVq5vIO1R_xR8IxfvIik9-xPMkd5Gb2N9xczuYnCn5d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 12:01:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 1/4] last-modified: rewrite error message when more
 than one revision given
In-Reply-To: <20260123-toon-last-modified-tree-v4-1-86bf97bad4e2@iotcl.com>
	(Toon Claes's message of "Fri, 23 Jan 2026 15:33:01 +0100")
References: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
	<20260123-toon-last-modified-tree-v4-1-86bf97bad4e2@iotcl.com>
Date: Fri, 23 Jan 2026 09:01:44 -0800
Message-ID: <xmqqpl70i7pj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> When more than one revision is passed to the git-last-modified(1)
> command, this error message was printed:
>
>     error: last-modified can only operate on one tree at a time
>
> Calling these a "tree" is technically not correct. git-last-modified(1)
> expects revisions that peel to a commit.
>
> Rephrase the error message to:
>
>     error: last-modified can only operate on one revision at a time
>
> While at it, ensure modify the test to ensure the correct error message
> is printed.

"ensure modify" -> "modify".

>  		if (num_interesting++)
> -			return error(_("last-modified can only operate on one tree at a time"));
> +			return error(_("last-modified can only operate on one revision at a time"));

I recall we earlier had discussions on "commit" vs "revision", but
was the conclusion that 'revision' is the appropriate term here?  I
somehow feel that it is sufficient to insist on "commit" (not
"commit-ish").  The way you are allowed to give that commit might be
more lenient and you may be able to pass a tag that points at a
commit, but that does not change the fact that the "last-modified"
command can only operate on one commit at a time, does it?

> +test_expect_success 'cannot run last-modified on two revision' '

"two revision" -> "two revisions".

> +	test_must_fail git last-modified HEAD HEAD~1 2>err &&
> +	test_grep "last-modified can only operate on one revision at a time" err
> +'
> +
>  test_expect_success 'last-modified complains about unknown arguments' '
>  	test_must_fail git last-modified --foo 2>err &&
> -	grep "unknown last-modified argument: --foo" err
> +	test_grep "unknown last-modified argument: --foo" err
>  '
>  
>  test_done
