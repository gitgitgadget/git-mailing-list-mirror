Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845F026F29C
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958051; cv=none; b=q8FRYXL6ri4r2RArHrQI10Ot48CM7aj9v0koJj2dCwJYzCLG1WESaDWzLkecRvtw2Z7CUn/jYUi2gijsVBaL9oVrlsJXnaPFqeszt2dnd8OYCL2JJj8hKTqn8jPcGB1vuy4sYqRZLbhNzD3uRNwh5pTE2w+ScISKLQzI46E1UDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958051; c=relaxed/simple;
	bh=EUPivBldQQ4Ta3hIZmqeGt5jap65KI5Sk3MmXrUyo0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hKzFJpRbrXoa4n7m80u1hRyLZJcOj31Q8CzbQrr6Ap6KIEsC002faO59qgr/rJK+7mKBCuKrvSAxel2dJli1gCckOwjIqCOSdBFxqQ3L1mBVOb/r94FDFJMhHl3uHDKmQ1+fXFtU9I10oL+M6aSA489v+G6fHViGQFMrv5qnQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UjFc4vA9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hzKBfOpo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UjFc4vA9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hzKBfOpo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 91E08140017A;
	Mon, 13 Jul 2026 11:54:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 11:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783958048; x=1784044448; bh=pdLxqoTl2C
	mS3Ft1/jAQz/4+nqdnqDPoMZD6J7qsc6o=; b=UjFc4vA9YMJb6f5B89+XAH5l85
	UGR2+XVkmAUaqLr2uQP3iMcpF9cMuVYf1t1Qn1Po1FSiLiBQ0mluPKzfauo5QRez
	gnSOGzRWHU9w9pzYtN4l3VIZXBt5cH4s4yXVTC1TSDSgAwDgXVPPAvDPuWrS9QvH
	SphHunfkHEeS+/9JdYUBtZhNELqt7aSa9355eL420LIAB7RqIfuoNaXX2sqbjm+a
	CwY4coqL5zikoMkkekjy7Z5uxQONwhxIYRNLI0kPd/Vgd1jSbL8rDbRrr9epqQUL
	lDNCTTD9q5VCHA1h6LkQH3kuM/Cew97c4ysIQNZ4eGli/qhZV+XTmEf6GdJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783958048; x=1784044448; bh=pdLxqoTl2CmS3Ft1/jAQz/4+nqdnqDPoMZD
	6J7qsc6o=; b=hzKBfOpoamkJNd9hzBsSpKvh18t5JAp5uZp2HGp2egCkZx8e93A
	iKCx/fFGqJDOWSR8/HSTImTnVA5bFQ6ae9txfMaojFmI8QAQbj/ovElHfSeU+Zsr
	dJwxEht4s08Yu/6M+WhaiUGvHwpbIh0jV2ocrac6Kdt06nFiF8c0zXpqa3OVDgBI
	/n62Bb7sSQbYQjMVS1QTb3cwcLMybzNZxWFeVyU76tDbuQkjWmQnVXQX+H9I8PXV
	YR1ttsgxET/PECKk8B/rT7XgNdrtTBz4arMhzsUBiPxOvcA9+uEFVYnzuE2BVdcl
	8QilGCAtiY4B23QXcRe78vci2ZuRVpeU66Q==
X-ME-Sender: <xms:HwpValvSdWBqbFBTnxgzix4rEXM-rcIO4yB3NqLlLB38NTMoz8G-qQ>
    <xme:HwpVarA52DrrWyqx60V8-_Z21pO2iaWrjQd3OIs-AroPruhrPTtl2W2eR1q0QDisw
    m6L57T5jtz6omjYO3biUdzvN4aK-dsntpxcoXWIhA2nGBfAiA1oBg>
X-ME-Received: <xmr:HwpVatPoypMzl9gfARk10HEK3eSV5dnFGO28t30Z9uTuU6jSfI00LidYCTMYsLXdRWd_3wMAdKBCUw-VgaS87ProJp6cCarYS-HZKyQ>
X-ME-Proxy-Cause: dmFkZTEM75dJ3fWJf+Xu+Km/dSjBJS1Il/Uy24HRIwbe2kq415k75LV/Sxkee4YJb4R0qy
    98hB/50Rkrqh2SgwPozVMDBD5jV5/noURPjujoxuivtX24wwq6N8lUJjdnrLEpOixg9jZP
    tQeo842Fcc6ueGiK0iDPBAUMDjzBQrynOYtOsqYz+cuBCd0S71x6miAsq5xZILijDlTGBx
    LGEqU9V4A3tLCO7xHDhfjRdQF43vBWT7KxSLEgSN+Lzw9hFS/2BBtxhsSwPTLSPaH3tMz+
    IZxGsxhQaoNtUqzXGv9C6HP1Yh2rvekTrrBmPEasC6jq78EAN00rbhLEMJgX8U0Lz9Joi2
    zEX1ojTQw9O8Z0txk0neQPWm8VJrGjV1DtZRSzr6LbU0gIT3d+/8pyDfhREp6asLjuG1un
    wa8E1hXkrNaDlK20NDNFNZQfrfErncaJQcp2/GqnNYu2SzcQVdnEFqc9ksoI0/UOLQvVKe
    fmYH0k+zZ0qNLuCLTvOZ4jPe2jnGezj00PAw0D+2COW2TQ+Fm7Nflw0dyke0nhLlKCqRuT
    3JOTxLaNYcZAI04yYXO4wpOG7brB3x0NMIA81IY7UENsaefpJqEDkXGGPk72C1v5EFmdSH
    pIUihYWv0I2H+LnpwOhCnUPx0ULujidD4azx/RrUHi/MHf7I8SOyg0AIW4vA
X-ME-Proxy: <xmx:HwpVajC1iwdZbocbZYugmxFiiSZBw9xpzCbapiBHSP6qy2LlCfQ9vA>
    <xmx:HwpVam4do7_5mHwi1eb_YnFPJT6x-3O-3OR_LIbWKn6sIvXPNSwOhg>
    <xmx:HwpVal7TToMCpT15WCHU7cYwc6enKqG3MrsVDilxmdkceF41oRE8tQ>
    <xmx:HwpVagTc3qwqRtol8-VgO7PZ8dxrbVEHWsKQCUOmxNawmMnV5uGXzw>
    <xmx:IApVan7kmFu01SPGocJzttQD-6KvR-BSJjo7a4-4BOqd9x3lWe4RcK21>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 11:54:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Justin Tobler <jltobler@gmail.com>,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] fast-export: standardize usage string and SYNOPSIS
In-Reply-To: <20260713124153.245268-1-christian.couder@gmail.com> (Christian
	Couder's message of "Mon, 13 Jul 2026 14:41:53 +0200")
References: <20260713124153.245268-1-christian.couder@gmail.com>
Date: Mon, 13 Jul 2026 08:54:06 -0700
Message-ID: <xmqq4ii228dd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> The output of `git fast-export -h` currently starts with:
> ...
> This also enables us to remove fast-export from
> "t/t0450/adoc-help-mismatches".

Improving consistency and eliminating special cases are both
positive steps forward.  Nice work.

> diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
> index 297b57bb2e..719aeca244 100644
> --- a/Documentation/git-fast-export.adoc
> +++ b/Documentation/git-fast-export.adoc
> @@ -9,7 +9,7 @@ git-fast-export - Git data exporter
>  SYNOPSIS
>  --------
>  [verse]
> -'git fast-export' [<options>] | 'git fast-import'

While this was well-intentioned (demonstrating a typical usage
pattern to show readers that the command's output is meant to be
consumed by 'fast-import'), it is highly unusual for a synopsis.
Examples of this nature are better suited for the body of the manual
pages.

> +'git fast-export' [<options>] [<revision-range>] [[--] <path>...]

This updated version is much more consistent with other manual
pages.

Nice.  Will queue.  Thanks.
