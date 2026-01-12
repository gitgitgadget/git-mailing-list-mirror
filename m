Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C7341076
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207253; cv=none; b=DYnxLEI6G88lm3q/yO7qgUzwundm9Py4oxIEEcC6HTutYnSLW5f8IRXU6Sq1fea+6R/7698sfajCnuCSqjwl6UdhlsKm8PdsPtQ/tT0iU7d2DTMGuUzAtthI4aKisF+DJX0fK2WOwCvZEktmJicY64tksE0TezQobARuYt7kpwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207253; c=relaxed/simple;
	bh=b3u9Zo8HSj+jKGjL5kY5E0bWGLYJhd5TSKJOYa4FQmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbhxQlswHF0WxLKR4UCArVTlyyyct/CtJbVC9OrIZTGOIkfcXJXVouM7hRUwVHe6PoKe0AtlgO0rbLPkWLddRSkLEAlT73mggop1hQO2HBX/c18l2gZAfzLfhBxeUF7ROzoLTKBISdM7cLxlocXlpvLSAWXB7he2luib32O5YKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JMLawY1e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lj/bJFI1; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JMLawY1e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lj/bJFI1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BCA5C1D000BF;
	Mon, 12 Jan 2026 03:40:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 03:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768207251; x=1768293651; bh=DEFUUuGl9V
	dJ0kZN+PJIByKe+K98AYFOFuA3y5r7yP8=; b=JMLawY1ekYQsiBFALh76QS1xJ4
	D98TBhzyTgyuanLAmwTer5LZzL6WGYT/pOUdXLZyR4xy5nMZocx/2Y01jAOrzoh7
	codmz9gEB0qoaZSnYE+pL4Nv6rlt9d8vo3/hPYX5a4++drO3jZLFEwUbkydLkqCZ
	mEaylbxP6s0hUeNL4pXFFR7WOxCePoE2v1V5NsHAGgF/PoyojVv6IlhlhXEa8YUd
	dVWXbWkkFD+igl8qN5FIQrKojPK8aARHh0y8i23OV1TKq4tJbynIj4rLVQOO8pwQ
	B3p7B7GuHcnpHc/gg5ph2LAId+zFtg2fa8X2YQQG8L5vdz1J5klS3x8PVLHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768207251; x=1768293651; bh=DEFUUuGl9VdJ0kZN+PJIByKe+K98AYFOFuA
	3y5r7yP8=; b=Lj/bJFI15+NXww5Dmo5VfUA8JnkZfhwKaXs4XCzWEQz2vPapEmL
	GrLOStRW0ZpcwRuUAyJgbWdfmWev76rnYjvUbrlqg7c/GO0N+UGWjuCTFQ5EE7RS
	9BiqjbkHef1RP/NPoWC3WXIzGYu0lJl+Q5RtSxFI2PujEQdHckiklEiCShZuLuxB
	OoIYRKYddL0xfnZOcuS8MCLsYXDq6FDRRXa6OStorN/44zhfKwxHAvU1R7/X1lD9
	3pTpa41wGJkpNJib4YnQNOMpZZL3BB+1K3BJ1xclhSGDgr4NpJm84RXGIAU5vqkp
	2PEoB3D0L7OrzB8RzGPVtBSUxF3607fy9Tw==
X-ME-Sender: <xms:k7NkaRev3y-XO8GEk8XyxvJA10cmT8EqnLh7_mO198g09bLC-4scAQ>
    <xme:k7NkaWP37hdQ1KjE_Lgd_gn2gVfhzOkKF3SJjcgtUA5EcLu7NefpNwIX8U4VLRXE0
    S92zqUMZsjVdTOn5NvMv-ftTRU1fJI0cuvnOzKs-pFoigqBg9lU4t0>
X-ME-Received: <xmr:k7NkafhUMDpPm25qyhYsb9Cv3eUyec--t1suoJYWs5XOHgn9NFllEsUHWabG4jqgozkwrfX_OeFoHF-OjJjF8HlxxJsy2wXkFGXfNi5vqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:k7NkaZ0Lq3BhenGl5kDvTZ_tOFItjTOqTWKNziGKoLDqCq1VgS_5NA>
    <xmx:k7NkaZg1QC2oAoOM11AyfRRVDbt_yaDog1YyLiu7PnOvvz7m8UeNoA>
    <xmx:k7NkaZevM3sMkNyHWqAtST_oQMzr9p8aIF1etIKexjpuHm4LeUwsKA>
    <xmx:k7NkacmA4j0F9pm3yfZWwuqL9TEPI1i9CicCm_APDvUhKthlVFRkwg>
    <xmx:k7NkaTBhurSf3WWK5kYZNyM0JkuQhlXUeQ8u9Flf03mSBx8nyHhSEBzB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 03:40:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id adb577f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 08:40:49 +0000 (UTC)
Date: Mon, 12 Jan 2026 09:40:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com
Subject: Re: [PATCH v3 2/2] repo: add new flag --keys to git-repo-info
Message-ID: <aWSzjnqtvpwYnJlX@pks.im>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260109211554.90828-4-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109211554.90828-4-lucasseikioshiro@gmail.com>

On Fri, Jan 09, 2026 at 05:31:53PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index fa0e6600af..4471816cc8 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -47,6 +48,16 @@ supported:
>  +
>  `-z` is an alias for `--format=nul`.
>  
> +`info --keys [--format=(default|nul) | -z]`::
> +	List all the available keys, one per line. The output format can be chosen
> +	through the flag `--format`. The following formats are supported:
> ++
> +`default`:::
> +	output the keys one per line.
> +
> +`nul`:::
> +	similar to `default`, but using a NUL character after each value.
> +
>  `structure [--format=(default|table|keyvalue|nul) | -z]`::
>  	Retrieve statistics about the current repository structure. The
>  	following kinds of information are reported:

I think it's slightly unfortunate that the default format cannot be
explicitly chosen. "keyvalue" of course doesn't make sense, but maybe we
should have a format "newline" that can be specified?

Other than that the patches look good to me, thanks!

Patrick
