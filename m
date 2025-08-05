Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7933997
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406802; cv=none; b=c9SrLe68Pc+9S5iM9gHMbVDNNxGPKXpG14BCXDlAmLVRR12Gp9qb4nwUUxx4FiBvo1aMZnBZWFrcBVY7tdvK0Jd2l4zMTv8+RUt0UayjyC6kjKFGCV48acsfbFAAXuSWx0VYmEd0h7NKgdLciL3mxTNXQdcFTBbDQnmxQfQIiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406802; c=relaxed/simple;
	bh=LC/4C9wp3PlFU0H7FFEhAe6pHlmL5Xjw6Yc+cCV80yU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SZGSqruAxnDzPfTqsk6rtEXmR0SU002XAiknSmwbfJO41kGE45j3eqNzeqQVTQtG3do9jdlTmkOODHcREE0diPlcI0yYZw+3h7/9D9jgJTTUI2pRJQADbklJnDwQDQEnuxHgfcO+01xQy7VOXwTYdtkEOWFIy+j0NLJzHmyo8do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M3CBjJrT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uc56aQdD; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M3CBjJrT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uc56aQdD"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C38141D0022E;
	Tue,  5 Aug 2025 11:13:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 05 Aug 2025 11:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754406799; x=1754493199; bh=2Mq6Vdo574
	I5+MtrPnw0wx8JYcoUJJ3ArmzPZnuZqxE=; b=M3CBjJrTVANN51h5zo23PFjmau
	3ZDQXQzqo0hSnFUOv4DGccPqrGklkw8B7WAgsIzFwSrzCwRHaK9F80IXMk9FDXjI
	gk+lqO6E28mmXuK7BNR7qG8hGTyqt+UWMBRAHpeAumj97SgDFCG5aQf5fOd5IP7H
	jS7C+UYiJViGQyI3ZXCmm//n7sDUZYSExJ6so8/3UyGcY/dtsfXcHEkiRLbezqe1
	XRaMU0QJxKcYwhzbkWaGyX9IzmpkClcazziHILABNmbzzOLBxuoRQdfcVJUxlbQX
	Vpwe6MYiZNTb5/4/UjTtdz9e5Ny82JtAEOe/vhJWoAtpreQXZRQnI95tex0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754406799; x=1754493199; bh=2Mq6Vdo574I5+MtrPnw0wx8JYcoUJJ3Armz
	PZnuZqxE=; b=Uc56aQdDVrMxyS67yd7et3ADhAASeT60tm73wrxl+QjhQ0I/YO2
	7dqYjX9jgNHveMEEtQb/UfogGVLnqxmNIoB/zkBBWk3itXGCqGdfpdQjp2lQYjKu
	JCAdT4gKHwVM84fL6XeAkMS+it3MikBxVY++qwKdaa9ZC3ecfkN1B4HvGPkEK8cy
	xENkXMLum08Xx5hBHWO5DyRDe3imkKL6C9Chu1kdJKzkJu05CgKxMHh5HxxaDVFt
	pEhznyG3q1OGlduPghP+tYEKgBKvLYztCnxooAHQfi/dgni/G+xsNJnzYJGXvNlN
	lNJh/RoSkcmE/jHpU/GuNZh9zhKaFLXn2pA==
X-ME-Sender: <xms:jx-SaDRq6ytsTtVJvCwPYgZQWejZQI3zJUkbVIpZxCOUK8PVfwO0Jw>
    <xme:jx-SaPX9gKJ86LQFzPvMsEeSE6ppMlY1em6e4YJMxODfm7hjPUqREZLYH2OUrkmQw
    AnjRTawlxJ2iXkW8Q>
X-ME-Received: <xmr:jx-SaFZNEoJK6DV5Ro7Esrxsn3TVrZokIeFsPl_FigkpmaFAoZFH8evmz_69Zy0cpzuFmmVEczOHWgoNmLnAuAU4WKaRr22xFUTeBUU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehoshifrg
    hlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:jx-SaF1nz1-_3q3GpHHiHzg2h0-FXhUxFurvHpslOwxmFqx-q9JlKw>
    <xmx:jx-SaHjefmBY4-mPWluh6iKoUKiAmqs6MyyI4sQYjKe34dvPBPYm-w>
    <xmx:jx-SaJacb8A0ms2VfcgBhYFc4kXx-zCM20bycTv3ygZr8yuHz8wzrQ>
    <xmx:jx-SaHRWqb_IgPwuUkUKlC_jWiu6cgEUtqkOgWOsZ2Z_pYemZDcq0Q>
    <xmx:jx-SaEWnAKEE9PMohB2XPXFYfaXKYYE3g3RcoENMS-xo83J71Ir8bBho>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 11:13:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH 2/9] commit-graph: stop using signed integers to count
 bloom filters
In-Reply-To: <xmqq5xf35429.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	04 Aug 2025 11:34:22 -0700")
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
	<20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
	<aJB5uKFdGybf-IbN@ugly> <aJCW7aYqJB20LDNg@pks.im>
	<xmqq5xf35429.fsf@gitster.g>
Date: Tue, 05 Aug 2025 08:13:17 -0700
Message-ID: <xmqqv7n13ipe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Each of your "stuff" may weigh N megabytes in core, and if you have
> M of them, you may have to ask (N*2**20)*M bytes of memory from the
> allocator.  Your (N*2**20)*M must fit size_t _and_ you must compute
> it without overflowing or wrapping around.
>
> None of the above mean you have to express N in size_t, though.

Small correction.  I meant "there is no reason to count M in size_t"
in the above.  I am perfectly OK with expressing N in size_t.
