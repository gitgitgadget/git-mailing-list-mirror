Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAC8396D1C
	for <git@vger.kernel.org>; Sun,  3 May 2026 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777849191; cv=none; b=YlMthplI0JS7aMuRWzWWTJ+6hThshRtoqo/8eA0tqcu2BlBAUlcX0q1c6+gzQNRmZxEelQegsEx6+IC3GbIeoHQ2F17I1OaPrighw1h9OX/daoDw846Pgodj5GsKXR/TZu2TZwWg72JoF7I32slzJipFRapvz9szxbmSbU2LzZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777849191; c=relaxed/simple;
	bh=HEnqZA0Xsj2H8zwhc9K8zR5SMUNxfdgWO49RCMn0EhE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gWgOjjtX08bODOFqxwWJIPA1zwwXnOYKxL/Jc1NzJMr+BW7vJ1lyXzYA8Y8NfxykHculk5ja0m9/cYWNNer5G0VsQzSsZ1GOACyHcwL+lBcJSXPG/Ze+x90pTaRztxJo30aIuMCOe7wL/dVzR+3S7abPhHARZbbrn120m9O2lsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nB82giVZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KmJZrXYp; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nB82giVZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KmJZrXYp"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5ADEA140008E;
	Sun,  3 May 2026 18:59:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sun, 03 May 2026 18:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777849189; x=1777935589; bh=44rmWn9IIo
	RVuWQQwi2ullfW85IAM07ZDBSV2spWDLw=; b=nB82giVZQ0k6xSX/rwWTbu70kp
	qwgXgRPxKXzAfnWCFtfHYHZZCjOutHXT3p9RdumTn8oiyYyUbtNLTLb3ZZRd+BR/
	ubJzQyv7DnX5pXBoMyknXnyFI/d0TP/h5qR0UMhVQi/boULKN6ST1hYmH3C32k/i
	aOWkpITLalQQ/4dBARyew7GED5hJhci7yGz39IGPpd+40o2Wt46GWWdqsaXTe4DQ
	t+2faPJhOWMPJtrYR8JLKaRWj3T2OnV0fHh5IBoPx0stnbv1mID2E7XqY7PPwgIg
	F77tfZJdHgUiqFyeXQLrnSh+m/Le2C+m7EsL7ZoZDJQcxH41EVHFNCRDTlrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777849189; x=1777935589; bh=44rmWn9IIoRVuWQQwi2ullfW85IAM07ZDBS
	V2spWDLw=; b=KmJZrXYpqU6FVZHP89S/yBP76HHw7SD4JTcBGjhU0NXE5nxN1Kt
	76BOu9b5XMuF2D0cgaeqoGgSJ5c/YUxy37r+a68aiblBrofYn0SsWSysIDwHLtJd
	wjb8EZFXU0VZdjxGKGIpD5nXUL92ydQ05HJSx208OXQBi8zZchLW+iJlvy83kGji
	Dzx/rmkWsot8rp/3VmnSkemQXJtK3KepFOFLGKTYpZD4qoROtb9MBicxtGcKIJy5
	YqP1eeyy+nXJcaPDcwEyoIuOf34fYZhZ0MwuyVWDXHIjZbeFt0bH+/z0SKD5LJVq
	98dcq7z0m8jSBHjGEOjaUb6+B/nhZdFtGBA==
X-ME-Sender: <xms:ZNP3aZHA-nNQI_zlzUyrHqGFYGbI0wd5lztTN_pCbr9zbPIMDDGakA>
    <xme:ZNP3aUvC3EDTnfrqyWBVhWgjsXeOSb57Siv019wiIvy1pugN7S38Q8kd14GKyX7dz
    UR4qXIUzSHWmziO3gpTzja3bbpoueWriECL2FQkVjhVitz0JNcQcQ>
X-ME-Received: <xmr:ZNP3aXY9ophkJT4JjgKUyJ6aodg6gd_EKmzFlD2zKKWsT2GXzroTnLLDmKppYOudRj3yfvH2izA1O1uFhPjr_BB9vVCM4dgP3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeljedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehj
    ohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZNP3ac7OgSKR5SfNHr8JJmTlY71QYzzRf_aE8Icnt46T3K89Oaht4g>
    <xmx:ZNP3aX8s5DPFJ8sRCfFeTpRKumXyn-_8ELlNvNjwPu4Qfl85EQ_Isg>
    <xmx:ZNP3aQZY30zoKb6ClQEm1AVXZNzmfPfOIh9NVmSA09ZmK6uGtVdzXw>
    <xmx:ZNP3aY7BozcUOpY0e7fUd9bigklBIVqWcJgXB6fTQybKbaBPLxBs8g>
    <xmx:ZdP3ac0-8CkF7OZPg835LVUpH0ieT62F2k-Vp4rFxjAs0k-Iuy5t2E4B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 May 2026 18:59:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  johannes.schindelin@gmx.de,  johncai86@gmail.com,  karthik.188@gmail.com,
  kristofferhaugsbakk@fastmail.com,  me@ttaylorr.com,  newren@gmail.com,
  peff@peff.net,  ps@pks.im,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 4/7] backfill: die on incompatible filter options
In-Reply-To: <22db528d0c5e6db71664f071dca97ab218f4ba45.1777731354.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Sat, 02 May 2026
	14:15:51 +0000")
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
	<22db528d0c5e6db71664f071dca97ab218f4ba45.1777731354.git.gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 07:59:47 +0900
Message-ID: <xmqqbjewrtek.fsf@gitster.g>
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
> The 'git backfill' command uses the path-walk API in a critical way: it
> uses the objects output from the command to find the batches of missing
> objects that should be requested from the server. Unlike 'git
> pack-objects', we cannot fall back to another mechanism.
>
> The previous change added the path_walk_filter_compatible() method that
> we can reuse here. Use it during argument validation in cmd_backfill().
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  builtin/backfill.c  | 2 ++
>  t/t5620-backfill.sh | 8 ++++++++
>  2 files changed, 10 insertions(+)

Another topic adds a helper function to check for many incompatible
options and calls it from here.  When I merged this topic, I made an
semi-evil merge to move this call to that function (with necessary
adjustment to the parameter).  Please sanity check the resolution I
made in 'seen'.  Thanks.


> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index d794dd842f..51eaa42169 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -144,6 +144,8 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>  
>  	if (argc > 1)
>  		die(_("unrecognized argument: %s"), argv[1]);
> +	if (!path_walk_filter_compatible(&ctx.revs.filter))
> +		die(_("cannot backfill with these filter options"));
>  
>  	repo_config(repo, git_default_config, NULL);
>  
> diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
> index f3b5e39493..3580e10b9c 100755
> --- a/t/t5620-backfill.sh
> +++ b/t/t5620-backfill.sh
> @@ -15,6 +15,14 @@ test_expect_success 'backfill rejects unexpected arguments' '
>  	test_grep "unrecognized argument: --unexpected-arg" err
>  '
>  
> +test_expect_success 'backfill rejects incompatible filter options' '
> +	test_must_fail git backfill --objects --filter=tree:1 2>err &&
> +	test_grep "cannot backfill with these filter options" err &&
> +
> +	test_must_fail git backfill --objects --filter=blob:limit=10m 2>err &&
> +	test_grep "cannot backfill with these filter options" err
> +'
> +
>  # We create objects in the 'src' repo.
>  test_expect_success 'setup repo for object creation' '
>  	echo "{print \$1}" >print_1.awk &&
