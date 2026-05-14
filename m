Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E719386C24
	for <git@vger.kernel.org>; Thu, 14 May 2026 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787610; cv=none; b=gxBaEb0uzrIATSNlsEhxER0FKggNGjiKZbypB8nl8WBc5/tPfIci/UwsGjjP1r6Sx/XZqSZG5n5mcTnECUuKYCot3mQSL9dUVtrz7gVjU8mo77//CKWzvGZPBqbhxfdDmi0eC9v+pSJRaSYOTUOstToHBvRlTDet7gCaQe+BoJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787610; c=relaxed/simple;
	bh=qCmNAlg2nV+zhRgkGWAjHT30L0OewI0Bi2EtF/47HY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h7knN3xjpmxd2YgG1BEVBuvWzqpmkbKCErk2i0/EWMHlYWdJXOVZD3IZCsVgLLO28JMLhh4FQDNKeHp9WSSahGip5cFuCFGKbZFmc62rm3MVH/SA4pbu4N4vUstlckfLIFv0NtTstOW7w2tlVJKytZggdjUFBjGjZYvbiRXM+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C6uaJGlh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N+IvlNuF; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C6uaJGlh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N+IvlNuF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DF4BEC01BF;
	Thu, 14 May 2026 15:40:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 14 May 2026 15:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778787608;
	 x=1778874008; bh=VKbCP7VjAggYRO6zRALJaq9zsoH1ZlqBjJhEpbWNdGQ=; b=
	C6uaJGlhXhP50RxnwrvQdFcGqjhBsVDB3WOBjIgViAYZD6Qp32k3baGUPKKSBKTi
	F/fCECc8LV1ZJrTuPNE9ajeMsjgDuLK3MwOzGwAT72RItEAVLohE15Wjo5/i2vwA
	6VjYa1+2t4K6kURApebHT9jDQyHMWyNouJtzVqRBAftB5qf14oNKiKLtA1fgWcvx
	NDXHDT+sc2Zb7lPUYn1c1wABQj1AIx8xccu4H81xWNw+nEp0PjdI1cxfXwliHxHy
	mlTiLzE85TWhU9e3Ufwy9Q6K0V9WrbAHRxjka3riL08HLTS28Lk5K8XLxRfy9r4n
	is979EzXBOA/2rprc9LeqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778787608; x=
	1778874008; bh=VKbCP7VjAggYRO6zRALJaq9zsoH1ZlqBjJhEpbWNdGQ=; b=N
	+IvlNuFfdV6sNR+JcM1G78/QY4E2BywH+CyEccvdhEhICzPgLR+NEvljRPDtlJlF
	oSpiQdW3bJDeBVoYB177dfzW2Zl7bqXvv0AwFSBX8+CfNrIDlAHHlM04TM+UzACG
	Q6LgEfwh9x8GgIluEuAHyD458okQKbckF1Io1fp/GAfie9vjppTYywKKqrp4ZrbS
	TNc8FzUAkuq+3U+XgypZrx8yPz6EoxdBfJUpde2EpD7knrvGE8wyNrcYilcWNAz+
	XOxRGQ+hTWgnyhcvOCj9qkZJchJThbakLosSS2povb08MUpBwqeoVdd6PXDW4iMH
	NJPbPv9q0WP0TGp5pdwbA==
X-ME-Sender: <xms:GCUGanaUapX1TaNPh4KlZfBVzidBpicTNV6ExY1HCaZ0lz6PN95bcg>
    <xme:GCUGatb6ufO20gX7m6RFzHY0HOAJyyjSVgCOs0HMr2WvzUO_3q8Sn_fMAckyNiIE3
    kWr4Ixxj_4NUN4Hj7p7r7-YvJqjDMMVWITTmD3GETk2TZDqpM2Z>
X-ME-Received: <xmr:GCUGau8evhzQvaLIS6HVT6882BoahT4rHkWCtCipYxCkw-GTalU7ZD-r2qijoLj8m8rEiAzhG9ke1bzmoJfxbowdkQoAcFW09Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdekfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhhrkhgrsehsphhothhifhihrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:GCUGasjzMaxE9LBYwd9tKJMcJ89VIeRdJCIlHBBb75uTGjzhKGEMBQ>
    <xmx:GCUGauex6wtdPwK5L41N0takp1haWH9vhGNJnpm1Ile7mvdf7-rGBg>
    <xmx:GCUGajqXunZPTZ3LKGeyYPXS2CIo15lHEQfzRDPiAy26NVcrSCOX2g>
    <xmx:GCUGajCTs25Zu2ttTKf81k27d6XoKKGrFXwtthnQHI-W-7NZkORjrA>
    <xmx:GCUGanAB35rkDwC0p_jrDmlsn63UC-7M50KGmnzcU_CPt3_0qzY1bAQt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 15:40:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] revision: use priority queue in limit_list()
In-Reply-To: <pull.2114.git.1778777491939.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Thu, 14 May 2026 16:51:31
	+0000")
References: <pull.2114.git.1778777491939.gitgitgadget@gmail.com>
Date: Fri, 15 May 2026 04:40:06 +0900
Message-ID: <xmqq5x4pg4q1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Benchmark: git rev-list --left-right --count HEAD~N...HEAD
> Repository: 2.3M commits, merge-heavy DAG (monorepo)
> Best of 5 runs, times in seconds:
>
>   commits in
>   symmetric diff   baseline   patched    speedup
>   --------------   --------   -------    -------
>             10       0.01      0.01       1.0x
>             50       0.01      0.01       1.0x
>           3751      21.23      8.49       2.5x
>           4524      21.70      8.29       2.6x
>          10130      20.10      6.65       3.0x
>
> No change for small traversals; 2.5-3.0x faster when the queue grows
> to thousands of commits.

Impressive.

> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>     revision: use priority queue in limit_list()
> ...
>     This affects any command that triggers limit_list() — i.e., when
>     revs->limited is set — including --left-right, --cherry-mark,
>     --cherry-pick, --ancestry-path, bisect, and rebase's fork-point
>     computation. The practical trigger is git status --ahead-behind on a
>     branch that has diverged from upstream in a merge-heavy repository.

I found this description a bit curious.  Notably missing from the
above list of revs->limited users is a bog standard A..B and it is
unclear the omission is because that case is not improved and if so
why.

I think a major reason of the omission of A..B from the above is,
despite my recollection that such a range (i.e., any presense of
UNINTERESTING commit) computation _always_ worked on a limited list,
these days we conditionally do not when we have commit graph and we
are showing in --topo-order (which is implicitly enabled when many
options other than --topo-order is in effect) since 1b4d8827
(revision: use generation for A..B --topo-order queries, 2019-05-21).

It might be interesting to extend your benchmark over the same
history with the same command line, perhaps with and without an
explicit "--topo-order" added, in a repository _without_
commit-graph enabled.

Thanks.
