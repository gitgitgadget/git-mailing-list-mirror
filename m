Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1D21E1C3F
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102184; cv=none; b=KYFS2zzUxEXExhsnueQt9+WgIg7gJ50XBtqoRjIBy+vxcKNZCJI9DdM3VjZbJiJeWuOm73/gnTlC9oHEpD6vqhIQZ0JWhZ9+MufeuvBhQv/3l4jZz0gYu/B3w3h7dzU/8Xcd1/Xd3ND2hYxwe+CewPpR4l14CiSSnnrWsdaGFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102184; c=relaxed/simple;
	bh=lT/eq2wTnVCsEryXYDRwJEBYPtYTsBGkA2d5awpweeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hZWU55HU83DV42gjFxh7pdSpnTAlGnzrIgIWk7JK+c/onvinXuHu1IeDGYtbYtn5TuvkD3ULDs6DBDv2JImUsRYBWbUQ3fXj6okV3HrvgPRQ+rHX0zfu0RN0zwBo0hvfuWXnjq7aaMWPPgQjggfVW7hWcMe252Lj/iIALlpzMGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d3xo/9m2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pedt6IVl; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d3xo/9m2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pedt6IVl"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 123E02540122;
	Fri, 13 Dec 2024 10:03:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 13 Dec 2024 10:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734102181; x=1734188581; bh=E+/BOfCodX
	dFRTjeTDO5rrpRM3cv4GcGP11vvwDL5F8=; b=d3xo/9m2Ur2M3jcEf+9o1t87Qc
	IKrO+LfhBXEo67HqpP1EcsqWlVumvJYyDqZMfNdrWXD2UYQezCM5tdBIPh3uz7M2
	cbDiu3BaGv5synUPDiFGC7Oz8aYxb+Z3yufOujD71RuqUoaOrWoZZ1R0Djq9XQfz
	ZvtlrnQOGFQocjv01+Q312kXNFlnPVu0ikk+Pqg6mY+cFfgCBO0GkQ2ScwL1m429
	g9UVaXdXgc5jQ5Zt2VfBCN8ICtI7lIWZgB+/zzglw6PZkZ3em/iRdhUdlg//cOTg
	dx2C66mdQ0b7ja/nJe2CdzHtTp9RjHOLNZQgeKw5/T6izqZ40UIe0o33OyxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734102181; x=1734188581; bh=E+/BOfCodXdFRTjeTDO5rrpRM3cv4GcGP11
	vvwDL5F8=; b=pedt6IVlrTsLRS4SBc4lX3IXej2l0TJw+chq356UluFxgNk59CA
	4KJgrocW3QIaikW3MSMyv6GXDzVOlpzdsWiB90L8xS1RaIRl77opF8ZF4BPGs3zE
	GjSGES2yYCCcZT7uX7vo8hYKgy9QfMM0+MCqIDNDNJsDWFia0Ge1sk/RlKONERw+
	ArzWMKJj/XuCmpgcq6gGFCFlN1sFiGhln9ura/5ju2/jYY041Ty+9uU+cue8uOya
	sAP2i/AtAxzXHX3VXQgMMApe1mn/hMzkDGaEBWQiVZSeNpYD/Tvoz2gt6yziSSZj
	xn8xQ0Maj07tiQeLu5fyYt0yvm2P5xstzRA==
X-ME-Sender: <xms:pUxcZ9YrVAq9IQRPlGmZKT8Esgs9KUtasvTvv8KKBN_VT5kJrEJf8Q>
    <xme:pUxcZ0YKd0oySgh0dvKyWKxFTv0EctctKJwDkStz7eeA7i5lOEI9yNNMrZYnxh3HM
    4oU9GlWBv-4LfuBEA>
X-ME-Received: <xmr:pUxcZ_-b0stiG4LWbh37ZSEeTTk4yVKTtqGWPJzr5AX0UYnPGbIzymBiZCfdQMvo2XR25cctnaMpoVUmqr7hai8HY9TfGtp49lL-ldU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhn
    uggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:pUxcZ7rxyjaerxTvlbll-xEFefRvOaohRc8uxJXsdnSZXocpGFwsGw>
    <xmx:pUxcZ4rMUQkwJPnbhWkEyy9fZJ9hLIoAmH1lvlHDUhHXQwZMKzhP7g>
    <xmx:pUxcZxSvtjF5TPIjNwm57qPOY64Sgfpr1lc7MuWMr_iUAsr12oAT6g>
    <xmx:pUxcZwoVIn19w3gsmKOk18ckh4OgYBXzpCb4pRzoOcdEFhsBeKhncQ>
    <xmx:pUxcZ5cyHBDt0z6PLkXs8ZJ7RTh_5ft9p_txmpDrzxt3tTyMTK2C-veu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 10:03:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Elijah Newren
 <newren@gmail.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] log: --remerge-diff needs to keep around commit parents
In-Reply-To: <pull.1825.v3.git.1733999352289.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Thu, 12 Dec 2024 10:29:12
	+0000")
References: <pull.1825.v2.git.1731350009491.gitgitgadget@gmail.com>
	<pull.1825.v3.git.1733999352289.gitgitgadget@gmail.com>
Date: Fri, 13 Dec 2024 07:02:59 -0800
Message-ID: <xmqq5xnnbp7g.fsf@gitster.g>
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

> This problem is most obvious when traversing the commits in reverse: In
> that instance, if a parent of a merge commit has been shown as part of
> the `git log` command, by the time the merge commit's diff needs to be
> computed, that parent commit's list of parent commits will have been set
> to `NULL` and as a result no merge base will be found (even if one
> should be found).
>
> Traversing commits in reverse is far from the only circumstance in which
> this problem occurs, though. There are many avenues to traversing at
> least one commit in the revision walk that will later be part of a merge
> base computation, for example when not even walking any revisions in
> `git show <merge1> <merge2>` where `<merge1>` is part of the commit
> graph between the parents of `<merge2>`.
>
> Another way to force a scenario where a commit is traversed before it
> has to be traversed again as part of a merge base computation is to
> start with two revisions (where the first one is reachable from the
> second but not in a first-parent ancestry) and show the commit log with
> `--topo-order` and `--first-parent`.
>
> Let's fix this by special-casing the `remerge_diff` mode, similar to
> what we did with reflogs in f35650dff6a4 (log: do not free parents when
> walking reflog, 2017-07-07).

Nicely described.

>     This fixes a bug that is pretty much as old as the remerge-diff
>     machinery itself. I noticed it while writing my reply to Hannes Sixt's
>     concerns about my range-diff --diff-merges=<mode> patch

> diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
> index 07323ebafe0..a68c6bfa036 100755
> --- a/t/t4069-remerge-diff.sh
> +++ b/t/t4069-remerge-diff.sh
> @@ -317,4 +317,11 @@ test_expect_success 'remerge-diff turns off history simplification' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'remerge-diff with --reverse' '
> +	git log -1 --remerge-diff --oneline ab_resolution^ >expect &&
> +	git log -1 --remerge-diff --oneline ab_resolution >>expect &&
> +	git log -2 --remerge-diff --oneline ab_resolution --reverse >actual &&
> +	test_cmp expect actual
> +'
> +

Will queue.  Let me mark it for 'next'.

Thanks.

