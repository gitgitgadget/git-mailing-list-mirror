Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310DE17DE01
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021481; cv=none; b=V34Ai0a0uQb2W6yIXSwoW/p6CTn9ZBxtIUAloMfprT3CQQ90vvu1qmCZUroi4QdDFNjFjwmU4upD0NRfT8E8x69UBn2pjou1gT2/ZXBaihssPWqgismMXShApX+eZq7ZT8EvxiaFLaPaHAhS+grDZ2NNqFnI72aZGsk/0Vm5sNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021481; c=relaxed/simple;
	bh=BJm/5sB2ErxAqqPgAcD5yBV8MVMa67Y1bwHbAWLywNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PENoQLSKA6ajk4+2slbyjCAeE7WvvhnasxWmXvJf64XsvP3Cnal6w8OcP2gYilq0b/ouqJ0JMg4sG7/cZYuHEfxFklnuR1S83i4y9MEUfjFyNfYjva1NrUlgQaK9M1yDVRdNoNyzDyS0du/rAorkwYpVU1W/O7O+qjFTQ4Ox/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yX28fwAq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yX28fwAq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 111C61A734;
	Wed,  3 Jul 2024 11:44:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BJm/5sB2ErxA
	qqPgAcD5yBV8MVMa67Y1bwHbAWLywNc=; b=yX28fwAqpuuawKdOfNlWMQyXwz5D
	eeSWmMtSu2Vb/9QG29bOaAVy2rhJj8CZ3EGzZ63oHnZ9qah59HPu9nls0VyvBMaW
	TGrFaW/9wtaBInipwHLAq3Bix2KYIj5ke9m95BVPqANHG7yEvordG2EQuSkvCEUX
	RDUbPuPRdNTOUFw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 08C1C1A733;
	Wed,  3 Jul 2024 11:44:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3DB351A732;
	Wed,  3 Jul 2024 11:44:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v4] git-send-email: Use sanitized address when reading
 mbox body
In-Reply-To: <dbdaf27a-4b11-44eb-ada7-9991628a47ce@prolan.hu>
 (=?utf-8?B?IkNzw7Nrw6Fz?=
	Bence"'s message of "Wed, 3 Jul 2024 08:24:27 +0200")
References: <20240701090115.56957-1-csokas.bence@prolan.hu>
	<xmqqy16lvtix.fsf@gitster.g>
	<dbdaf27a-4b11-44eb-ada7-9991628a47ce@prolan.hu>
Date: Wed, 03 Jul 2024 08:44:30 -0700
Message-ID: <xmqq5xtmfpk1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 241C941C-3953-11EF-869B-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Cs=C3=B3k=C3=A1s Bence <csokas.bence@prolan.hu> writes:

> On 7/1/24 20:47, Junio C Hamano wrote:
>> Let's mark it for 'next' soonish, with proposed log message
>> rewritten somewhat.
>> Thanks.
>> ----- >8 -----
>
> Alright. Should I re-send it with this message then, or will you amend =
it?

If you are 100% happy with what you saw there, then just saying so
would be sufficient.  If not, you can update your commit with
further improvements and send a v5 iteration.

Thanks.
