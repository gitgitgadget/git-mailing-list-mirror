Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227D38D6B5
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444638; cv=none; b=Q+mqh/AmTl1hBM1qPBIJqSYO5dT+jxbgIlNHAQj7y43F3F/BaXKUSuUO4juhE6ruAKK+5GHES+0gsGBx8dg3u5it7uRxKzaHqcyEBZx1OFI5iNxkwA9bzNTVjyv7v9bak9N4HrquaNk3+04zBecQAwSTc67g2Nm1AmU8Ua7Qvw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444638; c=relaxed/simple;
	bh=cmOYPRshfaHEuXT3BC6JQKGIo5DIMXyfVUOv7QJM1Og=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bdBCgDAsH8kHcuwG4p1ELYYQHyxMmxnC17Eoh7UR3/FAkD1jZm8VtgufrNB977k7aav/E6wOO/UyMhAFw4JvwHUWiQQOQimQ1GpmM8JMoieBOcOd56hWcPI31nhiWsuIcXR53/+CFk+IsVPOmm5rZ35mC3EeJZJkQBr2VYRSrbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VExhcNt5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LEir8LaY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VExhcNt5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LEir8LaY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A4367A00E4;
	Tue,  2 Jun 2026 19:57:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 19:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780444636; x=1780531036; bh=2UC80M2my+
	l0K0OcsFoAS1Y4I6Qr/Ow89+PbyRZh9x4=; b=VExhcNt5RFQ00SZPHq5DNIP/A5
	PUsLdpCgsF01+ofwADKi2vqcC9q3jau8c0cWwNr2rzTxkqzf+bmnqIE33RulvxnT
	K1df6cx3IS9svXZTQZwuBrvHCkXv+qASWEI46JPf4CqPG0z4L7STqgizRre416aE
	zBU8WcZsRe2ho1uLq2hbo4rmvQdtOIYikW98Mmp3Orty7C/AjtmaT5BWl9lwYxXA
	LcLa31lXqN5oOQuiFec1GNg9CKXtpIO932cWV/7GT2mKdDQANdFIaXKZq05XG4Rf
	7XEYbohDHW2YF7eCYq+zz+HLFkUMIRWsJSrihWAXqV15judbxEe7zBtmj1VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780444636; x=1780531036; bh=2UC80M2my+l0K0OcsFoAS1Y4I6Qr/Ow89+P
	byRZh9x4=; b=LEir8LaYaNooyt+VBtdZnfZ8jRF708GHfjZziNotutVW3hSWNxj
	SwGSYghzhbEwppAofq7IkviI9lpPBJSjmMW1yndmCIWGLThUHt8nxmThrNZecjXq
	pnka+44s2sXixpa9LEb01z90lCeTqbxdbY1/Nu00sKPl2FDHm6Dwv5MhQrNh/5sN
	dxnV0yztcStrhPbueJOLOzGornxKF45dXHqyU4WZb+Cywh60W1m9Pug7Xz6iHPRk
	Uj3w+cE0wu1RiZpitewY7XblLKb+x+vbAEogg0/iDfUNFzUpLcgSg1TdWXf2beQm
	NNz5/ZHJ/BXapvlOi1OG7OeQ+EqAlE2YG3A==
X-ME-Sender: <xms:3G0far3lqMVwtoVXudPZztQpOLTogi75i8kJmxjE4kLoYQ6qfB-dAg>
    <xme:3G0fahiXX0lwdpuEEh7O27hyIUg5rIKPJInRZa-BHnIoiCITvBuKnRwSd_CQzEsuz
    Nt1fyrENS3Z3pKV6wkwn-hOsKJXjyUGjYkEY0p52bYP7Lkg6lERKg>
X-ME-Received: <xmr:3G0fapTtEG4R2a75LkhkI5qGOQpeIzN8VrNLU31H8qkBsdLtdctR1kpyTsTKBtZho6RDjJR93z0ybzFGaAgX0iDtHotS8zKxIpze>
X-ME-Proxy-Cause: dmFkZTFPwelA5ZDSckGLsEKOPaBHP4uwhRh9ijM+EFqhMcBuWge9W3wELFUmemroafY7iu
    s+xvc5lRfhRGK19hspnwnYF33hFykG2zqbFZEDgLUJPE5dk+rPnxHdhfr1m7cNCo0m8ST/
    9PHiTXVfcN8kc4VySZLSOtvXpMZL3G75sHFIJzIhRXZnxNE9v9Xt9hSJAC0t8mIK520Bmk
    /1N3WZGY/67Gjy0umQWjNup4GBmIeyl3ncurgiTX8AiAYQLb4Xlu6uyFlgT/sqqA3VUl9z
    O2zZlJiSgKqAz9wRkAm9WgdT2Pw0rc4PLKwPJsjxyCLWn44+WykGHwsRNRShXeLwJipmAa
    vpnWdzFt6nVx0ZkqR38UJkbEdfyuoQUy1zo64L2C+0H8JsAZzUXv1o9DZFeDazd2Iy4u0t
    v/FDblTFWMWJC8eUOT6eWCQGvA9LkDcFDQdYuHp+ieZX3ueQb+dP6f67LbwIYUX7VKBPl7
    y+STHKXmNcoOkda3Cv+6ccN0BKeoJAyKu5iazSvEusqMbFQa9rIzBY5ZexDB4qa0uBvPGm
    5vxX2sZQvPr6BBqK1Eb7Os2k44QWeV5QHk7PAz2mm2TVWM5waHvgKPOLXmwlBlbXc8cZHE
    3OUWS9bmuyEgv0PjS7k3F2GajkwKE7LxHoVSjftzlrqQpcm9Q+Oc9d4Sf5Rg
X-ME-Proxy: <xmx:3G0faqij4ldxoVDPnoZ1LFbRsmIs3VSZiid7ZdVNAFOH-NBbUB9pMw>
    <xmx:3G0fah4aygNfnskIiYEeRW8IPTwZiU_8e8potcKDCjke6pB_GpzOpQ>
    <xmx:3G0favCTvVIdMfSGpiwgJDOYfELVgx02rP7taivTk6VgzwWsyq0huQ>
    <xmx:3G0fagantHySVYr1Df9metSGqdBgCYO-zqAwxZhnJeH-QSZJK-59CA>
    <xmx:3G0fajq-7d-AMcvhu5_I76fHMcRq54roPF8Il3BvLiT0utx5YP4QSEwh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 19:57:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kiesel, Norbert" <norbert.kiesel@creditkarma.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] worktree: record creation time and free-form note
In-Reply-To: <xmqq1peots9i.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	03 Jun 2026 08:52:09 +0900")
References: <CAPGaHku+RAV+FA3C0md0xHiavfdB_anoqcMM06MAiU1VyMAdLA@mail.gmail.com>
	<xmqq1peots9i.fsf@gitster.g>
Date: Wed, 03 Jun 2026 08:57:14 +0900
Message-ID: <xmqqv7c0sdgl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Kiesel, Norbert" <norbert.kiesel@creditkarma.com> writes:
>
>> From 130cd5e4a25e6672b2a97268e1100b6ef03fa552 Mon Sep 17 00:00:00 2001
>> From: Norbert Kiesel <norbert.kiesel@creditkarma.com>
>> Date: Mon, 1 Jun 2026 17:03:39 -0700
>> Subject: [PATCH] worktree: record creation time and free-form note

Ah, I forgot to mention another thing.  Please do not add these four
lines to your message body.  The information belongs to the e-mail
header, and as long as your e-mail software is configured correctly
there shouldn't be a need to use From: or override the time when the
patch was made public with Date: in-body header.

Thanks.
