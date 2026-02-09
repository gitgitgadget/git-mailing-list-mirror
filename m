Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC0C36F425
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653597; cv=none; b=f7qIGSCIIAHNCwxwEu8WJSy0iLb0inWPogWVVBLsA7YO9/WJf4NUUlMW/YjJfjoAm2hu18X609A+MtvalCTeUdueLgxX2B6uXZf6Zjc2zzHUcgxQt3fbUuJQ2MpbnziQdpu+hB0AgPwDV2d+ITamfvUpD6IVqJMBmvrQTdBwJLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653597; c=relaxed/simple;
	bh=2CWpQKGFI32qBG0XW6gzOARHLT6JkIn2mwspvEOqD7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VNPYpQVdoLzB+y+gnlWcaTlcAivqJFlXXNxj1aZTR08lNNR10ohqC8+09yuTZ0sZB8Xw79B1c8F+nUjSxSgRFgdKm3VyXMukmIsTvBvmaVu6Ux4dRPAhsEQaaz7n7XSHQy2vlNCMsSlK36SMa3LO8fTnfFUHpas1VYEAzgVKDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iz7hLTvj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aFlq+8go; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iz7hLTvj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aFlq+8go"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 771597A012E;
	Mon,  9 Feb 2026 11:13:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 09 Feb 2026 11:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770653596; x=1770739996; bh=T/m2/dPIHg
	WobYiwbL5JSLVls6O6AvDYXwNeeSvc1Ko=; b=iz7hLTvj/6vjek3IMGbZ+CqIGd
	PDx+gj+RWUHoDuTXHdYAKkwDvW6K7j2w5Cuj3CpgevvUGUaTaFv6ih54ExNQL7o4
	mbB0ddl7eHpt6ELOG+T5fiwbz9KcM7OP+j0UQmjXe4SaDT/dnaJsX3GhGvZ+E5Nx
	SWzPUV9XGp2iWZpm0O1rTFaJE/quUgPSuQpoSBt92tGtmoweAd5Es8thZKEWLTC6
	N/ZOABTrzK2cZJoTjej6l2Wt5QCxSP5wUqtJhieFEUvmhwMSDSnWzuXtfV4vfVLK
	G8dBOZbRN00V2YPnWzWj1A4Cr6czKWA/IdL/tbU2eCjYkJoshd4A75cBCx9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770653596; x=1770739996; bh=T/m2/dPIHgWobYiwbL5JSLVls6O6AvDYXwN
	eeSvc1Ko=; b=aFlq+8golEKQqQb9My1j5r65q0stgZnmgXg24tbSt8zgQjhsLxl
	G8Sedv3gc9EyiuxdMX307CbjNzWpUDpppsQx73URxX55/xN9q4WluVwopw5ftnFy
	YEbVAL1BWBINMaaNQda8kkHqu9SHed1m/hX0WQyKsWve47YASzfXu7QYwsPQoKSP
	yujOMXTTpdkATwEehjm2/u5itSpi40Ln0I7cKefezBcJbRtEEcn0fFkg1CMhPUhR
	qjMifBo5/qCCt3jSjAZY9diwau66B9GXKtm1T4wE1neo7b7Ydszd67/rlhWUaL77
	oU5pawq0UGBpqIhGU9w9a9gMFvvCBf5riDg==
X-ME-Sender: <xms:nAeKaTpT92vdurGsRlly2ZT9LCX5YTvG_uesUcWD2nraAq3RRg0EMg>
    <xme:nAeKaUhyuU1z9VRKH7hLCfOEAhgcPoFt98IBUBxJAUupopUGw-kWLvb6xkPYnu9KR
    w7YIzw8Fnl5GbTOizas38ZaYkpRsqSmIE4e_muoQevMzXGbD0Cl6g>
X-ME-Received: <xmr:nAeKaYjrFCJ_oM93IlfORClXSwHlMJ2hywGwf04T2SUJcUbJvlDHSpLH1q6QpOw5VYJ7X3ey9h10SbQUYMHpoHi9Tia_QZ4WfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehshhhrvgihrghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nAeKaSijheWEr1Qdq2pFgvTUnhAyIFpT8LTW58lH4OQ89yff5pUMmw>
    <xmx:nAeKaQIlchi4J21cKYgYMLkIXA-2SAAvp46f8EbzHTLtG-NdDElBvg>
    <xmx:nAeKaZHnrdPl--tlK0wD1DakFXzgM71LUHgPnWUVMZUjm_9LLqdX2Q>
    <xmx:nAeKacQm_eyP6mdS0wJ_6k8NHtGfuJU3OXCWlfzWuXHkz9vLV9K5nw>
    <xmx:nAeKaVyHuLYw1Btouz_RCe0Wuw9yPdzGfI2PH-Es4AfV_lBi2XfjRRwj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 11:13:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
  git@vger.kernel.org,  phillip.wood123@gmail.com
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status
 through function parameters
In-Reply-To: <CAOLa=ZRaWA14sootWSPo5g4Yi4GBXf6HjdkdBY1Tt_+V0szCjg@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 9 Feb 2026 01:02:12 -0800")
References: <xmqq4inrahti.fsf@gitster.g>
	<20260208152811.73213-1-shreyanshpaliwalcmsmn@gmail.com>
	<CAOLa=ZRaWA14sootWSPo5g4Yi4GBXf6HjdkdBY1Tt_+V0szCjg@mail.gmail.com>
Date: Mon, 09 Feb 2026 08:13:14 -0800
Message-ID: <xmqq5x857v51.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> I would like to point out that we already have a function which provides
> a main worktree, see both `get_main_worktree()` & `is_main_worktree()`.
> In short, a worktree with id = NULL seems to be treated as the main
> worktree.
>
> The harder part would be correcting all code where `struct worktree *`
> is passed and has special meaning for NULL vs non-NULL. See
> `strbuf_worktree_gitdir()` which also distinguishes between `wt ==
> NULL`, `wt->id == NULL` and `wt->id != NULL`.
>
> So cleanup would require identifying all such spots and fixing them too.

Yup.  That is why I upfront said "if you are ambitious" ;-)

> This also is tricky. We currently already store all worktrees in the
> repository in `struct strmap worktree_ref_stores`. Here, for the main
> worktree we use '\' (see `get_worktree_ref_store()`). So perhaps we
> should formalize using `\` for the main worktree everywhere.

Is this a joke, is my terminal broken, or is my MUA hallucinating?
I see a couple of backslashes in the above, and in the code I have
a forward slash instead.

But you are right, ref-store-map does use a slash to indicate the
primary one, while worktree itself uses a NULL, which is somewhat
understandable (NULL would not be a convenient hashmap key).  And I
do not think I see any downsides (other than "This used to take NULL
as the sign of primari-ness but now we need to use a '/' instead"
fixes we need everywhere) to use "/" on the wt->id side offhand.

Thanks.
