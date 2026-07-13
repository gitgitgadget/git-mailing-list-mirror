Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868033A70E
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960461; cv=none; b=FdPU3XsoSfJQifbUkAQmmt2yJplL6fCt4sQc9bPx+FSdFQAAfJmDAK/cHpo5NPjuqc6ogwbD5dfA7PBzrnxtZeFKRjbYngN1vmy34csKG2HoLnLpaLhJBzwNtL6ntksSLFSqma5bTjyeflv8F5yA6qWhtTugG9DFrZyNswerktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960461; c=relaxed/simple;
	bh=U+ye8tA7+dXRP3O99TSPV2cVZwox/2X6yPtR7/ZeswA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uMqNcktvcIc6vkenSqCK7HaXl3c+gSIw+D1g5T8R3f8qK+x4MghjtBsqtvSdBu0tPLWyRMWMH2TFbBOROep1wNhuKQUQFPGGhfkhwiEMp09E+n7qFTpzhV5CCY6T4wdV//OQjpzKOWlFQ2DtjG3fmfAdWCBqlnYLwQK+zg8AL8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iZYLrXGC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=btfHyYl1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iZYLrXGC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="btfHyYl1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EAA1714000CC;
	Mon, 13 Jul 2026 12:34:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 12:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783960458; x=1784046858; bh=BCNlpzdSKM
	cnehBz14tiBB5AsBd2nBpg5h+TsCn6DPY=; b=iZYLrXGCWiWfQ7qnHV8vq/ZjzA
	iMj5IBmsiMZX7MTHFNRYu/Q8ghXNuhn59ijfP5do2kxJBFgc8w5gwepvo2I6Z19g
	D6vIYmlCa70myO7LOwKOsQGI3rvfBaulCYLBdbazZNDbCTHGNl42AhzqL1LY7Sh7
	PDnefZeYiBSJYDMwWdhaj6EW4Rjxkr6FDvBs+qOsR2eDHb0GMH24eNsMtdIFcfij
	yrCx67ZztU7daqF4eoU3v1ydlMMrML4/ztJqfuSpTzPfCxAHb7xRLOqHbiSkm2EW
	EReeGQ2hkYEZaly++ExhgGAxA3xdnXoPz1ITsp2Pr1e1ZhUcGl551o3aOqug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783960458; x=1784046858; bh=BCNlpzdSKMcnehBz14tiBB5AsBd2nBpg5h+
	TsCn6DPY=; b=btfHyYl1UZQ3GZUQvrGhVnTW5f2rsCjKczBwxSA58KI2aZIquqP
	4UmNGSvZ7ZjI9ri2IO7PwipQ3+DGMB0kTazA0L/eofjviDO2vhWchzuEW8u8/+DT
	MrQshmNxDXJePM8GyQydD1CYgJS3IjaK5VyAiH4KZhRtWd1gCqGxzSSGrZcTaOzs
	fVOj+XOA6/5ondDqKNhAAvZppqOT9QPNEaY/6TCLlfvXStQs3DQZ17l/9235tuMl
	mO2KwvLaHLDOI8ql9qM+Wq+2S6uJPuposFwVyoMCvoYLHMh8kN0GnIoJ7SG1XW2R
	0M+3f+EJI6BurDITfU8hmgdWUCFAEo2AV8A==
X-ME-Sender: <xms:ihNVak2GKg8PjIoGKtJ5ClLvOW4AlIqr16dXsw1Js05oN9PaDVei2Q>
    <xme:ihNVamhUkvCyhosUmr2aNqlXuTHXd9N4XNhimHOlFIyqIg4bcyO8ldVHakG3Ds-sw
    MKF82OO0EslvjwwwzOT5ZoRMp36kmC9eoRDKjDHN7MgoKgR_-XMdw>
X-ME-Received: <xmr:ihNVaqRogRrkogHd9AOqF1D2WOeRJXsSKos3NuO-HHGdtEEVph1otbc8YsYd4F0GrDr3lSJnSTLkLyXQAaqK_-XArZJHmr_YwG3zPM8>
X-ME-Proxy-Cause: dmFkZTEFKC8LD4/XFYMON3hRoDlq1siBbFaAARda0OyqseBZ2C5olHLgg3M3pv97xo23CZ
    p5hySPVjaG95tZQap1xKN7OCj94VexU7O9GO/lyhtzRq0AoZurbCJHgM4cs6xF1Qrxm/Zp
    FK9pHfLFwuJ8qiwOfI3bMj9EzX0J1Nv5S0qggXNwjqbfrpOhb5XkzvmYaQLg5qdHvpVlKh
    qVIIVsd6xXfZIHuQQd5XasHR+oTzxiP23dO9/rW+1E8/DeH8ekqw8jb6pJHneoikDvcLqD
    JmuMSMoQHEkoT4IK+IqUYCUrG+elri/sP1J549RO6ba/cYo+d6yj2Z3xDNeokELgqftiio
    Okup+59mAoVpXIFNrUajr+HTmqThSJi6sVDhqeoI63hW7EocxrUPakV47t5NIV7ujdhBZ3
    fZWBbBTFtjXQSCRElZFuJ6MdsNkEyl7emnOorI/HNRMSBoRyI4FW0aiZirN5knXyo7fEwt
    URy4an4/H+1apxELBtIkanktf9OlCMAYSXIFQcScI/nKJVq6/m1D92xuFy4b+Fys4XSt6w
    YF2374j6aRaez5y0ojF+ZmBW+IG0R3yBdyPKnDyT14ReUITDjilxkYEvQRYM//NOaf1JLw
    tIBWK+1g0RvjzwK2lLL8AWN0uT8MiE7UZLjWr/Xz9NL4Dfli6En+qn/X2zlQ
X-ME-Proxy: <xmx:ihNVanhpFyWAtVrQsY4UHCado6Bd8M0jL0qcI8w2EV9rmvyB4B0oqg>
    <xmx:ihNVaq4zu4iUazzXunkw9_kzdCwiArHYjHSeZpcu2PYsWGxG_QihlA>
    <xmx:ihNVakDWHPvEgDGLV6aGjy2UCLktyQViGQ_-O54LrO9z8QY7Ed8fvA>
    <xmx:ihNVahbDl0QaE2Dg4F0vd4T2XTysrbmky8OfbUwjxpUULsksttncog>
    <xmx:ihNVamoW2IAiZfk_tcCvEfEE7Te1ZmWDMN6ftN9MV0DBP_AP8zofxiVA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 12:34:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 12/12] odb: make optimizations pluggable
In-Reply-To: <20260713-b4-pks-odb-optimize-v2-12-9c2c3ee94b38@pks.im> (Patrick
	Steinhardt's message of "Mon, 13 Jul 2026 07:52:15 +0200")
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
	<20260713-b4-pks-odb-optimize-v2-12-9c2c3ee94b38@pks.im>
Date: Mon, 13 Jul 2026 09:34:17 -0700
Message-ID: <xmqqh5m2yhkm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Move `odb_optimize()` and `odb_optimize_required()` from "builtin/gc.c"
> into the "files" source and wire them up via newly introduced vtable
> pointers for the object database sources. This makes the logic pluggable
> and thus allows other backends to have their own, custom implementation.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/gc.c       | 490 +----------------------------------------------------
>  odb.c              |  12 ++
>  odb.h              |  45 +++++
>  odb/source-files.c | 470 ++++++++++++++++++++++++++++++++++++++++++++++++++

Reviewing this commit with "git show --color-moved" is an excellent
way to verify that this is 90% pure code motion.  Only minimal
adjustments were required, such as replacing a direct reference to a
struct member in the original with a variable that was previously
assigned the equivalent value.

For example, this original

> -	switch (opts->strategy) {
> -	case ODB_OPTIMIZE_INCREMENTAL: {
> -		int gc_auto_threshold = 6700;
> -		int gc_auto_pack_limit = 50;
> -
> -		repo_config_get_int(odb->repo, "gc.auto", &gc_auto_threshold);
> -		repo_config_get_int(odb->repo, "gc.autopacklimit", &gc_auto_pack_limit);
> -
> -		/*
> -		 * Setting gc.auto to 0 or negative can disable the
> -		 * automatic gc.
> -		 */

turns into

> +	switch (opts->strategy) {
> +	case ODB_OPTIMIZE_INCREMENTAL: {
> +		int gc_auto_threshold = 6700;
> +		int gc_auto_pack_limit = 50;
> +
> +		repo_config_get_int(repo, "gc.auto", &gc_auto_threshold);
> +		repo_config_get_int(repo, "gc.autopacklimit", &gc_auto_pack_limit);
> +
> +		/*
> +		 * Setting gc.auto to 0 or negative can disable the
> +		 * automatic gc.
> +		 */

And the change from odb->repo vs repo is such an adjustment.

Looking good.
