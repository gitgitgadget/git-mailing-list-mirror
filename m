Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B262417DE
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783803968; cv=none; b=Zpvc6GHbrgpzxpR5Ea40bVSQ1zvmU+HyCo5G45XOlnj7kYeCUAPBg75XEfXA+nSfpxNod3QRLKMNzQe9QSvrRIYDnI9hM4oCsOZ9cg+QvLiDYdcNgQzuy3g01pnYTmxgOAq21Tbeae54mBi8cWbUUOgJStv961PyztDQXGWKLfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783803968; c=relaxed/simple;
	bh=kuc51hl/m6ZbMN4M6+4xPaPErvt7CFW4NNAARfden2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jw4zDtBfDoyFlWUWBdHFNg3lBdDccnXXPEOeRFSgasO+ikaE3qeOQAcm0fqRqbT9eu5a+Vb/Qg8uVFXqQzcosOgfuM+xf1NPa9YtUVsY9HJ12RhrxpnNBvJu1RysucTc3gdLD5d+mHz5719aB7VRI6D7XVERuTFgVmB+ne112fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PbRU4STR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jw9UafEe; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PbRU4STR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jw9UafEe"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4CC34140008C;
	Sat, 11 Jul 2026 17:06:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sat, 11 Jul 2026 17:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783803966; x=1783890366; bh=kuc51hl/m6
	ZbMN4M6+4xPaPErvt7CFW4NNAARfden2s=; b=PbRU4STRo0/yHmsUBSR4KFJk6s
	Gw3pW3iKZe4hl+56gHj6cL8DU5vCK2RH5okKG9JZEinnuqe2V3PEdMvKGyBPoxt7
	Jy4PcInbE3m9bv2rrN4xs2vtMupaP7aADX+OaNIfkPBkDVPf/bK3F/wC0Q+TdnOB
	rqOP7Yp+khwbV2KqNHI27YepUPC/fNVb2ZkGIYqlFEWpqGps+5+uT0KQwEqxSIoL
	NoOTt6bAzjCN0Sc+y6wL10agpAdD95E3JpeCrHXATB4llK8pppOAkZOHn83kXP9r
	q0SNwc2kFvHEzteTqvRDdMagNvk79cOqWnzyWSG0C28JTQdDBQJ83XAv1WAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783803966; x=1783890366; bh=kuc51hl/m6ZbMN4M6+4xPaPErvt7CFW4NNA
	ARfden2s=; b=jw9UafEe8o7TvKWTzLIoNO6K9volfI7GFb33P92YWJycY+t5wgl
	P4wOtCwoVlrUlmwSIg31VYunGSRJIoctB6EyPB7ia0kZEuYsalmiNiNoAoa98S0R
	hf8OXrKvAO6OET4KuAfAIF85o0ly94bQ3UaurdzaPfXHbh9ARByYsY418qvcyBW4
	h45hAhHh11YMfVPbKJ7Nja2jZ8Bhz1Hd0tL4aNP1e3mJgttbpqXBl1xtRskcs02y
	6anlymKmkWh9U+K9NfuwXBeZngLvplCcKz+/PiVGSNAsyxiim4Ko2pBuRTW06r48
	j5S2X8hm97wKLx/pgg3zqvGfu5po0ClaJZQ==
X-ME-Sender: <xms:PrBSater2Tvg81KRWhEB7wsCaISH59tqVb8_zW6FtF0_0nSgVJa4rQ>
    <xme:PrBSau6Vtt-Ba-96B8Yje_6m6qyo4VTdO_8su65_9drd52FVq_oC1vlRU5vQakqCr
    TfBAI8nu3pz0HMSUFIQKCVYRkzncN3ex1gWbBNsqQx8oSTgp2ovgA>
X-ME-Received: <xmr:PrBSagUFnS__BUUoEkaXAeVBYQh7oVhB_pmwjvXTLITWRrrSRJxfxYnGez5elZO7HMbZywhR_k_p-70Yc9pq_Af0Ql3XH5v0Hb7qv04>
X-ME-Proxy-Cause: dmFkZTGKPMdWmw/uXRedUnVzIY23txrjB7nCgcWLvomax/OOSyMYWLWi0du/Z4iDRom/oa
    HzLebVd1fSqgc+l50+z85gVzVvcAOZrzKcQFacf8aH7GfPlT7HipgtEE6uUr2TclNnLzaW
    BJHamPY7g912/VzH1/JbtXvsblVhwXYBSA2aao47dGxgMuXWkAsfoIB4C3P5tu07joX1ZV
    mG8f5a20E4+Zgj2XnBTBxP4T7kgZB7cGVTkydzBwj51LlI3RUCBiiVJ+Ia5DIxZc6rNngq
    LIW8BYIzt97pC+1jNIv1WFz5QwHCPSTvQaxZZb0zE7OsVTc7xdoaslUXWxDlYn3vI2WUR9
    IrkcuXTW+EOgL7uc9Sw4R0Go/ZLUK/gsfLoLUB29ercGnyWR8isWmHm/rzp3atfV8EdAtn
    LrQrQBoMu5DJaHXjZnPPWFgfOkKUYbiCS8j+pcY9l5q5/DVB2E0r+FowcO/0RP1oWpY5tq
    WEzqvqSQQdA0vjn3XHoN+nBwlaTk/NfQ/JA6aNRg6D6NM7cO2AOdKbiTQSa9PluUQawU+5
    dTuDyjsl+icHshmfInjBL3k7I5JNne6GoU+f9DguKWLGrXTzZl4RCC6XW91kqh/SkR0C4p
    LUFmjDU+7yL8GzbAHUPSureLMkXn2KLiL8RWX24QtDSEt5nZdWPjivMPfIow
X-ME-Proxy: <xmx:PrBSat4Q5zL00Lq0EDiqNcZuxgXTwNt3MBa3gqOTteg-NoOKJV-bew>
    <xmx:PrBSarpxp7wlH9urWebVPBslt9FO5ZnbT4r3jVwaC1mALVnUhqx5jQ>
    <xmx:PrBSagmnIHZIrjhKvcWjhws2F_Zjd1vTJXzVi5Cx9XQOhx8Px9RRJg>
    <xmx:PrBSanOrTXoQFSoxps4P7dwvKvOzOuzSZ-bGb-lFmiAga8UeldFTvQ>
    <xmx:PrBSaiJDmG9npLdlAouHXQTdLOzk3NoSvzBreeRrtIE1aBtkZv9ZAGGK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 17:06:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: "Tian Yuchen" <cat@malon.dev>,  <git@vger.kernel.org>,
  <cirnovskyv@gmail.com>,  <szeder.dev@gmail.com>
Subject: Re: [PATCH v9 0/9] migrate more variables into repo_config_values
In-Reply-To: <DJVUGL8XA0Y0.12LN2COXI5BIY@gmail.com> (Pablo Sabater's message
	of "Sat, 11 Jul 2026 17:24:12 +0200")
References: <20260708160300.8852-1-cat@malon.dev>
	<20260709161145.13349-1-cat@malon.dev>
	<DJVUGL8XA0Y0.12LN2COXI5BIY@gmail.com>
Date: Sat, 11 Jul 2026 14:06:04 -0700
Message-ID: <xmqqo6gd9qyr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

> On Thu Jul 9, 2026 at 6:11 PM CEST, Tian Yuchen wrote:
>> ...
> Hi!
>
> I missed a base-commit to easily apply this locally, could we
> add one?
>
> Thanks!
> Pablo

FYI, a topic that is in 'seen' can be extracted from my tree by
inspecting "git log --oneline origin/master..origin/seen" and
finding the commit that merges the series.



