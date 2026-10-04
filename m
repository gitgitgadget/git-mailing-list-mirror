Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E334D382
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791130218; cv=none; b=GIWWNHvgC2AJ2bdhc4OEyj3Xd37A4ShFAvRAz6hzfPXpLEQVz0NWIydfyKt273EsjP/+x7CjMOlb+pnYi/6S27QC31dhVji5ibx0gplt6/TIFm4wiCIxy46BxuezO+RJTPyCaS1JJfGdI/mqomR10UoBQFEY2fVLoYKgzQnedNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791130218; c=relaxed/simple;
	bh=PkmJuZWABpQ1P58MIZhAszRHAvvC65vq2jvLl9muAUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bMy31AkJnBYma//Xo9+xSId32ksZwl7zneDiRpeqVE5mnSqGzpq6nmtWiqUpNKbADfRS/wfcRRA/pNlgzuGkKxJKkvVh4MCCy4boPyun/i09gyYGYWF5eMnph0plhUa/kiB7ILbbfFVU5jAOIs/sjCqffynMdMkh+g3KDBXrLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VtQ4ikMN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D/joS2ac; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VtQ4ikMN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D/joS2ac"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 86E3F7A014E
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 12:10:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 04 Oct 2026 12:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791130215; x=1791216615; bh=07Wrm1yn+1
	oyL0SCGhmaXZSQUP4aHBy5iprIzwNUedI=; b=VtQ4ikMNMSRtbI5diju9OZGXnL
	hynzHFNz1rBkLGn1bY4oFTifZa15JpnO90obWlLVi/ef2JGiPrxaI3pZU2kwUPEH
	Urj8ghf6MXvKpirE/xFjNd5tRGUFh4D91Sav9B1E+tXkhqjCgP+8awBq0Zwg6hll
	scmQIzDRW14AP2zf4PGfayHomcRUHiGx8zQ868zVCRw4Hud3ZZKcd6dQoIlbGQeO
	8NKkZQbOpkoYon3v3/ORgBlhqLqOmVDGprbAbVZnY203ugojyIUKcCt2meCj5Yro
	BzOuiOGj2AQ3YH+5/a0nht53vjSz8L3R631iMb0dBrCIQV/Bvru/6LJNZzcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791130215; x=1791216615; bh=07Wrm1yn+1oyL0SCGhmaXZSQUP4aHBy5ipr
	IzwNUedI=; b=D/joS2acs6Vwwr9USQKxDuuUFkh2vS9Yb2ukJ4AxK6a8R6evVqU
	f9SHN11/sd5o2vKyrpcxKg0/Nfq0pI22hfZvvynAkgWelbqtle578F/zIE62qAWw
	4gpirOnOHVOWSu3nERkNd515MGeYAiaYLSYZ4OsW3AvEGx2ju1fX3s93KRpoaWWW
	4at2tzvQxQl1U2Wue/n3UrgpyaMtuML/RDcREkQprZaGSo2PaguyCdJjTwdSBxxN
	HyrsvGGXv611Whun751lFY11KVblWLd1hj2oiWWdpZ8vGJTQHK9N2TQOyp0vK6Hx
	r5UjVTur/UXjxDiQ6uYKbu+Loeu/2eH5FXQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791130215; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:WwOVnzgCaVqB5Cc5yIDex8w+urnwTviE65NvsSMJe/RNGEz
	CBJak4v3XTZaQKTsPUnjwebMPK+xTY7irXq/OWBIw1lMC9Z05ly2FyafTKv262+4
	YhN12xOjvqd9e47YdHNkpqKARvCtTiLPXa/a1/rWumMLHK0aPFGZFitYE7mN+JHt
	A9JWWJXpDCEJ2ftCPteB1pqhHCIbzJoP8ZWO1DEch4aKAE1xviihKIEXdSYwpOPv
	NKD4JV7ImgxxgcckDWKJZOL3R7tyOXZpevG/yMyWcZnIa2kXRsjAaNvQzXjxgtta
	WXGR9PVHAnZwe/gvCD8LC9So/mvC2M2sy+iU4BQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CgRTvVXnf/1gkLQDHjK/HAGeVsGnQrKLC1jP03CiVfs=:PkmJuZWABpQ1P58MIZhAszRHAvvC65vq2jvLl9muAUE=;
X-ME-Sender: <xms:Z3rCail_jiY-0nkFAaCw3u7QXlanZRfnJYWOiNu5tMKUnSXC97YjzQ>
    <xme:Z3rCag275ZuQL-8BoACsyZywITqv8PXIW_FcBK_BEI_Icf2muH5R2Eq9gQPY9Y6cx
    aKxGrWB4vf0xfqj3ezUIf7Fr2kgIy2HVjZ7o_L_4BeRR4O1xkvC>
X-ME-Received: <xmr:Z3rCalpgxOoAMsj98M_pY_kcWJ4qv4m3Y_HM3Qc5eqd4XmWqRQ6PV7ZKdYRgzLDOyRZiD-VbkJeoA9-KADnO-wO-A4V8rXlgTaFO>
X-ME-Proxy-Cause: dmFkZTF1VQtVpkdp+Jw8w58hM9GYOyd4W8caE0SCPIa8XouslEj1Cyd/p1Bgfz61bt5mIL
    ueYNPkpeopqaSGoGtdDnTx++s/eFzi9DX9ESAj/8b+OZ3AS2DFAVBbCQgzFvzz/Ij8DFZu
    s9ZpL/YQw4rA+0+F9oatPRP7qaoE7lj2fvekyATjtO7Z5+qrRVgxWTzxr0wRdxzrTg2nNl
    pgK90xCu8jLy4n+FYcOD3SiC3Nj4zy8oX2U+k5I6azjh1E+5OMx2sv3sTf5SdUk74QhQFp
    pzT1Sn3hDoCxV/XjAX9GVipfWsV8rQozav/xzUisK48MjLCCCRU3wvp/snN0tkgLNwmoeA
    s5vlLPWvz0n5rd8BEvcrLEwqybOG4S2TVe0F578l00rTjYPBV1KHXMbgZgImGu/2wxJUQV
    YzhyiocVTUtE+qYvQ/fgrpQpQlUf/jlzoAYt2PCwdSDB6oJtdMDMq2/ZM/D6ZQpQxheRKj
    ovTZmR3PwwYCwKTX/iMMj0ufrY6Y9734VCrqfeasaGtbZgqmDSfJmfagNCBUBLi+oFEkii
    s1cVzlw3mYWeMUkGUY54FJt3ekz6c1qg/Z/Sp9tfoBcQU+0ybi9XkSdO47JFCCdNcvtmrm
    vPkQPWQACJYNSwulVA+Rg3QB/Ka7aOGfa2JFEoDQZnY2Brx2V2TIXLWqFUFA
X-ME-Proxy: <xmx:Z3rCalfwRRzemCx5vg074PtTjRZZJ8RDDB_63bnWQHiSqCQUTl4R1g>
    <xmx:Z3rCasq0Ko8PddONoPyfIGcwcDR0o42KDT47Jopjsx30tdvwEiYCzQ>
    <xmx:Z3rCauHDanino7UpSpGDPwIiEn0YHi6XFtmeoXAWojcRNfodvTKdUA>
    <xmx:Z3rCakugyGohwH8fxnW2God_Yo-lkEdymVpNUx5hUb1-hUIQg5Hcdg>
    <xmx:Z3rCasQJq3mPUD9f57D0ozdLM4KWqAXnF0Yg_ZI2gt4iNYYcjaNOJNnC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 12:10:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] doc: interpret-trailers: fix cmd examples
In-Reply-To: <V2_doc_trailers_cmd_examples.d49@m5gid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Sat, 3 Oct 2026
	18:03:19 +0200")
References: <doc_trailers_cmd_examples.ce1@m5gid.xyz>
	<V2_doc_trailers_cmd_examples.d49@m5gid.xyz>
Date: Sun, 04 Oct 2026 09:10:13 -0700
Message-ID: <xmqq1pa5v44a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Fix `trailer.<key-alias>.cmd` examples which have remained unchanged
> since they were written in c364b7ef (trailer: add new .cmd config
> option, 2021-05-03). (Modulo formatting changes.)
>
> Steal how the `see` example is phrased and use that as a template:
>
>     Configure a `see` trailer with a command to show the subject of a
>     commit that is related, and show how it works:
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---

Let me mark the topic for 'next'.
Thanks.

