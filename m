Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1324E27465A
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749141237; cv=none; b=pi8NkTCMmX0LSDbNmCzGkVlUixauZa4ccDHOLD+CSj59ZaVXiE4gQCm9mP2eZpWO3tp91c6wqjNRZrDbybMi9zZJJUhFLYtjzOvtr5qhn2LAqv8/ABoESNHAAQ1y3kHkS2cXXYunHHK2kb0vgyY37Gz0Bu3sih97mG9K5ZFDuM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749141237; c=relaxed/simple;
	bh=mjjy9ZL61w6RaJv1vqt+h0cXueP3+hqSFNztKU/IKM4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WuAbIAf4hhrK1o8E1+f2rV7dwfs7ECCgonSSTpVtZXhGXUkxKqQyoWQWTAVjyL9TiPbv1siAMo9ZZ8u0LrpCZ8BzLh/4xgR/JhcT1wHU8Cp0FFC2VcfzpHSsG23RqBMIqQE3HFlTur0F1jBkQ6aYDKZU5F9Z1bfu0HjjZvmt7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KjiKucNL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N78fWdZy; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KjiKucNL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N78fWdZy"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 03DF0114012D;
	Thu,  5 Jun 2025 12:33:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 05 Jun 2025 12:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749141233; x=1749227633; bh=N9TtL/pvNc
	tto8xt9bMKTLSefhvIH+8ZV15YJpGWtMA=; b=KjiKucNLFUi1wLhf3W7PHTNCgT
	z/noL2lNfOVYW0XzVZvwCJZZ/a9rwh5sSEZFeDJD3STTLUjeYnIXHlv4weEphmKM
	tz03DlHC/REeOLwyDpLX7sJLX5NJ5rGUbdS+pHa5Y1aOEdq+3NPRMc283t5BweZi
	4v3LKCknr004/znG/3q1GO6FEDrSSUVJzAyYyA9QH6rm1HgCq8zRT4EX1Ub2t67u
	vBs2gHbnB7jGNJVTRmHuxc2vfWYTrbZ/V96wDkH7IWqAsA0HssY419oR527kAm6T
	Amm6/NZB3NHpWtvjr01c/K5LziAbTBw/ZQkbqhBuPiUv3IfMdKYSeEzc/lWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749141233; x=1749227633; bh=N9TtL/pvNctto8xt9bMKTLSefhvIH+8ZV15
	YJpGWtMA=; b=N78fWdZyfdZMbEIPRMLyKAoLCriTvKUjmpYAOD8pRHIapsAx0Cg
	JpAL9D8EVAzzGzML8C6wkQkd9lro12eytyIuySCgqygv3rrDZT/cwQ0uwAYqEzat
	uAWJ3pOgk+GbOMdf5XpRC6VuMNGiNjEm0bGvlWZPwVC04JbiXzXx9sIIG7sF+4K8
	BZRGt62+EJKRy8MvB6ZjCPBedjeL9WUyWvbZ36RXH7w7q4LxYUird7QmZyXvpFU5
	h+StqnNdMNQvh3AAbhieplE6TRFT5Bg6cOyVSribS+Sdr3Ytrjru/w5Sd7I4KaHK
	Fs+ZdJ1blGcXFYQpFQt+Jsec6zBXZe3LeQA==
X-ME-Sender: <xms:8cZBaClfXmROZbcL7rXgK5Qsnyqjm3tHyZjfFirsz_i6kFr00FtDPA>
    <xme:8cZBaJ12bxUgEo1KFq5TXj3gJPFYUAb6v8tUCB5k4JqX6QCma95zK9uE3Ykv2xpxj
    rDrZqtjJfN32_CLMQ>
X-ME-Received: <xmr:8cZBaArnIrsTLFrSUmzgII2avYCU4tS43ftnczgBHzrWCL5_2i887fI_qC8A1RWIhcW7_XAs-0TPZpWdrUmLRFgo8Y-5-idpwM5j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthi
    grtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8cZBaGnHiveSZMawstv1fGCiZYPYg9kbC1qK2F7EZszuX6vh6OSU2w>
    <xmx:8cZBaA0CTzTthu0fquHE9CZT-I2l7Gr0W_j2NHnQA0MYvI1hSFdFuw>
    <xmx:8cZBaNspXuxpDRZC9aBOLvJ6uiN4E64gizBTX_gu0xaLHWiwEOQG6g>
    <xmx:8cZBaMUlNDCtqmqoVoEbftykYrKMIEEmZPtLp0j5cMBSqOopCJhwEw>
    <xmx:8cZBaDyPBDfwzC_5XiVIfPW4Rl1mQ3rmSd3VKTPFGNBUpCC0sNy49l_D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 12:33:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,  Ben
 Knoble <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v13 02/10] imap-send: add support for OAuth2.0
 authentication
In-Reply-To: <0d28e337cfe7ce3c52490544875474b3502d2081.1749112640.git.gargaditya08@live.com>
	(Aditya Garg's message of "Thu, 5 Jun 2025 08:42:25 +0000")
References: <cover.1749112640.git.gargaditya08@live.com>
	<0d28e337cfe7ce3c52490544875474b3502d2081.1749112640.git.gargaditya08@live.com>
Date: Thu, 05 Jun 2025 09:33:51 -0700
Message-ID: <xmqqy0u687ww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> +			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
> +				if (!CAP(AUTH_OAUTHBEARER)) {
> +					fprintf(stderr, "You specified "
> +						"OAUTHBEARER as authentication method, "
> +						"but %s doesn't support it.\n", srvc->host);
> +					goto bail;
> +				}
> +
> +				#ifdef NO_OPENSSL
> +				fprintf(stderr, "You are trying to use OAUTHBEARER authentication mechanism "
> +					"with OpenSSL library, but its support has not been compiled in.");
> +				goto bail;
> +				#endif

Ugly.  Can we avoid #ifdef/#endif in the middle of such a main flow
of the logic?  Hiding such ugliness by indenting the #ifdef/#endif
directives as if they are just one of the code lines is doubly ugly.

>  	server_fill_credential(srvc, cred);
>  	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
> -	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
> +
> +	if (!srvc->auth_method ||
> +	    (strcmp(srvc->auth_method, "XOAUTH2") &&
> +	    strcmp(srvc->auth_method, "OAUTHBEARER")))
> +		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);

Can we clarify this part, possibly with an in-code comment?

"Unless XOAUTH2 or OAUTHBEARER, use the password" sounds a bit
strange.  What about methods other than these two that are not a
plain simple password authentication?  Will we remember extending
this code when we add yet another one to exclude it like XOAUTH2 and
OAUTHBEARER are excluded with this patch?

