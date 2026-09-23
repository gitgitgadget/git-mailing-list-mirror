Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3CE2E7162
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167806; cv=none; b=UdR3JA+wRJez+Rj8Sum+92O30XE6nSrwjlpn7S3faGUQLvfQG5AdFrR8qvzaQUYPok1h+ZXsupFk768kqD7niyGdDU0RoJ127reaCZ0idO2InLUJ9zWhlyCJIizb9MpE51rWUPj4YROhnyvVcxRXluQJKn2pJZUa+dCotOtdjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167806; c=relaxed/simple;
	bh=y8u6QcU8HW6lCd7DquS3yXJdwVztVZwKrRhFUvKrALc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgHrSegkkwhXFqiL7jwfoXYSENOGSVDMM2qHk6V7QzHrskGvYziw60R1t6CZDnih+9mXawsWdOBgmEExMFYFJu8EE9uRidNOmMLMAvytZf+4Gps+vdbHeWRGKMzP+suw/fkwdnm/3+lihewTARzgqsaCViWtAjufSKpI7skXLjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZPOcgTxd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MHyX3ilm; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZPOcgTxd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MHyX3ilm"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id A63E81D000D6;
	Wed, 23 Sep 2026 08:50:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 23 Sep 2026 08:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790167803; x=1790254203; bh=gXrUnTenB5
	5hCM0d4mdymQ+TmwqSd6AztT3gy9hGX/M=; b=ZPOcgTxdf6lkweuT3VZ+G2IgPD
	7LdQg0xG+Mr2BgWZDG10n3yUW9yVlp3W1mN8sxzkzTwJYEhvAQVgeHGMeDvIz4qR
	RZfAUX1PzYZI4dm7MmtpyhvqzTSFDvX6WRkvBOUDaNMJS5PHG0EeLGp6Y2ko6dXR
	uyoYMulWOMC4d1F1b7qGcd5cMsCSzGKDqvdyjqfPkHQQFVgci4zRAV/wrE0nNeAg
	oR91SZ5X7AzcTrm0lJ/eJVj9X7QrDLOYp4Ee1blKlf+/mYtH9eS++7akjucyjvdD
	v9Ju03yueqnATAWaLrdVB0DYWR8TKB7gehQ4M99z8S1MXE7ykXABLJRt+x0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790167803; x=1790254203; bh=gXrUnTenB55hCM0d4mdymQ+TmwqSd6AztT3
	gy9hGX/M=; b=MHyX3ilm+JyDZJERzlyPdP7n2RU5o3tdr7sMCTcKwh8ejJzobdD
	IxDpnaNTcz6WA2Mv7N3RWQm18CPiOoK1Jr1GvcXUtwPjWKuYF5ZUfhZpEY/xmhJT
	ypUFSeauZ0BdT35iacOatY4+w9dNRqXYATh+KCBoumKxl0r+a9sxgkFCnqch/Y3X
	1u7mG8jQgNM9Rf5CRhzrqvbIq1cb8jETQ/14Bf0hV64muYXhQW8plaYbju9xNAaN
	XilslQiv4+aNEtKUjdwyLf1Xa6Gcua5xvUz1YMGCnEvol0HI9/GjJZZJgOcrsT2n
	ce1ftzN/571+K71Om/kwWoR7uADBJSYfsDQ==
X-ME-Sender: <xms:-8qzavEL8Q-VzUudcXRjLyqgCjrebXMqnKyraj4GutK9IHCZhZ-wFA>
    <xme:-8qzagDd-VFi0uwO1qZQiBGKWF41GOtHRg2SE7TNDAs8ZsDT7kS-Fvs-S3biPixx5
    geQlxeApIV22ydh3RMFjwHjDhcPowD4fPalrScMDJzDfA54CW4WI_E>
X-ME-Received: <xmr:-8qzaq9ztGgY2ObSnBrMM___UCEkPyrEXQ94L1YzyxSr-t3TGOeA7g>
X-ME-Proxy-Cause: dmFkZTEyP1SvsVL584xrDl8mAI0MvTNAWDDi5nHlposiFvkkPLAbWpqnXco72dz8DVzqqA
    I943PNoThCL7E9JfKWAgHgiT7MF1lzk+PJPadhRYT13ov/Kh53E4qCUVx+XTQV9ywgqfrn
    He5e9205hGx/kFmlKJJlnshKFYbuddIkul2DTf9BZN5kF/Qucy4m3URbmha+E3RWfGjaYb
    yircLfh4RtihlgKEn6Qrp06Y2rTKbxTuPOVRjiJm68F7gzPi4l/c5iujYRkC2SluQ5XQF3
    4LfJK0s1thv7kmIZXEBtA+dCXmrolcshovywYSQPhquQrgDnlsBlDFIAG3cWZEBYOWzqBL
    PMZ3pvXU2TQIhD1ZFsLjkRWf/i7yWWNiRWAqhIiYwUN+LhFHe3WSM6GZc0XlkBQO+gu2PM
    x/MOqEkIRt5FyQ4ugmsRM966Lo4Kkqrl70m4dO8ksdx2IP/p47JLwd/QV4uL5KcV8dMZXT
    ZRfW7AD2pOoIud7nnZITANvyESViPvPHLu3+B//vxGdjyJyCM3Inpw9VPtXP2fjDBtdOcL
    3BoEwgZ0U/Lf0C7YxJOmfGS7zjr+LwaTgO/hukQ89Qi/EP1/v2kuZCTeHKigMw7EOwbIJm
    3olNTjVCztfrsmUbCCujodIWJ/7oKUGEzsblYw2W8t0mZVj3R6JGV49J6haA
X-ME-Proxy: <xmx:-8qzakDrBQDMJL3-i1y-yI_cIUj_FK5G9i7pFR8nlI4F9JnC9RQ1Bg>
    <xmx:-8qzanR5VhlgA1DxPEIGTTP599DxyHGHUMJc6MK8dMTe6awSd2Zhlw>
    <xmx:-8qzajsNEJl5tFpWLDDupZxF6wg6UlWxlHRJO9QY5PrqQIRjIHej8Q>
    <xmx:-8qzar0aJQLjxKpcp5gJ1oF2e8_CfbwfKC_IjJqa31jM3yaGBGDvJw>
    <xmx:-8qzamjqMfybIXHVSq1ElkdADh0dG-dydHi-MnKVoi8NVOxm6xEXTAzP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 08:50:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aac9cb7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Sep 2026 12:49:59 +0000 (UTC)
Date: Wed, 23 Sep 2026 14:49:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Orestis Floros <orestisflo@gmail.com>
Cc: git@vger.kernel.org, Florian Schmidt <flosch@nutanix.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit-reach: parse commits in the given repository
Message-ID: <arPK8phxWv1pNG_m@pks.im>
References: <d3241733-d015-4646-88e0-06e56a04e77b@nutanix.com>
 <20260916134632.1424829-1-orestisflo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916134632.1424829-1-orestisflo@gmail.com>

On Wed, Sep 16, 2026 at 03:46:31PM +0200, Orestis Floros wrote:
> `can_all_from_reach()` and `can_all_from_reach_with_flag()` parse the
> commits they walk in `the_repository`, even though their caller may be
> working in a different repository. `repo_is_descendant_of()` is such a
> caller: it is told which repository to work in, but as soon as
> generation numbers are enabled it hands the commits over to
> `can_all_from_reach()`, which then parses them elsewhere.
> 
> This breaks merging a superproject whose submodule pointer advanced on
> both sides. merge-ort resolves it by calling `repo_in_merge_bases()` on
> the submodule, and with a commit-graph in both the superproject and the
> submodule the merge dies:
> 
>     $ git merge side
>     fatal: invalid commit position. commit-graph is likely corrupt
> 
> `merge_submodule()` looks the submodule commits up in the submodule, so
> walking their ancestry pulls in parents whose commit-graph position was
> recorded while reading the submodule's commit-graph. The walk then
> parses those parents in `the_repository`, where the recorded position
> indexes the superproject's commit-graph instead: `fill_commit_graph_info()`
> dies when the position is out of bounds, and quietly returns another
> commit's date, generation and parents when it is not.
> 
> The latter used to be the only symptom. Before bb5da75d61 (commit: use
> commit graph in `lookup_commit_reference_gently()`, 2026-02-16) the
> initial lookup did not record commit-graph positions, so the walk simply
> failed to find the submodule commits in the superproject:
> 
>     error: Could not read <commit>
>     Failed to merge submodule sub (commits don't follow merge-base)
> 
> Pass the repository into both functions. git-fetch-pack(1) and
> git-upload-pack(1) keep passing `the_repository`.

Thanks for the nice explanation.

> diff --git a/commit-reach.c b/commit-reach.c
> index 5df471a313..3d579d8f7f 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c

I'm always a fan of removing this implicit dependency. Doubly so if it
actually fixes a bug.

> diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
> index a564758f52..afb484b963 100755
> --- a/t/t6437-submodule-merge.sh
> +++ b/t/t6437-submodule-merge.sh
> @@ -517,4 +517,43 @@ test_expect_success 'merging should fail with no merge base' '
>  	)
>  '
>  
> +test_expect_success 'setup for commit-graphs in superproject and submodule' '
> +	git init commit-graph &&
> +	(cd commit-graph &&

I wanted to complain about formatting at first, but I see that you
simply follow the preexisting style in this file. So I guess this is
okay.

I also double-checked that the test indeed catches the bug.

So overall, this looks good to me. Thanks!

Patrick
