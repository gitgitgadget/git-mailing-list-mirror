Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD048DB26
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176022; cv=none; b=joUkOBzcLxee8c1F7hSiTXetMnqiK9rxNr55XZSRvD5TDgYLrKOKWBmH40fZPm25v2pcqWQzODapJ96b2jzu5iYG2GCVGpce/MIzYFBfGS0P/EelNLpkzXIU4HoreMio2cqzGNNlyDeAkwI5zUx20B0ghGVQe2doZwoJUgp3PTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176022; c=relaxed/simple;
	bh=uO+3TUWRSA0qdQIAmDCpHMKYDN7vo3QDEEnLQQ4FdTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hxgnfjw2msv9VNq0kKvrsWSsQI+pn/UGYbV85SaZaFcJbobsBhmj2rjpvYRUTM/pNMH78hs+1Tj6V6Yq+GyyVLHqM7zHHaIwPbH4ydciG7z0s5Lzuc3DHtNt2I9hfI6OnqIEO8606Il85DO9yPNEbVwcTEdKz2HwviZ8sMycpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TiFJ4pi0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n0HYmJyu; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TiFJ4pi0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n0HYmJyu"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50EAF140013F
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:40:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 16 Oct 2026 14:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792176020; x=1792262420; bh=6EUhhIJ/WW
	IeC3tTf0xQhEUrZTIomMrqmfnv1dzVdEw=; b=TiFJ4pi04m0XFpa8YqCRsRayap
	YqrwU9Z2kGC6EtIih94bnE14SDduFUI+GcVunOvBxqJ5qLJYQicO0WdrFBwNZFwH
	PsJEhN5Opc7obw6BU3jWcBJC9rDVaiUlUzgRaEZDwb4gpeMWIbyyBH2xR1qykdNZ
	jEJBauI28ZXpltGcc+q5r5cIFGtlO84N65WoGFDwv2qMdUyLh3H+xj2IGN9647RE
	QqfX8h0ieZsHWBceQEvT74+dhcr2gk7u+JfZH7aGfSrdxIXSrQIBX6fkZ+EKMBr6
	bBGEFkOuiIz/U25kJkJJHPcjv9t2782RxIKvRK2fS8dhIeMZs2FYujWMSzRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792176020; x=1792262420; bh=6EUhhIJ/WWIeC3tTf0xQhEUrZTIomMrqmfn
	v1dzVdEw=; b=n0HYmJyuqXXzKKTsYsNU864XmV2X41l+Ytrcf2sRTm/pnmS4Zlg
	tg0F/dRcN2ic+J9S5WpuLqrteghP+VXEQFdLjFiP+A0vHv/Gs2rAmewAycsjDSam
	XFrIzF5Fwz728KPyH5SM8+/wK1hqTcgDrnA12MDncp9t/MvJcqtoJJoyAdbWuJvn
	2UZyM3lfn/plEbP/ofszYffXwy2amQvSzvStU55VQ7M9PsG8CWcjncheirKqj5km
	K6sQWjhsrOSm7/RXV2DK/WFo8EZy0bTPMwuNOqLkqJXoXius1i+prgG6DJjDLSkI
	gGBlWn/DCYwC1LI8BzQEroEmJKTW22fcfDA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792176020; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:goqfZMFJCRIaQntmH0y6TYdbLnTglVkrC/PaCEt7+qVXLqW
	gKHNp/ovOTMnfdRsl4L1cQTwDjDdP75JfCjIsWSoN0m8y5qsZgtmc8oYM9x+Dv8a
	l9d72c6W/Sj9wqLFnxg7aMN+l/Gu4Hi+6QI50djNLJODzEInFiSwLcTBVVNv6faZ
	zzwmdtQTQkYtyiZCwABbCQUxlpqcenxv5JbqKnDbvZIMhfgEXXkeWMkILATLiVza
	FM+zyu/z9tozZNno/f4F/UjDtbPAtiIJj8sAAhfOQFevECqTM6pHfsJ4KdDn4Td8
	+EF3uns4ShsRmkyeaizoJnEOncMQBJBNbfXSo0w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:/+mt79MU+YOGpRPbltpBKm5O0KsciYTq67e4ouiakUA=:uO+3TUWRSA0qdQIAmDCpHMKYDN7vo3QDEEnLQQ4FdTs=;
X-ME-Sender: <xms:lG_SasU3d2mhjl6oEWpzo5oGxNQXpQ52_CWHv5IY3-CwKhNC1qQcrg>
    <xme:lG_SakT-6joxhnRDGKquGNd8GpM19jUwDut7rCJIn0PffLEeNlgHLO9eK2NS3d034
    F5phtkVnOAAAuBLSlUjXK1wJANSH12WQUqKIUwh04_ARhebfLOXaAM>
X-ME-Received: <xmr:lG_SaqO18t2gglde__h7sIDojIxILq2Jn339KTvqwc-5vmik_3yXqId9HutEeD_Y3of1TwmI8s3Z1wJvEEtVI_bY8meZPsSpvrhd>
X-ME-Proxy-Cause: dmFkZTEtT376j6BnCOftrbygRqiCmMOvA/+Q9zGY0OabVFdBDgkP3Qvm5JehSsgOZMCpCX
    dHdBu/pPBhSQHOhbe2imxWcpjdashnWAEm2aK/z5J0ogz5rnjwMYscveT42PPFrJ2gt/MJ
    3oQ7MqAxdSGc0aO4QsM393wpXB8pAgzgTzw0WS33YOnNy3N6zcNQBM4nSqRdF5+3VyM5df
    VvsFRwvH+6dDrXVebnItY63QHrNG7BzPcSgKYLwGJYSGxte3rcYbvkaUlUzVfXAJaIZBD+
    XljpStenXm9pCrhzrF9/gKh93nc4WustpMKd78jeBu3RxROGzfCEtMsrsDNpBjQnC44nNn
    wvCF4cdUM173q5qwmbYQZYisua+ZC7SGWhwUL3THJF2CR0cSqKE/Een2K1nMq6/8xBq+SE
    EQFkAiPk0uN+qI57gzCwT4UBQH87PfDyyiP3s5S1J0Asc1aCbi0r97qifwl+7TwaVyPbNJ
    WG8KJqxwY3slv3i3+AcuUgBg6QUbnCZUk6PGW0fP1uYRwjwuYfHLnSZ20AH03FlIUF54Ib
    jDC6WbXfQwVfJ8uNk8fZrE7j0u4l78Z6Sf9r5KJTIVD4gl7HcAH1QDOqUeRPr73hloO3yD
    +HO8CSj2tG7mQ+2bY430z9nA6HfXisw2Y0SnDnMOCG7A/ARgxM8ybWaPjgWg
X-ME-Proxy: <xmx:lG_SaiQ4uT_NBU67qqhjA8hj7Q5dMFo1cJtmhLJFHjRK7xm0Zkp6qQ>
    <xmx:lG_SaogO8-mAbe6fBufXoQpe1wWmo1fwSm0U2oKDP0S0VzquVArfIA>
    <xmx:lG_Sar9-G-DEbSvscFF5s8dyHNpxGewh2mqu6LlATzB2yrrgqO0FBA>
    <xmx:lG_SavEHsaea6IKUW3ymXzotmA43lEE-SzBHil35uG1MYOye5F1Ntw>
    <xmx:lG_SauQQ_QGncOsXbeMGIysaVu6s4h6QvJ5txKVx-t6PpSVCH-MeAkMu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 14:40:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence.csokas@arm.com>,  Kristoffer
 Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [Bug] Porcelain allows creation of '@' branch
In-Reply-To: <CALnO6CA7vxpmhVB3pi3gpVcbtCS_yHtA+a1Ud25P00JDAqboAA@mail.gmail.com>
	(D. Ben Knoble's message of "Fri, 16 Oct 2026 14:09:57 -0400")
References: <4e8d8b75-ddf4-4602-a2a8-26e5214c65f0@arm.com>
	<CALnO6CCph_xC394v_BetLPyoriYc9dLZY42LsXhjVNdvt2e-cQ@mail.gmail.com>
	<958622c0-e0a5-4e27-9815-cd1fff2ed111@app.fastmail.com>
	<2006115b-bcf2-486a-ac7a-681caae686b4@arm.com>
	<fc3de093-a051-415c-b40e-f9df5c914704@arm.com>
	<xmqq4ielirpr.fsf@gitster.g>
	<CALnO6CA7vxpmhVB3pi3gpVcbtCS_yHtA+a1Ud25P00JDAqboAA@mail.gmail.com>
Date: Fri, 16 Oct 2026 11:40:18 -0700
Message-ID: <xmqqld7xfq0d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> But shorthands are convenient day-to-day. What's a bad habit about that?

A shorthand may be convenient, but not all "convenient" things are
automatically good.  A poorly designed, ill-thought-out shorthand
that forbids a branch whose name follows a set of clearly defined
rules perfectly well is good example.

