Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A754B1D08
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823124; cv=none; b=sclw7HMx6+oTtbwsJ5MfcgFtdhNM46o0OdqrGiK6iiFeotY/rCW9GldKmrluy5Jo5CT1xFAnwt+4/Xg28Xch4KZDjoaapYSMwVGjuN/DuEi0nmEOVQLf/7wm9Am7tYwZCdvkl3AxmVIMMHyTV+lBrZEMgDUXZAAM2pZILP4k5po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823124; c=relaxed/simple;
	bh=Vh7OUqHDXyQmI4nl3FE4mOC3aHid2hN24daBE1eBl0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gJm1BjVH1pgV5uerveTVBrUtascu8WVvtMkfbk013HEa2MisyW+9AGEQn4AVzdne/dlieX0Y8FTi+9fmoIgI1ExCYs+XrTZA7+6kJiIfeIzHqzJ6LlK/CfSrcKMdtydLv7rQB9oZVPuH8A4Fhxj8Jun32MLtNzYzv5ULRK0UUQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qvb8sokC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WNhU5xFH; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qvb8sokC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WNhU5xFH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 34681EC087D
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 12:38:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 12 Oct 2026 12:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791823119; x=1791909519; bh=2JIzmTUnBD
	gMKPvRdUEFlQ0jTNYM2meUZzmkmFEpDtc=; b=Qvb8sokCnAKLAJ7QoPMH3R6XFx
	94o3DvMpmxf9K5T2s4MMyaLjzHqxKg8XzfQkkojafZ6prkgWwUQkNUJ+qY7drDVX
	6bv1WXDS4cVtv6EuIJKgWumWbkaF6bW1g/zIVk3MtFH7QJD3U+ENzZKXw0dc18ec
	c5O14BacanaAA2Py5D3GEd8c3D8DXts15Gs3dDCf0VV6O9pBP+RNjvCGiOcKcJk/
	H2x+U2LTTQI8NhTy0ZqM1CKZ4SnYpc1GEuHzVunCkL+Zozg9B/2mHSbFay/Fqc1b
	WU1phkNPBUHTNgDrHVx3Un5TS4lnW4PO+ESonotZVEOIEOMhybb7Sxr1REGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791823119; x=1791909519; bh=2JIzmTUnBDgMKPvRdUEFlQ0jTNYM2meUZzm
	kmFEpDtc=; b=WNhU5xFHXZ8AnOc/XzMCXynpGwAv/WucBOSMtOv/6Hl+jLHKoQs
	dqCQ7YNtoEFLO/6ZQh2LSeBLa9oTNNql621liQpZgjyyaA9lCJD7Tc7bCifQBGp1
	hSVVUA4T3Fck73DLv72su7s3Ng+sMk19mAXKT4CJDYWgeDXz/kPi/L6nKGrw5TiV
	/yvmLE3Gb5WY9AL6QgB7+izF7dSDLIrOq1VY2VFINQh63GbbVco1kELU+haJKwaF
	QH7uuBRg6cL7qkC7+3sNWY0rkvJiFJ4WZ39Y5kvvkWfOKpRaHLtwLcWf1HCbN8L6
	IFcIOu3ZW25ZoFgqt3A2gw8ytSSYDHV/YUw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791823119; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:OqNLm1/5TN9jF8dQjWzqKdKxltptEZtenhfLIrvCQG1Eokk
	ZbdXmouBfvpUgO3NoDh+4qs9Y+ILUPfwwKagx6oEcgclsdOJyEOy1m0X433TKBTM
	/SgrDyxHV+rpAUszlaxElNcTLT4+THjNBXZ6zfmUU82hreFZ2LS92QEHH4feoWvP
	L3NPh5jyDiGEqyfEjaKV9DBKFPNTBEbfwvg70RqGW6BArFgdYNXSnFXFrCRlmxUY
	dPmRPUvNiaXmJ/BBvsLBA9iHic8FKtzfL4GJa5FR1c+g1Hs+/kdHdoXTNzwX5L2K
	mR9PghqYFIN/C+lND9wufJVfkDmZ9LA+JUNLeIw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YWgf2aQRxtt7vJUbM0rM4rlC+mpA8Yo2JrG6WY+RpXw=:Vh7OUqHDXyQmI4nl3FE4mOC3aHid2hN24daBE1eBl0M=;
X-ME-Sender: <xms:Dg3NaqaM6CEQC8lHSb_y1pNjx0sYNHxswty5pQxM3OWNnUsNM8xdXg>
    <xme:Dg3NaiW89QjzN3c2SIaZh0u9v0u39iQjGynPBfyxqQ2Kf5z87dlm1jPnLW7D0BW4t
    ZFZAd4bNeow2tX8xrvkkauwRTCwOrqeHpyN1LJHZ5d-u3hufr_ATV4>
X-ME-Received: <xmr:Dg3NapOJRqGGGGkB926L_o7_vfLcsX31VdsntJpuXuwhZX2k7LevlPQ5fsEWQQ6NXKnMtUQk3bLStm30uCF1cgFqQtx7ikMC_lm4>
X-ME-Proxy-Cause: dmFkZTFHk7YpyfiqlAhtCgHQ74idA+6XKrq2WSNPmeilw/iuB9WnxZVoTw8SOZz4bVFmqN
    nF3Q6kxbdwLWN5XcW1jXE8nZ4J1+V3YOVJF9sMFzsUGqZiR7D3VcNJQACIQwPVcIIMrBqz
    KRi5EZNpLO4m+5VNsdbNVmreq8v0DFWcfQz3vqBs2VZoHMJ4G3tTuf1c19ac2fspZtYQIT
    26Sm5B9X2N3e+zzE/bTZoC/Df0cxczSxN7KJjUwz/2hW4Ced7nc1/mbCZvoD/MJCPWIjVO
    KDMXnSf5l7boK1u3zaGOjkKP4ILCfg1EoJv5B2WgJ43qls2FFtZ5qptVLJlLF1V0tB4tVc
    Q4RVMCVilQCwM/ca7J+Wt+72dQytHOO1d2MJ/yd3R6xCwPPPd7S06ryHswbqhwwADiSskF
    p5X4hBaz2ykpvK2plYGHq/Ep30owM5lvC4mApoFhes+/FpTN1CSU8FeYo46p/oSUgfyxou
    VSsvgCWy6IFSVGSIk8m0H8i4FrlKGBvvOzCruB9KmuLWr81gx33piIS+XBDPiY04jJJQ3u
    TqnLd06aLc5HhxMcYGOSbYq5t84ZB6oMJexZiaAIutdAEqYsL1d1QBeBDLxlXWeb7kgXEo
    s7GkYOUxaCk3wF+2fIHW7s1qABWZn+7nLD3GtUHkRaVxngjfYNY3LHvQJr7g
X-ME-Proxy: <xmx:Dg3NasZbyGnAdB5nH67454yat-lYiQU8oVqAHGsILe607ZTkbJv0bg>
    <xmx:Dg3Nao_zUSR933cHAivZ9TBaMBghDA9o-HApnZZhPzQOqyn67pLEAA>
    <xmx:Dg3NatQUVxnrIHmd8qbupCIZmQKCc9yYDiZWyhqY35t-0myanGEY-A>
    <xmx:Dg3NaieP4IWDHJ7bCRB-BXilL0l4DSDKudv41UYQzYEdtKczKlV4mQ>
    <xmx:Dw3NaoT4xxyScAf1i72NQCsE5aruKBwHvHD93aRw0Nm7mY3eWBuWDE1_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 12:38:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ravi Mistry <rmistry@google.com>,  git@vger.kernel.org,  Ravi Mistry via
 GitGitGadget <gitgitgadget@gmail.com>,  Abhijeetsingh Meena
 <abhijeet040403@gmail.com>,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] blame: ignore revs in HEAD:.git-blame-ignore-revs
In-Reply-To: <5fcd107d-b620-44d1-91b7-e5f9965171cc@gmail.com> (Phillip Wood's
	message of "Mon, 12 Oct 2026 10:13:28 +0100")
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<pull.2224.v2.git.1791493644.gitgitgadget@gmail.com>
	<35e303d65bc378e733b1e9e8d6908a829352e857.1791493644.git.gitgitgadget@gmail.com>
	<xmqqtsmsdpxz.fsf@gitster.g>
	<20261011222929.2957901-1-rmistry@google.com>
	<xmqq8q43eszt.fsf@gitster.g>
	<5fcd107d-b620-44d1-91b7-e5f9965171cc@gmail.com>
Date: Mon, 12 Oct 2026 09:38:36 -0700
Message-ID: <xmqqbj8yan77.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I've left a couple of comments on v3. Ignoring uncommitted changes in 
> the file in the working tree seems a bit odd to me and we seem to be 
> prepared to load a file of any size from an untrusted source.

The latter sounds like a sensible thing to worry about.  Thanks for
bringing it up.

I do not have strong opinions either way on the former myself (the
behaviour implemented is to attempt matching what the hosting sites
do, which obviously work from the committed copy).  It indeed feels
more intuitive if the checked out copy (or even the file before it
gets added for the first time) were consulted.

Thanks.

