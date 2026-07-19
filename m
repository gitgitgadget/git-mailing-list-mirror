Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAA7199949
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784504422; cv=none; b=ELT6oZpkSkEgmvuphMsdzBwuB52THgDww/nZPspZdBEEDIthxTTD3iFWTNl6faaKT0U9rSmjYXBMUs0yaMrXS2wWBabT0IDmcbETgF076n/vfaZ1rKm4Ch+qiAIPY51ZtLurBaN9nzXOoOFpLgG5AwZgvzaobOZikkPJv9gU/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784504422; c=relaxed/simple;
	bh=2OdXme8mKztuEpuQIpcQSJxv5CabYIdkHChAMIK1Q+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TZBmeVMbRLTXaSJt5wdwEYS10HHy5ofTiS72e7yG/U4y78EVwGDH+ISrFu+MyH7i2OGFH8xEZLYFmc6193daG50K1iXWOsLtYobMN3WiJosSpqG4DHQwLU8wUgdfIJruWJMxli7OErIArHtd/YfriWZqEKPzC7sS6xERZTHBTV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G+qSvotS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lAzSrYk1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G+qSvotS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lAzSrYk1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58C5D14000F3;
	Sun, 19 Jul 2026 19:40:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 19 Jul 2026 19:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784504419;
	 x=1784590819; bh=YZg2PJ5QNUmuVl5R4wQeh9DToJzNN7g4Ezuba8ksj2M=; b=
	G+qSvotSwrIG4OBJQGIHDzC6djV1IDMdIQGk+ruqSHtuinffZmXWszOdhfoSjK/P
	UmeoBrZIfdHQ6KzMUgnKKMN4en2N8g5OxFo109FF/CQdxYbNtUsytpW30H8azH3/
	f5NMpbgumWFYHGJwI3lAmBgmQpU8fW0HCo6QJto6ixQGYGrdWPdLeP6bjtm4u4ZE
	bIjTSbi9/QI+cZX9fZC1h77cDcL6NmS0bjwGOGY13YThzW7IyFHI2CdoOAChpNG9
	Lxi/tqHimt+2Xg4d/hl4Aby5MsXGlL792LNgKuz1TwccZ5w6aA+mfkf57cnsBHOe
	1qh3AWd8L++XrJnUyi+1nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784504419; x=
	1784590819; bh=YZg2PJ5QNUmuVl5R4wQeh9DToJzNN7g4Ezuba8ksj2M=; b=l
	AzSrYk1jqmzvuIkyFf0/vK4MTZh/3MxH26122ke1QkttogCnBSiLBF63MWkrWV/4
	FL4tN3pAmUvHQSibLxIP7bK0RamuPO3BDPC0d45WdG29ncmUNCHqedJi8JtvpRtR
	iSzG8/xEY4uSToJNNwPGXQ8oMsc7V0Beiec44F2Lsd+4n52084UNXXrVQyAMlgJf
	FUk9qafHaiZ9lBeKMvC49JhNKt45DGpkhnf+QJ+ncp2UrgxwJA0qDtcAB5n3jFjD
	2lZa1lQBxG1yU3XaSMbjxS+GPc7juYDDp8q0XdD3PDBEzDtKXF94Qon2L4bYeREx
	nId3n6qnDA2wYRhvKBaZw==
X-ME-Sender: <xms:Y2BdagvN5fMZl-xrEbMHGghZNvAmF5nBkcHO1A5Q0wzg8lUULNIDpw>
    <xme:Y2BdakfwYkJgdYH4OAL62OOd-TCJNJmvxNMGbvOBUphWjJ0NreUZgOlAXTVGMNz_D
    OOYfwWZZ2X1GTULzN-xYoln7Gz9KyLZYfhDAgWEYkE12raIW2RVLA>
X-ME-Received: <xmr:Y2BdagwmXqkDM2dsgjF-Gg7tDJoso3WqQruV7s_-UBF2q8EypCEMCT68x6qQg42yV-R1l2IBL1uhmPsAldi-MZ3o9fp0dS9NjA>
X-ME-Proxy-Cause: dmFkZTFOwM7F0R+C/DWThHILsWwF4HSPFjIg7NPPP/80zSp9g2dtVGpvBWzHLtsaG175IO
    7UwqsfcRVKkFdDNwoKPNEBS2GGrqLXu7wj6/FRbnTy/hSh30X7lFs1s5EaTSStTTx66kby
    R/kejR0loe6aWmKoKgruE3OpZ4nkeZxt6jY3rQCzdR6o2DxRsKoeGs57WzPGKAsXOxivAL
    B7/6FC5J5TMitiaGkckKhd+wV0q5xuQLGsdh8/U4g8VAoCkvKxdur5odSD41ApeJDC9nIW
    PsFr6gl52POv+RLwd4P3mWjtICH5ODleZrA669jcIKjfKiIOihcy4DMQ8Qy+KqVHPrvVMY
    hA1DOMq/cYjgrPR+1A4hmD7hyRwE86/URh+X5l/omVUofOBFhs24e1eFW4wobwHsj/8fhc
    btS88a6QlH72svdPt6NMcgxCHDDF5mPGFte3+an16qOqn1mwSJCRuR0oQUIbYoowfsNJx+
    5x5QLFUiefUsqNMsnoxwkHCr/imn4FyYrWWOVEXS9mAaRHmAjbQci0zfmEvn2fkluEjHXX
    P384+LXee3RdIj2g0hq94bx1ZX1i+0P6SFqa2UBJz6ptkLGICYsaWpqJb3oxA/GafUOPhp
    H9avXx/ahDUP7ZZDcyfUdLGwDoou9rkRV6UvFV1csoKb2dWqjL8+TAR6If9Q
X-ME-Proxy: <xmx:Y2BdaiEJdQeS5t3wcC6OjWO_qbKWoJLSwNWv13zjvfaZiYRUKu-9JA>
    <xmx:Y2Bdasy-tQhEmuBc0pigYsIKs7joFdNjufuwHVXh02b-CeblbbsvZg>
    <xmx:Y2BdarvScxmsUWdms3bEyGRH6nA_bQMGIIIfNzTULPEsDvw1zvvttw>
    <xmx:Y2Bdah3P89sakWzUp5S1pEZkiz579UNXDLsOeTWHlKrbQ_flkeHVEQ>
    <xmx:Y2BdagyGm_94DJWv1B1vfdhm7gkcPGSBigxEkmAseUUbD_MIcUmF2wCh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 19:40:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 2/4] doc: convert git-format-patch synopsis and options
 to new style
In-Reply-To: <e1ed85e3f2733f0f1cc46416903d1e0c8b4c1856.1784490878.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Sun,
 19 Jul 2026
	19:54:35 +0000")
References: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
	<e1ed85e3f2733f0f1cc46416903d1e0c8b4c1856.1784490878.git.gitgitgadget@gmail.com>
Date: Sun, 19 Jul 2026 16:40:17 -0700
Message-ID: <xmqqldb6lfa6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Backtick-quote all option terms in the OPTIONS section, convert
> standalone placeholders to _<placeholder>_ form, and convert
> single-quoted commands and tools in prose to backtick form.

OK.

> @@ -708,15 +708,15 @@ BASE TREE INFORMATION
>  
>  The base tree information block is used for maintainers or third party
>  testers to know the exact state the patch series applies to. It consists
> +of the "base commit", which is a well-known commit that is part of the
>  stable part of the project history everybody else works off of, and zero
> +or more "prerequisite patches", which are well-known patches in flight
> +that is not yet part of the "base commit" that need to be applied on top
> +of "base commit" in topological order before the patches can be applied.

GIven that the last part of this hunk below uses backtick-quoting
for `prerequisite patch` and `patch id`, shouldn't the references to
`base commit`, and `prerequisite patch(es)` in the above also be
backtick quoted for consistency?

> +The "base commit" is shown as "base-commit: " followed by the 40-hex of
> +the commit object name.  A `prerequisite patch` is shown as
> +"prerequisite-patch-id: " followed by the 40-hex `patch id`, which can
>  be obtained by passing the patch through the `git patch-id --stable`
>  command.

