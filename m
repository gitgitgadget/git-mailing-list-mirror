Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93003D561
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749173318; cv=none; b=SSXOqxUzbBC1TXKyF430RkV6GBuU0tbS3u7L12iwrBvT7rHE9Z/OKNgAIsRBEZKEUNX0U8/uh1f89UzsfNmcEHuIIOFOwc4iSP0JdBE2ZFrXm/uIpO+f4Yr65sVQhLDTJQ3uTJdCrQqCQ3AYyKMQQzQhyHUQCt65K3KwnPGHsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749173318; c=relaxed/simple;
	bh=ERqrPd4tfVJ93Kzce7Lh0P2Wa+hPSh4kyNEJXgv8Sjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oB3aRTvQNtGqlaG5a4OVLmU2yWtzZBHIrgQGCOggDyZH+XXLf+In3YwhwRb5f2oEhqiKaFAJw7hqT5Zlf8A6C9VgYa9efoRhO/2f974eIHRj396V6pQL22tIffmJDuGl+Ra5T3Vsr6EO6DJCRIeo3bVIPGAF/7pD9Xtz9tD3VWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FnqFB7is; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=deuFqRTW; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FnqFB7is";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="deuFqRTW"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F89825400FC;
	Thu,  5 Jun 2025 21:28:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 05 Jun 2025 21:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749173314; x=1749259714; bh=+Lr733Yetu
	4OFFdCmHJEawZMB1VZfTJ0pO26fqosXiI=; b=FnqFB7isIGrBee45aXmhOMCWLK
	u3eUZhEM4BExwxjGw+emnMlR1QWan5IAomtV1YZ3jykLAolW2GqGWBWNW1N/wb6s
	XE8lz1KsJpLxrx2cfaZvZuENoJXftbgUptmCUmAZkoq86MjLbo3mj93ZLocwrEhT
	xDMat2vOlceoP4zLS7RNrKCgLoQFFpuv/muWDm6hDz5SvdgKfKvp+wbFH2srwneO
	CoLPInXpsN+DvVzEqQPmoQwOyr6HdMG5IscUQXLREeqAXKOmZT0XL5YSSkCH2UKb
	1yNAY3rctmOry1T6ke5oZeuaTo82KE7E3reSxMJyiSEfAXuK3P1ByaecIfkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749173314; x=1749259714; bh=+Lr733Yetu4OFFdCmHJEawZMB1VZfTJ0pO2
	6fqosXiI=; b=deuFqRTWbkm6pWnfhPdnlQ7hgeYVOHC47BdSnE56OVyNyfLgyL6
	cslUoC3zTaYY42/aomouLft58nW8bgj/oOOmEMvrwrnqD1LNhm4lXONt0kD4bECI
	ULVmt459LPjetnLtnbGALwEzZb6cVxp0IXzi6hzeC0WGhcgvkRO7G1fZZkt6NsmA
	wjqRUaMrD6uS1o6FCwns+uglOv+r8WabTG0PXHiEbnI0bTUvGJ8uif03XKA25KMr
	CQMGxIFvcBp2OuYKcrGg3rZ52yXyyj8VStl/x+GPo2IVteZWnySxd1qAOsoKv4Ty
	V/l9am20Eofu6KIQxmZchsYDr8s7eNUV+tQ==
X-ME-Sender: <xms:QERCaJ3GbuoYwmgmMBGRt3f5viJxG3ycuqwxmJ4MzBmnTuVtpp4T2w>
    <xme:QERCaAG7Td6qG07SHbkOMj-Qt22_94OHCSIytxNulArDuP6a5fvuiXu_bOHd8faXn
    2BSsmsstiZ45OW-2w>
X-ME-Received: <xmr:QERCaJ7dZ7fF165-X9xQ65r-SQctwOLuqbBdvmP7-DxNwdBe9BbmRQs9ZX8T80YY91V4qctiDJZC7VEIHVgMiK9MBRgWBvX6eA6W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjh
    hurdgvughurdgtnhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QURCaG284P4bCaOIitfchcqXn1dCZR_nuLEA8jukSFgKfDWm1hbNxw>
    <xmx:QURCaMHsueWUgF2gi-UGC5DMzSOULDpr9z106uctuFFojUsxpW9BAw>
    <xmx:QURCaH_QsfuXPWjo68aZVls1fsyS5NrNFdAcGc6I2eDv8hvb_XIaNg>
    <xmx:QURCaJlxubUyS3Nq1VrKMssS-xGPS0IgsbJIejgf8QH8K_z49HJ4YQ>
    <xmx:QkRCaHV7quXf2F7oB2D572SRwRiAvzm4v3NdR3zCk0S2EmEkxuT97KVE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 21:28:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Taylor Blau <me@ttaylorr.com>,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v6] pack-bitmap: remove checks before bitmap_free
In-Reply-To: <pull.1977.v6.git.git.1749138820241.gitgitgadget@gmail.com>
	(Lidong Yan via GitGitGadget's message of "Thu, 05 Jun 2025 15:53:39
	+0000")
References: <pull.1977.v5.git.git.1749104667618.gitgitgadget@gmail.com>
	<pull.1977.v6.git.git.1749138820241.gitgitgadget@gmail.com>
Date: Thu, 05 Jun 2025 18:28:31 -0700
Message-ID: <xmqqplfh64lc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>
> In pack-bitmap.c:find_boundary_objects(), the roots_bitmap is only freed
> if cascade_pseudo_merges_1() fails. Since cascade_pseudo_merges_1() only
> use roots_bitmap as a mutable reference but not takes roots_bitmap's
> ownership.

Sorry but I cannot parse the last sentence above.  I would have
expected that "Since/Because X" to be followed by comma and a
sentence that describes the consequence of X.  Also "but not takes"
-> "but does not take", probably.

