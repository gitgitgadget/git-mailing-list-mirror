Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193DF397B0B
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208884; cv=none; b=AbuTkdKKXlAewjYd6eP6iS6ZgSiPf3s/Ahq5LJ53r797iQ5R/AdcJGpZ9l962PFJtnJ/lUi3+n4XxWyG1Gfp2NOkLoBroyKP57v/OHT/uNRXqEwJ5i6g0Imf/lcFyPI32xzaD8O9nAwWOY8GN8rNuM2Av4Ej7TWed+O6zzkFbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208884; c=relaxed/simple;
	bh=7EhYwsWhh4hGQVx4QBVq1LLZOwofKe3I67InKKEYw+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a1VrIhzWCqCw7KcVhMKsItSgy9Ry6ltTlybdoPDf8GZEeVwbDfhLRnn1DNG6KFA8nAp8QGq+QuJlr723dBr4QoUEDFIoxUm4sezq32o+F6ZQZ4KBtMa9c2oGigQNlcYGw1eybMvkpUq1WAuY6p8YU2UTuvcMxUG/5UiZdCB6h/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OuvpJfZv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i4KaEcmp; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OuvpJfZv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i4KaEcmp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1F0001D000AB;
	Sat,  8 Aug 2026 13:08:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 08 Aug 2026 13:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786208879; x=1786295279; bh=7EhYwsWhh4
	hGQVx4QBVq1LLZOwofKe3I67InKKEYw+0=; b=OuvpJfZvM/a7dRI4MCCOIeECyS
	VkkVD83ZQtz3BNgWTLr94fvAB1da3H7ZXTYFgu6ILd7ii4mFUd2SEp8GVj7EHBvf
	n0bBa5o6MJSkN2dFSw48dDsxF6ctMGveNrd3tOKRUwi3vPnFzUPioEXLLVcCIpnB
	geMGWMCniRVfAQ0fSTuA0zZuwL3SjVToiScWEMpqMqMJj9ZOjNsb5VhL/WkhVRrg
	WG+U044mhnPWHDM1uyO9wUoqyEBVrwoj+irY+CFEz1qBu7pwiC25gbp2Se6btJqX
	Dyu0bXJnEWFObEMw2Hzi7Tas8J0OksxZSe1ygOGPo+3LZcECHwRqsmQ98jTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786208879; x=1786295279; bh=7EhYwsWhh4hGQVx4QBVq1LLZOwofKe3I67I
	nKKEYw+0=; b=i4KaEcmp9o3gkH6UaRrNQNdn4LVUTAU6mMEY9wonWw2U62ByJ6i
	oe/R7MOYo4NB7JuFYx2IFgMi6V6tVrNnNdN185mvltMyrpZFov2a4RgNG3wsYgr8
	Q8X4wxijNxM0ZLmsHtU9hFNyLjdyXnVQhOx02/vRP5A1iFl4m+dM0bUm1QReoOAY
	DKXW04FxViD46Nft8JJL8Pus6LSbXKJwLZlTwEXHgjW+VAOkbw1gSA8O9TrzIKBq
	hX38wwR4IaEInAgNHS1ETrEdMQe98O2Rb93fYf3M2si+V+iNPCrZTHG0WkEjtTZ7
	ZH57b8t6w8r4szb+h20jMZwdLA3OoEloWLw==
X-ME-Sender: <xms:b2J3aoMCgy4wzEqUwDq9-5n5EGOH50GZNXUgiO22OYSHa8hBo8dDKA>
    <xme:b2J3aioFP2QCBDZUnCCiVh_nvRN98cGTPgokGn6FpYWlKO37MuJHt3HKFzS5rKw_G
    h_Ho-5mnGprUcQLiA5r1cCVKsT0TjVSl1zPsBVgdhOPZFi3IOun1g>
X-ME-Received: <xmr:b2J3apFJ9MR0580udUvqPHBDLQj_WuCEJ3bW73lgcTnR1B3_TxVJDWHEDygDGl35cPXgCDmfomLYswvwu5TTTbK8_zzETj4WsQ>
X-ME-Proxy-Cause: dmFkZTF6AUlcD2bOe4t+7Hk1N2Z1+ROdpN4Cch9Vuuuux2x9H5E8YAOBIwH5vUZ4lkYK8o
    RLHxdmQbgsFZjPAiTVHknUFtO9k6F6Mx38qSXttppHUcJjDmYbPQC1sIquedh2F5KiEf7N
    SFbnuX0MFFAKVCEVx6Urn6/Y0hmDjtgXsdWJn644hIRMhFi5a6GK8cf7lYTbsqEnPqoFJX
    qk86XpBIfETA6IonHLWusbYBsrGxAZvOfndRCU3X2MvsESirMVnfZgzHh3SRGXjFrM2K4H
    xpgw4+ROnBCBf8m0pAiqzNleTl6lI9gO8ZsB8PwfDcTHFJielcLWId53FqDgUwiCOf38ax
    JxVz4GD3o2nKKa2QcxQvOnunpzAq43/fQyoT6kc8A5A8MpyrpHF7X6W7I6O4218Maretbi
    FhQcfdnhGm+FedmEg+QvLhxn9OcZMMIeZnMkJQ2JawqwSZONhKLzyd3ZNQu/BVWx50g3Jw
    reDTU/ZMfLHIhB1gWyNfAQdRXXdmDf0ZHYBpTvG0N/co+sMl0J2UgM5G+Rk7F/uYF5udh+
    6mQm/EUMP6KVGC8MheGXINOnTWWbG7d3iPth117OLzJqijWalAQZRYpb5diwiEtgZgspqE
    cUban7W3sfRLfdjneOVyCNgol1gIBgHMwlbSM7yhhGiq6gyHcZQHMGqnmC1Q
X-ME-Proxy: <xmx:b2J3anoItckkeRp-_45IleHNrJgkzlbEx2pfBogSQorehPBoZZHBKw>
    <xmx:b2J3aiYHoIo7w0_oFFjYxFlei1V0diawoP1cyDoeUvHe3fHMXavsLA>
    <xmx:b2J3agVOx-ZJ7Oj0xoL5RykUKBkiTQI0ryEAjzXb1ntehbMhiLJpqA>
    <xmx:b2J3ar8smaOPWEHPe2xYrN3wBynUMtKv86tNLyCAqGmMYQ298m_BOA>
    <xmx:b2J3arIyIU7dWVtTs7prlQh7OYH17YNLvrdDn_fLAP0aYP2iVrPupTmT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Aug 2026 13:07:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Gusted <gusted@codeberg.org>,  Jeff King
 <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 6/6] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
In-Reply-To: <20260807-toon-speed-up-last-modified-v2-6-7d87bbdeaf9b@iotcl.com>
	(Toon Claes's message of "Fri, 07 Aug 2026 20:26:52 +0200")
References: <20260807-toon-speed-up-last-modified-v2-0-7d87bbdeaf9b@iotcl.com>
	<20260807-toon-speed-up-last-modified-v2-6-7d87bbdeaf9b@iotcl.com>
Date: Sat, 08 Aug 2026 10:07:57 -0700
Message-ID: <xmqqtsp4a6c2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> The last-modified builtin expands the pathspec to a set of literal paths
> and builds a Bloom key for each. During the walk it looks those keys up
> in the commit's filter to decide whether the commit is worth diffing.
> These lookups need `bloom_filter_settings` for the key hashing.
>
> prepare_revision_walk() runs prepare_to_use_bloom_filter() to build the
> pathspec key vectors. For a pathspec that cannot be turned into a Bloom
> key, such as a top-level wildcard like "*.c", that function gives up and
> clears `bloom_filter_settings`.
>
> Restore `bloom_filter_settings` after prepare_revision_walk() so the
> per-path check keeps working for wildcard pathspecs.

Should a new test or two cover a case where a pathspec with a
top-level wildcard is supplied, and ensure that this restoration
kicks in?

The machinery should work correctly with or without Bloom filters.
Without trace instrumentation, such a test might not exhibit any
behavior difference even when the filter is not restored.
However, the failure scenario is specific enough to make a good
test case.

Thanks.
