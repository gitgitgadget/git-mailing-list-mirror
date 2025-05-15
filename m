Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46FF1BC3F
	for <git@vger.kernel.org>; Thu, 15 May 2025 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268285; cv=none; b=DYd6irurarcEWVIldSo3YVROsTLz/xmqqLbXX1yIzpQvmvo511zwHYA4I/89BM9hkUgFMu00pzBW1LKIU9wIImKJuG2B7a0fHoSvkVlzTfOqmHUwYHPrK+qbc1w6fZW6QS0WCAcATNh/wjgmA7R14XkOniVcBrPr0IdgchGt3YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268285; c=relaxed/simple;
	bh=OksGtMr3tSJdlp+7ifk0idMOgbNnRBXr/LU54DTcdWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VxIOyzjEYTjBMrK27tvfQS2dT7ajOwWro0FfCk34wrZzMiabK7mlZ0e9Vxe2fUY+GLjkHMGp097ZFQTbZnBa5wOhbIqItdzYXEazIuVqKjw+b+kzcXUBV5eH3ZRSi3XyxgP3sJ3kW/eqLItGEC9ivEUoQmM7Or213qIBoHVmDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dowp6+Iq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SvARIVln; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dowp6+Iq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SvARIVln"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A77041380145;
	Wed, 14 May 2025 20:18:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 20:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747268281; x=1747354681; bh=4hvVRnCxKp
	2t1U/7sJLcKH5ym7YkYtCrC5ixDs/PXdw=; b=dowp6+IqjM6m+fLLfb92+crvmW
	znqMoumkbg7C8J5jUx09858xBpsI5UbtqBOZiDczq7q3uZbyj/PW1p5jo+rsXaan
	6c+FSPx5qMwt0eCdH8QgZxyzvRabyXeqr+dzjz1DoE/2+h4Ddy++CxtLq4JH7ddM
	ZOLPdKt9XoPL2FIWtuw8ohhnw8eV2xcjbSNGNNxzxMChVnftdHg30VBWFFydWBWK
	fJTZgKQYFeYH5iRpRTMki6CPrK5EXgegp619wva042nKdv+S6R2wwfQsvwt0lyao
	minyCGXeZXpYoYgtaxlALTfgWgTvAcwecavppMPBIVZBjkxyui26lOZTzuww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747268281; x=1747354681; bh=4hvVRnCxKp2t1U/7sJLcKH5ym7YkYtCrC5i
	xDs/PXdw=; b=SvARIVlnR1t63Vqg2SAtR0P64Mu2OmGKa3RQ2fi4oWSDnccqjJ7
	+3/sk76NDh3INZnxNGpUUILwxUjmLfWAV2Gwg+v3Uy+U6FPEMTQTXhnujUaWMRca
	gmv9X8HumI5Ueh/Ab0+65aNRhMoaYIjs9U6G8/r2rRVmApVwyi2bZ1G3ZtIfwfin
	AGgpYSXkpEikwyEmZFNd3yvSRcrVUEqdR7T7NFQ70DM8favevxsd9zrzuCuz2lOx
	0fj53lqM/JlaJRsBmH/1ENFW2WHSNxaKMXi30oA5MuebR8NR2gPoamnmnQqwlPg/
	5wQquF/F+JGBKt9yGqOP8NbHBDn4tV5nlhQ==
X-ME-Sender: <xms:uTIlaFmAa453kd93ZbE_ZkO3_Zre1taOxnxN_lUX9PtY7S2Dpfxcpg>
    <xme:uTIlaA24FwG-WFKwVma03lnqfMPr4tf8c8-ffAGyNE8IJlswW2M9_7GowViPuUDmc
    PBDVwJ0NzeU7zDvZg>
X-ME-Received: <xmr:uTIlaLpj0a-biKZDne64O3L7hy_4M-DmZI9AE-pgy20S2kGnJM_pIgywy83bz_8hDJRyVj7o_D4F1pz2hooCa0GrVZ-Mu0P6Jr1wL7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdekgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishestg
    hhrhhishguohifnhdrnhgrmhgvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uTIlaFn-G3yO7yQekwDOVsxmWm4HR0dLQUOLZTv0nEf1ilkDiHGukg>
    <xmx:uTIlaD0Gv-JiRTqSf1gRJHx7bjJpxouyd31FcFhJOUsGXljPjJBqow>
    <xmx:uTIlaEsSE1IHaMdKH94lfNOFWwCgfYR4sHPTgW35JwUVy5wEn4ZlkA>
    <xmx:uTIlaHW9T25jJ8kWDIqYTcn1GoUYZUEOM77n9HHwwt7IhDH3YGU5Jw>
    <xmx:uTIlaFCl7A7fSnbX_gQ73KQx6eFWj3T7jSA9p5vUSAxval4KrOisRuNv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 20:18:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Down <chris@chrisdown.name>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  git@vger.kernel.org,
  kernel-team@fb.com
Subject: Re: [PATCH] commit: Add commit.signoff configuration option
In-Reply-To: <aCTI7VjK5QMht3ws@chrisdown.name> (Chris Down's message of "Wed,
	14 May 2025 17:46:37 +0100")
References: <aCM5JY25NVPgyYRP@chrisdown.name>
	<CALnO6CBdhYFsDN=HPo9HbKeoZH7bb=xVVXUCK7nUdadLg-U_Pw@mail.gmail.com>
	<aCTI7VjK5QMht3ws@chrisdown.name>
Date: Wed, 14 May 2025 17:17:59 -0700
Message-ID: <xmqqy0uy4thk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris Down <chris@chrisdown.name> writes:

> ... For
> example, some of the objections are about format.signoff in 2006, but
> we merged that into the tree since 2009 in commit 1d1876e9300c ("Add
> configuration variable for sign-off to format-patch").

But an old mistake is never an excuse that we can pile more mistakes
of the same kind on top.  Otherwise we wouldn't have learned anything.
