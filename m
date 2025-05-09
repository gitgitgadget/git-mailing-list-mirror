Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB561E1DE8
	for <git@vger.kernel.org>; Fri,  9 May 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746808699; cv=none; b=s4o1MLgZZCBu9D532UF8D/EdNLbUzla1CaWPpELwfM/p1YnOCYAGipSb73ND4O4qJaIja4hFOq854V+LyF10vi2D5+pXn5zrVXS29IBonwjFi4B17nCW0/myDRnQ+4vck9Uh0SDJpD+9F88GAjDEz/sva0TihtoZcXhQlRyzfjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746808699; c=relaxed/simple;
	bh=EYbsRMHDBA5FWwD1MCRlTuasfFZXsFb2OOm6sTTN+/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GJUcP4slAgx3thXT5D6MXl3b3JTqL9IOfpmOlOu9fytSGOPOIP4T8cwmb+NOjJpa1bq8UE01wDz9wGOFaV/RPTb80VWJly0b0LAMqlA5D+vBj949UoDm4OubgExUNs5eb2veepTO8MR5gIxwLwgt2POe+Jh4PYKbV11/2bYJ+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fvscBwA7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NjugsbfA; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fvscBwA7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NjugsbfA"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7745F13801AF;
	Fri,  9 May 2025 12:38:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 09 May 2025 12:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746808694; x=1746895094; bh=NLS9W6diLt
	xihXj8CZQ1hfVXUNRPQbPQpVXCsqFr97A=; b=fvscBwA77Y+MXevUdOkyOGprlE
	WzQ1XpPIItaeH9MQOnOCc7L7ob24S6SOCjwYvReGne4LA60h2dhsclUt+OQSIkIz
	yEptyZVczp4qD4zSMiOqGHmUqUDm1sXi2wWo+O+nsAHviawxyT2hD/njy0tLwzyo
	tyqd9ggmP313ekE+4rJFKyYzLpYjVglTDVr0f9bKwXP/apSrTvCEg+bs5OMJk9pW
	AFXPjgkfHFqJUjs5sr0775pBsv+A7zMp9NnJ9CI9KdS2PpMvbLlnkOSy024ZY9HQ
	yFEUZVYzqymZahN7W99L6tVwtsLFBooP+IdGRfsA2m5yk9NfuapNAMv4AcDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746808694; x=1746895094; bh=NLS9W6diLtxihXj8CZQ1hfVXUNRPQbPQpVX
	CsqFr97A=; b=NjugsbfAneHuPJIw7yx688B7Ch/wlBOarbqUOC/sF7f1cE5UomS
	eLATuCTkeOaNkfk4BLJsV/5y3SrCYezaS7b4ZFRpcHC2qvc87zSt8VZRBi0xbdLA
	ktX4vwV3VfXobaxOtgQ1SagKilzTzI8r9gu+ZYq2jELTPVApJqPdOqA+u+cWDTR4
	+AHU7ujz8RhwnGqoHNQMNJqjxYyv687qjPUSH4b0xp2oTKciAghr7/K5wnh5I5Cx
	Xxzad+o8PbKsM4PM3p4iAYj94ni3g8aBnXW7SZbEa95sKvJDhr9gmQft4lWXBepq
	QcnnczxOa6tK4ArAFiPmjbGtvFwP0wnsxfg==
X-ME-Sender: <xms:di8eaHbj2mYijVcsa9dvVc1XcGDkK6xmMqIK-FEwyZ4b0PHs0s8x9Q>
    <xme:di8eaGb5TMDm1GGNNW4u9S0zlRNJEvUQ5wS3IH7W1_qC2W08kl9roB2sDiWklD59m
    2_hJpztAFH5nDp1HQ>
X-ME-Received: <xmr:di8eaJ8sQF6CjtihX3MaSGYBnf7dMPVzyrC-GAA6nLhHTkgS8-P6mjlCZjWHsLcrwzNQGnmO778B9oss_lUw_5x-dvSgMZJ6KxEa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleefuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:di8eaNpF4RKWbQHh77j4XjAhlZZ8mB7ZW9W8Fk1SA3FoVog2GycetA>
    <xmx:di8eaCpe6Buj0UKDJUpwlcd4aobNHIhLED8mRqPNb5sWF42wyNRmAw>
    <xmx:di8eaDRwKGKBj4L7IZ84X3jbxMG8E1TDkZ1cAo_9IEFIEXrSi4newg>
    <xmx:di8eaKoPlBqmBHsbtpWg8UkGqeIcXRvY00T1uTvGTVD9CQZXO3Ypbg>
    <xmx:di8eaL_WzBa6QSsfsr0gqgj44l7Rrj7zt-YO9y-1V32FW2FYvSsZRjl9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 12:38:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 3/4] builtin/stash: provide a way to export stashes
 to a ref
In-Reply-To: <20250508234458.3665894-4-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 8 May 2025 23:44:56 +0000")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250508234458.3665894-4-sandals@crustytoothpaste.net>
Date: Fri, 09 May 2025 09:38:12 -0700
Message-ID: <xmqqr00x20zv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +static int write_commit_with_parents(struct repository *r,
> +				     struct object_id *out,
> +				     const struct object_id *oid,
> +				     struct commit_list *parents)
> +{
> +	size_t author_len, committer_len;
> +	struct commit *this;
> +	const char *orig_author, *orig_committer;
> +	char *author = NULL, *committer = NULL;
> +	const char *buffer;
> +	unsigned long bufsize;
> +	const char *p;
> +	struct strbuf msg = STRBUF_INIT;
> +	int ret = 0;
> +	struct ident_split id;
> +
> +	this = lookup_commit_reference(r, oid);
> +	buffer = repo_get_commit_buffer(r, this, &bufsize);
> +	orig_author = find_commit_header(buffer, "author", &author_len);
> +	orig_committer = find_commit_header(buffer, "committer", &committer_len);
> +	if (split_ident_line(&id, orig_author, author_len) < 0 ||
> +	    split_ident_line(&id, orig_committer, committer_len) < 0) {
> +		ret = error(_("invalid author or committer for %s"), oid_to_hex(oid));
> +		goto out;
> +	}
> +	p = strstr(buffer, "\n\n");
> +
> +	if (!orig_author || !orig_committer || !p) {
> +		ret = error(_("cannot parse commit %s"), oid_to_hex(oid));
> +		goto out;
> +	}

It is too late to check the NULL-ness of orig_author and
orig_committer here.  They have already been used without checking
for their NULL-ness to call split_ident_line() that happily will
dereference its second "const char *line" parameter, so we would
have already segfaulted.

As fsck.c::verify_headers() say, it is not a crime to lack the
"\n\n" after the last header item, if the commit truly lacks any
message.  So '!p' is a bit overly strict, but in practice I do not
think our tools saved a byte by omitting the empty line after the
header even when creating a commit with an empty message for a long
time, so this may be OK.  On the other hand, preparing for a stash
entry a third-party reimplementation prepared would not be too hard
to do here.

	if (!orig_author || !orig_committer) {
		ret = error(_("cannot parse..."));
		goto out;
	}
	if (split_ident_line(...) < 0 ||
	    split_ident_line(...) < 0) {
		ret = error(_("invalid au..."));
		goto out;
	}

	p = strstr(buffer, "\n\n");
	strbuf_addstr(&msg, "git stash: ");

	if (p)
		strbuf_add(&msg, p+2, bufsize - (p + 2 - buffer));
	strbuf_complete_line(&mesg);

or something.

> +	/* Jump to message. */
> +	p += 2;
> +	strbuf_addstr(&msg, "git stash: ");
> +	strbuf_add(&msg, p, bufsize - (p - buffer));

