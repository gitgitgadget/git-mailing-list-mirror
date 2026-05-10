Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CBE2F8E99
	for <git@vger.kernel.org>; Sun, 10 May 2026 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778457235; cv=none; b=QfN0/lEyGNgt8zRj79jc558jZnvuSr6lqn1Fwi7N/ARg9/uOen0vChliL7/H5na+IafmuWbiFECbiD51f5v0Z2H9SmtDCYKOhp6jlHFKKuosTGdahrG+lbjq2HLlDfnDPgVuGNh+ZnTufAeqJcnSQfWwCRut2Cnb+iY/oSWWCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778457235; c=relaxed/simple;
	bh=eEA7GJzHE86bvg8InAAERit02CBJXalxvqBGu4DLwn8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AvdEWOOd5os4lgTBZMSpFyM+GFIx8N8kSbuQulFGCMzCwN5S3k8xKFqzQmek788XkeIgKq+S2pwIrFsd0889XjuYwOEYm4ogX+OLNDBlIfAKk3Axp/7aYfME1MKfzNtYNdLjkZFirE4TAbNdGzD+SnfvDCjFw5wgCj6dKqR44+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AwCUHjaj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UcZ3PIy3; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AwCUHjaj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UcZ3PIy3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A5EE7EC011D;
	Sun, 10 May 2026 19:53:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 10 May 2026 19:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778457233; x=1778543633; bh=Dme3/5Nzil
	uoQ7rcokYnh2zQnSd6vTiaenwGLDTy8EY=; b=AwCUHjajwX2Fbx7zf0FlVLM04W
	LPFixoxNVSTCSaZgABp4+QH3nkkffg7IidEEUBfxN6AwU75m69gJK0BSR1HvLchj
	lnFA2uOOWPfbPetMi5Gu1Tya54PNyjXnRkJ6ovJYHSf3K0FCxQGMcwQyOlhqo6KP
	LIN3mMqRr4l/5G6TbqnXx6qfdXkQ2pCkgNIfpYgCicj4s38Vuv6w6VjkVistjifv
	0Efc0i9x4v50D+bcHdBbIcVVwgPbchqQz3yiRi3jpLki5irZzfHQO1x4JpXTRAOF
	Z9CQ/xj8kfOBsUKom0WkgF9BZRqQoQsJqHb2q7Rq1IPYHw/8KlRTQSXtNZSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778457233; x=1778543633; bh=Dme3/5NziluoQ7rcokYnh2zQnSd6vTiaenw
	GLDTy8EY=; b=UcZ3PIy3xpASgWtytwonIJZMh6NGhP/NLEhT4zsXPdUyS3H6xay
	IRcrCwU8RP6TUGyTYtlD5p1DWwnhcKLPHzGTnRAoFHUDnIUW3rDvzVb7qRCo2uyi
	fpb79DM1tbbEzK5D6t6D7LrVYF932Ag7/1lnT0da9kx1mKaJ7cfAIn9AMXWyMBbO
	Uc+czswcsqhNV5NM4OUqmqFE3UGeLTWVtx6ZjKZXQqqAwBmbl39aL9GtZyf1RV1F
	VnT1BQlm04YeXRmI8iXBfTvYDyaF51yf4P0XMEw0VYxcWkPu4vVhByhmfZo3Xwq3
	k8Ns2O49ip1ItMINg09vFa5F/FCPPV5B9Tg==
X-ME-Sender: <xms:kRoBasi0TPpuDW5yumru32YieOy12Zk73nIohwavtC66LI0QWyJcWw>
    <xme:kRoBasBpo_j6KIXSOPJD8gIqdxvsJQeQANq-ot9b76uxbtaTX5L-f8zLTYb-KWHIH
    FJ42BTAWD20ymG4v0LLycxjKIwaRpHT8udO_AnIj1rZRGP8knGUFA>
X-ME-Received: <xmr:kRoBapGUgBnPil7vpI6xnyGQ9N5zkzIZcCb6UwWTG1sSYIjr3NasHOOyTN_CO60Q7Q3um7tqV3GP-_jhTR4C_SR9-bPI4tp1HA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjnhdrrghv
    ihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:kRoBasKVBe44uwGguDIx0zsQwH7tV5xgxsycI9zTWyeSvDZahJ5kyA>
    <xmx:kRoBallFBlU5OcvfhMuvdxECVjt5P5dAnRL2XFq3TbgssxLW8Qp6ww>
    <xmx:kRoBasTKm0AgkqpO1cLhBF3hjZeNC8U-ggrstjlxLyIle01C2UwxYg>
    <xmx:kRoBavKAHOc4csq8fSpjqxNFpqO8BSvdAkMRtwNY_ETAxJOmydTOSQ>
    <xmx:kRoBasHB5X9eMZ1oMru-rumrbUpQV1qddEucAXkDnRkGwoSXx2KOPI2B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 19:53:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v3] doc: clarify --follow and log.follow for git log
In-Reply-To: <20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com>
	(Tamir Duberstein's message of "Sun, 10 May 2026 18:31:14 -0400")
References: <20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com>
	<20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com>
Date: Mon, 11 May 2026 08:53:52 +0900
Message-ID: <xmqqik8u95yn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

>  `log.follow`::
>  	If `true`, `git log` will act as if the `--follow` option was used when
> +	a single pathspec is given.  This has the same limitations as
> +	`--follow`, i.e. it cannot be used with multiple pathspecs and does not
> +	work well on non-linear history.  When the pathspec names a directory,
> +	Git does not follow directory renames, but it still uses the same
> +	traversal mode as for file rename following; see `--follow` in
> +	linkgit:git-log[1].  This can be overridden by `--no-follow`.

Saying that the feature does "not work well" on non-lenear history
is like the behaviour of the feature is "undefined" on such a
history.  Quite honestly, when you do not give a single filename,
the behaviour is "undefined", either, so I do not think we want to
say what happens when the pathspec you give matches a directory.
The feature only takes a single filename on a linear history.
Anything else the feature does is "undefined" random behavour.
