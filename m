Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A9921E087
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771368117; cv=none; b=H0Y3G5RnsQxHoQRwhCmiHu2i0w3wY3kUtzCCpBkENIiktNGvdMjuiVi6jRU3WRQceibGqSpHnab+qFL6DVNzmgP0CDxnOhhRgTNsho+iYkFj9XMqw3wVzAUIIwWm10Gzh1CPKFnJiJMzfU+CzEeu2ygxxogCGUJXiri8gtf5hHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771368117; c=relaxed/simple;
	bh=13cU3JUOrFUYInK42o/cw54TbRF2mliJc3hwJaFaZ1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X94PO9SXjBUnaAgmFXk4TbHpWuQfpUkqP8jhQjhl0ccK00GyUN3hHznSOrzpPaIgjvWkFZsRS3rs/8QYORwlW0kFCgRLQ/UjeHDe2imc6kyp2u2lUKYl9I+J+tGuFMpvOPWrmPXHMNpN8W5U/0YCgwax8ghFcTXqq37x1yi97ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UBElbaW4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rp0hoVIO; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UBElbaW4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rp0hoVIO"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 7F7FC1D000D9;
	Tue, 17 Feb 2026 17:41:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 17 Feb 2026 17:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771368114; x=1771454514; bh=uINgxocklv
	gNMF6W0sF6AWYxVtwxj9e3tdLamgY+3h0=; b=UBElbaW4CGPYWJ1CmZao6QHPxy
	kd8QGVZ9gumw2aLhw8Tvq4lz5Ynx7YWpyyJlMe83GTKk0j16h0yP+eGe0Dw3Ew6J
	UGxXqpp8dwuxIB+OyZV8pkpqt2eTH/XBYmPng/tDsh4HYbmmfACUe/AQd1EK0tRb
	/pwHPsowX5zOFukf8pWW1t15BIB0VusRAC3WgsUYuG/RSoobPbYJvacsFVQFyhAz
	avD5JaEk8RHmVSITLiPIhPr5MQaNMAaHXVGSaQpYW5vnAg+iod3OFCVnB27dfyfY
	rnFD7ONaNSAb+M7Iwgia9eoX41aS/RrFOQIE1+Vt5ZmC6FCxZWO041i92rKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771368114; x=1771454514; bh=uINgxocklvgNMF6W0sF6AWYxVtwxj9e3tdL
	amgY+3h0=; b=Rp0hoVIOduS/qT+PzgEOq8VfOYLmUhRgK+2plEdikzHlXWiOk1H
	2vk3+5xFVMjGhEyjY9vzMNPqUejEBROtkNBdFxDt1nzPgyJKcCYkx6JGip7xpnRk
	JdBXQx1kOfbeT0j0fml5zmpDQJ9cDpPYqVUcGDsqBFJNKLTWCPN/FEqr9Y+cbj/2
	4nL1J1lfyqZMZvHcIXqH35XWxicFLNUeAH/I2vvMq5FS1ALSbDdq6G99LAg1j5cD
	N+NY632lAJs0wdSjhasRAZ5eeHAr36q7r0bCT+eDtwEJTh3hNp3uW35FGEj+4WmX
	osnvmXHtyi5dtNGUKnXmS6y+/QDS3Mg5bnw==
X-ME-Sender: <xms:su6UabpQDgWIZJzGkCPHaDOZCgU4lz-ToF2OWjiJ4coZi0JjgE63gg>
    <xme:su6UaZW8iLLa-THCyrHhjFYhxSfeYRA-HjNiXVoOpUlpovqkh8zprJVc2ZXBnrEBD
    Steh9kcs9OZiRKA4RbX9QnXU82h_ebOWE-JyAinG2t4wrIJK3gz7Oo>
X-ME-Received: <xmr:su6UaSCExTWYw2qITKLogO8B_dHtKSgKTzZ907qS9TvUcisJukytNVhskthbxoNhIh2cC1jlsG1jBoQcEmC2nja94coQ1I_ydg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:su6UaV1xO8vzQss-adY5AufKzi59q_OCsOhYEOZfInmt8Tz4X9lRdg>
    <xmx:su6Uac2hWn55vicx7D9Pqskh5CPAevO1Y2wKjB_rfsHpSFCQJcpOVA>
    <xmx:su6UaSAxIbhC6IWsUwdG_rGgQahxd1LyfN1-pwdxsJPtQK1g4jC6ew>
    <xmx:su6UaT4hzU8yocVeQH81bzSuPB-8sr0fAKBOw4fPt9ZhWVZXGYcSmQ>
    <xmx:su6UaQ5xXJ8yoRSCnOcHrUywGqWUTvB_XWP9YbRWzQfMM3Zvxx7KGXof>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 17:41:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mroik <mroik@delayed.space>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>,  "D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH] format-patch: fix From header in cover letter
In-Reply-To: <20260217220515.14127-1-mroik@delayed.space>
	(mroik@delayed.space's message of "Tue, 17 Feb 2026 23:04:39 +0100")
References: <20260216152730.37478-1-mroik@delayed.space>
	<20260217220515.14127-1-mroik@delayed.space>
Date: Tue, 17 Feb 2026 14:41:52 -0800
Message-ID: <xmqq7bsb9emn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mroik <mroik@delayed.space> writes:

> From: Mirko Faina <mroik@delayed.space>
>
> "git format-patch" takes "--from=<user ident>" command line option and
> uses the given ident for patch e-mails, but this is not applied to the
> cover letter, the option is ignored and the committer ident of the
> current user is used.

It is worth noting that ever since this "--from" option was
introduced, it was not used when generating the cover letter in the
proposed log message in the above paragraph somewhere.

> Teach the make_cover_letter() function to honor the option, instead of
> always using the current committer identity.

Also the reasoning behind the rename of "committer" to "from" is
worth noting here.

> diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
> index 9a7807ca71..05c4192dbc 100644
> --- a/Documentation/git-format-patch.adoc
> +++ b/Documentation/git-format-patch.adoc
> @@ -282,11 +282,11 @@ e.g., `--rfc='-(WIP)'` results in "PATCH (WIP)".
>  
>  --from::
>  --from=<ident>::
> -	Use `ident` in the `From:` header of each commit email. If the
> -	author ident of the commit is not textually identical to the
> -	provided `ident`, place a `From:` header in the body of the
> -	message with the original author. If no `ident` is given, use
> -	the committer ident.
> +	Use `ident` in the `From:` header of each email. In case of a
> +	commit email, if the author ident of the commit is not textually
> +	identical to the provided `ident`, place a `From:` header in the
> +	body of the message with the original author. If no `ident` is
> +	given, use the committer ident.

After reading the above three times, a natural question that comes
to mind is what ident is used when this option is not given at all
(i.e., "When this option is not given, the committer identity of the
current user is used for all messages").

> diff --git a/builtin/log.c b/builtin/log.c
> index d43ca693bf..42648dda54 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c

The code changes all look good.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 21d6d0cd9e..2135b65cee 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1472,6 +1472,14 @@ test_expect_success '--from uses committer ident' '
>  	test_cmp expect patch.head
>  '
>  
> +test_expect_success '--from applies to cover letter' '
> +	test_when_finished "rm -rf patches" &&
> +	git format-patch -1 --cover-letter --from="Foo Bar <author@example.com>" -o patches &&
> +	echo "From: Foo Bar <author@example.com>" >expect &&
> +	grep "^From:" patches/0000-cover-letter.patch >patch.head &&
> +	test_cmp expect patch.head
> +'

OK.

We know what filename the cover letter gets, so it is really the
matter of how we want to verify the output.  We know that a line
that matches "^From:" must appear once and only once in the cover
letter output, so finding that line and comparing it with what we
expect to see is a reasonably way to do this.  Good.

Thanks.

