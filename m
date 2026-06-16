Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037F394EA6
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648488; cv=none; b=GhZz8qaZjYhL86ahoXYOtGKgRaekyCmg4cEhI/vDBoHz1y7ncS1HE+CDVVo83AuWHagXmCCmlm0pchueJp+YbOT4xFogJp4sgZpx9Tqhk5e98+y0aJPGdxthzgD6Ok2pQP01KmXEjEf4442RJfDnE8+OVxtezJWuEvgqSS0eYSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648488; c=relaxed/simple;
	bh=zXgGU78/vvuJZswqjQmTT06mhNQuPpH/rzi74pN4aMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gdBmT4EUsd5CBrXHKdSL0rM67SBfv3bPyiejlN2QEzaDkITr6xy4Qn31RHlLnYMWDMzKlMJy/WORjIAvxH+fXIBb5LSOk9sXAhNQZ807ahFrFVL5rk/HgzaDfItUJZMn+hOdbjv5WXBSxd/EfWvYt6GRa5t6TJseY9tfhVOtEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I6seu8sA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gch7hoV1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I6seu8sA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gch7hoV1"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5D5A1400014;
	Tue, 16 Jun 2026 18:21:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 16 Jun 2026 18:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781648486;
	 x=1781734886; bh=kPSDNmzSDTDtpoonRRkcA7kVpJupsTlHSU2b+uYaFjw=; b=
	I6seu8sAYzHovTy/rRMGfJDBukn0T5T2wrQW+pI9s9safLFyCX/mfvIHMeGzLgL0
	vbPK63M3rlpxJLZYSkNo7AVIMy1+KpJ00vX3E/o/C5QLPJdgyhcZfzrCyDnh7HFh
	qdBHol6ANnUkODpRhdabz/O+6cPShtZd97vhk2MYWOPLiiNmPQPyWUXkHMPIGfDv
	6fhANhbk3z6SOlk/36kE87xvUNPCx1MUyeYWmyuANpb4A+EPFqafez3tYrKZoQh9
	qphAfWLkio7NYabU2WLf4Zp8+HOW6Fmw9jS429wEB+V3ockBtVqJrc+swTa8pxPK
	Ok+aWRQzAle32n0V7wIddg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781648486; x=
	1781734886; bh=kPSDNmzSDTDtpoonRRkcA7kVpJupsTlHSU2b+uYaFjw=; b=g
	ch7hoV1Wue4E404rbwEM2c2z9Ge1NpS7gja10HphkWmu3xKoEd7dIfa0r5lWvhO7
	/C+9E7pyWN52lyFWcAdbcLUGR2rm19wlopyMaLyAuHrLVKzVIJWDUyhN3QJ4guyR
	ocNTV6CJC0sbo4CRNeCrHnVJYNBJymMYEDJ2hAFPv5wDtMDFOw/NFwbbdR05IpE+
	DMR3m55cUMx2LOxVisnByDuO0jz80ea/myEfz98ORs5NATfUQPdWVV7ys9SH9sjL
	GO4zVVbUscAMr8CoGQAMskl96fgNP3o2fUDnnZq0EwbbxGVPJe+muTWd2ocXxBlL
	NM+/1E8pwubx75AK3QjAQ==
X-ME-Sender: <xms:ZswxaiFwQn_VePrqISO9t9Byu-1Xl2lZKFRL3MbDKGFHAvuHk-pTkA>
    <xme:ZswxaqUkoj9RIi71-p3H4ZRBtHQ3KtGOJ_YF-1ktm_mUmAE9zr4hFtW771lkDE-K_
    XKI2YRzify1enluWoNhzlmEQQGkWHvRLhiLAMpM5i8ysuOEi56M>
X-ME-Received: <xmr:ZswxahLm-xCRyK5-TcymWd91vkka8F6P1WCJy0iOw4TivAxqXC2R0ycpWigKwRXvEfz5p3647ZUx9GwFDOXSUwRPgkhDhWLMYYc0>
X-ME-Proxy-Cause: dmFkZTFtHWZXVqz23E236Jcxt9vwigVfSYKc3cpQUK1/AmIUXUdj7hV3QXXN1cKf+4rqQ+
    F+5i0glW7f145G/wR3UzpoBvUkfKX1eiTLoWcqey5LXbFnqeUHHOjN/o2SAXkk2krh03dq
    ZZJyYUZySwUYk9mzMsubl/9FLGnADzCfExZRIpobjor6hQ4xC/NIqO4VO2E52ReoYTVSqy
    vilYTNpvHzxfEgnvxLz9NJhR5kFDS8mPg5lIdODDub2aPMNmLOeD1dqSVHPGZwdeo793yg
    ZF2Uyae3esa4/j1LzUCBlQjdc8zPBu9o04qdazQd7POFZLUQINWpYCPcQDYXU4BA2XwFdo
    vEWVIWj8zo9N24BceAgVBr1AXMSFYfuacoDhNuVTREFfO5e9Q/gQCi1p2DLszckJQzaZQc
    ygPPpSEpbdjAPUFvPPl4KkHEQSmSNHLOi6Yn9WsZc/yDvcW/uy7aMEd1FqfUkyoZk7s7E8
    JXKTuRkP3u1R1R54TpY+TnxpuXg4fQmzxjvcKFQjv8DxlEwqXP06sX3viXbhtOQckuS1eI
    cpIFaDft22+frV8t/l+GBUGG7PpMJG/TiuAWVkvecN9PJRfxdEMfQCWAi0VBlw/zieuXb6
    05EKBEHFbvXIIb4dTOmuawxE6LAZkmsUtLdMB9E8R2su0XiMKTXmXgiUE11A
X-ME-Proxy: <xmx:Zswxaq8vrRll8zGF-lfL1IKhAKJ3dbyOPTp2_qFntFaDd_I5xSP5iw>
    <xmx:ZswxakK9Key3l689zqlBxQ_z9B3rvizVj1X_713o4Zz7bcMAfXFHWg>
    <xmx:ZswxavkuPRHLLOj0gAVg7mVyiobelVENbAD4JwInBPZLpJwoX0aQDQ>
    <xmx:ZswxaoPJtxJvl6Wvxe3RTPRUe4Bjt-Uw5ONrvAwPD73LRsYehZp2dQ>
    <xmx:Zswxaie-pyyDby1VQp2xeYbl7rx8d4dlCpGBpGylkUeliEvEsPFuZUCx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 18:21:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Jeff King <peff@peff.net>,  Git List <git@vger.kernel.org>
Subject: Re: [PATCH] cat-file: speed up default format
In-Reply-To: <47e3cf16-217e-45d4-91e2-5a1abb4ee49e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 17 Jun 2026 00:14:37 +0200")
References: <5a7ed929-6fe0-496c-83bd-65dee57c2241@web.de>
	<20260615165326.GA91269@coredump.intra.peff.net>
	<20260615170652.GB91269@coredump.intra.peff.net>
	<10a33614-837f-4166-aa30-6de28b052692@web.de>
	<20260616111237.GA687438@coredump.intra.peff.net>
	<47e3cf16-217e-45d4-91e2-5a1abb4ee49e@web.de>
Date: Tue, 16 Jun 2026 15:21:24 -0700
Message-ID: <xmqqo6ha15zv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 6/16/26 1:12 PM, Jeff King wrote:
>> On Mon, Jun 15, 2026 at 11:53:07PM +0200, René Scharfe wrote:
>> 
>>> We can also store literal characters in there.  An opcode plus with a
>>> payload char incurs an overhead of 50%, which sounds high, but at least
>>> the default format only has two of them and it's much better than
>>> storing pointer plus size for an overhead of more than 90% in case of a
>>> single char.
>> 
>> True, and it's a size win if the literal portions tend to be small
>> (fewer than 15 bytes). You do lose out on the ability to strbuf_add()
>> them in one go, though. So lots more strbuf_grow() checks, etc. If you
>> really wanted to get fancy, you could follow the opcode with a length
>> represented as a variable-sized integer, followed by the literal bytes.
>
> Or an opcode that shovels a fixed-size string.  Depends on how much
> literal text people include in their formats.
>
>> I'm not sure that Git's formatting code needs to squeeze out quite that
>> much performance, though.
>
> Good point.  Near-native performance would be necessary to make peephole
> optimizations like the special handling of the default format
> unnecessary, which I understand exists to speed up Gitaly [1], but I
> guess most users don't have such high demands.  And there's no point in
> removing a few lines of duplicate code if the necessary machinery adds a
> lot of complexity.  Though the code discussed so far was not too crazy
> IMHO.
>
> [1] https://gitlab.com/gitlab-org/gitaly/-/blob/master/internal/git/gitpipe/catfile_info.go
>
>> OK, so we managed another 1%. But I'm skeptical that this linear opcode
>> technique is where we want to go in the long run, if we're ever going to
>> unify formatters.
>
> Agreed.
>
> René

Obviously I agree with the conclusion, but it was fun to watch cute
experiments from the sidelines.  Thanks for entertainment ;-)
