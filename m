Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D40E34CFA1
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749243; cv=none; b=ILi5gJnPJROkCpfbzqGMP5lN7QJDdVVB6tUUTXk1NM2zPLUJyiilaeeQR/HBH70C5U39boQ/yuFLA5119SA/PrOrbFtWaUgHcQcjwtXgSw8yG+xADjQm2H0dtbeMjtDKf6jSTIzh8hYq/L4ShJzDjbA6Ra2hyypmcppWHjUtjK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749243; c=relaxed/simple;
	bh=vpdUk2E7YSpZis9hFqqYbiQEewMMRf3nt31L6YucPr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GTrTNyPICoIX7rAdt1K7UIZhUDachHP4Fljk16IsnoVg+rPrO/ZBUC4Pp/cJnH5trtftT61zt5bvjPTbxJ2Z6VH6aRirXBa90Vx17JUgT98zfvLai31xP6uyPyboga27nwdM9HwWd6gr2Lq3AkyHgJ1iJJ1k9cxGp5P3aX9Ezjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WoQlNLEH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L5ug+S40; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WoQlNLEH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L5ug+S40"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E0351400226;
	Wed, 29 Oct 2025 10:47:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 29 Oct 2025 10:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761749240; x=1761835640; bh=CMh9R65A1c
	GHUzEdVW4v4sEHAYoeZfBx4VbSJYdARCY=; b=WoQlNLEHfqFUgmApbQxE9VYIhG
	sBH8aEF8rC4k0MtqjTZL0O4WHiesM+4dLMS/x/x9eLSr2hKiBWcU4y/iHBSzXccc
	KD52jWhVjL9RL0GJ0eBzbDs0WYOLuuU/VdyphdzLhT05dx821G9RC2hOsNXLu9pZ
	7FxesOmccNafMOkGGuAaAMTLcYvUs/x5IoT+qp5gmEz+NnlI6zMmRdQtXyyXxlYz
	FNAJA/YDtLCgHDM2n4CxlcC66mFBxqMy61reU+01FpSca6o365PmXWELf9JZ57XY
	TVBhgRtUy7beSDZRWHYyNT3DsB5XWJuKs/KvPV+TKxwAaIYdZbDXcdOm5/Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761749240; x=1761835640; bh=CMh9R65A1cGHUzEdVW4v4sEHAYoeZfBx4Vb
	SJYdARCY=; b=L5ug+S40VQ7oUyxQBYPznMfJTsZPtObOF8bEbq2uV9UidyqMFhC
	sqr0SZVDXaMY4Pc8+p0OGPEJcnyLKVKSvpRYI9xQeo/gQ7ickuEv9D4Phm4E/Gds
	/fHPNx0FzBZRX0+bAEyEp3qIMOIDJCUrJuh2oDlA23KmSU+RGf4ksNGeG4efNLZo
	pA+VQyjbb2HcDP7fpKqQhjppUeNZ2d/dyyEuzjE/eg8Kl5LpbWKONdGpF7PFi9b4
	b0olNP+ksYuSWs9R49UE+xVZDFMsEq7TNKoqbHMQXvjDkLyUmYfJD0o/dAtge0Uf
	nF+0fTJP5KENAnhkY0BZxB3omgC4jjzY1gA==
X-ME-Sender: <xms:9ygCaW7zxPM5T7jovk4mqyS0apBkp70vxBXRHP3OJhf2890GVouznQ>
    <xme:9ygCaWxgJabbqDNNQ2nfE9Etv8ABS8XzZtM7OyISQ5rUtZumWEuWH7Mj0z9EDGaPN
    WJjs_lctg5sONxnNX8JxPlsI5-uwwGw8MjAUouD-47rFqGt_hxjjg>
X-ME-Received: <xmr:9ygCadyoLYFXL92kG2cLT0_VXCUXF_BsSpFoh4FsQkdOWx-koEqo_kvaTXoJ7VzSnFw57XKbSV4v8A0W0PyQTE9KLlXjbCvEA3qE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrmhdrsghoshhtohgtkhesshhhohhpih
    hfhidrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-CgCaey3l_7_mw0SDdwtFx1rHWX8tbvxpeEZaljVHzcaOyPieEo79w>
    <xmx:-CgCaXYUfSANCbCRgYMPysONmrgt-pr9_uAmkVTrs5VFQjsZgR1UAQ>
    <xmx:-CgCafUTaGr7MkIIPhi0ZhjC-vXunTpnyZ5NQ_qgsveY8FvpyhLu4w>
    <xmx:-CgCaVjlUwKHBXXu25UGkl94EMFLUzE4HFE-0gEWDr0XbUa1dAp8Xw>
    <xmx:-CgCabSli2D-emQuEwzIjmv_7uAqirgEXpcdOQv58s8jm2NAGdupD8Xe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 10:47:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Sam Bostock <sam.bostock@shopify.com>
Subject: Re: [PATCH] refs: support migration with worktrees
In-Reply-To: <aQHoKXtrbDx6eNpH@pks.im> (Patrick Steinhardt's message of "Wed,
	29 Oct 2025 11:10:49 +0100")
References: <pull.2077.git.git.1761589580028.gitgitgadget@gmail.com>
	<aQBwiE-bhqcaSHG_@pks.im> <xmqqfrb3dnis.fsf@gitster.g>
	<aQHoKXtrbDx6eNpH@pks.im>
Date: Wed, 29 Oct 2025 07:47:18 -0700
Message-ID: <xmqqzf99ahop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The problem we have here is backwards compatibility. Right now we assume
> that `extensions.refStorage` applies to all worktrees, so if we wanted
> to change it like you propose then we'd have to introduce a backwards
> incompatible change.

That settles it.  If we have long declared that a set of worktrees
attached to a repository share the same backend, then we do not have
to worry about overlaying refs stored in a different backend on top
of the base set of refs at all.  That simplifies things a lot, I
would imagine.

> So with the above reasoning I'm not sure I'd call this a limitation.
> It's rather a mechanism to protect users from unexpected consequences.

The need for that mechanism would imply that it may not be clear to
the users that worktrees of the same repository must use the same
ref backend.  Some education is needed, and erroring this operation
out may be one of the ways to give that, perhaps.

Thanks.
