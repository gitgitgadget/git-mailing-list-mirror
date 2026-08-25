Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B38F489871
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672389; cv=none; b=mW1CN2zVVPTQBchzb9fnIRrabzVy3M8zzwUDI26ktRF+MY6x6dmHWfGUbuJwwR14g8bcd72Ye1UqYtuqdXRhtbhmwIqxGe6n2HcleSz14YIP/XOHDYzALHISdMrDWaepXfROVOb9ivl83Dur30FSESn+ZGsylZinwRzg1RkuTC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672389; c=relaxed/simple;
	bh=xX4oOzaBCuIQJmhEtnE6sBhIToBRrtbO2lLBy9GAhw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dc+kVgnocx6sxJqVr4ijTX9LvB78AIzuLO9mltePH2ZBac7ZERhClOQ3x9CN7g2df3BZHzk83MPAd/zckPjXhbTVlTnNEgtyXSawvDw4+Cnvco9SbnEb9pUNc2KbXdJm/o6jrzPCrAN9TT2LMI+uxNsM6fSitjRxy5W1zf6eUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E5d6/q6N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Td/tFGzz; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E5d6/q6N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Td/tFGzz"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1565D7A00B5;
	Tue, 25 Aug 2026 11:39:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 25 Aug 2026 11:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787672385; x=1787758785; bh=Uk8y4QP0kG
	w52DyxPEHDALJsJS4hJfVME0l2Ej1qCOQ=; b=E5d6/q6NA18zPs5pP/H61Logyj
	JzXdeSZmcSsVcGZKuZuSUKP6wvb6FXDpATJnXOmeEho+Jdbbv2JIRiU9ar1YZbyN
	VcaYhrMXaSoWO733XS0Db9RoR+jD24hxSPCiYo8uXt0SKbj7p6pGLhZ+kA3891qB
	zTa9I3xZZzTfwNjLOHtCj4LSzXDXkCUgD5OrC86rhN8ykv8j4lhjKuQIbr9yoknz
	q0RDzV1zuiJtutNgytsDumjFkUFuexXI0ZxLckcwLGZPtULJP7TcGGEG1DlJV5HM
	Gsioo9RZymSY8MM4hT8JGPkmxAl6lR+8qPgvO4Ix9z0NfN4h/L02YFZ5wAog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787672385; x=1787758785; bh=Uk8y4QP0kGw52DyxPEHDALJsJS4hJfVME0l
	2Ej1qCOQ=; b=Td/tFGzzEHEBSMXM6mq9g4mgoVDp9wrKkS2X+EOamUUd+USvPQr
	D9YFZq0yhUMWn645fM172+0jDYFxBRr+tRQ/ulRLtLQeu8ULYe/MArQ+iO2ul6wY
	LSoQEB2Ua2CQ10keYtWO6gWy36ggT0MjHUMr5C9JuVCAMXlO9JOSIDal8X3QFcAr
	ZlnriXFEi56nUtdrjf5H2C7QvvlLoFNxrp1k1rld0JLG5YpYkvVGnK2A+sikT7FQ
	+wptb0tZ/xIVUZafecSWAq6ZyLVu2aNuCeywQXHfpuph/sTF6+4aZw/2YWC6Qgf2
	dqewPVmg/Kwdj4NVHRtOpMLpl+I1sATu88w==
X-ME-Sender: <xms:QbeNavDuwEnZjpaGyismY6N4vKZsGG9dflkziiBRwkDNRtvAEYRBDQ>
    <xme:QbeNas9T49SOthwxZkTe_dPp0QkThcr9lfEBBq6UKVTWSAo0voTPdx6LpVliCdQpR
    UD2E8WBAqjX2uo2u7VYGfZwlhhZ0oxPJ1qLD1NTFD2UlX-aliGIXrc>
X-ME-Received: <xmr:QbeNan-xaNtj2T9lIltP01OFp8FoEPflZzmglrN_E6ZMHYrrt1ew2z5Y_WV5j7HN0xUM6L_Zr2HXK_RmwDQZi6jQIvIcHfDoGA>
X-ME-Proxy-Cause: dmFkZTFw2Hg0ZRfZk4k7wJTqZUMcwH92h+MAFcuXoUiwqu57JI38waw7nFDoBWap7LGxpn
    IlJTcM+P5adEWDoskkU0JjeCv6ClHtQpDLRySbWqsT8/iPgufwVumYif4HWoskBvRjYaOg
    AyAKMD1VJeV1a7zaQluGm1HWybAeBNfxtvMKu6cfhHvdp+FJ9dGY6GFte30H4P04DsRQCC
    3T4xVMT6UP+VY5Uj9Hz7vMBuJ1yYFQM1yVfb9fFrHpsMNP6gaDxs5BE0H2LnNK2vsLflAL
    NuG4bV2+JnNNmiMu8tB1lbOko2iRFFyEJdzzripIccWX3WO+3sVq680pr2GRYzjyDOTXMX
    fjVWo0A/Q5lwITTH41LnVzJ155U0aY135tltoo+kUlToXWum40CBu4QXrM7UvlzC52Rn13
    g4iRxKjHVklBEEQ1bMOwlUyu/1ff1yA8cMFu1IlAMTCV4CWFvXWIV573JoLWhc2rSRSVWI
    O6uaebT558ZG8hcElChwSKDHit+xvPKvzhWjV2p9ao5sBLY687374jZqwDRk8QjelDLkkK
    th8NIGftetuzurX3F+hG71weWJAdqy094l2ncpTDkh3y7WqPoSpwuzpP3Ho2cDWES36cAa
    0KR1AmgA0s7OBOlTN9YsOwhqcr47fyk+nkJkBV7T6uSdOj42GMdSG0kbCQPw
X-ME-Proxy: <xmx:QbeNarcw6ibX89haD9ZvPj74BRqb7Imua0ppx6Y7yF3pMNXNh9uXAw>
    <xmx:QbeNaoGjkP7f14loWg9A8Cqlbq-kzLTFwDRImR_63yt9wkhWHZRA4A>
    <xmx:QbeNahcF-fnJIUv3CdLou5V2keHo3pj2q69onQDqldR5hlr9BznIhg>
    <xmx:QbeNaqHeoDqXlNNMtVxwcp6wc0YGstrl6zkf_RcY73_kQ108GNC5HQ>
    <xmx:QbeNavxdl2RhVwpoZamHXk9x_uc6VWL8NIM4bRoKemyxQHYQHUs_hItj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 11:39:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1/6] hex: add functionality for lowercase-only hex
In-Reply-To: <20260729233215.398654-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 29 Jul 2026 23:32:10 +0000")
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
	<20260729233215.398654-2-sandals@crustytoothpaste.net>
Date: Tue, 25 Aug 2026 08:39:43 -0700
Message-ID: <xmqq5x0yp5ts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We currently allow both upper and lower case for all hex values in Git.
> However, in a future commit, we'll want to change that to allow only
> lowercase values in some cases.  To prepare for that case, provide a
> table to convert hex values using lowercase only and an enum to let us
> choose which we want, wiring it up to the hexval function.
>
> For now, keep things completely the same by specifying only the
> variant that accepts both lowercase and uppercase to avoid changing
> behavior.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  color.c    |  2 +-
>  hex-ll.c   | 37 ++++++++++++++++++++++++++++++++++++-
>  hex-ll.h   | 14 ++++++++++----
>  pkt-line.c |  8 ++++----
>  4 files changed, 51 insertions(+), 10 deletions(-)


Now this is an embarrassingly late review.  I hope this is not a
sign that nobody is paying attention on the list these days X-<.

> +const signed char hexval_lc_table[256] = {
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 08-0f */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 10-17 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 18-1f */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 20-27 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 28-2f */
> +	  0,  1,  2,  3,  4,  5,  6,  7,		/* 30-37 */
> +	  8,  9, -1, -1, -1, -1, -1, -1,		/* 38-3f */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 40-47 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 48-4f */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 50-57 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 58-5f */
> +	 -1, 10, 11, 12, 13, 14, 15, -1,		/* 60-67 */
> +	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 68-67 */

That's 68-6f if I am not mistaken ;-).

