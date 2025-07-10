Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2427F2EF9CD
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164259; cv=none; b=TNDWDHRm8ygMOQLtnCN2A2tUFR5Q1NUjrdRoFzP+QttJeQ8aGuESa49gK7VZEhBbiyIXAb9v5YsuK7ecry7bSyhfff9diaH+nxl3HwnwTqMDeoW+NQnaJub/lfUWNNsGN+LTr1yj+dyvf0/8s2aXRcktGPOrt5+lp2yzWcOvZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164259; c=relaxed/simple;
	bh=TGrBIXDqWz/Xg7YFMJbOaNj2iDtzfXPcgfW/TNw5sGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nrcEwg5DiXDamYHfWj5C/Q385todLiukvAlVs92dNABFjb+KqNkElf2fSFvj5ETj6bnSRo2WK2UBWtz5lHkTURfID3ZWSOZEbLFpZp1sxt68fv+XvSW4xnGzbFJTN+QYZO3uocvBwZR1TAGhc/Ro9n52gw+i8Um17R+LxvETaeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H++mGDrg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HYYpdNYK; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H++mGDrg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HYYpdNYK"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 363FF1D0025A;
	Thu, 10 Jul 2025 12:17:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 10 Jul 2025 12:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752164256; x=1752250656; bh=4Y7MZIAbny
	nJ1JG0SPKO+KzrPs7OfxCaY0HFUMaRToY=; b=H++mGDrgsIPsnM+E+ck6ZC5S+z
	hCZXhUUXhL0NU74TtEH3thQkt7CgCpgjbJfmK8VRnnJjJlKWn/eVdFzgWuXsLehy
	TFi8WW5HrD1YGyc+MPAjPS3pOnuL7139al8EzWCR3lPgmCE4vO8opMyaoZi3C/tV
	4b3FChjPBatsXoEas0uXVkKImAXMJL2sRKebn9yTC0W9OjWqPN8ztqR1GBv8oicK
	GFFtOw4VB1h6eqJBfgDwD9yRjrtF8JOOBtyLYyp52YfPokM0Dzy5URSIQAQ8qDrl
	a1lk7OIl+EDxS84/5PURknJEmf39QIW1LGDu0LIcHlWts8Cn9JilNLzKrGVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752164256; x=1752250656; bh=4Y7MZIAbnynJ1JG0SPKO+KzrPs7OfxCaY0H
	FUMaRToY=; b=HYYpdNYKbVnDdvl8RjsI8brMrsA18Q9YGgMfU4oc3PGr+tQ8VhT
	JY2heFYAb7m8pMZ/EXs/XSYUeoZHpCQgSr0bNwX5DA3lFhggKMN1oe0lbsLFPTL1
	6SsAskwK6NOK3mjGu6+3Y1reGeDw3hbS7JuW3Sd5WYoGYRywYoYM0GJhsliJb6sK
	N3rEPuDmLq4dksdBeABuObnLHdkX7pvjNUWCvXcoEEP3kSImRPF3642YWT5a41fa
	VSs460NoSH4986q6IDI34j2GAbdzlu0Me3V4Tx4KvhCUDLMtxiFmDXLicqt9YIRX
	fzsCvyrj1wBKvUsijIvVE8Fbf795Qi4tttg==
X-ME-Sender: <xms:n-dvaL-570SifUhSqphfhYCtXrNQZr37DESh86-sTi_LNGXZUwrCdg>
    <xme:n-dvaFr4QO8BfNIqNM5-gf1MUoVP1gUlZ5o6js5JVSGLE7KIzS9aMoIvqFbcwMySi
    9V_pKLT725cVspP9Q>
X-ME-Received: <xmr:n-dvaLXbMzSYuN9uGU3ReYjD7ZR0YRjB456pkepTm4c9JF0ahvs1mWn_GEDeRuBVAfszoucWQac2figv3Y__myDbPtfcTiu3-SsLMe8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihlughhohhm
    vgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohephedtvddtvdegfeeftddtheeise
    hsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:n-dvaMCEGJuwrfTfavUQDZsk7PJDvxKANo3nHpS_ZN_CbAvO-keykQ>
    <xmx:n-dvaH11otVBI1TLGvI5wjvQdmtXu8TNHyRqIme4m3wHPeXrMAe68Q>
    <xmx:n-dvaG0jbAcwD4lwytUAPurteNmlG8dFY88yHF8ZfQUGEbPPsEBYVA>
    <xmx:n-dvaEAiiw62xlZWb4wqKOKKKgXL2j1nEA3BQKb3qd55Yicx7b_Sfw>
    <xmx:oOdvaPIiPnKOEk-Oo3C8KAk13qn4jJDkbd5xuwdAI2i4v23HfjZ-yFMQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 12:17:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: 502024330056@smail.nju.edu.cn,  git@vger.kernel.org,  toon@iotcl.com
Subject: Re: [PATCH v5 3/4] bloom: replace struct bloom_key * with struct
 bloom_keyvec
In-Reply-To: <20250710084829.2171855-4-502024330056@smail.nju.edu.cn> (Lidong
	Yan's message of "Thu, 10 Jul 2025 16:48:28 +0800")
References: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
	<20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
	<20250710084829.2171855-4-502024330056@smail.nju.edu.cn>
Date: Thu, 10 Jul 2025 09:17:33 -0700
Message-ID: <xmqqv7o06mw2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

>  static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  {
>  	struct pathspec_item *pi;
> +	struct bloom_keyvec *bloom_keyvec;

This new variable is no longer used, since the code to create a new
keyvec is in a helper function and its return value is directly
stored in the array of keyvecs.

>  	char *path_alloc = NULL;
>  	const char *path, *p;

And the "p" variable no longer is used, because the logic it used to
create a new keyvec is moved elsewhere.

