Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC40439011
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544449; cv=none; b=bCbo8XeJXwiV4nvla3NZZQOMwZBf5dl0sh2V/rtaMyLrav2V+V8cpPAgWfrmQ6uLEdcwUup6/A6iGptiCG2tvCGzvTTghJjhriPmzpyG5DIasKjYx282NYC6JRpLZQv3Apd2/s4c899WlgSbmvmTzeRqADNAhhX++cXqytQo/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544449; c=relaxed/simple;
	bh=QnllbctvFdokfbx1x3weozUd3w/n6lkoW6kFf1t2uE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXccULpxpisuNp3VBHApMX1i0I3HNAswTg1rS88YuBxzJnMQ9lJrChMj1S0ZtvXCRnXHP+vwwo2vg1p4GyDZSoOfVQt05hXOOmKCiGPZFEa6OSTAbCzr58gK3CsiPq5nfcv1HSoVDUSFSUnPocgCHthuUpuWrTYo/xTth07Y0kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bx+zfcUB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OUqI2hvd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bx+zfcUB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OUqI2hvd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 098591400159;
	Tue,  3 Mar 2026 08:27:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 03 Mar 2026 08:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772544447; x=1772630847; bh=8swVE0TqmG
	W1rCld1Z1w05zm53bDmOu57YpTZAtyzwM=; b=bx+zfcUBTN/1r1krNO1BntVvIQ
	bSa03bSKL9jAYU5EpBzlrhyIJ4uIAlPM0WJVxwaZIdGn84OhTdXH0XSKX7A7+eMX
	6Fqe7yqyPHff14F6XxN5RQ80nHowM+xDNNHW2lYf5WCXIGdm6paRKk2xfT5W49N+
	9rJ8uqHfny9cT8z18AzW/RqSTmn4yphoFTIGCiV9r9QOHiXShI6xnMsw4q8Jfuv7
	x57fak8/MTKzXTuaexHRrH6xw7PMnV5h16M0FQQWi731aIzmx670SP8gyPFrkrMI
	9kcxiRWkmOFb33Ndz0orjya8exKhdTk6kAt+QQwe89SF2At2dFOjgU5bsLcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772544447; x=1772630847; bh=8swVE0TqmGW1rCld1Z1w05zm53bDmOu57Yp
	TZAtyzwM=; b=OUqI2hvd25vIH+k2osu+XwBUcH23vUvpeNrCb+GXK/GsGzAyPst
	8JYkD/SyUNsWpoGwUCu0XIhMG7D/EOKLKfwDZQTYqseYbshpNqMc2aSfkTHK5316
	tpB3j7fnV4VwSy8wUjgs9Rfo9z8tQKuco3U/NBHC5Dk80YjoVEmwVTWOE3ywsTx3
	gGU4beURPdUKoMzRYxVsVc2sPchcoDI454o1eUxal9t8YH9VpAjGOt32Yer2J3Jf
	9SqLzGMYfB2VQr4iOcPNjJB7pqpd2q6UkyiLQh8H7FNXKyAzrm+aKGxlApBGV9qU
	sBnExyigVBy8MfK/3YIgsiOe1y0ILVt+OCw==
X-ME-Sender: <xms:vuGmaQeRrJ9tRQzP8ozlqV069pl2wKPRkiytJPYO98nRFD8uOtFsqw>
    <xme:vuGmaZHwZuY0cJ2iLPfJLRazHRdy9mqb9riLeVs2zKU9dyVr6xvEjqR4C1nF6vPP9
    -ZaUPeApJ9RavmKc7Ezf34T-Yr2ON1RXVR5lpeZ-HnHyoOakvzDiQ>
X-ME-Received: <xmr:vuGmaZ1GtbysJO0rBWEVjaWN_c_NdyBWIMSiEpmwO1FkqZEd_rjX9gejmcw1Wm1V_7EeAOmNIr9RSuY2N5O3IUKFyN38A9dbVvoC9exu2iB7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:vuGmaRlJ_fp8lrAdA8PTpoyKi3vOUE4fZa8VERO9sBRKgB0KdRbDfQ>
    <xmx:vuGmaZ9SprOMkmOMyrP9qtAt15yJP1VYYiuswh4hlwqeb80rQXcfFg>
    <xmx:vuGmaWphnPzG2MCzap6nA7Dfa5xZ2g7R4DFs2WyRBH7G82TxYj759Q>
    <xmx:vuGmaSn-Cx7fxHJb98lkjs93EOsBnzOgWxIwyU1a5541V2eoO0c6jA>
    <xmx:v-GmaY2kb9EXk8CF3-x6HbvPe-hFRo4qW4z9jgrQc0arQ8lDgZzAn30->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 08:27:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0904ac13 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 13:27:25 +0000 (UTC)
Date: Tue, 3 Mar 2026 14:27:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com, lucasseikioshiro@gmail.com
Subject: Re: [PATCH v3 3/6] builtin/repo: collect largest inflated objects
Message-ID: <aabhurGdiN0jFqkb@pks.im>
References: <20260223174120.2356504-1-jltobler@gmail.com>
 <20260302214526.2034279-1-jltobler@gmail.com>
 <20260302214526.2034279-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302214526.2034279-4-jltobler@gmail.com>

On Mon, Mar 02, 2026 at 03:45:23PM -0600, Justin Tobler wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 782194cf4c..59d5cb2551 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -453,6 +482,14 @@ static inline void print_keyvalue(const char *key, char key_delim, size_t value,
>  	       value_delim);
>  }
>  
> +static void print_object_data(const char *key, char key_delim,
> +			      struct object_data *data, char value_delim)
> +{
> +	print_keyvalue(key, key_delim, data->value, value_delim);
> +	printf("%s_oid%c%s%c", key, key_delim, oid_to_hex(&data->oid),
> +	       value_delim);
> +}
> +
>  static void structure_keyvalue_print(struct repo_structure *stats,
>  				     char key_delim, char value_delim)
>  {

And this helper is also quite a welcome improvement.

> @@ -492,6 +529,15 @@ static void structure_keyvalue_print(struct repo_structure *stats,
>  	print_keyvalue("objects.tags.disk_size", key_delim,
>  		       stats->objects.disk_sizes.tags, value_delim);
>  
> +	print_object_data("objects.commits.max_size", key_delim,
> +			  &stats->objects.largest.commit_size, value_delim);
> +	print_object_data("objects.trees.max_size", key_delim,
> +			  &stats->objects.largest.tree_size, value_delim);
> +	print_object_data("objects.blobs.max_size", key_delim,
> +			  &stats->objects.largest.blob_size, value_delim);
> +	print_object_data("objects.tags.max_size", key_delim,
> +			  &stats->objects.largest.tag_size, value_delim);
> +
>  	fflush(stdout);
>  }

Certainly makes this part easier to verify.

Patrick
