Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A91A279DC8
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770824274; cv=none; b=iwgjYdl26AvyxzpcTTVb2jiIToasDaJzNG8KM8Fp0aKiMOhHVdqUfCNi5/RxdnX7JPUx9xDKZImKOpPhL7QpifOujGGdu2UtI9H8zmNHUCvmlj1UJUd/P8VCyGtCDgKKImIn6/hVaZvoLLGzMwWfk3SGsfbMM4zDfacZ50pqwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770824274; c=relaxed/simple;
	bh=M/L7eEEhpB80TDzTKkF4gyeS0uf3Ap/zuiDkcE7LMwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jJVp5mjZeB9SBgZXCwLSLKi1OyM73xFO7a2Rq+EcPOYtwWLSIpQC2F1U758ZERLfb/gQLBbjlefMEOa9MAH6+uV22oPQgWf/lqeSyQkCVloSnFFib9ITFF2UOjERNO17vy8qxlcOQ8fI531/4GOWMi20Cl19LZA9jR63w0S+z8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pAoEa8UN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZZo1F+9k; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pAoEa8UN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZo1F+9k"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 49A18EC054E;
	Wed, 11 Feb 2026 10:37:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 11 Feb 2026 10:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770824272; x=1770910672; bh=e61OTRn5zW
	IXrm4I2o3SCtm+57253XdVDy4nWBnnx2I=; b=pAoEa8UNL1Pc9ZROAXPCxKlkl/
	aAgfsVsY3HBEA9a2QOsPCTQWw1KZqxgMr5Z/vTSpQWLz0Mc0JX7vKM+rGnSFA6N3
	OhLIZDyET9cXTxA2pSEbKgm9KXdDRYuCDl9fwom6YgbT7g1t/Xv5Ym3kdDI5Obcg
	SxAotjex9Hd9sOyvZx6DvSlB9PDXGQixUOPyQs1nJEWVsOOqR9PaQXAHUBRZaUDW
	NxXlhkH0pvomt18Qv8sbxRAm4x5K20UOsoOGkaf1v8HrXCLZlkwPFkzOOt39+bPu
	0UDv5EQPwcVf+N8FNs/Q61l0HlTSI6Wb/LuLaaMQCZmdESLjHn4vClzWjBZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770824272; x=1770910672; bh=e61OTRn5zWIXrm4I2o3SCtm+57253XdVDy4
	nWBnnx2I=; b=ZZo1F+9kYqA8/C5ChwpWj73odz85sDkSoxF2S8nKtBOzoGpyVYy
	2nvqN2S92X8nMyWbc5QK93OaMUX5g2yfG8l25csCEttOxSEx2VnG+KS/MB4cQ2jL
	1fFX/LORfc/gFagnmdDXbU6FnOc41p8qzqNzkr+zjjGqO+5XqPjfF8oYssRZVxAy
	BHrJoRZV9QDSg47bKFruItdqgIoixzIDYAqMU4UVqLxNhU6MrYt+xmIZlOO39zbS
	sOSZriF0PKjH3pbQBlCTOOgi5RGjk/WdtJJ+Ygi0Sbr9iIsRxK85IUKZfnLaRf0u
	JQQ3rCZuxgi5Ddp3R5G0474m2D+7y2b0m9g==
X-ME-Sender: <xms:UKKMaeh7H0zGxky2_MaAnDX3b4nvTHxcsl8k-N9FcB8R5j0VMUANyA>
    <xme:UKKMaWDyyH_khyZnlC-ZoXOBsIZT6nkflM8vhjQ44z1M-9D8ZKtfdAPrheeKGggGb
    Oqp-IwL6EclHFdYyHMihBTUQ3jTsbr0sywHtzms42IuAb0QpM5ziw>
X-ME-Received: <xmr:UKKMabGAuxD8P0Ur1-3wWOYeqqHMWvRuVjTQq10h-7cQKZjZ4emf99f2sh1t_I33PVyQ0GExJTR-_gGMRYgLJHuleYAY-oHlVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkohhjihdrnhgrkhgrmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:UKKMaWLfwI-dH5kSt_EmqHzF3NfWyU8dNswo-gaEHwax1Wnjdp9eng>
    <xmx:UKKMaXleahWuvE6vQFdwqngwBEWtBCwiZRhGlLy7jdAbPriwPJM_dQ>
    <xmx:UKKMaWQ9TQNzHdLBfkuJuHQqRRxgyOLeGu2O2se82Trno7d3jI9ZAw>
    <xmx:UKKMaRIPJqXD9BCFQG8L-JmTC0bvm3mE2pxROU6FbRycKnmotA7wQg>
    <xmx:UKKMaQetMozyOmqbRbDS94elP9CLxi4oz_oM7uSp_E6aFVuix7m8bHQg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 10:37:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH v2] osxkeychain: define build targets in the top-level
 Makefile.
In-Reply-To: <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com> (Koji
	Nakamaru via GitGitGadget's message of "Wed, 11 Feb 2026 01:59:29
	+0000")
References: <pull.2046.git.1770746461307.gitgitgadget@gmail.com>
	<pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com>
Date: Wed, 11 Feb 2026 07:37:50 -0800
Message-ID: <xmqqms1fwasx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      -+	cd ../../..; make install-git-credential-osxkeychain
>      ++	$(MAKE) -C  ../../.. install-git-credential-osxkeychain

Will replace and mark for 'next'.  Will squash the double spaces
after "-C" into one while doing so.

Thanks.
