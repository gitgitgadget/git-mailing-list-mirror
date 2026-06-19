Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7D2D5408
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886322; cv=none; b=QRliD5AUSj4eMc1f4mCpOrxfmnEVkXlVOzi35pkXITKYntLmxlOqspQRo3cLKqS6UUftlC81kiFYDR85afUmFOid9a1N6nJenTL13DtyVBog0e0dLHJj2VyE/vqemMByMuypQv6N9XvN77gKFh5y6mFQopNtpFPa5/ujhFa1RGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886322; c=relaxed/simple;
	bh=pL1qbHcJHWim6+Kf2RxRvyr28i7hsXeKDRNNDgS4x9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KBt0yUQy+3250qn+9kk4jvPLo2l5OE6ko7tMVBIJ7pWEdq3qVDG1d6YhIzU7X2cQ1uO6kqoI0kzszjnf22HvvwN/Tq05GllfNgb0YSq0lpq837Sr3OYMZbZBfqkOg9ov+9WCyteCC6WwMXc/Oq5joHXbWkvv8Z39aKzWWHEKhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YMGo1Dnr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lX7oink6; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YMGo1Dnr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lX7oink6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F0A61D0011B;
	Fri, 19 Jun 2026 12:25:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 19 Jun 2026 12:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781886320; x=1781972720; bh=5q8+ZcbuHc
	L5YW5hn2g8WN2cIeE4MhqJhTlas69vjXU=; b=YMGo1DnrV7UYvbHinPiqeQgIsw
	WhRhVybzV9zn9Oh8utnUXp+1uQDCMW78bOVLpKICsg/mfey7a2cfQB1k0BYcEhAg
	dySU3NzZ9OF0b35BLp9FhqPJJ9UFaOnAJnCzIoaeDtHqyCW1T7LtIs4K4Xu7zQAw
	u5JSCrQ2zXWo+FLDGlOqJwD1YVCor3Gq0HJQc6yH3gXkg0qMUbbV05uOgbN9YBsU
	iyJoAH+RopRxBwivNS6RyK1N6OB+igo16Q3/WxcXaeOuL6gcMqP2MM9i/XW7pMkI
	TwsabwYEwJBEzsQMNQiDQ9oZrHRycwjWVHsvfTcy/SU6JvAvR62xQdta+w1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781886320; x=1781972720; bh=5q8+ZcbuHcL5YW5hn2g8WN2cIeE4MhqJhTl
	as69vjXU=; b=lX7oink6H3bPJkC0N8s+F0tQYiWyO/iiPy3QeTHrgyskjajQ8Ti
	DD7pEEl6FtaKTMNgsO5GzSvn22sekEDztc3WzlTRLowADtRjih68kW9njIM2B9Fi
	LQ7//kDgGD5/6xwp+vWEbva6xzRiOkYc1ZG4bKeAgU6C7VJNl1Pcien9Xnb8/WUo
	91bovxVSSEzwj7PaY8lFu/DWg6fN9i28KzCfGnsXOIMAJYlAJn4hMVnlwgd392qZ
	KUXZj7pvHjMxa3eBtZCTeuUo/updxColPf7DpQ+UdT7ZN2eAQ9q2wB/DVm69QZpv
	2BzhFw3Ar5jzwy75jP26OGyimsEPZbN8jiA==
X-ME-Sender: <xms:cG01ahtNKILi1BNmDV9_3s5Me-j94kGth0wz39-ZPrGn99QBbh_QmQ>
    <xme:cG01ahfXgYKN-rzeoekquO8khkVWFRS1S6IJ2PLVXxTFSuC2yhnh3ylOKQy1Grge0
    UzNuamrmInb5wPT4N1PO85J2nBflMsndEP0Le2-nLftOpexAUju>
X-ME-Received: <xmr:cG01apxMpeHVk4qpKyUmOcPqZ4fyKauV8Y1exY8Ak7zlBAUUfjbpai_BLEWSkBr9Qw9WV5Z6aDwlzbtcjgs0lz04UKOUnr6_7z3T>
X-ME-Proxy-Cause: dmFkZTEAINR1ohYYN2O3ezu2AjxT0VGnGNQQBDtM9g5Br8PXtTvu52MrwvR069SdmeuzLv
    LwlwxQuHXTSCysgcPXWytV6FZBc0Tur7kMBIUByfAXMrF/MJYI8IA9GPqTwvDUUApCWTSD
    2gDNpiV4w6XOUlRSkocxLLHrdUpbbApXfCzDFJ8RTYdXBqBVzLVLKzEQIQpYxcL/ioUZqr
    EUS/6aFTqbRWlR+WjsB0W+AhW2Bznp8o5lnguct/nRewnQ3rnPpqIH2MKGgdjqkcCnZ4WD
    DCjOaFUIlLkiW9NEJ8fYuNxCU3836UeM42pv56pdHPjTBhLLOXy4ATgsXSl2ScwopATxH7
    de6/FwrIAmNQFKqCdVttNK9e1Kz5nVFbhZV14qyWWvSEnQ/Rf7C9RefsC355x4AcpJR7ip
    axjaWglvuxP2F4mJpsSplhCIdvHxGlc3hJmQzY/EQQtUE6e75W835pYac50L7ytPcmn2jv
    x/gHyS5f6xKsZSuD8SqFyxmOnmetguvwyxK47vWT/oAuWCxthmzNBbkydPNvON6Wqh9o+n
    MWIyHUES0z3P5/0wMNX4HZwVR3YHeW35/aAKSzxmnsAQhJsEfCwlk/E+dzvFOEUA+iF7Sz
    FGL1IDCbOvTpcQNtt+xPx8b0NuFuSCnPrT2OyZzqZRNBXLfE20tucBiI/xyA
X-ME-Proxy: <xmx:cG01anHUJVeJ4rIm8LtwYQMB195Lz042QeJfOaLGhqnKzs9ZQMmcig>
    <xmx:cG01atwvZpsn09_Cb76uEUGHPCk56x13I_1FF5H2DAJTGMmWFsrDHg>
    <xmx:cG01aotW6C5W125dMxbF_GQMimOOXioDFe3zNI8K9Emx-oL1IUfjDw>
    <xmx:cG01aq3OvJAtpc96HcZHVpRXFAv9QnSd1XKPv4ezNVwHXsOAaLQnoA>
    <xmx:cG01atTND93_vCqhBZV1D8QBxhuSV13dHVfV6RArIZE6WnFuVsjYCaQO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 12:25:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Erik =?utf-8?Q?=C3=96stlund?= <erik.ostlund@gmail.com>,
  git@vger.kernel.org
Subject: Re: Pinned references?
In-Reply-To: <ajTx9vLIWK5wvTHM@pks.im> (Patrick Steinhardt's message of "Fri,
	19 Jun 2026 09:38:30 +0200")
References: <CANE2Nt_LP9odF9tVsy8di54eSH=QJxif2WQfHC+TQGGFeVcjvg@mail.gmail.com>
	<ajTx9vLIWK5wvTHM@pks.im>
Date: Fri, 19 Jun 2026 09:25:19 -0700
Message-ID: <xmqqeci2lcpc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> You can already kind of do this:
>
>     $ git rev-parse v2.54.0
>     0b13e48a3a30cdfa94e8ef842e24d6045ab3d015
>
>     $ git rev-parse v2.54.0-0-g0b13e48a3
>     0b13e48a3a30cdfa94e8ef842e24d6045ab3d015
>
>     $ git rev-parse v2.54.0-0-g95e20213f
>     95e20213faefeb95df29277c58ac1980ab68f701
>
> This is described under gitrevisions(7), `<describeOutput>`. The only
> gotcha is that this format will not verify that the tag and the object
> ID actually match. But other than that it gives you the ability to have
> both the human-readable name and the machine-readable commit ID in
> there.
>
> As said, we don't verify that those two revisions actually match. So in
> the case where they don't the result is certainly going to be lots of
> confusion. It certainly is one of the more surprising syntaxes that we
> have in Git.

It is very unlikely we would change this, but it is a fun thought
experiment to imagine what would have happened if we insisted (i.e.,
verified and then died if it does not hold true) on the presence of
v2.54.0 tag and when the "hop" count is "-0-", we also insisted that
the hexadecimal part exactly matched the contents of v2.54.0 tag, or
when the "hop" count is not zero, we insisted that the hexadecimal
part names a commit that is descendant of the commit v2.54.0 names.

