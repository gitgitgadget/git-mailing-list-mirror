Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8F4E0B85
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609763; cv=none; b=toZ2uSXLpFBKt44ew2RmHKZrFEg1uZ0z9d37tioqgQ2fJQfQZljm07LsQpiCzBKe0o5vP/M8cVuhfqgMSO3wPl7AmPXzqM+v7tFTjd47bgAOte3ArcdX0JT1AXAsW1wemviD5cAQbYM1w24IkR4A3qbPQGk27zIwYn83TNMg7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609763; c=relaxed/simple;
	bh=0TFa48b9sl131C4K0CDRvzFqrsT+M4TZTNgWX5Olx7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q9HnyKqb1xkPRD2oz1sO+CQnGJh4GF1HxXjoA0R1FSnxreqTCoRyulH6i0PSFM7WTbCZqPNC3iAdfpjocBvzbtcAUsjrcWJi68sibqW9kyCr0r2Q+jT9tUX/VKOAJEqGILVIH1YLo8ruGgba2BCqnWEAHLlIfulGu4uryLM+1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EzTvuF46; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rfB4sOOL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EzTvuF46";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rfB4sOOL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A53331400056;
	Mon, 28 Sep 2026 11:36:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 11:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790609760; x=1790696160; bh=L83dASTQ+e
	RJ2mlXM3IRtMci7MA1qzdc3vCuC0adIo4=; b=EzTvuF46xkjt9+yzlpvosz5exd
	eJ7gibxefIz82tnVa4hC1xVWVhXMsXGzeesKG8GiPH1yrI8aOUg0PWAYHQevUUlI
	mVfWG31/KVWVj6MGRc/7+A6PUbuIvZ5KhH8Ioz69eAuR83N3cc+F0KLzjkr8PJxJ
	hBvN9Tt5N4tZGUG8P3WqdCStL+ouaeJ0wrQ806KyTIJ7AQxh3p2O/VjgAqaPQ19T
	P2jVG19fyJ9D/lQdcwDqygHuLtXthNLZ8MO/T2xf/EJeepM8UAfJ3Mli7pl4l57s
	9b//5OaJ+AJOJzPmtig/4UyoURxUbIzq1/9mGhqqbV8gV16Bx+Kujg5TDheQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790609760; x=1790696160; bh=L83dASTQ+eRJ2mlXM3IRtMci7MA1qzdc3vC
	uC0adIo4=; b=rfB4sOOLgP4yWr4N+6bCVhu1dN32Fux1BinXsXQTEy37uLpMWoA
	jPcsqJ7f+ogEYVjt5hLX2XzIL669jAKIc6jo6k/tPdRRdtEmD0n+CKiIiEwuODJk
	PJFnaeLwxINicRQy5i/iFSfksKorezvKzoGhy8rO6YfGdk2VGOy1Ao+xETdfpQHE
	pm7xq5c/Cs+3iFgdY8fphmW99Qp10EXSUiA/sNUxi0lqj/XqG5reRiuG/wPlTxiC
	IzgtXm/yDPnZUurE9LIIcS6NwmaK0J5tolfi0+s0ek10p8Bu2WbMIITRED1rpyTw
	7OhJRdHNE5u7dhiiUEqmtqu4mVdOR//BUUw==
X-ME-Sender: <xms:YIm6akjffTcX0Ga8zKmorPI_DLbPUYMIYKGhAxGI8V1pmPFG8uYILA>
    <xme:YIm6aj6ovxhM4-kBNKZWgPthga7pPS5Kd8WFrChFHjgiA70J4IpnP1jvB9jYh224o
    2p6a5pRxgLkuQfhqGIadWUPyt8-_uctidf8NiakRSofXDYjF0eTho0>
X-ME-Received: <xmr:YIm6akbp_DqkmHv83oMKDkpgm2jU7WlDzsp38Lfim2mRsQYKxLe45mEdtR4KW9T9x2pVrZ6n_TH_e-sewtsG3lwQihuMyGI4lUI->
X-ME-Proxy-Cause: dmFkZTFoDJlXwCX6oezJG6YCkefWZcdElekK1Gs1j4mcHiR5RJwXVVmCDBKbDODgbTW0cu
    Q2i8Lt2Bcu+YCO8zBB4mDXU6YH9+2YHCZGHHqxpn5aB1gl54ac+7NfkawwXnQnvg2ljw7D
    kVvwFDj1bToQXfvB5iOcAhzh3hcTX1gQEzP5hLTPR0rljcgovqSqtDWz4k/Ia8oKn29FSM
    ACGPEngScgUGpTyWTqfX5cKt+QWM8AcOoWVYMAm7WcCIYcVLWJR9tyd7LuWbKN2fC8j2U0
    KbSg1qt/NCf7/IGVIPL3lugje44H++j6xFgjewqhoPobwkNHrGDuDj+9U3Sqj0BTX26QEL
    IdFIfpAL/P8FPxlzq+cR7Kdi9AB78prTK0oPJNlxOuFVd5lx8gLvqlS6U3QsQIVNkh2EGL
    UboIK4tR6nryR496lgkpYlkgiRkDQPUUkLJgvOXowAVMA17XxTszXtTG8gG9s/TUmP3v3H
    2FZneOgefKgoi32n9SG1wKvlWI/gBHbNvSbSal5xZAvInorokxirn5ei/fecdvhakaWJB/
    dpbVZkL4fXrxqlaM0vMdeRYKx1KMtY7DfiLWHWQi8yDSrmD0EOSaCMnQWHNjkF1CB0VtYk
    baC5NTHxODUSnz5Gs3Njttmo2kIxLfOaUrmnHc1oE+TqaDlWTD9lNU+cahEw
X-ME-Proxy: <xmx:YIm6ag5hbZ2TDIiEfg5cIBxKvQGIDPX8NdngPXDk8uPzNMID7ZFBFA>
    <xmx:YIm6avCjwh5C4M9X4t3vcVApBdu2HU1dTdH7zy5Zgwmhctayo1LdEA>
    <xmx:YIm6aufGZT12mgE9HqUwTIEkwK-dckpjif8zakpxyHM3ejX87XkitQ>
    <xmx:YIm6amKCNprSIvjrAyznzoLXdc-N3-Dr_dM4W-NrlvftN6ghiixdtA>
    <xmx:YIm6aiJIZgQPsUvT72-UbRnsvUhDBaL44SFcpesJewbvZ_ZYKIUObYMf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 11:36:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 2/2] format-patch: learn --[no-]range-diff-notes
In-Reply-To: <57741bea-f264-45ab-b5fc-52466fdcb03e@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sun, 27 Sep 2026 21:42:17 +0200")
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
	<V2_CV_format-patch_learn_--range-diff-notes.cdb@m5gid.xyz>
	<V2_format-patch_learn_--range-diff-notes.cdd@msgid.xyz>
	<xmqq33uusvst.fsf@gitster.g>
	<57741bea-f264-45ab-b5fc-52466fdcb03e@app.fastmail.com>
Date: Mon, 28 Sep 2026 08:35:58 -0700
Message-ID: <xmqq33uto0bl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> On Sun, Sep 27, 2026, at 14:50, Junio C Hamano wrote:
>> kristofferhaugsbakk@fastmail.com writes:
>>
>>> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
>>> index ef92704de39..640c5dec52e 100755
>>> --- a/t/t3206-range-diff.sh
>>> +++ b/t/t3206-range-diff.sh
>>> ...
>>> +# The '--range-diff-notes' has no effect but is allowed
>>> +test_expect_success 'format-patch --range-diff-notes=not-a-note (no --range-diff)' '
>>> +	test_when_finished "rm -f 000?-*" &&
>>> +	git format-patch --range-diff-notes=not-a-note --cover-letter \
>>> +		main..unmodified &&
>>> +	test_when_finished "rm -f 000?-*" &&
>>> +	test_file_not_empty 0000-cover-letter* &&
>>> +	test_grep ! "^Range-diff:" 0000-cover-letter* &&
>>> +	test_grep ! "## Notes " 0000-cover-letter*
>>> +'
>>
>> The second test_when_finished is redundant, I suspect.
>
> Oh yeah. If there is no Range-diff then
> there won't be a notes section. I'll fix that
> in the next version.

I do not understand that comment.  I was merely saying that you are
registering the same clean-up-when-we-are-done handler twice.
Having the earlier invocation of "test_when_finished rm -f 000?-*"
shoud be sufficient.  It does not make a difference whether we have
notes in the range-diff or not.
