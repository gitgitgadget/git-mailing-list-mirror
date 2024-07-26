Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87737E
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721961690; cv=none; b=h4sJMI8rssa6OWD197RVv3L8QsEmO5LfTuGPVNRr+P4Gvf/MdN2U9uFx1iSLjZqnWCUFmDF90IsYIkdnFrEWb1IQkPc8u443+AZnYEazfXWIbCYyW1TtGF9T6PAn6F5XJaN2rvCms+7JlUX6A7iA6OqchsncPUKePrEty6x6ahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721961690; c=relaxed/simple;
	bh=FYlnwO4w7SV86Ydj0WYeFDUu/rHwRfNK/43lW2PWFOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bJ1ToAO2/EcbHKrc0VTYRcXaq9flVgqiIsplX5r7BWFIGbM2dYhy/+qoJKi7ga3Ilgs0KRcGcWhlWdKMWQjU47Pv2ZS1aczjS+rxeNkP6QHIBOEdsUZKqQPVA+mOnefgCs5jFEb7mwISzY4o2liQeJFS9T/bwuMEkTx/JyvQ9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z/VK1Ufm; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z/VK1Ufm"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EFB5C1B58F;
	Thu, 25 Jul 2024 22:41:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FYlnwO4w7SV86Ydj0WYeFDUu/rHwRfNK/43lW2
	PWFOI=; b=Z/VK1UfmDxAyPs6j9UysVDdrQAk7QsN2lyU9T0xX8mxn0oQZfUjjHj
	zAwjkxp4CjpwfxcBhSHr9yGjuTovf1znDJWTHFV39yLYph/11qM2Shf19BIjuPyP
	YVe+zuCivFBmno4n7iRseoT4p3a/dg2BLaOiWxzMWQbnT8Y1DRH7I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D89051B58D;
	Thu, 25 Jul 2024 22:41:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BF461B58C;
	Thu, 25 Jul 2024 22:41:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>,  Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 3/7] unit-tests: add for_test
In-Reply-To: <CAO_smVhq=MkQV3a6qJtDiFykvR4im7AX4hMfKMNcL5SegnOSLA@mail.gmail.com>
	(Kyle Lippincott's message of "Thu, 25 Jul 2024 14:31:50 -0700")
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
	<73465c3d-1be0-456b-9471-f875e819c566@web.de>
	<c51025cc-26e5-41e2-be56-94e141a64f5d@web.de>
	<CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
	<xmqqfrrxjw8f.fsf@gitster.g>
	<CAO_smVhq=MkQV3a6qJtDiFykvR4im7AX4hMfKMNcL5SegnOSLA@mail.gmail.com>
Date: Thu, 25 Jul 2024 19:41:19 -0700
Message-ID: <xmqqv80szxgw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8ACA5A94-4AF8-11EF-BCBA-BAC1940A682E-77302942!pb-smtp2.pobox.com

Kyle Lippincott <spectral@google.com> writes:

>> > Maybe it's because I'm coming from a C++ environment at
>> > $JOB that's using Google's gunit and gmock frameworks, where every
>> > test is in its own function and we usually don't even write the main
>> > function ourselves, but I have a preference for the separate
>> > functions.
>>
>> If we do not have to write the main at all, then it would make the
>> separate function that implements a single test a lot more palatable,
>> and we do not even have to implement and call TEST() macro ;-).
> ...
> I tried to think of a way to do
> this, and they all involved some other system coming along and
> identifying the tests and code-generating a main function, which also
> seems like too much magic to me.

I thought that automatically generating the boilerplates from the
visible list of test functions and piecing them together with a
synthetic main was what was brought up as how libgit2 project does
this?  It does not sound all that involved and I do not find it a
rocket science.

In any case, a well written framework soon becomes "magic" anyway.
Our scripted test suite, back when Pasky and I invented it, was
unknown to many people, would have looked very far away from any
day-to-day shell scripts, and are full of magic.  Modern versions
gained even more magic than the what we had in the olden days.  But
I hear these days other projects imitate the pattern, so it may no
longer so much "magic" to many audiences.

If we use a well-written framework for C unit tests, I suspect that
the same thing would happen eventually.  An important point is the
"well-written" part, which needs to hide the ugly implementation
details well without revealing it in corners.  As Phillip said, a
loop construct similar to for() that you are not allowed to break or
continue may not qualify exactly for that reason.



