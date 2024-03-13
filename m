Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657761A38D7
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355189; cv=none; b=o2oSQMKmjytG3DNWhIpjB+LW3nRHsZdAzDiM/qnbT5URQRTApXyKDDQ3EHoH5WnGpf+vEiILQLBu1UZjaLcl6h/jOdIhcnU4Mcg6caRb4VAwYnu2+GISroDCHsHjuKrCB7yZWRecN/ycM8O/opdS4fc6d9kSz9NEZbn9eA6i1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355189; c=relaxed/simple;
	bh=cUjrHA3ojc6WgzZEcmpoAeWiUJmwKtSRlYKeWAgZO1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y80qE8iKM/tCDOAxvxlSSd0les8TqFslSbfD6ADaYwYRpIBPtTdZjKH7b7fXVVtpCe9CS0wV8/9vzppfAk8NOvzC9BQLcfh0AfAMIy0TFbGyrDKFuuF2Q/MlqmCJvVvFiKYNrQVeT700HSJ7Fs/E+rvjUKeS/iFGycmDP3XcyEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x4qLziDP; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x4qLziDP"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 392691DD719;
	Wed, 13 Mar 2024 14:39:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cUjrHA3ojc6W
	gzZEcmpoAeWiUJmwKtSRlYKeWAgZO1c=; b=x4qLziDPgqfgCvRtRhZc5b5ya6MD
	X1GttxCdQlKKjDxUYyYKhlXjH6lSHhI0NaVT8KIih9tBs+BE3j1L+9f4Hk5/UqTE
	5z060OMUASFz4HUzzIGYdTUCElSY3fwn4fv08vzMlNtWWQLKRnTiFcj34MUGbHNF
	DfQtKUzOfnoB8RI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 300891DD718;
	Wed, 13 Mar 2024 14:39:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D7A41DD716;
	Wed, 13 Mar 2024 14:39:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Jeff King" <peff@peff.net>,  "Dragan Simic" <dsimic@manjaro.org>,
  "Manlio Perillo" <manlio.perillo@gmail.com>,  =?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  "Phillip Wood" <phillip.wood@dunelm.org.uk>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 16/16] config: allow multi-byte core.commentChar
In-Reply-To: <0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 13 Mar 2024 19:23:25 +0100")
References: <20240312091013.GA95442@coredump.intra.peff.net>
	<20240312091750.GP95609@coredump.intra.peff.net>
	<0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
Date: Wed, 13 Mar 2024 11:39:44 -0700
Message-ID: <xmqqle6mascv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 10476A9E-E169-11EE-B157-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

>> +	(default '#'). Note that this option can take values larger than
>> +	a byte (whether a single multi-byte character, or you
>> +	could even go wild with a multi-character sequence).
>
> I don=E2=80=99t know if this expanded description focuses a bit much on=
 the
> history of the change[1] or if it is intentionally indirect about this
> char-is-really-a-string behavior as a sort of easter egg.[2]

> Maybe it could be more directly stated like:
>
>   =E2=80=9C Note that this variable can in fact be a string like `foo`;=
 it
>     doesn=E2=80=99t have to be a single character.
>
> (Hopefully UTF-8 is implied by =E2=80=9Cfoo=E2=80=9D. Or else =E2=80=9C=
f=C3=B8=C3=B8=E2=80=9D.)

That's definitely an improvement, but I would say that using a
dingbat instad of "foo", and "single character" -> "single ASCII
character" (or "single byte") would make it even clearer.

Thanks.
