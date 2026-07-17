Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7AE3EDE46
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284955; cv=none; b=mF7B8oBD6bes90mf8ga7fxjUE1M5T978rsZTOZeTCAWyBYOw3KdPFwA39p1OFKExfd65T8l7IbmxvBFzJpUWWMAN2ro7q+kWmWB5gU8dv6/ufkW0D97okKKNy0JsuaHCcvJ/bxbqZeJVbz2szCZJdtzm5a6IF4+/KGQGSpg3E9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284955; c=relaxed/simple;
	bh=cZtmqUAzjmsJLKlcDcSUAi2z+Rlk2DayWMzz/0Ke7U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnsPVQp3ErM0GX3Chs2EsL9bhvjAIss97oXWRCPap4mrutZfNxtQkaV7Ow/h6Z4gfkfPLM5T4/l0MCSdtuyTaebZMUSoxdsz3tkx8whf5nIjjPLLX7Ixgy9fD2qEdK6v41tPsyxVnnehZvVcfYevDXWsWpLs4lQ/ch8FwDfgujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Enxw/xb/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qsZJJhaf; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Enxw/xb/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qsZJJhaf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 782FF1D00108;
	Fri, 17 Jul 2026 06:42:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 06:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784284949; x=1784371349; bh=9AiMcrYo6h
	bDPFUH4ovOTl3He9hxdcJzKo2tG/KSKVo=; b=Enxw/xb/JNCwoKXkxPCfwOcVrJ
	GX/GJUSxiO0sBqZMkGdH94DK4FjEbSmz/GvjMKhAa9qv7u5o3rsr7CU6LiO9CThE
	uaWmWVXZPKmZ7Tg5UXvE4mZOC1KNNXv83gkr0C7JnF7X6b7pSYPz7mZf3Zlhu3KN
	f17EO5qrNjGKtRjPwruO+7ciC/n59OhxC9TrrY/5zuPD6qLoKFvOvIDcV82RI9mp
	uq3b4p3KMK0EjhsidKYUSX4NL2WwyYZRsI+e+/sjT6AyGsHIE7hPWgwQ2QwIth52
	mr4NNQgyldBx3stXwpk3qTvKpuR26w4NUBO0AbhK7Xab0PVdVtTKUPseSShA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784284949; x=1784371349; bh=9AiMcrYo6hbDPFUH4ovOTl3He9hxdcJzKo2
	tG/KSKVo=; b=qsZJJhafdvhUP5+LG/0GTINt0Ui9BO/0nW0fdB4Pxgc4Oy1IVlt
	nEmiAYJXpEGBbpGpMfkRZJy1qOPQ5oans+jf5sOudUX7a+03FLLK4ZPd2QcJ9Sco
	j0IZD+yLvBQ7HadCfjwxq/4YWkO1fIiMJlknfFHC/HIRIOuwqOyB0N+vQN8n7Q21
	vcpTbbtvDrq0U874/cIk8GpKbU3trgfzw21kIT9giaWi9fhqSn9J/byQ0VnJ/u8Z
	IVXqhUwE7evAxhwILG7rcRo4ZjWOx4fM+MkH8uLPAZQ2d8hrfYtw0EPHwLfMHQAf
	SBMwIruQTAjd0QR99BX5PKsBTTtg82lMYIg==
X-ME-Sender: <xms:FQdaaoohhPVn_qIbPB9mEvpj1lUq2riYPDx8TDOp9QYggDHdL011tw>
    <xme:FQdaamE7boivy4uqAxKB-nAsvVJZ1XwMsHbm0GRWBJzYkIEu-u3huOUFQmMByfhQa
    uCF-COLDEFuz5-n9KWCWbFuLS7xZXnTlj_kHC5pwO9nYZmd5YiISQ>
X-ME-Received: <xmr:FQdaaql2MjBHE-3cOa4ml4kAiO2No4iP-fdpYNmislNRiJFJnMhluoc_BKA6vepA8vjOvv6bnL9QRZ1iFhLbzxuPyl1FfiNuNDeasmlKXuA>
X-ME-Proxy-Cause: dmFkZTFTUuHKfGatM0E2/bxv7GyoMFhzPfyzbSq7/TC+Qhl+tAzaYyz7oV0oiw8z5tt0JT
    Ihozl6faksxJ888oFgfQqAqssD6eETSJMPUkcpbA4hwFJYpXPFaHlbmMBp1NS9Hm8gSEQk
    Ul/26LXFoeOMapY5Ir3+2vmZ4jxadkk1XLA2S5fR2d0i7y1CM/+TapXtu64PPTygFmV540
    7swrWP0/qUFkMEkcpaDosr3acygnHtvkWtDwgQ1Jf3dXhnhbJpmEjKcO3zRYuDcKBY1HWl
    jfSwiUUj/gJssa9S3bxc2h8aXmtl7+bFkvrnmtOgZ8q/OsF1pnOsOB+wduHr/jfO0szQFx
    8pKOQS9mfaFGoZ3IyLge7Xf/+PreRZwpc4tckfQ/u0mKTL36b1UQhUW9aKl2tS3pI1PGct
    7F170nu+4EhdvRstUscT5+b4Eh8m7OkD9iETb9j35LivWFNF+QE8IzgjwwHiOWtm7QqNaQ
    Al8PI9utiGuoSnIaJkci0xQ6G3C7oxhbkuzYJORALpsZG7HUwz/EfD+hv766lGOjVw8As2
    Lafd+9I9lqvLEnp2w9x0zSkwA4YJ5cKMLKeNfhfdK632+p1G0AGCqnVAkmeeGjD64zRMoA
    iEWxwKxojjCNaeb/oV7Gm1y1pEKnL+qo24kbvGrOKwe10I9r2N3zfItRjccQ
X-ME-Proxy: <xmx:FQdaapnfrrbsn5R6-UgpdQyjE6sDOzJCuqGN_vJ7onUkFa-2Z0oMGw>
    <xmx:FQdaarslxh4v4Owav76LsunchbXx9onE8DZPR65ms7qUouSckmRmmA>
    <xmx:FQdaasmTOR1eBUh_3KYIYeHtmpkBySiieJDEv0fzFpjZ9nXRrvv0tw>
    <xmx:FQdaamuMaSXJeqWhbxEu01tLq8xgImxEE9zzynBfQIBNgUkVe5noeQ>
    <xmx:FQdaauGIcmKhDbP20RSAY02hQXU-hQ7KV0fz6sgqUfcYltIJYhaRa2ch>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 06:42:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 60a38c8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 10:42:25 +0000 (UTC)
Date: Fri, 17 Jul 2026 12:42:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v7] show-branch: convert per-branch flags to commit-slab
Message-ID: <aloHDhoerEhIXxFA@pks.im>
References: <alntPJy2VwVK75qj@pks.im>
 <20260717103454.62750-1-gatlavishweshwarreddy26@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717103454.62750-1-gatlavishweshwarreddy26@gmail.com>

Hi Gatla,

On Fri, Jul 17, 2026 at 04:04:54PM +0530, Gatla Vishweshwar Reddy wrote:
> Hi Patrick,
> 
> I am a real person. I used AI help for structuring reply in that thread. I understand that is not
> appropriate here and will write my own from now on.

Okay. Using AI is fine to help you out, but the human-focussed bits
should really rather be written in a way that it feels like we're
talking to a human. We're a community here, and when you see text that
is so obviously written by an AI it can get very frustrating eventually.

We've seen a strong uptick in threads that are obviously AI generated,
only, and at times it just feels like one is merely talking to a prompt.
This just doesn't scale well, as it leads to constant iterations and
back and forth without much thinking being involved. So we require the
other side to stop every once in a while and invest the necessary time,
too. Otherwise the community will simply stop working, and that doesn't
serve anyone well.

Sorry if I came across as harsh.

Patrick
