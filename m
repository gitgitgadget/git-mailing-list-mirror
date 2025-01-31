Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CBB2F56
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738363106; cv=none; b=dlWC6sPizZcznutTxQd2jFiXa4cjM2mMUXUuXNJNjyZykd9kgWZigfCmeP/BxERcznm2cwQzVNIin/NwdV5LfZ0XiG0cIdPvWYV1HLrZTm+hDZE64SDjTqdsRsFfZXmaC68dQQPqRdDXZ4ovAUuf0iNtLvhjA1Vo7L1AvC/+RVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738363106; c=relaxed/simple;
	bh=j7Mzi4lfHqDWYunHfeuNjX6g1/QmzVAAV6X1Hqd63y4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V0qSYxKz9La+AnFJ3GhRZJLk0rNZkv3rfvGPrT2GK/98nvkZxfskc5XWDX91Cct8pr3V37ETwJxtc+dLXejRnB3RuHZNyy9S7cQsH6DjqymuaOgJq8XPFpMOf75BVD4zFysona+irPgz0YR7eb4+ssloWYzJ+gpKVMW6J0O4J70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PvydstX7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PCuRG8Ix; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PvydstX7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PCuRG8Ix"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9EE2254014C;
	Fri, 31 Jan 2025 17:38:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 31 Jan 2025 17:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738363102; x=1738449502; bh=PLplFHEMNV
	notEhjC1xbndfuZwfr+MwnDB3dJwVCDc0=; b=PvydstX7avWDmg0ej5tNnEWO2F
	vx6iqPon2TW9b6F30mxLuQyE+tQnlFMUjee1GJngRACtMsrr7jwkcO3ddA0bFjJp
	aIiM8Oaoe3wjd0EV9Py9s9yHPZHVzlNwIuXM9p6CqIvAHtIz0R5wolUr2DWLeLht
	AR9dzddUIxGErLrdtYY+kxRaWSmrEkRLfC754otTx9XrQ1bkxjqiPTaBzN6KhclY
	hm10NeNQW3CJB8MDsYkKu8ii6dzRepwA/oZBInUZ+VUjfu1R+3dq3fRDokn/N9Nk
	A3mtBJ3Jm7qvTiOPsxcemH+fJ3p77/fyBfR0gZoojg75TR9KJg5eX32ZzPRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738363102; x=1738449502; bh=PLplFHEMNVnotEhjC1xbndfuZwfr+MwnDB3
	dJwVCDc0=; b=PCuRG8IxYP34Wcz3PRhPWaNHIX3gYz7EY6nFJN59qOh1ZlCz7R8
	vRkV7+iI3W7C+pLdQ9P9rk4GfvOJV5owv7uQ2FuKmoIkZw8o6gyTzVh2um4jVvZa
	J7ykfeYXPXVcIsDXveV1jxZn4A3tmP0a2IigFIVAGOo6Wa+F7KdIty5HigKWpAd8
	baPc1I/H5mhDPDcMn5wYkzmiKy8fT7fiuS18YKTHrvqM9b5BYOdE+H1OA/9860U4
	4NxeEnVPOZDlHWBLjoE4sbNodfSm0j8V3Vp/FOyls4jV5fAy96nD/UfVsinUQrGy
	mizwP0r+u9KO4CRDcqJAA3gSRpxpO/IGvvg==
X-ME-Sender: <xms:3lCdZ1JC9wpAeBpZAPR3mmzXFsLc0RcuYCJTCUfKQuw8gAn64robzA>
    <xme:3lCdZxIFa1jRo9xJ_2PUCxy8FPxOo7AOxjo805wJ65PpU5dAuLN0Ho4vdsG-2n9DW
    TXHwOZTkXXKSJOE0A>
X-ME-Received: <xmr:3lCdZ9usFwwAwl-P1g0KkAnnO-5YkUik7Wm2vbQ8O_ZhzdD0gRsmj4UkaA9GJtj_lO-2vTPnvhbiFeww0y-73rz_Cxp4kNYsCDhU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3lCdZ2bHKPQAbYXKZDk3UZM5ckL5VkSPyXB_rjGg1V2ueQOM0EmZ0g>
    <xmx:3lCdZ8ZOzhq2imBL8187seBLomhVFTKLc33eB2kClFvZ-gBc_VRwjg>
    <xmx:3lCdZ6AKDJiQrPU8_0Z28q4lT-gO0IxCuZdX_Emq8GK097Rs5lYVxA>
    <xmx:3lCdZ6bXyYwjSXQUA14A4g5DUzbhA5E1KmwSAwTKCzTCE1wkDgkPEQ>
    <xmx:3lCdZ0Ek7-IpWZH9VK5-i23XwZaHp21AkLyxFqLKC13jfzRsI3HTm5mM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 17:38:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] setup: fix reinit of repos with incompatible
 GIT_DEFAULT_REF_FORMAT
In-Reply-To: <20250130-b4-pks-reinit-default-ref-format-v1-2-d2769ca01207@pks.im>
	(Patrick Steinhardt's message of "Thu, 30 Jan 2025 17:24:18 +0100")
References: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
	<20250130-b4-pks-reinit-default-ref-format-v1-2-d2769ca01207@pks.im>
Date: Fri, 31 Jan 2025 14:38:20 -0800
Message-ID: <xmqqv7tu623n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Instead of retaining the current ref format, the reinitialization tries
> to reinitialize the repository with the different format. This action
> fails when git-init(1) tries to write the ".git/refs/heads" stub, which
> in the context of the reftable backend is always written as a file so
> that we can detect clients which inadvertently try to access the repo
> with the wrong ref format. Seems like the protection mechanism works for
> this case, as well.
>
> Fix the issue by ignoring the environment variable in case the repo has
> already been initialized with a ref storage format.

It certainly is better than corrupting the repository, but if we are
to do this change, shouldn't we at least issue a warning to tell
users that (a part of) their request was ignored, instead of
silently ignoring the specified ref-format?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  setup.c         | 4 +++-
>  t/t0001-init.sh | 9 +++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/setup.c b/setup.c
> index 8a488f3e7c..53ffeabc5b 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2534,7 +2534,9 @@ static void repository_format_configure(struct repository_format *repo_fmt,
>  		ref_format = ref_storage_format_by_name(env);
>  		if (ref_format == REF_STORAGE_FORMAT_UNKNOWN)
>  			die(_("unknown ref storage format '%s'"), env);
> -		repo_fmt->ref_storage_format = ref_format;
> +		if (repo_fmt->version < 0 ||
> +		    repo_fmt->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
> +			repo_fmt->ref_storage_format = ref_format;

Perhaps something silly like this?

		if (0 <= repo_fmt->version &&
		    repo_fmt->ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN)
			warning("ignoring the specified ref-format");
		else
			repo_fmt->ref_storage_format = ref_format;

In the longer term, we might want to consider automatically
migrating the ref backend (by calling into "git ref migrate"),
but it is a good first move to stop damaging the repository.

Thanks.
