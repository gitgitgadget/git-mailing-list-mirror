Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABFF22579E
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781964561; cv=none; b=EqvaniigfwX0qyqcVWiqr+unVADvCk3BFWstlP/ngX97W13RhHPB/xIAriebvxT1d7Y43b6m1Q6uKcmoelSd3miY9ByZ6KsZWof6dzJbmTqoLAh7uhI7vmJKbnRYVcAKU5Pv4A13vYW7N5omqov1q3VQGCYlSyEcxPIamZ/4PkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781964561; c=relaxed/simple;
	bh=a2OzJ9iMH2DhWsANIbwmNM0YOU/J+Ov8rLYiyls5CcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tunBwV/16X5NIIG1bvGKRk6clZZrBibE/y4/Aze7PxG+zjXX4KhGGIUpiEijXSaRI57sBVcu21cTxb9OLCEoBhoHLbYR9T2ftlr6qUhP37MLRidXBzrnHVXVB8iybDQPaNeOIYfESekRRndCiIMF8qSYB1Ct14KWX0QgGcF7uNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wf6Xd1yA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wxf9wTga; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wf6Xd1yA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wxf9wTga"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 130161400071;
	Sat, 20 Jun 2026 10:09:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 20 Jun 2026 10:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781964559; x=1782050959; bh=U58sc4Cb9t
	5ViwZ1Pi2n+6bRNXplksP9FiSyEqhdeV4=; b=Wf6Xd1yAv50GvYYe1Uw1HkbWl3
	lqhcSK8+eS59rTN8hStNrnX/R6g+mLHEucqZduMPyBwIxLNLMSwo1JOmxzoXeFAu
	n6pRqIuEcRGj+FD28iy9AM+7m4z3cWnWtD7pTEhlooxAOoXC9P3GO0L8tUVIfIKZ
	EyNnUB2inXmv66qE8JdRfedUPP5RMpm2oc8cBNOcawXoNdVzYPmnpxaIphPgeTwH
	GrmIUZcNk33sdQ4NXg/7e3AqqjtQBNjpqHTcRBynr6t3jTQN10PUHd4sft5jj5Bs
	2iBoaaDYtIkvNUea9wAVHbcVmpdhwEhAEiOTlu9voxEb3iVkod6dei88BkDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781964559; x=1782050959; bh=U58sc4Cb9t5ViwZ1Pi2n+6bRNXplksP9FiS
	yEqhdeV4=; b=Wxf9wTgaQT5eAPrasR6Wg1EYMmTPEYx/X+5AZglRTJsW9GP1IW8
	RSOkapp4iaqkI9U+jAXO5dtXsscu/caVU9i5IRuKl4IsMlX/90hzzsvvF+KAj2s+
	j6DlyYSe7F04fItjs6E2rvPqBC7bECRfeAJvD8b2Yf2WpvBGc7db6RrgEpN05FtR
	lzZMdnD0l6qePwOTOP8UkXPHoO6cmIy8eSRkMlsfK6Hmot42bSTFngIGlLfotaCz
	uLzdKs0P3uRKfiG6mytxnf8IVtqVz7FuIoJUhsM2Tx7d1o3780xbn786gOGejyrK
	dVOadyMA6P6Im98gBxf/i6yCtKKMLjUkhHw==
X-ME-Sender: <xms:Dp82ainyo8DFm5Hyp6w0IbpkRJgv2AEyBCvlQlDenQF7Fpuxc7Jf6A>
    <xme:Dp82ag2yWYBvUdfDYgSX8bgAQoLTuqOAf5sS17GvqXUKbQJbR4b7WB0Wvx_Ydwitt
    FVlNkYXWUIZgNVmBXqCQokvTGkLgOuYqVaZ4P9Uuz-kinik64K8>
X-ME-Received: <xmr:Dp82alqLDhRJ3msVCYksblNXj-4SNIg6mOwXCgg4Nx7akfXn3zhfbTAqTeB07DjLA1n0A-JV6Coj5nMFL7tEf87H0aKIojBu6ynD7y4>
X-ME-Proxy-Cause: dmFkZTGt88zgrftAA9tF3FebDEILZ20YQA+jm0wzZ07HOtnwQShzaZaxbnuFtOBWycM7KH
    M418HRPYV7Y0AiqLCfhmDvZkbZQI733NXl+MrjIJ0vqit/m7FAw1C1SgbZj/kamWRwog1q
    vxLow+Fqzw0xDkCXjtY1z2fX2fzvho7lrRRAMh5zhNm31WpDIJMrOManEXdqV4BOPj1YRH
    XmvUmVJDwOyoIFPnZMTsha4oCLrM5L8LOqQ7sCmdkz7T/9dbXswtK5XkdX0MTXsRa34WYh
    Gs21bsns+NWez8qMO/aMYhj0izA/WqAHBQv9TRqNlVhhQN7odS2S7IeyMQhXDmWxzoFUfu
    CUMHt3sR4gjP6sS/uor70IJimgwBKO+Ja9Q48olGwjo2MJjG8yAvMmoL1GPEYwvV3ITOk5
    mSCo2VIu+XQcP7tnlBNQz+LV373xlp9fKGelE0cf7jKQ1PSdUQAUvw+XlXDcap0DPtjeEl
    7yrrKfVoa9jlzvlM4vObJOEH0/btOxWEFfExWNWM0SxxYZKVMEf2m0OlNmLb8MHHYn292N
    i+buU0KguZf/Smskg/pa2lzP0G0WRAEgCya2peuojWjk/RPHQwIuHKoH90T3P7rZ5HagJV
    BQ7gaEdgZPA6lEDypjAPWKuizV49Op5dGPBBQd0oS0WNUmyUsn88ddznCmHA
X-ME-Proxy: <xmx:Dp82alc_fPekkYtLH8XVN2R6Ng3M8COUTYaTu0RWXdiFXQ9HfOcjjQ>
    <xmx:Dp82aspXRISFA34gaRIwHWZL7xeW9HsALxekc1VmLZCOGaIkUsOBYg>
    <xmx:Dp82auEqxyCUTDK4uwfGgD1lJAH0DCP5EQ78lFR0MtDknvmPpNY7sg>
    <xmx:Dp82akt7qhKlamk2Ml2fyvvHTfjwHxQueBEK3HOFINTszl79SyZfDw>
    <xmx:D582ahKmdYa3kDEYq1_wEiHoSCyi7nLcB993JPY8ZlFO3iMyTVkjeUx0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jun 2026 10:09:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: code@khaugsbakk.name,  git@vger.kernel.org
Subject: Re: [PATCH v3] SubmittingPatches: address design critiques
In-Reply-To: <CAC2Qwm+WcGkd9pAV5=JL1hfCDRisGQRFmdfOsMTrMWyx7aa65A@mail.gmail.com>
	(Michael Montalbo's message of "Fri, 19 Jun 2026 15:40:51 -0700")
References: <CAC2Qwm+WcGkd9pAV5=JL1hfCDRisGQRFmdfOsMTrMWyx7aa65A@mail.gmail.com>
Date: Sat, 20 Jun 2026 07:09:17 -0700
Message-ID: <xmqqqzm1gv76.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Montalbo <mmontalbo@gmail.com> writes:

> Slight reflow suggestions:
>
>   Defend your design decisions on the list first; work with reviewers and
>   other members to improve the design before revising the implementation.
>   This will avoid wasting effort on an implementation before its design is
>   solid.

Yeah, making the last part a separate sentence does make it much
easier to follow.  Will use.

Thanks.
