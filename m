Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC984ED180
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474859; cv=none; b=pRYlGx/kiWU3wvXsEzS8uXKRDALHXhT4V/mQIzuFtxSQ/dxI4SC9V1XA3iANfJzK5hbkh/bQGTAySzu7jRSLghLLa1eDtS0Wdf7dJcQZlKokBjycg/JMI3lGRBAeNLNnJhmT8nUGskdaS6ArZfLRrHSJscl2yvqc4MTPqfb4roo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474859; c=relaxed/simple;
	bh=wHR65/A9HU1gjbzLZZyxFcJqIlP7k6NX7aes56wMHy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HwoFAeo9dyCLTvJWkB7XVUa/nv9l6v60S7n08mpRNwpHXFPJQ1YNTS5bFcDk+eutCsltTSNhjt8Lt9S5dJCHRozz0F+N9SZ3Z55EjyQTZ+dG/aYiZCxf0AA5Vjm6JWWI1gdstH41QsCdwdjP0qYnOUQwEno4MLWKnbno8wkUDuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AUm9iGu+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iFDnJ8Vs; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AUm9iGu+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iFDnJ8Vs"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 011471D000B9
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 11:54:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 08 Oct 2026 11:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791474856; x=1791561256; bh=hL+3DSLKtO
	GeU9kZPzM+hrXC4f0IzftuMwu4DelDpRA=; b=AUm9iGu++lDG4c/+WuNQ8q3W/P
	X3LbdJBYjo/n44KWVyP0CWm1/prrRhQ4bd13B6fWjfIPt+vkBCidRR2TS5RUrnq3
	5sjOmfyyhtwtwS3Ukn5ylDqcBPUnP61vP/g8zvtP9jUd26Usf71SRIfyagaz6gMQ
	DlbkfrsnpUFICGYAjEmb5kLbMCvxICmasp0lW9ViLTApimP19+R+75CULx5eh0C4
	0Hdjm5b6TzarTJt77aiSu7PNMutjvielItmci9/sxJL/2sJGr45OcykXC1K8Q2Fg
	W6iPLVEuVMWnUWT4VWj0SNpxTEhY6Rt6PGzxvWwwH7ooZm4W/hUIvD3TVfzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791474856; x=1791561256; bh=hL+3DSLKtOGeU9kZPzM+hrXC4f0IzftuMwu
	4DelDpRA=; b=iFDnJ8VsjJRdGGg66ZpnPRuGl8BodxB58zuWB8t05R/QSo/8JXo
	30YTI/fJIeaGq+cPfjw3IvGCodcvwFZE6krE3lucBmGwTXXbT77XmvR+bl6dD0y2
	TKzf0cr/rpdxdfuk2+R8gQ42HndXiRCSc+kw3Vdc3IWw95OkIGhrlVtJ1tnXvHuh
	of1+MTqj7wVu0t5ZW9uAyZgpLp40q88TS52O9m0wWKwRGt4StTVFZD32wsFalD6w
	g/RNiykU9M/HzynxIFTKXXBDOP2GjVU0o8zPDPFCG3scyHT52GNRkPyO7AgeNXRa
	CYwLpa1XgR8qf+MJhi5ba/eQxNr1Bi9AXnw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791474856; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MDv23iXm+B6Ls6F81c+AKXY1AUKk69toH/fxsVtF8qtjwlR
	8a62x7DGmKl6VmrGOIj/WWYKYfzstYWx0bVTUXaZu1HzMn2l8EADSUBWNMJVTOIw
	v4AnkZW5v1Fb9XVn7fdo3EW50NoWAn7tbbTwsNnIMu0HBKs53XmhhqHoNLZjYM0W
	ptR5oCou9kLMFB3+7eCf1jEDQBFMA5+psd0tY/42D49HaZ0RyDEwQf7fnO/2Ofnw
	NzhfwNVCkKvvU3Srec3E5d8sISnwb03POogXySwfKRmxo0XjXPjDb0NL9TsuR+wy
	LFsSPaDGnYD4mGRuI3iLJQJNop//9ZQ64ap8RMQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:bgY6wXLVB64eZ/zlo6mV31hpYd2xqNaLD1MzvJuuNNY=:wHR65/A9HU1gjbzLZZyxFcJqIlP7k6NX7aes56wMHy4=;
X-ME-Sender: <xms:p7zHalHj9U3ch8GsiHAdyUD8qYWdb411pDGR-cpU2W8d_FIUWvPgLg>
    <xme:p7zHahN2xQO-SEkpIvo_OdV-qB95DIkLifeyn5DVUY48H5vcfGXfDIfVB2wH_So9M
    ph8DXDdLTonY1oBrt-bSIyvR_n4rTpFELvNZxJBgvillzEQ-ypKMYw>
X-ME-Received: <xmr:p7zHavfqvvk4p9aBZg3HvhpaSa7hA7q9EB5YAmO4SXf0cQx8WUFrEhZLy7HDNeh-6_nSEXZ8F6CY8dDtspU-ojPCmDPhVMIRJet4>
X-ME-Proxy-Cause: dmFkZTFnMU61OfYMASvk0y07ZbEF0agPxS3VaTcx8D6f6GLZJmYd92WZn0rEgR3JpUK4ev
    cqGH9/B07EfZBf0kEffkUHKT8Ex5EJPDieh5v9SlmuosBDDm6McMK/bq5Pg4Py7e4dkRSi
    uSAjoAChOcu5LgT34C3sAzzsENAPKdXS9NbPqD6Judc5t3tgmaYGZnlatRSW6NXApus0JZ
    9vlT0Vg1udusUM/zwP5dseJRo/CHT1k/Golg4xmNv69uEhbkduEhUUiX+tLfYYxdHXFg4d
    yHqgiHkhpBmAP5A4PTwMvcmu8hakWMg22uU9EYkm+oQArZR46brXXunas1M8f1PyU4gNJ3
    JYsfSmeofo5cn2IqDtvoNwwhBZ5moVYqxDvbBKq0JeaCDFNSNKUEviHRRUwhAe+RhxdwmS
    hgYlXhBKqsb7xyOz2EtOvDvv8KyuLdI/4xu3Jew2p3C9Et0elNh6LY/tGqSqwCvcBigqT/
    ZVCuwHNLpv8fsSeAKfdNiT9oEn8knZoFVXDVmNwtQTxWZR8R32ni2ZSPhdt3CVUsvKJW4X
    VCMYEF109arSvJjqEJWu1PNJlSCF1Ghzz0VY63JU3Hox/GGKwFCBCR8rbHRP7HvYUIkQR8
    bWdG3HADWa3yN6cUo3ykiAb0F2Z8Xf5SSyhTen5UcGkJ2XIjsVuXQuyv6EmQ
X-ME-Proxy: <xmx:p7zHamsfuTB9hLUFf5uIHI8d52-WVkFrE4ZGvitS3ujeO2RsbW3FtQ>
    <xmx:p7zHaok_xgb5n7d4Ynzo_p6Xwqd6DxLO62AfFh4NSvT25NZBGaPUXA>
    <xmx:p7zHagx9xmPQ-Q49GFEdfdcjUYweoPLduI7CenkLpptDSzwAfF6J_Q>
    <xmx:p7zHaiNOJdWUZHVmGJv6zGLz-tNFNo01XWFcKeozv1gvIBryOMGGCA>
    <xmx:qLzHal_VZeqUO-7rKPNfqaa7pJpfRkkArlkIMWbBFxObeaWhhK3bTdlu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 11:54:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>,
  git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 0/4] refs: run copy and rename through transactions
In-Reply-To: <asdsIjNEUOpaAnX5@pks.im> (Patrick Steinhardt's message of "Thu,
	8 Oct 2026 12:10:42 +0200")
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
	<cover.1791452597.git.maciej.ciemborowicz@gmail.com>
	<asdsIjNEUOpaAnX5@pks.im>
Date: Thu, 08 Oct 2026 08:54:14 -0700
Message-ID: <xmqqece02no9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Oct 08, 2026 at 11:44:15AM +0200, Maciej Ciemborowicz wrote:
>> Changes since v3:
>> 
>> * Rebase onto 6de20f6092 (The 4th batch, 2026-10-06), the master commit
>>   used in Junio's report.
>> * Preserve the packed preparation error in patch 2 as described above.
>> * Register t1425 and t1424 in t/meson.build in the commits adding them.
>
> Please engage with the reviewers. Just posting new versions without
> replying to them at all will very likely not get you anywhere. This kind
> of behaviour is nowadays a red flag and often hints at contributors who
> are basically just a meat proxy. And as a consequence, reviewers are
> very likely to disengage and stop reviewing your patch series
> altogether, which is frustrating to everyone involved.

Thanks for bringing this up.

A response to reviews on the N-th round must come long before
sending the v(N+1) round of patches.  Some contributors send them
after v(N+1), or immediately before, but the proper time to respond
is soon after receiving the reviews on vN and having had enough time
to understand the comments, before starting work on v(N+1).  Only
after that work is complete would you send the new patches.  Hence,
we expect the time between vN and v(N+1) from real contributors to
be measured in days, not hours.  Whenever I see vN responses arrive
after or immediately before the v(N+1) patches, or worse, no
response at all but just the new patches, it smells fishy.
