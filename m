Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4070168B1
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736556072; cv=none; b=C0pOXaer6r8EKDcQBBE7ymi6cXYg3WOTh2Jx+Y0+S5ZV/NHyW9EQaj1YdXA2mV08l1o14sbT8d4avleP4eGvZ5JV9PozH+Lqqp9T/HjAPtQg/ZRSn4/4u3sr4qN/F9zIFDEX7K7FTEfEJix6izUF3winFr0Ojj8WE5M8dWASgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736556072; c=relaxed/simple;
	bh=CbuZSv+DtUHvbgE26lNzvVvwAfZ3LRMC0YfWSGCA5aM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PdEH5aN5yzmWN2lb6Y5ewjtIKHS8O3nvcJnkQ7m12lPPM86Ur2R5PdVQERR4UlBRSg1+kw9HQnb1gNIWK6t3QCuwYs4mJAKcCowM5xPaLozgtIUEIhdkOoV43FlDyfmUNHkq8xDfdkIk/DsoDR54uC8HS/1h5zAheLIxwgzSj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pm8D4HZ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HzfxL8Ji; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pm8D4HZ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HzfxL8Ji"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E18B25400C0;
	Fri, 10 Jan 2025 19:41:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 10 Jan 2025 19:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736556069; x=1736642469; bh=7h6LGGHsch
	v4q23bWmX2h3HcNrwpDDaJRkCklrmS3WI=; b=pm8D4HZ2gc6+MMkDo1JG07lGvx
	13m64MHRE6gouhrcKAAB5FwWHNuTGSM3lt6IpEdAPEGYXE1ofBvKM1qr86EyV6oT
	9h3ERTSqlowqsn3oj3H4aI/LHAFz2SuuubDZspSg5R1h6SbaUR5rRSTXm34P+cA6
	OAtgjzcFvJnYCwVbqwFk1dErWquD3G2LI/O1E8pTyKv1Z0XYc9LKI1VwUSKtLdKc
	8hfLMf+jQhF2dw/oN2x9X/L+fKIh7DArGuWXhBxTpbgjRoiVEhmLF4Qled32U+/K
	FOlYzdOsd4gNUexJxPSgMwtCsNwCnHbNZsGMFaBxFOPS/DrCwGP9hIkNremQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736556069; x=1736642469; bh=7h6LGGHschv4q23bWmX2h3HcNrwpDDaJRkC
	klrmS3WI=; b=HzfxL8Ji+k8fZwRm+r8XEjUa4foujkQbyMYSI4gZR9jPtqMcVyD
	6pZ4MBMecdwvs4yYTQ8xZhaD+slehn+NWAIFdl/2v4QaB1i++QfrzS3PAy5ZjSmw
	CkrspG9vysk9JqkjNECUqlzwnb7iD9l6SxCLAoNtLwtndzBPMAoSyPa6tsRO4GHE
	/N2M8af0klVeB5h376EgiayNxbIzu4M0fSdqG+3bpeqZJnUrGi4YJA/8Rp320eQ1
	DBI5hgHQL5jUjvp3T5qR+FFdB3n1H8jJ60pwA2QEvjH68vLbXa52NFrvGSp8HvNA
	g2INpaMyc+2Ku4OijfdgBLaV4xkH9FMi62g==
X-ME-Sender: <xms:Jb6BZycvuARasKJbQCjpz_6bN-eWhjpwCSdD6itA-E3uLS1znxrPNA>
    <xme:Jb6BZ8M5sw6GhV9sOxuYrzMfSs00XQx6_qPzwfRb9grgO0eCbXs3sRpmX1sP5aDJm
    ZWvMo4gSMnXz9Y3YA>
X-ME-Received: <xmr:Jb6BZzgiWZl_l3pgUPxVaYmfdj9SY_CdQb5RJWuaUXWXYkuftvmOFJgI29BF2Pua4ZgU7plnh2BrjqAbCIUgLm6nWBFTLlISnz_G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegledgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepfihinhhksehsrghvihhllhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:Jb6BZ_9NNcDXe2PORxMxAAU9NavlqUTmt55bZJHGO29YZkdAK0mrWg>
    <xmx:Jb6BZ-sTHQBLfejmq3Avjy5fGZxsnWMD9wLsmKSHdQzJ4XJpn8IZEw>
    <xmx:Jb6BZ2E50dMcJiItppVZEhw9yFIsPOMXrUTgcQlL6AAAIpUvHlTlPQ>
    <xmx:Jb6BZ9MlrJ9gWXdvPLDA-D217ikXDHquvPL_Tz0KToWIqS6zn5YJ0A>
    <xmx:Jb6BZwJ8H1qb1Sa3ZwN1XU1WeYufAdoBvHD1BpRF5diiUZ6JthJQ2IFj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 19:41:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>,  Wink Saville <wink@saville.com>
Subject: Re: [PATCH 09/14] tree-diff: inline path_appendnew()
In-Reply-To: <20250109084944.GI2748836@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Jan 2025 03:49:44 -0500")
References: <20250109082723.GA2748497@coredump.intra.peff.net>
	<20250109084944.GI2748836@coredump.intra.peff.net>
Date: Fri, 10 Jan 2025 16:41:07 -0800
Message-ID: <xmqqzfjyb2sc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Our path_appendnew() has been simplified to the point that it is mostly
> just implementing combine_diff_path_new(), plus setting the "next"
> pointer. Since there's only one caller, let's replace it completely with
> a call to that helper function.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  tree-diff.c | 31 ++++---------------------------
>  1 file changed, 4 insertions(+), 27 deletions(-)

Very nice, indeed.


> -static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
> -	int nparent, const char *path, size_t len,
> -	unsigned mode, const struct object_id *oid)
> -{
> -	struct combine_diff_path *p;
> -	size_t alloclen = combine_diff_path_size(nparent, len);
> -
> -	p = xmalloc(alloclen);
> -	p->next = NULL;
> -	last->next = p;
> -
> -	p->path = (char *)&(p->parent[nparent]);
> -	memcpy(p->path, path, len);
> -	p->path[len] = 0;
> -	p->mode = mode;
> -	oidcpy(&p->oid, oid ? oid : null_oid());
> -
> -	memset(p->parent, 0, sizeof(p->parent[0]) * nparent);
> -
> -	return p;
> -}
> -
>  /*
>   * new path should be added to combine diff
>   *
> @@ -206,7 +180,10 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
>  		struct combine_diff_path *pprev = p;
>  
>  		strbuf_add(base, path, pathlen);
> -		p = path_appendnew(p, nparent, base->buf, base->len, mode, oid);
> +		p = combine_diff_path_new(base->buf, base->len, mode,
> +					  oid ? oid : null_oid(),
> +					  nparent);
> +		pprev->next = p;
>  		strbuf_setlen(base, old_baselen);
>  
>  		for (i = 0; i < nparent; ++i) {
