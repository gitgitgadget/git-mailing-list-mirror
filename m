Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1054968E9
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199192; cv=none; b=WpVtCq8ZJAtfxPpb/zMgLH4AzRKYA3/1KFudvk96uiLxwqFRqIe9cioVkUlafHZd5BJvsL4K1gQZslbgiDN8qKyCM5c7CEAh7nqQ/TIHzUwkAA3ujDKZFzHelRQZyen/pqORT6zY0P+H/pAl6+5iqJ1u2y5jr1jm239C6n7x6n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199192; c=relaxed/simple;
	bh=6d926T4gtCPfzaV4dGr+NA3vIdh6gXa+DTvc67+++cc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V8x7WsEZHl4dP0SVYEYvrpwZhlRdbU2shbzXs8qlVvh/HA07EUxvVAS3zYP+7kElczW87pATBRYWjbg+rCJ4EbvVAHOQUwz44q+diHe6usMlyY67ia7In5h581HZ1/ulCGwOE7AOQ/dNktPO1f604/Lth8ciuz7Zybc3Y+TlwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hbhAKKAQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JKmo+q16; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hbhAKKAQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JKmo+q16"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C32DF14000BD;
	Thu, 11 Jun 2026 13:33:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 11 Jun 2026 13:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781199188; x=1781285588; bh=eNWOB3KyCr
	tz81wTGGFKbfjP+BuPCzMuMzNOBMSZOz8=; b=hbhAKKAQ+58p4d26eTTAx7z0+y
	B9SB5jX1ihpuieMhC+knleatrA0Ua3tgpm+zgMw233RPRmdRj+B8paqwR1fuDGC9
	YDaFQ6sZYXXNgUUuo+1bigJh8qeIqICtsZdQbD5sMHmyDxrrFPP84ti99IrKvMka
	COQb5Ch2CkJgJlH9xmmBylp0uVGRJwT/agf96tIGABpTnkyXw734qS2Ct9+kTQNF
	xD2G5IOaEGlypJ9C3PtWrg737ptRqLncyrh/T86hpakLw0ZixUU2tye6lBk4JAL9
	HDZeIv5K+4fWZDzSgbojnVQvD9pVIj5tkIpPBwJh6WtyllL6MweBrzGg0WQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781199188; x=1781285588; bh=eNWOB3KyCrtz81wTGGFKbfjP+BuPCzMuMzN
	OBMSZOz8=; b=JKmo+q16KRgSxxRGg49CohAmc2HsPOqdDtNoVlki/eHDEg0ShBC
	IvUoqWs0t8x6LnTQCWgTc0zIXO0hDA6a6hpCylndJN57gAyGRgp+cTnzlJGarf/Z
	N7r/Lu6CsWt7N9uNBt0P6V4SGlVDI4MIX18Hjf9qH7IpxHt7PlrBwIltM7uKrKF9
	xg5D29aL7JcfJcZAjiO1q0mkh6+GH/5iIZZaaAmqKLavMYIpALEiuv01I+lzDdJK
	WSkS3R5t2e+jjzqQGLlCo1xTZpRGm53ddDCnWn1h96yzFlfqAzOZAhazTNXLkn7D
	ED/rGLrvH6ChpcmnE//uL6RDKEvVwzYLtnw==
X-ME-Sender: <xms:VPEqasVpFvX5D8Ht5lRrPzFtc75UavSwCDUKiWxGunqFZMPG1Fi6Lg>
    <xme:VPEqakRIn8z6vii2Hxyzu2bMvr-GwaDElrJf3Js9eBWj7xP2OZtMZjDv11QXb1C4m
    bsi3Vo9Q6bSQHLe5MJAQrvcJ4X4zEfvFSdrpUKn24UnRvtvR2Sh>
X-ME-Received: <xmr:VPEqaqM3Mhr5XqBtI51OhleZ66hoM7tiZSMW7BPp4ZxekDS0o3e7I1pGgq5yyDa7neWJLMWdRNLcNZyij3HIdpDBfjioToIBVPHY>
X-ME-Proxy-Cause: dmFkZTEAANHHpcQY5imSc+ptwHRFC2v8xn3iXRTq1h0U2uw4BTB6gh0uTNZNuT5c+J7zia
    GmHWz4T6uIxvsaktkIisSVse9hwn20fPGv7BOxDlPJ2c4Ci4GhiqcoVwZlLELXYKmld7rr
    9CqxafLmrQx8vh+dlp8ckKIxvvx9Mp7EmMk+KBnVIq7QnkuFzvLiIqfS5Zybm5ZxdfUy8S
    EgmbtLQAQCcK0pX4ESLcVrNLalL2mFvekaRbJ9fyUUK4u+pGsjr8Jx3vlaqFI1eoSSloiP
    F+6eqt68xrfLS8orruKYJojlPMY7UEe3mDPrOQqghwkUrFccvlA1tgr8OTmYvP2V3LAhbU
    vvJHXddUlxxb+WxwoAw5ePoOJ/5ZvmjROVrUohfmK22rIZM7U90W79VMAcBE7oO5EnNmJi
    pIFLl7260PiPC93SWu0eOIGaruMWOgQeVRdyYFxjv3cjgftmuJWym7wm8OzBpcfD1ff8mh
    BxB9P+a364GO3f/acg0wVRJGsfFiByesoY8lQnmnim2JhHw4NFhRuNO1Lzy8c9dDELkidK
    3CWuTAmKa4yA5EmfNfeT0xk+RtoSmLfRJ3NrwPP4ftMPmjf9gV9uoRDh1uM4QZJaSsDrwJ
    FKl72JhrD4XBy5kYl46nu1nnpbKaewt72pWQx594eFZ9M5jUKJ12Ky3gR1cQ
X-ME-Proxy: <xmx:VPEqaiSSj83_rIhcZ2ILHnxTAH4vLjPjz66BmACThl-tMKD0JAvTmw>
    <xmx:VPEqaohgE9u_wy2bSFP3Sw89KZtVPF5TPMZ7fefmUi6Tj2fmsDOPQg>
    <xmx:VPEqar9oiixyCBzj73zg9CT-AFiT57y8SgnXLLZNh62tY9GGH9uZeQ>
    <xmx:VPEqavGpJpGS7lEc7dvBTdvhkoVMrUtE2lG1IfpfVjmNaCRFPoz8UA>
    <xmx:VPEqak-ZH4yLU-WRGqTNt4QISm92DS-w7Eg7xxQsUqBSBlgKhop0vu5n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 13:33:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Tuomas Ahola <taahol@utu.fi>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?=
 Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2 3/3] doc: git-config: escape erroneous highlight markup
In-Reply-To: <20260611083139.GA2237523@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 11 Jun 2026 04:31:39 -0400")
References: <20260610185148.23920-1-taahol@utu.fi>
	<20260610225513.6269-1-taahol@utu.fi>
	<20260610225513.6269-4-taahol@utu.fi>
	<20260611061156.GC2187173@coredump.intra.peff.net>
	<20260611080242.lqXwi%taahol@utu.fi>
	<20260611083139.GA2237523@coredump.intra.peff.net>
Date: Thu, 11 Jun 2026 10:33:07 -0700
Message-ID: <xmqqjys5nfsc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Using backticks does work, though it always opens a typographical
> question. When reading the source, you see `#`, so you get a punctuation
> delimiter but no typographical one. In the rendered output, you'll see
> it in a typewriter font (assuming we fix the config issue), but we'd
> lose the visible punctuation. I could live with that.
> ...
> you might hope by asciidoc. Doing `" # "` does work, and is probably OK
> enough here.

Yucky, yucky, asciidoc.  I think these literal notation `#` would be
a good way forward, given the constraints.

Thanks.
