Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72649EC7D
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151526; cv=none; b=WtTWAuPBZU4quD6+IYSykDN5wdBBkAbwHKl05SnV/8BAlZaVoz+Hbt18NRaaM9SCXYMlkjy538DzWczSV4CgP3DViWuNU7V/r9NHOkDyiQTB6TktfSPSqkOBkmST2Zl/WNXFlX/qjkB4+9o+4lPzu0B1cy/Lla3GOT+UvrxFAws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151526; c=relaxed/simple;
	bh=mL/shf03tp/ilOP6Bu6ihBI5L8mfHUnIOcnnvvG04Qc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uYh1Av9FgN531mfUaG2pUzCPJvWauesU5qhqX+Rl0gzeDQa6IbAaz371InA3pyz62E845yfIchIljU2HXV35QO3rOT0nD2wcwxCrk1by8zOkWwZZIMpKXW9MssOsuxdi7qbD1xQEeVXJEMKhuW5SqUKff0exCs4qCAEJWDdhQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Uu2zjc1W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mmwdPPYq; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uu2zjc1W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mmwdPPYq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 980587A00C1;
	Fri, 11 Sep 2026 14:32:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 14:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789151523; x=1789237923; bh=BNDV+/xSoZ
	862wTNJwpr9cnWjP1RMA8n9Lq3EvmY+z0=; b=Uu2zjc1W8pEwTvskY+w/s+656t
	p8k+21sTQxYj6+yf0luzUs6tCtkBJhoL8q95OVUNfml61inq/YFGIrtGx1a2tv1Q
	frUQFvErQeu5jf0F3P+3R6eNw+wD+3MvycmZcOPvBttHJijNFihrsk/1l/42a6WS
	leoODQxWNlPxa9jOF+a2G945amHu+Y4yeANQuGMYy3vU8zoeiCwqzUCFoRrrlMcP
	UhwONwzVx/OIfCSUHq2UZ+9wEu+SYbpKPs+M2N4cmTz6snfbJI/vSw5kQ4hptaA3
	Njs13hH5kmDXPLPwbz/HAenO3q6B9UH/qlDeGTZ06R8j/ROw2GufXyk/Ufjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789151523; x=1789237923; bh=BNDV+/xSoZ862wTNJwpr9cnWjP1RMA8n9Lq
	3EvmY+z0=; b=mmwdPPYq5wnFvjmD76JIb3PGVG6s9tRZDfO1G1vgbNcByocJnd1
	JBN6sRnjejXWiRixnQ8TGhAI5JchjTwBjZXaqODRlzw5s5ODfDTPjTGIIqmjYxsF
	VfIT/1DlyJsLn8O55WY/68/jXZV7yu6QCUM6uriyuM68TvI2brfZ+gLvuYC/Mn63
	K5LPKlOVUiF4yfrHJnpWVKvOkoQVVV32nNApo5QrVKdW/o26AimKJpASQgpbYzmt
	8XG2FpJosQqs7gBfCcL4lHa9qklTeAcoJs3RsHj0l0mnxjZ9GjsKDzLwQh2t8LKW
	YBOoHpTerIUtAw4bZ0eI+U0YcQ6kCBbMWhw==
X-ME-Sender: <xms:I0mkaty8XKc4Zh6uwH5hcwlGSVnKlwYcIzchWjqYhgG68ZoqgBuZvQ>
    <xme:I0mkav3xraml3HT06z7v_Yp1jhQu_F_EqNmsa4YGI37eFX7sKlsBHBOxtsLzeVsnd
    1xx0KaP3FFDD68QOHPb3n8nW03AD0Vqtt06Nblrp6rU7WDeJz2zgT0>
X-ME-Received: <xmr:I0mkaq8r04j77RBgxsxYL6AFIebSBwYQg5kaIeJdPIgaOqCqykiZFmZyZEaASeGvg2TLZURVq_b2wSS0jY4HePMy68QS7gQlscPO>
X-ME-Proxy-Cause: dmFkZTF1D3Z1l0YPa2ewj8qNlcXqwx+/f9QGbdHEqkiJahrKI193gAsL4Y8XPav1x33oFa
    Lpc55sVNm2U5ZgJknnEDdHaUUISGeoMGDg+o2rL30+4PjfoQx9VC1bdw9Dg7fv2uuh+6jc
    Wm+XFc7cAuoEO+kAejJqZmynrpRQvErF5ZypAIyXV0oltxGAe4Cx8r/WuotDhMLYG5S2aI
    IXrFZW2G3isNsHrNgLOT5G/Wg1l4lgEN31KZaToxzp58KFGlBI3o2huVuoUNGUIAA+EDEV
    jigqOCzSDyw3Hc1x2/Spe8eG3emO74+JBCpd5UdBbPR7lvyHkeyQA0yILdLvJByDC/O+ta
    NgIdPQ/h3Cjf0fmQZVuaRyuNm/1hli8UH2+CMBFVJ4R4B4v6cvzvirxzZHEBjUzulULoGv
    xeSlK/NMEe2trMxHpR2KVgqgF1BD6dAdZyS4oJxTquBBL2qex8DJ4NOq3+RxalJW2f0Qf3
    TLV7rGCQ1liFDZt9ane9xfvuNmcGLykXQ/hCYLZi0RATmxIxVjkxUzTR2nR+Fw6AqBK8I5
    o0HjDWzH/cU/8/r47kyebvRtF0+jTXmWSshXZ9Ggn3r2e/avxibbp3QiEQD1ZGPnbki6UK
    QkNbw41ZcGSzxkT/Qr2G2kk49hZlx7Ul+GGguOTKtSfdXwHzCqu7jcIv1GCA
X-ME-Proxy: <xmx:I0mkavqICRCY7PMFAaZWMPGWEKLx1MjCiTCrkVXvxBLdswHVxDEQGw>
    <xmx:I0mkakQeGPmp-VNynKqXVd4NyBdROMDXGf9QAtU4lR5K6WyQW4816Q>
    <xmx:I0mkaiOxx6pT7THYTZdbBHEX0YnldopLCgVr1f3AtK14_ju_FY3FOQ>
    <xmx:I0mkaijado_7Z_4MXLKITuGKi_nbgdRnI0h4cp_z_Ho5wkoivtYWAA>
    <xmx:I0mkaux2syeEc0Icc8EVVoLQQ__EqGtBqRLYWC-PxBxLVctH0lrBQgrr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 14:32:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Jeff King <peff@peff.net>,  Michal =?utf-8?Q?Koutn=C3=BD?=
 <mkoutny@suse.com>,
  git@vger.kernel.org,  Jean Delvare <jdelvare@suse.de>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 1/3] merge-ll: use strbuf to read back external merge
 result
In-Reply-To: <CABPp-BG9Hkc7i_JxAbYfyzu+b4Mc_pZUr0jJF=vY0jHSARpHzw@mail.gmail.com>
	(Elijah Newren's message of "Fri, 11 Sep 2026 11:06:33 -0700")
References: <20260911171044.GA1609692@coredump.intra.peff.net>
	<20260911171124.GA1610200@coredump.intra.peff.net>
	<CABPp-BG9Hkc7i_JxAbYfyzu+b4Mc_pZUr0jJF=vY0jHSARpHzw@mail.gmail.com>
Date: Fri, 11 Sep 2026 11:32:01 -0700
Message-ID: <xmqq33vfbpwe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> The old code narrows before  xmallocz() , so it requests an impossibly
> large allocation and dies. The new code allocates the actual buffer
> first, then records a negative size; callers converting that size back
> to size_t could read past the allocation.
>
> Would a simple fail-fast make sense?
>
> if (result_buf.len > LONG_MAX)
>         die(_("external merge result is too large"));

Intereting find.  That does sound sensible.
