Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5497E257854
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784077121; cv=none; b=gPSk4XRt0f3v/tlVQO18j4FaXMARHREvUDzhecpTpS7V0TXwieRnffKKOcRhlIEucb8J4W8me1DviyN5DqNXjjyZRFD31iGpJonHWCb3nwY4AwzMfsmKIRQQxaMZRzxleeFobIsAYqMpjdA3jxbL5iQvTWfTZWzP07t5Rg5xs3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784077121; c=relaxed/simple;
	bh=SZRGgVivx+BJiukxl7WnwwyQJMhhz07I9t6a5h/Thoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jE2kB0Fc0zKw2t0IbU2dHBH5DcDdsCNgYRkfJFWiFZSvE0MHcgKa2fy0MeerRs5hPHyO051HysDHRTOup/Sng+X/Xm/xITuBwYwWSpp8phR/slYo3gNl13UzC/trrPmaKqnf9f3DGph/YE1giv+L0q98yYRbyt5trDSthvQKOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fVT76MMh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HdmUvAop; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fVT76MMh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HdmUvAop"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 327627A019A;
	Tue, 14 Jul 2026 20:58:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 14 Jul 2026 20:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784077115; x=1784163515; bh=UBo0XMzDhh
	HxZ8FYJ+YHkyy3mgGmlWD+pLKG/GeS71E=; b=fVT76MMhiO4aCJLVzFLspXhprc
	IMIriFFn2ODykI334iE43mNf32eI9tjBrNa4QM7bxLAVWgE+ILahK/u38lGkDMds
	TJ0agoImkcjcCcqnje8wOw6yvkKIx31Nh9hiAuCd5M+qxpBcVZdx+/eGPTNWdIDO
	F78LPRWjGnhXY2fCqWTC8Lv2wYSvRgi9GBafdtiWOjH0vBw2QRbvbvIm2dSsakFP
	CIlvegERXTSfTrTUeKUmnMR6vApu1+dPx3bWnaPAQhr+hZku+2UOi5MAOWZHetIr
	egKBCAQRwW8hYb3Dh8GCx5FQ+KVmUJvWWtZDO+NA4osvsCZyjedkJ/F8bh6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784077115; x=1784163515; bh=UBo0XMzDhhHxZ8FYJ+YHkyy3mgGmlWD+pLK
	G/GeS71E=; b=HdmUvAop/nHJXCUVDdhADcXzjtrsQFUElT2gTt1zIINWulg6OfC
	RR24buSIfXBVjUlK65hIzzHKjCvhCoVAASb+FFgVBnc18iN2r39HqEbXZPyrGvlH
	gr3tlfr66eT1Kv6fs5EUQ9SI5QZfQK6CZ1cstdSat9IaFnXqi2rIHPT/hojw7vsk
	rTKm14rbZ58vhxa8H/1OAlR96dbTSPyIP5fy1LUvpK4tX0omHKH4SYcSEsHLVfDF
	Gp3WqC7srsIpOpPsQvdU7RZkLYL6k/e4mr06k2a5B4munNqWlKx3+SLzH2H7qruc
	EieDkW7HHGPVV3jdyLq4MOzDUyPBd8rZIhg==
X-ME-Sender: <xms:OdtWaqVGfed-vVX3JcUc4-1KusJNvuC88QorBwLPXCVfxxpUqNPHqg>
    <xme:OdtWajI5t8tJyGdEHCiO-yRAnLlftqdq3GXCnFeIsqA-Pm62aY7DE3pmMIh0xI9Um
    Kx36uA8phfYVjmqvre_S_jk3rWgy1j9e7iz75sDMzSLJzXlEPJ5ow>
X-ME-Received: <xmr:OdtWai1_JOQ3m5loSmNHVm1KPUlMTpdlIrGvj6LK-tL4insw8xRr4Se3pQj3QpdNRq1Z1ha9-fqRN72wI4_EQQlbCwU1C2EzIlXZnGI>
X-ME-Proxy-Cause: dmFkZTGZ5s0JnBaJy2SK427Xfb2U6Knil5gtQYyk8rE8Nc5zlC5aTsvIUqdu5olwScppy8
    vLhBIhCcEzSSJeYjh16+fc9/yUiJli1B48iRgfsC3ua/CGbwOSDoxOWrwezr/BGu7idw2Y
    0WJnhNap/biJFBlmzUUdcaVYQY/icob0KPoz5jYTWVBKayWkS55DRPcCTT+8SOaKByK9cM
    EMjCOJCjH0AEYni6r0wOh4LjjO+P8f+yOnTar+VkwQ5IbNWyrXgmytqXB2FGlhJOlO9UuW
    mT42NAqMJVE2OkAoTXt1JE0rkuGC3STPvQhjpRSCc2bYkE+SONZn272UPX7cqqa+xbq4R6
    LuW2j+US28pHr+X8+aYeknqAwOklDPGbRKEpNsO9uTxqV88wUmoBwjoZCkyQgVmKLSWYao
    D75DjbSD0G6Tjf+x4Z+epodYpHdbZXC6RWuOQjMlQqsSpGzf/nzfR7FNSYW4ycayxQvp/+
    mn8hIauB5oyzgjeInvWDu37OUnDq+CX9F3o9jnpzwb6LCsWjv993ZI+rz3CZMjer2u4CWs
    4q8iQR3SW60FY6LluXUMzAmn3kAkHyEPC/NYeANdfMQjyOZnkY6ZFkw8a7D4pth43bfUTQ
    4ZJ6vim3r964pUQk6aU6U0M+TVNkTk3skYCHkDrXSDCw8915PG7RjSE7hTPA
X-ME-Proxy: <xmx:OdtWaoKVvWGHZmaK8c53IPFi1i1ow3wArCBS5JsztHNH3Sa8EKxDvw>
    <xmx:OdtWalhMAd4QMkXHP-2VKsA0zVQZxDeQ_0i0wJp8UCFCz1aS0Gn4zg>
    <xmx:OdtWagAJRzt9hfsP2ZRx97Qqcu0LsDlFqhgm1PX1WoXOsRuuwmpeFA>
    <xmx:OdtWav49Fe_yz01c6dG4qZxO9wgxWdv9niD3ZzJz38NuP0sBi5G0ZQ>
    <xmx:O9tWavfI_9FOkRdLZXw9wjWNHIKQbkno_9XA5xDYsubGj95baXu-QUy9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 20:58:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: <chandrapratap3519@gmail.com>,  <chriscool@tuxfamily.org>,
  <eric.peijian@gmail.com>,  <git@vger.kernel.org>,  <jltobler@gmail.com>,
  <karthik.188@gmail.com>,  <peff@peff.net>,  <toon@iotcl.com>
Subject: Re: [PATCH GSoC v17 00/13] cat-file: add remote-object-info to
 batch-command
In-Reply-To: <DJYNU7D4A7C8.3Q2Q4DX27RXC0@gmail.com> (Pablo Sabater's message
	of "Wed, 15 Jul 2026 00:50:51 +0200")
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
	<20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
	<xmqq8q7dto8d.fsf@gitster.g> <DJYNU7D4A7C8.3Q2Q4DX27RXC0@gmail.com>
Date: Tue, 14 Jul 2026 17:58:31 -0700
Message-ID: <xmqqpl0pqdag.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

> You gave me feedback for v17 10th commit:
>
> https://lore.kernel.org/git/xmqqik6htpv4.fsf@gitster.g/
>
> Should I send a v18 or a new patch on top of 'next'?
>
> The fix is simple and I already have it on my local, I just want to do
> whatever is better.

I had v16 merged (prematurely) to 'next' and then saw v17, so I
reverted the merge, which means 'next' no longer has your topic.

And v17, as a brand new iteration, is not in, and will stay out of,
'next' until we are happy with it.  If you have an updated v18,
please send it as a whole replacement.

Thanks.  How close are we to the finish line, by the way?

