Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7641BC58
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 04:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959810; cv=none; b=Sc93XdUIK1E5JSlTWxH8gB6S1ugrXXRGuKjr9c+oCzdh9fT0ButGe/0CIDr4m44osIrhFaQIUQfw0nui7v/1TZLVpe0zEN4cfcnOx++O+h9muUCnNaycXGP48ySbt/OFlNh1YV75znhoKleWFO61R/Ki/47xj7yhsMNcGx48JyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959810; c=relaxed/simple;
	bh=qgw/kefg4+3BpH3WAXm5CwCWfaJb8ij2rnWHFIOt1uE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RdzroqkA2lqtxfcpqfZEk/iDpP+KX8mNj3Sx1f7WHu12GyLbbH0q5/BXN+LePPAWtjF6KlXLfxqEhFC0HrqnDu6QN7vjg5y4zGEYMgtNLYOK//KD8TtlDsxgUeCEu3ovtHtYfZAgVFntp8FFqZYY16N43LKrRSGpin2mQ3o00X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rvQ04qQk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eF6fZ6Kn; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rvQ04qQk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eF6fZ6Kn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9EE4140020E;
	Thu,  4 Sep 2025 00:23:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 04 Sep 2025 00:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756959806; x=1757046206; bh=70LsRLZuXf
	CjxEYs0wfzb07B9jBzBmg1OGAK6lkk0AQ=; b=rvQ04qQkL1d7TS9lohD+ng2gsj
	g3Zz84CurVo732mxxKXND93E4dGYRwLCMxRs2ho+WjC0YBE31PVlZ8DYWeGjCpEE
	p76ibwoF1wm4gC+yXxa+sURg7cLCAyQQhVaSqW2SzJ2Ao50RzWk3oQn+JzVj8Eju
	EmPS/z/sF0FFjKqJwgxWAp/eN9q4vlOcZTsKnv0iih6diemxYcvs+0CaWIC3tLD3
	sF13QjGnHIkjleklzCm6oFCmNdGngaNpzJb3L786uDkvb++2BlSW5XltQ+qjXvK4
	QC5tVDUe+ezX0Np5DElVJOX/cdFpjNT3Mtn0KnSKa1JEQzmg7XQU1zxsx8cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756959806; x=1757046206; bh=70LsRLZuXfCjxEYs0wfzb07B9jBzBmg1OGA
	K6lkk0AQ=; b=eF6fZ6KnwkBcizOcfv3ozNjzrYikrvyNO5gFeJqybeLiddErjFG
	becB//IH92UPV68yCx8gG3LSiFLYcGi5AWejafZ3TQOKbBtajPBwR92Xp4EZK4Mu
	2t0uc8fwcsV4DXtlXOOUaX4Qnl6P8gyY7rpAXAzc7Y+hZIfGGzk/xt/CgkXrtGI1
	9MhEV4DfFKNYvpK0ZSUSu3wmdKbikJN5HWizWGBwpK8uQpH8sMF2XXg33/xokWCp
	GhSx9kmh1XzGpEMokM1PxNtbKPcjlot43aK5GzQz0VwlwuCmDp6yAwuAGbMVmAHQ
	IvVT/ZFA8nTYOsNunCnllm8axldIgrsn2xA==
X-ME-Sender: <xms:PhS5aMYJ7O2OnzpUFC29yOuYlbW5s0xU3GToZBaAv2EbrEl4bSmdtQ>
    <xme:PhS5aC6g4reuiW_3tY35ymAZknb0uMGlLXc9M4wBFNSafpjU04dVDa7LUrDIAbPTL
    ky9yxbLXNXpRIPw0A>
X-ME-Received: <xmr:PhS5aNaxcPt_VNtNmvpkJiF64WFxuqwoeFlYaUox84OVo_GAwYtJHDwdfjgdk_QWEmxg4kgFmkJzCuqW4oUSf4g7T6VW73jIk1oAG7s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PhS5aBi5HwkImh-hyuiX743b_hSG_dV7PAU9j5_4ssKLgcA3y4ctpQ>
    <xmx:PhS5aO-46dgsfHjQ74GIGxZeIlQoNzQUlIjYS5jFvOgbBHqSmsi4Sw>
    <xmx:PhS5aMq_N2xO-2qzFaj7aivM-I-UH1SKMp59lS9_tT4ajDBRWjFXig>
    <xmx:PhS5aGVmtRvSB44SZOrErNqpXNuNlyAT2fqp7XhPZER1Kqc1tNKx5w>
    <xmx:PhS5aI5Izx_xs5oMGnHd27CJXWHdyEaXVdKVigKjz64vPV5XI6eM7lRG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 00:23:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH 2/2] upload-pack: don't ACK non-commits repeatedly in
 protocol v2
In-Reply-To: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-2-4e019af4dddc@pks.im>
	(Patrick Steinhardt's message of "Wed, 03 Sep 2025 06:54:11 +0200")
References: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-0-4e019af4dddc@pks.im>
	<20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-2-4e019af4dddc@pks.im>
Date: Wed, 03 Sep 2025 21:23:25 -0700
Message-ID: <xmqqtt1ic0ci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> This means that we repeatedly store the same object ID in our `have_obj`
> array, with two consequences:
>
>   - In protocol v2 we deduplicate ACKs for commits, but not for any
>     other objects as we send ACKs for every object ID in the `have_obj`
>     array.
>
>   - The `have_obj` array can grow in size indefinitely with both
>     protocols.
>
> The potentially-more-serious issue is the second one, as we basically
> have a way for an adversary to allocate arbitrarily large buffers now.
> Ultimately, this doesn't seem to be all that serious though: on my
> machine, the growth of that array is at around 4MB/s, and after roughly
> five minutes I was only at 1GB RSS. So this is concerning, but only
> mildly so.
>
> Fix this bug by storing the `THEY_HAVE` flag independent of the object
> type so that we don't store duplicate object IDs in `have_obj` anymore.

Makes sense.

> diff --git a/upload-pack.c b/upload-pack.c
> index 4f26f6afc7..fba3e339e2 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -476,20 +476,21 @@ static void create_pack_file(struct upload_pack_data *pack_data,
>  
>  static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid)
>  {
> -	int we_knew_they_have = 0;
>  	struct object *o = parse_object_with_flags(the_repository, oid,
>  						   PARSE_OBJECT_SKIP_HASH_CHECK |
>  						   PARSE_OBJECT_DISCARD_TREE);
>  
>  	if (!o)
>  		die("oops (%s)", oid_to_hex(oid));
> +
> +	if (o->flags & THEY_HAVE)
> +		return 0;
> +	o->flags |= THEY_HAVE;
> +
>  	if (o->type == OBJ_COMMIT) {
>  		struct commit_list *parents;
>  		struct commit *commit = (struct commit *)o;
> -		if (o->flags & THEY_HAVE)
> -			we_knew_they_have = 1;
> -		else
> -			o->flags |= THEY_HAVE;
> +

OK, so regardless of the type, an object that we already know they
have do not need to be processed twice, which makes sense?

For commits, we used to ensure that even if we see a commit that we
know they have for the second time, instead of returning, we marked
its immediate parents with THEY_HAVE bit.  We no longer do so.

Instead, the new code only paints the parents of a commit that we
haven't painted with THEY_HAVE.  Otherwise we return without doing
anything.

I wonder if they are equivalent.  In the original code, when our
commit A has a parent B, where neither of them we haven't painted,
we paint A with THEY_HAVE, we paint all parents of A with THEY_HAVE,
and put A in the have_obj array and return 1.  Then later when we
feed B to this function, we already know they have B, so we do not
add it to have_obj array, but otherwise we still paint B's parents
with THEY_HAVE bit.  In the new code with the same set-up, we paint
A and B with THEY_HAVE and put A in the have_obj array and return 1.
When the caller feeds B to this function, we pretty much do nothing
and return, so B's parent will not be painted, will it?

I must be misreading the patch, but I do not quite see how.

>  		if (!data->oldest_have || (commit->date < data->oldest_have))
>  			data->oldest_have = commit->date;
>  		for (parents = commit->parents;
> @@ -497,11 +498,9 @@ static int do_got_oid(struct upload_pack_data *data, const struct object_id *oid
>  		     parents = parents->next)
>  			parents->item->object.flags |= THEY_HAVE;
>  	}
> -	if (!we_knew_they_have) {
> -		add_object_array(o, NULL, &data->have_obj);
> -		return 1;
> -	}
> -	return 0;

> +
> +	add_object_array(o, NULL, &data->have_obj);
> +	return 1;
>  }
>  
>  static int got_oid(struct upload_pack_data *data,
