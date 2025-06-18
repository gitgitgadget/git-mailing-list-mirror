Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443421C9F9
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750283453; cv=none; b=PHwNKFGV4tlHPY/VlDgfPK3bErLmGoNgWhUahjSGR2nw0DQk7P+wMA90epwKFZ9zpfSohFWjO3FtmdIE1ZnCHjkkFq6xIELT8y4aEz/qFEl8BFr1FeWv1bDUHgGXjxH+vokAvqH9/WkFLmkTuaR1Qz+LGp34eCxKU49cWsoDhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750283453; c=relaxed/simple;
	bh=G06J14fNSg+J3FoAn5i6Gljjsi3J8+eHH6YGWzjlqd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sTtzeE09kqxo0lBJKsnmwnZPR1pLk0qRfikoQFVCPtxEq1CNZA3MYxQtRN1KH1sSzTq7xYm7XE1Zr+6ykXlY2Nti/fnoxzD/8T3YDhU8vKfCSEPDvgC7RM5Rqy3nYWrL0/Zsppb0QJmvZm/6vscnQGvLC93LvG4bsu9UTrrAOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wbq1tD2F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OZiqKyfl; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wbq1tD2F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OZiqKyfl"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C22A1380469;
	Wed, 18 Jun 2025 17:50:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 18 Jun 2025 17:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750283451; x=1750369851; bh=G06J14fNSg
	+J3FoAn5i6Gljjsi3J8+eHH6YGWzjlqd8=; b=Wbq1tD2FSFXVbchBWLlllEQPaU
	igBo05EeL618CCgKVx5eQbvymYPQSbKgxAo3UMUqCQWLx48qrDDNqW6ADD71sKQv
	Zl/ZXRlkVutuWwJnI8rspW9ytnRB2RnbWiin1I9dTrh5tnZLHkM+cUc7Wf9qUoLe
	sJtUDnau8YUQ/zaackLzetB6Kvigx2ZIq6MFN9JvFC3O9jJtVCo9eAfDFGGsJVuf
	BGxgfRAYEcE8IhehRzNWNPLlvfjU8gchL2exXeFBVuwzzJfOc3PvxCyGdbbyWjPW
	aGGbhhFzFREX2zhUptsrNtDchjqUyPD20l1/4yKufFQcEVCPdHELHt9JOsuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750283451; x=1750369851; bh=G06J14fNSg+J3FoAn5i6Gljjsi3J8+eHH6Y
	GWzjlqd8=; b=OZiqKyfl/YZy4FeotY1yZOkgqNqeS90BmPY7p8gqbuzYmd9bj9Z
	V6xbIu4cxZGEngy+rd0Ld0qZcl5M26fNOPRGsyJYQuaRv1if4Xo5vspVsL9vB/8d
	sWLw4VpOOJyD8Vp2zX0bHcua1wTNUrEUhxMMRDZTL3wq1UB/vAX69TADBqffGyv4
	XpB6BfvoDX3fC1izuR7sJM0LSUnxKvvSR9Sg9eAk+OBU/91sx7aE/rupxmRsEtoH
	4jR8yvCFhSO1Lr1TIrHvlWYhCkLWlXyLsLyOTSoMVhaTSRlbcTSJd9ry++fnXslU
	1ZNZUQ+Exb6r6y7AKCuPLnbTYtrEff4RZwg==
X-ME-Sender: <xms:uzRTaC5vNhLCAv8CsBMBehiBLLeT7tpRZ1T73odBlx76ntXOTLXNog>
    <xme:uzRTaL7GblPMiMwKNDnP5xRPKEDzRirkmF9wvDH2K7as40AgIGCrWHh588pvlqN5Q
    fUAHBoRuhETl05iuQ>
X-ME-Received: <xmr:uzRTaBerQf9TOXALAq3k_rBYoRfkfEyNzMzz8sWkusES4JR4utCTSrfvdVZtMvPjfS4Pv52bnWIDmXVGSRDcdo9QfVDIUV9PQg4B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhlrdhhohhrug
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uzRTaPLuw54okVduRuP8HwTN52YI1_yfcVD1QsxhU-MlJ3lSbADv8w>
    <xmx:uzRTaGLtdQG5RdO_B68ZOz5StdmRu9QTAywsVEg1cTqs5KaBSS7e4w>
    <xmx:uzRTaAy7uuWpBUXRV4lJc0FDPv9EvkXxh-4v9p6cF-xTaENetoXb3Q>
    <xmx:uzRTaKL9O94IL-YDFyifoWt9_gLL2NNUCLN4DxZMPP6NlgE3h5Za8g>
    <xmx:uzRTaPnLcCvED7HEmFBo_4a5WMFsbAWaAqtPlGXp4H79etwIFWtWQjQQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 17:50:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fetch-prune: optimize dangling-ref reporting
In-Reply-To: <20250618211024.2332525-2-phil.hord@gmail.com> (Phil Hord's
	message of "Wed, 18 Jun 2025 14:08:39 -0700")
References: <20250618211024.2332525-1-phil.hord@gmail.com>
	<20250618211024.2332525-2-phil.hord@gmail.com>
Date: Wed, 18 Jun 2025 14:50:49 -0700
Message-ID: <xmqqzfe4d8hy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phil Hord <phil.hord@gmail.com> writes:

> From: Phil Hord <phil.hord@gmail.com>
>
> When pruning during `git fetch` we check each pruned ref against the
> ref_store one at a time to decide whether to report it as dangling.
> This causes every local ref to be scanned for each ref being pruned.
>
> If there are N refs in the repo and M refs being pruned, this code is
> O(M*N). However, `git remote prune` uses a very similar function that
> is only O(N*log(M)).
>
> Remove the wasteful ref scanning for each pruned ref and use the faster
> version already available in refs_warn_dangling_symrefs.
>
> In a repo with 126,000 refs, where I was pruning 28,000 refs, this
> code made about 3.6 billion calls to strcmp and consumed 410 seconds
> of CPU. (Invariably in that time, my remote would timeout and the
> fetch would fail anyway.)
>
> After this change, the same operation completes in under 4 seconds.

Nice.
