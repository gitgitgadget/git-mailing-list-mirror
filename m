Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151371A38F4
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858284; cv=none; b=ei6DzrvS5GpomsZN8vJbNdbbcpKXiNT+NTM0ZSQUQr3jxx4BFdhW5mPfu1yBy1+ATuvGgFm0RgPj+fRIsngqWr1uMUQhkFdQWF+2ms2XQITVNxFe/CPv/i0i7nCp2aoH/aTx3iCCSLzQjsvZuAgQVZ+qjrrRF2fwCR+Z1d6ob5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858284; c=relaxed/simple;
	bh=pjJ4/Vq0gb+Av/GBVkVF4uu9fzXll1Uylo8KrJshSzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FrR15u2OofVlGWXvq8+YYoVALJsVjAxD+c2c3vS/fo6WYq3DN+M1FskI/8e/lZUkZ4QL6fPKiEPFsHatPKgAjWouCrCV5IVBeeSQUQTccYm32wH4BcofO6JbkRDxY8e8Aarr2C/W/lT8475kHoY1xp6xB+2JMAvRtXIhWDbVJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SOv+p4Jb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SOv+p4Jb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 831F42636C;
	Wed, 28 Aug 2024 11:17:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pjJ4/Vq0gb+Av/GBVkVF4uu9fzXll1Uylo8KrJ
	shSzw=; b=SOv+p4JbKfhxT9MagsB8eGXtUz7RnW2Ig9TdZ2lWOkPkxSyn7keYYX
	zNh4dIcrPqUJeD0e2gQhMAWhB+JGyyIi281VUIu1cyprRgyEQYbuAjLec5MfjUjz
	bIpMc3FuB3OTfMmEqzwQUMyGSWD+Ic4oDIEPPJsehz4QSy+ez7wkA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B7442636B;
	Wed, 28 Aug 2024 11:17:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D99382636A;
	Wed, 28 Aug 2024 11:17:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 6/6] config.mak.dev: enable -Wunused-parameter by default
In-Reply-To: <CAPig+cQLr+vAzkt8UJNVCeE8osGEcEfFunG36oqxa0k8JamJzQ@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 28 Aug 2024 01:56:13 -0400")
References: <20240828035722.GA3998881@coredump.intra.peff.net>
	<20240828040049.GF3999193@coredump.intra.peff.net>
	<CAPig+cQLr+vAzkt8UJNVCeE8osGEcEfFunG36oqxa0k8JamJzQ@mail.gmail.com>
Date: Wed, 28 Aug 2024 08:17:54 -0700
Message-ID: <xmqqle0g4qxp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B3BD49DA-6550-11EF-9ABF-9B0F950A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>>   3. the function has to conform to a specific interface (because it's
>>      used via a function pointer, or matches something on the other side
>>      of an #ifdef). These ones are annoying, but annotating them with
>>      UNUSED is not too bad (especially if the compiler tells you about
>>      the problem promptly).
>> [...]
>> And since the code base is now at a spot where we compile cleanly with
>> -Wunused-parameter, turning it on will make it the responsibility of
>> individual patch writers going forward.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> diff --git a/config.mak.dev b/config.mak.dev
>> @@ -54,7 +54,6 @@ ifeq ($(filter extra-all,$(DEVOPTS)),)
>>  DEVELOPER_CFLAGS += -Wno-sign-compare
>> -DEVELOPER_CFLAGS += -Wno-unused-parameter
>
> What is the expectation regarding newcomers to the project or even
> people who have not been following this topic and its cousins?
> Documentation/CodingGuidelines recommends enabling DEVELOPER mode,
> which is good, but this change means that such people may now be hit
> with a compiler complaint which they don't necessarily know how to
> deal with in the legitimate case #3 (described above). Should
> CodingGuidelines be updated to mention "UNUSED" and the circumstances
> under which it should be used?

I am not yet convinced 100%, but probably it is a good idea.

We have our idioms and conventions like use of UNLEAK(), UNUSED,
__attribute__ to annotate varargs functions that take printf-like
format, always using "{ 0 }" and no other form to zero-initialize an
auto variable of an aggregate type, etc., that are unreasonable for
somebody, who is new to the project but is fluent in and competent
at C, to know all of them.

For things like UNLEAK() that require a bit more than general
competence in the language, a bit more thought and peeking the
implementation to understand how they work, we should document them
to make it easier to learn for new people.  

Consistently using "{ 0 }", instead of picking a single random
member and initialize the aggrevate with "{ .it = 0 }", is asking
the writer to pick between two _valid_ C language constructs and
always use one of them, so it may make sense to document it, even
though the general "do what the existing code does" may be
sufficient.

Unlike them, UNUSED smells a lot more obvious, and because the
code base is full of API functions that take callback functions,
we have plenty of existing uses of it for those who are competent
but are unfamiliar to the code base to notice and pick up quickly.

So I have a feeling that relatively speaking it is less necessary to
help new contributors with documenting UNUSED than other conventions
we have.

I have no objection if somebody else does a thoughtful job to
document these things evenly, but if we are going to document
UNUSED, we should explicitly document that it is our policy to
document each and every one of these conventions to help new
contributors.

Thanks.
