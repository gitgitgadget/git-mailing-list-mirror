Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292643B19A3
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773214338; cv=none; b=l8VrrJ10oVhnX8v/U7cRnm1RGfmBB/5DxeaWM3Dbe0UcyZXHielf2e/N76jXTORUhSvpbgA3OcCWJ3aJ8YIMrgpBdiEiOgMUojpd3d68mhOU3bw/zjw4PZRx0Z0OAQzcx9lCscE1pehnHlJpeifaKNvZN6YLyE6lUQym8jjlnm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773214338; c=relaxed/simple;
	bh=X2t4gNU/vsimUyQRlfQD+zpfKsZNVYaLXBGOWNXXzUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAcoBKrhBupG2qetvK2brFwZmW0+TT6n27Z8P4iGdSDXnrvgPeRrTNmAZNH3DMOoYrwSxL+Bh45V/59y99DP5iDPtyWUJpME2zX5sbl5ysFKCkNRmUbqMhpuoDH8rog/D6EMWvLM1P7ij7vFQyQoGePTNyHrqECC/OqBHLb1WXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O79g2n7M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eoDr/Z75; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O79g2n7M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eoDr/Z75"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CA447A0053;
	Wed, 11 Mar 2026 03:32:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 11 Mar 2026 03:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773214333; x=1773300733; bh=/LRIieiCCZ
	hu20V6vYtauDABvKT7FOJ9DLrp7sHzoog=; b=O79g2n7MbaH2iklVBI4xfY7yWf
	JML+AwlH2ykMZOgfkGDfiQnGkPPb18HiNLyKC9w39xI+IC9o6bDKAQzJI447mVRo
	GzPYWx7fx2J9wAYG1382ZF6vp5mc9yRUprnIBJhEC06CqXCE0gOQPZI+4KBngzud
	gVm709UZJX++4mOQPU8zA4zwOCh7v8V/yf5pAFKIeMBN6FLpQu8yHmjNFsgMad/d
	HwHH/8HqUgZrbpb+h6D2+BnzYsrQULhdJpDWnE5/JE44h464LJDgb5ogYv3Jiuv7
	FnJV7iCpjcqSgOaU161/tS+6+f+ouztyZUo2hmIzpFnThevuPGiZ163YYJnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773214333; x=1773300733; bh=/LRIieiCCZhu20V6vYtauDABvKT7FOJ9DLr
	p7sHzoog=; b=eoDr/Z75qfkulquEsGdiVNG5roIxddQlXQfFtjyzOPD3il6jFN5
	QE36845Wca6VpsC1CXS2PCTaQegYj8k2oylCZ6neMtKBjI1GctYHt9NIAS6FGzeI
	1yFv+GTK8fxpNPp3R1ucb3936UUqSP/74XxMG30XlguLUlm8y74jboySf/SGvhK7
	gu9xRnZoWMa5V0ZDBa4nhwzvUoEg8DnDmHCMqY3tfw8GTeOaSY8oZnZmqZB/LXtc
	In3ZphiQdSlWj5G7i7nW/SplvmDn1XjAGnG4u5aS4uKfH0iomSU/IF3nAmPLeLCw
	qe9WnZaKR+fav6vuVgejEosAEsg6rvRRFAQ==
X-ME-Sender: <xms:fRqxae-ADQo1Wa8wTR_La_AueM5IJNoP40hMc83uZRcJ3DJKKQ963w>
    <xme:fRqxaUs_fmCXfspbHEtdVm9c5Gfkbck3e62Ahp5rjezvXbB5zcPewlhAF6z4mZitw
    md16cb8WQy6D9wJGcbxilEN5ffVBfu5iD7JOZum4kxBUh4Clho2Pw>
X-ME-Received: <xmr:fRqxaRpLCxqNIb7iEnzxPVwjBRPq4QwDAJPwN8y8Amwbnwg0E3VEMCTZYYrTWmNYqh2qImEglzBoxmS0kNsRbXiTwaLsZnvK5i4VL-OyHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeffedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fRqxaRmfGiyib3yHDVHMPYIrSpus02OI-jaqb8QbTvctJQsX2hbVkg>
    <xmx:fRqxaVyxGPVOuVeD1qsWIu5RLQgQZ5ROOkIRb3MU_D8j2MFwMw_z4Q>
    <xmx:fRqxaZkXRHGr9VdlDHA4HlmVayPfChy_igajOaHE6WtUJ7An8xh2zw>
    <xmx:fRqxaec00rFh6Vpsa2gVZE2KTjLy7Tzmow_FrPJAxtM5OgHID2Njmg>
    <xmx:fRqxaaWyeLhBIjlwKGoRidxzM9E09gONZMDK5uwc9Dt-_tca5N1eR_Un>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 03:32:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d876853 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 07:32:10 +0000 (UTC)
Date: Wed, 11 Mar 2026 08:32:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/8] Some build system improvements
Message-ID: <abEaeC1kRsGyQYWy@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <xmqqwlzjtufv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwlzjtufv.fsf@gitster.g>

On Tue, Mar 10, 2026 at 11:23:32AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Patrick Steinhardt (8):
> >       Introduce new "tools/" directory
> >       contrib: move "coccinelle/" directory into "tools/"
> 
> Even though "make coccicheck" may not care where the coccinelle
> stuff lives, if this step changes the location of the resulting
> coccinelle-generated patch in the tree, it will have fallouts to
> developer workflows.  The blast radius may be limited, as those
> other than Git developers will be hurt, though.
> 
> I mention this to forewarn others early, but I do not have a strong
> objection against this step; at least not yet, even though I may
> change my mind if the fallout turns out to be greater than I
> anticipated.

Yup, that's completely fair. Thanks!

Patrick
