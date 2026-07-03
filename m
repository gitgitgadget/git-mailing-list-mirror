Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937083C4565
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082393; cv=none; b=n1T6rXNUWO6w9zsc1mTXkrPc4DYAgguAA6WTUslXI6tzuRlZbS9hP2g/bYYM2URWwRpE5PNKt2ZK07B0qwYFxRmkwL2Unp69Ir2fawpHwwz3vlawc4xkLHAcXTqbWeRTHCxvQIpEEaAVq2KiEc5pYUF/CWnDuMaPZRmQgx80JOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082393; c=relaxed/simple;
	bh=p6MhTnAzQj8qY0ioGRtQ+h3rMWXUZsSmGYp/iF1iWzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2m0KbzLswroFMwG9cZXPJyBNyg2oyOMzKQAZmet2ll2Ms3XLqS0C32XvwnGNibG4slRmsHtWjALCNJOLUpanTcDKxtE0i1W9TiptE4zyy5qj12/tsP+4SxH+8J81nc1VlOf9dY8Ruf/whnDglLY0/AaaGWxsnf/AlJ5QaHW17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lGUcrN+y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZP0a8Vik; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lGUcrN+y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZP0a8Vik"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C97AA1D000C7;
	Fri,  3 Jul 2026 08:39:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 08:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783082391;
	 x=1783168791; bh=dnNhClWDREwPk1U2zIz41F6XprAv6qfhohosA3IyvUE=; b=
	lGUcrN+y9KTSkjE5knulvtaVLQkSUvfx2vnvbnOcB8oBoPZ/g0o36XsXgakv+NDN
	EKi1MqrZVvLSt7t4jwlQykgJSGaOp+0CVCOIrCZD2QFSZlxEVVkK22k7/SQmDJ0R
	MamSiDJp8eummVH32O0dojs+SSYVWsq+Hx1UP4b8XqUFWFcMTSrZRocXCgZhRtCI
	T3l4i9XJw3eTm/cVX3MgDKvR/hdBQnAvKdVKtN+y6LP07CZKw5BrNQT8T6JtNr3S
	OVer7fRUHHL9NEqETJPlgLsXUC4Q5wJzE0qPyi9a28pJKd1dRcZYgPJyEchVAaUU
	snoXG5nGw2NfVVtQ87IY+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783082391; x=
	1783168791; bh=dnNhClWDREwPk1U2zIz41F6XprAv6qfhohosA3IyvUE=; b=Z
	P0a8Vika/ZQ3YhgxuM5E6qL3DTLk8OiK2vHA2sjmYHMe1KZFpphDscaI5fNSPzHk
	3+t9Fo0j4KNTDD31d9v0uxGFzIzxQck22/lHxAoF2HYafjvAvw6ivyHa6uA1MGBO
	HuYJnal9EhPtvGdlA9gWTedpDAxJ+ghSquMNYjgu578rCLE7d0GaEHeQmbRIuusN
	LcVA9b1tnCQvfl8y5O5C8olPE/NpVMZ1Vlu7hHMUztig44GHw5b8/Vxx5UDrGR0o
	EFgId6z3wgZ2DjuwvElnrb+niuOzkzVY8buU+r35b+MYTDWZduSexhHP1xgFRNKB
	qFAqCYJKhgCbSCEK5lkxQ==
X-ME-Sender: <xms:l61HamRdVH3LoXciOvQ4PB3a_QL1KqAhBeD4UNDz19RCBfi7QGgs7g>
    <xme:l61Hahw7l9FDQxj-V711eIiYArcnTwD__DPUfK6yxhnoIoiph2Lmv7rFYko_Grm3D
    iaIJYZWvbMpZBHjKmHuudbKG8CTjZAP_FN0HrWllwVuyE2D-7vb>
X-ME-Received: <xmr:l61HahdJmBYuOpFeRK42p7NrrQGoYRXZXaDOEK6VG_QxDF3su5ymvo39eQBZQS1_PVBJDh26f2tWGNwbyMiPoi2eSQSut_sFr_ottL-DzQ>
X-ME-Proxy-Cause: dmFkZTFpC4JRSgt3mb0gDnR2AAYw3Nzt0HyG9rX9I4fjeOR0NUm9eJ60miS5lnm7Jxgkq7
    9LEnbGP8bFJdkGgjbI3ljMJGkQR+V1HX9aUEaKo2tWxUR6JEiUjcixl25RKsg9o1C5lINe
    j+XCYK+/0Z6RwW1awuIpPgNu1dSva/lMOKgeRPqqTU5T3iaH0YK1rVZ341FREEBJ+vg9wW
    plDzqczmyeuzFnoqHBcXynnvYOiUzyJu3nuv9jbXWbPxOis5ASAzc+z1wEWLcltsFYu3/v
    695pcyAv2LzRK9/rcF7Je/4DTCihg7pRi6siuKyck+VvkijLFnSYCRYgcZwsdxEP24rHJv
    53cSPC6yHRkOEDQ1yAo/1WFYPAyIVZ3wGwaLfKDhEmwRtEHzX8QJSW76IeLwrYvti38yts
    ZbS5yk9ZuU2YWnS7Buw31mV3aja3TQxFhHHqSQI8/HNBNQjxLgvoiHZJIocmMp+FRM9kZQ
    RxuwXCmhk1eTwyQx4h9pwRVzq/+vRJ4WSV4w7TutiAl5/AqowG9Xx9shl70mrqGMpCGVfG
    yZl2rztuSmY+0xEkNbGH0DFcQR5Y1oC23g0XuMO7+UN5ct9jDHesRAavjSQp0dVk6Dmy3/
    7uTqLLK8ZH1Clqc4UoP8ZJ4Ej+xPasxJ5VF+qK8Xvy7+1w+Gz19KtIKPAKYw
X-ME-Proxy: <xmx:l61HatIRkOt7phddx8wNIG7m2_Covu_sFSCUfGVxSxkjfqLqIcRHaw>
    <xmx:l61HaiHAuC-t-GTRlp0Mwszlr0UsGlFn3WUwt24XX-ZnPb9mF5AyAQ>
    <xmx:l61HanpfS6h2skUC2PpVG9sSbyhkraaZ1ZPaPtymxy1MfGRjQzMQaQ>
    <xmx:l61HarT16wskq-RgMTNs9ggW62J0rcVpZFAvxaHGbp7hNj_1dgFROA>
    <xmx:l61HaqCO6_qmbyHXlkJYAK8OaD_rKU2vOPsK3_U00o5VMCRlwdxjjjNA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:39:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6bfcf60f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:39:49 +0000 (UTC)
Date: Fri, 3 Jul 2026 14:39:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?0JXQstCz0LXQvdC40Lkg0J/Qu9C40YHQutC40L0=?= <eugene.pliskin@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Unexpected recursion in 'git rm'
Message-ID: <aketk4ensXGZS4eI@pks.im>
References: <323134122.20260702104910@gmail.com>
 <akdzSHrJ4DfdUWoS@pks.im>
 <1756071445.20260703123414@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1756071445.20260703123414@gmail.com>

Adding the mailing list back into Cc.

On Fri, Jul 03, 2026 at 12:34:14PM +0300, Евгений Плискин wrote:
> > This is expected behaviour, as the argument to git-rm(1) is a pathspec, and "*" matches directory separators by default, see also gitglossary(7) under "pathspec":
> >   • the pathspec up to the last slash represents a directory prefix. The  scope of that pathspec is limited to that subtree.
> >   • the rest of the pathspec is a pattern for the remainder of the pathname. Paths relative to the directory prefix will be matched against that pattern using fnmatch(3); in particular, * and ? can match directory separators.
> >   For example, Documentation/*.jpg will match all .jpg files in the  Documentation subtree, including Documentation/chapter_1/figure_1.jpg.
> > Could you maybe clarify which part of git-rm(1) made you think that this wouldn't happen?
> 
> Thank you for your reply. I believe you are correct.
> 
> I have made more research and found a way to remove files in current directory only without recursion into subdirectories:
>      git rm -n ':(glob)*.json'

Yup, that wouldn't cross directory separators indeed.

Patrick
