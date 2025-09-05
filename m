Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB2F221577
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101092; cv=none; b=iOnsPvyfjhfGe87E5TEi6DU3d3Xa3QsbaLLZB4gd8u4S8eNFdnKtrkfCWk14cMkiJ2dTmPM19AGvb/+8W3R0tYwZj35A87gP+tPGpI3K246ok/lKufnOPtGWoNepXeQAzBwcZ6ooI62vo8jL4CrOvKqrzTneHG3EUca2CyZBA9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101092; c=relaxed/simple;
	bh=OK6zG8j1JZtBc7pQm7YdAteNWfE6bKN80QnG4JJfi5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L+4HWGS4swq4kfNiJUQhepAc36Qk6uT+KqZOJRpJOUZEbn+CdfK95bfPsrw96H7i6R6n2MM2E5Q0cc7Kf16ydJeJxXbNd3GUVYOTp+zVjNqYKwA/KYFd/qL0ZrW6gzSo4GZnTco137LvO9EXBUQBDu0+FgDQJE1MqQtr0AyvDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JzeQXqOc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=enZd8Kt2; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JzeQXqOc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="enZd8Kt2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DF980EC02B3;
	Fri,  5 Sep 2025 15:38:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 05 Sep 2025 15:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757101089; x=1757187489; bh=6Wa0RH/YaV
	kkPezhMHASpn9aSr1aNqvK/QPgAJZSu6M=; b=JzeQXqOcOzPyLxNeCh4/AcScDQ
	ApzLJ4s7a5Tg0hD9aZD5liqGqIwkcnv5Q41M6gi9NwN58qCEUOeys5gPldIGZcrF
	QZy81k9i7d74n5252nR06S+sr6IwUMvPXIPxCfofIQDZNiU08p8oJRB+EBlPDBCe
	isatHMd/yH4tMmkjnNVE5Kvbn/4rqbzDQ0HPZ7uoifLta+XBtgF2MYi8V4M3q+er
	On4IEhY8KOYEh8cTjFBrHldCw2ayywgpCnUZegro7tPDWzEraNeYULXc1seuNcNF
	MKftYK6INCmDprStHKTFdCKOv4npa8REZ5Ct9UnlKiemRgrpDZeYGNcqxEJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757101089; x=1757187489; bh=6Wa0RH/YaVkkPezhMHASpn9aSr1aNqvK/QP
	gAJZSu6M=; b=enZd8Kt2BtEIw3aSO5ilh1CAMPIJJ4RHpW4C7f4Wojk7YzBHu//
	xODByNNQPhrJIgi1dIi1LHGXOvFl+ccCBcm4Vx89X4OwbJwfmKsHU4AaZzl87J+H
	132y61BOLtVCV4x5UCe0mdTQxIXp/OSpvTc/t3BOcL/uwtEvBzr0v3SwrE9pAWvT
	69fiNl0auX968ZkaY8AL5wiw9mKKet4rx7vxKyS/KGSacYtehPa5AvXtIf4HHEdV
	e4qva68Ab1+LS1MI7eoyQc9bMsFipcWYEeIsBk1MV1U4O0FA9oc3FDX4hWKdESmw
	hibXZpuuy/fJvhtxdzLcGnGfjqBrFNdZgVw==
X-ME-Sender: <xms:ITy7aElG7KaHeEpbgpdsFakZ56yEN_YguBE2Q5hESzuCAB_zcKggCQ>
    <xme:ITy7aMTdzrvir6Olx1cSlQetAPkXnNe0lylbwx1-YVPPovUw8tzOIQOrRHbMAe5qS
    KhxvJ4tRuARgHMX_g>
X-ME-Received: <xmr:ITy7aDH07x5egPi8eeDGbQcYNGoZImGH1o5wlKUSqVbb59Md2Dg99zKcFMBo9MyHCphatCSp87aAXYdKo6ZYMTd2L1aW7No4LyQbbFI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeljeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ITy7aBHOMMPmdR9G4KUPjm9Bu3saxncPaGbYMsCImNtxL1QJY2QVew>
    <xmx:ITy7aBQixznmgG3lfC3E4m4lbl3sBfESQ_b8W1DBgoqN1NPM_3qViQ>
    <xmx:ITy7aCLx31K0_NbQIUV2YHzwd60542KF9R0Q2rjbSC3L_algK2bRWg>
    <xmx:ITy7aMY7JEJ6RawlXQOg5eMAcozogMojxoHy-jZM56oJqMl4fbKgtw>
    <xmx:ITy7aEKFUTLQ1fB4hlVXhwGR3ZJpXMtU4R08i-f_jCdzrZWP3OMkwYGp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 15:38:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  Patrick Steinhardt <ps@pks.im>,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/6] midx-write: fix segfault and do several cleanups
In-Reply-To: <pull.1965.v3.git.1757100378.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Fri, 05 Sep 2025 19:26:12
	+0000")
References: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
	<pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
Date: Fri, 05 Sep 2025 12:38:08 -0700
Message-ID: <xmqqcy843d27.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I was motivated to start looking closely at midx-write.c due to multiple
> users reporting Git crashes in their background maintenance, specifically
> during git multi-pack-index repack calls. I was eventually able to reproduce
> it in git multi-pack-index expire as well.
>
> Patch 1 is the only change we need to fix this bug. It includes a test case
> that will fail under --stress with SANITIZE=address. It requires creating
> many packfiles (50 was not enough, but 100 is enough). As far as I can tell,
> this bug has existed since Git 2.47.0 in October 2024, but I started hearing
> reports of this from users in July 2025 (and took a while to get a
> dump/repro).
>
> The remaining patches are cleanups based on my careful rereading of
> midx-write.c. There are some issues about error handling that needed some
> cleanup as well as a removal of the DISABLE_SIGN_COMPARE_WARNINGS macro.
>
>
> Updates in V3
> =============
>
>  * Use test_grep over grep.
>  * Translate an error message.
>  * Clarify a commit message.

All incremental changes made sense to me.  Will replace.

Shall we mark the topic ready for 'next' by now?

Thanks.
