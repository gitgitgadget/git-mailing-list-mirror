Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B233198E80
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143213; cv=none; b=mFtK/4x2MwPV/b3WjS6FvS/eHl3vbP+YplmKdU1V22EJF5TfPeuxJJdcLu+AtnktAj10hJPDK2xSc/81WsZ44ADGqWXw9jaN0CCEhbklYG5jOlFWWjTQJTJXK6RKEc/3+K4EKWhlowPzwbHnprm5rwJbI7yhBRTJEE0JgmrzS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143213; c=relaxed/simple;
	bh=3DfYLe2WVMkk92hSkl0Ncsnalx8eyBKXUSeo1uddWC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ih7p1uqweXcAFKY9ZDE10DJlHLReZiTqshjr3Il+tJfhx8SUcqwbRKo65ujs2DC7kSW0zSzjM0f2phUZ0s7o2NYmFZRhRwz7uAX+edQVWs+K6yjNzxxlZBDGS3LTpkpR29w+Jjxl8qR/xDCHJaF+PrhzAVu0Q4pnhhpP5zET4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k7l5b4IQ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k7l5b4IQ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C0D122B1B2;
	Tue, 16 Jul 2024 11:20:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3DfYLe2WVMkk
	92hSkl0Ncsnalx8eyBKXUSeo1uddWC4=; b=k7l5b4IQlQwq0rX94pg0GbuaESEL
	JZbExpj/DYfT09QTkDgTaPgpzp6rh+HwawnRP7EndnqNUyLTIf0hA/87HpFzB+rb
	HRYSlF/bu59i15IL2/LCLJvU6NWF9zWvhTpe0aczEXAJZ3QIh461g0QVOlBgNmGb
	JaQh46Hp0w5UrSQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E25A2B1B0;
	Tue, 16 Jul 2024 11:20:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4F2C2B1AF;
	Tue, 16 Jul 2024 11:20:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Patrick
 Steinhardt <ps@pks.im>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3] t-strvec: improve check_strvec() output
In-Reply-To: <20240716043727.GA1429885@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 16 Jul 2024 00:37:27 -0400")
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
	<5bbef273-382e-4096-9ca6-d74781223e55@web.de>
	<20240716043727.GA1429885@coredump.intra.peff.net>
Date: Tue, 16 Jul 2024 08:20:01 -0700
Message-ID: <xmqq4j8pcqji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E02EFD42-4386-11EF-B2A3-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:

> On Sun, Jul 14, 2024 at 12:17:53PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> +	do { \
>> +		const char *expect[] =3D { __VA_ARGS__ }; \
>> +		if (check_uint(ARRAY_SIZE(expect), >, 0) && \
>> +		    check_pointer_eq(expect[ARRAY_SIZE(expect) - 1], NULL) && \
>> +		    check_uint((vec)->nr, =3D=3D, ARRAY_SIZE(expect) - 1) && \
>> +		    check_uint((vec)->nr, <=3D, (vec)->alloc)) { \
>> +			for (size_t i =3D 0; i < ARRAY_SIZE(expect); i++) { \
>> +				if (!check_str((vec)->v[i], expect[i])) { \
>> +					test_msg("      i: %"PRIuMAX, i); \
>> +					break; \
>> +				} \
>> +			} \
>> +		} \
>> +	} while (0)
>
> The linux32 CI job seems to complain about this, since the concrete typ=
e
> of "i" (a size_t) is "unsigned int" there, but PRIuMAX is %llu.
> Presumably you just need to cast to uintmax_t.

Yeah, I noticed it, too, but unfortunately it was after pushing it
out and seeing it break there X-<.


