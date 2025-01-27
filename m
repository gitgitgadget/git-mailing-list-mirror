Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB471FC0F1
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737962791; cv=none; b=Bxp7zj+Lm3aobtpybXA6YO/IMu+88uH0jReI53BPNGZ9b7lTbGF60j+PWdW56kckFeytFJmvx1IBmjt2YxKVmFehhkKTEmpNVrfc/TpdNu89XsAB/zxAbJhUjLs5GfB5c7Vh/Kgjw/otDdmFekazfEwksdikG67Iu6/z2Yhl6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737962791; c=relaxed/simple;
	bh=/dt7B/y8nA3bK+TI+3THD7EShjIj4tnAP3LN9AGDDJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DH3RbQ95DPjEcdYcnBS71pK1nFvimwuV6zMZ4ZDm+c9LT4OqAL1rF5tuR1CcqavS3YcalByGxU+tPFI86eSzcX7Zgogg1mDC1W8QW6OGzBp6ObtzZfjwLym7xPgS7FigLOvPTiicawA9wUzjtTS4ESdLqWYRyzhGi+Cpj7xuylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TcnPsDqd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xnp88P7d; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TcnPsDqd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xnp88P7d"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA6C4254011C;
	Mon, 27 Jan 2025 02:26:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 27 Jan 2025 02:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737962788;
	 x=1738049188; bh=RQEilAgOD2zlAts9yvrNiSsd1zQ2oa9iO3ooCSkCf3g=; b=
	TcnPsDqdlhZCiMfJjJYVOGa5SbdnQCx2rOKRa1k8hGgHFYt/6wAF1XzauIt3EXGa
	HJOE+nRiaH2Av3KogwuEAAej6JATMglLAyfi2TUfWJ1tC4H87fUlgwrYsX9Aqx0w
	wmbkSw9tvxEnYTKyxT5yKqYuarMNwcJef5Hxlj0EcLxfD7XTZ6SHWTjIwN9VP9cJ
	izi6BzICCCQQhut6UEe6OnWkvH2uADO/x7SQVEKiH/P5R+IdSPal0cOc1VsN62Zh
	jREwWG+fRu4tbbPuuKyTzPDwMtdZM40rrvhxEzOtWzXlAYbfvKYHl7SoaHAeowC/
	UONvDSzWj2tfPhyYnsY54g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737962788; x=
	1738049188; bh=RQEilAgOD2zlAts9yvrNiSsd1zQ2oa9iO3ooCSkCf3g=; b=X
	np88P7du4Mts8AVsdLItr2Qtz9sdJ4UDPoeMctf4fJEKoRtAhaG+9nXz+54hiYED
	EOwLWcO7ST5UrG/2Og7Dy+bXk/wjDNziyVGMAUNTewUmE9LsQj5eNj8EpyZ0f56E
	d9u6TLrZbH0F/QieCDmYh8wT6fWb0kJqLGdExPx8HEmVrVqTgL5R/hqoio0qagsL
	KM6YdrBah/lnaD5LKzMFi180ybytqvft4q0iP0uRJKs0oS8MsqUjWvtBFYUPK/D3
	uIHfBo0UHmnuQ5hR1PtB8ChtdhkqsPUpKQlE8SvxL/cQWhYCVs1gMGZkp7dKjuZT
	M+DszlpAWbEo9AY8u8F1A==
X-ME-Sender: <xms:JDWXZ-BjTP-uiUvh-WRMxv3lmiZBhOAl5cwVNSt3HLeAyG1xDxMv3g>
    <xme:JDWXZ4jit-_U_vBYzj-F35zT9fFkyZ1iUjjMIcXQ0c9yeYIosYEyd5XvegOaOT18c
    9lHNLZEMD15QP0Cbg>
X-ME-Received: <xmr:JDWXZxn8kQPlRG4kNqetwXzesIYPzXkQA8Z-MCHk8kDS3etYQvy0Sx5BwGX39oegdtPNM3v6C9aeJYMjTM1PA2I7cf2y0E2AswILX82yLoNT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddvheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefje
    eitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshho
    vghkkhhlvgesfhhrvggvnhgvthdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopedvtddvhedtuddvieduvdehieefkedrfedtkeel
    qdduqdhsohgvkhhklhgvsehfrhgvvghnvghtrdguvgdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhm
X-ME-Proxy: <xmx:JDWXZ8w4lgfMT2q6mmNAzjMGzAMtFf_gOUPvMgRVnh61iR1_rr4tSg>
    <xmx:JDWXZzQ7UbI3pMYvP1qRoG4Xq3kRyXizTJVONXfcNnhY68MZzVSIvg>
    <xmx:JDWXZ3aJnRRmYCcsR6Xb0kcr1hjsidJRr2gendnBk9SkWKOJu21lYg>
    <xmx:JDWXZ8Qc-c-vpRib3K8k7dHAs0G098lIp0DeftSlmf0mo6fuVJhiRA>
    <xmx:JDWXZyGBGlhZcvAAChr0b1nnjXErHOdNMrIuC8VSjTtKwCGNllvMTiNM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 02:26:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6e8d3a54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 07:26:26 +0000 (UTC)
Date: Mon, 27 Jan 2025 08:26:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: 20250126125638.3089-1-soekkle@freenet.de
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	=?utf-8?B?U8O2cmVu?= Krecker <soekkle@freenet.de>
Subject: Re: [PATCH v3 4/4] commit.c: Fix type conversation warnings from msvc
Message-ID: <Z5c1ITUkNqB7CeHW@pks.im>
References: <20250126130038.3277-1-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250126130038.3277-1-soekkle@freenet.de>

On Sun, Jan 26, 2025 at 02:00:38PM +0100, Sören Krecker wrote:
> diff --git a/commit.c b/commit.c
> index 540660359d..c9cc56bd9f 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1530,7 +1530,7 @@ int commit_tree(const char *msg, size_t msg_len, const struct object_id *tree,
>  	return result;
>  }
>  
> -static int find_invalid_utf8(const char *buf, int len)
> +static int find_invalid_utf8(const char *buf, size_t len)
>  {
>  	int offset = 0;

Shouldn't the type of `offset` be adjusted, as well?

Patrick
