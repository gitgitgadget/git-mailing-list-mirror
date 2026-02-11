Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA24158535
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770830480; cv=none; b=PCut3f6fKp3Bf1wX/VcqbDfii9DPFN1xbU3DpcxW3Mzr+1SGucoVh+p6ef6smHjO7lKfTstHNa5SLbu0ftDKaY/EmQu3PC5IEEQj+Cxa6GMKlEEC3Qv7zSaPJmHIIlEx0F5j/GKxvmRZ5cOryzhsmaj1aGV9ya3W82ZQwTFDpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770830480; c=relaxed/simple;
	bh=M3HCUOY6C0HzWUiRY68TmRMW2gwtC289bIc5yDdbNCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GgXGs2srO/1Cvm0U3nqYdcUL+2tnqv5+pAG/QWEJZlshOyRbqKMr9mKNvSL21vO+7v9hKu3IrW4esKO1L5dDoONXO8vilBJu92XAILqdcHtJ6/LSPtgad99T+VepibGnksEz7VqwGFKz29/R+lXvK+gwhkxR9E9j5uThcZ/zBSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HGHXkWT1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L44xLOVM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HGHXkWT1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L44xLOVM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E4B41400103;
	Wed, 11 Feb 2026 12:21:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 11 Feb 2026 12:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770830479; x=1770916879; bh=H2nXhx1QUX
	XU83COZhYN5seWAyfl5YGAXd9eKyN2wHE=; b=HGHXkWT11ownDnXfZc0xzy/qw2
	a3/qVHRnML4DAu4fcUKzyPntlkOpd7F+kKHJr7fJTc7lCWZlMAlqkYzNslYJUlxb
	4X43PdI3ez2bU7rHChKshSUWB1NJ+jBLD6YQws//SnMwi2nHgsGdjsT3aBQjgtED
	8NFP1yhwNdWr4Yax/SR2PvNROvbnHeMdTr9BGsfEtTfyf5PSb4xFaxEU/6z+0vfi
	/oUFjb45tMcpmCAtAIrNKelqlWkylHpzsqFrekmUGgbKn4V7zOYyoMsy1+Wg1pB1
	OYg1absyb2adNFm7Sl2h1hEOZeAK36nseDuWrrYNTNnJS6KDvAyqfTsFoGVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770830479; x=1770916879; bh=H2nXhx1QUXXU83COZhYN5seWAyfl5YGAXd9
	eKyN2wHE=; b=L44xLOVM/Vv9kY8Silgq5kZa3j+5y2hi9cjflY49vw5LEDVwPIU
	ZH3x/flpHOk/QNkVaQDo8OUX/tgaxePKTawvdjM7QDRFCACLmvrM7qcvK6mG1uWo
	Z9d8Oe1f2njEfbRiOHNuBOouoqzdTBYjO8PodW7s8eXP6lFxRvrptuSPFZ5yx0Fh
	y0aINPSCM/i8f1CqyYd8FOvPWyw206n14H7TSxVFzFn/7KkZAvvyNtx59e8fJhjY
	IGC/zAWj8epeTGhFsZxeci8tcJsIsoNOOOlDxQRzKQ/SC6CX57NNAGJ7PBSqUan0
	Od/j1FEeeQCa6yDPS8jlyKBbbGf80Xtq5Eg==
X-ME-Sender: <xms:jrqMae8hXevULS_quGb1RsIl2j4xVcGB5-NaxXH4GWsf98hp93hzCg>
    <xme:jrqMaVvtptCKZDwxBF8CUA8s8er0vSiIfkDfwx4uWjZ8S8nnN_8e6j_KN0yTFbueN
    _EwhhwB6fJA1wzU_sxvpnOphgn6SkoRCMQCYulWKtSybqIsfe-33Us>
X-ME-Received: <xmr:jrqMaZDfIPgnN8qM3_YfYmzpHmIULwX3ItZsKiva1oX6lPdYjPO9cT3XHBP6ZkH49Hb0vvaCbZn_gg6ge3_Sqg2SQE9Lmb546A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhifrghnkhhosehgihhtlhgr
    sgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jrqMaVWeugAzu23MhuowrOSP9G33bVOf_HopODtoPdz_UzNPViQL7w>
    <xmx:jrqMafD9UlOCYszmslmf-EdPy4fCJ2STs5Lt2WmJzmOE3wtQKEJzvA>
    <xmx:jrqMaQ8NUpKE4PK5fsUyfT_0uZG0hP8EOi_P4R-fU3EsBgt-tmnk2g>
    <xmx:jrqMaeEcaphtzUdRMAH6xpzYUAgqrTs_8_9QMe1gGTpsrSi9CRvK3w>
    <xmx:j7qMacgZMbd4Xm_O6jjht0_GKxCCdY_T1QQ6O7PWicac2tg2cCjbXhQT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 12:21:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Lukas Wanko <lwanko@gitlab.com>
Subject: Re: [PATCH] builtin/pack-objects: don't fetch objects when merging
 packs
In-Reply-To: <20260211-pks-pack-objects-stdin-skip-backfill-fetch-v1-1-870cad56d8ae@pks.im>
	(Patrick Steinhardt's message of "Wed, 11 Feb 2026 13:44:59 +0100")
References: <20260211-pks-pack-objects-stdin-skip-backfill-fetch-v1-1-870cad56d8ae@pks.im>
Date: Wed, 11 Feb 2026 09:21:16 -0800
Message-ID: <xmqqseb7urg3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The "--stdin-packs" option can be used to merge objects from multiple
> packfiles given via stdin into a new packfile. One big upside of this
> option is that we don't have to perform a complete rev walk to enumerate
> objects. Instead, we can simply enumerate all objects that are part of
> the specified packfiles, which can be significantly faster in very large
> repositories.
>
> There is one downside though: when we don't perform a rev walk we also
> don't have a good way to learn about the respective object's names. As a
> consequence, we cannot use the name hashes as a heuristic to get better
> delta selection.
>
> We try to offset this downside though by performing a localized rev
> walk: we queue all objects that we're about to repack as interesting,
> and all objects from excluded packfiles as uninteresting. We then
> perform a best-effort rev walk that allows us to fill in object names.
>
> There is one gotcha here though: when "--exclude-promisor-objects" has
> not been given we will perform backfill fetches for any promised objects
> that are missing. This used to not be an issue though as this option was
> mutually exclusive with "--stdin-packs". But that has changed recently,
> and starting with dcc9c7ef47 (builtin/repack: handle promisor packs with
> geometric repacking, 2026-01-05) we will now repack promisor packs
> during geometric compaction. The consequence is that a geometric repack
> may now perform a bunch of backfill fetches.
>
> We of course cannot passe "--exclude-promisor-objects" to fix this
> issue -- after all, the whole intent is to repack objects part of a
> promisor pack. But arguably we don't have to: the rev walk is intended
> as best effort, and we already configure it to ignore missing links to
> other objects. So we can adapt the walk to unconditionally disable
> fetching any missing objects.

"passe" -> "pass".

Other than that, very nicely described, and the implementation is
surprisingly simple (thanks to a single global variable, and
asumption that makes it safe to use such a single global variable,
i.e., there is just one packing operation running at a time).

Will queue.  Thanks.
