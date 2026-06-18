Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511E517557E
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789506; cv=none; b=AV2JRDXR4VcW8J1+WHi814UoD3z87w8bbGdDXnmhAOtI1B2Y+TSn5h+bxEBqgfn3nqEePPfB6R5cNhPFWYLCaQ1YjU+w3RHqMxzHTFaVGx6PCm41W5WIM4bqfis8sJ8fgMZ2rZkmD3Cv4j2l5xrdEZn2JxNQ3I8uaOA6m3oP/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789506; c=relaxed/simple;
	bh=piLG8D1rukKYsMUX9z7MvBPA/PRHCWTFnIJUAQfue3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uC9lTwX3n0FRUwrql/XNuwp0Y8bP2WxjS/T5ImXLo0lGI0O3Wjo9bjVk9Y4PgOZqjOxzUyNEsggdiDAJrwnhmgAom3AoQxgaxdcLifXKCEYiD7vmqwH/ZZUO/uBmFBb6QpfydbiHhQWicLTGPpaeziESfM6C6X1fPQdDovOEAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XzC0RWKA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L0QYIuXd; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XzC0RWKA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L0QYIuXd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 650811400046;
	Thu, 18 Jun 2026 09:31:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 18 Jun 2026 09:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781789504; x=1781875904; bh=piLG8D1ruk
	KYsMUX9z7MvBPA/PRHCWTFnIJUAQfue3M=; b=XzC0RWKAg6bhNk7XQR231TLplr
	Gdokp9quNghr69/CWH8H0LFKmUz06ymoPMrQXcNzyXF35+ZN49tL4qf5iI0pMaG+
	uUjPGVS+aRHlLAimACNO6wDCwOEvhI532U5V+LWQVF9mSDbNKYrYiGODnqG5vaWg
	13DboeK96reDVJeSrp04S77Askn6nT0M1PvosrN4s0VCBh74pikLLhP0Y74RSm7e
	QTTjZij2KehYekghejNXGxJirVlKNWmFMFVd3glD+8T9SxmvpHwXf6OwyuoVSfuo
	uXPYPGyJHmb5nNzzbuAapvPzZnzibXyTsXC9qXpVBW5qBzyhUPqw2cuLMGRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781789504; x=1781875904; bh=piLG8D1rukKYsMUX9z7MvBPA/PRHCWTFnIJ
	UAQfue3M=; b=L0QYIuXdcmUsrP1PwHm0Ybk+kv7WmASopuWjZIsekkwpQKSpA67
	YXfYQYhyI5T2BTonbs5hq5p2uR+s7UOGNRwV/6lxzLvT0wy/8fxAI45RcDpeyxN8
	EmCC97vgKlcb4hdlryYaeDDtrbxv9ZoFV6LZxkK+8seLsEmm6ddDTAS1AzeELCxz
	f5ZzPKBkiEOZG/yXUqMVMhNpv45SNdALRgh5SzYkiCEB5i5s+4kgz2UKM69XCGJ/
	ss8O7z8yTbU+EGe/Sm+saq7tW7vvtmt0LfLSxPWwpP2rqSOlLSrFIY3CQFfUkAVX
	wUsKxa56S2LO5YO8+aywEZFYOq6XL9D+9Zw==
X-ME-Sender: <xms:QPMzajzQkEgi3q-RK8CItTxFhuGJpjXqEiwafXFw7VWlSkpOkTTJlQ>
    <xme:QPMzapgXh2KbzOum8R29Kk-cw0XfAlgwsGzev05I3_w5Kt9gq9VSoNvCTrz2FSvMW
    VX0xvBm5EP2xYOyymnvhQNUBd4y6qKvx8OLmM05OEkTC80npQUjoA>
X-ME-Received: <xmr:QPMzamrfJdoDPHS9kTQWPsGlTNVyvtKzu68jzxFMNLogwiIWCXLDSrFUw4sP1n5QnuTJXNV4pz1Wquveg0esynS8ORbm1ZnDmHES>
X-ME-Proxy-Cause: dmFkZTFQ1equc5BqDxAMxOuTXmgVCm5bMff2Krw70QToDHb6cf1NiHIo5n6Ze5xDn5Pip+
    p42uiqi4eqYZrSFll0MyNN3uatAKRybX+xU5heqNmilBIGGBfMj+M3jvhQXTGMfJgcIxel
    ZDaqGG438LfanhSYB4FAIwt+NXxqqTwlLpdQrjG9ynq1kR85B4GgD6F7BV00NLc+PfiKur
    qKEu+LEPjgDdTSBaGOHZzCznOKLzblHbAOCEesDxZUDp2f3dB6fAXtwa3qzC38wvepJISn
    PVY5IUBTpKqd5S7g2HbEpmVK18zbFDIX9ZKApRJ5QDWGxGOvBz7U/o4V35FtBx9mr+oHX8
    1eC30WcNK6VnVM5gMFwJYk5O61uuo5E0/veXCvX1opiT8JWbZAKuMi57nnMeqK+bvTiI7K
    9x1DC6UnTK1iA4eR+Bl/U1ZFLfSU6t02LU2nUrrbEzfTnMwfOKqY+QbCsXLqY6buBYp/pW
    0qctDmlF4S36+Ph4i3pICK/VO+pqmVpw2OhsNRvPBtv7H+em5++gWtt1uDh7HkDgZHVpDU
    /Qqo2HZpCIUPsjxL8YjnGBGzh1tLw94tCICQAeiviWiFRVmDcGA9rbQ8L7K78iQAOT8Q6J
    mwR8EHYj0Lf8cLSP0GlebUxtchA0xJalUmbn9lSTtWkBVaLLxzXrxR/V5yiA
X-ME-Proxy: <xmx:QPMzaggvdsFqUS-NwJoYf6IQYXrGMpw6EQ902UpW0UmiW2KQLe9Yog>
    <xmx:QPMzaoNRvqhkLfkY5m03oo7tkxLuoHG9V6GCV5AgKZARZIYLT4PoHA>
    <xmx:QPMzaqzROVIXAnxgsC-ch3pmIBQiWrXVkpFPaIzKdZYsXCt1BjUGtA>
    <xmx:QPMzaqoH4C8G9oErLRdeFxDlTvHTYAHzI2hQqeqVfxW1pj9srSaDYQ>
    <xmx:QPMzame5NzTEsm6gfHgz49wT5fwSiW8tQkChUyFTW6QZBEFgPc-aLzxM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 09:31:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,
  ayu.chandekar@gmail.com,  chandrapratap3519@gmail.com,
  christian.couder@gmail.com,  jltobler@gmail.com,  karthik.188@gmail.com,
  phillip.wood@dunelm.org.uk,  siddharthasthana31@gmail.com
Subject: Re: [PATCH v5 2/2] graph: indent visual root in graph
In-Reply-To: <CAN5EUNSQY2oK7BE4J9Y8APfkP6eJxta050OUu=RoJYhXOjX_OA@mail.gmail.com>
	(Pablo Sabater's message of "Thu, 18 Jun 2026 14:42:16 +0200")
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
	<20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
	<20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com>
	<20260617202744.GA3465855@coredump.intra.peff.net>
	<CAN5EUNSQY2oK7BE4J9Y8APfkP6eJxta050OUu=RoJYhXOjX_OA@mail.gmail.com>
Date: Thu, 18 Jun 2026 06:31:42 -0700
Message-ID: <xmqq5x3gt1oh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Should I work with 'next' as a base to have dd4bc01c0a? (Sorry I've
> just worked with master).

As dd4bc01c (revision: use priority queue for non-limited streaming
walks, 2026-05-27) is already in 'master', you should be able to
work with 'master' that is no stale than 6e148f82 (Merge branch
'kk/streaming-walk-pqueue', 2026-06-16).
