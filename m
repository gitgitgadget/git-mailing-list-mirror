Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FBE242D7B
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783810004; cv=none; b=Dl5p5AltyIX5OtduBoHLyj2R0RTdXe13IBKqz4tSN97xUb70wh7bMpNOp7Hwkj3VMzNSrkpRmw/rNgft5cpRn/FHkTuT3X61TNvZIGX+asm0Ml693kal6D02dlYeKenTsheEw7FuILz04fHexPylNoTHhvm8OLD0Djp88TxHQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783810004; c=relaxed/simple;
	bh=edRkc646a4AEb55/LEy9/hKGGsUKksGeZCjZ+oJ2C7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ObPwEv3kO6ijXfIlXNNXZ4SBDv6guXULD/RMEke8mxEVcfsOj3ExN8QVt/Zi0xbx4POn1h8SsxUAKVCi7QQBmnrlKWY5vlw9nVwkPo/R8gf1hZiwNjCcbEhCjP4M8h+Yx0wmw3+bogU7Tr4AApCTHFq3Fsarz5Nhm4AmlNlZq8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E7VKrsxc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/cmEzC3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E7VKrsxc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/cmEzC3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 649D01400047;
	Sat, 11 Jul 2026 18:46:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 11 Jul 2026 18:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783810001; x=1783896401; bh=edRkc646a4
	AEb55/LEy9/hKGGsUKksGeZCjZ+oJ2C7w=; b=E7VKrsxcVvJrDROEbW4tQD/QZl
	Dlzub1rj6i09fiPWh0ReIynqElB0I1HY2pVRcAKgm/q+SqoorJbvRPhwD1xTlkYZ
	SDJ/Op7KFKKV4NtqOat/NDhI/8EBc3BU2poWIVK+VzwGZ6MybEy0z49NDvSNR0Wo
	UryBjI4CAl/zBp7V+ovhe/MmXKwZxGEkaoe08MszfnCFerZJOQ63OSWzMbtdXQOu
	qIfyK9+Ojdb9y1+zoTjeHgMiab6JbEQzq20Myuhy3/sraFTWGnXYOebdVACVtvWV
	yHpaUA/TI38ZnBqKuFybbcu1+Uq1txk5L1BWj7iTVkxkiXFlGh6NuDeaCmSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783810001; x=1783896401; bh=edRkc646a4AEb55/LEy9/hKGGsUKksGeZCj
	Z+oJ2C7w=; b=m/cmEzC3d4li/9+ZK0gBy+a6u/pM5v+CmmQY96Ymtq/sVKmz4/E
	FGuWXgMi8ZIhe3C8QNst1ejJSj759vkT4TjTo/oAHkssEUnxZ2DJshlcvAt1xm7p
	2DD6uAsNrTNFuR+t1AmduYxKT/SsV2KbkcmUicLruEdVzh1pWrCrjcQebNcv4Uml
	/znOfsYOo3pR01PaUyxIrvvNjYilMEjfbCgjlyCOL+ndVwSAsfUZ+7+To9Oo9Wfd
	dXJsHEwrNkGXVKRx4+6Bfu5vNVn+RJt1BpYY3/5hT93rKctpUINdNBjtRlEUmP6B
	CG1ZNp4Iqlu/u6JJt83lANTmCo7aGoigaOg==
X-ME-Sender: <xms:0MdSajIMRtF15cHeCxttCKzQZcibiQh37jNZX75r5rOaDtk9qpGC2g>
    <xme:0MdSan2LjzIAMmr44mizxadED7emE8KeCSC26RHNuBoGMVnJmBQKC9ZgE89P4zGJy
    w5H8npqDDBVGMX_8bkmzE7i92jmAPBKPirZqBNbPLDj663pGKRrLA>
X-ME-Received: <xmr:0MdSap6GYcP_ZnjwaLobbIso1FcBp6xr2xJTVtzn35bNxs7t34KpkERklJEjHqEiTAJCP_41grG9cGvWlpTiSFJfSSOM5_2EWCyzIMY>
X-ME-Proxy-Cause: dmFkZTEASbjS9wxKqy/0Lbt+jNMDironn1XeCVDB4SN+YRfl/vbGHgD6dVegrAWPqZ6CTW
    NrCcwfLx/Cc/fdVrGdqDGLThewjnb96xfeSSH7wGPcRADgWevR2XXL2QToJdwMNGxjxwNO
    m8ucDj5Tw7LBlzUNOg9TLu0k4t5yvnUw1vLPnXkDhsGXxlAE42O+YMXk52a/3oBJQDlbKn
    a6NZM9231tVE/CeQUn3RScsjLedPK6xom9TaRHIl7QAdh3HAbp8DodHnx0SrLt1fbk54nP
    2WZArHRz7gtLeIuaEHuGlayF05pY8MkRCpu262G2M/TgOR6FZv0homaEtGzh3hg3XKGoVy
    UjsjZVRo1PKRf7erRMgI3mq9qppXAmKW9esoDsxiPctiRaphzuNpsYaOS1DqGZtDSrveCW
    klVyiovUWW/SRofkzd5mpqteTOqyOTqF2RL072Tl1h4PqHw3lifrfkaEq8XAHzc2auZ4qV
    SdEXpqDohZMR/QAo+B70fAL+cEya+1+fBGUkoldFhSNxukjFsQ0k6+GfB4hkBrgopNdrEq
    d7Yd96DnP8d9olkCHPE7WJKtzJWhwO83y27V9i9KrLtPAXJviwdOvOShNInJdU/qTLgAZu
    nk43sxO4v97YAvUg0bK9qo3BCfS6EDhXvJT9xpPmiaBpGxAwzBkHyTQjQ+3Q
X-ME-Proxy: <xmx:0MdSag-lbT8hk93jm_l02BWpMRwu-q6NipRmEVu-dhl59n6HdJsy8A>
    <xmx:0MdSagUdqSOiFU-YNBTnfRkmYdUoZIaKJmVl4ZEcQRrh5EnPd3SrWg>
    <xmx:0MdSajrUGMQNn1ONYrqpNnAlyCQ-2QIS_pzbgYwswRaO7sXpvuLFCA>
    <xmx:0MdSaqk2Q1J7HLK6wXS5YN2Q7iED_Pvf4-8dMaOixrVkLCSeyyb1Iw>
    <xmx:0cdSakFMAP271R5DX5csRolQZI1iFZzn4lIIE9nwvZArJ_RXDNp_QjNT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 18:46:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  Jeff King
 <peff@peff.net>,  git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
In-Reply-To: <aktOn-3K41Uhl9cr@pks.im> (Patrick Steinhardt's message of "Mon,
	6 Jul 2026 08:43:43 +0200")
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
	<20260621174934.GC2206349@coredump.intra.peff.net>
	<ajjuoS5Qc3K0nCRl@pks.im>
	<CALnO6CDAG4e4A_Qn-3QVe0s4D9xB333Sp0QRntNATwMygNXmQg@mail.gmail.com>
	<aktOn-3K41Uhl9cr@pks.im>
Date: Sat, 11 Jul 2026 15:46:38 -0700
Message-ID: <xmqqa4rx9mb5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I don't think we'd necessarily need a way to detect this. Our current
> build default is to have this disabled, so I'd keep it this way, but
> automatically compile nsec-support into Git if available. And then we
> provide a way for users to opt-in to the new behaviour via the config.
>
> An automated test would of course be nice to have so that we know to
> enable this in cases where we can determine that it works. But with the
> above we'd already make the feature more accessible than it currently
> is, because I'd expect that most distros simply don't enable the build
> toggle at all.

In any case, the discussion tells me that if we were to pursue this
topic further, it would not primarily be about adding the build knob
to meson.build file, but rather a bit more involved to affect the
product for everybody regardless of the build framework used.

So I think it is safe for me discard this topic from my tree for
now, with an invitation to resurrect it as a topic with shifted
focus.

Thanks.
