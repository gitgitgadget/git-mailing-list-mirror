Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A02749EE
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646656; cv=none; b=im99t4VH94cIxHDWINq7q1Z3JYOPxL+d7Ygc1vSyrNPiSo5eVpf0Mmo9tYaD8xhBVFaN56rvtzWutDVYMQCRPgk3kVikh2tgEgQ4t+036spOZ6aoyYvdoDkcXNY7UHrilbbCowy/6rNa8EB/W9qceZxQSPQyW/Uhs/SN6vNnN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646656; c=relaxed/simple;
	bh=dYffer9XuZUVCD8SdLXC0dn5gdtDdF+/tC9EHiC24KA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YhRYaRNfosJaq1nCl0n2EgGULX6LLhXUTkXMGBg/sO+i/nKSTAvydYH3tN1Cx5nw+h+se1p3ULy/SV/T2AgblkPFTpxbz8pFy763bHRzhp5Sn1SU7mTlt5mZyhdLtwUqmylAHThAKyr7KOgpEG28bXYTaOR8y2l95jc0o6360Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f444bjhi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UwJ4s/hx; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f444bjhi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UwJ4s/hx"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 808B72540374;
	Mon, 14 Apr 2025 12:04:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 14 Apr 2025 12:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744646653; x=1744733053; bh=dYffer9XuZ
	UVCD8SdLXC0dn5gdtDdF+/tC9EHiC24KA=; b=f444bjhiiZMHidqTCccxwRsYcm
	4kyVRwTviyjQB6VUY3lS3DyAOkKS9b0mThQgcH21DCUrrbh8yPKUzWx6PXtaqhT6
	NGkCVBGOxfNp2hpoEm2sRcOp1sKqRkpNhfaftYmGUXzltC+lU5D48wl1ivYLOuzA
	toM7pUCyM75yDixitaRsKpC+QkVuoNjgtbMPbT5o/tzjb8FDIhI2vGjt0dyIYlcM
	GZ4sE2p8Y03jwWbftcnT/kfMLlgUFU0FN4WbIAezWtHNByMMb1RiW5LlnY6N6f2x
	dJHojaGIIcZxqCCzMZWcXGoDZFnP550W7EhCiAuS1BuEGREZACv8zas5SsLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744646653; x=1744733053; bh=dYffer9XuZUVCD8SdLXC0dn5gdtDdF+/tC9
	EHiC24KA=; b=UwJ4s/hx3IBlCC7cFHbRVK8NipZMs4/sV1q6UfgrQK+Di+35BcS
	XPSBTtNmfGziKh5WuGYxr9Aqszgs6hB2oBu6lfGSKSfORs7HS0ptx4UoPPnh7huP
	kErPqpx2I29LiJWEE/3gI1Q5uE/SxqrRadCuVRe36MHMnYwpmp5zKMU0HKi4LPOA
	FiWyXhwDsNKHqXzFNJV6ZwA+jIAnqOLdOLTU8sMunHXqLrScijrCH+e85Ow1XNZL
	aLe+T29K9weuLZ8yRRPJqFfwHHh/LtrS7HwEvw+NakicXYjh8y8zMlchtNeBsSVC
	A3XcgEaFdNqZ5749xOKfnX2k5zkaSaf0maA==
X-ME-Sender: <xms:_TH9Z1khb8t1OI5vu-jB8915DKkC_whAEkJkH0uClnBPkwQzdNgYzw>
    <xme:_TH9Zw1FSaqEOandzVDOYGXrVGzTQUykuOVjYqxl_o52EU3MAybab5cAwwWV0mqOP
    KPy08tO-gYb1MFfbw>
X-ME-Received: <xmr:_TH9Z7psmDqe0RW-84sxu72V6iCqcP0osmzq293t0pHRvoUgLsYXF_xaOa6HeTypQTI-ru1tr-Vgj2K8hrpPqnQacKdE_fgE-K1i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvvhhrrghiph
    hhihhlihhpphgvsghlrghinhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepvhguhigvsehgihhthhhusgdrtghomhdprhgt
    phhtthhopehnvggvrhgrjhhsihesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_TH9Z1nT8LBG6sRnTY8J_CeSBaCELVKduLqMeLh1SdkdUWLB3vMglQ>
    <xmx:_TH9Zz23u_SVSUmfol6wZCjCP5rCfT6xAIK1UmIPwnA9pCCtbmgftg>
    <xmx:_TH9Z0tvsC1LppQtVz6Uv6F7m9gjX1ONx8eHijEVmmXUW1GNj7Ma7Q>
    <xmx:_TH9Z3VW3g0tY1ysVYoR2neb34FgWCOfdAyLjF6NkkKEbSuH913nbg>
    <xmx:_TH9Z-F5QDti7dXAb45qmX39ZisffRaS5GvZkxQ05o_CdDFn-nguPzbZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 12:04:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Victoria Dye <vdye@github.com>,  Neeraj Singh
 <neerajsi@microsoft.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/3] Two perf test fixes
In-Reply-To: <54864a66-c399-ac2e-e223-affd6a493989@gmail.com> (Philippe
	Blain's message of "Sat, 12 Apr 2025 22:50:33 -0400")
References: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
	<pull.1936.v2.git.git.1744481732.gitgitgadget@gmail.com>
	<54864a66-c399-ac2e-e223-affd6a493989@gmail.com>
Date: Mon, 14 Apr 2025 09:04:11 -0700
Message-ID: <xmqqlds2rapw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Sorry, I forgot to mention that this v2 only adds a third commit
> with a small comment fix.

Thanks!
