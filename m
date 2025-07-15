Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8A333E1
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606044; cv=none; b=Yv/NRb/elxOW6oCSHQJqS+jxn+dE+FC9zzr7F89Y30zFKdQC7wKSoLESmFscTaiy+axrSsuWzFhXQKKqYTW1ve//3d/CJCv6a2YWlDfNVUlyiUArCreLcR2Ol/+w+hVtOdNfeYGzunlpiZNCZb+VqRfH3K+kr8voorrbYStg+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606044; c=relaxed/simple;
	bh=uY1Eo64mH3gCw7N9j0hzXtq1IuSuiRMB7zVdRE3rq/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GaUZ/kMu9wX9Ju9c8MGanvQnb+NcO5om56Dua8eU95qyOOUf292qoln9UZjAYFnmuB12vKXRvnHnyg8w4uke0hZ7JcmfgLGkzgU8+iuCIbqxkEZtDag0ZRbnupGqVZCrAsB5TP9HV/6eGqSzXzNulnUg/X/5XtSHK8PMNuFt7ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hEfqzd0i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fQLqMDXR; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hEfqzd0i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fQLqMDXR"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 81EFD1D002C5;
	Tue, 15 Jul 2025 15:00:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 15 Jul 2025 15:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752606041; x=1752692441; bh=CJAK5uNTR0
	uCug/aPKPvPoPmrYmjdXf3Jbf7XTbOC70=; b=hEfqzd0ivo5kGf01Zle/AkRU+t
	lJaZpqaj58BNWkHvoNqppqc9OC0nXBaCGmQj/MRnyAhxCdqoSlRXXERmDEVE8Kpd
	yygWFA+R0qNtVXUeuXD28wd6b3ak5653+8ozoqVCvicKrGrdrqPOC/M4APrE2qJa
	xOiwcF9/3P7ubAJ4VRNtrRX2iD1TTCUBLUmaajTdAvY+S4f6Bnctlxoufa01QdN+
	28tEUBWO6pVUpzWkSASweXe0JK0Ay+GrZ81tJJ4obeZvgAwXUIjiiM6e22YvXDIX
	ZzR6XSGTebUDlMPQklxCM9S81P+nGiVPr+CWz2pFRdwrk9h/rlA6RohTTwRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752606041; x=1752692441; bh=CJAK5uNTR0uCug/aPKPvPoPmrYmjdXf3Jbf
	7XTbOC70=; b=fQLqMDXR4JIxEgr5ETyytKPZ1eU+wyzxg3Gmd37Fw+IQ+1o1vN7
	4xD3leZo039WGojKO8Azzv8qX4VQNz0ZY/rVweUsaOw2QYPb6ijLAb322RSljV5h
	D0MIBSObxtQe0IkcS9ILTj0h5UxNxvYLhNiW1FOSqaQbvE21pPQ+gFoN0oahB3OR
	EujW1hZaWsW0f2W+OpVgHYzEyXzrKxGc5wLi5WFrro+o4DEQmiH1ZKlXDR9ChlHo
	nYwdtQuO4YrQFcDaazynaUCZ0zEgVI3ylopujjZxLD5SBXIV9rY/pSblsgshtfIZ
	Nlv7DkHfx8zV69iQffm3wWfoZtQafNN5wNg==
X-ME-Sender: <xms:WKV2aH_ztPcqm4ib5W-mm87Grdo5MV32Xr1KNDhJYR_WnwQQNVMGVA>
    <xme:WKV2aBSjJ5E50nDADoUgNh33bQ_U5nxQONvHoe2XVL53B7U9DEch2z35jFxXV4R6K
    qRmCnq-pvrjWKMacw>
X-ME-Received: <xmr:WKV2aLfVg6dRmKLxRY_2EIAkHG00FjAoDvkjiNkfBsqBUlRYnPuHvtMYOuk1CNsagIUFGK-5pZLnO1IHTIW7_tnoQ2XHDAayVismF9c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghooh
    hlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:WKV2aFA9jcMkw7xqg6naIo0so94Q84W8pQMduIi60rlG2ucnWLjIbg>
    <xmx:WKV2aNlaRmCmijHcyhCbATXSU9OeDfqpmpouw9DAZRm4fL95jW13Cg>
    <xmx:WKV2aAcAepUaZn--m278zyNp78RtiqWW1RBN2v8-Cykpx1OQoFCSaQ>
    <xmx:WKV2aBRI1eelQ2_QYzL1yG_cMhUboXVHyp3DWqsitx1IrjyqAY0mhw>
    <xmx:WaV2aMyE9uY-WJ9xZ6LrouL8ho75U7-k5RgKaL0AtNVyVyBqS-zPPbPQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 15:00:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  schwab@linux-m68k.org,
  phillip.wood123@gmail.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 0/5] for-each-ref: introduce seeking functionality
 via '--start-after'
In-Reply-To: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
	(Karthik Nayak's message of "Tue, 15 Jul 2025 13:28:25 +0200")
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
	<20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
Date: Tue, 15 Jul 2025 12:00:39 -0700
Message-ID: <xmqqple1gtyg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Changes in v5:
> - Changes to the comments to refer to the flag
>   'REF_ITERATOR_SEEK_SET_PREFIX' instead of a variable used in older
>   versions. Also other small grammar fixes.
> - Added a commit to remove an unnecessary else clause.
> - Move seeking functionality within `for_each_fullref_in_pattern` to its
>   own function.
> - Fix incorrect naming in the tests.
> - Link to v4: https://lore.kernel.org/r/20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com

The two refactoring differences relative to the previous round do
make the result more plesant to eyes.  Looking great.

Will replace.  Thanks.
