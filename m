Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175281388
	for <git@vger.kernel.org>; Tue,  6 May 2025 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746563648; cv=none; b=rZTIbM4GsDmcPzuaWtXswHdSapva7SxfQnot3p3/bC2uHWN0xH/BARVtNLiwIBffTpyE1h8wNX527wdJuypi0aBmWDxN6lmMEpGyM4Wn73N6tk5ZLr0wP2j0U0f9s6QOF69rbyuZ/1AMobRf/2sPrk7xTemtMKWeDH6DEQXpzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746563648; c=relaxed/simple;
	bh=TUhkgt0VdjJBpYGRnwMmQYSUm57YFHF80yVSP4OCVc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TyVXXe3VJF+fMN5MJ2wExtgnorfrZp87y3Qt1cELnXMzajkR/r1HGfINVZOlTP0Ku7utTherUW2EKA0HyhGmZpY4pjA6AJTHByFDx2k/BlBVB7ncGEbEj+X6nXcjasLRX5ZAOb+8MzTXr9Mk6IP1ZIvJncfQB2sVf5+qJXAYVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ENphoTAy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wi7oNF+b; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ENphoTAy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wi7oNF+b"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F189C2540262;
	Tue,  6 May 2025 16:34:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 06 May 2025 16:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746563644; x=1746650044; bh=TUhkgt0Vdj
	JBpYGRnwMmQYSUm57YFHF80yVSP4OCVc8=; b=ENphoTAyJjY2aAjfxE8lvE3MR/
	G4mPG3TT6kw6rX/g79rKup3Y/oeRgjmGiFGDv4eb59W0kWQi1Bl/R85h4ebUfu05
	zkVgSmkDH1MEwdL6Ckn/1LUmGtwtunyPqY6IofoxD681QB1E16dwQEmNW2seJQ/H
	9ClnZBCDR7F+QdSF2bY4Z21GLdlwpPWEhIqCCBQM8hxqcA3pRdbsT2ITI8NCvGq/
	+uSaCgKG9g9dm9xQG3VaI7iEkF2btcB3kvycuaO6xsamWQJpCIGiBYgtGfyY0Tci
	cJfNQJTNSCDAhb+bak9j+Hb2dxOKWNK5CiKZFoUe2WF3YGxmblYzNiWJNjjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746563644; x=1746650044; bh=TUhkgt0VdjJBpYGRnwMmQYSUm57YFHF80yV
	SP4OCVc8=; b=wi7oNF+bYrCXm9XNQexltY6QGSx4RcoVfa8yyJQU6fik28bM4XK
	7wt8qWM8Av9K9VJPOUI38oDdLlhMYYAOJ6xiIrW8t7SdoLO8acQNMkCP56dvog7U
	GGWT6vMSPPiN1eTP+MgJIVoGnEQMxkOPgOesdliztn2MavkZmYMeEVQLfrLO1Kjr
	PfeQhsFNs199HK//XuuLQFBevFa3VsLpuyvFfpCM+v9bwaOkZZB7S7FP7j1VpXW/
	7+M/qQFmmSRfU+AmoYk9TON5X5bt7t0kEJ7dXBaYB/fGZk6qr8diz7ps51TwK/F0
	rww57lGYUO9Sfwkwi3JJSpCSTcdrXhTFgnA==
X-ME-Sender: <xms:PHIaaH2XSrizStRakfgbuBbEmHeM3yZws1hCPKDwivC1ySYuIZjsKg>
    <xme:PHIaaGHqDtGIDD1bMxadn8o4R4aZqnZ_IEw_yLovIUeRR2jftxbhXWHSTz1b1yGKL
    YJ1XplsY6iCNSOMuA>
X-ME-Received: <xmr:PHIaaH5JuZCCpEV4_h5gxZkyfMF8TzPNo-jk7IBqKl3jW4jNlmOivqRmCRY_xiiuvz8d5hIxeMT4gHyr84y6dGZephzeZUhCnq9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsehmrghtthhhihgvuhdqmh
    hohidrfhhrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PHIaaM3q9l_tLLdmmHqwbpMyZ6WavVZ_h8Dthysexyp3BceOXqCRJQ>
    <xmx:PHIaaKHrVSqNYYROGvKBZfmmVTCosp9iYm_-PVY3AHwrsF0r_aUMHw>
    <xmx:PHIaaN-Vmo81mEK4nk9PEdMVAGeyG9hxfzPGn8M7GyXE8iQe9jR1Fw>
    <xmx:PHIaaHm7qQUcBt8poTG-bCXvagn-d0YmhSueU0Ko1QH8sWsdUAR8Bw>
    <xmx:PHIaaLHZOEXYsXUV8_qDvZVI8orgPLsNWE2yFYzZoOHuIPN-AWwegvO8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 16:34:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH 06/10] contrib: remove "mw-to-git"
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-6-e6d5ddd79a72@pks.im>
	(Patrick Steinhardt's message of "Tue, 06 May 2025 16:12:39 +0200")
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
	<20250506-pks-contrib-spring-cleanup-v1-6-e6d5ddd79a72@pks.im>
Date: Tue, 06 May 2025 13:34:02 -0700
Message-ID: <xmqqr011h41x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The "mw-to-git" directory contains tools for accessing MediaWiki via
> Git. The scripts are essentially unmaintained in Git: despite a couple
> of global cleanups, the last changes were a couple of security-related
> issues part of 9a8606465e8 (remote-mediawiki: use "sh" to eliminate
> unquoted commands, 2020-09-21) and its parents. We don't ever run any of
> the tests so it is more likely than not that many of the tests have been
> bitrotting, like e.g. documented in f8ab018dafc (remote-mediawiki tests:
> annotate failing tests, 2020-09-21).
>
> Furthermore, the code has been spun out into a separate project at [2].
> Remove the directory in favor of this new home.
>
> [2]: https://github.com/Git-Mediawiki/Git-Mediawiki

OK, the new home also lacks activity since Mar 2022, but it
still is certainly a much better home than having it here.

And I doubt this removal needs to wait for Git 3.0 boundary; unlike
other things, we shouldn't even have been its primary home to begin
with.

