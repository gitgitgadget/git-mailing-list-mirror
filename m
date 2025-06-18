Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A204A21
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210232; cv=none; b=UcLp8RMW6Ll5Rrh+bcc+FQFQcIwkRMb8YpNx/ClkeUKkBWmL2dVdoXtTGvluFyjWVssMF39B7YRZc2DVs1AyMKSIw3+IHocMQ8imolAJh/m0+nqiiQhGmnsVR4z7s8tcUjDjVaO0I/yEEcNWypoGuv7jDLwrw7UR6+HrJe5TqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210232; c=relaxed/simple;
	bh=owS6+o48Ecm+ZPTatk4onQBUpUVv0LILWGOmVeEeTSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rlefg4zq58Zp8XpvSOO9wmZhK5gBvQ/iKooxmHLE4NdMGpSLOeoqWgGMlN9lOmkESEMDIgbm2ZElijSGqZwQ7dqgMYjJOoe8tJqCslcz5t3oAmYfMpiLqMWH1zoY5KYBbZeGY+wlqReJCpqngDnw+HGkWOFvPSHrFrcqGIL7Y9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qL1Aeind; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DQ7WL79h; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qL1Aeind";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQ7WL79h"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3FC881140155;
	Tue, 17 Jun 2025 21:30:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 17 Jun 2025 21:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750210229; x=1750296629; bh=G/JjoVq8SD
	Qmc/aIeofMjkAKtKdoYG8E5JC6Hrz1y4o=; b=qL1AeindZGiQkQDdoqmv0IDGpH
	L+LzKPG3TQgklEm6eHWAz34cbiXYVLpvzVfT6s9Cxp6b9EoGdENufUTC++b8DKsw
	jUDhIecIIO7B+WfStKn2gXyVwIN0EJNQamnoAR4pxRpAkqaEnfw2UjJFpl3yCoZm
	zG+H6VKn7Jpv39ehLK8EHcounmnN07yqHNbDFTA51d0ZqeVhwgKhXIBmvUG6FRe6
	xlXES65gg2GH6XDcNEcthJA4P9eV9d10XoUtlgFgRJepXhsYxsoknQPf8Ff4gBz+
	aFDN1U7Xwy3SO0J8nktJaR3HBMr8tL7grUfj9OQsk7cOqwGUehZwoIvfnMVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750210229; x=1750296629; bh=G/JjoVq8SDQmc/aIeofMjkAKtKdoYG8E5JC
	6Hrz1y4o=; b=DQ7WL79h5dLxTLURzWDpSQJqx81zwqj4AmBhlcTTszd+vG+cwIx
	LZoxrSejDo/VfRyTDLQfQOLGS9i+ZEGy33lkIDmpnxjVHLo/M5tbFUPZyOIS6il/
	gd+jrBIMAAxVOu1TbVUopmLkm3Wb11prG6oFPqWV5ZGfxmAWEpdn2JdBcQCKDRl4
	z1WjYWIox5cWMiEVEqP972Gfhonkyv2H5d+e9UUCymDQeD/an90jcZOydh43FWux
	b+KvD2o+LG++ncRp9+T3+nCRmXwRvS1re8Ltzu9z1iy1tqC5ZKcDtqg/syJX1EhV
	o3/DtqtQYKuAkvtQU20UMZj60KEf+FA07KA==
X-ME-Sender: <xms:tBZSaJQ8rBfWJkK26EPbvLh0krB-K7yKC0Z2kPpL7_VEKysYFyQw4g>
    <xme:tBZSaCzfKEtjMVWh7vi2hadxw8fQtxUmR3LfGpXvK-6mFB1FXseH9ExqKySmzhbzE
    6MI6HEQBffJPxNzSw>
X-ME-Received: <xmr:tBZSaO3l2JRiHJxl2IODZkS9eLr0srY-raWj2s6DHk_ROvQVvFJcrKtD9gGGNkfjGM6MdEWMMWy7nJO9TFwvoWElmnOiHuJgR3o8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrvgdrkh
    gvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhmrghilhdrtghomhdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:tBZSaBBATAAxuG7h6AjvNYc776oCj1uYrIfpWkVDXL2IPJuuU_qK_Q>
    <xmx:tBZSaChrCc26jvqKSfppM0_FvOeHvPuZfOZqiUdPvJGHtnou8oruuw>
    <xmx:tBZSaFosD72CaR5T6CPHmzV5gSXqNzEGLSlRvECcSt3jva_SFqfCag>
    <xmx:tBZSaNhP5II4jbmPnIEYlTwXFf8ZlsHZNp-5TTY986eP7rnNOr9ZIA>
    <xmx:tRZSaNGaAZPArrJ4_6iMCSL6kV-g5NgzS-pIAfFSFh1TMxVkdcwNUNJ0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 21:30:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>,  Lidong
 Yan <yldhome2d2@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 1/6] remote: fix tear down of struct branch and
 struct remote
In-Reply-To: <d72fb411-2e05-441e-aee4-d8a26d652fea@intel.com> (Jacob Keller's
	message of "Tue, 17 Jun 2025 16:25:16 -0700")
References: <20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com>
	<20250617-jk-submodule-helper-use-url-v2-1-04cbb003177d@gmail.com>
	<xmqqcyb2uhth.fsf@gitster.g>
	<d72fb411-2e05-441e-aee4-d8a26d652fea@intel.com>
Date: Tue, 17 Jun 2025 18:30:27 -0700
Message-ID: <xmqqldppu98s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> We initialize branch->merge with set_merge() which is called by
> branch_get() and which is the only way for callers external to remote.c
> of getting a branch structure.
>
> The issue is that merge_nr can be non-zero because if no caller has done
> a branch_get() on the given branch, we still have merge_nr is non-zero
> and merge is NULL.

Meaning merge_nr and merge are both uninitialized and unlikely to be
0 and NULL?  What values do they have, and if they are left
uninitialized, shouldn't we be initializing them to predictable
values?
