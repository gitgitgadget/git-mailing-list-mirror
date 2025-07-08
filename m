Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AEC23D289
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009635; cv=none; b=HZHdKZbHJBRozY7QUF565q8E9KJUUK581XZaqrUyOCXiP64KsblhNtgmhLawcaZafnkx9GPmf8W52tYdPixkuYOjs6Jq7thmr3fBYTAvxsJvr80hGPh94luKNHNtN+lWdL4C8bnsGWxJUqxr5CjTVaGnZh5mohEPVZj6pLuqnD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009635; c=relaxed/simple;
	bh=0R6sBINYYCEctSj3L//Frb0HrOTKJpuBlGjKFSL04Ds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JgruWKkRyjkvaUkC90J7zTBTGxJWaezbmpwHArJswL/6K5G8C8XieufR8BUU+qUYrBlShsJCNlfEWdCoPF2fm28B76QEkjNNp251ea2quB4HRdCPizzxCLpmPCaAhn8l92HWB4fVru6kKXcwqQZmR8vEgkr/717Wl3h3QVlORSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PN5dj4+4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XbFDVBbI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PN5dj4+4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XbFDVBbI"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 014BE14003BA;
	Tue,  8 Jul 2025 17:20:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 08 Jul 2025 17:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752009629; x=1752096029; bh=BNDY9i94FP
	NNgyyGsaVWSXdvhD7GaulO9uLIkmObX0s=; b=PN5dj4+4OactkVHbCXLwRje8kH
	T9P4Df7L/KjA1jgd/PV+oZLVkoT4Cqc2pqZBM56cucahAVIVzV4l51AREvF4jnJh
	D5gS9cInfBHHx7DbS0aF9CgIe2FaKfXGoRQxjT9AZDRn4/TWm0od0O1N1j9RVwfx
	E8Kz1HO6hVK7lq2HMdwyoFg0WdqllMAmTi1MHI8FrPyZJgUxKOCaVK2jM2Tbjgqi
	HoULcFN8ZktTQjjlyF4cpNJM2OFHKBBu36cZc980hNwlDjGNJF/kLlOCMKD0O2d/
	avrhapTrHK9gTOTfvbWygO/IJQWFnjf6MjEZL4eqztfZlQOlw28vy5v6flmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752009629; x=1752096029; bh=BNDY9i94FPNNgyyGsaVWSXdvhD7GaulO9uL
	IkmObX0s=; b=XbFDVBbIKVKP/tW9W+a9V/8Rku/Wl0LuJnUHU5ZIUlltrYZjaDZ
	9r4j291/HSG4/gpb3gK1f3KvqO949CgRPYJJTvv/LXMgiWevH+pQAdrSRUtUeCzs
	upFN7mQ01NL0YdhzhUUMZwYIFrad/5L8iHOAHFOEMCRGujWPfOR3byM3DBLXPsCm
	0XVvze/Px0hQp4cJZg7+lj/yeR3SJ9aELoGRa0q4cVOligpw23aVnq4Y+0VbbVqI
	s3ryov515XHlNpElqm0RKl6uNR/M9EvqAhBV1vru41MPpNVsOQE0wdlLvnYu6iJw
	iw6HLlrGS6Wx7ynTHB100+WlmhQeB5KPmiw==
X-ME-Sender: <xms:nYttaLH4ffJhd7fL1RUeY-SokZIiLec7M4obXy9gHGVVhKjy1727_g>
    <xme:nYttaD18UNG_dHzMeiLUd2hHxhD9ro8Hg4BZWy9XJp0bvqBLuthuIRc6-O3qM7RnY
    cpHPnVn3CV9hVGhnA>
X-ME-Received: <xmr:nYttaDnewGIF7aCw4DTYLqz8_HLzq2qOGldvdb5_ttlLT9tN8ekO-9FBzjhUqReSwp8lK-nkQ0qb3Wt0OTwKLZ13go0_tg53NnUUN-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nYttaD-RZ9MkrjSUMbYmsF8QptvQqMNxrpilaS6TbXzq2VEImsJJrA>
    <xmx:nYttaIrLp5tWhfp0-2BE_S25MCiRzkPwmrx3uIu34atgvJpglZklUA>
    <xmx:nYttaMntwKwYwLPZDFruYAViCs68fjdGjje7oQ2vprzcaWNCKLGH0g>
    <xmx:nYttaPgVhV4HXEhDOwh12WQS7QnmF1_51Cz-aGo_W4U5juTq163-Jg>
    <xmx:nYttaHU3wcJbhH0So68K0dBcVi3JLF4v0r65dqk2Cc-t3qr1CjHmIW_x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 17:20:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/3] sparse-checkout: add 'clean' command
In-Reply-To: <49418e8ec8a4c3e0ce9c65aa700042b6f3f3f4d7.1751973594.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Tue, 08 Jul 2025
	11:19:52 +0000")
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<49418e8ec8a4c3e0ce9c65aa700042b6f3f3f4d7.1751973594.git.gitgitgadget@gmail.com>
Date: Tue, 08 Jul 2025 14:20:27 -0700
Message-ID: <xmqqa55etm5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> When users change their sparse-checkout definitions to add new
> directories and remove old ones, there may be a few reasons why
> directories no longer in scope remain (ignored or excluded files still
> exist, Windows handles are still open, etc.). When these files still
> exist, the sparse index feature notices that a tracked, but sparse,
> directory still exists on disk and thus the index expands. This causes a
> performance hit _and_ the advice printed isn't very helpful. Using 'git
> clean' isn't enough (generally '-dfx' may be needed) but also this may
> not be sufficient.
>
> Add a new subcommand to 'git sparse-checkout' that removes these
> tracked-but-sparse directories, including any excluded or ignored files

Are excluded files and ignored files form two separate sets, or are
they one and the same?  Do files that users forgot to add (e.g. new
source file that would not match any patterns listed in .gitignore)
and object files left over from the previous compilation (most
likely match *.o in .gitignore) treated the same way for the purpose
of determining if the directory that is no longer in the cone can be
removed?

> underneath. This is the most extreme method for doing this, but it works
> when the sparse-checkout is in cone mode and is expected to rescope
> based on directories, not files.
>
> Be sure to add a --dry-run option so users can predict what will be
> deleted. In general, output the directories that are being removed so
> users can know what was removed.

Hmph.  It would be safer to show not just the directories but which
excluded files are about to be lost, wouldn't it, especially when
the user is trying to play safe and see what potential damage they
are looking at?

Also even though ignored files are "ignored and expendable", nobody
marks their temporary file as "ignored but precious" (yet), so "it
is listed in .gitignore so we can safely remove it" may not be a
safe assumption for us to be making (yet).  Shouldn't we at least be
listing these ignored files in --dry-run output, next to those files
that the user may have forgotten to add?

> Note that untracked directories remain. Further, directories that
> contain staged changes are not deleted. This is a detail that is partly
> hidden by the implementation which relies on collapsing the index to a
> sparse index in-memory and only deleting directories that are listed as
> sparse in the index. If a staged change exists, then that entry is not
> stored as a sparse tree entry and thus remains on-disk until committed
> or reset.

Removing untracked directories is a job for "clean -d", so it makes
sense for this new command not to touch them.  Not losing changes
that have already been added is just a bad as losing new files that
the user forgot to add, so it does make sense not to remove them.

I wonder if we need "-x" and/or "-X" options "clean" has (and
perhaps "-d" that is a no-op, as the whole point of this subcommand
is about removing directories from the working tree) to control its
operation a bit finer-grained way.

> +	for (size_t i = 0; i < repo->index->cache_nr; i++) {
> +		DIR* dir;

The asterisk sticks to the variable, not the type, i.e.

		DIR *dir;

Thanks.
