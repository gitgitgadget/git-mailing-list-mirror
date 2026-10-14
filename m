Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1A053FD30
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988086; cv=none; b=tA8DKTLlDiAQSVrbMUf3EjkQwbRwK54xLycfOnOSLTQJNoqC82S9VA4O47jpLdP5fT/4t01ufiaxpAOeRgbNxoDP2vcN7jynOB8ao3gwa1O6oCh0QCvjcUgik0WmbtrDo0wawXyULLIR8KLNZz66u3GZDQSsVGCiatpPwhl6jVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988086; c=relaxed/simple;
	bh=YQppJy5oA0WQ6As9Lz4qsvRLj9SYc+MUykpBaa5HTVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AiP8BjXRGLTi9LP10L3iGT0r8T2vhZy10Ln3aNvhkYcWsXYKWWWSH8e3om521rijmR7kZESLvW9fJZYE5GmIQ6yAlldmanUclSIXQRt0/c5ISJ1eeQMtqatli9E68YA38HE4wloE+Tn7863ymW/4moUSnTXatrdYjGELMKdpChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p6LwWNf8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pCxYRTyb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p6LwWNf8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pCxYRTyb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CA31AEC012B
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:28:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 14 Oct 2026 10:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791988082; x=1792074482; bh=nr2fBpuRVF
	GvOZeYuJ6VzxGVlF/GDC7LjNJCSlVfX78=; b=p6LwWNf8NTi7GofHmEzlRycPM1
	ikwNIpeS5I+Vo41vWHfHSZBRkWTHOUQmx1OigqvICKArF9ZmPViWoXOle+X4/TTq
	3xdKyyXP3VAhZdC0UA2xiZZefVD7fWU30GwFivL3JuPZYHjOEncPDDN5k7cvPuf4
	DmpmW7VBEIqJg153sE3tCQmPnWetUPNKMyrI47o8nX3MmOtRAsjFBQBQUucf6gQa
	FR7SP3SZ6CgJByT0KAyw/VFBpEUoNx4pd4hX+rzLucC5LA9yXQbXlBSTMegPqphx
	2WWy6Rk/s9vrUS71pHcMAj6GwdOXs7nVd5hHFi9QUuowbcewp7c65JLk3CKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791988082; x=1792074482; bh=nr2fBpuRVFGvOZeYuJ6VzxGVlF/GDC7LjNJ
	CSlVfX78=; b=pCxYRTybVm+ogee97aV24G/n4s/kkske6lQO+mgzKUa1ddUwLg6
	20Z6FQREN8dn9ps1gkXt+hP5DHNj+f186L0P8x4D1RggTnIwwYF6fdcBvYI10wG4
	4MJQXSGg49CFxi1gZzwhrqYZDyTOpyrahtDPpg55bTHLg/gNKq2aEh1mb13ARQWz
	YEC/MLmyBXbOEG4Fc5tFqFHe8WjzM/0WVaugK81Nh8sFGViiG2QfppYsfYi8Bdme
	Y7pv84rKqOD5eCPMhjS1UAq5PYJXqwLQccxO91inUp9+HHu8cr4TZH3KH4CQsnr8
	DIIVTEuhP8nFQMrlli9k7u0BHTtEAnx7hTw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791988082; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:khBbDziEXFYqIY0gzVYWerpGNFyT7kvbbLeAh2BI7h/tquC
	pDMleA6Ko1VaK77GisGInv6MQuPDAGUJ1wRI2WZ6+g6rSW3CY5EDUs5BXx2ryDbQ
	0/071au/Zi4Qo8C+BR+zqMVbl+klvEbLc1EuM6RlBvkd5Vc20TJjXw8yhhBsizgM
	nj6dBtiG3ijbw5GyavUJ1KXKMHAUPTnKS/ZKK9uBP9CSukNyhQ00pUGKLAwHgxef
	SeBvr34cHER/YMPW5LkMwEyma4Dcw7U6MmEPcHwuU9CspIqT4JpU8Zq/wdjoNBp/
	rL9DkVGrvNOPadh+mtldKXR6S44Qte+U9KSgzJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lU0nBgzvQDvOB4DLQB5q1oqWMJWr/pndcPHGYVIUleU=:YQppJy5oA0WQ6As9Lz4qsvRLj9SYc+MUykpBaa5HTVc=;
X-ME-Sender: <xms:cpHPahZtVqJb3C1bhLTIrBEYmnvRbQAai0hNQqMBqDVXCg6JSepEQw>
    <xme:cpHPasF3h2ArZxK4dbnEHwKeTlmzT3yNXmO0rlmJg9dpGtiD6Oe0Vs5uoUsN-jLxj
    p0A3RL3-tzrF6ZZV4k4SxdY4Z1zwh7B1BDCbxTY8272_k41TtswpfU>
X-ME-Received: <xmr:cpHPaty99NuwAPsy3Uij3Gp6scLsk1GAmmsQezRtJU-RGVZAlYBlVuR2RFwBGL1n3C5Jf0gkECsD1hFgWbOi-Cq6Bg8YUOZGgo8F>
X-ME-Proxy-Cause: dmFkZTEpU3vY8Rg8+oCEvLK51z3nTasBzIe+goqZiTkzgMokhINiFjVEpj56zCA/ip+0Qd
    seScTuLKKjpcztGwtpZZoR0UsG3v2rCg06r3ou+OpfMSQ7VU9y2YGUh7ha7+xbtweOeESr
    +rsPJnMicll7vqZJ1GN7lj+TsAvMUdC3J8vdqUgmeMhSHsTDl4FF8dWqXVox07cgzauA0T
    DL9yOORu2vQM/dnlPJfw7/G15kdq/Ro3TwHo1oa/of/2HZf0N/+r0MTNy79HxgYhLnBYTC
    RAXULyZ7W/rnw+6shH9EtE4/C6PCe4zCtUiZCFIIVdZ6oYAoXZoQasfz4jYy6IV/j/Mdsi
    rjsb1wspmqOt7694Mx/ipJ0UWxab+LNrud7xBZaEJ85h5wd0uA1/mVEPLZEF5/k9Rc76Hy
    6AvVTKyW1+wiDMw21hurBmnrGMu1VPEl7cz8mOAqHSHafstsCG6o4U0vtKE7dRnhbekqfc
    MDvp4wnQ3JdweF1goA2ss/fhpnODFE6PNH8F6sS7hb3IhHMfOwkpSQBkow83Uvbsf/i4Us
    67NA1LOqPaEfX12H2qW36tKL4+oK+3u8YS09nfefGmIc1XjsZLSzfHSwOTfkfLGTK6Ea0U
    G1lB6ngn9n8gYfVkEiC8y+DTHdMVPP7CJdo+5a/hbK2n6TiTgOHujxvjBHfg
X-ME-Proxy: <xmx:cpHPamnuhTzPRpvXfPD1sKDwOLKmv88sLt66G8HSi6t4cyBYy85Yjw>
    <xmx:cpHPaumnelbpnnYhRRaQ5gAY_8PUo8Np5TN80owNLRRD2MJ0wpY3NQ>
    <xmx:cpHPagzzEG06a10d9r0Z37HlZ5YFxN_cLivvTf36pC_MLF6RwxD93Q>
    <xmx:cpHParq6rC8MUy4IiS9RW4IaveQZYXIzP5wtrNIL4XZbm1pw6UgbRg>
    <xmx:cpHParJ1jKBHazPzNFb6LknvKnF4Ug3sFUXSWCEvBSx4Ck3MQDVduZmd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 10:28:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Todd Zullinger
 <tmz@pobox.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 0/8] ci: some housekeeping and modernizations
In-Reply-To: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im> (Patrick
	Steinhardt's message of "Wed, 14 Oct 2026 10:30:26 +0200")
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
	<20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
Date: Wed, 14 Oct 2026 07:28:00 -0700
Message-ID: <xmqqwlrktkzz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v2:

This one is v3.

>   - Improve commit messages.

OK.

>   - Rework the "linux-reftable" job to be more useful instead of
>     dropping it.

Happend in v2, IIRC.

>   - Rename "linux-exotic" to "linux-feature-testbed".

This did happen in this v3 iteration.

This was built on the current master, but I backported to make it
apply directly on top of v2.56.0 so we could use ot when we need to
update 'maint' and run CI on it later.

Thanks.
