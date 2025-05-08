Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944A921D5BB
	for <git@vger.kernel.org>; Thu,  8 May 2025 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746741338; cv=none; b=G6kiRnv+e3iNg4zaQsimpWUiK51CBcGRMXRlRRlPjGSqFyWSeX8wcv8YcWxRhYDtONYUcEcFNQggDxa7wZGWX4mPz7j/JiZZcbu0Rjw6C9YeyqIfneUtXXRCJveN9yUU9utk627xvL+rmbyfwp/3ZaA6gpNu708uJk0dEno/iAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746741338; c=relaxed/simple;
	bh=qCQFGE2ZJNIOU2hReqnikNODqPWRsLIi8WhOZIGp+oQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mB2utTShOd9sheyw4ueqa/lZdaDymF5/taEkezBE7DFAwjPrA4bhT73sdz8XZ5cAxWOHg891EHI0CR8R4URyqh+HsDUh2lNUgWeLym48TaA+Ou8qQ91CT15j1AAV2myXxHyYPhLgrcnkFaMbt0fpIChOGINLF2HF4OKnVVY6VxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OSsHueUT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o3zk6h82; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OSsHueUT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o3zk6h82"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B15C11400BB;
	Thu,  8 May 2025 17:55:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 08 May 2025 17:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746741334; x=1746827734; bh=v1iaD8k0pq
	aQmhjRg9N8cA7ss2oUigq/TfWmqddZjuc=; b=OSsHueUTyZjIp6/R184sGB+AUs
	ibtE8cTdyThcT/5UuFlWfoj4s9gJWIFj5F7hQL8MHLZ+dWKlTJQBf9HsLQPoY84u
	QR+KdHq3WgBjMH6xIjay4M1yFSK0YLAuAgoAf2MJuc09cR37/WB7incph87m7XVp
	D6sg0Z6JjjhgSasodnSuXKKUo8rslQorkM2GBLbVvg3w5KV7sz/PQq5X74yhAgCx
	NUltrsHgS0nsJ1hhZLHr3zGLFXMZkrp4jIdQUQuPaNTQ+IsHvQAwAOAc1NooJGVg
	gX5nylkmhtZRdHpOBdyF26YnNR9ZUcyYAqiMUWKb3KZTwkAcRrwVQO3eJxuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746741334; x=1746827734; bh=v1iaD8k0pqaQmhjRg9N8cA7ss2oUigq/TfW
	mqddZjuc=; b=o3zk6h82J1zSqSgEDjrgiVRXSB+5K4eyzeehn0+6jRpvQMzCDeJ
	Kk8tyZ4W/rBn+OSAmeiXyDZjk9BO19EDcjiqfGaP+epbADOB8nyFYdrOphNAfETs
	FDOmDDCiX7uyarpMpiX6boUw8ddhm7TMgwaNAAmpCNkHeOC4yncvw7tQ1yEypx9f
	o9POEdkwiJ9LNMOb0uU7xTX69qMuyzRcKp5/aPLrVFf8mvITzzDQCAYk8CNwWp5e
	/CGOKEKirYWl2gCBQ833j/6DXYoMkj1LNz0SXz8JCPxwhXBWuwA58yneXHrCf9Sp
	wtYmd3a2syDa5pkgPcFkfcQ4ScmbCqpi1AA==
X-ME-Sender: <xms:VSgdaBMi7fZpEbF7Mj8dVQUaw9vZtit_-azdCgKK3tREPjLKmufBcA>
    <xme:VSgdaD-wDlvLTAAOzefcIujxjEwtOJod6BlyJdd1zHlOarSrSWtIGWpJnqOyPmEP9
    b8o2pwXrzl_wrfOvg>
X-ME-Received: <xmr:VSgdaAT9DQs53vTycaFLq2KIKE7vrjEoWtLUu9wrpAw6TAk8QOrayc5fW9E42b9giAA4iSkcpksPTTx3buKze8rBlbWRsv1ZzJNf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegtohhnghgu
    rghnhhhqgiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:VSgdaNu-2UIavmgZY-n0A1b_IVSPJKnfTGZJToHSElH4rwj1R66TKw>
    <xmx:VSgdaJfJVjDab_ktaWe2wo__5mXriV3HVKyu5a2UFMPe-2ZIRN-LLQ>
    <xmx:VSgdaJ0bLNg0UPGRQ1honqkeqV2QHo7RHM2zrL0liIKhvuXbnmm-eQ>
    <xmx:VSgdaF9h8Lglfp7_5tC4DIY0dlrVMAu0Tcf4mm0Ua5mJb7BdlqLqAA>
    <xmx:VigdaCrkpV02pVom3MfegLqD8iUAYBVHLMtdPQnMcKH_pRZIRLXTBzO5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 17:55:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Eli Schwartz <eschwartz@gentoo.org>,  =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?=
 =?utf-8?B?Zw==?= Danh
 <congdanhqx@gmail.com>
Subject: Re: [PATCH 4/5] meson.build: correct setting of GIT_EXEC_PATH
In-Reply-To: <20250508164443.1506440-5-ramsay@ramsayjones.plus.com> (Ramsay
	Jones's message of "Thu, 8 May 2025 17:44:38 +0100")
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
	<20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
	<20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
	<20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
	<20250508164443.1506440-5-ramsay@ramsayjones.plus.com>
Date: Thu, 08 May 2025 14:55:31 -0700
Message-ID: <xmqqmsbm4vjg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>  if get_option('runtime_prefix')
>    libgit_c_args += '-DRUNTIME_PREFIX'
>    build_options_config.set('RUNTIME_PREFIX', 'true')
> -  git_exec_path = get_option('libexecdir') / 'git-core'
> +
> +  if git_exec_path.startswith('/')
> +    error('runtime_prefix requires a relative libexecdir not:', libexec)
> +  endif

Certainly nice to see these settings taught to be more careful.

Thanks.
