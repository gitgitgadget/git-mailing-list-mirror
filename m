Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E01253935
	for <git@vger.kernel.org>; Fri,  9 May 2025 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820456; cv=none; b=BWeu/Em2ahO9VHE7+NdbTyEBQx24uRpMd9oMMPf1qs2MVsDoy+rCuN/fmjkJp0knm8sh6b4I8E6J036gPQODcWAPNXatcRwBeSz9zFWWU+Iu46jp73a9j0gDsDAop+VdAIurOoiQ5HKNpFbTe0c6OyVqCE72a3Ijy0zv6pKCIDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820456; c=relaxed/simple;
	bh=G0m9Y/b1E6EeCtzmubw5Zs+/d4AmSBKB9gO6qEkXokM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=chV6C71Fy174Ip0JLcSk/thg6zZVThZZMj+W4xuWkyeeouNX0NxXy7V4nF55NICioYe4H3x/DgROQqgKNWPQStZWgwrPJle3JOht24ZJt0q4HP6MITyia8EjHgrf1OBz7h7Pee82JH3Nu68FEcsJwEov4LXCfpOgeWVA3i7d3JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WFdFnsDZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pPKgZEeX; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WFdFnsDZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pPKgZEeX"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06BA211400DB;
	Fri,  9 May 2025 15:54:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 09 May 2025 15:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746820454; x=1746906854; bh=mUTA8OFADJ
	5Kb7h2eMGuWhuqSivJaW2R9CSctziiwxQ=; b=WFdFnsDZOEV8CPKozXEZBMiW76
	zKLmRJvTWBKVboQV04cp+e2V3UH15V3/ZVlziSwIfnCIxMKsc9WeN0+MFUx8KKj0
	jl/BrDC0jEdLmNEhNgIDTbVqp/Vd5icYWY6aVSHe7gCdPZ3RKtI9WplwwUEetv/r
	GSXrGnQG4YRpV1FPMg+M3nB4F6gqbdkX7stDAQYSNh8MO+9qD/MIt8CAuXIChSs9
	PVXTgaLVbL72usm41HzPe83+akx5Zlzy9P7Rb7V7K4rlXjAdg1tLFK3Q62+o+IHo
	CbzYfDoo5xt695tSokKi8/wI1GIZFNs5AUSPZ18kASw2XZEal8sPe1puqrIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746820454; x=1746906854; bh=mUTA8OFADJ5Kb7h2eMGuWhuqSivJaW2R9CS
	ctziiwxQ=; b=pPKgZEeX1rfqfX+Ezw0xZTcMpiR4/TA59EtUeDKfJNetBdKHMqU
	qGA4lNwUP25CPzfmU99EiJKNOXMVSFnArphIho9muIcvBll/eIbUzsFL3Rd+GdOn
	Z/LFatuUOpM2SvhPMeR00c+OjNxE178yI42aTqgzMIBuXA62csaKHLyXeMRavo8m
	J8+tR62RY+akhWVdkFPGyxqICeZ0GcR73TTI3qB89rGJOjpSeQINMUFP7TisncrJ
	kdW6pW7VHFE3ZWMe/F8BvGnisPjh0sbBLsml7sSND56lOXf+Vf0Vhj+or4EI+7IL
	n983p7GGVZIRgj2jQeRT1EtBP+P+dymGXww==
X-ME-Sender: <xms:ZV0eaCjJV-Veb5XwgPcYjmSPyLBj7tUKVk0bFGDrNXbwXJO6AlfUEA>
    <xme:ZV0eaDCy8O0TL_A0iMcqq7a7lTFepQZiYGlD1MzU3ztwouwu1WLMifckmqh7rJZez
    Yr-8xIXz8QW5Q7o7g>
X-ME-Received: <xmr:ZV0eaKFWM2u1-fddXG0BF-J87i916CVHlqa1qlSgq1MNbTU_GUAdIQxzGK1_VXieaNL3AiqoO6Csze0t75ogfDXjGffpOsAQjpqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleefheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:ZV0eaLT0_4NYiQK3T5b-VzZQ2P_0hNRESZvTsCIVWPQ_cgMTJE1MJw>
    <xmx:ZV0eaPysCBTPonk4JtU5VCpdhmOIBvfklsMx9ww5yPl4atWm827yxA>
    <xmx:ZV0eaJ6rUtTfXx-9bG8zASyodwJ00iAIdvvOa5qOXuF7DdWvp6ZK8A>
    <xmx:ZV0eaMyXqFkntMe9-UaGKa7O9kosTQGho-MLiVPquiTq-xleXUIG0A>
    <xmx:Zl0eaDEjdYMyDsCtcrEHoc4B2emb63aOpd1fsDKyQDIbZlEhZwyCQoJh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 15:54:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 4/4] builtin/stash: provide a way to import stashes
 from a ref
In-Reply-To: <20250508234458.3665894-5-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 8 May 2025 23:44:57 +0000")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
	<20250508234458.3665894-5-sandals@crustytoothpaste.net>
Date: Fri, 09 May 2025 12:54:12 -0700
Message-ID: <xmqqzfflzhjv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +static int do_import_stash(struct repository *r, const char *rev)
> +{
> +	struct object_id chain;
> +	struct oid_array items = OID_ARRAY_INIT;
> +	int res = 0;
> +	int i;
> +	const char *buffer = NULL;
> +	struct commit *this = NULL;
> +	char *msg = NULL;
> +
> +	if (repo_get_oid(r, rev, &chain))
> +		return error(_("not a valid revision: %s"), rev);
> +
> +	/*
> +	 * Walk the commit history, finding each stash entry, and load data into
> +	 * the array.
> +	 */
> +	for (i = 0;; i++) {
> +		struct object_id tree, oid;
> +		char revision[GIT_MAX_HEXSZ + 1];
> +
> +		oid_to_hex_r(revision, &chain);
> +
> +		if (get_oidf(&tree, "%s:", revision) ||
> +		    !oideq(&tree, r->hash_algo->empty_tree)) {
> +			res = error(_("%s is not a valid exported stash commit"), revision);
> +			goto out;
> +		}
> +		if (get_oidf(&chain, "%s^1", revision) ||
> +		    get_oidf(&oid, "%s^2", revision))
> +			break;

This is to stop at the sentinel commit at the end.  Don't we want to
make sure that it actually has the expected shape of the sentinel?

IOW, how robust do we try to be against being fed a random mergy
commit history (e.g., our 'master') and mistakenly adding nonsense
stash entries as refs/stash@{<n>}?

> +	/*
> +	 * Now, walk each entry, adding it to the stash as a normal stash
> +	 * commit.
> +	 */
> +	for (i = items.nr - 1; i >= 0; i--) {
> +		unsigned long bufsize;
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

Here, we could check "git stash: " string to make sure that it is as
expected in an exported stash we previously made, and abort, just
like the above "cannot parse" case.

> +		repo_unuse_commit_buffer(r, this, buffer);
> +		buffer = NULL;
> +
> +		if (do_store_stash(oid, msg, 1)) {

Should we be making sure that the object named by "oid" does look
like a stash, like what is done in builtin/stash.c:get_stash_info(),
or is assert_stash_like() called from do_store_stash() sufficient?

