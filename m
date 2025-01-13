Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA5240242
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782825; cv=none; b=qYwCVAKS39URgXFFdd6l+f0fmVwKtAp2IczvDHzrgoHspldgNxbieP9x+tT6GnUxf21pW15FnqXBp9gii2uGAwp9BVN525rW0jNm2U8MJF79gA7n41pPXLgItzStrxHxSHkMlGwViEr0NmquZEReOLohtQaECvavCi11isOY1B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782825; c=relaxed/simple;
	bh=3OFkzU7cy1qatsvgYv71lWOIC8Hlz/NXlcJ1N3Gp7hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYGd3CaZQ6GaGfWIpdsQADkbYvttBmRHkO9TLRCYpeGKy6ngkHFM8L4p7Q5YcvVc6PjO7a86GPjs0s00cnQW6W0y99ZnrR1zc6naECh+d2mb8F5mNriC1WrFg50w/IJ5wa9zBOTV/llTe6p54z5WEiFGfrJyYUgXyows8ANTt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dASkcPLa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tSkbS8os; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dASkcPLa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tSkbS8os"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 70ADD1380836;
	Mon, 13 Jan 2025 10:40:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jan 2025 10:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736782822; x=1736869222; bh=2t21YHEaX/
	PiUnQOJuLYOcx+YdATBIGd8Vsl0SV3mOA=; b=dASkcPLab0GKPmV3AnHZmRyOpO
	RbSNV/V0DYuQt61955Qf9DoQ+XuNxPk7SnrPdbqKU6lEhRyVqETH9Sysd1jJB/Ef
	9ExWx7uRYbj07zEuhl2ws7yBqoWRLuFoPgPBiT2+zIw0EJTnGj3wit7hYqiyEcAo
	V91WwWVFZVYWUGFbHxoNZ1MAVxGfOp68zEva38oyxtrXHEeJpeBsmRykzJWPTYk1
	GwykI6k9+xa2md8PTw8J55/5+i/IOEd4yMN5MRHEeqlIZupXIEnJqhWVg0eTHs8Z
	4xmbv0vIjTHx3NsBNzzc9cdXKjhI6F8Kt2L0wDV7WFdAVnev1NeKQ7QCfXjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736782822; x=1736869222; bh=2t21YHEaX/PiUnQOJuLYOcx+YdATBIGd8Vs
	l0SV3mOA=; b=tSkbS8ossML9LDjcM29ko379y7Nacl4d+NMAxlQYUe9c4pRWlV0
	4sF5MA16Qdib2Y1fDuaWl55wtFyQajWjnr+kEGPAilfOqcCDbTem7P05Z5iqfmyR
	tOAGBKQB2UNGq9l+iidegI4iXT5QnNd7t60irvSAAE78yMay5q1B1/gPqFUjKCFy
	rQ8c+05HEnC+ypPmiszGTKb6f3aPFGv2x+yj8q6pY2rf6JXzHxvT1j7tgVbOLMdK
	TGN2GRF4F0G5PWr39C++G/MXcoTZ7khn+zdVHfwdFm1Itzud9WVIMc5S2bjaD6jq
	QOpuW8p1ygY3V7KKlEXku9L96kv9XPN2sBA==
X-ME-Sender: <xms:5jOFZ-P-ri7eS6yjN10pEFVhjXpihzYaoakoiYAY4d0mr1_FAexv6w>
    <xme:5jOFZ8-UvDQMLDF1Ym_oQqgGtlCR0qSr_CY6ZQ0A4CZiA8ViCevQhzwCzxNgv87FS
    cWq7I2JaJdX-ehuiQ>
X-ME-Received: <xmr:5jOFZ1SuMYoegO3d7vi_aWofKqo0fBK9Q9-bjj-1vHiKQMAsQZMp3acEujGSndf-rmQvHOUTqtYCWkaNsx43xQ-rDcRjjYkh_3VNo-souKResdhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihinhhksehsrghv
    ihhllhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5jOFZ-sdGkyGP25skGNsGKRTu8LljxwW5AJusZOknrt_skjVVFPudQ>
    <xmx:5jOFZ2ej53ghxb5uSjrMpkjIUxXK4LajP43yoq7e3QbBJWsHEdxn4A>
    <xmx:5jOFZy25SQ2kxON_FSPgzS4oPBPlj7ewwyIUdcpgSDsRMkMmSuYfag>
    <xmx:5jOFZ6_X2xK5xW3PgFjyvWB6r8S-K8_V6vzWMN12lrCLLBaxcSVJrg>
    <xmx:5jOFZ14NiStIhXCUrZUFj4ilHrEIuJfk947egzsiwmdlYTalKjRsJTMT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 10:40:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0a2adec7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 15:40:20 +0000 (UTC)
Date: Mon, 13 Jan 2025 16:40:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Wink Saville <wink@saville.com>
Subject: Re: [PATCH 02/14] combine-diff: add combine_diff_path_new()
Message-ID: <Z4Uz43eByZHqW8UK@pks.im>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
 <20250109083236.GB2748836@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109083236.GB2748836@coredump.intra.peff.net>

On Thu, Jan 09, 2025 at 03:32:36AM -0500, Jeff King wrote:
> The combine_diff_path struct has variable size, since it embeds both the
> memory allocation for the path field as well as a variable-sized parent
> array. This makes allocating one a bit tricky.
> 
> We have a helper to compute the required size, but it's up to individual
> sites to actually initialize all of the fields. Let's provide a
> constructor function to make that a little nicer. Besides being shorter,
> it also hides away tricky bits like the computation of the "path"
> pointer (which is right after the "parent" flex array).
> 
> As a bonus, using the same constructor everywhere means that we'll
> consistently initialize all parts of the struct. A few code paths left
> the parent array unitialized. This didn't cause any bugs, but we'll be
> able to simplify some code in the next few patches knowing that the
> parent fields have all been zero'd.
> 
> This also gets rid of some questionable uses of "int" to store buffer
> lengths. Though we do use them to allocate, I don't think there are any
> integer overflow vulnerabilities here (the allocation helper promotes
> them to size_t and checks arithmetic for overflow, and the actual memcpy
> of the bytes is done using the possibly-truncated "int" value).
> 
> Sadly we can't use the FLEX_* macros to simplify the allocation here,
> because there are two variable-sized parts to the struct (and those
> macros only handle one).
> 
> Nor can we get stop publicly declaring combine_diff_path_size(). This

s/we get stop/we stop/

> diff --git a/combine-diff.c b/combine-diff.c
> index 641bc92dbd..45548fd438 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -47,22 +47,13 @@ static struct combine_diff_path *intersect_paths(
>  
>  	if (!n) {
>  		for (i = 0; i < q->nr; i++) {
> -			int len;
> -			const char *path;
>  			if (diff_unmodified_pair(q->queue[i]))
>  				continue;
> -			path = q->queue[i]->two->path;
> -			len = strlen(path);
> -			p = xmalloc(combine_diff_path_size(num_parent, len));
> -			p->path = (char *) &(p->parent[num_parent]);
> -			memcpy(p->path, path, len);
> -			p->path[len] = 0;
> -			p->next = NULL;
> -			memset(p->parent, 0,
> -			       sizeof(p->parent[0]) * num_parent);
> -
> -			oidcpy(&p->oid, &q->queue[i]->two->oid);
> -			p->mode = q->queue[i]->two->mode;
> +			p = combine_diff_path_new(q->queue[i]->two->path,
> +						  strlen(q->queue[i]->two->path),
> +						  q->queue[i]->two->mode,
> +						  &q->queue[i]->two->oid,
> +						  num_parent);
>  			oidcpy(&p->parent[n].oid, &q->queue[i]->one->oid);
>  			p->parent[n].mode = q->queue[i]->one->mode;
>  			p->parent[n].status = q->queue[i]->status;
> @@ -1667,3 +1658,24 @@ void diff_tree_combined_merge(const struct commit *commit,
>  	diff_tree_combined(&commit->object.oid, &parents, rev);
>  	oid_array_clear(&parents);
>  }
> +
> +struct combine_diff_path *combine_diff_path_new(const char *path,
> +						size_t path_len,
> +						unsigned int mode,
> +						const struct object_id *oid,
> +						size_t num_parents)
> +{
> +	struct combine_diff_path *p;
> +
> +	p = xmalloc(combine_diff_path_size(num_parents, path_len));
> +	p->path = (char *)&(p->parent[num_parents]);
> +	memcpy(p->path, path, path_len);
> +	p->path[path_len] = 0;
> +	p->next = NULL;
> +	p->mode = mode;
> +	oidcpy(&p->oid, oid);
> +
> +	memset(p->parent, 0, sizeof(p->parent[0]) * num_parents);
> +
> +	return p;
> +}

If I were to write this anew I'd probably use `xcalloc()` instead of
manually `memset()`ing parts of it to zero. But it's a faithful
transplant of the code from `intersect_paths()`, so that's probably
okay.

Patrick
