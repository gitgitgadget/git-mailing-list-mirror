Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427C485CCB
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373982; cv=none; b=emMNiXa7ujZXMjlCRPExJrLrbagWKOEEEGuoYylqKR6/bqZOIPUq9EeWM3AHKHCf/RN0SG/nsSqqQgXFNSrv5cfPtb6ZpHVxeSNiu+sJGKB5hBhxYTGVH73eAeqEbKI7SZ4ix/JTE1m2Jy+E+/g2+LX4nNZe8bNBD67Mesxirz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373982; c=relaxed/simple;
	bh=m1iG/w3zKfL0bTOygiowjZ/P8dqR8e0r5hlGVoDIdj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijj1B7qS8keFFTxnTPp+4E0UmRBPfiML3sqw8n+koxCsqhGTD6pHTN2KisLpyUhSkB9hETWDuDBtmudb5vyYuenTqRPTkZMqoIbXJCa3obVU4I+bIgxm3V0sICt5FOT8bCOGN4t6evSo/BQcU0k7IcO6Ft4InEb2DPmaV1pD6F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pS8LsZwL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RKMGm8fI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pS8LsZwL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RKMGm8fI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D54AFEC04A7
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 07:52:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 07 Oct 2026 07:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791373969; x=1791460369; bh=D2hETRt7/A
	Vh0UmI7o2DFZq2fhlpQH6eSSNy0Xjdvjc=; b=pS8LsZwLiaz6Sw0daubf9baGkg
	MvNskgX33olFMFcLjoe2jyqxup+cXl0VKeufnjftWUj5+hNFUvV9PlqMBZCeLoIx
	obElcoEFsvcUdP3kdrHipz5WdPqQbo0V7DwHFWS1uRR3IUUYbB+sKU+bnWQccoXK
	v1k9lXigBlYBZaiOWBxxC8H0JTJkmc8s3a6aqWiDde8+iFJ8MLtd8V2ZOAshFUhO
	4+CdPdmYKlTerCH6uvgnPw3MBmnAElg8E9fxZ+7E5QuPN9/XMtbBId+p4p8OyNEE
	c+7Q0XCjHUH57QSAQHjN5BWmRSQV+fZMqTlNbjA6WkRgrAxw46+FdP0P8ImA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791373969; x=1791460369; bh=D2hETRt7/AVh0UmI7o2DFZq2fhlpQH6eSSN
	y0Xjdvjc=; b=RKMGm8fI+BYwl92sknIUcGbN/usi6f6rxoCKzuA7beJzIIC2z7B
	W+0r9pjDQCyHi9w8qvar43HGTRhnrGm6W1xG/dpbvJaFsFIhg5gq2evnsDHImLZ6
	O1cw7kY4iZaHJf8JSXwrrnKFcVGvU7UDWfqi5g3puj9EOGkAvHBsIgqgz452JMoJ
	yXJr4iyiKN7KZDTLDo0NWJOvKUTE/IxJMs4RbYn2gwJu14ykXipBOJbHTRu7bslS
	9hMQgBA6IhCi3WNoQXzlq0PBbbrfr4sYz+WNmiu0GlezvBUyEdTuvFOxkhoW/slP
	u8exfE5Z7k+jNxOineIk2q4oD/j7RI0+hFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791373969; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:TtjUJ8C1UeWels3vKdvzXDIGeTSz2MvPqU9SylnEKkam95O
	8fRKD0QoYz8UyHHViJPxZlQxqaSP54GXxX09CImwh1dTiqOe04fmE/cMPsGg8ytp
	Chu78zuO3zTDzPJu71rJxXY3bqAI6MYsarEFuni4k6h6bHQ5l/gLULOLreyn+10+
	38XJda5EBEdO/ox8CmBE+DPvTZOBX+KtQAYt3McDjkbX9moaHlL7f8IHUPZpsocv
	HnieBBrFBdXhYxuEcy+uZwWfIGPHTGiTtLmu/72tipoQrokiERBdtalo/DhE4q1m
	uXv0sF4cSyQBZakqiCiPMFR21wRSwzjscjZRAnw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ofJGFP62bO2E7TuvULJsw1ddyWDf9h3ha2cFqL1gVVw=:m1iG/w3zKfL0bTOygiowjZ/P8dqR8e0r5hlGVoDIdj8=;
X-ME-Sender: <xms:kTLGarvuYlGvWReGhxitJ4pQQkXJnGBydqn-ZUq-sN_AxR-nCnHlrQ>
    <xme:kTLGajdoLivJuOurfU2Tmt2o29c5FrdvE-M1-HHVZGv_ClsVjQdSjd3sDvURom6Le
    kDkVHGSDvG-yq3npdJB5m6DT2EYyJ8-sbF3GgrmMxAB1JVQDE0LeKk>
X-ME-Received: <xmr:kTLGajzXAUezf6QUGqm-q7OeeA4rbleJoReNxaGPBnOc9kGOfpDJVA>
X-ME-Proxy-Cause: dmFkZTEJbknj5BQpsDIdriQ+0yyRVuAWLDBIXfqpgQN6vNykv+ofILis709qoe9lCD7rOD
    Ml3ECEa4/q80kgUtdYYoNcHR3JDgKpiNBnzDOCpvfoDsUKUXK++Mv+cixqXmT2sM4FAezx
    2wCMgAqG8r3PuJec6iN1z9w5c9BAwksYMXexfVu+g3CdbnoFQhkHwJXTcd676O4Ji5h4Iw
    eNjooPNjymB5xM+TNqxfiyIPve60LD35VjfzITPJtAyS+REPTMdXBfeNTYgld7kpJlIvx+
    FFhtyC4nNVuviMWF2qHT6HNkga6Yj6QH7KYPUeec3yIiVEoic2eepP3eNKmFo8gU93zAp2
    Toj8ky/hMk7t+pq5Cox/Y1r7tLIhnVwO4jgNC7pT5pWvxEgZel9UO4Ofev+JEUl6AEvAev
    UDbYq05I6y1WpdK4LVveoce2gCPZ40gq1dBTIkVhuSssG6LcPOALd4gacru64BHBXnYgAV
    SNVR5rAFO512eShkdzXU+W65h+UuwZm2hJ/muhg1e3Q/LQ6QyA+XlwPoQQVhiVGKRklrFf
    inTLJHWwzppIdLhL5yz54W+LY772WCBRR3pD+Y71XKzZt8Lc22nNjBNdRiaJlw7RByONd0
    3AZz5bausLRVUV0+8vC8OEXhGG6ugjUabjrNH6LSrZTsszir81zSgaYq1aeA
X-ME-Proxy: <xmx:kTLGapGamC_tjJtfBaUjxy_SO5SgD0pRyEHDhl7VavzI_-_tffQkVQ>
    <xmx:kTLGanxLxUdh5EaAfjXt1YTjrPlSQQsXlBI6gPNZ36pDZFbCGPJT9w>
    <xmx:kTLGaqvZuD0mIonL3zadKo_KceWjpBB75stEbbffdtvgTU5Ty9GiXQ>
    <xmx:kTLGak1j09bKG9mCEwZJ7k4YmC55b51Om5qlhb5A-6PT7fQ-7U_F2A>
    <xmx:kTLGajwMcMS1fwzD9gXSEBsFO4PCB-6y3ZTfI9LmpTqPPICuki__fugN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 07:52:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af3ee702 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Oct 2026 11:52:46 +0000 (UTC)
Date: Wed, 7 Oct 2026 13:52:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v4] packed-refs: use `fwrite()` when passing refs verbatim
Message-ID: <asYyhHB8DROQpkBB@pks.im>
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
 <20261007-kn-speedup-packed-refs-v4-1-79a411026596@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007-kn-speedup-packed-refs-v4-1-79a411026596@gmail.com>

On Wed, Oct 07, 2026 at 01:20:16PM +0200, Karthik Nayak wrote:
> Changes in v4:
> - Modify the commit message to state the issue with the previous
>   approach.
> - Modify the comment for `record_start` to remove ambiguity around its
>   setting.
> - Remove `write_packed_entry_raw()` and inline the call to `fwrite()`.
> - Link to v3: https://patch.msgid.link/20261006-kn-speedup-packed-refs-v3-1-a1c76b1df9e0@gmail.com

Thanks, I'm happy with this version.

Patrick
