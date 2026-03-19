Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F02D73A1
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941044; cv=none; b=O0xHjdQx0GUKZAYrNPmcXFERrV01eQ+ySHfIQ8V5uZcmyp2QO9tZN7FJthD2NyZEndgrRqAUBTI47G+/oognnRYRtufIVraxrYgTPb4Rvjx7oSc4Zt7yRlirA+DzK1UihOIvQo8m2qAhqvStWepVGZDrcbVPEIc59rSG61Enk2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941044; c=relaxed/simple;
	bh=nohPZdfniTX8xxijaKppXVQcnPrOH2iDr69zafLT9Dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K++4r4A5ZPzf+dvjYbkNCTXrL1d69aH/4KxFFjb9/mSmkX8ZB1Ow8vyw+aCe56huhpyF1wAP/xYUiLLGbQln8WgRv5n02HF4bew0GgcvVyHu9he1U3Rcl8npMO9ee/42FXQfrqmC5Fw74luRgUeS+1o2a+BPhKzvN1/iboSz6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F3mRjie7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rp/C4OfX; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F3mRjie7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rp/C4OfX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 081B67A00EA;
	Thu, 19 Mar 2026 13:24:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 13:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773941042; x=1774027442; bh=n8MciB+V9w
	WeEtr0lEDtBvaXQJKrkiSz2BC/klTJb4k=; b=F3mRjie7GbBF3N/GGe03DN29ob
	e81FL0g8aEFl+viOINb/fxlX2kNlRPDwKDQjDT4N6AcYiqijB0mtSASa6/ofxFy+
	4q8IgCTohL0+UuKRff1pEC5PewMCTdDsdJYBLRswXJwtsdeq2cyOyX3cnM3MJvr0
	Kf+s9ry3+PZ2/jfLQQzDHX8ZckFe+DBj+ZV+T6V5K9+LgJ3fdkTlBnC2dwl2IlyF
	U3DWtmWtatA9AkC0exSMdIec320vUTOzuVfb64ff2Op6lnXHu8mMexV/l0NOsxNX
	dW4SylE7mkiu2DsAy/rNzt2f+jdKz903oAkez6DU8d39pMjKUZySf1YO/QCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773941042; x=1774027442; bh=n8MciB+V9wWeEtr0lEDtBvaXQJKrkiSz2BC
	/klTJb4k=; b=Rp/C4OfXM3TH0xdZTcugSl7D4w6f4e60cLuh85b300YwQAuVBbW
	xsCLVCVcg7II3YBxndtcZ/w/3YsAvRk8cSmOEq/j9yMvLcv2eHXGUTIBDBahR0za
	TNhdUHsE8Ry4fU0i7gUIFLNoFX00k7+vHRxx7+a24tWT68cnKsL547WLqosbeuHr
	euq8T2uxdPatyYwTgx0x3/e/ZPr4wyLvMCbhPCiGr9tDO8bfXTHE59c7jZbLyM4e
	dmVGWZ7tW+ZjzmSodXQW2Th4BWuUU3sXs+i9eBMQ30iOv3AdcH9Xyhes9MZfDWS3
	KmGn8q9xkZk543fZTxl4+3rWLfb8c8wJ4eQ==
X-ME-Sender: <xms:MjG8aegvgsVC9y5KhSUXAnRL8Bp0ROXQHbXqPGC3vA32VKULJlVOLg>
    <xme:MjG8aWCWh8zOCTO-BS7JnotjbX6aTQCUEQVBdMxno6_JBjExt308238ONvCJEgLby
    QafhZ1GPLaceztMMXTpJZ8OaYUv_w9C2WMpqLtM_-QWmX8uUtYpvg>
X-ME-Received: <xmr:MjG8abFUPzUNaCpd1OpRubW8PJf-ZGOoBcjh-1_sNvaDRsrdOD2tQB7sKX3ovCJ8Uw7vzf2XpGgFqA1-S-gT-YXtGzrCXP4_DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:MjG8aWIjWvxMRtLK06MlU7_E-X0qPHLO5GVCJNWvUJFE2tbEjIBM0Q>
    <xmx:MjG8aXlSxLVFlVna6bIbGfiSqZTpOLvWFY3a936qoG_7FoQXXVudvA>
    <xmx:MjG8aWQh0gpvcmOPSMWOi4LDlOe1n-4h-S8R5CsYDgU8ksKG4_rXKw>
    <xmx:MjG8aRIjk217CNLb36FeVDh9Otyjyw427DIm_lStXDF9RiGbd4OqTA>
    <xmx:MjG8actSnpXfiTuG21aLcnObfJn_GLGP7W0qcENu0xkOtO3p72nj0k7g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 13:24:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: git grep failure?
In-Reply-To: <7e8159fb-f7ff-41f0-8955-5ed2dd5dc7fe@infradead.org> (Randy
	Dunlap's message of "Thu, 19 Mar 2026 09:47:24 -0700")
References: <7bbcda60-dad4-41d4-b994-c19f83f37e2f@infradead.org>
	<20260319003829.GA3530301@coredump.intra.peff.net>
	<2c943182-d5d7-4f72-ab97-8d07bf4ed216@infradead.org>
	<20260319155326.GA3611913@coredump.intra.peff.net>
	<7e8159fb-f7ff-41f0-8955-5ed2dd5dc7fe@infradead.org>
Date: Thu, 19 Mar 2026 10:24:00 -0700
Message-ID: <xmqqtsublolr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> (/me notes that git am and git apply are different in this regard.)

Yup, consider that "git apply" without "--index" is a mere "make
goodness invented for Git available outside Git, as a replacement
for 'patch'", just like "git diff --no-index" is a mere "make
goodness invented for git-diff available outside Git, as a
replacement for 'diff'".  Their primary value is that they work
outside the context of Git without relying on a Git repository, but
they have limitations for not relying on a Git repository and data.

There are better alternatives (i.e., "apply" with "--index", or
"am"; "diff" without "--no-index") if you are working with Git.
