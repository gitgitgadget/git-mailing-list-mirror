Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2D3DD84C
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184331; cv=none; b=lvQXhUk7QAZ2wseT8+trnChxY3NQEI8iN/zDDS+mJ2D9U3pgD+E2UMUYNcVmVoTpGNwRlIGeKfrMP/o3f9YSNC4V6d1LskYBqXky3o8V2tJqAatoQsaY5g+DXfp3wdEYGm7vYzu619DeudD6YbqRHSZSz6V2hP/QBi+gt17XXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184331; c=relaxed/simple;
	bh=sSRdcjXRSQvICkmohY7As2xnrtjJzH+FWezI3MCZD6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W/7Xyh27psfc1s/tpFEXP+ShqpecM7jDk1/MNDb0jl/otWHF3QNOJCgNjXqeS4Hr/j9ujOBHRqARhqo9TnOj5fg4ueBTZ+5c+7PyMOr7RKfruBJD5l7zvpIcQQvQYQFnC8kxw9f7sALtWYOGaKd64CsmwfX9kUYZwRBQBVd32RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LzR0dHUx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xSBpM+cY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LzR0dHUx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xSBpM+cY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC2D37A0108;
	Wed, 23 Sep 2026 13:25:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 23 Sep 2026 13:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790184328; x=1790270728; bh=NVPv96PZks
	9Y6dOgqnb2TN4PMHQicHk00zw3ubsp6Xs=; b=LzR0dHUxNZ1sqHbR5Y72DiNYFD
	g3QgmpkfbHT9NboHV3YYaUYZjvNEMQpDu6ngwEZGdE8/sbw3VWMSWE5RxZn+KEQC
	eRhcIuMbCqpdhZBapqUzBt9TKEb+8o1xz4W1wz3wQw9QFItiTYsZ9rJmrBeEhPtD
	rIGacyX1Dwn7iRQQLwibWiA//GJyO0Eh9tSyibxEQvNG2V2xNx9N+rPsiAx9B0IA
	u+uF1r+fmMAHj9ESMSv4i0Szh6gmgHLefHIoVbl+H4oRjtVQcFYdEE1wQBUmK+0x
	VAts39h63DXIp6lTgvWT8MwTgndKyRjdTxnd45UqWWHLYtXE8iqFGrNzv/9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790184328; x=1790270728; bh=NVPv96PZks9Y6dOgqnb2TN4PMHQicHk00zw
	3ubsp6Xs=; b=xSBpM+cYpwX3sQVw0lFwmBmmAN+OkuDqerRfvqXhRPW8iuNKQd9
	fBwZWCPx2/4gvZ/4Kv8AEFInnWcVILlhRGDWvOkNXMXYMu+h4aQF4zZkSAef1ZzC
	9kKoP+1nT/o+Tjo6FXKbKUcssDNmywUnrsbCvE79b0EXVWaeBxKjLr/3M98S75m7
	udNv/BpRSI+C8Xy6skK/KdpIldabGewQRkl5R6f5+b9UlqK/tRjiDPq/cgzWYCMP
	RxBWUkXNfa/yIbJkUTJx4bb/4+eqmrztobFqhmo2rqJRu/mNGzZSXF/Z2D6IfxRG
	y4D10+cSDFo/LR37rqEYMFBNWtKaEowLH3A==
X-ME-Sender: <xms:iAu0arl4aK_Ve_Dm4QujgbrJ-a2wP6xLY6_vyvPCEwn8XMzwl6TFNg>
    <xme:iAu0ahZ9MXfd9u7g0PM2UcxeRCydsZBHhnXPhLRt03bCwcrDoYEmkMA6ha8tUhcSe
    HXRlzGkcJNRtRM4sQEDq4rd-BXYY9lI_Oc43qsO8URiY2RGnOUfNg>
X-ME-Received: <xmr:iAu0alTb2SFMqvmK7OAN4VTA6orIVLFMS9yBYZaBZLhKwZ-cg6L5YaTWww-wV9cfE4mxEwyJ06aCDO1IkYVvFMeZNRzqGntsA95Q>
X-ME-Proxy-Cause: dmFkZTGsxmfKlEk4ulD4s5UD5Q/D4DBvHQnGWT3Nt5Kipms17eAB5FzUm0sIoXIwza13jr
    CLygwy6cARxvpdeP/DKDcNC/5yQ3LeEVGEy72j42J8BGj3z4juIcbMg1ip8B3nh/LlguaA
    dXhGbb8gXBRLtGpBKTwdP49gQ9n/rqmT/axtQ8CC3JZvUfi65BOwnrzWvnjPGjygENFSUC
    rF28+5/vuetQ8FosE9AAcSw9tTPi3JKHGAzKzGZEH0qeKTenr+YWeAzXw+QK8v9AjpD6iX
    u26nbuoPlmPZ4rqDlDT8U9fmsYEYxKDB1zlK1nsgtbZ+FI4IhCGXxuvqhLey5T0xZl2WI8
    xVXV9ANDeMRVPeVB2d8sff5CSxQjSUBc/vVQinnJRjVc29K2ZQkknAOvJY8yBGLhRqx0r+
    MSuBiJkR4oHxjwKLbIJMTPh5TsXh179ZR1a+vDFf+SH4BJ4LMvXtnwFIWqWPPf2bOpdYCC
    mX/Lc/LodGTFxyv2OLjTa45KJXMuvs6DMmm11ffv3qh5x7+wusWNnlqITn8q1nrGEzzU5v
    D/O5iiUW3YeiaEnNOM+ndEtByYgMN1OXLiZyzE5tXvJMoYw0/ctttZu3rdJSw7AnZvhHeG
    dN8Vzy4HhPvx1meR2hLQ8Un7IUSXZpIIrWR9o0ReBb7lnBAAnuQPNq1Y3BIw
X-ME-Proxy: <xmx:iAu0ajuQzDtsENjW1i-lQdGKaznkqgi_ol1oBIh5arkPsELU0CDFZw>
    <xmx:iAu0avGakuEYiFWxQvw3VkwlulKm26ZrZsdDLUEEXEBLBLu-7-qYQQ>
    <xmx:iAu0asw0bqi7Lhaoon6o75-L21ncgca-2_Vg01UmEFH2efCkU6xXNQ>
    <xmx:iAu0ah2_chfd_FFarIqRaHpjMtOcusaTEQZFt3bsIQveBebCEOLa2w>
    <xmx:iAu0al7I9JSJ5MUYHzUpbFwMDLJERcuCAx7Od3A3EeUR3Kv32cI5WArZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 13:25:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 1/6] parse-options: add early_scan_options()
In-Reply-To: <CAP8UFD0KP+e4EYVAKW1+6n3og1nzi_+Utr59Vgo8Fz0G=WZ-Qw@mail.gmail.com>
	(Christian Couder's message of "Wed, 23 Sep 2026 10:10:37 +0200")
References: <20260902161047.476753-1-christian.couder@gmail.com>
	<20260902161047.476753-2-christian.couder@gmail.com>
	<xmqqy0djfgmt.fsf@gitster.g>
	<CAP8UFD0KP+e4EYVAKW1+6n3og1nzi_+Utr59Vgo8Fz0G=WZ-Qw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 23 Sep 2026 10:25:26 -0700
Message-ID: <xmqqqzijc22h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Whether the next argument has to be skipped is decided by the caller:
>
>   if (parse_options_takes_argument(opt) && !value && i + 1 < argc)
>       value = argv[++i];
>
> find_early_scan_option() cannot do that itself, as it has neither
> argv, argc nor the current index.
>
> So signalling to the caller would be redundant, because the caller
> already holds the matched option and can ask directly.
>
> But maybe I should add a comment on the line before `if (!*rest) {`
> saying that skipping a separate value is the caller's job?

Not really. I was hinting if it is cleaner to have the callee do the
skipping so that caller does not have to worry about it.  After all,
the job of the early-scan machinery is to scan the options reliably
to find something later in the command line argument array.  The
less the caller needs to do, the easier the machinery is to use.

>> > +             /* Only an option taking a value can be stuck to one. */
>> > +             if (*rest == '=' && options->takes_value) {
>> > +                     *value = rest + 1;
>> > +                     return options;
>> > +             }
>>
>> And if the option[] table had "opt", then "--option" on the command
>> line may begin with "--opt" but "ion" is an excess that is not a
>> stuck value, so we do not consider it as a match.  OK.
>
> Now using `takes_value` in the `*rest == '='` case wasn't quite right,
> as parse_options_takes_argument() returns 0 for PARSE_OPT_OPTARG and
> PARSE_OPT_LASTARG_DEFAULT, but parse_options() does accept a stuck
> value for both.
>
> So in v2 we use the same condition parse_options() uses:

My giving an opaque hint pays off sometimes ;-)

Thanks.
