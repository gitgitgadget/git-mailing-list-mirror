Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5188A199949
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782072976; cv=none; b=OfvfKPE4hrH4hNUJRw8FH2RspY0WuaHIYSKnI3ODcm0rZLHnwlTv80ccM6/SEE36vqnKML7yWHD4QTs0c8FG6s0qJkxD0L66bUM9pchdWT4nArGA/f65pP/Vb0ZZxKjx7jHZRZaVTT2haQ/SAaVzFM8JWNxDFk40ebyQxBZZWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782072976; c=relaxed/simple;
	bh=E23eANnPXa6wOg2KGXSau5oY1/eFjVU5td4M2kUgmqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BqIO0ewnCQ0mZAw+wwCva+rqppp9EByKbN9iVlGZVWJCrP2TBlSnJTaEOk+m28G89csfME8l7VNmBWmoZUqDP8XbiVUKk5zo16j/uMuACm9jPqcnMQmbXVwVbSaJNfbYkACc5i5los0xBvYUqi4Pv+8Xjx5comAOWdWRp8yXUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nBN6goXS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HT/9QT4s; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nBN6goXS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HT/9QT4s"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7FEE014001E1;
	Sun, 21 Jun 2026 16:16:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 21 Jun 2026 16:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782072974; x=1782159374; bh=E23eANnPXa
	6wOg2KGXSau5oY1/eFjVU5td4M2kUgmqM=; b=nBN6goXSHSzlveJ+D0M3Dilz5H
	UY55yX2MwOQdyHOKQTh6ygNxipTUVqp1PzYBKm2Nz1i/dImorj95GX3BAyTDKBpW
	qs21HOLaI8IAOo/2VZXIL3XuL/zzUg+8LM9siC6vgBQLEXnWfJ0jDttAL1/Mmt0L
	jG7QcuRX3+FbA7gbFEW/AmSSddqoLCrx94XzQ/dXjCa6J+Pb/QiAd27tXhSVYFpU
	i+RXB3mv2lwuZLPkH6j468yntWu2GscJ0i0wPMjbyipuYxaYFISPIW6gLeGt3Xrw
	VCOM2r6763O05ues/eU9IWbuyLNz04VvRSrfUxB/p8Ltmur0+Tn96vFGP7ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782072974; x=1782159374; bh=E23eANnPXa6wOg2KGXSau5oY1/eFjVU5td4
	M2kUgmqM=; b=HT/9QT4sczvwCJ5fDNFnlkxvtwF3C0uOwDcXWq8+lz5QDNijnRq
	xzSI9E2UsrQxpkwj/L7Vx4YaIeLlxs3MoX+9+CkFO+kdJ7YTC4M/ds9qguyvevsy
	rS70QBkRXt4c5aJQ2uK4Qy1Rd2pa5jFXIbHpXfqNynPuiB0NEGYnTkKsHiF86vz9
	wvzh+p4tetTT2Q3Q88IcptnJwhzlh5YAYjM5+eC+XJLDLw0A+sh8qQzY1Vx4iKu4
	zmKXjV50htJ14aJl1wEzBksk4/lpE1EUXXSUgp0B350ssCHafcftH26ej9RVz++M
	G3ukVTLbfKLQfjY9b1VPhyM+3RoRB9QV/mw==
X-ME-Sender: <xms:jkY4ahBfQkohRQ2Ka_hnYC8A8umk74Ze0LB6AtPOzEFZN-mJxdFGgg>
    <xme:jkY4ahzeOMGVzVw3bPUQPelyPUXYd1E-XaVBwyomgirxjLOBS8E_DHk9aBAsbxmhz
    u1qe2tJ3uR_psbF6oPb2MbmS7ZxxNH0mqAShmdgsfZDizmn-kPIr9s>
X-ME-Received: <xmr:jkY4au2V11FigC87pcIY016FhaWSXB_eN7ETnxw1xWnUSwX-XRnWqkxibjgTmiU6z2aINGgXCW2eDwwXdHXAMOGEnhFmH1x7pD1rFAA>
X-ME-Proxy-Cause: dmFkZTFgbL52wwHzogDR4KkXJsN/gA9FWoyzeFOUkvlsrVHwwNr/aSR7JTlEYrkMNDMZIo
    Vr6kb8aojzarX3gW5FVCUysbimk0rl3FkfMadPMEJVYX/9QmQiruzx8V5bzcRGKfTl8Sew
    93RgbR8U8ayfS0O18xy0nTnFuHN3jdxBm63/JoSux/0whQaxRbM4oVQgdNLK+cpwwcG406
    m/HO/RFsUoazd9H4mBLndFWIu1XgeYvNkWc0u6G2opHiG5OvAW19DHB0Q5l35UNiyb6BJ5
    +EVVU3fNDKus/fgHLMVLqJFH/kR+eXCh1Kb6EoAzhRKusqlRzGfzBl61B/MlJVuGw7n6VZ
    X8Kowf/fN85CNguOizH3haDd2B6uFKCkHPLASQwvAhWdB08to95FB3Hh2X3NK9nd9ntobp
    U0j0oYUDsJ9C5Ebe0DfZwphSx9dQXJr6d4LOcLLAges1Lcthd68y8tOM7UWHmSoh6uhLF7
    9ifgKMTWG2ZQSAj6o/gHYQVeR2C+hhixIeoTjbnLG6y17UpHC7WmjH2+rQoqTWi6OA+JHo
    vDY/Oun/pKWNhqtreW559UD4wWayXjvV7kRKHDkBranZHrX9eZDCGetEWCij0dZBzs09f2
    YJYhef9zPK+EtBoPYidxLVPaI4/njODMzVSOsheMYdupii8ndLCipOmP4Upw
X-ME-Proxy: <xmx:jkY4ahwyqdRo8hdnyO6120fxaUoeg298iunIG2Wcjq_Zn_eAwiIWSQ>
    <xmx:jkY4alFSlFCp4rNUcmW6SrFcDI1od3oGUTbf7jMGJ1rzNc-8EwOZZA>
    <xmx:jkY4akYyFQSUeDH73VoVb-Xaoh2BRdzVMHJjOfw662pPZenW-FkY1Q>
    <xmx:jkY4anCnk0h4IAkKI-QayW7a6hay7XzGAia2QPBnwUlXN16ddAmNtw>
    <xmx:jkY4akDKXVF3QfmC5iibpTaVQcWr550FVyiMfoAUK2VwdRA1l1Fye2zd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Jun 2026 16:16:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood123@gmail.com,
  johannes.schindelin@gmx.de,  stolee@gmail.com
Subject: Re: [PATCH v3 0/2] environment: move ignore_case into
 repo_config_values
In-Reply-To: <20260619155152.642760-1-cat@malon.dev> (Tian Yuchen's message of
	"Fri, 19 Jun 2026 23:51:50 +0800")
References: <20260618114207.605211-1-cat@malon.dev>
	<20260619155152.642760-1-cat@malon.dev>
Date: Sun, 21 Jun 2026 13:16:12 -0700
Message-ID: <xmqqjyrr7ipf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> This series continues the ongoing libification effort by moving
> this global variable into 'struct repo_config_values', tying it
> to the specific repository instance it was read from. This allows
> us to encapsulate the configuration without altering its
> eager-parsing behavior.

Looks good.

> compat/win32/path-utils.c --- Is it appropriate to include the
> repository.h header file?

As the compat/ layer is not meant as a general purpose POSIX
emulation wrapper that is generally reusable to projects other than
us, if we have a knob settable by end users to affect behaviours of
lower layer in compat/, it is natural to make repo-settings
available to them.

What is the perceived problem you have in mind, and what are your
proposed alternatives?
