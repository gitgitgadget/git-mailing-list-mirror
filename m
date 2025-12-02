Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20492153D3
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764641114; cv=none; b=cdJrH6a6Hu6Hwx61md/XlH0AhtRgyqZZXPYDkv15CVCqX5P3F4fae4/m7VZ78zTEvENzUq2QSXlJ6RSwKud1oto8P3qNAgOFLSGsaZ+X6uEzVnkLSztonG+KLS0A5RbB4EuVwXDefRdMUJ4yaB0lBrvvG2fL5JnsgtRcuj/zoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764641114; c=relaxed/simple;
	bh=15L5FYZu5an4nCra2Huz2pKPtBFUloXjfYHaZ4voL1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hqwfcVdegXSqLKjCtIWpqosRT/rX5yw4uv4QcBJR+E+W3ZoysgOzwu9E0C78n1oLCNO4f6xjDAq6BzBtO+gnebTN0Jkk7zHCcvPuZTBvbKiPTTJvA+lch0WA2LOMEbur/19OvaYDuTApPAr2g+V5UBMDKMtTBOnHQZISNNYf5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IhxWThkZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wT9lLmSE; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IhxWThkZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wT9lLmSE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A5D45EC03F8;
	Mon,  1 Dec 2025 21:05:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 01 Dec 2025 21:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764641109; x=1764727509; bh=wfOTHqxwCr
	NynUTfrA6q5oS2HaUkk1NCdF5I3ytnkwM=; b=IhxWThkZfOjrYj7KNbuvXb84AT
	hH4byDR+98xm4vLijayRoLhAkGQyCa57uA1GUgV3AmSAj4k76nPOW9jTDPJVcUlF
	B+yx8ZKVhdNH32f5dqqQKLVJle2cFKsuzmeDovfT9uhmw6MV42k3ETDKFBinl+Jy
	h9/JSz5TI3iinwcLdy6eK/Ic63T7Hi1JC7uh4cyXXqt7B7rtFVoe3YELELnDJm1r
	VMU1OT1/r/sjpkZd6xj2lPkZrjfX6y4Kdcr6tJK3ckrXqQb1tHK2N4Kzc7SmFeO9
	HMIr+BlwUdG8d0qd82Ldrke658Ui6d6sFfzxYguRtlyQvxc3yyKz75DEf1Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764641109; x=1764727509; bh=wfOTHqxwCrNynUTfrA6q5oS2HaUkk1NCdF5
	I3ytnkwM=; b=wT9lLmSEnshHA2iGVWa/hGG5XsfejPaJaDmvUlFQllbGnm0SyHs
	Fx326g0+dzKtt3vq3oda7Yfdq5srv0/eTb2yjDs9HkkXs2MaYX8+gLqe1pLciEbN
	YEENy1V1fKjklVJBDjwOBMXhUsUlXzH6iTR8eO1zSxJIoLAuTct4tmK41tMQM7p/
	+f1IRRlOJ0FRNljXGCJh5HMVIXdb2/tH+9elBmnvql7ZqH1hj0nf+soB2c/+NAjK
	oCHpXvHwsZ/57kMeMWat0YNbgBnm3XIAkEI+Rui3W27o4o1wR9mzqIG1Hj35Ah0g
	69ntzg76MG+bWdpo1XUBV9h7FlEuyTzk1Ug==
X-ME-Sender: <xms:VUkuac5wDV4K7TByVGJkvFk75U0iP9L8MnJM2DCVWEdUrCXl9auJxQ>
    <xme:VUkuaQIgyL982VeRJVENYEFVPegPP7q0G7FMKi7qS5zeacIdfgFDVAot0_X1h3HOF
    Vkk4WHVid9RtXbYzIuFSLp-MtUMKMhEzJdSQq5OZISISjZLBF0zoQ>
X-ME-Received: <xmr:VUkuadtIE571UvnFe0tT8AAgr6TeaY56SRKnMso_V5yfmB8zoy7G80rs3ZOrsDvtnAX5bzQ-X02B_oAmSztbmLovfBL-gcGea4qT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheelfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtoheprghtthhhvgifhhhughhhvghsleefgeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VUkuaXI1PkSeKQ4oUdSzvVsYFsXxbQmZHlBgbFJB2V7xJGqPZSSolQ>
    <xmx:VUkuae8BTluqJst2epYlk05s8tra983R8kGIqhtNxZAAPZCd7_SvWQ>
    <xmx:VUkuaYzslFIj5BXTD0l-cJrh2G2yCsFv4e_PA5dxIlxzAWIxGhw12Q>
    <xmx:VUkuaT7b2OKwDCA8myj2ysd3k9Nw9rPSNyhRk9JvxRY0j-quYGVbnw>
    <xmx:VUkuaZ0sTN8x4kyLIxHs_EmCdG_lXHN9N-tyyv8dkeEvykwaDevvoFa3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 21:05:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  atthewhughes934@gmail.com,
  johannes.schindelin@gmx.de,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/5] Audit and document Scalar config
In-Reply-To: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Mon, 01 Dec 2025 16:50:42
	+0000")
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
	<pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
Date: Mon, 01 Dec 2025 18:05:07 -0800
Message-ID: <xmqqwm358wq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      -@@ scalar.c: static int set_scalar_config(const struct scalar_config *config, int reconfigure
>      +@@ scalar.c: struct scalar_config {
>      + 	int overwrite_on_reconfigure;
>      + };
>      + 
>      ++static int set_config_with_comment(const char *key, const char *value)

I do not care too deeply as this is a file-scope static that is
called only twice, but I would have preferred scalar_set_config()
which is a lot more specificto the purpose of this function (and the
comment "# set by scalar" is hardcoded constant in this function
that its callers cannot affect, so "with_comment" is not even a
statement that "the callers can add comment to their config
settings") which would have taken a bit shorter line to call.

>       +fetch.unpackLimit=1::
>       +	This setting prevents Git from unpacking packfiles into loose objects
>      -+	as they are downloaded from the server. This feature was intended as a
>      -+	way to prevent performance issues from too many packfiles, but Scalar
>      -+	uses background maintenance to group packfiles and cover them with a
>      -+	multi-pack-index, removing this issue.
>      ++	as they are downloaded from the server. The default limit of 100 was
>      ++	intended as a way to prevent performance issues from too many packfiles,
>      ++	but Scalar uses background maintenance to group packfiles and cover them
>      ++	with a multi-pack-index, removing this issue.

Nicely explained.

Will replace (when I land).

Thanks.

