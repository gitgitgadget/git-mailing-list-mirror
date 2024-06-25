Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB69846F
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 00:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719275980; cv=none; b=e/KOHaEGexMn8p0aRgwfIIb0eUNg4EiU8jku5FL4nEcjlbFRHyDELSp9Zkk64fgpZ7HVtWcObeM1IEnsk1dhlR9PN8AM3M1xlJEQppTraGpyizrtYcC6te0pZx/gz90gEjyLsKLXP0vt+LwDy7tBaksP/AWcnpcvpvy2HEedvPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719275980; c=relaxed/simple;
	bh=vDT63EJOjNIT8KgtQBgClp7SMFfZ2zGn0WcnHFpxSNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BSWEYmPdadjmrvPzud3Lbg0ChTxRuKSz/+ILpQ2HUQCmq/jZWjogPI3NBLbsKQQ/P3MLgwAfqxrmDDRHYKku1zz6A6e8JU0XHoIfW+996lFh+GvCr0E7j9Ao94zH3pB0Xx7h9aTnBnkEhibtEOLAdi2Zxz2zYu5dcJSoNQE6dsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gy4P0/1y; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gy4P0/1y"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F77D3D0B8;
	Mon, 24 Jun 2024 20:39:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vDT63EJOjNIT
	8KgtQBgClp7SMFfZ2zGn0WcnHFpxSNw=; b=gy4P0/1yQ99GmKsLDR+cZ6OUQaq5
	V79c9ZsaJEUPbHOeFpjWPj+x7b9NX2HAnehpdC1RjOx/mLmX7a7pBy+Jyy93iKXa
	ITbb0J1bKb3Jl74MIeD/Ts1N0I/l91uynBX3kRSFAO7X9T7ZH/gcAGZhNpoSXvpG
	WLR4aGp0QDFCyPo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 352AB3D0B7;
	Mon, 24 Jun 2024 20:39:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99AE43D0B6;
	Mon, 24 Jun 2024 20:39:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: lolligerhans@gmx.de,  git@vger.kernel.org
Subject: Re: [PATCH] diff: allow --color-moved with --no-ext-diff
In-Reply-To: <48948980-ac98-452a-b2df-11cd81de56da@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 24 Jun 2024 21:15:43 +0200")
References: <trinity-acbdb8fc-3dc3-4dca-890c-8bcb37405782-1719050465639@msvc-mesg-gmx004>
	<8a8bd51e-9ce5-4a68-bfbe-f16dcbb7e89c@web.de>
	<xmqqsex2cnwk.fsf@gitster.g>
	<48948980-ac98-452a-b2df-11cd81de56da@web.de>
Date: Mon, 24 Jun 2024 17:39:30 -0700
Message-ID: <xmqqmsn9am9p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 631D2934-328B-11EF-B55D-965B910A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> If we did this instead
>>
>> 	git diff --color --color-moved=3Dzebra --no-renames HEAD >expect &&
>>
>> it would make this a lot more self-contained.
>
> Oh, yes, good idea!  We'd still rely on there being staged differences
> that include moved lines,

Yeah, the primary point of this fix is that the output with
"--no-ext-diff" and configured external diff driver, and without
either, should be the same.  And running the same command twice,
once with and once without these two tweaks, and comparing their
results is exactly what we want to do.
