Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143C219A79
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322889; cv=none; b=DtNWcfYZvr3vx35jeqTn7zFdLggt6ThcCaGdlTeSqjPhsCift7vE9AjsHzI3zyM7butaII0LT0McS9hA88VQ3HIpydrMKSrP+brekx6oGcKXXQRl9pWzCRm3W9Ftomat1ttADl9vTE8pV2J6/yUkgmmXKBlsiFupWsKvcWzEsDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322889; c=relaxed/simple;
	bh=8uByV4/IfTKN/pP0gEAN/NkHZMIx4frQw1xdzOwQ5xY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tyyc4s0MDidV6pPOpgtg6Ij1lnukcB8nWOFnjWA5CUqw1H3s5uX01YDTxToopnklQgeyx9RwTB3Ea1fYbrjr0bvrA65cZ5ds5s6x49e5D4KP2isMjbbauw43cz2WG0z4MEH3IwMnMt5ng0nBVD8IvmRc0TrcGcQkacG5lKw+ao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LBbYIvKh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qefo2aG8; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LBbYIvKh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qefo2aG8"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E9B8D1D000EA;
	Fri, 24 Oct 2025 12:21:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 24 Oct 2025 12:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761322885; x=1761409285; bh=1oHL40E8JH
	7Dkmo0Q84nA1of/LgHeg9wcF0AS4kvsn4=; b=LBbYIvKhodNCUN5kzmG1o6vxDO
	UHVJ6+DcMI1S3EhE5dMkMPZye1lvyGNjYaIzGXX23PlWw0pfdnBeDTa7bnYk1nmT
	3rO75+CrzytEqbDkqf87dAT8YkHXHnLH8JfcpphvoiUkzU0hWwDcL5aTXQJQM3ZO
	zRd9dpSY+nQqD1weh3MjB8AG7eXFpaaYGRs4Tttupnk05K5MAyXbOkaC0dMD5MLl
	saxG/n1nqs6OR1UosOb/xlB5bD8HHGqpZFPQTEtxcVGZJthcXKU5qGWQLsKNlp1z
	GvrRnMuBbu+6dk8FcJS2MX3dpqhwaRY0zBlaRd7dHYscqFVz2Qj+LPtXW4Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761322885; x=1761409285; bh=1oHL40E8JH7Dkmo0Q84nA1of/LgHeg9wcF0
	AS4kvsn4=; b=qefo2aG8OdslHlAaeHxDynFIOW05euD32+PN8iXLkMBkk9Y1Oop
	LtRnLumzmuGHfwk2vr5jsrsomuc/HvT/VJzXmVW1Rp4shZIKIbUZwlQ74kXhlnz2
	xDj4C3XQbK3/J9EO4j8JiG0CNibOmh5hDIAblT22qtNvlH1ofXpPFRCPAbgStWqh
	m5zIlkS/pDxZnfmwI/gtFP9Rm4BMyrIL3VSCirdlp6d8emcQVJ7LrtTbefDRy3co
	d4F8M+dqHjI84NN4IyIAl74lHrAAjOdeFyrm59olhHcbxLiIUH68A7C7+oKxZP+s
	VkT9EuyAPKLMym7Uu6xNgMASSMiNdp3DGfg==
X-ME-Sender: <xms:haf7aE2-63ILOunxbMeG0Zx1iGllVIWVvamz7WPnNljCKFl2Mgs4Iw>
    <xme:haf7aGgsJ6J0XE6tf6I5DnrxsHmzcBBoVaFSVSote-XHZnc-qGFjkbnE7lj-TbbIL
    1NuYlyftMuTOC0B91FlZK0KC9maHPTyoMr9l0yPepkwPxciGsCVf9I>
X-ME-Received: <xmr:haf7aKRg8ZD8odapdVCaLVc6GJNfTfhFqBpUQgG_toGWJJqg_uJPvlzAMe2uUj5MziNoYCNhAZxJ56M6VQLEq9CMoiOycPPcbNNi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:haf7aHgBlMt67q64RPaYAjkeAzMCUTYwV0R1qZV3uwkR9397LgSSCw>
    <xmx:haf7aK7rV3yEFI9J2k6YN7QHCVhuKqswXcEIALb65QKFlAn4Guc8CA>
    <xmx:haf7aEAuJyKhrUZL3BTiAjqVNr7TuX1nQWyOFgHqEFEvXHGxNp7GSA>
    <xmx:haf7aBY7D09DPvyDzN3caJMgcQCARLrsIjMhs3Jatn3iGeKdk3dsZA>
    <xmx:haf7aGruuJXENz655vMl4v3QGKyclANvPT9QB9jHJcXJwfYVf6SgYK4m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 12:21:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/13] odb: fix subtle logic to check whether an
 alternate is usable
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-1-1a4202273c38@pks.im>
	(Patrick Steinhardt's message of "Fri, 24 Oct 2025 11:56:00 +0200")
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
	<20251024-b4-pks-odb-loose-backend-v1-1-1a4202273c38@pks.im>
Date: Fri, 24 Oct 2025 09:21:23 -0700
Message-ID: <xmqqo6pwp8xo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +static int alt_odb_usable(struct object_database *o, const char *path,
> +			  const char *normalized_objdir)
>  {
>  	int r;
>  
>  	/* Detect cases where alternate disappeared */
> -	if (!is_directory(path->buf)) {
> +	if (!is_directory(path)) {
>  		error(_("object directory %s does not exist; "
>  			"check .git/objects/info/alternates"),
> -		      path->buf);
> +		      path);
>  		return 0;
>  	}
>  
> @@ -113,11 +112,14 @@ static int alt_odb_usable(struct object_database *o,
>  		assert(r == 1); /* never used */
>  		kh_value(o->source_by_path, p) = o->sources;
>  	}
> -	if (fspatheq(path->buf, normalized_objdir))
> +
> +	if (fspatheq(path, normalized_objdir))
> +		return 0;
> +
> +	if (kh_get_odb_path_map(o->source_by_path, path) < kh_end(o->source_by_path))
>  		return 0;
> -	*pos = kh_put_odb_path_map(o->source_by_path, path->buf, &r);
> -	/* r: 0 = exists, 1 = never used, 2 = deleted */
> -	return r == 0 ? 0 : 1;
> +
> +	return 1;
>  }

In other words, when we say "we ask if this is usable", it says "yes
it is usable" or "no it is not", but ...

> @@ -148,6 +150,7 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
>  	struct strbuf pathbuf = STRBUF_INIT;
>  	struct strbuf tmp = STRBUF_INIT;
>  	khiter_t pos;
> +	int ret;
>  
>  	if (!is_absolute_path(dir) && relative_base) {
>  		strbuf_realpath(&pathbuf, relative_base, 1);
> @@ -172,20 +175,21 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
>  	strbuf_reset(&tmp);
>  	strbuf_realpath(&tmp, odb->sources->path, 1);
>  
> -	if (!alt_odb_usable(odb, &pathbuf, tmp.buf, &pos))
> +	if (!alt_odb_usable(odb, pathbuf.buf, tmp.buf))
>  		goto error;
>  
>  	CALLOC_ARRAY(alternate, 1);
>  	alternate->odb = odb;
>  	alternate->local = false;
> -	/* pathbuf.buf is already in r->objects->source_by_path */
>  	alternate->path = strbuf_detach(&pathbuf, NULL);
>  
>  	/* add the alternate entry */
>  	*odb->sources_tail = alternate;
>  	odb->sources_tail = &(alternate->next);
> -	alternate->next = NULL;
> -	assert(odb->source_by_path);
> +
> +	pos = kh_put_odb_path_map(odb->source_by_path, alternate->path, &ret);
> +	if (!ret)
> +		BUG("source must not yet exist");

... responding to the answer and saying "ok, if it is usable, then
let's use it" is a responsibility of the caller.  Which makes sense.

>  	kh_value(odb->source_by_path, pos) = alternate;
>  
>  	/* recursively add alternates */
