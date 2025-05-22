Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9445386358
	for <git@vger.kernel.org>; Thu, 22 May 2025 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747948168; cv=none; b=PYgVdxoOzftV9/HnTs5B6tRg4g+QWeHLNooxpeQY7AJj2zQzOcBWWSaHt32aevb2lt9SxLE67L/mIHjzy0PXfZ9IQXAwO8WjB/Dtd3mHdjyd8m+QeVbey/4rKwKxNpg+AAxg8P5e06EzGujg6Ugk1vV3QAdFFPVfwWA05r/JLeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747948168; c=relaxed/simple;
	bh=81kK3X85JrboTM2gKTOqhFqvOSTwj0yFFh0Y8ALGyuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BlopX8svCJPQRbCTAM4JkyXjeOrS87xSpr7SqV67GxII3sVXMeEvbol+ZqPxcuR+Zun1d9nxDap5JPGk2SfTez80PiDdX84te2cC/DUAZsddpLrhQVv+8L9jKQqnZ9AmBoo38m0zmQ7Lq8eBRpY6kniQdfS9Q6Meo3ZhsACmoX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c7rDMvEC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJkuyGH7; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c7rDMvEC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJkuyGH7"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A09F925400A0;
	Thu, 22 May 2025 17:09:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 22 May 2025 17:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747948165; x=1748034565; bh=8oswdBw3e2
	wF3gXXiDNiL/dPXE4lzsHJGcPBbKDFCP8=; b=c7rDMvEC9cP05xt7tH6a79SEm9
	fdBRYRNhDqu7ngGkDLo42mLZNyOXN6fqD32fkMRYiN5+rOAcaXqzSmOUG8B8MK9w
	UqgM/+yCu0ou2zu9GNdJaClMgGm9hft48x5rdZ1WmrbOloZQhXprE1rQP62nAuhK
	fGexQFCareSjXBiBaNVR3S2xcqIwkikLyqx+at2G6rx0XrL+koWM0PO0tP875oqi
	f2NIfz5ilmTH8fmjUkx7Xt1XUJyyccQjB5Mzzhsg0GJxWw15zhGU+cZMCQShXid2
	x6DO0H6dbK0lRO8iUqOJBDqbNu7LCZAdZMZyQeEmvufgYYqPX2mHImx9ruPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747948165; x=1748034565; bh=8oswdBw3e2wF3gXXiDNiL/dPXE4lzsHJGcP
	BbKDFCP8=; b=ZJkuyGH70fJPg2ee4huOiwY3nY6mnMfywALxG1hmEs9EqiUcrT9
	U8v3m8Q36146n8IIIP7AAJJ/DN2Ho99Cb/iD5aumeR5g5gQupVpuwr63xCoKzHdS
	PVB8fjHXhyHMp+3t3p+tBlCpuZY2O/cCiec/oWHX5wTwsSzqHao0naclvmelIqVf
	gcvok0zlVR8RQygAPU9dbiTrHSSziYcin4PrCgdebi+B3J/1sPp486WkETt/4uog
	jnj4qE7G6xSKn4SVj3wqzccMTEP4bILa1pHnQbC05rSYpzW5cVgcni1OMJH0FnFP
	cbfVoYvDkxnHVUNXaC5bOlBcvUC4UGa9Gcw==
X-ME-Sender: <xms:hZIvaNyqLrEKUOMu47fi8corRS-OUoQ_pQYT2W9BC3OxB3pXM2xLcA>
    <xme:hZIvaNSDJvFg9RKQg4ZLni5dCGd6clhSY85li10IQMDK_V1e4qSSAlpwUy8oe67E-
    nj1NplRiJ2NF8GmPA>
X-ME-Received: <xmr:hZIvaHXxpp6GE8Fgtl8bO5xf_uj6v8lctN-91yvykOsLWu0eu5pyFcodPN8zPGiyq7HoAo5Vr2cExcjJ5frmAZjC_3i-CzxzZige0aI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejtdduucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:hZIvaPhYw9y0K8I_H3KVqp7x-5YGGx_VN9B0V13xjlXQv21_gwasvQ>
    <xmx:hZIvaPB1_9FK4W0kQB_O1aJTWoTUhJmctW67w4UNObs5vN_biugNxA>
    <xmx:hZIvaIJz4UdMHQkVRBrdJ-SvvD4vYg75GwmUopGPFbPrh4A-VB_Wdw>
    <xmx:hZIvaOCLOtPRk9WGUg7vIRmXHuVrIIGX28D35PIVtm0huZiODKJmiQ>
    <xmx:hZIvaGXQWuNJYgxZ9GtYGJEhWZHBJtIp-QB8TT9Rr-l-kQVks6L4v5xb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 17:09:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 5/5] builtin/stash: provide a way to import stashes
 from a ref
In-Reply-To: <20250522185524.18398-7-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 22 May 2025 18:55:24 +0000")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-7-sandals@crustytoothpaste.net>
Date: Thu, 22 May 2025 14:09:23 -0700
Message-ID: <xmqqcyc04akc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We don't clear the stash first and instead add the specified stashes to
> the top of the stash.  This is because users may want to export just a
> few stashes, such as to share a small amount of work in progress with a
> colleague, and it would be undesirable for the receiving user to lose
> all of their data.  For users who do want to replace the stash, it's
> easy to do to: simply run "git stash clear" first.

Very sensible.

> +static int do_import_stash(struct repository *r, const char *rev)
> +{
> +	struct object_id chain;
> +	struct oid_array items = OID_ARRAY_INIT;
> +	int res = 0;
> +	ssize_t i;
> +	const char *buffer = NULL;
> +	unsigned long bufsize;
> +	struct commit *this = NULL;
> +	char *msg = NULL;
> +
> +	if (repo_get_oid(r, rev, &chain))
> +		return error(_("not a valid revision: %s"), rev);
> +
> +	this = lookup_commit_reference(r, &chain);
> +	if (!this)
> +		return error(_("not a commit: %s"), rev);
> +
> +	/*
> +	 * Walk the commit history, finding each stash entry, and load data into
> +	 * the array.
> +	 */
> +	for (;;) {
> +		const char *author, *committer;
> +		size_t author_len, committer_len;
> +		const char *p;
> +		const char *expected = "git stash <git@stash> 1000684800 +0000";

Makes me wonder if we can somehow share this with [4/5] where we
establish the author and committer ident (timestamp spelled in a
different form).  Three strings that has to stay in sync is not a
huge deal, though.

> +		const char *prefix = "git stash: ";
> +		struct commit *stash;
> +		struct tree *tree = repo_get_commit_tree(r, this);
> +
> +		if (!tree ||
> +		    !oideq(&tree->object.oid, r->hash_algo->empty_tree) ||
> +		    (this->parents &&
> +		     (!this->parents->next || this->parents->next->next))) {
> +			res = error(_("%s is not a valid exported stash commit"),
> +					oid_to_hex(&this->object.oid));
> +			goto out;
> +		}

OK.  "buffer" is initialized to NULL before entering this loop, and
cleared to NULL at the end of this loop when "this" is moved, so
jumping to "out:" would not confuse the call to unuse_buffer().

> +		buffer = repo_get_commit_buffer(r, this, &bufsize);

And "buffer" becomes non-NULL and holds data associated with "this";
any "goto out" in the error path would do the right thing.  Very
nicely designed loop.

> +		if (!this->parents) {
> +			/*
> +			 * We don't have any parents.  Make sure this is our
> +			 * root commit.
> +			 */
> +			author = find_commit_header(buffer, "author", &author_len);
> +			committer = find_commit_header(buffer, "committer", &committer_len);
> +
> +			if (!author || !committer) {
> +				error(_("cannot parse commit %s"), oid_to_hex(&this->object.oid));
> +				goto out;
> +			}
> +
> +			if (author_len != strlen(expected) ||
> +			    committer_len != strlen(expected) ||
> +			    memcmp(author, expected, author_len) ||
> +			    memcmp(committer, expected, committer_len)) {
> +				res = error(_("found root commit %s with invalid data"), oid_to_hex(&this->object.oid));
> +				goto out;
> +			}
> +			break;
> +		}

OK.

> +		p = strstr(buffer, "\n\n");
> +		if (!p) {
> +			res = error(_("cannot parse commit %s"), oid_to_hex(&this->object.oid));
> +			goto out;
> +		}
> +
> +		p += 2;
> +		if (((size_t)(bufsize - (p - buffer)) < strlen(prefix)) ||
> +		    memcmp(prefix, p, strlen(prefix))) {
> +			res = error(_("found stash commit %s with unexpected prefix"), oid_to_hex(&this->object.oid));
> +			goto out;
> +		}

I'd call that "without expected prefix" (the difference being "we
expected 'git stash:' prefix but you have 'git stosh:' prefix" vs
"your commit title is 'hello world'"), but OK.  The important thing
is that we are being careful not to get confused.

It is unfortunate historical practice to measure almost everything
in "unsigned long" and bufsize here is one of them, but do we need
that cast?  We know strlen(prefix) is a small known constant
integer, we know p is not smaller than buffer, we know (p-buffer) is
not larger than bufsize.

> +		stash = this->parents->next->item;
> +
> +		if (repo_parse_commit(r, this->parents->item) ||
> +		    repo_parse_commit(r, stash)) {
> +			res = error(_("cannot parse parents of commit: %s"),
> +					oid_to_hex(&this->object.oid));
> +			goto out;
> +		}
> +
> +		if (check_stash_topology(r, stash)) {
> +			res = error(_("%s does not look like a stash commit"),
> +					oid_to_hex(&stash->object.oid));
> +			goto out;
> +		}
> +
> +		repo_unuse_commit_buffer(r, this, buffer);
> +		buffer = NULL;
> +		oid_array_append(&items, &stash->object.oid);
> +		this = this->parents->item;
> +	}
> +
> +	/*
> +	 * Now, walk each entry, adding it to the stash as a normal stash
> +	 * commit.
> +	 */
> +	for (i = (ssize_t)items.nr - 1; i >= 0; i--) {
> +		const char *p;
> +		const struct object_id *oid = items.oid + i;
> +
> +		this = lookup_commit_reference(r, oid);
> +		buffer = repo_get_commit_buffer(r, this, &bufsize);
> +		if (!buffer) {
> +			res = error(_("cannot read commit buffer for %s"), oid_to_hex(oid));
> +			goto out;
> +		}
> +
> +		p = strstr(buffer, "\n\n");
> +		if (!p) {
> +			res = error(_("cannot parse commit %s"), oid_to_hex(oid));
> +			goto out;
> +		}
> +
> +		p += 2;
> +		msg = xmemdupz(p, bufsize - (p - buffer));
> +		repo_unuse_commit_buffer(r, this, buffer);
> +		buffer = NULL;
> +
> +		if (do_store_stash(oid, msg, 1)) {
> +			res = error(_("cannot save the stash for %s"), oid_to_hex(oid));
> +			goto out;
> +		}
> +		FREE_AND_NULL(msg);
> +	}
> +out:
> +	if (this && buffer)
> +		repo_unuse_commit_buffer(r, this, buffer);
> +	oid_array_clear(&items);
> +	free(msg);
> +
> +	return res;
> +}

OK.  Again, I suspect that commit_list may be a more natural thing
to use to accumulate the stash entries, but that is not a huge deal.
