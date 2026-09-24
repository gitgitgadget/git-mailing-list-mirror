Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DD63CF673
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266963; cv=none; b=Jf101bw2jWzhLdV1xU9yajfxWnv7BfrHqmapNfSxbRokWU7Qj6zz5oG271RQM0LFgj9XTicOgVRu1MX02DplzxdUsIfQgUDIjCef0Ja7KycosqcHXLWYpya3iydOmKRv/9XL98chYHJ2uukGNTBj73l+jID+ms4p8rbbO/Jb44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266963; c=relaxed/simple;
	bh=Mwg2Z10KcW7Qyhz56xhAfu9xLOVcZbhjEyiM7dOHekk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=igndwiChVi/mS+pHdZQumCgkYGwJB5BNbQtGviLZxx9nVqCWQk2IUoyiq7LBc+V6Q7srKazS5je8EGHnRtlZb1aahOXfFcxoSjwrdzDrfNNucRnRdcqBixIK2EQWZBChtw9vMArZbGu3bvc8Wg/e7ftFvbYNqXdT3LWSvrW86Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D+Bnf9wM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fCoJqDPX; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D+Bnf9wM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fCoJqDPX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 356BE140008A;
	Thu, 24 Sep 2026 12:22:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 24 Sep 2026 12:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790266961;
	 x=1790353361; bh=6HpKXNnhLPVF/W7IKQrcCpas4Em1Gmwtn+eu9GUQzdQ=; b=
	D+Bnf9wMxD7C3maptz07JSjqLnH0V9Rlxw0hJHCCXHCSRYCb69oNwifv8bVNsR6O
	FXYUONz288CR09WnzzDfKA7TwgFeAk7MdenYJZ3c9qKYGLXdfoTlIFsOwqurUi6Q
	WuO9nkCEFEHFAGyOMbo+K3S7LVmrJrO1x+WdfWhZWaKxXc/Dn/MMHcoYO9WCmlcA
	3s59bjnQnOr/PcjRmVpOV/8OkRu8NGhWpKFlZDpF5W+79sgAL0ULQG4IwrZZGO9q
	vLhK5HwNMM8zL5S0GsEIjk1k8lb4WrtEks2Xsm2Tgc0+mAGl/OEZLEL2PcP+lb5Y
	9dVcYRuiG7hSoMpoA2V03g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790266961; x=
	1790353361; bh=6HpKXNnhLPVF/W7IKQrcCpas4Em1Gmwtn+eu9GUQzdQ=; b=f
	CoJqDPXYzA0DhOHAkvLQQKDcqcSvrsMptpHC+d6/+wUhF/fzDody55+4lLoBf/oQ
	EqgDA5eLirTsrooFJCWpEhFmgY+0onIkgqih5zB53U0ADPxzNOR+VpAhO9yuEaP+
	I+u/6GQsBeCT8xcd7/RdjHSpjQwJF2tpchfCP6GUjY3W2YVjswDFOdqh0p7BbUH9
	oFO3SUdKrrdzimDuwru6WG/Jy4EnI/7XP0wQH30WAEniS82lk1MJB3ZZaj/olPI3
	1EJWKJKOUDvCiSbYyMxlM3Bvy/91tqclBMnWYBgV0ulS4wdaTAkycjHOblUyXvIG
	0Mx+EWBLdWVZO81geqJ+A==
X-ME-Sender: <xms:UU61ajbrJXRroOQifcthRb-K9XBjVw2aeTXHxzQfKr-LzbFabT9-GQ>
    <xme:UU61akquDS6xrUhvHAG_osb9gVVa8VG4znJXR3JylLjIl3Zy3p2QH76bxE3jyEKJD
    LJjrYDrBKY1jud7xGaMmpTYKC7c52XNaOHjC7VMG3aUteHGhm-DCZk>
X-ME-Received: <xmr:UU61aoON5al1f_YA5mXMVoYTjldGTydc-4Z4D2oc0aAZmE_HLutTpRGa1kR3VnAMFsR6zo1zbo8cHc2S7FMbR6OafoXUzw1dToyr>
X-ME-Proxy-Cause: dmFkZTEjPDSf1QI42fDa2xUM+PBl+NXWxI//GxmPuWvYKW7QZ5IQfi0AXAvAbdNIqLbKrI
    /cDRO0srMyPFoGqtKMbq0g31E0BX3Ihk9/NbX22k1XTft8jqaHDMYWTH/D87hBag7URhbo
    S7u4JKf8dwLeEIxNp1koNcDmW1+bzqJbRFjzWLH9+Q/r6QlWz0rEfH1IP1UO+YbjIrEROI
    mLWfHJdwaWh2MFWAJBvFFSuZYUNEe5EeCFNwlrv6JV886oV7WUx0Q5q9Q/mVSwigSD5YvR
    IOJiJLo2fW1GyB1iXKo8CbD3PylR3mPlic6cIJP00MsFlAuTiBF6OLUPWJzWeYoUVfC6Sg
    MUo8euoq5fy84/ezZ2q1Lfm3zmGxkf5TgObFyJCWHlZyJLTV6qfe0GskM2PU+e6GxwNOf0
    vipQx7FPmEbI3axwC5wvG1P7cQLuq/fHFbw3znsb0lYvtp3N3I+5pudPiBn5n//Qt+UsLa
    AFeePKXR6oSTK+u08yC+L2P7PXqgB/IwflXM2DK2L6548bxyNfEm6VQQDrEK5ZMhH1V3Es
    lt/CvFynYwVa/XytF9i06WTDD6moi8JB5EBhGTP5dX9tw/u7o0j/wwOG8ivPRgCiz+3s5U
    ygWRZP/EoFlJ+rbNdX81YXR9+ogDNY3WlT0dtBNN9p/Jd/hzwCL3BGQ/urWw
X-ME-Proxy: <xmx:UU61avpgVDH6ac1R-t7EXffgoyPTr6ObsRGA_0g_HfUrCVC8NBT9BQ>
    <xmx:UU61ate6OkqG9l-k2YBE9fOJUJURTIG97ZjNFfR2hdjc8KNAya45gg>
    <xmx:UU61alQXYGFrTgPLEF3RH8UB5uoqHcAPPEvK_dpU5LhrS49myrwGow>
    <xmx:UU61ambCKZgdpeycO0mqqhwNlKtcTgkXZvylBgCOQfkHySw_t3ppDQ>
    <xmx:UU61ankzDU83e-o6C726GlStf7jARLHsCREWhq-TyOWfqCgxsJVh1ACE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 12:22:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: graysongordon-gl <graysongordon1@gmail.com>,  ps@pks.im,
  git@vger.kernel.org,  peff@peff.net,  avarab@gmail.com
Subject: Re: [PATCH v7] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <arTUNYVvCNwX1pDp@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Thu,
	24 Sep 2026 09:41:41 +0200")
References: <xmqqecfez7ie.fsf@gitster.g>
	<20260915162348.97792-1-ggordon@gitlab.com>
	<arQ/nOH+o3XwQFD/@szeder.dev> <xmqqwlsb63o9.fsf@gitster.g>
	<arTUNYVvCNwX1pDp@szeder.dev>
Date: Thu, 24 Sep 2026 09:22:39 -0700
Message-ID: <xmqqcxu24o1c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

>   - Checking for the error message printed after curl_easy_setopt(...,
>     CURLOPT_SSL_VERIFYSTATUS, ...) returns with error is indeed the
>     right thing to do.
>
>     However, in that new error message the second half is much more
>     informative than the first, and if the prereq looked for the
>     absence of "could not enable OCSP status verification" instead of
>     "http.sslVerifyStatus is set", then I think I would have realized
>     all this sooner.  Perhaps calling the prereq CURL_SSL_VERIFYSTATUS
>     would have helped, too.

Yeah, both are understandable.

Thanks.
