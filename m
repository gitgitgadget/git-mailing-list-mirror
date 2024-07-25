Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E712B7F
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923349; cv=none; b=SUidFwiDrZsCyRpfU98ajQXU30cHYbcD7ywi7GnK/iqmNP0xkiCUdNcKTzNbDGWVY28JEIxVnoUOJxvTHpj6cF1JWP04bIiZ8EzPoFCX4MlQO2x4WMKJgKbyjespd9vRHxPRZMdIWgfozIGkr6Tx10JwlIUR1aSEl58AQxEcUOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923349; c=relaxed/simple;
	bh=eUMp/u0C58xtxnLWDWztkh/dPH5bmnOl+Sk9mQ3Yac0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kixT7LFh95kzYGRCj7CY29lrJvl8c50EFGe5lkVx4TOMMQUfIReQY9csURqnM9F8xwBPAMvF59U5KYyvElGZPrHV3sMmSncVNjEeUqsVbpUcQQ3TIYMo8PgjsampWN9T/2nxgYUH6/fYZhfH7xS3/ovkcb2xkT8gWZcsyYbgQG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RPn/4H1t; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RPn/4H1t"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C825E35DC9;
	Thu, 25 Jul 2024 12:02:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=eUMp/u0C58xtxnLWDWztkh/dPH5bmnOl+Sk9mQ
	3Yac0=; b=RPn/4H1tHkC4pSzkHjzDNW1dnk067AsN1uvnpbkvNyoRSOsAFSokae
	25wx71SWuc6WzQ06Hu2p29cFnU9YCRHmAY/LKcDFeOJZRVTkw+mH2Fw8oLtZpI55
	b2GJ1soZ/ogI6DMnJtbx5lhpRPyTRF7ISxle2td0DnhfnuD+5oC7c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BF72435DC8;
	Thu, 25 Jul 2024 12:02:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A9F235DC7;
	Thu, 25 Jul 2024 12:02:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 3/7] unit-tests: add for_test
In-Reply-To: <CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
	(Kyle Lippincott's message of "Wed, 24 Jul 2024 12:24:47 -0700")
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
	<73465c3d-1be0-456b-9471-f875e819c566@web.de>
	<c51025cc-26e5-41e2-be56-94e141a64f5d@web.de>
	<CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
Date: Thu, 25 Jul 2024 09:02:24 -0700
Message-ID: <xmqqfrrxjw8f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 494EA39E-4A9F-11EF-852C-BAC1940A682E-77302942!pb-smtp2.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> But the main simplification in that patch (not using
> `setup_populated`) can be achieved without `for_test`:
>
> + static void t_addch_appends(void)
> + {
> +     struct strbuf sb = STRBUF_INIT;
> +     t_addstr(&sb, "initial value");
> +     t_addch(&sb, 'a');
> +     t_release(&sb);
> + }
>
> -       TEST(setup_populated(t_addch, "initial value", "a"),
> -            "strbuf_addch appends to initial value");
> +       TEST(t_addch_appends(), "strbuf_addch appends to initial value");

Yup.  I like that better when we are using TEST(), whether the other
thing exists or not.

> It seems to me that all `for_test` is getting us there is an inlining
> of the test logic, which seems like it's optimizing for vertical space
> in the file.

I would consider that it optimizes for human readers who have to
scan the file.  Having to jump around from caller to callee to
understand the whole thing (rather, the description being away from
the callee, which is where the most of the logic is anyway) is one
gripe I have with the approach taken by the TEST() thing.

> Maybe it's because I'm coming from a C++ environment at
> $JOB that's using Google's gunit and gmock frameworks, where every
> test is in its own function and we usually don't even write the main
> function ourselves, but I have a preference for the separate
> functions.

If we do not have to write the main at all, then it would make the
separate function that implements a single test a lot more palatable,
and we do not even have to implement and call TEST() macro ;-).

Thanks.

