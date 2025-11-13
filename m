Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006730AAB3
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051346; cv=none; b=YBULEa+ptU7Zc8sjg2pOofTKHVBjEwnGF426cNdoVyitUOhk5WQdnoQ1qGOdNR/41V4Nkd/NmAck3MHNWB3yU1JMlqz1TGgyoxmjK0XEulHsHGIoxk94T/LGFIvY1c4aYSOykIR+diF+yafGNa9mhhFawSHj2f2ImHLSoWmcXVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051346; c=relaxed/simple;
	bh=puHk/W654vnPCkN1nMZTjXGvIpq0iObt5bbDSKEwqu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o6TPLFlyPYgOX3cjr9lnzJvgI3SeTNXFUru2XJ8KIisNevyc0kSxyOE4bCjV5t/0G37iPK/4R6IbAsRFI8a5a4qxutdx//yl/CjjLmMUXgcZIsruFbXPALrvksodFxY95ZvPKSx+HqBzdusmj+Pu+9MqIBw2tuomcVg5b0Q2Wtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UCU9Zenf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=apsndEHT; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UCU9Zenf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="apsndEHT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD0657A01B5;
	Thu, 13 Nov 2025 11:29:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 13 Nov 2025 11:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763051342; x=1763137742; bh=z1uD6MuARG
	2O33UCqsWzPW7FnNQYq3zd1RKPEv6REfk=; b=UCU9ZenfgqnA+7m96vW42Q/t0c
	p/EPWn4Z1mnXoj8txrEdRhgYf+hFGBR5V083mvHYeS31YOiRywO4NQdOBqp3Bfar
	zXHJ9NR4zyYTNvT80HJ3QqAywUJ4/HJwziCeXSzkOrqu8sDG86IKgnpkHYQJwxhh
	Qbu0FTWAnOTzL5toXF2xXmmY36bUhTaqm9rTGYDdY7EI8eKxQuhdJ+mOJn4XZQIj
	6MRJisHxk+6CEFkuyACEhInLr/IaYsxlM5kRc67AqCtiWWSZ7GMC+t4vQlTMxKfx
	Z09Y9kiLMMKEn5F5E3lMCZ7YdQjvOkSHq6uaC5m5qljIISSLF+GAOHPvItJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763051342; x=1763137742; bh=z1uD6MuARG2O33UCqsWzPW7FnNQYq3zd1RK
	PEv6REfk=; b=apsndEHTZZFvtZZzhT6GS8q6T+OQe7VVKWVjnPHQNJPzWqrkgDe
	cvCuGL3Y4jBIYSE+DnP00+3g78rv1ty0bTXJfboOxITlw8Q+jnFuZnccfhbODexp
	12Cul95Y3pr/zBHFUzq79cFfpFEZB8WRAGE5dwN4YUJj129c5cH6xOLupy4lnJTL
	0GIrg5SSRuqaAoOhe6JGsxoptLLwg1BccuaQp2M56jtZLyzwHFO4vnhJn6UHZEJy
	hPnaToUM70Ke1kfVf5g7X1aDjwL27s8N2tZr7a6qC6ENbC7WxnL3yJ8HmyZ+21n6
	VcxtZBUemGGCyzBNVryDkDKCvEtNA+j5J6Q==
X-ME-Sender: <xms:TgcWaVAyNEbRIcOE0DLEZHcIDidoZoLnnbPhK33iHCsip3gQPBmp6w>
    <xme:TgcWaXONnoKj9LeVoM3q9i5C_zkk6VoDZMBfPmIGX9WJ-41uJBY5Qe_kGTM7W6As8
    giQmJgK6y_3yq_0p7R4Jifm5x_lOJEdB-Ye8LtnwTzq_Knn9vA-q8k>
X-ME-Received: <xmr:TgcWaabmXnmhBh_KTU0G7woOzL9kkunpRHqS-IvxYwI5_LmtR3b6658HMfGzSbD1uKQk1c6gFqMZWWxOD1yJ-u0fDMbcbsK3L4v4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhifihhltghkse
    hsuhhsvgdrtghomhdprhgtphhtthhopegrughrihgrnhesshhushgvrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TgcWaWvIlmkw1YxwiVbZQIDlqdaaKRJsVa-vf12H8wwZgCK1sEoWXw>
    <xmx:TgcWacNGXWB4vJpSdWon9fud-IpSXZm6Iub0YOeZ0RJWaEeC1oNmug>
    <xmx:TgcWad5xProxT5hRT7EJnTwNDCFHcotKYQZHRmcmCWmKmh8ZrHxNZw>
    <xmx:TgcWaSRmlPHKUvMcwnsXj1DMBiHuhrIDqP7F_oqyOwQFzlxyBLjLyA>
    <xmx:TgcWaUoZD4k94KN4KIFlpkauN9jmkZXHdoBc-kqdsOvpKq_XYXHLqHRP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 11:29:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Martin Wilck <mwilck@suse.com>,  Adrian Schroeter <adrian@suse.com>
Subject: Re: [PATCH] object-file: disallow adding submodules of different
 hash algo
In-Reply-To: <20251113035614.GA1758009@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 12 Nov 2025 22:56:14 -0500")
References: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
	<20251112235434.1499699-1-sandals@crustytoothpaste.net>
	<20251113032619.GA1739649@coredump.intra.peff.net>
	<20251113035614.GA1758009@coredump.intra.peff.net>
Date: Thu, 13 Nov 2025 08:29:00 -0800
Message-ID: <xmqqjyztq4kz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So this is what I'd propose on top of your patch. I can hold onto it for
> later if we don't want to muddy up what you're trying to do.

I do agree with both of the above.  The patch below makes perfect
sense to me, and it is more about the quality of implementation of
this codepath in general, than the primary theme of Brian's changes,
so there is no strong reason they have to come in a single series.

> -- >8 --
> Subject: [PATCH] read-cache: drop submodule check from add_to_cache()
>
> In add_to_cache(), we treat any directories as submodules, and complain
> if we can't resolve their HEAD. This call to resolve_gitlink_ref() was
> added by f937bc2f86 (add: error appropriately on repository with no
> commits, 2019-04-09), with the goal of improving the error message for
> empty repositories.
>
> But we already resolve the submodule HEAD in index_path(), which is
> where we find the actual oid we're going to use. Resolving it again here
> introduces some downsides:
>
>   1. It's more work, since we have to open up the submodule repository's
>      files twice.
>
>   2. There are call paths that get to index_path() without going through
>      add_to_cache(). For instance, we'd want a similar informative
>      message if "git diff empty" finds that it can't resolve the
>      submodule's HEAD. (In theory we can also get there through
>      update-index, but AFAICT it refuses to consider directories as
>      submodules at all, and just complains about them).
>
>   3. The resolution in index_path() catches more errors that we don't
>      handle here. In particular, it will validate that the object format
>      for the submodule matches that of the superproject. This isn't a
>      bug, since our call in add_to_cache() throws away the oid it gets
>      without looking at it. But it certainly caused confusion for me
>      when looking at where the object-format check should go.
>
> So instead of resolving the submodule HEAD in add_to_cache(), let's just
> teach the call in index_path() to actually produce an error message
> (which it already does for other cases). That's probably what f937bc2f86
> should have done in the first place, and it gives us a single point of
> resolution when adding a submodule to the index.
>
> The resulting output is slightly more verbose, as we propagate the error
> up the call stack, but I think that's OK (and again, matches many other
> errors we get when indexing fails).
>
> I've left the text of the error message as-is, though it is perhaps
> overly specific.  There are many reasons that resolving the submodule
> HEAD might fail, though outside of corruption or system errors it is
> probably most likely that the submodule HEAD is simply on an unborn
> branch.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  object-file.c  | 2 +-
>  read-cache.c   | 3 ---
>  t/t3700-add.sh | 1 +
>  3 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 8c43c52ed0..a7438b6205 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1662,7 +1662,7 @@ int index_path(struct index_state *istate, struct object_id *oid,
>  		break;
>  	case S_IFDIR:
>  		if (repo_resolve_gitlink_ref(istate->repo, path, "HEAD", oid))
> -			return -1;
> +			return error(_("'%s' does not have a commit checked out"), path);
>  		if (&hash_algos[oid->algo] != istate->repo->hash_algo)
>  			return error(_("cannot add a submodule of a different hash algorithm"));
>  		break;
> diff --git a/read-cache.c b/read-cache.c
> index 032480d0c7..990d4ead0d 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -706,7 +706,6 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  	int add_option = (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
>  			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
>  	unsigned hash_flags = pretend ? 0 : INDEX_WRITE_OBJECT;
> -	struct object_id oid;
>  
>  	if (flags & ADD_CACHE_RENORMALIZE)
>  		hash_flags |= INDEX_RENORMALIZE;
> @@ -716,8 +715,6 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
>  
>  	namelen = strlen(path);
>  	if (S_ISDIR(st_mode)) {
> -		if (repo_resolve_gitlink_ref(the_repository, path, "HEAD", &oid) < 0)
> -			return error(_("'%s' does not have a commit checked out"), path);
>  		while (namelen && path[namelen-1] == '/')
>  			namelen--;
>  	}
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index b075eb9b11..d8cc0e4c66 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -388,6 +388,7 @@ test_expect_success 'error on a repository with no commits' '
>  	test_must_fail git add empty >actual 2>&1 &&
>  	cat >expect <<-EOF &&
>  	error: '"'empty/'"' does not have a commit checked out
> +	error: unable to index file '"'empty/'"'
>  	fatal: adding files failed
>  	EOF
>  	test_cmp expect actual
