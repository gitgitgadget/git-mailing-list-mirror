Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F92D0602
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787314973; cv=none; b=k7FZ1bqflefEK9hM6qj/MkuCreo9gfnCShpoDutjHdtn836IPHehSxLOmGOFZmOfP3z8I1FRTVq+OxBMSoLGQWEaFX+xlKaeG4o9zNdn+Vjs0h8623Z0mQqCfHFY+0Umj0hvPkBHA73LZKt5BrQxaDNuKv0i5LutlmBkYIIFd2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787314973; c=relaxed/simple;
	bh=kuKjiOqNzhru+98WQonxZeak+G3qEYYtESFj/zBrmW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DweWy7/vsiY8kF1LluqZy1I6A2XvNE5demvec7zXOGQ6aLKnODhSLK5ITIBltPOFzW11Pey4833vqJ1ONcMFAkr//UUIaGGLHcgPXAB8kvbuG7wTrXtc+OCPFyJaggMbbMm9jRLG1EX+BaHp4Stl6UHL08Mx6HKjXc9Noldb4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cc4n3rk9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CS8MSnov; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cc4n3rk9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CS8MSnov"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A40E1D00060;
	Fri, 21 Aug 2026 08:22:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 21 Aug 2026 08:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787314969;
	 x=1787401369; bh=y/XqOv3T758fg6INLeKvEWXx5oeefAK+95fmhuBN/2k=; b=
	cc4n3rk9S4xbKk+kCeexRSdxl/3nw1MDTOg7hRh61CL/eZsIQIMPng757oA17fZo
	uoT48YX0SJ/XsQnDr9Fqgf3X/2O8XvppsXyVtKCxn69hkZp2qCENKzhJ6ZDN5Bao
	Wyt3/Wo1Y7wch78NRQpzA3nRNP0YNbEgQOpRi4681MOnF5RPckFaQzRAmgPO9Mf7
	KjGlslsmpl3pV06CjKznGqTmUHje6fi3L1o5+nTjsfahDMCocWjwyj74CSH7GrUV
	nkuqXGRzj9kPf3w+d+E2n2Z3E4q6FC8PRg9mtgrmSmjGi5PQcsKbJSaj1Ychd6pX
	DarZ3yZTLta9LVSGKwqlfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787314969; x=
	1787401369; bh=y/XqOv3T758fg6INLeKvEWXx5oeefAK+95fmhuBN/2k=; b=C
	S8MSnovVwFE8aKbgS7OBLUUGpIzVrCzb5pDq1fHsTA9HQMmrWRkUDNFXx03bHanN
	mFq+xG9PkO/JFfQCqUi9c44JUY/Ilsh8NU6I/j5p8BLRthIKe5EwwNbojKO+NwYn
	5dhLmZiOeUryVHmQWBJefKaBSYR8kyppGkxyvjg6NXNn9s8fpuT+LCVYE1ySukoR
	F9m/K2j50iqfCROqMSRcFRXtSRcIbV1yp1byJ7k4mldf7paVleSOvbIYXagxE9sh
	XFeaxKVPMZ/rO/9D8uDDIuaD2q+clBjKzXSxiMXYayEUNyVRD2KfXZ1V2tDCOq9j
	6rUhTwWImscg9mOKspujQ==
X-ME-Sender: <xms:GUOIagVPRvzIETrHxU0ZIDwRk8F8KJbC5yQmbp8n4scbylb652fcpg>
    <xme:GUOIarnjuCbxehUzuqEF30tMDq8yvlhBoSpdTwMamp3g1hfj2is9cabeMzqjdNc5c
    cn8O9cKkXtI2NaoTqItQA2zZD0lqS38-7SSsax7a6XZ8-REUM_rfJI>
X-ME-Received: <xmr:GUOIapY5x2MIZ4jDl1k-5fXl6B1KD3dqRBftrXPBJ6GNGYc5HuO20yuW_mFxwVbejRfNiHX9B1KQsg01HM2w-R7rXJTd_sWqp5CoJgmc_Oh8>
X-ME-Proxy-Cause: dmFkZTEh+/KWuPSzkDFJfI9xuyKHVNhV4zK9zst534cggmM/T+DNe14Bbnf5WYBLFCm9PE
    Jnnk/eHamCo4CwDvOoj0LTMyLzFkCKIKHtuk5fPBGrfym6PLqESXX1X5b7ZBD6wz71bYjY
    VXdt2oPwsMb50af19Ba1JYCPHiLkK9bKfYLlsb2nlwKWsbPDQlgehlDakpblCvxBrWDpNu
    iz9JnKszmCOrVjVB6Px48ZaGtZdFHB7h5ekHnvjJyp39DE5EsX6Gfcd9qZCDCzZk+62Z5i
    47+2w0qaw0ZYzJwUpEX4TpQZ8fXU8xBe4SxaIf0Of/pcmMlTSj8rfVLQs2+OpLmfwZzmBA
    9azw73k4gSead2+YPkIRq3chB9Z6kY4kPZPonQeGwvwZA67qWPyc6NaF5b45L5ddMHET05
    6Ej3NYfzcxd0GQ0ta3rDl33X+wU+HJ3kPrB5aTghjCZk4D2v4Gh17hXZCnhsXDH6vTvLEI
    mgHmxNKitUtXTzSlvbAg6yKu+TUG0OvauIU3v3jnpaRw8ymUxuhrH+QXG7fevmbdeUhVqD
    iZyCaqmqtuSJP50HBP62MxGp1JZX/yhGVwNqAK0UFBQuFUtnG9m3SjOhTyxlvq00ufoMDA
    v4Lo1NgCeY4aEkJtc7C/1AskZOyNsWwzhpfVcGlB4JgaEdqQ1Psd753FegxA
X-ME-Proxy: <xmx:GUOIauNW-Hw59frhllgSTDPXOZOWTV8zjyeXY31TQ1ByDDVT3zavMg>
    <xmx:GUOIamYmUvT_Oq9YCBIIouoFkHClL1KKnrMSlyowj8GYB6Ri60JxNw>
    <xmx:GUOIak1LGP49BTZ3GIg434nY3X3ulKOMdlIQQBEns8-UHhmNyIf5Xg>
    <xmx:GUOIakdR5ry7o02G-syRaCHpmdwjsVeoG3WzLMenIRa_Ekk9gm6LBg>
    <xmx:GUOIagAxnyFEJHyeUuQoKmUmUSEx0CDTgO4BKgEZ6uN_0EvK7Ui9dFhg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 08:22:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f90cfee5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 12:22:47 +0000 (UTC)
Date: Fri, 21 Aug 2026 14:22:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 2/4] doc: git: link to the gitdatamodel(7) tutorial
Message-ID: <aohDFdjPU0t2d9_8@pks.im>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz>
 <git_to_datam.bec@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <git_to_datam.bec@msgid.xyz>

On Thu, Aug 20, 2026 at 08:55:22PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> The previous commit added the first mention of gitdatamodel(1) on

It's gitdatamodel(7), not (1).

> another page, namely in git(1). But there are also other places where
> a mention is relevant.
> 
> Let’s mention it:
> 
> • under Description, since it as useful as the other tutorials already

Missing an "is"? -> "since it is as useful as the other"

Patrick
