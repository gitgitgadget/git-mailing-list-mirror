Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1301990C5
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960884; cv=none; b=EvoxTKv3k/kXA9MP+Ra5Z8CnFUkrX24V3VwlEdr3+HvOIC6uxH5yeqbVjb5f3+/dsb8NB1qMAqHUAdiL9SAMy+H60FZLZrcz67Nrzyly0mKWrqHg5VWzYe70sSZjbiNU9DtieHmSNEr3jbLAA0b2YM3UXZr7OMoNUTUI1knJdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960884; c=relaxed/simple;
	bh=QpimQAV6T72lj9y83AD6tzatRyVoWonJIcyB4Q0gIU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eEipa4Qn6/HJV0gvlAVvDG1BYY5YENcOhbUYySeVDfxzB77/8rWLi5V0yuwSat9oKJ/YsD1ZoRcssraFQ6n8fKeJouTsxY1+q+4jWacRK4GOwsq7tPmcErRsuy8xSsK8HqbgeM/o1EXYsj+WblHwZ2Wx79BFicplJVylJoA1Xfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RHWcaFgr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kEZl9H9F; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RHWcaFgr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kEZl9H9F"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D776B1140194;
	Wed, 15 Jan 2025 12:08:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 15 Jan 2025 12:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736960880; x=1737047280; bh=Fyc/G3TIM6
	j+OwUUlp0zlCjxgQNHd648Xi4NgaNioDQ=; b=RHWcaFgrkORoGgwfVIqUlH8z2b
	CiR3xgLm6zd6vSZ6VbdUyBh/S2XJF+RY8e0mX1xNhCV8yDngCIQhfya0SxQBs291
	hW03mNh3Ob98lgy/oHs3pR+RD/5C3GugWphjQTIvaqPb0h1bOcH9/jvxfd+5tjUZ
	CCnrh+pxLL8pPSdOCI6WqIeJRRqECLeq3wyaH962LM8oPqt0MguKW2N4dfC5W2X6
	CgpIp9awA8+8C2+NLdZTlwBzyZqJhqCmtd95tt0Eu0Zn4ztAGfO8LMW7DsI3aA71
	ROypTuYKQ5h9FSeaRArh7dlbo80Zjb5XpvhAwliRS0rQ497WU9sSHt/Oq9nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736960880; x=1737047280; bh=Fyc/G3TIM6j+OwUUlp0zlCjxgQNHd648Xi4
	NgaNioDQ=; b=kEZl9H9F5bQHIiOe/ezFnjsyNsGZGgo91WpvyAsjxjDgQ0JbROy
	nqeiovTIqTnvuHWF5MWLo8fJkvyI6RnvTfstzBDRkLGHiR7ihkLN+lVQC1LBzUgB
	eIR1BOfwU+hxhtTNZg/3POW0GvZ2vHBliAcB++FBDDy9HeJHavPxALxoKylaZpVv
	rjqRBnFxO4cAaPPkLMvSWJgwQYI6LQyn9JMQOmourXIk6lRZmX/Zk2i/9HXDqVDP
	f4g6sWGdvwJp7aOIiVotR6VVWnmxcV7nbCjIZNBimNeE4IudscGcfD5KT5JSDpkF
	urNUwzS1JjxiKidmKJDGpGngtsmPW7jC23Q==
X-ME-Sender: <xms:cOuHZ9CuihJSHuIZmN3Sxq7XPZbgJ2XOUFZg-i3DUpyvReV6aJ82fg>
    <xme:cOuHZ7hq0U0JsAyiQiZEQBmQ9VVPeehJvnwbVacShS0O_D23hFWBEXTCz_PyL9iIy
    rIyAzJs9Gkvt_TJaw>
X-ME-Received: <xmr:cOuHZ4kYDDGycKxLRESqF8LGJDnI2z1dR7e83FvOzBibppuwn5z6W0LxApte-lPM6rUXUtG0DT14mnZ_xsEb7rQK_H0ehWC5x5kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthiht
    ohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cOuHZ3z0YHFOvdhJGuyM_wkZa48bQQOAsJyuxyHhpBAJJKVsPecXwQ>
    <xmx:cOuHZyRFg4hOxx2noQoCi41W2fYOGv5wVkzpbGWdBrEO5ekFDBTy2w>
    <xmx:cOuHZ6ZkGYZRBmRYFCUPBnlQNwABrXmHu4jsEVack8YBg0W6xmyEbg>
    <xmx:cOuHZzSQ4hgelu5DURydg3AUNHKb_PkJ48YU1YzEqv5eX5nJjTjPSg>
    <xmx:cOuHZ_L86g7oJBiPhFl-beJZVf-eU8fiy0MTwrxoLxZb8xUnO8noriSl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 12:08:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: Bug in 2.48 with `git refs migrate`
In-Reply-To: <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 15 Jan 2025 11:54:51 +0000")
References: <Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net>
	<CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
Date: Wed, 15 Jan 2025 09:07:58 -0800
Message-ID: <xmqqa5bsypht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Subject: [PATCH] reftable: write correct max_update_index to header
>
> In 297c09eabb (refs: allow multiple reflog entries for the same refname,
> 2024-12-16), the reftable backend learned to handle multiple reflog
> entries within the same transaction. This was done modifying the

"done" -> "done by", I think.

> To fix the issue, the appropriate `max_update_index` limit must be set
> even before the first block is written. Add a `max_index` field to the
> transaction which holds the `max_index` within all its updates, then
> propagate this value to the reftable backend, wherein this is used to
> the set the `max_update_index` correctly.


> diff --git a/refs.c b/refs.c
> index 0f41b2fd4a..f7b6f0f897 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1345,6 +1345,13 @@ int ref_transaction_update_reflog(struct

Not the focus of this topic/fix, but I notice that the only caller
of this ref_transaction_update_reflog() function is a static
function migrate_one_reflog_entry() in the same file.  Do we expect
that we would add more callers?  Otherwise we should make it a file
scope static and remove it from <refs.h> file.

> ref_transaction *transaction,
>  	update->flags &= ~REF_HAVE_OLD;
>  	update->index = index;
>
> +	/*
> +	 * Reference backends may need to know the max index to optimize
> +	 * their writes. So we store the max_index on the transaction level.
> +	 */
> +	if (index > transaction->max_index)
> +		transaction->max_index = index;
> +
>  	return 0;
>  }

So from the problem description, whenever we consume an index by
assigning it to an update that belongs to a transaction, we must
make sure that transaction's max_index covers that value of the
index?  I was wondering if we should have a less error prone way to
do that by having a helper function that takes ref_update and
ref_transaction objects to do the above, but this is exclusively
used by reflog migration code path and nowhere else, so it may
probably be fine as-is.  I dunno.
