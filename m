Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460818FDD8
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391163; cv=none; b=mP+YoK23VMcaHsGF5CpFS6mGnPFDWBM3mqKMUCby92CcxeYcFceXJjGMDAVYO5PxVX1MJjNNK6Sx2orOpCMQFXRDD6uxQm/PmkdYWG/AjCnHw/+XGlc8gSjWkX2u2vbalWLeH+XDGZ2IFXEubKBJC7FWNJ8A0F7LJHH9BeuGfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391163; c=relaxed/simple;
	bh=KIGpfUK2JsFShTOlQ7HtNda5kmlX30uJ+V/tUCQx7PQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jYa7saIxvH4e+BOi9O8SCKFlTz88U6Jd0phBzkRpLSK2BjhkCMf6/lVP4cAUxpQrncwlMbkw4rh6EnBI6Oo1WueJyGxE1YnFOjZ8Gsv5L0V3vsTF3exjrPsjYnAnEPYd7yIoVhqbuZKzCV4nTXgBYzP/BZJEqvd7JaMW+dlP3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q419C5Yu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q419C5Yu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AD38038AD3;
	Tue,  3 Sep 2024 15:19:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KIGpfUK2JsFShTOlQ7HtNda5kmlX30uJ+V/tUC
	Qx7PQ=; b=Q419C5Yu8/g7bKgn+18PeWUUsX3tjwce8QXv/GW2k/uua0lVPBOc4P
	8MhOiKCSULPy6nFvddBBlkDY8B40c3Bl8AqTlGygBUjSJ7dC6ZRYhd6RdxHYbJWY
	z+PGFumo5A0K1sAp0uLLBl70VH8rnWsuef4qFXbIjONJUu9rxlmp8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A365C38AD2;
	Tue,  3 Sep 2024 15:19:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E613338AD1;
	Tue,  3 Sep 2024 15:19:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Kevin Lyles
 <klyles+github@epic.com>
Subject: Re: [PATCH v3 2/2] Mark 'git cat-file' sparse-index compatible
In-Reply-To: <f4d1461b99350151970528e12a92290cb65f7860.1725386044.git.gitgitgadget@gmail.com>
	(Kevin Lyles via GitGitGadget's message of "Tue, 03 Sep 2024 17:54:04
	+0000")
References: <pull.1770.v2.git.git.1725052243.gitgitgadget@gmail.com>
	<pull.1770.v3.git.git.1725386044.gitgitgadget@gmail.com>
	<f4d1461b99350151970528e12a92290cb65f7860.1725386044.git.gitgitgadget@gmail.com>
Date: Tue, 03 Sep 2024 12:19:18 -0700
Message-ID: <xmqqle08ilzd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6B626C50-6A29-11EF-8B9B-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v3 2/2] Mark 'git cat-file' sparse-index compatible

The same comment on the commit title applies here.

> From: Kevin Lyles <klyles+github@epic.com>
>
> This change affects how 'git cat-file' works with the index when

Again, we start by describing the status quo (e.g. "'git cat-file'
always expands a sparse-index to a full index"), explaining why it
is undesirable, and hinting what you want to do about it.

And then give an order to the codebase to "become like so".

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 18fe58d6b8b..1afdfb5cbae 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -1047,6 +1047,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  	if (batch.buffer_output < 0)
>  		batch.buffer_output = batch.all_objects;
>  
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.command_requires_full_index = 0;
> +
>  	/* Return early if we're in batch mode? */
>  	if (batch.enabled) {
>  		if (opt_cw)

How should the correctness of a change line this validated, by the
way?  By following manually all the code paths from this point and
making sure that the access to an element (or size) of the index
that is sparsed out is preceded by a lazy rehydration of a tree that
represents a subhierarchy in the sparse-index?  Addition to end-to-end
tests may increase the test coverage, but I am not sure how to ensure
the coverage is exhaustive.

Thanks.
