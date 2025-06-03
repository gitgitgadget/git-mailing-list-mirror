Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFBF213237
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985160; cv=none; b=pPikRczT5rhO0ilzOyEyIYAp1ESPIKUw6yoGzplZ4fkZbHxaYX+TIJHizfc0bwUIjBCas/9Sjb1CGl2uAYTgjQiDwLXpHhyERaKefjQuDBG1Gh4a6vCYEMiLlhHKgSJB/qm1YQFR4G+knSGtkQbXdmN5A4tYkOsNu8lwZomCQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985160; c=relaxed/simple;
	bh=F7hzwso2LqLakC6clv9Yd2hJ6I1euHTWGEW7xFNceaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jOA8Rb4qnig/Va+PyyxbqXO91qNdtw34nYMF7e9y49IF+HtEdC6DPZdQFrjibp8qQ6XGooh7z/YQa/6IlAGokc9a5OWjGZfHhqr+VbdvwyrUYeKUbzIozRiDZINYYjMBTW7rl29ELHTFfUTwUx07hd2m2Kk3l+6lg/VkNL3BXLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SbitesbV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ld24D4XI; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SbitesbV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ld24D4XI"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F398013802B8;
	Tue,  3 Jun 2025 17:12:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 03 Jun 2025 17:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748985156; x=1749071556; bh=dGIEByXXe7
	DCvEfEZcJHCb2Qf65n37/TaS9jDG1rzXw=; b=SbitesbVFBFdt1vVibzt1WJ2Zp
	g1SkRsm+whEjnH6S154BbMxv2Id5nk48f147iQdQ8bpwHsUl0N/cfHPMg8HiLE/R
	o89y1EDHkBw72Y/zR/3EFNdOmQmykxapRk6us8eeLiMZNhlurldo5lsgGkwh5t9h
	kF10fmP7nV4XaypUAYx84M1Iz9XSE3rfd8/l6H2Hdj6yP2J6G8hRJ0Wd5/x+n384
	k1nVgcJO3nSEmBTWGb9qBbh1/RWu4sUMMdcNX+PQzvHMe/TydkA0TX7CAHXk4FNp
	31HwbYT2EqJmhJP47Grf7+/oI0FLL48fIZI4YMeIkrK+Bo9v7GPVqURD4z6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748985156; x=1749071556; bh=dGIEByXXe7DCvEfEZcJHCb2Qf65n37/TaS9
	jDG1rzXw=; b=ld24D4XI2DffctYjdRbk/uDmkowchzB3TexdJaue9/FCtXcQNYO
	bENUqnT4IxT8Y1jWC5IjLmPhumxJHuE70v9IbRMysC99kigmQFHtgUhGNBQWUYNy
	elFnZUDtawK7HO9bl8i7AoxZ90+Y0i65fNLaFNUHaIxqr7uZGAxWqJI20NQf1RX3
	s+0BepAASnjBUpQD6gPZyhNf9HTlkmCCnHGDgY/dAJWf6lBn/ZQMLPJTJEOncx6j
	Vz4gGp2leDe0P0W9ziy2K4t0vlpWoNjLFmgnFqLh4v7D08Wl4HYp5IgirB095hhk
	liVgJ9HdJ4+p+ErHZi+fcmc+XebyqV8dISw==
X-ME-Sender: <xms:RGU_aA92iLG-S0BUiDOZxjysha_w8diaaOlh4sNM3lZyA90Zfu4qlA>
    <xme:RGU_aIva9VCF7FaatfCNpbUShhkN0geXGpj9LAR8oj9Ct_0raSwoZnBwSOEY78oo6
    YYl6YcB5me00UHpOQ>
X-ME-Received: <xmr:RGU_aGBHi1SWuupOcvFEGBxwFgx1-Y4M8wAPo5O2v1uS15H3fKtvsErI5YNXM3BD-dKxLkQUr7PkSENs9qoWkZYq7qlPFNA5fnja>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrvgdrkh
    gvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RGU_aAcQ0XLHaDsI85HyFxsegrvw3YsmUFk70hD_OIYIvNQDilQNjA>
    <xmx:RGU_aFPhIcwJy3RKjAUM_NhkQJaoaWJqQd082SooiSpHjYuayCfERw>
    <xmx:RGU_aKkeSI6QWBTn3fF3N3iZQXq6uE_iQMJt63Nsg0wXraGxktsB0w>
    <xmx:RGU_aHt1qqQHnHDw1pFbALDMc0aEZFQY4ZzbbgA9njqBP5wqsQNLxA>
    <xmx:RGU_aCY_WGt-5KSee897FBTfmiQ1TICSQ3D04KRB73C3nLpLv7g7yC8L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 17:12:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 0/3] diff: add pathspec support to --no-index
In-Reply-To: <20250521232917.2333291-1-jacob.e.keller@intel.com> (Jacob
	Keller's message of "Wed, 21 May 2025 16:29:14 -0700")
References: <20250521232917.2333291-1-jacob.e.keller@intel.com>
Date: Tue, 03 Jun 2025 14:12:35 -0700
Message-ID: <xmqq1ps0il6k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> This series adds support for using pathspecs to limit the comparison when
> using git diff --no-index. This is similar to how you can limit what is
> included with pathspecs when comparing inside a repository.
>
> This version uses only one set of pathspecs and instead uses some logic to
> skip past the root of each directory tree being scanned. This avoids needing
> to parse pathspecs multiple times, and is overall a simpler approach.
>
> I also opted to add a match_leading_pathspec() instead of exposing the
> match_pathspec_with_flags(), since I didn't how DO_MATCH_EXCLUDES wasn't
> exposed. It felt messy.
>
> I tried a couple of different methods for skipping past the leading portion
> of a path, including skip_prefix. Ultimately just the index to skip to
> seemed like the simplest solution. I like that it means we only need a
> single pathspec array now, and that we no longer have to worry about
> changing prefix_path_gently.
>
> Changes since v3:
> * Drop the patch modifying prefix_path(_gently).
> * Instead of exposing the do_match_pathspec flags, create a
>   match_leading_pathspec() variant that sets both flags when is_dir is true.
> * Use some simple logic to skip past the starting portions of each path
>   before calling match_leading_pathspec
> * Re-write the commit message for the final patch
> * Add a couple more test cases
> * Simplify existing test cases to use --name-status
> * Drop remaining TODOs

Anybody, other than Jacob and I, interested in this series?  We
haven't seen any support or review and I am considering merging it
down for the next cycle sometime in coming weeks.

Thanks.
