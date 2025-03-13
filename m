Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883A91552FA
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885605; cv=none; b=NX65/kwskl9R1YFXOwgrlcLiESuLhkQ9smXn/CMb7Zk2nJajdprXGNzJoLIRCyHVvsBXYvvgHMFztEWJghY5QEbmOFOD06EYhZbJPUXOHUP7JRLSOtAWHpITaV/d2GbIUK1bs0tu255wi7F/JiBxCCpx7M/WXKMi1BSt2dxzlao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885605; c=relaxed/simple;
	bh=ybqnIaPpwDfCPRhU5fFYFmNLnjBOqZCjBs+wBDiYGyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lfWMi/jpvsTDXVIDSohF/cUVirz0gP+fBNH02/VOwyCWvjb2a8aEUAueNj0tWJ5E+rJCaIoYSJBkiFqvu6jw3aMBCkVj5uKhTPZhPsUcyauKhrG0qcDBSZdysdVusQ8Zg5Kekasq9WdtQVGyMb0XAD4ZAjtNz+WflRxLBz33mEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=quaxCCER; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JTMM87aW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="quaxCCER";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JTMM87aW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 747211382E09;
	Thu, 13 Mar 2025 13:06:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 13 Mar 2025 13:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741885602; x=1741972002; bh=Y0IUXdW+lJ
	UsOjeC+4Q9+OmybECWYPFVm7ZDdc7ZwyU=; b=quaxCCERNjCSlCCamPWZvIMQEc
	l6YWI6dGC3zIkU3j0RSoN3wd+YSWlRdM41Rso+lcjMngYBlM35NgodYICavOQT4J
	6sAIZV0v5+UxQ5IHRX1dFalF1D/nBlV7RDd6BbLVSaehAek6LXyASDKPRClP158w
	ZhlWwj44GEFlSEUa6iatRFTdNuBdwndpHrt9Oze6utyLHPzNAZXKBNygVkzsEM9E
	C+VFxiAWUXm4eRhreGpNGijaQipSbEJRFJlRtK9UW8wo/G2CX2BBLMmPERU0IVgH
	9EHe8O9pZaX1IFSEb0IDIY0OOzWJvV+RNMyGDI/4HVyEIVZQcbAVB8GZX6Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741885602; x=1741972002; bh=Y0IUXdW+lJUsOjeC+4Q9+OmybECWYPFVm7Z
	Ddc7ZwyU=; b=JTMM87aWYgWo3pLZ3844b9IOANO4JSgI/8OFOwkjI+cqCwAx4Gn
	KlrO5Q7y2RGjSYSacQDEBq/EAdUd6UX+/a8ygTreP8OdEwWR/eARYllw9ihHKgbv
	7P8P6gJonsu5P0JMvncVIaySeQyIcvK4O+1RLLLZwGup3TlEdQSMHvTz3lEkx/1/
	2V+I+hD3vM/+H8f1vczUP2MDkbS6sY8s7WKYRUupRUmjRwCqxi4sa3uWqoUD6CP4
	5lrLTjvqwX8dSj8oWQLrGo7QZcksJFkUzreVQOzvvZ4HtfiY/Bk8DbNVh4CM+APo
	/BNkpleQo9MdNkEsQxS95trq67KA4PQjtIA==
X-ME-Sender: <xms:ohDTZ6q2FlX7vSsvkm0B4s2CLTEd_a8zMw6MKH7m-ixeytmUv9of1A>
    <xme:ohDTZ4qedrs4zYVT3N5FS2qUTVBYVzdx7qdyE_FfvkNI58bdjk5Qfl3qS4ZgS0TeT
    D_Bf2YZvYThS7I4eg>
X-ME-Received: <xmr:ohDTZ_PUiS6QnVFabMAQJHHUL2cQPfBU0M1azMHdTQ2uFMt60s1XekFhb87QY7Fizc3D-nKxE4jUbCrTMHRpQIay6KTlOLKruaxHAnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ohDTZ55p6fQmHGWK_Ir-VcSZmQv_EDl5BRUWnCMBaZUhTvy2ZiYTLA>
    <xmx:ohDTZ56wMZrvi0nxhyD-w0SsJAMdgxcHnDvU4tCfxIvFVrmI9EuWFA>
    <xmx:ohDTZ5jDZKIsVjJXDNT8KKgxLm9LgsDen4Za3z7Tx0j0yzs2dXykkA>
    <xmx:ohDTZz5pXz9be7cKp1xO53FRFWGOHHPOctLkilEi4aCrGrVRYB3JXw>
    <xmx:ohDTZ2sap_hpfJRj-0SOBDEsD72X3735OI1MnltC00DQx2b94Sa33Bzm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 13:06:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 4/6] pack-objects: generate cruft packs at most one
 object over threshold
In-Reply-To: <CABPp-BFSXVkZb76va0CO_w3G+MtNuvC3jv6-9vo-oR3LHW4YNQ@mail.gmail.com>
	(Elijah Newren's message of "Thu, 13 Mar 2025 09:23:35 -0700")
References: <cover.1740680964.git.me@ttaylorr.com>
	<cover.1741648467.git.me@ttaylorr.com>
	<f2ca92245ada74825806b50f786aab312275fd85.1741648467.git.me@ttaylorr.com>
	<xmqqikof2pqp.fsf@gitster.g> <Z9Gmo2P3Fnt3JeOs@nand.local>
	<xmqqjz8uxfyq.fsf@gitster.g> <Z9HaYEyYgBYTiia3@nand.local>
	<CABPp-BH0rbieCV4Z11pHOX-mwrtEO-FPNdywV0P5HxXnusdRKQ@mail.gmail.com>
	<xmqq5xkex9md.fsf@gitster.g>
	<CABPp-BH35cn1nXSaF=U=dbSKUxTFL5uP+yUvhbXMi66tJMuhLQ@mail.gmail.com>
	<xmqqmsdpruqg.fsf@gitster.g>
	<CABPp-BFSXVkZb76va0CO_w3G+MtNuvC3jv6-9vo-oR3LHW4YNQ@mail.gmail.com>
Date: Thu, 13 Mar 2025 10:06:40 -0700
Message-ID: <xmqq7c4sq2qn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> Personally, I think I'd set the --combine-cruft-below-size to half of
> --max-pack-size, because that guarantees that any two existing cruft
> packs being considered for combining can be, and the resulting
> combined cruft pack if big enough can then be ignored in the future.

Yup, combine-below can be set to arbitrarily a small value, and ...

> In other words, this scheme would allow you to always make progress.

... I would even think that setting it to too high a value may be a
misconfiguration.  As you outlined above, a half of the max-size
would probably be the practical maximum for the combine-below value
to avoid the issue and to always make progress.

