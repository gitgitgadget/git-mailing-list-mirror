Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0B20110B
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 05:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756877149; cv=none; b=ZKCxSQpIXNUVriLT3viOi7aAjexi4Gz5qBSDyO3DFslgaP2OaIdUNtg4vvSLB766uqw20IMNumwBLjVy7VW2jn68F6e4hOQO0t24mS2DCTWuvmq3Yx0qO4N7rfzA2NiavLCsN96bdTsFjXzcV9MKCezgKOuSsseUvnlX46JfRps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756877149; c=relaxed/simple;
	bh=Cuu2cOkBvYRtYdXoEzrULDNQPoJcx0hx3dZt/fDG/pA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bx9jp/feOCAHYbiqyWBaGoTSQcR/xpitIrFC38eBinTg7g/GOTOFezPFYVkk7xWpjhT995wooVzfMYkccABDEGgEm2v5fdsjyVqP3sRlM8VxRliAI7tjT6dMIsHHv6UNNi8nhMOeAZcTxi2R1GcGJmnnZ05FsK0d6JEoTpmmGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z6bDxcTL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hEv6+0cU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z6bDxcTL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hEv6+0cU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 635A4EC032E;
	Wed,  3 Sep 2025 01:25:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 03 Sep 2025 01:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756877146; x=1756963546; bh=5w9MHFpQKK
	6eU1zdEz04pWWAaFg5Nt3+1TedafPRSzk=; b=Z6bDxcTLLGkeYTbJHlLiaGKjzI
	MI1qsn2kPzoKUpx8HLgp4/oA+OOGEXT8DhOR3ZIuhIsSzBWq6qZerYidF8oq77DA
	AGkhNcqcPe+O+JKkiTcjy0vsyb17X7NvohHU71umTIAjX9yzxCB+vCbl1QppCUL7
	UMBqfmm92EPz5lhXTEvjMSeVR34AKvTGtQfKizVA5E4ZYWVPQ9tbHSfmaTCU7gJ2
	9xBBCW+lIx738yqkHiDfzaRJgsJ4QzJSsC/9lUDVCwc7LXj3ZSP6LjnRkdnp2s2J
	ONpAhntIiyKU8AVqx5JAZEpAYLzpK+VIDFL2pKYoJvRWkzm02d4HUZEpkuWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756877146; x=1756963546; bh=5w9MHFpQKK6eU1zdEz04pWWAaFg5Nt3+1Te
	dafPRSzk=; b=hEv6+0cUrQVl1q3Js7tLMILw+S0XMITNh2wpClV93NZa3V2iYQ/
	B/snhcFezyyilIbaIFwK7X67001v4ee9fM1vdx+HH+aSObfw2V5RlgxEeZUnpltZ
	Uv/FLA/xJvodofgU6eqLxVTRaaNQMImbH0Z9AxR5BuLi9X0d1hO3ZqFFSyxG+lOP
	LwXS4JcDmTG9rImBQ2NdN4VdQBLJS6aiuRRH3qD1bQwnIIegSQrMs11jQBSKyHVS
	Ij6Un/Xe/ChEc0weJEupCX4pTMYfj14jCwz9XJT12zWUWdUYxvIArEafiZalED6M
	11oYIOXnmwudOS7KY6LP+9HI5rzlOnenPkA==
X-ME-Sender: <xms:WtG3aBMi9O4RTlLHDRQZOkgA5tOgti8UTESLVB_hfH1oEmXIjHppkQ>
    <xme:WtG3aPcmJpvHGN8DZE_XfXbnmnSAhQHh3jOre41CzPGuzqCni7wSnoYJYJ8hn-xYR
    UwwH1UjqZ7gI5m3Og>
X-ME-Received: <xmr:WtG3aGurlfmLcNipCYDyBKdKwV8u-wUZ8KfmnshiyReBKrB0Ysg8PcASzEKm_7SNoIlYSB7MJz56clGkeMz4tQ-gijcofHBVj-I52hc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvggvthhsoh
    hniheftddujeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WtG3aInbdcIADMs_qYaSYhLFPPhGiMewP52UzJw5Ai7MQ23kSk4XWA>
    <xmx:WtG3aAzps-OISS_vUaf7_BadTQ7m_KjR5lLokyjiLJPbP-rw83fwyQ>
    <xmx:WtG3aCNKRCyA6JsqQ0oJ-AFpND7hF8QH_q9jGZSU31PeBJttNu43rA>
    <xmx:WtG3aEpEZN0A3U6ttR5faP5BxcXvJKDlA-5YVZMUGEya4ZaX_fmRfg>
    <xmx:WtG3aD-CLarRSNyEBX_uSr4lw8V5SyZgurwAuk4sLn0W8POjcqbzPwLn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 01:25:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Meet Soni <meetsoni3017@gmail.com>,  git@vger.kernel.org,
  shejialuo@gmail.com
Subject: Re: [GSoC][PATCH 1/5] builtin/pack-refs: factor out core logic into
 a helper
In-Reply-To: <aLbEWSHUotkmSiCq@pks.im> (Patrick Steinhardt's message of "Tue,
	2 Sep 2025 12:18:01 +0200")
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
	<20250826073645.1074397-2-meetsoni3017@gmail.com>
	<aLbEWSHUotkmSiCq@pks.im>
Date: Tue, 02 Sep 2025 22:25:44 -0700
Message-ID: <xmqq8qiwgl9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>>  builtin/pack-refs.c | 31 ++++++++++++++++++++-----------
>>  pack-refs.h         | 22 ++++++++++++++++++++++
>>  2 files changed, 42 insertions(+), 11 deletions(-)
>>  create mode 100644 pack-refs.h
>
> Shouldn't that header live in "builtin/pack-refs.h"? Makes it way more
> obvious that it exposes functions from "builtin/pack-refs.c".

There shouldn't be any *.h files in builtin/.  since the top-level
is where the library-ish reusable things live, so that they can
eventually be used by more than one *.c files in builtin/ and also
by other *.c files outside builtin.

