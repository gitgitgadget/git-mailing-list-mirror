Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF1226E702
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223897; cv=none; b=DZvteOYk7jDMYkagtmrLsAT2iQLrUqelsV7khXtY6ZtTlJ3bPbLvP8pZxuAUXIAax0zYJz78pNC/yTL0KBsPh7bIkENqSVTOlnTiCnIBlmpLeWScDs2k65XVEHtlEosk3AbBieHE4EngIdxm5/BHxiMWxACfgeqqvAwITdAcxmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223897; c=relaxed/simple;
	bh=zCJSLoH5idl2AoSodKWTrqLb3lwintZ1f5WQ03BvTeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OGVikowXxpnCQLpJcShlUA5SFASt7mGXLTIxwHEMOOU01Or9hWJKMzFtskHZhOBPiji75jF42iXEXn7ewcUQE1QU75PNrskaTABqvXMRpjlyPFrCJGO5RFJD3azjWq0TV/rbGLY0pnjVk/l2PpzHoUBwkFJWN2gkClwgodFCRDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aTblfr1P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ezg+7RIN; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aTblfr1P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ezg+7RIN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A98321400098;
	Tue, 26 Aug 2025 11:58:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 26 Aug 2025 11:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756223894;
	 x=1756310294; bh=286lsenD+DgI6jq8IviJ14KQiiAgQc5Ponf7FEh5Evc=; b=
	aTblfr1PGr2YxmPBi0BhCdO+u4o5yDzgdjZihuyO7cMeFQcNGToQH4Kq9OmCZaUe
	BbJw1L8ypHOf6MZ661gqKfuCaiejf5j9n5wg4aze78lXEn+eREpRCXKww2u+QlOR
	yT7DEsMJ4w67ZCs0XJtMzeFBcyKbwsXClCaxsXg2KYcEfdp0PEZ3O97G1msg4WJY
	H+JJltNGyP4DRHxpiLr2X5jf98GXjyqAWhxok0PkAwMsPZ0SKhoZyuHW9ZMt0W+R
	uEXdaCmdcNjp9b4fkIyDR09s7TXAPPe2gQMog/uGCThcj62zle82MBdsdqAmkinP
	DrjL79deAuKCgsFtox+hRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756223894; x=
	1756310294; bh=286lsenD+DgI6jq8IviJ14KQiiAgQc5Ponf7FEh5Evc=; b=E
	zg+7RINmRUO9Gg08iGlyDLJrpX3+jCPdaMJU6KbCjiXPzAbgfWH94aFWUDSKEzXM
	pRWxW1U37GcFHRngnPgE2D3yq6PsqbmsmJJDCSuJqy3jJA8zzloWHRCQmW8NSb1z
	MALgxcP47Wq9neFHDPLVqJx8o0HNyyYLoM1FpufEdorDGFHPDNsfUw2V9EDDAQxB
	JK62FGd6TDkV+zBVYdiPZmHOOgCkods34KiS0uxJO5edgA5+I9tvbIBCkFwsRpct
	i1lWskcq5Qz68cRqRH/QQ+VSViOF5tVhMgEWWth9QeD/j0l8sWfhFb959PdZ0MJF
	IJcda0cQ66zEWJErzHZKg==
X-ME-Sender: <xms:ltmtaMyvcsdAhUW-xS31faqAZXhBYMv9BAF8JuLZIRulC4Ng8LKj2w>
    <xme:ltmtaHhvTbVcAnWvKGznDimTWqFEKy2BMkM429pWjGusvHtqysmGl3uzqWSGsFCao
    gCDkkfExYaQgzSSSw>
X-ME-Received: <xmr:ltmtaJONPsc8aXpDc3OeiAlXjlOUE5Ow4yy-p0E1R02hlIsK8VJIDKVNv1HewyODd__m6EgD-ZI1sVi5N8jwTILiA-XWSwF-2_Jeh-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedugedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirg
    hnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdr
    shgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehjohhhnhgtrghikeeise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:ltmtaKfhwiUIJSG3AGwWXI8oEx9Hj2OELCvmSWpW4iLth1PxsD9MQA>
    <xmx:ltmtaDxdyKC45S5fxlKIKQEUDUkFR5YkJcjthm4ks4bDhg5V2DlwYA>
    <xmx:ltmtaP0t31aFQTo5Ivd1iF7RCnL2gjK3Ybxh-tVvQiPUXv-x6QEPHA>
    <xmx:ltmtaKdidIwRC2CRxTUwMYyHoX9C8vAkWRMcB8qeUuG-0juCZsSGIg>
    <xmx:ltmtaI3aGjADkoe9oL1vAsnwoJfL2pJNi8mEOI16C_Sw8QUYbFvv4qcF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 11:58:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  christian.couder@gmail.com,
  johannes.schindelin@gmx.de,  johncai86@gmail.com,
  jonathantanmy@google.com,  karthik.188@gmail.com,
  kristofferhaugsbakk@fastmail.com,  me@ttaylorr.com,  peff@peff.net,
  ps@pks.im,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/2] [2.51.0 Bug] Missing singleton objects in 'git
 repack -adf --path-walk'
In-Reply-To: <CABPp-BHFxxGrqKc0m==TjQNjDGdO=H5Rf6EFsf2nfE1=TuraOQ@mail.gmail.com>
	(Elijah Newren's message of "Tue, 26 Aug 2025 08:03:56 -0700")
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
	<pull.1956.v2.git.1756126197.gitgitgadget@gmail.com>
	<CABPp-BHFxxGrqKc0m==TjQNjDGdO=H5Rf6EFsf2nfE1=TuraOQ@mail.gmail.com>
Date: Tue, 26 Aug 2025 08:58:12 -0700
Message-ID: <xmqqh5xukrcb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Mon, Aug 25, 2025 at 5:50 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> Updates in v2
>> =============
>>
>> Thank you for the quick and careful review of these patches.
>>
>>  * The test and bug fix are now in the same patch.
>>  * Several commit message typos/grammar edits.
>
> Thanks, this round addresses all of my feedback and looks good to me.

Let's mark it for 'next', then.

Thanks, both.

