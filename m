Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA327163
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078820; cv=none; b=oQtftLfjtqI5Ca7YYIAwnyzQJ0V2tf8oZb6l9244AuzYjSJVifSO8aFZEeWfQ/DDTRgb0R9oL+et72SciiVWaenMuLo9WHINVUKVxmt1kqEEJG7zHUdSF42EK0KR+7gnZFysRcATMmeiroSnQpCJOaNcF2R0db6Ritu5h4Dts68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078820; c=relaxed/simple;
	bh=75Ln3FKXlgAMHu375QQ8yxjxxGXQVq7nmRRXOR+fLTQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=qnr4aU75/CD5V1Y9eAn/o/RZdGphqgCWcfREVlv/GRp3PIUGGVCscA2l+M12Vwfb0QChoOWoyFX9VIvHZPZkKcDBK/X6Uyv4uCNXkOYM8MDx/uhijQ3TXB2ukqg4SDb8fCAx2pCEZZw2o1WQTg8eeC6Do4I2LZGx9flvN5HvDgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=EVu0UF0n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lp7BfTLw; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="EVu0UF0n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lp7BfTLw"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id E1E7018000C5;
	Tue, 27 Feb 2024 19:06:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 27 Feb 2024 19:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709078817;
	 x=1709165217; bh=axSMgY2sZbIsehTa0bYf8t6yYW3nrcrk9EQBqKGD8XU=; b=
	EVu0UF0nz10YF5pmqQ4kKgBlejkKMhm6kz+Ks2uI0Gzecwc+TiRwTLEgOV5X+YXr
	KYVxUVnYzBw1gAJqDkhh1TUZtaGyi6GLte0f3yiz/wZz3wnVnPjjleaBkhmVUQ76
	l0FpoJx5sScNOcu+zQ5eTRazk5HRgCI/xtgUfsh3Z4mHEbvus2uYxRDb1i3De0lH
	6xRf0Mwa98G1dQ90FDEij0d7kuqOICO8DajVr0vkKZGGLo7KnsyIwkPfeFRYYZt1
	j2KyYUeerb/w4d0fWX+BZtm7aEM6J5HjkjVg20e4qLp8RuJqYITEOB73s+rTKMBB
	1/QRftzrXmjCjS5oBEtJPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709078817; x=
	1709165217; bh=axSMgY2sZbIsehTa0bYf8t6yYW3nrcrk9EQBqKGD8XU=; b=l
	p7BfTLwdBhjs0Go12j22Ndt9W9DqNTO8sPOfFAN9MlRkus76juvm2/HVkHc6g1FM
	vMnrTGzDqUVbTrk6Rgxloo6CG0G6rJmNbkUY0jvOfpOtzKsPQ9N/nNXM6LYCk7At
	jPK88/C9qrJqHY0+ExtqGhyZtrzuQ14RaGx9FYTp2Cly8dbHma2E9oV/Jgx2z7ly
	3bHMgeZNrVLquoswZUvUkaJmP95ahlwn2SyxP0L6zJ0Fe8LZ9zIQI3hpj6SVFf0Z
	J+mvU7dDTJsXtYS4UpcPG/EqvMPzcbo+PCEo8T5jKCgLGUNVucG2XuSzfFX604/Q
	hN5CRx3KIzobkiGqceJ2A==
X-ME-Sender: <xms:IXneZZB8u0A_szzfsLwpvNSWXQzMOl_Cn4lk4QonIRrl1TdpJxNdyw>
    <xme:IXneZXiFc_4GYl6IQHpqWiSW7Bg5VuMH7DUFIEutQMGSh0e6829ZIMXGSj4tZF9Ox
    mICNvX7LxoF9b2mIA>
X-ME-Received: <xmr:IXneZUn8GTNZQPTwXZmcwkpCzsvphyZUg7q0V5X5mjreZvqm3tGxxotLGDNqWOf5jMtOC5GB4ReQksFyD_C2J-ezXFLv2RZxzHNoZM3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeeigddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegggfgtfffkvffuhffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgrmhgv
    shcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrthhtvg
    hrnhepgfegjeejkeefueevteeufffgtdduleegudeiveekfffggefgvdekgeeggfeffeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmh
    gvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:IXneZTxt6UCg8ufcQ89SOEEXnomk06ygk90sC2ip9VJrnHzPGp6QTQ>
    <xmx:IXneZeQuG1MA4ha3dFfwDtQdUQyybys5yWODm8t_CmDK0epHeuSW3Q>
    <xmx:IXneZWZrykGMyu7f64QV2J98OB1AnK9KPDr1J5ADuEBmGPOS-7VBhA>
    <xmx:IXneZZe0X7gbveTDawDeU8EnYJ4uDeMcpVjD0w-q5AmjVaGmjJkbPLfJaRU>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 19:06:54 -0500 (EST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Feb 2024 11:06:52 +1100
Message-Id: <CZG9VJKP1EA8.432Y9U39737O@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
Subject: Re: [PATCH 09/12] reftable/record: reuse refname when decoding
From: "James Liu" <james@jamesliu.io>
X-Mailer: aerc 0.17.0
References: <cover.1707895758.git.ps@pks.im>
 <3ba697036c1db3837f46775823a7bd55602b4bac.1707895758.git.ps@pks.im>
In-Reply-To: <3ba697036c1db3837f46775823a7bd55602b4bac.1707895758.git.ps@pks.im>

On Wed Feb 14, 2024 at 6:46 PM AEDT, Patrick Steinhardt wrote:
> This refactoring is safe to do because all functions that assigning to
> the refname will first call `release_reftable_record()`, which will zero
> out the complete record after releasing memory.

s/release_reftable_record/reftable_ref_record_release

> Furthermore, with this change we now perform a mostly constant number of
> allocations when iterating.

That's awesome!

> +	SWAP(refname, r->refname);
> +	SWAP(refname_cap, r->refname_cap);
>  	reftable_ref_record_release(r);
> +	SWAP(refname, r->refname);
> +	SWAP(refname_cap, r->refname_cap);

What do you think about reversing the order of the `SWAP` arguments in
the last two invocations? If my understanding is correct that we're
preserving the `refname` and `refname_cap` fields so we can set them back
into a freshly initialised `r`, reversing the args might make that intent
a bit clearer.

Also, since we're unconditionally `memcpy`ing the key into `r->refname`
below, can we avoid the `SWAP(refname, r->refname)` call altogether?

> -	assert(hash_size > 0);
> -
> -	r->refname =3D reftable_malloc(key.len + 1);
> +	REFTABLE_ALLOC_GROW(r->refname, key.len + 1, r->refname_cap);
>  	memcpy(r->refname, key.buf, key.len);
>  	r->refname[key.len] =3D 0;

