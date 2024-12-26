Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D721647
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735228998; cv=none; b=B5eXgjZvuRP6RAegsDKCQFHn3u7lhIG8de74zwjavzUvFLp2YTwggZWIkcLk+tz0t83qYmwoOksIEKubCHE2BPFFL5J6Qf6W8+cnuuFtRBVT1DjEgsICyk154FeSRxmJJ/ArjcWyHZz2UcWCp/Bg5Cy3k2ynykZMWbqM9yKtwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735228998; c=relaxed/simple;
	bh=bovctt4W8RWcO6kgHA1op7AFsm1titDU+OoeEqV2fi4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q7NE6fzl9BzoLqJwINbdtxwKlpYi69/O1rBE9zZq3Cpm4kUZ9qMKqw5vkP8Tlo0FGY4CDY6hWBIF9NPLvx9oHJ6TJRELhZ+Q6/X9PSRRqyLnfeHtj7R1vZRRMsWBP+krNY/ZwuQn2QFSgoYpsjwCNv4e3pTRNGwQCMq+KOtmbQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XuIpIWHN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j5DPfQEj; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XuIpIWHN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j5DPfQEj"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 423B825400FA;
	Thu, 26 Dec 2024 11:03:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 26 Dec 2024 11:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735228996; x=1735315396; bh=D7Sk3LVdmq
	BUa6U9b+9OkCB4mh4BwRRUCuVtEq+WbSg=; b=XuIpIWHNuSGwJH5tRONg4NZxS+
	gdtCmOXjMPYkI4H/S3/sOlJv22puRlRPvcRrqrsCmRejM8vW+DeGcbS7fW+UqGyJ
	VidCWaWnaCxtPZhSiyhJ2qLPFi7+wpNdluBY3Nwvm5qwqeWBg8ttv0LaWv75Dssm
	b7oQZbhtKOA3iS7mHum8AEomqZb7TeFRljbdim7RKkpVTIeFgcY0+ioEsMJGCFnh
	4+gYZVfyRnAcBbMboiWx5wlsbQfkBBPY78RW/nbEfaEyR8Vx3BIrZFlnay+O13nT
	+sfoHsBknc3Y0aaourIT7Ypopu+CPCMo2XwriWOio0TnYfMr86EgOERjZDvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735228996; x=1735315396; bh=D7Sk3LVdmqBUa6U9b+9OkCB4mh4BwRRUCuV
	tEq+WbSg=; b=j5DPfQEjAuruNHGjwiaskpLoEHVxgxuf7lsTydd9Boh9MI89CpE
	9tRIdk20QRR1LZat68UmD1Vib863GtS5qIJ0YMbpPJUukCktMDhacEFII3YUseNA
	ZaoKN8crPeuQBfvQT9QBXjbCqm98qfFgjc3Ev0CnykyexArW8uMND37DWy3M28++
	0h+WKDVxlbUq3j5TP8uw4wK34mkQHyrFRaCwHAsnfSRh9Mr9qHmRtEGgY6eUXVCH
	xfDBJbGkTg6cmNdrvJ0JXqlJi8H4oucODLMahTKE8hUQY2c/7sd7a6APv7+o2bUy
	p/CMVXqmgFyjamqshr4rStCPkReoN1r2Yaw==
X-ME-Sender: <xms:Q35tZ7EVYwgZiRWGO69H6tFPdSXLkUIhjoQV8qfFcB6FAw5mBzfp4Q>
    <xme:Q35tZ4Vez1xL9uI3RuOv82UHYVjEht_CKbDOTOKQpWdz-3TqYowKLvplI9Ddsl0P5
    YJskfewvnsW9w58yw>
X-ME-Received: <xmr:Q35tZ9IUM0PSYRzQ1UuyBQnmaJ8TR90rKu5Yrhg_a-R-qEobGjtSCbvgwl96PqcsvuSk4LtPabPJ2sS5mSq1CGjJldOuN4LYbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejke
    eujeegteevjeetgeeileeujeeijeefueegieetiedtleffvdffheeihedufeenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrd
    horhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Q35tZ5H17xM7-x-dOzNQnZgqv7GxR7rw1ySTpi4z9wTOSP3e8qoHlw>
    <xmx:Q35tZxWZu288Vt7NY6osyUP2XgKm_ok3XaTHLAp_EdJktpWzR-ylCg>
    <xmx:Q35tZ0Ooq_SgsbsZG9qC4o9wyaD5IJJTmXdexq0XX_tf6sfpQbQupA>
    <xmx:Q35tZw1opBCIErhYek6BKEQnra6gIH2bFYU3-BDRwCNH3HvPvVhycw>
    <xmx:RH5tZ0Sz-fsdXIVMnL9svxJPwZg6QiZTCUmzNkPe3lk646fwc3JZ_ujK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 11:03:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] git-gui: console encoding, no automatic
 empty-diff-rescan
In-Reply-To: <0e91e811-5f0d-42c5-94be-8dafa575f6cb@kdbg.org> (Johannes Sixt's
	message of "Tue, 24 Dec 2024 12:45:50 +0100")
References: <0e91e811-5f0d-42c5-94be-8dafa575f6cb@kdbg.org>
Date: Thu, 26 Dec 2024 08:03:14 -0800
Message-ID: <xmqqzfkixwhp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit e5033898da23b6e2f6b77320bd0aa613595a50a1:
>
>   Merge branch 'ob/strip-comments-on-commit' (2024-11-09 14:37:45 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/git-gui.git master
>
> for you to fetch changes up to 5c95773eacee6eeecc16506fad3ca7fe6bf249be:
> ...
>  git-gui.sh      |  3 ++-
>  lib/console.tcl |  2 +-
>  lib/diff.tcl    | 26 ++++++--------------------
>  3 files changed, 9 insertions(+), 22 deletions(-)

Thanks.  Pulled.
