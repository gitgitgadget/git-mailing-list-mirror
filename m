Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DA938B122
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164649; cv=none; b=GFoIuYGW3BpMHKUfjh8GpGSz9fcm7LBeD/b9UVFleOZV9f3NpdsApaQKFR8MG6QOjSQZt2SoXvNJRja0SqWuzUD74lWc5bK+gx27y5USOHhzv+epU3TkqFWqj52/XEiXbVMeJTOqYqSMIruPsekJK2vu7PrKDzIyPbSeaAKp8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164649; c=relaxed/simple;
	bh=CQOZE2YLCJCyw3lB3itd/8dnrxID12lIdmjVRK5A6eA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r61L4wpGjSAvLR9QQyna6P3Tv41IVN4auSTRHZfa6ODn9fhUU/bRhtik3iRls15ojUwr33YQEe8WE0wDqpzGlxT9lQpdUyUzM+Kc1Uf/bIEe5+5fwhgd4vC5RNE8hyNfH5jLoOnG2FNl9Y61Qh112gaykBanG86ds+uxLEoWo68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GGdt+50m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j5KA8Mz0; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GGdt+50m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j5KA8Mz0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0394EEC145A;
	Tue, 10 Mar 2026 13:44:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 10 Mar 2026 13:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773164647; x=1773251047; bh=6VUNNBXvLF
	sAB5D7ybVFwnOeR9GJ2tU/51aZ2oxoh7k=; b=GGdt+50mX5KH030hoV8j3Jo9cm
	MGn/p/CjxSGAfe2I/3MgNxvVK/Wv7tmv2aL6tj3WZ4UTg4WmTAH2YosO2qgB2Jm+
	sKOhwaN1W3K8E7iFjkdf5DahaeMpaqoHeEKAbgiSryX9s8WiPYbI1EaPrTaupYbF
	1vi/XMiN/m3LX0gNImkDP6dUkeNHOCyCEYkn0P2PuvRxLaW03iXmTT5tF9m6thmR
	4jtnCsWQgqYhRPpUmE/J2u5cOV2nbetQsRwpdFiRetikYl35TGO2eY4YWioHjpDj
	AiUBOjNw9eQFzAXFawQR0gI5i43ZvKjBYudO+OEXKeifaAQpxIu/qVSBfnzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773164647; x=1773251047; bh=6VUNNBXvLFsAB5D7ybVFwnOeR9GJ2tU/51a
	Z2oxoh7k=; b=j5KA8Mz0YJDn4XYRS7sEcuD2qBKHLXF+5cSjEPBqjgl7o/P1cQo
	g+QHgOIv+M3EonPibjPfAAk617/HhXbR4vT9UZSxxOHbNUlvyt/qNCs+abkl7GQq
	azY26hpFEmXm+0aqAVwo9nwTILwgk+pgZxBCEke4IFICBVk14SbiMHwg5Z2xDXQT
	sgHkeQjXyX1hMltnaKiNOO4vppTCwZvvVmbRkIbr0/6reW9MRrho1pkWS+3TPsIl
	q9demzmkV9dJYEY35qkhin1w7y4Exbkl2eYWq8t5Grvye2fEoZOwMpsfT3cEmr5i
	TnGAU9IwLTx7wLLhiwBn+hF32PakqQXzVEw==
X-ME-Sender: <xms:Z1iwadjQSmlZV8xEm8_77d9PBXtp3fzqLCh1bVYf9RnpW831UYwxAw>
    <xme:Z1iwaZfzbpW3L4vpM-wcylflsd4NftqLAj4h9vu0t39ELbFyT09SuyoAH4jAb-3dS
    WxXG7cbQPYoaoaBcT_V7RBqit5GDKRLbrst607Htcp1WQr91UuAsso>
X-ME-Received: <xmr:Z1iwaadpyQSG3IMQMrJQhjVGw2zS7hbQX_FI9lmFelvEsWi4XDW9cvyWPhsJNEJ9ipvkSQhBoL6YV2QVgBy8D41rgBUIDOe-hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduieehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Z1iwab-JbB-_jnyzuPrgdj7zZ-1lF6ZqVIbGRYsJ5acGG2PWMUAENw>
    <xmx:Z1iwaem7be0S3jPBjtyZ39FmLsA_TxwAZLjQurzuYxp9oaRwQOzsAg>
    <xmx:Z1iwaV_Z6QGpNLk8gPDJMaKtalGVEiQ12vLaqcYDJOKxBegroUcaEQ>
    <xmx:Z1iwaUnxQx3A-UqgUhMLEO8tQp2uYWO4ByUASxYmyQcPrFG2YKwcTg>
    <xmx:Z1iwaRn59kRSpt8q6sB2_eqAV7E2_3tFBv_-DiiRBrK32yLLeZMo2xlS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 13:44:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] object-file: extract logic to approximate object count
In-Reply-To: <20260310-b4-pks-odb-source-count-objects-v1-3-109e07d425f4@pks.im>
	(Patrick Steinhardt's message of "Tue, 10 Mar 2026 16:18:23 +0100")
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
	<20260310-b4-pks-odb-source-count-objects-v1-3-109e07d425f4@pks.im>
Date: Tue, 10 Mar 2026 10:44:06 -0700
Message-ID: <xmqqjyvjvau1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>  static int too_many_loose_objects(int limit)
>  {
> ...
> +	int auto_threshold = DIV_ROUND_UP(limit, 256) * 256;
> +	unsigned long loose_count;
> +
> +	if (odb_source_loose_approximate_object_count(the_repository->objects->sources,
> +						      &loose_count) < 0)
>  		return 0;
>  
> -	auto_threshold = DIV_ROUND_UP(limit, 256);
> -	while ((ent = readdir(dir)) != NULL) {
> -		if (strspn(ent->d_name, "0123456789abcdef") != hexsz_loose ||
> -		    ent->d_name[hexsz_loose] != '\0')
> -			continue;
> -		if (++num_loose > auto_threshold) {
> -			needed = 1;
> -			break;
> -		}
> -	}
> -	closedir(dir);
> -	return needed;
> +	return loose_count > auto_threshold;
>  }

We used to sample one shared directory and stopped when we know we
have more than auto_threshold, which is roughly 1/256 of the given
limit.  Now, we ask "approximate" function to count and then compare
the result with the same auto_threshold (i.e., 1/256 of the given
limit), which means we expect approximate function to count only
1/256 of the total loose objects somehow?  Let's keep reading.

>  static struct packed_git *find_base_packs(struct string_list *packs,
> diff --git a/object-file.c b/object-file.c
> index a3ff7f586c..da67e3c9ff 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1868,6 +1868,47 @@ int odb_source_loose_for_each_object(struct odb_source *source,
>  					     NULL, NULL, &data);
>  }
>  
> +int odb_source_loose_approximate_object_count(struct odb_source *source,
> +					      unsigned long *out)
> +{
> +	const unsigned hexsz = source->odb->repo->hash_algo->hexsz - 2;
> +	unsigned long count = 0;
> +	struct dirent *ent;
> +	char *path = NULL;
> +	DIR *dir = NULL;
> +	int ret;
> +
> +	path = xstrfmt("%s/17", source->path);
> +
> +	dir = opendir(path);
> +	if (!dir) {
> +		if (errno == ENOENT) {
> +			*out = 0;
> +			ret = 0;
> +			goto out;
> +		}
> +
> +		ret = error_errno("cannot open object shard '%s'", path);
> +		goto out;
> +	}
> +
> +	while ((ent = readdir(dir)) != NULL) {
> +		if (strspn(ent->d_name, "0123456789abcdef") != hexsz ||
> +		    ent->d_name[hexsz] != '\0')
> +			continue;
> +		count++;
> +	}

This counts one shared ("17" that is randomly picked) fully and then ...

> +	*out = count * 256;

... estimate that the entire world would probably have 256 times as
many as the objects in that one shared.

Ah, my earlier read of the caller was confused.  auto_threshold used
to be 1/256 of the limit, but now the number used is computed in a
strange arithmetic, "DIV_ROUND_UP(limit,256) * 256".  Not directly
using "limit" fooled me into thinking that it somehow kept using the
same 1/256 of the limit.

So we are answering "do we have too many?" question using roughly
the same criteria as before, not 1/256 off as I suspected earlier.

The old implementation exited early as soon as the threshold was
hit.  While scanning a single shard directory is likely fast enough
that this may not matter in practice, it is a slight change in
behaviour. If a repository has an extremely large number of loose
objects (e.g. tens of thousands in shard 17), this will now count
all of them instead of stopping at ~30 (if the limit set to around
7000 objects).

Given that this is an "auto" GC check, the performance difference is
probably negligible, but I thought it worth pointing out.
