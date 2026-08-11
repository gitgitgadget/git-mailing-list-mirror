Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAEC1B4F1F
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470629; cv=none; b=qtmfH+h7noCvgrdGczRvQ/3GG3TgzzZep7MuCMRl/s8oUsnJa1FWanN8Gwd3ldO5vWb+do0WHSDlgLlJDxaIfl0ZS+nQL6zzjTGvliGmhaIJgAeC5owqbHwiUGYZ5b77/ylGcHi/lILr4REno+MkTST6nB/EUyFbPBCyT+252bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470629; c=relaxed/simple;
	bh=inEQeMSo3gY8jT9plWQr6LNqiY3CPb3l8OSsqLR3OTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P38Xed8R+qmpKWl/mkRSiHUgLjwemaHeswobvymMGCivTJDi0TnHuSZGrxZPEEzhAK3nxCpGInZncs25a1Mv+P+J6qDNqZh1WbJFop3o1ZFF0eajgFFYbpX8iQTo/SHLnDmf+AcEHVLqStRNd04ZXF8jawhy0AGHwdtqDQqmUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=t4gqZdkR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M+73Oku1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="t4gqZdkR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M+73Oku1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E3DBEC0256;
	Tue, 11 Aug 2026 13:50:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 13:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786470627; x=1786557027; bh=0GTPLWJF+t
	H5RmJBsoSgua0sTEhWhGn7mYlvWA8DyCA=; b=t4gqZdkRg+3wjhWJVHHx8fDV6K
	8WJ1YP8yE7DltwA0I7wmf9mAgwY2C3ahG1TAaGNKqpW6Lt1Cb9EfaIjPCRBWdBTH
	6KhWfg1UgTQbJ+W0RifjUgrnINkpazIKB6PoXXyqq+L1t3pSwjefA4IMs4AgI03G
	A4c9FauxOeAvWlWrzfH68yTOaVqcwI/saEaMWwexapGDyLCtC5xXbA8cHwhBw0pU
	lEj4Bjk3lezU0PENkopy2ZksN5FlS5MpC7c6k+Eikra12rECYIqXj2povdNo4s8L
	Dki3Jv1uEgeylqMFPg4IhfstJRirJQgIaUNa6Lrs8ICMZnOE85NpCSro9Duw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786470627; x=1786557027; bh=0GTPLWJF+tH5RmJBsoSgua0sTEhWhGn7mYl
	vWA8DyCA=; b=M+73Oku1Fof9Iv+IJltmPEERHJwndgeWnht18VLRUrKl/cwTMjm
	WGStPhVUD8JpOs5yKJL0KaGf3WJL987ov3wH1OvrZrwY2QxDFgUaL7A50/KKkDW+
	M7TPVgNY13TZY6O9Qql8c6UXrRSemZzQ4LCgRhTOon99yqmTmLHtuDzOYhnezxAg
	XHWkxt87s90RZyHqUsG0zDzX6k7cCuH+P12ERVzNg1liD62jKanRTkswZFlRsiD0
	ag7RPsIpqUbu/CDGfuejO3UxC8j4mT1Kn7IXu/vXYBeC7FKL1q4IHWtdurVe601I
	uEe5I5vPT6L9Tk9nNdMafUXcZpLO6usYnmQ==
X-ME-Sender: <xms:4mB7akXfZ-A_AkeE6IlK5Rnw6Fbzbij7RB5r8pX2yoii0xdHXuPIyQ>
    <xme:4mB7arLuIbs1KUJShHQsvzoXK_EyyT09Fmmk5K-cOnInSm7vIdt5Yv-gBLML-eKSQ
    k70bYIWPdRPnFyQQzU_joHU_ZUxL8EVFiuqys6uTZVGJBgkcms23Q>
X-ME-Received: <xmr:4mB7asBiHBn6M2JXdzULTFhOne5Chz5Grl97PNwFZWKQfJ08gOd32d7hvww6JBCULkF2IOdJj-4nMkwaNZ4UasB6swugbDVGKg>
X-ME-Proxy-Cause: dmFkZTGD890Eq69Aqkd21HnzxPEAta51Zh4aFt0x6vdcnZGyNPng+AWkUe9PEuqe2tQklI
    PMsPYxT0KwEKm1LeBdWvNKb6thnA6SPe2y87zuvg9N3exhRU7YYaCgxavWx5HGnzLKuuqe
    ICyTe7WINAPp8YE4Z+SV/eBBMl0Znb46WUukRGU1eBePxWDopo6nKpayYZjOR9Pg0dyu5o
    MqhknEajmy7YgJPZYS1i9f7f4xNVosc+VBXEUn0OoE58gmF3CmMyc6fm3/yiU27Mknr0pI
    nFGSWE/NMmJazAya0y3VsXC+Uw39Cty7Oq+3VXGJakpztIUpxiZjk2uqd1j43Pp6N+QIHf
    wU6J5MB6Kuf1wXhe4efJV20YzFO7+N8Wd83BI06ytIenG8hsBAfUh0lR/QD0pyEDdEKYC4
    /yPRC88oak4ejB23tFAQGmW17AmOy39bhdcdC/mhFwDLmmK9VOPnYKsBEFpwAbaHFzc0P5
    G0sW8RsW+Tq8ARKrY4zcaV6DXU4lT5VSEQE0FWheRh1iMERJKCKIEhM4Hm91yJoC+TmyB/
    M3FxmH9ZuVyfxBXauFfT2skjlRsyeoGPDa3JIjmmu/f5bSvK6spkMA1YKZkFBuGdt5PqzN
    jbmmm2xRK8b3eQdf/41tchfb8xcvlQqbVdoZhEqeI3veXEFyWAGm5jfXcntA
X-ME-Proxy: <xmx:4mB7ajdBW8gB0qwZuHJjLX_BH5rSr74WxiCXb9qIy8_ZkZnzdcoSmA>
    <xmx:4mB7aj1epp18oH67p1E5JYLIDbknbbhFqJr4mvxSasBq7ZJ4NbrrYA>
    <xmx:4mB7aiikXnBjFY0IgVNoI4MwNiTnMeWRNcWfxoCCz5SaF3DcYoffKA>
    <xmx:4mB7aknRrq3b61rSYABaGRT0eqHErpH9S43lVW4Jzt9O1SWwz2mbiA>
    <xmx:42B7apce-cKsg0SmgJrn9_bIt63iTxmO3pBza_bip8KSLQOMylooLpYu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 13:50:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  ttaylorr@openai.com,  ps@pks.im,
  johannes.schindelin@gmx.de,  l.s.r@web.de
Subject: Re: [GSoC PATCH v4 0/7] repack: add --drop-filtered to reclaim
 space in partial clones
In-Reply-To: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com> (Siddharth
	Shrimali's message of "Mon, 10 Aug 2026 23:10:40 +0530")
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
	<20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
Date: Tue, 11 Aug 2026 10:50:25 -0700
Message-ID: <xmqq7blw35su.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> Changes since v3:
>   * fixed the git repack -h usage string to include --drop-filtered and
>     --dry-run, so it matches the SYNOPSIS in the documentation (t0450
>     was failing - caught by Junio)
>   * converted a bare grep in the test to test_grep (test-lint error -
>     caught by Junio)
>   * removed a stray bracket in the documentation SYNOPSIS

These three match what I locally fixed for the patches from the
previous iteration, so they are good.  I do not know if there needs
other changes to the patches, though.

> To do:
>   * remote verification: verifying against the remote awaits the
>     "remote-object-info" cat-file protocol command
>   * recency: a "don't cull recently-fetched objects" rule as another
>     selection criterion alongside size
>   * drop log: introduce with the error-path change that reads it

Are these "planned for longer term, material for separate sets of
patches to come on top, after this series graduates"?  Or do you
mean "v5 and later rounds need to do these three things before the
series can be called complete"?

Thanks.

>
> [1] https://lore.kernel.org/git/20260806112202.75067-1-r.siddharth.shrimali@gmail.com/
>
> Siddharth Shrimali (7):
>   builtin/repack.c: add --drop-filtered and --dry-run options
>   list-objects-filter: add list_objects_filter__filter_oidset()
>   repack-promisor: allow excluding objects from the rebuilt promisor
>     pack
>   builtin/repack: enumerate promisor blobs for --drop-filtered
>   builtin/repack: actually drop filtered promisor blobs
>   builtin/repack: add guards for --drop-filtered
>   Documentation/git-repack: document --drop-filtered and --dry-run
>
>  Documentation/git-repack.adoc   |  37 +++++++
>  builtin/repack.c                | 151 +++++++++++++++++++++++++-
>  list-objects-filter.c           |  45 ++++++++
>  list-objects-filter.h           |  16 +++
>  repack-filtered.c               |  82 ++++++++++++++
>  repack-promisor.c               |  15 ++-
>  repack.h                        |   8 +-
>  t/meson.build                   |   1 +
>  t/t7706-repack-drop-filtered.sh | 185 ++++++++++++++++++++++++++++++++
>  9 files changed, 533 insertions(+), 7 deletions(-)
>  create mode 100755 t/t7706-repack-drop-filtered.sh
