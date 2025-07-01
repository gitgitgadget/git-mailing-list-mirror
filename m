Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0354326463B
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369751; cv=none; b=rqhvM5o+l5G5zLVcZJUdbZRVScTjnxFhD8pHx6g8p8ZJ91FK8lSjYQxBqXx96AHYxU46T5O/bzFV/vFktToqcIWgrPfXyLeKKlvbtU5mO3LrrHYEO3HdICBFjd+kQPaMa6asCQfTQmblHvOhs1qoFnKWKmx6KsFD+dWF+tJ2hWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369751; c=relaxed/simple;
	bh=9QDFK4HUFJHOUXYjjoosfs7je9sId45sukOJwC33ULo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBGUodqfBdEbbIZ1TBeeIPH+WQdHnBrH5gXMk06HbX5Oo8v0QvIPVkKpXOlO2zAxCfKPm2vONMkKR2y7iHRwlgBz0Wui5WerGWBbv5XbgiTgBS77u4B1VEDmGGg7TFm2XiUFBoaknOgXiSFPvYYVKNDpSPZ2welaoUmFyP1Jjrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DC6gkpSQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ASlVvrtp; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DC6gkpSQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ASlVvrtp"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 416F91D0021C;
	Tue,  1 Jul 2025 07:35:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 01 Jul 2025 07:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751369749; x=1751456149; bh=KpYb5kOqw9
	79z7Z9kK2Wg2ImE7XIEIHtyg4y7ByAqh0=; b=DC6gkpSQ6OnODfMddXT6Z3lO/l
	08CxyjTyi60d3FBAZmuNCAt/NVc65/kSa1GkHYwJvyqSuoAxTB/iT4g/7iLuGJKN
	/ev6tHX9ewVTjNCNnfj8SqUVNDZXsU+D++HexojipcKN4aPBtz6ezMNVyL+gf60T
	dUYY08teAPyj6ea9Sic4T9ouEgydSFS4+hnmfUxrJCXu9hyPxqd5EQ+Icct91+d/
	v5wrnC7JVzyA0PKMidpRspo/4c0cCTtCuxwPCa/RDYUkLrs99hOeGnimJhbdihbf
	Z/32rza67BlHHdKQ3CpZi6qPJsxdPf3L4XcRjOhcDvR+R1rN5/kvWd5b4FVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751369749; x=1751456149; bh=KpYb5kOqw979z7Z9kK2Wg2ImE7XIEIHtyg4
	y7ByAqh0=; b=ASlVvrtpKeilnz5MKKql6r/Uq2QwSFG/uI5e54UT/GSWwLdCNqU
	wDvWaH7d3O8kjk2OgsCX7UCdRcuYVTIz5YHjaM27dwxkr8WNgDczkpFzQEMuscFI
	OABlcDpcmI/wj7zEMsQyXQzzP8ez3p+BMfUr3a6vqsm81/YAQ1EpUS/9LlBQEYpR
	80t1Jcs1UCKa66vJLAOE0eEGGZYJB4HD5hcJz3+jv6VMQ9cTCL2bxrnJuwUxDhBs
	obaVKyecUSZopne6KHrNhcQ9KKsd2baWCgBESo06AZwtTyWUqED01l2KBhnxjwwa
	dMurldD26T+vBQuozwQiKnbsO5fW8Mw90VQ==
X-ME-Sender: <xms:FchjaAMm2ruQxzhL30_l-svN-ew95s_UZIkv1XgkysmO_zjEb-labg>
    <xme:FchjaG_9wuYeHTecc9Zx9zUJJQaLYdCD7WsjWdg91-CaHiNh0In5Usy2tq48cKLUP
    MlBPpBbyw9Cnxq-dA>
X-ME-Received: <xmr:FchjaHT6a0wEuXEM6dkj9reuOZka6UUws3Wp-s4Mj3bQrqXV7_5lNnaeOtNZtGne7vCRPpAOMqzn2ZsS8Fl0tTYx0VH_jxzmrkSYRis62g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FchjaItH0UzsAAzuI-TN9PLkFcWdFhfzGO--uFdy6wE5wLMlvcJ58w>
    <xmx:FchjaIccynUnHXKLfApeSjq_GNQMfQXHVyYq5thyZQHtv8iOgnIhog>
    <xmx:FchjaM0LCpxeACzblFdTzr_2omXbtHPtfE_GIcL5mjhzRfKDdtQ1gA>
    <xmx:FchjaM_FepD08Dzc1CUUMgI-5ZrUTapIRIh79lva6A41VkgCkn50QQ>
    <xmx:FchjaKFE6-pdXq0d1-cycN4cuGlXC1AIMWkmQtd9U8KWdZlQ5pELg3og>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 07:35:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f684ab1c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 11:35:47 +0000 (UTC)
Date: Tue, 1 Jul 2025 13:35:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] Enable SHA-256 by default in breaking changes mode
Message-ID: <aGPIEHG8e0i9nzxV@pks.im>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250620011943.586596-11-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620011943.586596-11-sandals@crustytoothpaste.net>

On Fri, Jun 20, 2025 at 01:19:42AM +0000, brian m. carlson wrote:
> Our document on breaking changes indicates that we intend to default to
> SHA-256 in Git 3.0.  Since most people choose the default option, this
> is an important security upgrade to our defaults.
> 
> To allow people to test this case, when WITH_BREAKING_CHANGES is set in
> the configuration, build Git with SHA-256 as the default hash.  Update
> the testsuite to reflect this configuration so that the tests pass.

Awesome. Thanks for advancing our migration towards SHA256!

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ef3759ec80..bb18dd0606 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -536,7 +536,12 @@ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
>  export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
>  export EDITOR
>  
> -GIT_TEST_BUILTIN_HASH=sha1
> +if test -n "$WITH_BREAKING_CHANGES"
> +then
> +	GIT_TEST_BUILTIN_HASH=sha256
> +else
> +	GIT_TEST_BUILTIN_HASH=sha1
> +fi

There should probably be an option somewhere in Git to ask it what its
current builtin hash is. If so, you wouldn't have to hardcode the hash
over here but could ask for example `git version --builtin-hash`.

Patrick
