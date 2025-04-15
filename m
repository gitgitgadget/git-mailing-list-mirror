Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1A247286
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744746538; cv=none; b=RVunSpPp4pYHUOBuEHN40LKHCyggyweKuNz2QFYBk4EfWFuUKzy9WGG82u88i+qvuMPn+ghGX33AzsOjyCfmt4N4pKoUOht2yxfMXegyz8gtXbxOW8/zYjs261RT6yA2odKXdaMaSVS01kyuvzAntJfLxbEnJkbVJ5OzrqDsktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744746538; c=relaxed/simple;
	bh=mo/dzcJEpZm/Ia+XY9ANcApDPXGjQdCuBKcKNXZfxMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G3gYZIJGFDoWx2FeoP8gFGpSyr4Wpr1OsR6MpHUiFftIXIKcOes9oClv78EJwmIZ/6SERdrkBwmkehpQpsYBXLlmZP7oTDB9SgX5fOziAKsdbstcdqCZulQX+3QCAzrkPTgjHWN6h49UYYQz3ZvsvKNXuduy+yOYuIJgxqDKMvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VR4h8aVA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vewoe8D8; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VR4h8aVA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vewoe8D8"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C5721140100;
	Tue, 15 Apr 2025 15:48:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 15 Apr 2025 15:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744746535; x=1744832935; bh=aiDZwn8Jkn
	oc3OGGnMkn/EhfJBBvOWBXxJ5UnQkvicI=; b=VR4h8aVAaYtprXWLkzemNDpa7U
	/ZmAFmUPUgbkw1ekAy/rywFoSPIQiPAo3EH9ug/KxAih8A5QEyKMJSr26niwJ2PZ
	t9iLiT3Yfw0ivUTl5y6E2ahFYBxBKUilz82q+Bu312g+wh61ZZHLbLV3QrZPZNrm
	q/Sxc37NDOIUUEVxTg7QQ6QIBSOOFh3pEVI9mKPNVfozJSm2lCGU6srZq9YElU3y
	h8yRaV3muQG0m8yIvD5ili4lVpiG+p+asSNc32xwzlDMsNNNPaEf3UVYl14Ucff6
	K+bipQSBaWS62JYtcB8h4yUGpguRBJ6eVTPYCiAHeN9ft/1f8oAs8na1/pmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744746535; x=1744832935; bh=aiDZwn8Jknoc3OGGnMkn/EhfJBBvOWBXxJ5
	UnQkvicI=; b=vewoe8D8ymjLjCfU+fMSmpzhA441n6J7zqrIt/2yrFp29mqtqUs
	0+dQwfpiO6RFBVMo9tnQzr7TT2BNQX0Yb7tU9q03uqe+LWZw46K030r2WOzNXegD
	Va+0w2QcCi9vhhv5jpiglDbQo0psJjzbngwuqVcLXuQC5tLS+/Hs9sI1UeDZnOoK
	cV37WdnEFqJIEehrKzWbdRSc0T05ssLJmGJ9jqRa0I7hH9tGMBff5ISN8AIagypU
	RQXg8dUEuM2kYzQQMhVWriEqTZfosPyxCjMRaWDyO58mW+M85uRqnBegltIDxBSI
	N7ub2FYH3bzG9g0wtRjUh5YhcoP1Z+tfAsA==
X-ME-Sender: <xms:J7j-Z-tl-goxGe4o919L6EoCGRLpgOXLC7qN4YXa3SmEiiHjkucWFQ>
    <xme:J7j-ZzejyKobUyQk3ex3k42-lJJFOjCurmosG5f1qNWvDBY7r4bAnCPbDBeviEpbH
    Zufy2oLSZauiJpF2w>
X-ME-Received: <xmr:J7j-Z5xAJRqzYiEvuFuAJ84A7z-HLxQr-wcw6p-7d7vwGznmL62ZCi7WLHZPqXTKvjQ1UtaWPOescHoDujoBBSzeVBLLveC6Cl4x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:J7j-Z5MWnLZQZ3BMboqlY-hV4YalDBA3hJoeWe2sYx-jEol3pD-jCg>
    <xmx:J7j-Z-9yhYL82GiM-UFXhdZ0adm5jJIazuAlblT8FfT22geL3p8Z9g>
    <xmx:J7j-ZxVGTy8efmJHnAcN4v8ZsM5smm69iBtjTABEJ1JO2ZwPX4DUVg>
    <xmx:J7j-Z3dGsaEHSCxtWrp5DcV2Qf38XqeViUCfZG9bCh86tmSxtu-Vew>
    <xmx:J7j-ZzHJ-6Jf7sBnT1sg5AAEWnLzQE4A3AUeXadpDoLRkdFvOE3pMf7D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 15:48:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2 1/8] pack-objects: use standard option
 incompatibility functions
In-Reply-To: <Z/60anmKVxke0AVX@nand.local> (Taylor Blau's message of "Tue, 15
	Apr 2025 15:32:58 -0400")
References: <cover.1744413969.git.me@ttaylorr.com>
	<cover.1744661167.git.me@ttaylorr.com>
	<65bc7e46309712e06a2d743172ea4ec518ee928f.1744661167.git.me@ttaylorr.com>
	<xmqqwmbmpjbc.fsf@gitster.g> <Z/60anmKVxke0AVX@nand.local>
Date: Tue, 15 Apr 2025 12:48:53 -0700
Message-ID: <xmqqo6wxkxy2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Now I can't un-see it ;-). Even though it's not a correctness issue as
> you note, the whole thing leaves a bad taste in my mouth. I'll swap the
> ordering to match the original in the next round.

I do not think we can be completely faithful to the original in this
rewrite, simply because the original is not consistent with what
die_for_incompat() thing produces and you'd need to adjust the test
anyway.  So unless there are other things you need to reroll, I
wouldn't worry about it too much.

Thanks.

