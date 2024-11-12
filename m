Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530919F462
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396404; cv=none; b=PgGczXuprT5yu1aYjLNtdMl+fhOkTXIQrCImQVrY4xCJKA6aTElrBZdiMkKX5nIIwFY2KvQE4UknFTH3qdwABPwQcyxcckh4sESdPzDj9rBA04wfTFeg6jpb9Q7mtSWRM0kypeak4JuQaUSCDCrL7eo6hATGno7vYUKnlpAniz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396404; c=relaxed/simple;
	bh=11kWN89uuf/ilHl56Aj6+sHDmRVRBCk9SDJbnUBNJ50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X7RZpWccCtmiTU4T89iMVhOwhJFMOiT/iu5OlsACSqozYeOJTRxHRxlYqM1UvWPaRdAQZU5Frl5nHZYxtsiSjRbbpUBhSqG82dGHUb4c3xfDyGbAo/Y/tZe4UQVBGsVHms62YVzZEqCBCTtfjlTsHXz/UprK9l/yTBF/v6dxW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jzBmFwaJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QDcVqLWa; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jzBmFwaJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDcVqLWa"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 72AB0254016E;
	Tue, 12 Nov 2024 02:26:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 12 Nov 2024 02:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731396400; x=1731482800; bh=4XaqOTt6XB
	cWSxc1VJZhDv+xtDRptLvQsPFw2i5LrE0=; b=jzBmFwaJzUkRGah8MK9BkUqB11
	zg9bHir3PewYuPNwwe80APMGHSg/JTUiF4miZa8ldsAV3OUQBJc+Y/j21suD833l
	qRMnLrNMvx8Sp9Wi+pUzVt6CRfbRWbwBuRHhX8WrM4J2ERIqjhtQOYYcOiIv9zBi
	7v5d5/1ZsVWKZdAGEatXjEYqxX/YqTG/fXjip2bO0HZEOd6cI/j3+fUWhOxfAfIO
	32PotCjJ9+KVUKa1DrpxAzYkGA+tOJkkh6o6F640/N0zJVQ+CmexFR7LUiaHOMqd
	kZlrL7Z+m0aS8JxB1e9pL40TcpZIVjGxsSbbCDvJ5h4soQQhMEiipWYnS3QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731396400; x=1731482800; bh=4XaqOTt6XBcWSxc1VJZhDv+xtDRptLvQsPF
	w2i5LrE0=; b=QDcVqLWau9hlhvWMd1EeGPpfrS0ty/RK1F7b/IgFltlq1PWsWXy
	lwEuayEXIrXQQBWwKL8ogDW+sNCbXslk9lROvlvV80phPvSy2VHueon8V3uG+arY
	l2RTYY1NhEVcgWSLnpkJesSlKjG7PW5bt4LhUfIrT2uDWE0Mh/SJ2d2TPPeYbVrj
	GaQy1/DVL6EWY3cPGdtGvN2TQzXE5PhM9rkcW7yaG8I6l1f2mrvXwG20ypzllwDL
	u5cK8SGWPt0A+ljHLOiwJOi2VRer96c4JToi/F7ve7DN3u5gl8s/IcuE/1tL3Ot2
	gwJIGN+0zBbIHqL7Gx2i3z7tIVLt5CZaIdA==
X-ME-Sender: <xms:MAMzZ9MTf1Pr4wd7dW3NdymupuNoD1J5JtRwdVzWrjkdHjBtkorQ-w>
    <xme:MAMzZ_8eZUEUMjaZFCrVuzr_WS0idKird4BwKdjlNiJi9D1r7HUwmrbevMJ21r7Ly
    7bMqxQGbJ1QFa0zYA>
X-ME-Received: <xmr:MAMzZ8SkW17N4Hv9LEXGW75sotLp3gGX0okiU7dN2Q2nXOa-Qs5cHk0YC1W3el2-vU8CDj1AGncRUSSvAu7CUoT8UapVRltq3pWH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MAMzZ5uroKT8JNfp2N_m9f-AgUQSukRDeKia8XumredvGKu1RVzyTA>
    <xmx:MAMzZ1cXvktaMmijp2VivPIZMdXGnoiI_Gn6Hwl4SzsE51uBlwtY5A>
    <xmx:MAMzZ122AoD1WMLrnHPguj8KW_Dr38xZpk-l6s3hjTv-8lEVHA8ERg>
    <xmx:MAMzZx_FWCePuqnNmR437l60fZP2vPx69a05pRwbR4nGZbpTpkkOyw>
    <xmx:MAMzZ56qtjMk3yzBTVNadD3CzaORUTJX7YJsUI1nrJf08Q3fZUgTwJAU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 02:26:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/8] refs/reftable: read references via `struct
 reftable_backend`
In-Reply-To: <1b50655202f311c6a6ded61d4d50b1f287761d84.1730792627.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 5 Nov 2024 10:12:04 +0100")
References: <cover.1730732881.git.ps@pks.im> <cover.1730792627.git.ps@pks.im>
	<1b50655202f311c6a6ded61d4d50b1f287761d84.1730792627.git.ps@pks.im>
Date: Tue, 12 Nov 2024 16:26:38 +0900
Message-ID: <xmqqed3g6hg1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Refactor `read_ref_without_reload()` to accept a `struct reftable_stack`
> as input instead of accepting a `struct reftable_stack`. This allows us
> to implement an additional caching layer when reading refs where we can
> reuse reftable iterators.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c   | 110 ++++++++++++++++++++------------------
>  reftable/reftable-stack.h |   3 ++
>  reftable/stack.c          |   5 ++
>  3 files changed, 67 insertions(+), 51 deletions(-)
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 4a28dc8a9d..230adb690d 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -51,6 +51,50 @@ static void reftable_backend_release(struct reftable_backend *be)
>  	be->stack = NULL;
>  }
>  
> +static int reftable_backend_read_ref(struct reftable_backend *be,
> +				     const char *refname,
> +				     struct object_id *oid,
> +				     struct strbuf *referent,
> +				     unsigned int *type)
> +{
> +	struct reftable_ref_record ref = {0};
> +	int ret;
> +
> +	ret = reftable_stack_read_ref(be->stack, refname, &ref);
> +	if (ret)
> +		goto done;
> +
> +	if (ref.value_type == REFTABLE_REF_SYMREF) {
> +		strbuf_reset(referent);
> +		strbuf_addstr(referent, ref.value.symref);
> +		*type |= REF_ISSYMREF;
> +	} else if (reftable_ref_record_val1(&ref)) {
> +		unsigned int hash_id;
> +
> +		switch (reftable_stack_hash_id(be->stack)) {

So, relative to the original, instead of relying on the repository
and its knowledge of what hash function is used, we ask the stack
what hash function is in use and use that instead.

> +		case REFTABLE_HASH_SHA1:
> +			hash_id = GIT_HASH_SHA1;
> +			break;
> +		case REFTABLE_HASH_SHA256:
> +			hash_id = GIT_HASH_SHA256;
> +			break;
> +		default:
> +			BUG("unhandled hash ID %d", reftable_stack_hash_id(be->stack));
> +		}
> +
> +		oidread(oid, reftable_ref_record_val1(&ref),
> +			&hash_algos[hash_id]);
> +	} else {
> +		/* We got a tombstone, which should not happen. */
> +		BUG("unhandled reference value type %d", ref.value_type);
> +	}
> +
> +done:
> +	assert(ret != REFTABLE_API_ERROR);
> +	reftable_ref_record_release(&ref);
> +	return ret;
> +}

Here is the original that got replaced.  Since ...

> -static int read_ref_without_reload(struct reftable_ref_store *refs,
> -				   struct reftable_stack *stack,
> -				   const char *refname,
> -				   struct object_id *oid,
> -				   struct strbuf *referent,
> -				   unsigned int *type)
> -{
> -	struct reftable_ref_record ref = {0};
> -	int ret;
> -
> -	ret = reftable_stack_read_ref(stack, refname, &ref);
> -	if (ret)
> -		goto done;
> -
> -	if (ref.value_type == REFTABLE_REF_SYMREF) {
> -		strbuf_reset(referent);
> -		strbuf_addstr(referent, ref.value.symref);
> -		*type |= REF_ISSYMREF;
> -	} else if (reftable_ref_record_val1(&ref)) {
> -		oidread(oid, reftable_ref_record_val1(&ref),
> -			refs->base.repo->hash_algo);

... we have access to "refs", which is a ref_store, that knows its
repository, it was just a few pointer references away to get the
hash id of the Git side.  But of course we use REFTABLE_HASH_*NAME*
to identify the algorithm at this layer, so we need to translate it
back to the ide on the Git side before asking oidread() to read it.

> -	} else {
> -		/* We got a tombstone, which should not happen. */
> -		BUG("unhandled reference value type %d", ref.value_type);
> -	}
> -
> -done:
> -	assert(ret != REFTABLE_API_ERROR);
> -	reftable_ref_record_release(&ref);
> -	return ret;
> -}

There is one thing that is curious about this step.

It isn't like we teach stack what hash it uses in this step---the
reftable_stack_hash_id() could have been implemented as early as
59343984 (reftable/system: stop depending on "hash.h", 2024-11-08).

Other than that this step introduces the first caller of
reftable_stack_hash_id() in the series, the remaining hunks of this
patch do not have to be part of this patch, but could have been a
separate step.  Not a suggestion to split it out, but merely an
observation (to make sure I am reading the code correctly).

> diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
> index 54787f2ef5..ae14270ea7 100644
> --- a/reftable/reftable-stack.h
> +++ b/reftable/reftable-stack.h
> @@ -149,4 +149,7 @@ struct reftable_compaction_stats {
>  struct reftable_compaction_stats *
>  reftable_stack_compaction_stats(struct reftable_stack *st);
>  
> +/* Return the hash of the stack. */
> +enum reftable_hash reftable_stack_hash_id(struct reftable_stack *st);
> +
>  #endif
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 1fffd75630..d97b64a40d 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1791,3 +1791,8 @@ int reftable_stack_clean(struct reftable_stack *st)
>  	reftable_addition_destroy(add);
>  	return err;
>  }
> +
> +enum reftable_hash reftable_stack_hash_id(struct reftable_stack *st)
> +{
> +	return reftable_merged_table_hash_id(st->merged);
> +}
