Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E19199FA2
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447291; cv=none; b=jXdnbqafPEqr4UOkHw6MTMPc5clQF03iROfLUtmLk1cqkuSaxW1q3nrEpLTeoQzIIUDjGNld4jI4mU40s7brmXv+bpawuiYdXC5vE9Am+jNV8XjuGh+d81/oZI+FgzOP+vQ0aQGarvhMO3buxvsGtltAs1uMeu06kEQ28BufNbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447291; c=relaxed/simple;
	bh=jhNs0VqVYn6X0vtf/Fn597+7l/w6VgGQlfI7bEGo6z4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hvoFSxf/WSZ89zsCCvLVbA3aQ5yPRv0JhjNGKTKPn2PZtECkrevNSb7c1Cy9Pb5+oMHWOSJ7nrLyfUOeLLd2pofBRmFgZECHBHGhkUOXyp3JtgMgZoohU6i234on+V/SyDGv7RslcNvc7VTuU3S+QwdTNXQ6YHEiQ6HxmtfIB5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xx1DsRNp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OSENWY+j; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xx1DsRNp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OSENWY+j"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B1C2325401EC;
	Thu,  9 Jan 2025 13:28:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jan 2025 13:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736447287; x=1736533687; bh=UJTWbz5MZ3
	vJYTwt7MqYNj2Bz7MnSs+aZnZi8GwYlZ0=; b=Xx1DsRNpT5BhNw9awNS4gu1wGN
	MgtG/D54IsCFNwcTy6Kql1PiaeUbRgl8GEPSgJ8CI/toY8rf53CbCSYlhUwFyIuF
	3Gsti8fwJ3oFOX5+TEFEz0gLJsK01mbOyV5eKt8L7kobdl9zJk17/ECawH1lYntU
	Q5TK8qkf6vfNU4HxLUlR18RsyfTZqCLQ6e3pxGbBJfdB9dEXdX28v1u8owkTsO0V
	ptyVIFRB4WCyMXwcSF2DWFMvqTn7RR5gwORFd90K13o+3sQcSa+gTdZ+eeyMHllM
	F5/vjtxbUThtGn8Q0tGzbgqvgDnJeTeLM5FJjWjfgsxEAcKgxmWpjJZa7HpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736447287; x=1736533687; bh=UJTWbz5MZ3vJYTwt7MqYNj2Bz7MnSs+aZnZ
	i8GwYlZ0=; b=OSENWY+jpbLLzW2bpPJSsbIDzs9uTQswWmfwjQRZgDwfYXImJNm
	zNSzF7gEF9GpGt0rnPVTNYgveEYVl2kaIEBE9bIW4vODnjs8Ua/so1CcaYtgSmCm
	3FDNk9s14cBT+HBM2+yOyX/2+QTJ03dzYLBKjBUnacXQkXvd75LICZomAOC1T1XP
	FxiBYWLkgiT3TVYJHy1LYcpcT9hcZjsyE8JHy7iurUAYVU3i6ti/SKCKVZy4umLi
	skXqjJBG6eI2JrjVkDzQHuIDVXXl24J6IbjyUdj3tVc4Xdjar6OhUCX7y8mgKZ+b
	GZj7+Qi3UOYO49zmxpN9Jd63zzMSKqdEGGA==
X-ME-Sender: <xms:NxWAZ2WUW4jdUx4mlMG1MVSBJuP8qAYBbzKn9_AeW7Uj4J-MzSD0HQ>
    <xme:NxWAZykJYwGf248uGFc25b2esl_yNzJdZ_r2BGt2ewB3f9PYNF2M0kER31-k5rtx1
    wky-g7NYKaVgriPtg>
X-ME-Received: <xmr:NxWAZ6YUkoji9V9T0VZkY4PjOEkRqt2Gjue9B909YW1Ell-gNGtK-ojO2_xOPZQVdMT2yf00JZXShzgAAN1R41Dc5k0cWVZbUbLj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopeifihhnkhesshgrvhhilhhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NxWAZ9Vaq6bDJcTg2NjKQyg3ikadlrzyhoWFEWe4vZOjqsqA39vm2w>
    <xmx:NxWAZwnPMJl91wNOQ_jLALgvFoE44v-5-t03UTN87NW28eZ-SlYWvg>
    <xmx:NxWAZyfZ_D6iCL6eYak_OW8QCza1sOIObjuM73D-sfS2eCJ4FBYh8w>
    <xmx:NxWAZyERU3HA0Li4WvASW8asQHM8xFq9nb4HaYOf8noNIAD7iqSxgg>
    <xmx:NxWAZxBDD4FFUo-d2kkwM9r5JIaki2qmmKl6Zwm2VRQt104De9RIrJ4k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 13:28:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>,  Wink Saville <wink@saville.com>
Subject: Re: [PATCH 03/14] tree-diff: clear parent array in path_appendnew()
In-Reply-To: <20250109083310.GC2748836@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Jan 2025 03:33:10 -0500")
References: <20250109082723.GA2748497@coredump.intra.peff.net>
	<20250109083310.GC2748836@coredump.intra.peff.net>
Date: Thu, 09 Jan 2025 10:28:05 -0800
Message-ID: <xmqqo70fj0zu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> All of the other functions which allocate a combine_diff_path struct
> zero out the parent array, but this code path does not. There's no bug,
> since our caller will fill in most of the fields. But leaving the unused
> fields (like combine_diff_parent.path) uninitialized makes working with
> the struct more error-prone than it needs to be.

OK.  We however will still not use the array at all when we do not
need it, so it would be between accessing uninitialized bytes vs
accessing 0-bytes by mistake?  With my devil's advocate hat on, I
wonder if this would lead to more sloppy users saying "I am not
following the pointer; I am merely stopping when I see a NULL
pointer at the end of the array" or something silly like that
without checking the validity of the array itself (which presumably
can be inferred by inspecting some other member in the containing
struct, right?)".

> Let's just zero the parent field to be consistent with the
> combine_diff_path_new() allocator.

But I like the "let's be consistent" reasoning, so I wouldn't
complain ;-)

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  tree-diff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tree-diff.c b/tree-diff.c
> index d9237ffd9b..24f7b5912c 100644
> --- a/tree-diff.c
> +++ b/tree-diff.c
> @@ -151,8 +151,6 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
>   *	process(p);
>   *	p = pprev;
>   *	; don't forget to free tail->next in the end
> - *
> - * p->parent[] remains uninitialized.
>   */
>  static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
>  	int nparent, const struct strbuf *base, const char *path, int pathlen,
> @@ -187,6 +185,8 @@ static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
>  	p->mode = mode;
>  	oidcpy(&p->oid, oid ? oid : null_oid());
>  
> +	memset(p->parent, 0, sizeof(p->parent[0]) * nparent);
> +
>  	return p;
>  }
