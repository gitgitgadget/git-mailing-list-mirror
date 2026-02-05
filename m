Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5CA8632A
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318088; cv=none; b=VjVSxQiSrHIKY2jtsOvtEQ47rZnOolYUb9WnZBMwDN0QODg7gofBnwtjMryqHqFa2ktQtvguB2ULkdkPLsphU5iqNbDGmhgtgcLxD/3MkYfA+a9wr8yP7jxFzReoj2Y1d5pAb2BUESgrdOoJBcer4AjpW6LA2IcPcA3PczwYe38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318088; c=relaxed/simple;
	bh=LTucDu1dYxel4kNqvKAYyYwfjYJhL+IHFZWYIAZuqvU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RxkfsAESVbV+mzOUvg7ogEAvN/sgVvbH4i7Ox102NgM0+afSpMY4bjSQZe/hS2e1x4C3EH7SfKz+cltKNpUGL1IcqNseg9kWGIAiWNgozSpIMPyKFDsUnL54/xBtqQviDlIVkVhfFzM/HVO6z4kql6D17TBxFTbgt2Lmb/8hOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HUrIdm3e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZNmFvER9; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HUrIdm3e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZNmFvER9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5189B14000AE;
	Thu,  5 Feb 2026 14:01:27 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 14:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770318087;
	 x=1770404487; bh=uqXw5tM/9Yq3oigJpUb5xg+bYLRmhxD+xWDTO79awno=; b=
	HUrIdm3evnoARbG+KarL3SXdi/YTYx4Pw0Psji6s6skHM0itfB7wTVjOhXvOJPae
	XxrXiOBRL9OqWz8o0SCs7aCZI54I94ho0914BSU9S2+wEkLwi0nUqiXsXnMfvMju
	ieFBNCofmIHMVQjaL12/ra2lXOEOCQxKUzKnOmAaJ/77GsZERPjt5Lbj/rBTT7RS
	qzrRIKYIb7bNPPgLHl42MMXk+n4zfq/WE2zFD5mg7nxc2FVnU+DqVXkZGrihDByM
	ulUlox42gd6xkTJ4lbD+JjwtrHv9BWrYRC1qjaeGb++f/mPUejwhI+yzI38kN86y
	ao5Qz1+c++zqVljMFEvBmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770318087; x=
	1770404487; bh=uqXw5tM/9Yq3oigJpUb5xg+bYLRmhxD+xWDTO79awno=; b=Z
	NmFvER9QQhqZJ3fjciHSN20DzwI/rFfgIRMqe+pSlJRSPLN4Ff0MOJuZ6nbCmYiE
	fG4ubt0erCRW/pNyp3lF1SpOKoEH+zrHu6EAgLxy0qGQA2A7ZbeRPZ9/0YspjCXO
	1RRFGchkGlsUQSij+p75MOM7/0hX1vbVz2V+g1rMxIy2t7+gJS3UBvZnMdhRNQZ6
	E9nMrNqlpcVGXi0xfWEchYYOkrjPmEI04IvVo5aEHFUm8JJrV5dPild4cjf4KC1/
	PpSvDHqaYtm40Z+tVmF+TqzXrvo5Rne+iO3ERZ3fZg6Tm2THC0WWULwlJSAzR/Ne
	3TTM1UKa5ESEf9TsCHzKg==
X-ME-Sender: <xms:B-mEaazmtDC5EhwHoetDyNW7BSzfDByBcjepyHwO8AKit9_vUZnCm5E>
    <xme:B-mEaRGTY-4vMtLn1mPzbEvDZ5mq9M0hKJZ5WPmwPKP6M33vOuTuScSSIYBThoZ6Z
    yEMGDtvM1z1iY1T22BgBt2qunKPal7MXqPGfwDtr6DXZpGbeZrI830>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeitdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:B-mEaZZPZ75_nZXjDczUzGWl4GCGe6UGhO1_3P2CeOoYiUUbhKCiFg>
    <xmx:B-mEaeO05S5_pvC9Bw75DdI_saHU2rHYcxZzwW2OtbZzJHCjJeQKBA>
    <xmx:B-mEaWYs16CBhSPc6T-QzMK8DyZdp-9qC8kFdRNntfORsVrt1kx4bw>
    <xmx:B-mEaU3ZH36jk_siYZ_dqqRDZ-jmGqk1n9R96nXngO66yuw082XG2g>
    <xmx:B-mEaV_hQRLY60xtqYR-Wc4usNUgkGK8CdC7ixECb-uHwrjO_HzkjQ51>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 276C61EA0070; Thu,  5 Feb 2026 14:01:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A478TlyV4oB-
Date: Thu, 05 Feb 2026 20:01:06 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <1cb68e4f-930d-456d-ba1b-b153e7a66524@app.fastmail.com>
In-Reply-To: 
 <fdeef536f649bec811e8335d1c7151be8e352ff0.1770214803.git.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <fdeef536f649bec811e8335d1c7151be8e352ff0.1770214803.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 09/11] config-batch: add 'set' v1 command
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026, at 15:20, Derrick Stolee via GitGitGadget wrote:
>[snip]
> +`set` version 1::
> +	The `set` command writes a single key-value pair to a config
> +	file. It specifies which file by a `<scope>` parameter from
> +	among `system`, `global`, `local`, and `worktree`. The `<key>`
> +	is the next positional argument. The remaining data in the line
> +	is provided as the `<value>` to assign the config.
> ++
> +------------
> +set 1 <scope> <key> <value>
> +------------
> ++
> +These uses will match the behavior of `git config --set --<scope> <ke=
y>

`--set` doesn=E2=80=99t exist. I think you meant `set`.

>[snip]
> +int location_options_set_scope(struct config_location_options *opts,
> +			       enum config_scope scope)
> +{
> +	switch (scope) {
> +	case CONFIG_SCOPE_SYSTEM:
> +		opts->use_system_config =3D 1;
> +		break;
> +
> +	case CONFIG_SCOPE_GLOBAL:
> +		opts->use_global_config =3D 1;
> +		break;
> +
> +	case CONFIG_SCOPE_LOCAL:
> +		opts->use_local_config =3D 1;
> +		break;
> +
> +	case CONFIG_SCOPE_WORKTREE:
> +		opts->use_worktree_config =3D 1;
> +		break;
> +
> +	default:
> +		return -1;
> +	}

Is there support for a user-provided file? (`git config --file=3D...`)

> +
> +	return 0;
> +}
> +
>[snip]
