Received: from fhigh-c5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FD2282F01
	for <git@vger.kernel.org>; Tue, 26 May 2026 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779757924; cv=none; b=Clwk2OQXE084VDDTeHaBUmKLQPwYMvcxxRBhfQ0RmvxJ5wkvtRrCOZJsyawsgG6M2jKYZR6e+5RjraI6Rkf9TLj4hhZYE8+qbzKezcGRE3/ZjMtEGrxEuh1E8ZFUHu4rP3IhB1IgwqsKnCQRIAO6G0u5pbX3JdVBpNZoYhg12lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779757924; c=relaxed/simple;
	bh=iIj6DFi4N359nQYSZzaf4rppzWkvepJjBT5mS/jKB0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YeRwfQPqQGe5dI+v9KMj/z6miOpgADqZhbkC/Gcuvm6XwnPoH1w0cjRoIjt1Um+sA/gkBUOV6jBrfO7YC3sV2Id0a6hJrJa7sDL7DeMkAqrfbFrggIijNZMUqfFWmhBOfQJg9hK90T3OqsWcNGHVoU2t8zL55rH3uDeb8LYmeNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wy4TJCT3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U/TAtRRP; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wy4TJCT3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/TAtRRP"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 45E277A00A1;
	Mon, 25 May 2026 21:12:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 25 May 2026 21:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779757921; x=1779844321; bh=ehT+W6kGt9
	XXmGc9AnFjZSsgFqmeXz+OKsFtLGZt9wE=; b=wy4TJCT3vmqaY20kIvF520sijq
	BehxUwiB7N33lXNOjF+wppLTlWCesTVmoSxlkhzAGhRvDYjGzqd0euZsZfPw63Aj
	ytj+fRIdyV5gEMzADDh28OzgZIMc6+4/dBBWsa8/p2UJfs8UpiFthocjvQVJecSU
	nXqXxw24ZG9HHs9E201Q9VH2oA3XJfyOaHbNEisNTKmCgK2kc8C7IVYuPWwbgjnp
	3DfPVY/v325wGn1jmnTD+sOiyOJCI67c1QdIIV58i9e5f2BdkAu5JKpd12VdYVrR
	lB7YG23D2K4OyR9G6kF/R9CUy8JcfvibU+kdZLMD4ORIfQLqLdUXdlYtYxqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779757921; x=1779844321; bh=ehT+W6kGt9XXmGc9AnFjZSsgFqmeXz+OKsF
	tLGZt9wE=; b=U/TAtRRPs7xB07s8tNEfvElNT0KMQeQhYZzPPw28/brJVdZ3Jul
	WXY1uigo/CKVZY/AlUQs3F3fL/SW1PKCGqmA8ES7JyuFSIHWQ4C5wQ0WZu7y4w7q
	UaI4x4nhdaALYCMaJ/NhCrNXg1hH+foONg49k2Vcjjrd1bbQnGCAfe/j9hK8m4B4
	Dfn7hZTmEvKGHbm02WxWn/WvH7qbfs/kI/WjaLB4/2BAcD7CLdQyzFot7QfhEpYJ
	GvdWqNLzxqpo/91Kx7egJM5sBH/nBBz+6LWUPyAMYDbXTfZZNH2FY8Vv3YpQoQtN
	dZq+pYKjT00r/lV5teTAmOnKnORjRUyJlYA==
X-ME-Sender: <xms:YPMUanb6KTgDzKC5c3yjabW4g1aDYJstsCsmk4rlNauRo81P1JcEXg>
    <xme:YPMUaqHpHtGCOTjJ_Pc9m0F3rvJMwIvXbYzOPAW3MzYZLOJTA7nif-N5k_SsvF4MA
    XRFcT8-5vx61ImHhYADID_IwXbj_0hXhapB2oZD-IfjTvDiDRqw>
X-ME-Received: <xmr:YPMUajx6PxdCjZa8aFxFm8VyZskjgBMm90CHgxhV7fDHZul5rB6jxomlq_P-6VhIHAa6O9hpAR6levVAKBWN-9f1lC8qPePELGRW>
X-ME-Proxy-Cause: dmFkZTEJmizKhr70z1V6rZxkCpYhxnQO7iWKon6mqext5LeoYOgsKt+sx1fvq0t3m1smSI
    JhSLJYofg6h2hqYxXa/w0rFGVwTUHflbbKTouei3q2gWt4QDynF/yVjH4ydDjE9Ww6FRJW
    YFacTFWf8TYJCRymTMiSR45wjBO3D2zJfZn1VvMO+9/CSXKcHpOl9ryp0GbbG7FEFbg0/l
    OK3GcxGhiQeNTpIye3jOBPAeeoXOytoarNV4+QEReLbCzpXfvSAsV0tf6Xz+aAQ5jH6aI/
    7tGfMEOZ6RCcCdX/99ZQN+UYFSiq0VOyEcifEVV23SYCWlDUl4LQSt4xSNYpgJA/4KqSJ6
    s4kkDcmQ/CwubHM9rGNS7/8ile0mH6QHsMY+VUADngEFiBOVFoExKXegknqvIS76Vbdc3N
    IemO7rkP3RDDNFSjexIVQFmEwGdSaJhocT+UTacFVOsKxePiXUePQ5Aq9jJaPppvGCV0Ch
    +TwYLr+Te+eL7URUjXoVWezEqmcQZI5UkKRZCmJzu/pAHv0kXQYifpIbNQUypsPU7/Strg
    8OPtPVS3zmW4IFYuGHQhUrM0W1dj+5fSNToC9qFoHWvXQBHs1O34yjMK0dEwdg4//k4eDi
    1crDJ+mHan6lNiaevLGOpStxsRGDznW8e+89OZHaBeFW+IO8gUOK1ROw8OPQ
X-ME-Proxy: <xmx:YPMUakljFokedqcj3Kt-x4_d8wYGa638e83DJHgpqfW4fhrp5dsIKw>
    <xmx:YPMUakmrfbcvQtz58KtSwd5Jvyd201MQLPf27WYZ18AZogrwohtmVg>
    <xmx:YPMUauyi4cyacAXN7vi9mx_DS8aT7TZk9PaQe5zKWZz4v2FO7lpjXg>
    <xmx:YPMUahrdCtwJP3MK926zQkX6BOFEbsjRUWx9wti6BQ9LqiIIlapS3g>
    <xmx:YfMUaiohH1Pv1HfPlI1ir5ghR4EQnEORv6nESZYuXbjyKlUOs74UgaME>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 21:12:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Amogh Dambal <amoghdambal1@gmail.com>,  Jeff King <peff@peff.net>,
  Michael Montalbo <mmontalbo@gmail.com>,  git@vger.kernel.org
Subject: Re: Expected test suite behavior
In-Reply-To: <ahTsTDhVPkHTEbB_@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Tue, 26 May 2026 00:41:48 +0000")
References: <CAC2QwmKgQW2c6_OhepsB1hzXYHxpX0X4eyQS0dPcxRZLOnCdig@mail.gmail.com>
	<20260525072711.GE2737798@coredump.intra.peff.net>
	<23221493-ea81-47c3-9647-6c6ac8d03360@gmail.com>
	<ahTKq_zCmEDJpoN5@fruit.crustytoothpaste.net>
	<4649049a-ded5-4cc6-bc2b-d5f543e6df99@gmail.com>
	<ahTsTDhVPkHTEbB_@fruit.crustytoothpaste.net>
Date: Tue, 26 May 2026 10:11:59 +0900
Message-ID: <xmqqa4tnnfds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I think I know what the problem is: you're running as root.  I suspect
> `test -x` in the test says that you have permission to execute it
> because you're root and root always ignores permissions.  My guess is
> that most of the tests you're failing have to do with permissions of
> some sort that are being ignored because you're privileged.

I know !SANITY defeats a-rw and lets the tester read or write to the
path, but this is the first time I heard that !SANITY defeats a-x
and lets the tester _execute_ it.

I do not think we drop POSIXPERM prereq when !SANITY automatically,
and I do not think we should, but we should probably have an
automated check to drop POSIXPERM?

    (
	# is an unexecutable look to the user as executable?
	umask 0; >testfile; chmod a-w testfile; test -x testfile;
	status=$?;
	rm -f testfile; exit $status
    )

> I'll just note that if you just want to do Git development, macOS is a
> fully supported platform on which to do that.  I will admit most of the
> major contributors (with the notable exception of the Git for Windows
> maintainer) do use Linux and of course I like and endorse Debian, but
> macOS should build and run just fine if you prefer that.

Hear hear.

We want to encourage developers to do more _native_ development on
their own system, and this is not limited to macOS.  As long as
users on a particular platform rely on working Git there, we are
better off if we have more people actively using that platform to
build, test, develop on, and debug Git for their own use.

Thanks.

