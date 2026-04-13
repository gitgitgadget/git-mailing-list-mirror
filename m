Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D436F40D
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102248; cv=none; b=WQ8kdSj+lULCSSVjkrVrzSli7GZqj85l0ceywcDaLRrwkGyNr4hjwnbbSs6P94cS4aTAm8S8eCqGj4M/c5HiCHgmHAALhLremY+C8N2kawtTl85Llp7CzcL8PAKiagJk1rYMZcnJcPxFyzFsG+XnV5DU2lr1cKxDUeCUY3jeS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102248; c=relaxed/simple;
	bh=5R5DHTC5dYl+MBVuWbDmJEja//lHVnjeaxRRxwkx0E8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jG1t3WZAgp6+xlqQ2LDepZM/xnw1iHoaQwOXAk9Z5TlrbwNrSGIt7qwmhdg9OJrnSWXDVGb1EhGj7tND7h4MOCW/9yVGCFinGAjJr9fbgVYfp1BUtTsPk1TugLdSkZhMO4GI+NNFXotBLg9udyxASq0Oz3Kt+0niX+/od1qiq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=z0bwXldJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eWc8zE4O; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="z0bwXldJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eWc8zE4O"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6B6A07A01B1;
	Mon, 13 Apr 2026 13:44:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 13:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776102246; x=1776188646; bh=+bFeJveVa7
	VguKWZ33lH722IO8dHBgsDoB9s1/TfB2E=; b=z0bwXldJus6T/nkJ+n+375It5D
	zGlSTXKWZnZnG56eHHhSvGQ1vzk+ZUBIk7MzCpBDcQO+Of+M6KW440ZxhzCkxW0g
	uwbvd4v8dJ0PAhJqnbq5iDurFGHxbNGPOkZVEetmdv1LbUHGSkgtU4eg12Ma+Z6F
	Yhby/Sm6nz4Gw175PHuI54BpFU7SsUpO/8AxOgPxJx7UTRYzXFvAN5UbeNKmMOJ5
	+oSrsCHUujh8PJpEIOY5wfZDfb5/SK8Rq+0SDN0nmpQEny/OjjZfkd7W4O+3dM9X
	gKKKtUUBtpQ+GUd2K5FxyA++zx3CP+k045LZLbUuRCRxjsofoH3NLwCQXyWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776102246; x=1776188646; bh=+bFeJveVa7VguKWZ33lH722IO8dHBgsDoB9
	s1/TfB2E=; b=eWc8zE4OGC9jNz0x6GR2GTKaE2tF/0/jVQbegYyzHq2MGnQ1ase
	llgf7Xd/x+n81FSXlA5jE+O8wlzWiBAWE34Ya6DTMnnjF93303pF4i86VnClfNTx
	zMFcGbXyRXsQxNVe57NWuCmh8wlzuTubOTFnPCBAXXkiDWIKJJDxZ05eax+p8MYe
	84a4VHdMO3f0bdUvVzLJ0qCO255RHUECNYhBuPUQ3F1WFMHKPSPpOM01UqdqvXI8
	defGbETM2Q+MDFd2c1CwrvlQeM6xDMk3cQ6LhZdVVB/6KMCd4VRotil0aFHD7JD9
	/DLOlX+x7cgPu+h6gf/SJQGQ1hgYPL0fD9Q==
X-ME-Sender: <xms:Zivdacm9IAH8u2Waf-DgKknzdjtblCUTiVhYMSZ8fIrMHLOCt-enOw>
    <xme:ZivdaS0l7otBdJV0x42LrVyex79z50E0WYIDxz4LJQyxUmGMTpqfUD5x5ow8G_oT2
    Ky5oosMJWyxuWI0IivO0NCyp1FUoA30dNLftyksoxoLP9WrZ3VlJQ>
X-ME-Received: <xmr:ZivdafpPMkPIpiL1tjNuCREWvXeOi5RzjIHGxfgb7aXzXqEAqOA4PpNyyJFUzdUmDKSurQ_bmWqmVt3qgxMxlwi40e9btbFd0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejvdekfeevgffgfeefffejleekleeufedthfeugfevueeuhfefleeijedvhfeg
    teenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhrvghlvggrshgvshdrmhgunecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrg
    hnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZivdaXe33i_C9SIctjn6oGvFB7mOhIr7nGf_qUFgHlbFkjH0qAQu1Q>
    <xmx:ZivdaWo9nnvrhq8ijnlqs-woYAZRTbhWkdom-7CBf-dEf1IJfQsR-A>
    <xmx:ZivdaQGw26XIlDnLrmD6YeRqPQvkRhLKZNEXB9w0QvOTOJUs4-TrdA>
    <xmx:ZivdaevpgaXKkIO6g2Ry1F71TQ_tLNapQaqLIi0dM1KuKsKqfiBHIQ>
    <xmx:ZivdadAdVCWNLevHMpCUJZ5ENOKesr8X1NS3LkLHoqr0sa8hGEfdiYfe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 13:44:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] codeql: bump actions/cache from 4 to 5
In-Reply-To: <pull.2086.git.1776097457136.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 13 Apr 2026 16:24:17
	+0000")
References: <pull.2086.git.1776097457136.gitgitgadget@gmail.com>
Date: Mon, 13 Apr 2026 10:44:04 -0700
Message-ID: <xmqq7bqaiwm3.fsf@gitster.g>
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

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Bumps [actions/cache](https://github.com/actions/cache) from 4 to 5.
> - [Release notes](https://github.com/actions/cache/releases)
> - [Changelog](https://github.com/actions/cache/blob/main/RELEASES.md)
> - [Commits](https://github.com/actions/cache/compare/v4...v5)
>
> ---
>     codeql: bump actions/cache from 4 to 5
>     
>     Just a regular GitHub Actions bump
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2086%2Fgit-for-windows%2Fdependabot%2Fgithub_actions%2Factions%2Fcache-5-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2086/git-for-windows/dependabot/github_actions/actions/cache-5-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2086
>
> updated-dependencies:
> - dependency-name: actions/cache
>   dependency-version: '5'
>   dependency-type: direct:production
>   update-type: version-update:semver-major
> ...
>
> Originally-authored-by: dependabot[bot] <support@github.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

You should not need to be reminded on how our log messages should
look like.  Also your sign-off must come before the three-dash line.

Thanks.

>  .github/workflows/coverity.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
> index cfa17d394a..3435baeca2 100644
> --- a/.github/workflows/coverity.yml
> +++ b/.github/workflows/coverity.yml
> @@ -98,7 +98,7 @@ jobs:
>        # A cache miss will add ~30s to create, but a cache hit will save minutes.
>        - name: restore the Coverity Build Tool
>          id: cache
> -        uses: actions/cache/restore@v4
> +        uses: actions/cache/restore@v5
>          with:
>            path: ${{ runner.temp }}/cov-analysis
>            key: cov-build-${{ env.COVERITY_LANGUAGE }}-${{ env.COVERITY_PLATFORM }}-${{ steps.lookup.outputs.hash }}
> @@ -141,7 +141,7 @@ jobs:
>            esac
>        - name: cache the Coverity Build Tool
>          if: steps.cache.outputs.cache-hit != 'true'
> -        uses: actions/cache/save@v4
> +        uses: actions/cache/save@v5
>          with:
>            path: ${{ runner.temp }}/cov-analysis
>            key: cov-build-${{ env.COVERITY_LANGUAGE }}-${{ env.COVERITY_PLATFORM }}-${{ steps.lookup.outputs.hash }}
>
> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
