Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA75F1FB3
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735328840; cv=none; b=uVb4O119U/ogz6+Myc85tY9ZKy/sqP6Mqu1uoyonZuw7d4O1S0fk1FPuNYFczubAeRfV844ZuHHkeJFC4RaOZUH3o+291qZ2NmsixRomyNQlEZm+SFKKvcWmEuZe6m2aM5bE+K9Bev4VAq9mElpXG9829D3wpffZStKjTNUpcmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735328840; c=relaxed/simple;
	bh=YufnZM6DJwXrwMbaUvS3zRnKm/mt1HX5IEtNJ6l2qBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gDTogo0AjP/SKZxY8GJXBe8pr02qrDV/tq4aV2kVNQnSDPAygG4PocTc706CF+SdDXNx6PXnZkc7OwQsBmfbM2wUzvttwFPv6PbkyFkhkqfyrZi9PKbCT94sBwSDFdcACf+zwsfKWmpe7Mim5qsYZGwuxVHgkvDPv/xNqnoUKvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=t1vutPAG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P9+Ef6nH; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="t1vutPAG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P9+Ef6nH"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C246F13801B5;
	Fri, 27 Dec 2024 14:47:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 27 Dec 2024 14:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735328835; x=1735415235; bh=MHd5W/C4tt
	jBn0eaUGMiUS/CjVmml0BQXHRSOU3RKRY=; b=t1vutPAG0g8vLfHVg8wS/O5Hxk
	p231+e+r23wckGfDA7hQV+Y9t44DRBVRxMHpZvDY5Bk6nru8mETBAHou6Zdd4g8+
	sNhhCoJNYX/s9QEVtIK03W2tWlQfjb2y3vDX0TQVSF7M9oRgViCwIyHZdA8kIkx0
	wXQOM8NEW9Gh3cAHmKQiIuGrySOKexvsUbqbMV8/EX9gtD0A09/ORvJIxnSG518g
	w7xW1q/Lc7JuR/wKgOylfkODN442ih27xXtMUPtmIwqH/qrV4crtpM5EbKqwUm3x
	PHA2txyAcMDxpNOfMLUH7XadorZxOzG8KnXROPDJ4oQegz3PE5UeAGpnp/FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735328835; x=1735415235; bh=MHd5W/C4ttjBn0eaUGMiUS/CjVmml0BQXHR
	SOU3RKRY=; b=P9+Ef6nHeCd5iSmo3aG1S6vVruikI3aQoDdi/rxfLn782Lq8ETR
	SFo/TA1cF4BVfEqgkb71AAfrRlECz5W1OAkXHgYbd6AdPUSqPdrLeGbX4DejULTp
	GjcJ9xmjISjhdBcNtJItMuYalkts+bc7owr9iT4b3W42iyJyc8n/EYmoj9aN0sPo
	yiEYq2LTdyE4F8uYRO72zm0WxbzeHDAy+KpROE5hbbMN648qWnij1+xGWfzyjhmO
	/6NAH4buEnyA5l19kj5HG1fQY7YBccQSWLVTR+qdjJgq3Dv2o27MK/PazZq+szMr
	UwVEAgWsNypJa0PAevDyQsK5xlOjY0+eHew==
X-ME-Sender: <xms:QwRvZ6unsYY1eSD1TIZwiQLRhT-6WyldzdcCpJ4aVFsb5tIHfO5eyg>
    <xme:QwRvZ_ch4hnyua_Al-HmQyQW5z6ComAREOPSypvA8SzXGOZF_Xa08Zns5S2qJtPKu
    dMLb6PaUPHfRLUqWw>
X-ME-Received: <xmr:QwRvZ1y44KjLB3CmI3uR9o_qj1g5E3O4KxlcGzaI0eo-t_3KRJ1V9Kx0Y94-yx3J99CsiizfzvdD9aFL7Zidi2ePeCdRqRaOow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughr
    pefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevuc
    fjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgv
    rhhnpeevhfevkedvvddtudeugffgteefkeeufeejfefgvdekvdevtdekieegffegkeffgf
    enucffohhmrghinhepfihorhguphhrvghsshdrtghomhdpghhithhhuhgsrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsth
    gvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QwRvZ1OTBM99aL41nvbwl7O_oDA-3RqGRQaM4jbi6NWH9Zphu5DzfQ>
    <xmx:QwRvZ68QF0jR9SrAZpYZDd4rntFiW4t6ydFuNhMFZ7GSyGOaFDFZjA>
    <xmx:QwRvZ9XwCQ-nOQ34Kv8y--oXJ_HbX42dba0ULS3XiRqC94FIv7cs3w>
    <xmx:QwRvZzd6lIJp3JKoVh6tH52MCY6_2qPEUZcZs3oIo_6KkLV0Hw0Weg>
    <xmx:QwRvZ-Z48DTGrz_U11dDTcuutUwr24DgfnozaNarfqjn9oggYJfKT-Cy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 14:47:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/9] commit-reach: -Wsign-compare follow-ups
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
	(Patrick Steinhardt's message of "Fri, 27 Dec 2024 11:46:20 +0100")
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
Date: Fri, 27 Dec 2024 11:47:13 -0800
Message-ID: <xmqqbjwwucvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Speaking of -Wsign-compare (cf. [*1*]), we seem to be hitting this
error on linux32 CI job [*2*]:

Error: shallow.c:537:32: comparison of integer expressions of different signedness:
'unsigned int' and 'int' [-Werror=sign-compare]

    537 |  if (!info->pool_count || size > info->end - info->free) {

I didn't dig deeper than this.  After taking three tries to get
'seen' build with linux-meson job (needed merge-fix for ds/backfill
topic, which needed (1) a new built-in hence a new entry in
meson.build, (2) a new test hence a new entry in t/meson.build, and
(3) a new doc hence a new entry in Documentation/meson.build), I am
a bit exhausted right now.

Also breakage of linux-meson job we have at 'master' seems gone,
which probably has to do with your recent update with gitweb thing.

Thanks.


[References]

*1* 

https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/

*2*

https://github.com/git/git/actions/runs/12519901432/job/34924707204#step:6:181
