Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C3D1A2C04
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515119; cv=none; b=NiaBP96GKoV+EdOHmG/AFQoSAuuQhYlpMCi3ynGPKLHjxpaOyzhBvREy3SpD+dIzVEJwKTVeOjuhOFefRSG55dvsD/6BYreawFa5g5n9YMUUHfV6fwaObYJ47VJIEHZfR+j53W4gJEHziNQhxr9QRhmcgDVvdK8HVlZ+UPMMRqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515119; c=relaxed/simple;
	bh=y2PF0HP3l5uD9XI8/ncgSVIim6ihJsRWEYOkFfOwOg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A2FIjiZmojYAcGSdcmTRT5zx3ex+ezdMn7unlHiw2LUOnRHqDnuMWegZCbg82y1i6PsE72janyZSHQMWkw5tYbSRWOtkw53/2UESn6g2C+pUPnrPb6RZY8PKidbewzmUvIqwoUdF5cvoqR0ZAiNpuSyYpd3YDpqlgA3wJtN74/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JDvXZPk7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R+c9DK3R; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JDvXZPk7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R+c9DK3R"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 856CA1D000DB;
	Wed,  6 Aug 2025 17:18:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 06 Aug 2025 17:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754515116;
	 x=1754601516; bh=NAI75FYxjBOVsJ1Fz3ORKMzemH5xG/M5qT8aVE8IVao=; b=
	JDvXZPk7TYMjh3d4zE3a37vPLN5EDYv0dNCRr1IvK2u/wVAo1mui9mpVuDiZaPM2
	O3Njcml99lzI1BZB0mXQsdMtHcX5+tN14ahslzQcBncNio9sOXvc7ABARECqVIw/
	lv14Gtb2INvMTGbvQGjtp2zn9bVIgzf3Tc3Y4znqwAA7RzkqUmi2Jn1d1l97mO18
	rorwDkOylDaf5bs8zskFytgHgurU51kGHrbRvXYekd0uCqYNLqd0P/kLy2k8c8YB
	PfXgIg1tmKSmHq1zTq+1xVPfw/EtTiWhO6sKPGPAqpk9FNMb121/Mf9Xx6UFvbGT
	tTdgcPaaDJ9KrTON5oAu6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754515116; x=
	1754601516; bh=NAI75FYxjBOVsJ1Fz3ORKMzemH5xG/M5qT8aVE8IVao=; b=R
	+c9DK3R2Lltqu7HV6ogE7hzKXoJ4SwcuHzO0sEdO1IZMfBeH6QiXt+4fOq0rNSl3
	E7Ewf/JovsyGiaSI9AaMyPIChW5ZLcL3lB4x09WrtY5BBpVcDVDQBLhSBpdIEDPo
	HxsYiu6yTglWzX2OwpMc57W0xQJOzsu5x89+hl/KnfOppxSbGo6UoY68YxbLvg3p
	CTG9752O2m45LC0YGO+4KWfBBcFG4/y7jDCAZxM1eN8434LvAKkevtEjoWUIjURa
	OJly4nNcl8XL+iPJDm83f2z6W+/gFbFhY8XzdsTCIOjWVu5jnXZ690WNEWNEygP6
	bAAThpDMOnCV+/Jl7YQjw==
X-ME-Sender: <xms:rMaTaGvCJC1IkcNfvG9oxxoxFyOYoIvxpWMWxrE0WQKddVSxJZqK-w>
    <xme:rMaTaGD34LH3ec5Wa3eZotk4uPpYt-FtRIxpTms0Uro1RRP-wA25KiPXj1y1J8JHg
    K_e75Wl2PjkE5k2Ug>
X-ME-Received: <xmr:rMaTaOWhqQDx2DHL-W_rRGS3aMuKETkQlCYKqPjxlHBBzMlgyQ_9tu6m0cLk5zuxrwA-bvY40mYoOUUvu8w_834ZUeHR1eN4My51FNk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeluddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rMaTaEDiCjI2LDSV8dOtyzQ3InVO0Null3U4Q1bDbhGzCvqWIuDZYg>
    <xmx:rMaTaB8jfneQCJ1W1msdWiYKyUgb8D9cKeeUBSSw3rUddQj3IqaulA>
    <xmx:rMaTaLHhwf66IsprVawUyHyvd_h5K_1tykUw-4QZgzpNz4VHYC-M2A>
    <xmx:rMaTaPMEq1EYHuxtjvMIx1G8VctAaRWKg06us7AUWSYP_EQCmP8bdA>
    <xmx:rMaTaO8_m8-fvx8Pr-4KAf8XU6eyFo6Uox06ZuutCsuU7KUUrxqn_7kq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 17:18:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking in git.git (Aug 2025, #02; Mon, 4)
In-Reply-To: <aJO/VhvaH7FgluZA@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Wed,
	6 Aug 2025 22:47:18 +0200")
References: <xmqqectr57ax.fsf@gitster.g> <aJO/VhvaH7FgluZA@szeder.dev>
Date: Wed, 06 Aug 2025 14:18:34 -0700
Message-ID: <xmqqfre4tahh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Before merging please make sure that the topic can be built on its
> own.  Currently all of its commits, including the merge commit the
> topic is based on, fail to build because:
>
>   $ git log --oneline -1
>   fc33fe7eff (HEAD) Merge branch 'ps/reflog-migrate-fixes' into ps/remote-rename-fix
>   $ make
>       CC builtin/reflog.o
>   builtin/reflog.c:7:10: fatal error: object-store.h: No such file or directory
>       7 | #include "object-store.h"
>         |          ^~~~~~~~~~~~~~~~
>   compilation terminated.
>   make: *** [Makefile:2817: builtin/reflog.o] Error 1

The joy of having too many moving parts X-<.

Thanks for catching.

