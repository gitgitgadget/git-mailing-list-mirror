Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B71A83F9
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242563; cv=none; b=Cc+6BOjWy9VbmeacQP/OomuexD2AywN62KP1VE5iRju7UUO6N6stYGKiY5tucx8SvB7dRvkaPENRonYmvTDQazePlPHEmuPDoBJKV2Tc3xcUgvwY3oCIDVOMkd6aGYZZ4/jSU/GDa7Z1AaUTIe/mHWXzryv7rmtIvO/yk49Dtko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242563; c=relaxed/simple;
	bh=we58/E6Hcgy42Fh9yGg8jJv1j/7si+1EMfiaBMAE9ig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qPQsgHAmjmwguJxgAflLGwvyoXAKsujaf3IjHe3rqSReycVuAv5LiqB8CHB5HPQN77RKZ0JCZyIgTOFrPL9yIhLnD/POC/zYesxrvfVWnD/VEMSV3x914FbY7VW2YQLl5SWtsuWWz5OAouQxqVqlsurPTmS0jBz71vVFzS39GaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L1aXhdq8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nFErRb5t; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L1aXhdq8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nFErRb5t"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65AAF1140216;
	Mon, 21 Apr 2025 09:35:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 21 Apr 2025 09:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745242559; x=1745328959; bh=y0d/3kzzAH
	KulLEJ42m4UEeQIoO/k/F1nCiV/j+GyZU=; b=L1aXhdq88tjxfPbveCozlbSpwu
	aVd9ozBl/hR8T/kKJPtQo1hRTgTVpewJCqwZ6f1HEO0sXT++S0nPNkWR5fu3DylN
	t3cY369+aSbzU0LLDePVOv2NZWlNsVok7r/AwWAVGh212pM3YROlaufSsaCiCAfB
	or+8UQQOWIfCCTr8j1V0jaF2U6O1JYzouYZS+sFPNOG2gOGqEHciGjN5QxwWfI3E
	W3IF78ZXeurQu8i4EvmjXeJi7oWHyx/hlask51qdHtL7l6kBVbyvVGeV1UoY5fFf
	Q7n5e9yeTMAWm05QxLBQlYHG0RmTeTTbI3qGetSndiEEb6n5XSJQoaaB62Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745242559; x=1745328959; bh=y0d/3kzzAHKulLEJ42m4UEeQIoO/k/F1nCi
	V/j+GyZU=; b=nFErRb5tt4qGq0LLNhKrGaw0Pj42J0UXn4IHhCfzO30lY1yeyNy
	bZxxW737f7qpv3fTsnWaTLm7HY4oR0BQZwJiVttfASwURN5M6zC06XE0+pMciwGb
	FoqHPFxCCJoGAbEldDq9xdv4iDkATJdtHKqYZsxEnMLiaLVuf6drF7hI1x991wYT
	q+KGcdNlTNw+wYSO4AQVDqnkUvQ3kb7MWA65cH/Wv38sKKVfvtkVmRJZkjapnXrD
	XMRffV/DHbWqOrMTUBviYtYZBSHXT2OfDqwQLBRZ9s7XqlEzvLDYPE8s9uSySuPG
	Jw+JOdVjm/rYc8bYGlrezrshGj35Z6bxctg==
X-ME-Sender: <xms:v0kGaILpjKyGT92jbWJn1dFhO6wU7aFZfRpjN1kLThk_XJIDlVKuag>
    <xme:v0kGaIJUmFnS1pJWFiFCNVAks9ETmMHmYnMoPsatIgRyn6XFh4HPUVyz0ePFttkMc
    gxLk6DkxKzIucxwUw>
X-ME-Received: <xmr:v0kGaIsfAZ0ppu4la-IDMDW3-liv38yt4xz64EGQApsfgcuXaWdKRCT8k_h3dfoMfJ4lyhmulWW4y5DEtS70FSD9SXMWRklvFsFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvdffhfevleeufedtheelgfejfeegudek
    ueeiveevteevffdvudfhudekhfeifeeknecuffhomhgrihhnpehgihhthhhusgdrsghloh
    hgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtth
    hopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgv
    thesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidr
    uggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:v0kGaFa82L5V7l8dp9b4e-YrcSfekfSXCSAewMEcNiUo-8UjO8yjlg>
    <xmx:v0kGaPY4CWsSfGsZP5qW_rp4TywzoklZlEJlSabCrsYpixHWi2WYIA>
    <xmx:v0kGaBDhyDOZvn-bHwAh6k31lyOROi05oblcEQQHAs-XdM2-B2vw1g>
    <xmx:v0kGaFbFGVSrXUnarOtRQtSrUJVQ_Qvq519P2zBqwP5eTOp3wxHEeQ>
    <xmx:v0kGaDG1jtSjJp2LQKukWsex1ZRyYE-lMZ0LOuh_vMDOe_8US7KRk1jw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 09:35:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/6] Support Windows/ARM64
In-Reply-To: <pull.1904.git.1745239150.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 21 Apr 2025 12:39:04
	+0000")
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
Date: Mon, 21 Apr 2025 06:35:57 -0700
Message-ID: <xmqqcyd57i2q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Git for Windows has started building artifacts for Windows/ARM64 since
> v2.47.1 (November 25th 2024). Now that Windows/ARM64 GitHub Action runners
> are available in public preview
> [https://github.blog/changelog/2025-04-14-windows-arm64-hosted-runners-now-available-in-public-preview/]
> at long last, it is high time to upstream the minimal set of patches to
> build Git on Windows/ARM64 and pass the test suite.
>
> Dennis Ameling (2):
>   bswap.h: add support for built-in bswap functions
>   config.mak.uname: add support for clangarm64
>
> Johannes Schindelin (4):
>   mingw: do not use nedmalloc on Windows/ARM64
>   msvc: do handle builds on Windows/ARM64
>   mingw(arm64): do move the `/etc/git*` location
>   max_tree_depth: lower it for clangarm64 on Windows
>
>  compat/bswap.h   | 14 +++++++++++++-
>  config.mak.uname | 18 ++++++++++++++----
>  environment.c    | 12 ++++++++++++
>  3 files changed, 39 insertions(+), 5 deletions(-)
>
>
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1904%2Fdscho%2Fsupport-clangarm64-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1904/dscho/support-clangarm64-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1904

Will queue.  Thanks for a cleanly structured series.

