Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4028261588
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544909; cv=none; b=X2rg4AVafr6IhMS1Tvx2m7rt4Uo8Dk9C6rdBV+ICRxVxUNzdxj5oAExV6H46+WunLbAE09gvr0KBAiUOljoVEcvOJ0qJIE+k9owbWmWHamV5jyUTP8Q0h8TkPeHyBtE2oevnf0zNTM2NMJpuvZNtf3SOQ6fDwGiNPUFbJswEfLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544909; c=relaxed/simple;
	bh=VDYm9QOBudwUWLuz6zYvXVCqe7tc3qCw1ceQTzmPHSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GGwouEjLn2kdFzoUEviKRKESJCXt6F9q7Cmsk10Uwz+wmMKiTGKXBrD6mgFajGs8NH6S50uxVWoHuCKb7P/dNldLT3vzM8x/mqMYxxMl+o7SW4O5bq3P9ydUb2/0bNDX+owks8vVo5zfrhoXCI96qR6cXaGBj/0c9SZHlU8YWx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bUf2IEiQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wsKKtEj4; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bUf2IEiQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wsKKtEj4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B77FEEC0266;
	Wed, 15 Oct 2025 12:15:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 15 Oct 2025 12:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760544906; x=1760631306; bh=XXWwKOKW1G
	cBQYjVUZXkjfSzf2CrPdhtOhAywTM40GU=; b=bUf2IEiQn8NgGhEP/o9khoBLqR
	pL4Ls+SonrURb5AsX2pbRGvykBieboCezV0CsbxqHQaFhBuF1BCDAo/BPV3PI7VZ
	gsoyvA+HxxUazKRVmJODWuksoet5WXEz/BaIB5tTFIWtS4KHc5qytSes7NKPtBJd
	IAy/LMBzVjn8UN4S7B2feJoNdvhHGH7ZIrqe+CtorgHVxSGkuQcdlOtjkjcGL5nr
	J29aOzXqSu+yJxLU2Ae7/7gxogi4hHCedAH5ZVp8DC0WX38zcCh1G2LcbEr6cKOm
	z0mFmL8gYtLGleu/j86LOEivqonGyjR4g06ntkViOtxYmbBGRZzMXPN152VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760544906; x=1760631306; bh=XXWwKOKW1GcBQYjVUZXkjfSzf2CrPdhtOhA
	ywTM40GU=; b=wsKKtEj4gJdQXI2UAuYojxiNNKiitfVFppuYuKpqzg9BwkL/kXj
	dKNjVJFDd7Yxka2qrKNKkXdfzV7/y3E2On9i4VRqIovNgj+Z8GlV7aipa+QZy0Ql
	M4/132SBxdaOSWLlI0gpzPebLS4/4MVHUDeM1dt0juM344G8Ov3+YmEVEOE/BFGB
	hDF6Tip3ethJD7CjrgT7KVrHrn80whWMdh5Vj15mvxkeQFL1oAVR1NQ+3X9mUtsu
	h5VltSkdn+nWqYe4EzOpkBQvsQu/on4EIq4BlcAB9cf8ZQr4qVyLY19Aa1EMD96e
	gwfq4BE0HEV7B1odVJZpV9B2d3gxX4AXUew==
X-ME-Sender: <xms:isjvaAYWCKM0SumZS97xUCbOGzsiChEZ1RhpqaA_xZaNGC7OX4zWqw>
    <xme:isjvaCaF8ZLFDvbN5xvEYwPSZ5qVzhytb-TNdjkeESJNrqIUYDMeNOZguCcM6G2DD
    pDoStfSNThN9qJLdqSNGSZuwKKO7pK0KNBjkBIzEV0Fj01UKrC6>
X-ME-Received: <xmr:isjvaP_iZ68xXNg1LV7Y2WQizXkXUNckCVO9ASoaez4zaZ7BofDO5v-E4sO_mXHGZHB9oqb-DVaGpF2GevyFHMU0SPe217qokPKZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:isjvaJjOYEOObG_P3U1VzoKzlEj1UZMLdDUZvYtK7UkZFyCoxWgPSw>
    <xmx:isjvaHe8NZvsZtNv5gpiyzilEzGmZm0Yr9g_mIf2UeEy9nVSsm5dmQ>
    <xmx:isjvaIp2fpvM9uIKtvOeSRQZm7wq2H3c-nD_NrTMlZGYzZMzKQ7Vig>
    <xmx:isjvaECIe04cLcrzcEo_94b5fZLlLM0O7BMBZ5keecCtS8EF8EbSjA>
    <xmx:isjvaB7oBifmqfqaaBpkgUhog5S29ho8Qv-dVVUc_j71Xl0RjrMP1Wwa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 12:15:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] refs/files: deprecate writing symrefs as symbolic links
In-Reply-To: <20251015-pks-ref-files-deprecate-symbolic-links-v2-1-0529ba48db41@pks.im>
	(Patrick Steinhardt's message of "Wed, 15 Oct 2025 08:26:08 +0200")
References: <20251014-pks-ref-files-deprecate-symbolic-links-v1-1-4bcd6a4ef6f5@pks.im>
	<20251015-pks-ref-files-deprecate-symbolic-links-v2-1-0529ba48db41@pks.im>
Date: Wed, 15 Oct 2025 09:15:04 -0700
Message-ID: <xmqqo6q8uoon.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The "files" backend has the ability to store symbolic refs as symbolic
> links, which can be configured via "core.preferSymlinkRefs". This
> feature stems back from the early days: the initial implementation of
> symbolic refs used symlinks exclusively. The symref format was only
> introduced in 9b143c6e15 (Teach update-ref about a symbolic ref stored
> in a textfile., 2005-09-25) and made the default in 9f0bb90d16
> (core.prefersymlinkrefs: use symlinks for .git/HEAD, 2006-05-02).
>
> This is all about 20 years ago, and there are no known reasons nowadays
> why one would want to use symlinks instead of symrefs. Mark the feature
> for deprecation in Git 3.0.
>
> Note that this only deprecates _writing_ symrefs as symbolic links.
> Reading such symrefs is still supported for now.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> as discussed in [1], this small patch deprecates
> "core.preferSymlinkRefs". Thanks!
>
> Changes in v2:
>   - Tweaks for the deprecation announcement.
>   - Use "textual symref format" instead of "symref format".
>   - Warn after having created the symlink so that we don't drown out
>     messages from `die()` that may have happened in
>     `get_locked_file_path()`.
>   - Link to v1: https://lore.kernel.org/r/20251014-pks-ref-files-deprecate-symbolic-links-v1-1-4bcd6a4ef6f5@pks.im

Looking good.  Will replace.

Thanks.
