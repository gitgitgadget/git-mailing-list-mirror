Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B82165F3
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285802; cv=none; b=DG/7bkFfU7tC1RxF8NwU0HkMt3HRz89wraDHiTB4RJJMa+OcP1To5kY14SEAd+ScKd20sVxxv0idY8y6S+N+HFGSkO46jUecnEVOdJmptG9plhRGcUMG5hTcD5kAjiOqJIuhD7APmI3x7X2XgD1eed+HE0VtEF1ZhLPDru12XBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285802; c=relaxed/simple;
	bh=lgWsZl1RGeSGUgsREW+f8eSvPp0NAfgjPjv0WL9uxQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BKACRBmFmVu6CGgOWE8lvcmkBlheYD+LaecR0hHVo23jmrCSeKyJow5XFEQQJ3c4RIF6iKHizW+GzG/z/19s08BEeTJJ8zqwROStN31dFSX8K8YXroVLM1QXMyXpUa7U+3UEMzNnv/RNVZ78/ltFgihdv1xT+tsN8nF61rvOHmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VvNhAO1W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LR2iSkT8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VvNhAO1W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LR2iSkT8"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 71B161400075;
	Fri, 15 Aug 2025 15:23:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 15 Aug 2025 15:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755285799; x=1755372199; bh=qSGk9U9A6/
	f2tVdQleiJL05mxbzMLkcE13QlxE3vlP8=; b=VvNhAO1W/Slw9cS2ed02CxhNoR
	UG8B4GPBhP8Q6weXfZU4PfdDmKlqsaPQpPwQ2o6il0zLZv7WFnCRcUWosPkdLe8B
	Nvbu3zdth+HjmSu2mVAmIKDGqX4dqoL51jN2Rz0+Yp2hemuDBO7b0+mtiQLeO/aR
	1Yu/Ycgm3AX5nJwPtI8vRPHLhOk2s+PyuKntzxFmA0YL6E3TKtjiaETK2hVqL89E
	AmL1+Bdm30kEcc7/RutTwHP299Lj9yxK3qC0uP+x/Sgu+fyWNxej/UoDDH8qAXNA
	pFuDRP1MYkseeIcob6EEbWJCK6HS1CMl/S2FlafBtKQqxqIXCszznf0pVuyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755285799; x=1755372199; bh=qSGk9U9A6/f2tVdQleiJL05mxbzMLkcE13Q
	lxE3vlP8=; b=LR2iSkT8JW+Tcd6A4fif8Ub52YpzdiYn0R8LjcGR8JGgzWOAb4s
	w3bx4qgQRHfTufSLga+j6JRaABtAPCPm+j0kLdsBMGfXNH4ohtR0RPorkNaHt5gF
	5FcnbXApwcJVNHZbK8phYNl7BlgK2PBeLix2Qar6vwN1LSEzEz823WHO92jXeDNQ
	F4j/Dw0zfe90hVwjd9YdIohyyuMO7nu8skVkX0evG/Iyxt6XVVhKKl3hp+63+EVa
	1nEEc3JtEjMC7yhD3dLPqyyc43gkA688oMTuXLB+PUWxrLme17nFUaBECdolGnkr
	0cgsCbHquE+jdot6WHJXe+x8Tln31Uv1C7w==
X-ME-Sender: <xms:JomfaFvavJquTcCGJLwS4-qDC278yG8Q2y8_B48pWMwG7EKHaz6J3w>
    <xme:JomfaHH-yLsapGTrVxtcs17Lvti38UGAlzyaRpJHPQgWKhfKreZvz8rsN5ZhzN4Tv
    UawNEcXyM083FFv4w>
X-ME-Received: <xmr:JomfaAOvPg5mmI7xnesMGNeqPSTvBjmRd3O-ZFQ71QuU2oYX108yfK6NURkclqcrpj4QXhZdKRgDjLYANqix6ER-0HjibBS7f-bp_ec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjnh
    drrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:JomfaGJRfCKVuGWHiC7cJMOSOG5_wZX3Wp4NIOcH7edr8THNy7aTRA>
    <xmx:JomfaJ8dlh_Yv0csqPSnhN9ut2dopYrLP6rz7uEjHUAqyHJw0IgviA>
    <xmx:JomfaCGwbEocI8oYaTVhGHMV6TlVzjBAttil2q_wnFgaSysstoha3g>
    <xmx:JomfaE7hnoUjpPI0PDYbIc-bK8wym6aM47lKrgIiMMiR9K3OVU7RhA>
    <xmx:J4mfaM4c1NeArAMq4H1wLIJaGb_pCidNp90o8tAOcp-PwfMxeMkF5nwn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 15:23:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  oswald.buddenhagen@gmx.de,  ps@pks.im,
  karthik.188@gmail.com,  ben.knoble@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com,  jn.avila@free.fr,
  sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v10 5/5] repo: add the --format flag
In-Reply-To: <20250815135521.44044-6-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Fri, 15 Aug 2025 10:55:21 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250815135521.44044-1-lucasseikioshiro@gmail.com>
	<20250815135521.44044-6-lucasseikioshiro@gmail.com>
Date: Fri, 15 Aug 2025 12:23:16 -0700
Message-ID: <xmqq5xeoqti3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Add the --format flag to git-repo-info. By using this flag, the users
> can choose the format for obtaining the data they requested.
>
> Given that this command can be used for generating input for other
> applications and for being read by end users, it requires at least two
> formats: one for being read by humans and other for being read by
> machines. Some other Git commands also have two output formats, notably
> git-config which was the inspiration for the two formats that were
> chosen here:
>
> - keyvalue, where the retrieved data is printed one per line, using =
>   for delimiting the key and the value. This is the default format,
>   targeted for end users.
> - nul, where the retrieved data is separated by null characters, using

These characters are commonly spelled "NUL characters".

    $ git grep -i -e 'NUL ch' -e 'NULL ch' Documentation/

Same for the explanation for the "nul" in the documentation.

> +
> +		switch (format) {
> +		case FORMAT_KEYVALUE:
> +			quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
> +			printf("%s=%s\n", key, quotbuf.buf);
> +			break;
> +		case FORMAT_NUL_TERMINATED:
> +			printf("%s\n%s%c", key, valbuf.buf, '\0');
> +			break;
> +		default:
> +			BUG("not a valid output format: %d", format);
> +		}

OK.

> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> index 78766a3f4f..a4ec6b42df 100755
> --- a/t/t1900-repo.sh
> +++ b/t/t1900-repo.sh
> @@ -21,12 +21,22 @@ test_repo_info () {
>  	key=$4
>  	expected_value=$5
>  
> -	test_expect_success "$label" '
> -		eval "$init_command $repo_name" &&
> -		echo "$key=$expected_value" >expected &&
> -		git -C $repo_name repo info "$key" >actual &&
> +	repo_name_keyvalue="$repo_name"-keyvalue
> +	repo_name_nul="$repo_name"-nul
> +
> +	test_expect_success "keyvalue: $label" '
> +		eval "$init_command $repo_name_keyvalue" &&
> +		echo "$key=$expected_value" > expected &&
> +		git -C "$repo_name_keyvalue" repo info "$key" >actual &&
>  		test_cmp expected actual
>  	'
> +
> +	test_expect_success "nul: $label" '
> +		eval "$init_command $repo_name_nul" &&
> +		printf "%s\n%s\0" "$key" "$expected_value" >expected &&
> +		git -C "$repo_name_nul" repo info --format=nul "$key" >actual &&
> +		test_cmp_bin expected actual
> +	'
>  }

This is curious.

If my understanding is correct, the --format=nul/keyvalue affects
only the output format when "repo info" is executed.  I do not see
why we need two separate repositories.
