Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523862727EA
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136158; cv=none; b=SdYq9lQU0ZyQ4KGQAgz0Dehtzc9RYRGtCff1GsKwd1nMWlv70eUtPu/wajD2fwa7FmCg6pGLJEeNcfifMNKHDh4zycu8mqzjWO/83yfnyV38LolhODyWCbp/3zib/m//8nXNdntKn1/3LxfAEiAdJaHCP2HixfKIMJSR3VpkiWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136158; c=relaxed/simple;
	bh=HSybNr+kfz9u56W/oxhUAQiNrutHbEs2fezdScXjqJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XS0T/HD7XqYsvyyK1hRYRLF4TYJN3Ky1Qq71G6kkmrdn9hekOP7DrGpUEM+5fceqDKgwU//ykXTPL4SrF5jtSnYuKaMtFlHMBBL0cf3RnEWqOWEFnuHdw8rVbaqQG3ltZsIelpAwJHHS9JArLBcTmwlp0x82rwKlNK9HeNKOyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iPZHiBpC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mfk3nPxw; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iPZHiBpC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mfk3nPxw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 61F377A017A;
	Mon, 25 Aug 2025 11:35:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 25 Aug 2025 11:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756136155;
	 x=1756222555; bh=Rg0Xz7GH3CZxN7nBPP3WREWWSbWZCnrvhyWOdVNJUig=; b=
	iPZHiBpCaZopvSf8ypEdRorvsLbrxINa4FjUuVowPFrDs9e5oh8uW0knAeZpT2nd
	w0ry9cnlsBuObj7+N7DdCQzKy5/pqoj28k76UlX4FdiHbCXnCRsIWlAoMpiRVQZm
	9Snku5ppoUfo7A8vYkcFEhaI7ZHjyP0FQBKzAIJEHuvBXB3czPbDHgtmP6LB1W7/
	SjTcOZdV5Yf80jsreQ32G+ngLW4bX7rGxnoU2zBbjMMFjrjhRabqYLpv57Roi+SZ
	HeICepFNYHuhnhwd6BXLvYm4FVJBhbS+4RO0Myobe3M5EM/t7J5fgPVMehJ1UTnw
	RZJPUTe47xA+a/It9b5HZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756136155; x=
	1756222555; bh=Rg0Xz7GH3CZxN7nBPP3WREWWSbWZCnrvhyWOdVNJUig=; b=m
	fk3nPxwOxdVT2UE+ZZVWrn6xv7SlYyuUtu874eQnJNlPHOGrVIgFvcoJVoocwEGG
	4EuV+BxmD2AzTUgH0BVU3Z4cIcnHVr+hVHW3i0BDn9GWSrufYYdM0n24aOinExFz
	e8Awfti2Itf351Secl0O5SfOkJBnQ4Od+bHfOh6lNi9ypSFDSV8hPXyWxuCCtr2k
	xMaWGg7nnfnvYoA5qdIFlbFioboTMOc6I0HJpvBVL7WoscF+xQlEqKy0DfpiV9hj
	jOxcPQl86xLngOifcUgPR5h42snj3iB/TDjIR5EDrk9tBuqUPz+8c32bqZyYeNcY
	PeV50T/BcNJkIyQQggBDg==
X-ME-Sender: <xms:24KsaGYhk5bgGJHznygmSdHYtHEJ13wWGvUaCZ5yV6n2486aNHV9Yg>
    <xme:24KsaMrkLL8dq9oXydasMh1UXa5pxCXW--D8J-t_CYN_b26N-vIPp1Dax8I3xBnhN
    7UVcBekGYCaaGmhfQ>
X-ME-Received: <xmr:24KsaKZprbrtklsIhfPsbJvLaLVnbVHIg0QzoTt-2UlykhxFWt1QwqLzeOZ-oa8SAaYnECd0S2D3br6Ew8tHLuwakikD8sZsaD8OXeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshiivggu
    vghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:24KsaESbKgwE5ZWYb8YjDqiQfjn_4v1GH_ALAMhyo59PWA9ZkX8bjA>
    <xmx:24KsaB615Jr-9y6Yx-UBBU5aY4SCD3ecCW7NwkyzGhsepfAruQO8Kw>
    <xmx:24KsaJwbldcHIdclUzZUypn7AYcSVPnmHo_P7hMo4hcJtmBBqOg45A>
    <xmx:24KsaASqSeD578teui-VHzJvgOYE_64fnhnd5_QUO-tLgcX7wfO_ig>
    <xmx:24KsaNR5GXxC_zGAqfPTpmWlOk1zhg02o3L-bjNsdX2QVq66w-s_xXvU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 11:35:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] line-log: avoid unnecessary tree diffs when
 processing merge commits
In-Reply-To: <20250824190644.2573279-2-szeder.dev@gmail.com> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Sun, 24 Aug 2025 21:06:41 +0200")
References: <20250824190644.2573279-1-szeder.dev@gmail.com>
	<20250824190644.2573279-2-szeder.dev@gmail.com>
Date: Mon, 25 Aug 2025 08:35:53 -0700
Message-ID: <xmqqms7ntnvq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> @@ -1209,7 +1202,6 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
>  static int process_ranges_merge_commit(struct rev_info *rev, struct commit *commit,
>  				       struct line_log_data *range)
>  {
> -	struct diff_queue_struct *diffqueues;
>  	struct line_log_data **cand;
>  	struct commit **parents;
>  	struct commit_list *p;
> @@ -1220,20 +1212,19 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
>  	if (nparents > 1 && rev->first_parent_only)
>  		nparents = 1;
>  
> -	ALLOC_ARRAY(diffqueues, nparents);
>  	CALLOC_ARRAY(cand, nparents);
>  	ALLOC_ARRAY(parents, nparents);
>  
>  	p = commit->parents;
>  	for (i = 0; i < nparents; i++) {
> +		struct diff_queue_struct diffqueue = DIFF_QUEUE_INIT;
> +		int changed;
>  		parents[i] = p->item;
>  		p = p->next;
> -		queue_diffs(range, &rev->diffopt, &diffqueues[i], commit, parents[i]);
> -	}
> +		queue_diffs(range, &rev->diffopt, &diffqueue, commit, parents[i]);
>  
> -	for (i = 0; i < nparents; i++) {
> -		int changed;
> -		changed = process_all_files(&cand[i], rev, &diffqueues[i], range);
> +		changed = process_all_files(&cand[i], rev, &diffqueue, range);
> +		diff_queue_clear(&diffqueue);
>  		if (!changed) {
>  			/*
>  			 * This parent can take all the blame, so we

This is surprisingly small change that eliminates quite a lot of
waste.  Nicely done.

> @@ -1267,7 +1258,6 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
>  		free(cand[i]);
>  	}
>  	free(cand);
> -	free_diffqueues(nparents, diffqueues);
>  	return ret;
>  
>  	/* NEEDSWORK evil merge detection stuff */
