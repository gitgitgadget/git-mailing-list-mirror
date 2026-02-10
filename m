Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9783E47B
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770738425; cv=none; b=ZeMbVVuMhpqPRBukds0zBHP+LIjZoQLA7VV0FkDc2fhU/iJHYdLS3hqOOkpALAEZk7XqPWZUg//NOzpkG9xk4bzOhYgH+mqNc4rJwgFlB8IbxQaFXiGv8Za6VnUWHhNhN+WId5zhJ1plmDkxDvAvQ/MPqrAWvBO9UO6ah3bpNJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770738425; c=relaxed/simple;
	bh=BnGC3huA+I7krgtuqe/HPpeWblA0Ej0BVLQbERO6YMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ojjxsoIr3AiYemSoARJBW57Qqfx4kwHJMunAxjBtbWElx7/X0GTGsxCzlTQEd6mOgtvh5uL0GCMvjGjqlfy3suAxBcuAAIMhUze8zrxEyhBW/knwvzco+cKXl5Sux+H3hMtksHkfdKUr5TCpzZYk2TiCKwYLoO7ecNt5jAvCW1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q517VqcC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LxIdcxl0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q517VqcC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LxIdcxl0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 47DA1EC05A8;
	Tue, 10 Feb 2026 10:47:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 10 Feb 2026 10:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770738423; x=1770824823; bh=b4cQO+SyD6
	we+ztj+7UO/YIx8XO9RMYBeSoJBAvwMS8=; b=Q517VqcCqpfIhEI4OKY4r59f6b
	KW42zc/Ch90kpMCDc4H7AhUy+De4N2DhB30DMpkQb5HHt9+F/F5++BXwTTyp49bS
	9Io0R36zALcezWDxWTfuoSpnBMSwFYpG9NKZsZ4tCGXWoeBdFNtmUdAONnVIvGPE
	s8o9tj0YXb277WygbDC6wisR74Ucg41OvNVBcHQ6yzszLy4Oyl6rnm/jXTkHnjFp
	MRd5zU6sxgVUXcmzYuhA7VchhsM4ERDhIJGJbEnv7uKYAMdppyQzbSFghoQMkiRe
	rbqHTdMOSadIIj+iX3dcNUq7VAACSB47/5/pFJAIatuqIYAXf6Def3RDoBhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770738423; x=1770824823; bh=b4cQO+SyD6we+ztj+7UO/YIx8XO9RMYBeSo
	JBAvwMS8=; b=LxIdcxl0QfOBg1V+x/4QqDc5yPcBK5A/d0qsENUOeeziXRDt8Hl
	JjtzrnClRMunqTl7123basZUttfKLj+8kinxNI/BhJJLm2sUhsvxiV6lxZazAfR6
	2dxrSD3UlgcjJo4JaKoikYrGngDCSjRnPaDONewDTFZLj9/QU7E0KUe5xCrmeU24
	WML5YM2qJ/DrLuQbHwp/1V8B2sZ7QafBKqBPYE3lkLmSHFulmDFYJqTiTWWLO/6t
	9SM1KIwCpBVnWtC/DcEJdC1jEYAvMazmfIAbLROqmsc2T7AhWbYKnjMTm6mHTxLt
	j8Lid1tLnsV+WQTiSrrvGIsj5cyj7pMzCwg==
X-ME-Sender: <xms:9lKLad-M_RlbZ4-pn690C0sVPZ-dmj40Qmy9lU7m_LMnDWLPPVb9Zg>
    <xme:9lKLaT9Z5xuCejM1gKqQK7TwDr1le_uWmL0LwbcRDwMkfm8RLhf9iatm8M_FsGx8c
    6QVpSJWzuyB4oAsR7wAnVWkNH1vVf1RNAaoJNhXrtgLe5rdG9uafw>
X-ME-Received: <xmr:9lKLadR1B49vNPJd5_s9t_jVBBWB8TtV0aZLlJ1XSjAozYG30xYsiDN3IqvJ2p3uVaAizckgdS6C_Q-a-qecmvdx1AVz8vEouA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddttdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjrggtoh
    gsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphih
    ohhkrghgrghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:9lKLaXcRKaAIZTxGGTKIcl2qwbUMnJyhGRdQm1DfuQsPj_WlGBMhrg>
    <xmx:9lKLaRAulqqUmGK8JJWSvYTK2xqcgA1K2xmbwZJQGmt4CgGDmc0Khw>
    <xmx:9lKLaZlcYTg13eBCbM6bCebvkv9n0DmkhIjqnudhpz7t9qe2GQkGRQ>
    <xmx:9lKLacc-jPkLkvsWrejPi0l490K3sCI6k0WkU0VBYb2O4lpdQazyxA>
    <xmx:91KLacVWUvXUk0DICkjOFJbxNNhxbPwTkyZyZvviL8nGj9ebcg9P3Bb1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 10:47:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jacob Keller <jacob.keller@gmail.com>,  Jeff King <peff@peff.net>,
  Matthias Beyer <mail@beyermatthias.de>,  git@vger.kernel.org,
  pyokagan@gmail.com
Subject: Re: git-am applies commit message diffs
In-Reply-To: <aYs_P8QujA6mL81-@pks.im> (Patrick Steinhardt's message of "Tue,
	10 Feb 2026 15:22:55 +0100")
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
	<CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
	<hn6q2mdjdqezzvtxfxffmatctnlf4ttvwedfk7wnw7xw75gy4g@hetctv53f7bh>
	<20260206090358.GA2761602@coredump.intra.peff.net>
	<aYoEO0CcVt2Qjgnb@pks.im>
	<CA+P7+xrNycJHTyJwn9AQcJLG0dDAE7KrTvWTHBi+CiQUqK8p5A@mail.gmail.com>
	<aYs_P8QujA6mL81-@pks.im>
Date: Tue, 10 Feb 2026 07:47:01 -0800
Message-ID: <xmqq34381tze.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> That is worth a thought indeed. I guess one of the biggest questions
> here is whether we can introduce such an unambiguous mode in such a way
> that old Git clients/patch(1) would continue to understand them. I
> wouldn't mind much if they would still misinterpret the ambiguous parts.
> But if so, we could make this unambiguous mode the default without a
> breaking change.

Yup, if the old versions misinterpret exactly the same way as
before, then it does not even have to be called "unambiguous mode"
that is on by default.  I doubt it is possible, though.

>> Obviously if you're sending the contents together, a malicious user
>> could edit the formatted patch to move or copy whatever the
>> "signifier" for patch vs commit separator is... but at least we'd
>> prevent the cases where someone accidentally includes diffs without
>> intending to.
>
> Well, if we had such an unambiguous mode I would say that eventually,
> Git should start to refuse patches that have been generated without this
> mode by default.

Or any unsigned patch, perhaps?
