Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D379285CA4
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785637099; cv=none; b=PjtvjEdDHcaQnzPvxFj8y0tNiIAXIsDVILFEt55lJixD5TZQrQkXEmYZSDPhKaQEn9pTi+g52EHz6oZfVvswg1OcG1cuS0h32DjdKGKLIarpKc26J0cM11h6cXS3Nt9YkuG8ChkRhRU0holTxVXdwl7Yq2KG3GrejWj00NvwUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785637099; c=relaxed/simple;
	bh=hQfRJVg7c0HHoo43O3c6C19pAD2x1s3uuMREj7ddlb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C0eygnKq2/cENM8+MYqaGNBbQaC72z2FyjQF/bbxgo9Lqnl8MOy3HHNH/RaBGE56u+b1WWxZAKawg4yj5IxWZLm9YWWroHRA1q/cIPxc1+Uo5BTP17uy77j7tJkgyRafy/Da5DUHGymtJ+2mTF0+hKpB9HT94SY4x8zzmNNFMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ThwPd1Uf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DZ79WG+T; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ThwPd1Uf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DZ79WG+T"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F60AEC00D7;
	Sat,  1 Aug 2026 22:18:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 01 Aug 2026 22:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785637097; x=1785723497; bh=k9c8/8gjpZ
	g4xyb17tkU+AJg+qmitPlh9s+a7uxbRpc=; b=ThwPd1UfCeAuPGXFiTvyhdrTS8
	lavdLrMB5DSp4UadSj+cKe9+t09c8q+GHn2KoumO4/ZMVeehxcVhv11oLB9jsPT3
	MPPCFVXkaJXpfJdx8VeYM4Bh4nGcx8kV0K/ISV2axe/32UP+a/crKiWCce0Juh3l
	8Iyo3vDrbLGJkPaatiQbrEoy06r2DUwh848SrxSro7BJTFcTNwxaWPckiw4zFno9
	CxnZL4imE3zechyAaGBRlmI/lo4LMZfCwlverfjJYS/uS+yXMnjZXrJ28b3fDRe/
	eJ+dHfCPeBzVOCP2+i5pWEdIoc61BfoPluQEl4JDZqWdlraacfDrZXzJDJig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785637097; x=1785723497; bh=k9c8/8gjpZg4xyb17tkU+AJg+qmitPlh9s+
	a7uxbRpc=; b=DZ79WG+T5uXjYlQ6ecJTdG42qyMLeV7RsGLWem1gLnwrA4C9j3g
	TbemKfSGqctpnsu6im6wteOSjPDC8nwxeDnBCKNknERJ804eif1ntzBG89oXIx/t
	OLn25hUR1w5WqtCgv8/LgnhHfU+KA2dE4vkWaXVSMjQl++Ebd1MiCLZYUDWMDYPC
	UUrolg8J1yG0fH8M030A5INKtQkVA/pnWeeNn5BHJbXSCF//kFTuS0J12zTsnrdY
	Cpu5vl9xvd+Pd+UD8IO8Pt/kNK9lIKO0Fg6v4s6DtgdY3IdDxBJS49WTiYMkKT6+
	QNhbyjhIpOIAVJmaMb/88RPu4iyIYQHjvaQ==
X-ME-Sender: <xms:6KhuajS75FsdiPr85RpHUYyP6eFde5G3Sy64tZCCJvXoEOBAG_M8Yw>
    <xme:6KhuagemKsBqfikaSI1SxC44KY-LGPxQKaVuodWGFi-EnWj95mi1N5Nnmikyvwhy3
    Tt2Nx5DSnC3bSATVVt3_XQ2XIyl0KpH-jqvI3tyqs99j-Itp7bH>
X-ME-Received: <xmr:6KhualT8O3T-sppg-Uo4oOafwCVxFhfhIn6XyL_rAFRILRYfpBixsppLvql2nc7BO71SXuNh60PVwVVlRrfJ-j81hk6Xdg0yyw>
X-ME-Proxy-Cause: dmFkZTFbI0iI8O/SagROvyIpKWuhpyja5YxvXv/OsRl3HRpxf6DHRFpSBPvWgN/0LMq0iK
    N8TxvgZZTHqGhJONnJEY2KosXUAxiHondtgBjZ5hDKnO6fyCVGKuQ2lnl78D7xrD3QDHXy
    cZ+CPgL4tw7x9MiQqm6magp1wbW2khUqGtpvSBZVP8hreHWMGsv6uw/Ve9A35/DmmqVdi7
    fn3RmxWnQMa1b93MA0YzS2eaX0lGk5GmI1Zg+BCuKxj+aoyckkD5FVti8Omok8SjAYK02A
    8eCZPsBuna2q9IOWCHnzXlIUpSG8glmYp5LMiva9858ZD6/NxAzl7dAceHEBvRZ5WzzJj1
    htXtXQzjH+z4e9S9tJf36wrx0PUH0VAeB67i0lqsVzmMEa6EhPCzQmIB3QZ4Dx93uF0Fpz
    s73gujIH9kqbBctNKqkZ1GHw7DK2rrj89c0w2xdVX8/k3sGANHN+1HmrFFdTEisFA1XONv
    Bn75oU3j8/0xj8J91SQ+5f6TsgY8FdgYWYXVSt+S/Op2oRpytw3z/IolJKOZP/ReGwB+e7
    LDm2t40DY0lIlP5SYbhLGlgAE4c4mRI1Oe1qXXFmpGUyUrf5W/0nqlcquqRIDjfY9F4rVb
    RyVLb69WhenSvGB+ZvkJSBM2HgyqlFyZWk6Ql8n3mtqyki8kjfYqnfUZHHIg
X-ME-Proxy: <xmx:6KhuasK_yzPVqW57R1tzuXfgxNaM2wHsiOHhzWyf54cwdW05BluZIw>
    <xmx:6KhuaiJp4_d1sg0LvLhyM4bw-oJL0dXOl3hLzdw-UkN95M6UUb8dwg>
    <xmx:6Khuani4YNcfrjxJGvdC85QwPmyvzqtlubdHtL2rv18aN0VzYP9_uQ>
    <xmx:6KhuasNr_HqQrsctVxxqhva159TBcf2yF4nMBRznfHzCUw1MU6U43w>
    <xmx:6ahualJ0DnnmJTYLBBiWzlS5rMe_Zt_cIiSXnE-NiSX7NGbJk1T9K1pa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 22:18:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: christian.couder@gmail.com,  siddharthasthana31@gmail.com,
  git@vger.kernel.org,  me@ttaylorr.com,  ps@pks.im,
  johannes.schindelin@gmx.de,  l.s.r@web.de,  ttaylorr@openai.com
Subject: Re: [GSoC PATCH v2 0/7] repack: add --drop-filtered to reclaim
 space in partial clones
In-Reply-To: <CAGWgyh8EPSufBZrk0xCqTr4gz6MtJHkfCy6JQKxCqKSPZ3gEgw@mail.gmail.com>
	(Siddharth Shrimali's message of "Sat, 1 Aug 2026 23:49:11 +0530")
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
	<20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
	<xmqqcxw3dvh5.fsf@gitster.g>
	<CAGWgyh8EPSufBZrk0xCqTr4gz6MtJHkfCy6JQKxCqKSPZ3gEgw@mail.gmail.com>
Date: Sat, 01 Aug 2026 19:18:14 -0700
Message-ID: <xmqqa4r55kpl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> So they are a convenience to avoid pointless re-fetching, not a
> correctness measure.
> I am happy to drop them or keep them clearly documented as just that,
> whichever the list prefers.

Doesn't it suggest that the "cull anything refetchable" feature can
gain a bit more smart?  Given an object you know you fetched from a
promisor remote, are there cheap ways to determine how long you had
it in your repository?  "This large blob can be refetched if we
wanted to, but we downloaded it just 20 minutes ago, so let's not
cull it just yet", or something like that, perhaps?
