Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316B17166D
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721677024; cv=none; b=VLas0WtjrOP1JMgdeG6In9/sQu2EVS7Ug7TbKsDfmS7M+6fPuqHo5n/lZEwSQCXU6LZXQGdKXDbfmGaizD+gcJXqR9rQxi/tvuBxaAj9IKHs2l6ZpZcJ+DYyhhes2sM7Pn9qnaJeAd704+VPNen1qLpKcnZv3zLmLDSQR2R9oT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721677024; c=relaxed/simple;
	bh=OXjv/T+tg88xveeZT7v9eywaqF7HupzJFFXh50OVYIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KpQ+wlFqZfq9CucjhLZRhhJyUKgkm7OwxCiobJmma1teQTpJ/m2SHc5QMNoc7mJ4AMP0uWvRAHnrFawpCayD8zO5pFQFyg1/gACGNuqzyXWiPH6VEHWiTK3lTNdPOHh5q4RvDLE6v1B2PME5Z6osW0n8QM6/EPBj1mbubaWdn90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ntrP8p9N; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ntrP8p9N"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 72B983C2D0;
	Mon, 22 Jul 2024 15:37:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OXjv/T+tg88xveeZT7v9eywaqF7HupzJFFXh50
	OVYIY=; b=ntrP8p9NVLvNLFM/JVv40nCMCMt3/GzMdXBVFuPGQmYSZFOeB1Zs/z
	mACZG6xJFgm6hG0llSpyDiNpaaFLODS2NiTE8Q6OKSDa/SlTtljKOhPUcgpLvWCv
	vQYEB/1yaCjvyvb6vP82s74uLgMe5RXy1sIb6gu2q1hH2fPANu+UM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B2523C2CF;
	Mon, 22 Jul 2024 15:37:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E12973C2CC;
	Mon, 22 Jul 2024 15:36:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2 2/6] unit-tests: add for_test
In-Reply-To: <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
	(Kyle Lippincott's message of "Mon, 22 Jul 2024 12:13:00 -0700")
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
	<da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
	<2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
	<CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
Date: Mon, 22 Jul 2024 12:36:57 -0700
Message-ID: <xmqq1q3lb4me.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C2D26916-4861-11EF-A0E0-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> I can see based on this description where the name came from, but
> without this context, it's not clear when reading a test what it
> actually does. The name comes from an implementation detail, and is
> not describing what it _does_, just _how_ it does it.
>
> Maybe a name like `small_test` or `quick_test` or something like that
> would better express the intended usage?

Names that explicitly have C keyword for control structures, e.g.
"if_somecondition_test()", "while_foo_test()" or "for_test()" is
vastly preferrable than these, in order to make it clear that we are
introducing a macro that defines control structure.

>> +       for_test ("for_test passing test")
>> +               check_int(1, ==, 1);
>
> I'm concerned that users will write this like:
> +       for_test ("for_test passing test");
> +               check_int(1, ==, 1);

And that is exactly why we want the macro name to include C keyword 
for control structures.

> And the issue won't be caught.

You are right.  Making an empty body somehow catchable by the
compiler would be a vast improvement.

>> +#define for_test(...)                                                  \
>> +       for (int for_test_running_ = test__run_begin() ?                \
>> +               (test__run_end(0, TEST_LOCATION(), __VA_ARGS__), 0) : 1;\
>> +            for_test_running_;                                         \
>> +            test__run_end(1, TEST_LOCATION(), __VA_ARGS__),            \
>> +               for_test_running_ = 0)
>
> IMHO: this is borderline "too much magic" for my tastes. I think
> having multiple test functions is generally easier to understand, and
> the overhead isn't really relevant. It's not _as_ compact in the
> source file, and requires that we have both the TEST statement and the
> function (and forgetting the TEST statement means that we won't invoke
> the function). If that is the main issue we're facing here, I wonder
> if there's some other way of resolving that (such as unused function
> detection via some compiler flags; even if it's not detected on all
> platforms, getting at least one of the CI platforms should be
> sufficient to prevent the issue [but we should target as many as
> possible, so it's caught earlier than "I tried to send it to the
> list"])

Interesting.

> If others agree that this is a good simplification for the people
> reading the test code (and hopefully for the test author), I'm fine
> with this going in (with a different name). I'm not trying to veto the
> concept.

OK.  But what you suggested in the previous paragraph has merit.
Are there other things that could be improved in the existing unit
test helpers, that would help those who do not use this new for_test()
thing?  Let's see how the patches to improve them would look like.

Thanks.

