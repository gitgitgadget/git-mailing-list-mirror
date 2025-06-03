Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BAA239561
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958694; cv=none; b=qYA4HhfcTxIW+ALzxA+r+tTSqFb4Q7UX4uOXU6ZskFC2y9YxWj8Hls9MoobtTDd33SXjKLn9ivO1U9dqLlORApdPxd6nv81wrfOtFHOkQsfUF4sl/Ejh3uIUfzs52V33tl0z5nza2yb8+p50FgWTTY85kzkt6vOUOjLWp10Xdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958694; c=relaxed/simple;
	bh=tilpxLoS/3eVgEm9f158oh9xumeg3NdteH6g+sIiJeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdj5tZq/DXrQtkm28a4IMMHSxzHPr8LmL4K+tZGdyG6CPHAVNhI5e9NPiAYbm7vJ2bt9/YNLAKft49KpF2BzsMAdDbWlpZhb+nozWGbzmh4oZqfUrf1SYskkk5Do9ZCqM8BOImzInph1YblM2WFuqc0ChqJGIocuhKEdcagHNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lIbh14wY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cfUO839l; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lIbh14wY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cfUO839l"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A67C225400EF;
	Tue,  3 Jun 2025 09:51:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 03 Jun 2025 09:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748958691; x=1749045091; bh=ccWNnSpIo7
	GoOi1jtChmINhWtEbhBr4xAOgmkPU7Pl0=; b=lIbh14wYOEUdLVjkmKwayN4jEZ
	9FncC+pykb2/mkRLHNrLhqDAEtfhQoLE854dhr3T1nsh8nuhAQZ5sBtBQNfDfIyR
	X+fsA6QuCOw30UEOJAHXnVGRJ+mxbAIVksNWTU7xlHoKFPnTSlNgcuB3+5Kui3fQ
	MeAEwFuXzfL0xqucUquu/syk99Eh64bGWaTxxKWHTklaJT83nA3aBJdIYNs3fGJy
	zNQuvv0zUV3oR5vJmVKGDumMbA0rhLqI4uy1EGlb7CIP29yUMgfzJs7AMmlX5Ufe
	tuczq9tRUMXM4ekFs2vmYOObyu6iCHo59y1zNEcgnnnC/t4elA0CQwYncZbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748958691; x=1749045091; bh=ccWNnSpIo7GoOi1jtChmINhWtEbhBr4xAOg
	mkPU7Pl0=; b=cfUO839lwnXFkq2+MLEQzUa6XvObGruo/IwZT+fHZlHDBFgUAGg
	X7PgKR+g369OIjpuJzhmUULqUc5cHxwXhrkbOtpH9O3D6C/B9PJTRK7suQ2GkFVo
	plH1X/0W2clItzO5Qxttt7EldjFY9qivKb7FjyMot7xcQJ70UCyqIKwbmWEVgzFE
	nUTRqMSXbU8RmJlqf24UXUq3C7SBjBiYgmQP+kRhxCeZaUeXbnuqWTmAszcLYkkR
	VgCDQRuZNbekM6Fb1Oa/Iwjcy40ocKfz9YIwwQB1zC4J4gZxD0Q5UphoG1Cs7udx
	TpJ7sMHxAZZpGFMh7NQy+CKw5AkvPTHOeCg==
X-ME-Sender: <xms:4_0-aOwMFJx--eC6Zyrp8Bw-RPc0iM3wxe7bWJ5vR9yx-Kk2gHUPFQ>
    <xme:4_0-aKSkq1HQeoCTpN1ZBxmvzgP062z5FgoO_z9MhNgQc8zZqyQcKkGwPVn_-fDRp
    Ek5mZvRsQvSrplknA>
X-ME-Received: <xmr:4_0-aAXKkPKwPE6_EquDQQG-XFhOX3p29Tj0s7vlxoVpvKoeF1bDun9MbS2tN2Z0Lmrt8m1OlhwsvL_RgXfTRC1wZXYr5Xd9J-T-u4FhXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4_0-aEjupTQOTCDRHflTFWVfVUG681wBVniYfIxEnDzafnE9DRu0MQ>
    <xmx:4_0-aADpXtVjXvsb8B_OZqx4yvR2PAcwolyN35__6U_6Vb0KMLmexA>
    <xmx:4_0-aFLRpWvRNa2HD2vJF7ikssqUmzDTWxlpCJDHQ48IIhvsMl_M1A>
    <xmx:4_0-aHBd31WqA08uNew8KuwRLQC2A4XTcndqMLO-POGsb0T5PT405w>
    <xmx:4_0-aO4nJ0L5rAxt-dzWyhvwJV0kCQTLDYzG5afNFpBhHe1XKHnuiXZ0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 09:51:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a3086cd9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 13:51:29 +0000 (UTC)
Date: Tue, 3 Jun 2025 15:51:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 02/10] t/unit-tests: convert reftable basics test to
 use clar test framework
Message-ID: <aD794N8AjBqw0N43@pks.im>
References: <20250602122559.208780-1-kuforiji98@gmail.com>
 <20250602122559.208780-3-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602122559.208780-3-kuforiji98@gmail.com>

On Mon, Jun 02, 2025 at 01:25:50PM +0100, Seyi Kuforiji wrote:
> Adapt reftable basics test file to clar by using clar assertions
> where necessary.Break up test edge case to improve modularity and

Nit: missing space.

> clarity.
> 
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  Makefile                         |   2 +-
>  t/meson.build                    |   2 +-
>  t/unit-tests/t-reftable-basics.c | 219 -----------------------------
>  t/unit-tests/u-reftable-basics.c | 227 +++++++++++++++++++++++++++++++
>  4 files changed, 229 insertions(+), 221 deletions(-)
>  delete mode 100644 t/unit-tests/t-reftable-basics.c
>  create mode 100644 t/unit-tests/u-reftable-basics.c

Hm, these still show as deletion and addition :/ Did you try playing
around with the creation factor? What is the exact command that you have
used to generate these mails?

Patrick
