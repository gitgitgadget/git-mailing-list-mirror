Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E42045DF7F
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788300231; cv=none; b=mCBB/EAhsaADqZX3+zs5DHKDcXb02kOeB2tK9slYRDvjpo++q35ymWz2JgXQYemhie8OGZSESIWoZx+h3QVrZLJbEbmylg0Qw41MRux4w0zf5G2HvKdJ8ZjdKDtmtvs0FapK6dH87BD7Xsr4Czs036ltlGNZrSNZxruXN/UURuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788300231; c=relaxed/simple;
	bh=QybbSgMFq4DclmEucH95G3jM0BPBSnpK2m2lXtOK/lY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SFT4nRHAUbQ3G49+FYNgNlryE0cb62zVvfwNKsqP7Y/ljg8NYsSE9kbagD70oFGpv0nTdcEk7b4GO5KLJUwgGXoeryByGSNQAy++JCHvrlLsLm5wOSctiSm7+7qAkrOgBQtAsETnyu2LfXxSv6nAPvxJANP5rrc3aPvEkBm+Beo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iH/Raw9o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UvalKrz7; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iH/Raw9o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UvalKrz7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1C51A1D0011D;
	Tue,  1 Sep 2026 18:03:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 01 Sep 2026 18:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788300225; x=1788386625; bh=x0VysqTEv3
	s3AdujLV/HpXQQIsvZes/hm9XQlwNu2Ak=; b=iH/Raw9obYggAbIpIb0J7jTUS+
	uO+dm9gp75/BAasabht+lGwqztsXgs1cmybPq/bMkKMEsL8UzxIJr/3aC2qLsBCC
	b2vy/zbJlUZu6ww1xWKSNF5f3U+5zo6+80+vnK83tKOqVm3p1bzeAJ1QPDSO/XdW
	iol2GoAErk4SUKDkpsvH7TBcU+jg/2t3yDtex/4wQtyTRwJ5GLuI3TVqCCDbaTlB
	W53Y6VlAx/GukKfhgjMXoNA34YpQqlT+KkduL80mS7dhYJtJj7YdsRRjYtdwIjhC
	JygfTwgi1VGNOM8tBdiyccR/79uhXPIXdZ+itD8EdIts5wb8soUXYcew/JZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788300225; x=1788386625; bh=x0VysqTEv3s3AdujLV/HpXQQIsvZes/hm9X
	QlwNu2Ak=; b=UvalKrz7amTUW5YqMHHXVyreYnSzl0ooARc2wQ0+8k7AkTVrZnT
	Xyfm2RV4q3+VSKUKzqtGmy+DZNxbUL9kSpMDMTfHcHKlGMF3+8lIi/mKSsH/L237
	C6cOAbyzZiLE/2FhtrFP1qAdS8RvW8vMNDAFtyi0CIlsXk0YzODmrUuaImO+UqMT
	dhGH1e+Dk2fU2la9+kcWK8lTlEE/QTV/3e7aSwxcJInph/bzaI/7FztXu9whz9nr
	ANmfyaYpT45JHntqL+PcP6lQqiiZdNR72/g32i87yhyJ/BdTa210Q1vTP15MsSND
	whbwGh9o8ZK37R00Uwujgz1TfLIeuBx4t9A==
X-ME-Sender: <xms:wUuXav1FNC_-CNAGivH0CPXbmBjjgCJp0yqJwcin0Zg4D09uF1SPRA>
    <xme:wUuXalgSMa010RjWVqE-d6rLHARmjZbggYoeAiuUEmlgBUuWtls23WlgwDZHPzYJD
    Ll5dupPMMFZFw8dEs9o1rQIsV402M6QdZnaVvXAMLlYPLNHhmGRKqk>
X-ME-Received: <xmr:wUuXatTn_UGQbTfr_BsFcBVcaTYps3NlWmktKA0jeBHOpj62kl0NXfqeIfE-vqmQFskF_azeTN5rKiibhNP5949aT4ddLW7UJA>
X-ME-Proxy-Cause: dmFkZTGXloAYMlsDDI/qZRzFxWWW4XO3G2PdhcR2mtVpL5gJR+q3bMvOlhf1WmCzzpvKHg
    f8rBtBYTCE/ieHNVq+8240T5s2aNAsRSkj1QHOjEB8MpijXXx5ncj3Zdp6IOBroB0Z/OqH
    J0sdVtRHXy+n/pNZ+poUi1b+2ehUlX/gxdvuM2/T0re06yX9MK6nRyaKpImSn7i9rpsc7C
    1TUqFSITokqgwMoVStFp3T4b+ZA9Eqs8yIkRo9cN6lrrNkkstZWKMAin7nhD0FXZdTMLK9
    CU6yS+H93gOBLRYcgyEtnkjBFv8bie89lwjTMfhhjA4EMsLkPk9KnYZQ2RtjG4/69XcwTV
    3hBt7V3iLxBkxG0InsiC64y46q1iEme11WfejnIyNq610ZXPFywDCaMsJ/QI0kHcSXaMrQ
    4Tjtoxpjk9HNgMTmXU+k3HaVoUwu65RdLlHwREl3NldPJsPuXsWzgod8A9zHhWjxw5iUdo
    m/ZHxtc18bVwVZD/FrGMBy4G28SwD1wz8TFHVazmKXB/ZbMgou2sLg/kwtjymm4R+Go9Ey
    JWR3CfnzqbDcd1yG3C/QeQKRp/i7gaPgWFz0qUY7T+4RhuvUdytvgORWvjRXlu/Uri/Avd
    tQv2Yw3HyqXoCbPOLE35QVji9izVDOS+s7W+Dz3PUX//cSTR0F1TC8SsMtfA
X-ME-Proxy: <xmx:wUuXauiwnq9KPc3ZzaO4j765x2347oQ__1O4yo54C4FwbN9_S20nyg>
    <xmx:wUuXal4-wwmBl8PzpAeIkOgka-F6bQImdgOkVfxuAVfhgxz_0YOpdQ>
    <xmx:wUuXajCDY595DyxFlTAUHSJyP_6WFntijlG-CpaaCoxF6xHHJlZavw>
    <xmx:wUuXakYFT0OI52DnDLVAUQoqhzyqvhpx1coV6vwRVnx7T6S7vSKUIA>
    <xmx:wUuXalqM3CoqqNmYXSx7dvquqQXdejx0-EtCglj4fJnzs2XJXdl71nSg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 18:03:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/12] cache-tree: remove dependency on `the_repository`
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-1-97a312d5fa25@pks.im>
	(Patrick Steinhardt's message of "Tue, 01 Sep 2026 13:09:00 +0200")
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
	<20260901-pks-odb-registering-in-memory-sources-v1-1-97a312d5fa25@pks.im>
Date: Tue, 01 Sep 2026 15:03:44 -0700
Message-ID: <xmqqzey0ljcv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The "cache-tree" subsystem still depends on `the_repository`. Adapt it
> to instead use repositories provided via the context, either as a new
> parameter or the one passed in via `struct index_state`.
>
> Besides getting rid of `the_repository`, this also removes the last
> dependency on registering submodule sources with the main object
> database. When reading gitmodules from a submodule's index we implicitly
> read that object via `the_repository`'s object database, which is of
> course wrong. This works though because we would then register the
> submodule's object database with the main object database, but a later
> patch is going to get rid of that mechanism.

As "the_repository, " is quite a long string, many lines bust our
usual ~70 column limit, but other than that the changes look quite
straight-forward.

We probably should make the cache_tree_fully_valid() into file scope
static.  Your new cache_tree_fully_valid() that takes the repository
and a cache_tree, which will be file-scope static, will gain a new
thin wrapper around it, i.e.,

    int has_valid_cache_tree(struct index_state *istate)
    {
	return cache_tree_fully_valid(istate->repo, istate->cache_tree);
    }

Migrate the callers outside cache_tree.c file to use it; outside the
implementation, nobody has any business talking about a subdirectory
of any cache-tree, or any cache-tree outside the context of the istate
it belongs to.

Other than that, looking good.
