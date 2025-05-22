Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8D1D5AB5
	for <git@vger.kernel.org>; Thu, 22 May 2025 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747947086; cv=none; b=JIMsuTG3T+Ih+9ByBIwwiR8hdgnfzfSmqVn3+aNLafSMCE+Lz69HcnEdbklvK0qFEy9LvmieflyNZTmIwTwdoHwRaTL54xfThwcOSzCJKZH4isjuXDrQgR4gGLYt6vizej40xeDlu/QZ0Pjk8np80stchuljaaGGdSlNYzMbqao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747947086; c=relaxed/simple;
	bh=ShwnZS7jqSilG9qNnTOUXrnCU+he/vgGitzCr8FQFFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BOSnxmChPsO732Lx8UbKuTAlUKaaxK3qKNofyz4gMvdEiyCfIeXBEAqQnDOBogMIVbNDPkeVZuh3xbkpKN2pB8lXo72A0AYlrVdrGHPDfQBMQJssjGWrYKSAHJsgwctVEkUa7oCG21x+4s6lTzlNNjAHG3pdYE6BbT0uNOXkO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ndky5WGO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IxAFHVbz; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ndky5WGO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IxAFHVbz"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E28CD25400B5;
	Thu, 22 May 2025 16:51:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 22 May 2025 16:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747947082; x=1748033482; bh=G9KNtnDsvk
	e0g+QbtNHqqHAeUDbP84ud1oKHzlwiGHQ=; b=Ndky5WGO90Rt9OhC2xjZQQHF3i
	x7cuDUAW3lvLYwgaizoasi+bnExtkgqX9rQK9Jn08fhE4hBYfbMYxSDAPifAvHe9
	gwcBgPAWTxqWaUH05yyu3ZjpLWhkxkmS2dnCFY5+wwXa27+o60uzYJORxUGzwup/
	pygV022pvhdzO9XBPRFQsDiyKBy10m5fb3ocs3PrY1IamH+cdRgic3xBrrv2LgU/
	NjR3H8ApnrS7/2Y1raCx5tidqXKvyP5ZjcfWDKLjK/oGiyYszOWAHTtZch9KRaAR
	Du9Fft3Z6cyYK+L0AF1L57DIfCeaKvDpmgoKPk3CGqCgpqly4aFSeIFITucQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747947082; x=1748033482; bh=G9KNtnDsvke0g+QbtNHqqHAeUDbP84ud1oK
	HzlwiGHQ=; b=IxAFHVbz5UeocZenadR+T51YMNH2PSEIuwCzJo8JX4KU06Mq1qv
	pqNzxO4J1QJ6GR8HXX/0JJB65kXRykTBhp4uBDq90A9a7jrx/R5bmJueuiegSSxL
	9xjtK32qc/NXdzt1Vvx3/sQxZOaalAm6sLqj2KhHMUqRe1TI0vUMDjk5B8XLh3gA
	jjMC7kEI4jCg1CnvxnqnWzhnBM50pX4RDQx6OUbzs+BjumRIJOWmo5FkvlXaLfPA
	8u8mCLKKjF2yp1piGGVh7eKUsLTLRyP03rFt5lbTfok3OyHhuScNgiJxTm2MNQCA
	Qoqo2sQrnZsrlJpo7j28VjaP+MdpvKUamgQ==
X-ME-Sender: <xms:So4vaHC7xlmnObhuFkKaKpY1RIZ9gvC5eRYgZQ5adzRR4CXvT9UREQ>
    <xme:So4vaNiKOvmSq8PEafzKS5HAMdQHH_op0tCEGPesQCSXDmdvajE6EYwnzRxx47Th7
    BkE6pPFsLI8gH_oiQ>
X-ME-Received: <xmr:So4vaCmGK_0BMgp-EfxqJA2ek9KBlUWEBVR5rhAToJkzeOlOPFfewD_KBpSq-D-AEUVj-YqcaJHPdYHKory9995aXSCuTFW4yg3aqv4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeileejucdltddurdegfedvrddttd
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
X-ME-Proxy: <xmx:So4vaJxhwGa0lmTXXmetlb7o-KzzgC0NjvHZljVAHh-W8HkOj2kbBg>
    <xmx:So4vaMR7rxct3X-zSG6epuEzK0V6JoAbl8tLDWnT4yJjOvWf9vGKtg>
    <xmx:So4vaMZmgFAJOJCzEixN5b0dakCz1ARz7kcaV-mkg6tatYurDDWAfg>
    <xmx:So4vaNQ3J4g4IhoE211J3oATuo-JgORBVTVy4_2wsDx_B8nhQT3Dlg>
    <xmx:So4vaHkAk3r35KUv176d41e09pF5tXB8o8mFL65O6wH4D1_ja2xvQU08>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 16:51:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,    "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 4/5] builtin/stash: provide a way to export stashes
 to a ref
In-Reply-To: <20250522185524.18398-6-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 22 May 2025 18:55:23 +0000")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-1-sandals@crustytoothpaste.net>
	<20250522185524.18398-6-sandals@crustytoothpaste.net>
Date: Thu, 22 May 2025 13:51:20 -0700
Message-ID: <xmqqv7ps4bef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +static int check_stash_topology(struct repository *r, struct commit *stash)
> +{
> +	struct commit *p1, *p2, *p3 = NULL;
> +
> +	/* stash must have two or three parents */
> +	if (!stash->parents || !stash->parents->next ||
> +			(stash->parents->next->next && stash->parents->next->next->next))
> +		return -1;
> +	p1 = stash->parents->item;
> +	p2 = stash->parents->next->item;
> +	if (stash->parents->next->next)
> +		p3 = stash->parents->next->next->item;
> +	if (repo_parse_commit(r, p1) || repo_parse_commit(r, p2) ||
> +			(p3 && repo_parse_commit(r, p3)))
> +		return -1;
> +	/* p2 must have a single parent, p3 must have no parents */
> +	if (!p2->parents || p2->parents->next || (p3 && p3->parents))
> +		return -1;
> +	if (repo_parse_commit(r, p2->parents->item))
> +		return -1;
> +	/* p2^1 must equal p1 */
> +	if (!oideq(&p1->object.oid, &p2->parents->item->object.oid))
> +		return -1;
> +
> +	return 0;
> +}

This is much more elaborate than the existing "does this commit look
like a stash entry" test done elsewhere, isn't it?  Very nicely done.

> +	this = lookup_commit_reference(r, oid);
> +	buffer = repo_get_commit_buffer(r, this, &bufsize);
> +	orig_author = find_commit_header(buffer, "author", &author_len);
> +	orig_committer = find_commit_header(buffer, "committer", &committer_len);
> +
> +	if (!orig_author || !orig_committer) {
> +		ret = error(_("cannot parse commit %s"), oid_to_hex(oid));
> +		goto out;
> +	}
> +
> +	if (split_ident_line(&id, orig_author, author_len) < 0 ||
> +	    split_ident_line(&id, orig_committer, committer_len) < 0) {
> +		ret = error(_("invalid author or committer for %s"), oid_to_hex(oid));
> +		goto out;
> +	}
> +
> +	p = strstr(buffer, "\n\n");
> +	strbuf_addstr(&msg, "git stash: ");
> +
> +	if (p)
> +		strbuf_add(&msg, p + 2, bufsize - (p + 2 - buffer));
> +	strbuf_complete_line(&msg);
> +
> +	author = xmemdupz(orig_author, author_len);
> +	committer = xmemdupz(orig_committer, committer_len);
> +
> +	if (commit_tree_extended(msg.buf, msg.len,
> +				 r->hash_algo->empty_tree, parents,
> +				 out, author, committer,
> +				 NULL, NULL)) {
> +		ret = error(_("could not write commit"));
> +		goto out;
> +	}
> +out:
> +	strbuf_release(&msg);
> +	repo_unuse_commit_buffer(r, this, buffer);
> +	free_commit_list(parents);
> +	free(author);
> +	free(committer);
> +	return ret;
> +}

Nice.

> +	if (argc) {
> +		/*
> +		 * Find each specified stash, and load data into the array.
> +		 */
> +		for (i = 0; i < argc; i++) {
> +			struct object_id oid;
> +			struct commit *stash;
> +
> +			if (parse_stash_revision(&revision, argv[i], 1) ||
> +			    get_oid_with_context(r, revision.buf,
> +						 GET_OID_QUIETLY | GET_OID_GENTLY,
> +						 &oid, &unused)) {
> +				res = error(_("unable to find stash entry %s"), argv[i]);
> +				goto out;
> +			}
> +
> +			stash = lookup_commit_reference(r, &oid);
> +			if (!stash || check_stash_topology(r, stash)) {
> +				res = error(_("%s does not look like a stash commit"),
> +						revision.buf);
> +				goto out;
> +			}
> +			oid_array_append(&items, &oid);
> +		}
> +	} else {
> +		/*
> +		 * Walk the reflog, finding each stash entry, and load data into the
> +		 * array.
> +		 */
> +		struct complete_reflogs *crl = read_complete_reflog("refs/stash");
> +		for (i = 0; i < crl->nr; i++) {
> +			/*
> +			 * Iterate from the latest item in the reflog to the
> +			 * earliest.  crl->items starts from the earliest first.
> +			 */
> +			struct reflog_info *item = crl->items + (crl->nr - i - 1);
> +			struct commit *stash;
> +
> +			stash = lookup_commit_reference(r, &item->noid);
> +			if (!stash || check_stash_topology(r, stash)) {
> +				res = error(_("%s does not look like a stash commit"),
> +						revision.buf);
> +				goto out;
> +			}
> +			oid_array_append(&items, &item->noid);
> +		}
> +		free_complete_reflog(crl);
> +	}

Hmph.  As we work with the commit objects in the above part already,
would it still make sense to use an oid array?  That would force us
to look up the same set of commits using the object names again in
the later loop.  I would have thought we might use commit_list or
something to accumulate commits, and then consume in the loop below.

Not a huge deal, though.  But I somehow find it more natural.  

In addition, we would not have to worry about the ssize_t cast and
other complications if we used commit_list to hold these incoming
stash entries.

