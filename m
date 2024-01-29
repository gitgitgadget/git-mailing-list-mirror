Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878D53802
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572299; cv=none; b=tlxUljx7h8V/PEo46exoIA5C/r3bcnAPZ0JKOa4V6SbWvoRLNDjtUWD2nOQfuD+du8OZQ3HKhWNKym8mzYTUVGU/3WxqeLv6qhw3wHK42B9H42ZMnpRta4f2NxWMUBvIBYN2H9gRsPN62OEuecK7uTUOwO8Al1aPpSSnVfpPhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572299; c=relaxed/simple;
	bh=YbWJiVJMp0UWuzRCjt+wdAcm0EOTejlQ3qWovut1+GY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OgfffC7Enbxc6DjHtvr7dqdGKa9w3bPZBJLOr5mqh5bGBg1lqetYVVgv74BQLWFraSoiW86llRLIhNfUBG4IwGYQZJvdzDdSqoqrcoKzeJIaiYy5ulIOjKmVZsu/J1wlM4RABY9mpdpzhUjmroEqJOr5G4bBiHZJkWoPqiQ5PEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oCEOOw1f; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oCEOOw1f"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D9AF1D9C98;
	Mon, 29 Jan 2024 18:51:36 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YbWJiVJMp0UW
	uzRCjt+wdAcm0EOTejlQ3qWovut1+GY=; b=oCEOOw1fm4wFU77MNFylQSBurwQP
	pX5Bjr8tFgR+ICrrZL2mic7Arh0lExZl6QHxL1VS5otV8DMJNUYMatJVVMBLk5Yj
	YA+e5gedIBPI8bbAfdJYol7eIwNzUeA67sLv2uGzxTsvJWXW8fTxOa8BAvvjEabr
	RcePmZ1Sba8xolM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 139B71D9C97;
	Mon, 29 Jan 2024 18:51:36 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D34F1D9C96;
	Mon, 29 Jan 2024 18:51:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] t0080: mark as leak-free
In-Reply-To: <c932fbfc-f14f-4403-bfc5-cf1d616b22de@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 30 Jan 2024 00:20:22 +0100")
References: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
	<4adfcba4-0f2b-44f5-a312-97f00f979435@gmail.com>
	<xmqqa5onhjm4.fsf@gitster.g>
	<c932fbfc-f14f-4403-bfc5-cf1d616b22de@gmail.com>
Date: Mon, 29 Jan 2024 15:51:33 -0800
Message-ID: <xmqqwmrrg0l6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 556AA8F0-BF01-11EE-A32C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> The point of the t-basic tests is to ensure the lightweight unit
>> test framework that requires nothing from Git behaves (and keeps
>> behaving) sensibly.  The point of running t[0-9][0-9][0-9][0-9]
>> tests under leak sanitizer is to exercise production Git code to
>> catch leaks in Git code.
>>=20
>> So it is not quite clear if we even want to run this t0080 under
>> leak sanitizer to begin with.  t0080 is a relatively tiny test, but
>> do we even want to spend leak sanitizer cycles on it?  I dunno.
>
> IIUC, that would imply building test-tool with a different set of flags
> than Git, new artifacts ...  or running test-tool with some LSAN_OPTION=
S
> options, to disable it ...  or both ... or ...
>
> And that is assuming that with test-tool we won't catch a leak in Git
> that we're not seeing in the other tests ...

But t0080 does not even run test-tool, does it?  The t-basic unit
test is about testing the unit test framework and does not even
trigger any of the half-libified Git code.  So I am not sure why
you are bringing up test-tool into the picture.

> Maybe this is tangential to this series but,  while a decision is being
> made, annotating the test makes GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck
> pass, which is the objective in this series.=20

One major reason why we want to set TEST_PASSES_SANITIZE_LEAK to
true is because that way the marked test will be run under the leak
sanitizer in the CI.

What do we expect to gain by running t0080, which is to run the
t-basic unit test, under the leak sanitizer?  Unlike other
t[0-9][0-9][0-9][0-9] tests that exercise Git production code, would
we care about a new leak found in t-basic run from t0080 in the
first place?

Annotating with TEST_PASSES_SANITIZE_LEAK is not a goal by itself.
Annotating the tests that we want to run under the sanitizer and see
them passing with it is.  And obviously these tests that exercise
Git production code are very good candidates for us to do so.  It is
unclear if t0080 falls into the same category.  That is why I asked
what we expect to gain by running it.

Thanks.
