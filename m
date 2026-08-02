Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720ED2BD11
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 02:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785636163; cv=none; b=HqwZOcfhauW/X7QPdZaKPDVQxYD/F980XjjiOvWweXr/bB4xD9AJwFMtQ5RpXOEOVNuw76fiAHx4UNVXs2nz29skCUWrIKZyD2EIKD1v1fB8AraPpmO5CnVKTGaA2F9cqJl/Qr/oK9N0SWLrZqA6xxz/1umTL119X8ZgtNBdtSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785636163; c=relaxed/simple;
	bh=s8evNl5+ATXrPTpyIRrUXwsrYeibTDzGyTpvv5YTp9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=op1O6j93588vx66SJscUS6Cudeu81uQSFvZeFbbfD7nj7UnOWQY/whAJfcgvXLYE6p1LhKTEf574hs2wmFtKNtucT4ys86LhvmK+xGjMMdwxLO3Zyo0rkULoHaSrAF6PfZjx0pvlHvfJG214fHd5n4XttYJXWNs4MGN7fZfX1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WPDVE+aW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bH/MLL41; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WPDVE+aW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bH/MLL41"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A049EC016E;
	Sat,  1 Aug 2026 22:02:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 01 Aug 2026 22:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785636160; x=1785722560; bh=4PrsOJGNcv
	Pg5uzvoQ+OAZlSJHSVJ1pHJ7PpJ0Na2UE=; b=WPDVE+aWyO5ojgTipWlsuonzKG
	ZgxQ/eJXh2zT51zNHNoTcuyOw07ZEHFJRjcldSFYC/OynFVcqdIvd8p+sOo4KUCL
	swIS3KLcP+NrtJYXQhT7oAPYj/1T9SWRvY9jEZ9tMPrvMQYDUVDaqY8B/oP4pmqe
	hm0ZKTFKk8L4TPzVs6Wm1Xz1F2flBB0fwq50GMhOiWppu75WXkNLSCkHo4O6lHHn
	ry5nQexCO0l6mZG6N4W5xxO/PSN/5lp6Kb6HYGWd3f3kISRFw/4fAm2wrQsjTISk
	6RPWSMNKG347vtuwQtIhXEI3NSRxUnf2+pxNEHXVV2FgIUOx3HMgukDYHVTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785636160; x=1785722560; bh=4PrsOJGNcvPg5uzvoQ+OAZlSJHSVJ1pHJ7P
	pJ0Na2UE=; b=bH/MLL41sV+IObCVgCQNcdCFi9No0IgfulB3KiGGgsPh1qEDJMI
	NPyDIT4wDcw4/rTMEhPJNbwzHMhb5rH8USC20qwQsu7qpnnDaR88MHQ52Sr4ced6
	BE1uU/K+Uah5tV1OcwFswgKKmxSfHHy2ZYAhRuOWlrIeflmwqsRF6uqzIlVt2yQB
	F6iLdP2iEQ32nHSMIOHf7bTNq+hkBQeQh4ZmDQhOMeMJ0JR8mdSXbHys73eOyWFJ
	hLFqwCMJ+jUM/7ESPSy2ARg1YiLLCpdJnXSY04muJQi2Bz3K0qvz/omdhQPf1IKq
	Dd1y2Tnml29Z/ky45DY48la1Ay6dBDGFHBQ==
X-ME-Sender: <xms:QKVuaq2eZ9y9C68kT7J2FtPYRSO5_nANcerYYbEG4wmp5j2yLj6NkA>
    <xme:QKVuagw_mzWnxNr1O8GUtoQDzygBr3FTxDi2qltrOBbt6O8rGAiIksiEZqlFCgbaB
    KRGCas_XFHzJgf_WdOGvXNNRxPfNJEvylUXXwCYktJ92tgVg88A>
X-ME-Received: <xmr:QKVuasv6kR2Mg34B9D_pnLzIXqIKdQEsISR2_BYBNH0r5jq9mx0_WyVNzbTNeofj54O27y823peTJXe9ygPGQxF4TP7_Sl0exQ>
X-ME-Proxy-Cause: dmFkZTE24SJ5KjKKFpS6DQoIEBhhfi7T+erjVrgmBeuMEr3kT5mcJq7biiLi57+fHxOHWN
    04M2TJ0GXRo5q0irUBVtQ50i3EYtT9rkH5aCnLyG+aaioilAYW0b0M4RGpJpmRj4BzZgJg
    bx18yU2lrQkz0NnW5gtuhI+hHXe+jbwy55+9jCDdNiQXiz/GjVEwp7561Z7ST/VJ7oY3Sy
    wHcDAiNcjJhET52eDPNAoxG3vG0rVcGl+o5nC5tO0Kn7vUAzuGVOqEPzvGLv9AYeucrQcW
    TW3LWkBW/gJGi/fAawcnlz5tzmJeDiDeXdDcuDVeGjqlC0e9m4sz2xkjsgEb9qgFkDs4tH
    NFe3PQI0VlmEoFmufk3KVVP1DUCsEOVfBDYgzC4XvefXRpXh6TF3NzA3E+reYnyVJnvbKS
    hOE3jNDXCsSap4AqHG1fv88yREmFZM9+wAX8QY2g0jIa+BRMAo1ITvTrickTpGlJHKn+R7
    q2Bb0X9IMoWVYdxfB3+dH0zttj+iGii2YodfBHYIWs67FE0POcdSKzJWzNU76nZs800g0x
    GEdW3A6HmbnWn+YvWhRRVtQHEmTBWbo5xNNysVcTvLygghwRMI2QalZbQzsMey+gC7r1lo
    Qy+AA4xzcUz3g4Fc4pZp58dN9hxcCkzr9U8TsyXggPOMhY0OBNuV0Fw1wPlg
X-ME-Proxy: <xmx:QKVuaiyai9-Zzvu0PiSyxKsXmRejPvQuGy01PQa-BQ1DIKISLZ4Rlw>
    <xmx:QKVuavD7-UlElgr71jW1gLVZi9fDmRWE1kXjdF95cEaCnkASXPpoJw>
    <xmx:QKVuagcEOggveEnuSTOHngSUlpccvzluGRMtsgakf1P3p1YkNk1G8A>
    <xmx:QKVuapl3znbtHDWhpGTdzO67wjasO_kVNc7tG9i2d5ZKqj5Yx4ZUrQ>
    <xmx:QKVuallq8MEfIqEZGHjsZ96TfCY0sK1_f9qKlpzV6V4mti_DChKPo6nO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 22:02:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,  git@vger.kernel.org,
  chandrapratap3519@gmail.com,  karthik.188@gmail.com
Subject: Re: [PATCH GSoC v2 4/6] fetch-object-info: parse type from server
 response
In-Reply-To: <20260801232941.GA2097163@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 1 Aug 2026 19:29:41 -0400")
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
	<20260731-objecttype-support-v2-4-af577461ed57@gmail.com>
	<xmqq7bmaa0sw.fsf@gitster.g> <xmqqzez67yg1.fsf@gitster.g>
	<DKDYGQRTSF2W.25OU81K306HJN@gmail.com>
	<20260801231437.GA2097059@coredump.intra.peff.net>
	<20260801232941.GA2097163@coredump.intra.peff.net>
Date: Sat, 01 Aug 2026 19:02:38 -0700
Message-ID: <xmqqpl015lfl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> And I guess that's what started this conversation. The fundamental
> difference is asking about one object (and using pointers to tell where
> to put the answer) versus asking about N.

Thanks for framing the trouble I had so cleanly.  Yes.

The origin of the pointer pattern you mentioned, 9a49059022
(sha1_object_info_extended(): expose a bit more info, 2011-05-12),
designed the object_info structure to be passed as a set of extended
parameters to sha1_object_info_extended().

Instead of passing 'size_t *size_p' (which can be NULL) as a
parameter to signal that (1) if NULL we are not interested in the
value, and (2) if not NULL, that is where you are expected to write
the answer, and having to keep adding such a pointer parameter
every time we need to optionally ask the function for a different
aspect of the object, it defined the function to take an object_info
structure to allow us to add new members to the struct as the set
of queries grows without having to change the function signature.

As a set of extended parameters, of course, it was natural for the
caller's variables that receive the answers to be pointed to by
members in the struct.  So the pointers in the struct are
justifiable, but strictly as parameters to the function.

The troubling thing I saw in the patch (and I suspect it was not a
problem introduced in this series, but by earlier changes that added
other kinds of fields) is exactly as you identified.

The pointers in this struct were meant to point at real variables or
structure members that receive values from the function, and were
never meant to be the final structure that receives and retains
returned values.  If we need 5 calls to the function, we either:

 (1) Have a single object_info, and a set of local variables that
     are pointed at by the members of the object_info structure, and
     have a loop that runs 5 times where each iteration calls the
     function to store the returned values in local variables and
     consumes them, i.e.

        struct oid oid[5];
        struct object_info oi;
        for (int i = 0; i < 5; i++) {
                size_t size;
                enum object_type type;
                oi.size_p = &size;
                oi.type_p = &type;
                object_info_extended(oid[i], &oi);
                ... use 'size' and 'type' here ...
        }

     if you can consume and forget about the object in each
     iteration, or

 (2) Have a single object_info, and 5 sets of local variables.  A
     loop runs 5 times; in the nth iteration of the loop,
     object_info points at the nth set of local variables and the
     function is called.  After the loop runs, we have 5 sets of
     local variables populated and we use them, i.e.

        struct oid oid[5];
        struct { size_t size; enum object_type type; } trait[5];
        struct object_info oi;
        for (int i = 0; i < 5; i++) {
                oi.size_p = &trait[i].size;
                oi.type_p = &trait[i].type;
                object_info_extended(oid[i], &oi);
        }
        ... now you have 'size' and 'type' for all these 5 objects ...

     if you have to return all 5 results to your caller.

In either case, you do not need more than one object_info
structure.  Having an array of object_info structures was what
looked so weird to me.


Thanks.
