Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B823630B3
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352659; cv=none; b=sTwehXzDX7h07QIGnYHHh+UFNAZJ8orudcemf3jjcPFrGn4Fc4S6DDAcFt1UT7XDOC26GjnSkgAT5dGzhXFZZpxWe4nmDvPRJg91rwecl4AlMyGjQVkcG1xDPmmHNzO14Jgq754w1kDnI4HwnzAedn4MmggbpDjQXQBtBhz/tQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352659; c=relaxed/simple;
	bh=U0MDoCPt4EB9R0Jphbr35vyM/eAC8A8aJls1mNwyM/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A9WAyfUJNMSNErwuxbCm/455GYVnSfPg38EdxU4lFaM7fnZQCB6FtZpN9swkSGgrp6tip3MqjQp8bXuKrrK2aNGdConawXIcw2pxpc8L/VnP5yOldpX0ezv0uR0iQVzWGIGv5zOqnZ0BXZRmt6pq/W01+ByTKw/DZDWHdJq9r4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WnFc3ySy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gZ5Hv2zi; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WnFc3ySy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gZ5Hv2zi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 99B227A00D4;
	Mon,  1 Jun 2026 18:24:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 18:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780352657; x=1780439057; bh=3d5z58BB6P
	/dCtrddBrwXQMyoR31JOVGat7odOqHVRU=; b=WnFc3ySyUBKN5C06aXQW6cjDbS
	0uXlB5u37+1bcAmB11/f08IP+LY2mY/zpIfA/Vj/5xNtuRV3IU07368jtnkcxXts
	+68dCaPX6AzyC295eh5ZB8NzCVHKxe91ag2ia4UbANMU0g1zI9NAHYBsJZMLIp+g
	luhW0jIrfVxmBmiR+0uAa0W5wQWTtq/+P3aHFYNmyeXiOYZxJtklwn8n63I5+SoR
	pIikcYNBwinWmasSykv+rJumpVShmVIgLWJRm3AYqnrKwKoX0kcExpgpfA+OGcDV
	9Bw7QE5NdQw6A2Vyh8rYvMrR9xzMpxXZj1zbJyCJsQ31u6brARgWQIqvrplA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780352657; x=1780439057; bh=3d5z58BB6P/dCtrddBrwXQMyoR31JOVGat7
	odOqHVRU=; b=gZ5Hv2ziqyw39rJXzzPUV0Vz0ONrZQ5szrm72kqBdM/OrFv3nSb
	/6x6IviBIHDiOi+ZEOs5m7cqGb3cNFechJpH19pR1/aJIhJsCtCOseokmYOzSmEB
	fEhf3Glz9WullffDF1lm3w8TJGK9ZtcxQ/8X7bkTvWXbIoKGw/0bC5slLVDVZACQ
	v33b9p+IktogQz0na6y3qCQo6cUVdNHFvpGrm4HuVTHPPzt2fuJuuhO/l/EfcUf3
	8TVZm8cAmY55or8As+lf0lq1Mx7vvqEpzHYs/h/NqP6pjH288nnR4uJ1CujbIPis
	b2SDx/dZ5bGL0w3azMcURYThrUIdtI01muA==
X-ME-Sender: <xms:kQYeapjbfrWQ1hoM6Rw0iNSaUlSokIDEVrRarFIcmes__QuP8vWpfQ>
    <xme:kQYeaq7kiwfC8XLQ9AtrJKpuSw6-WirYnwiEII62XRgNa3driaHyB-0u_UlUZm_lE
    el3seOmt4pRxOgjnIMlZirqK54zjn3vjh2NV8ZKKBUQhriKzEwE>
X-ME-Received: <xmr:kQYeao1n-acXwFhzwFI5jthELx4XhodU1eArsheo2F95LjQ2pYTXQcw84xAqKZKyNUasveokySq9wd48b92QnWYbVYKlfpVwoI_C>
X-ME-Proxy-Cause: dmFkZTGTMTN/C3bJu2zLV3KN0Qg2poyOo2qPj9SlBQZhn5X7KcXrsRtOjJxhNCtMwslFYo
    cMi2R/l625lQQVpCM587Jt6GwDR58+SUBOIPfCymzko54d6SKPeRPqzpiRaYXIfFCQOjU3
    5QMF/GWAbLKsuV8gWtC3dYkayHciBEoJ9ZQj5yc0QvPsITq/PWxhzVXdtyLscCjdJUFVR7
    1v4Q03inVwRqvD7eClgjWIlUHjLGe+0tmXjATf14QlbfqlYMcPh10xwndgqfECEeBVggl7
    /sA8Cj3VLufX9HXhsBqqsMY9p3wwLXyRKeSCWHod0E2Tts0TCbzAKMubFJ7mWKbOIt75iK
    Owry71bTORESXuaiq9eDPnvYXVvkka+M3H/lSgZ8vJD0hK8+zXGcYBq3+JYTcmQT9tdkUq
    142WG0Q+ZeruOAdCBZHif4vl4b9IFHLx7MS2ZbsNtcYp+/cru0UQtcuEGOioBXR1VyinTt
    zoHSqbqfbgEikxREoYfL4Q/wFE6CpxmyzZ9TDii8Xm02KxjjMeUqKz4qeLD3+i1fOG9aSn
    4vdXZ3GR8PkPg/lSNPmEieiP7ybMD6CBCU/exsw/ChoPxEuqUg1qy7YeyFr27aEjFugEHV
    9WyUYv2WiYcfFfc5tWbuy6qn23TWPEKnG6LN69dfuZXfV5g9K5jUnXaNUEVw
X-ME-Proxy: <xmx:kQYeatv0tdVG8-Yzq8MiI6AH5Rka9nC_rAbdOJP0TYC_QcdUKxR73A>
    <xmx:kQYeam65-y3Ie5j8LfdyrsaTK3GmUn2mhR_U6bY6-HJUNWIsZ85E1w>
    <xmx:kQYeahfENdsGVFYEHqsOD25TunQbvixECAAcXx-wMWC7bbV990NJuw>
    <xmx:kQYearwOEdMOoAV3tRjsD1p-Fsv5DdSihasLESpUQRQy4VPLij01Lw>
    <xmx:kQYeauq03h0dWbGel1MifKxrKnzoqD7l8fQ5COFwvmwpKj8SEopmHza3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 18:24:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,  Tian Yuchen
 <cat@malon.dev>,  kaartic.sivaraam@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v3 0/8] environment: move core config globals into
 repo_config_values
In-Reply-To: <xmqq8q8y3pjl.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	02 Jun 2026 06:43:10 +0900")
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
	<20260423165432.143598-1-belkid98@gmail.com>
	<xmqqqzo27fnu.fsf@gitster.g>
	<CAD=f0L8-_3sDGGkCzF4WA0xmUtaY_qiz__3zq5AemLgwTsqvsg@mail.gmail.com>
	<xmqqlddqu013.fsf@gitster.g> <xmqq8q8y3pjl.fsf@gitster.g>
Date: Tue, 02 Jun 2026 07:24:16 +0900
Message-ID: <xmqq4ijl3nn3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Your mention of "the next revision" were made on Apr 26th and it has
> been a month without any updates since then.  Tian Yuchen seems to
> have made a few review comments, so perhaps it is a good time to
> update the series to stir the pot, hopefully reigniting interests in
> the topic?

Ah, I see you now have an updated version.  Let's see what people
say on these patches.  Thanks.
