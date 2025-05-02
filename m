Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC51C8632
	for <git@vger.kernel.org>; Fri,  2 May 2025 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746221076; cv=none; b=OqaejSC55GNcpzS+CGaTi7VIp0Ax/ZvWMMoPzsyOF11mOZdaj15P4/0e73EjznSZYm1iCeF/CwBCgU16DYjqvPU+jFD4W37/ETaMn1fDCfpjGU7Lie751nz/+XudQaQUe+RlHlwfZo+zMKgrGj7bMwOMqBZl5n5l+7C/Cnao/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746221076; c=relaxed/simple;
	bh=md81FaSO6GRf0UYUg8pzCFZC3ok+EOvcAnOhKzGYzSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SIJ6UaDa0ui+twlmxhU10fvtPoZ3vx5tBVFsgNiZUDj6oIvQJrZOUiE+J6LyjsGMZDT+STB9EwBu2xP83jmunH4wW2EK27U2oMJeNKDk6whN/hRdADEILGntzAqQ5ka2bJIsnx3kcyg+XlR4Ly67MeyctuxIc7zgihgF/tyx9+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R38aapK5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HDuX3hom; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R38aapK5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HDuX3hom"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FB561380FC1;
	Fri,  2 May 2025 17:24:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 02 May 2025 17:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746221073; x=1746307473; bh=ZyyyVIvjWu
	7cqiUi7TyW3W3jYJMsUwpAsN9FSGiN4ZM=; b=R38aapK5HDNap00ILuJM+5ehA8
	xthy2L580ShApwWP4S2Nq+i5FNrsw6fqh6noonZjxNxpsMiI+I8Sfs9dzm0LaeBd
	x/6d0cLn3LAgbReSAlwXMUtQAzhFACFu+NJUtQa9FIXlYoAISdf9TH+ygLhaHgCq
	9oTnsrBoXAn4w8p2XGRbBpYf5PGgjHZ95kfcTn73M3ofaKciOt/fnZiSxNk2+9JO
	nf16AdWkrDxJSQChPYOCB6i4C2Xa73Gu/+JAs0tMDW+EbU9+crddmzvzvY4jMtlx
	zYv0n2MUegjlR+DCUhA2klU7KesmrAC4eeKb4yJ5VyWWe/l40n5Tc5xGfjgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746221073; x=1746307473; bh=ZyyyVIvjWu7cqiUi7TyW3W3jYJMsUwpAsN9
	FSGiN4ZM=; b=HDuX3hom2MdtSrEko/UrrNccfW6yJdbEr4/FY66tCjd6Ih462eA
	CL4yg3ykyn4LhF4IqEHuDFbdrmaUWKvwrXBzZYEXEPQC+UE/DLH1XqsbiABiUwuZ
	OTIn4Wgjl2EapeaURHw+6RSMajbpqYLDbmmXp41NskCunc2FmYq8ajxiTLI17BaP
	bLsqExAf5Zkyva5cKa6dU6rY0eDkCujW4VzTgU/+AVRw8ixGPMUHiKYNzMvco1/E
	KkOMIMwsdbCwRQIVPyjDQ8sW9bMD48nM6f1TxaN3fzQeeo5xo7PFCHw6rivsfYCy
	k/Z3jKZDkdXadXVijltGBvRD/cPS6TMR0pQ==
X-ME-Sender: <xms:EDgVaPX4rywgu37r-uIvCkdVDsNIq1qXNOze3YHBk0vF2BICrLF8XA>
    <xme:EDgVaHk6a2D8dVfQPso9dfCeX4sdcmSmMZ8m9A0_c6jA6t4cnVLwnqgnfY4O8PWkq
    YIFr5y6Z_hsrb62mg>
X-ME-Received: <xmr:EDgVaLbzHDFjBvIUgmhPqGnofCdQpmeqWVQruQfA3_Kls5vSdImKzx0JrfwqTt1iCZKtrpxGeP0AHCcBupGXqOlZjWjh2pwqHd5N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehjoh
    hhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgr
    nhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hm
X-ME-Proxy: <xmx:EDgVaKW09LBRUAzAapatmTsXJQOj1YIxO0dyVfEDwLzq3pRB29XzNQ>
    <xmx:EDgVaJns3AzQrTkBy-EyghIGT1WKjMqrrKNdndCw18p80bTyAF_YUA>
    <xmx:EDgVaHfPlEK0da3W8_fnlWhjcsyEE40Xn3c-dFiz2N1-piwq7162KQ>
    <xmx:EDgVaDHREvJa4Yf7vK9JyhaAj2CN0SdKEce_58cMvhv_M1lYGsRFfg>
    <xmx:ETgVaKWIXGgJ8ripZx0boPo_BMrTiv7OaF2KwdWU0z6zWBp8QNbduNzS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 17:24:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  johannes.schindelin@gmx.de,  johncai86@gmail.com,
  jonathantanmy@google.com,  karthik.188@gmail.com,
  kristofferhaugsbakk@fastmail.com,  me@ttaylorr.com,  newren@gmail.com,
  peff@peff.net,  ps@pks.im,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 00/13] PATH WALK II: Add --path-walk option to 'git
 pack-objects'
In-Reply-To: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Mon, 24 Mar 2025 15:22:36
	+0000")
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
	<pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
Date: Fri, 02 May 2025 14:24:30 -0700
Message-ID: <xmqqbjsau2nl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series does the following:
>
>  1. Add a new '--path-walk' option to 'git pack-objects' that uses the
>     path-walk API instead of the revision API to collect objects for delta
>     compression.
>
>  2. Add a new '--path-walk' option to 'git repack' to pass this option along
>     to 'git pack-objects'.
>
>  3. Add a new 'pack.usePathWalk' config option to opt into this option
>     implicitly, such as in 'git push'.
>
>  4. Optimize the '--path-walk' option using threading so it better competes
>     with the existing multi-threaded delta compression mechanism.
>
>  5. Update the path-walk API with a new 'edge_aggressive' option that pairs
>     close to the --edge-aggressive option in the revision API. This is
>     useful when creating thin packs inside shallow clones.
>
> This feature works by using the path-walk API to emit groups of objects that
> appear at the same path. These groups are tracked so they can be tested for
> delta compression with each other, and then after those groups are tested a
> second pass using the name-hash attempts to find better (or first time)
> deltas across path boundaries. This second pass is much faster than a fresh
> pass since the existing deltas are used as a limit for the size of
> potentially new deltas, short-circuiting the checks when the delta size
> exceeds the current-best.
> ...
> This feature was shipped with similar features in microsoft/git as of
> v2.47.0.vfs.0.3 [4]. This was used in CI machines for an internal monorepo
> that had significant repository growth due to constructing a batch of
> beachball [5] CHANGELOG.[md|json] files and pushing them to a release
> branch. These pushes were frequently 70-200 MB due to poor delta
> compression. Using the 'pack.usePathWalk=true' config, these pushes dropped
> in size by 100x while improving performance. Since these CI machines were
> working with a shallow clone, the 'edge_aggressive' changes were required to
> enable the path-walk option.
>
> [4] https://github.com/microsoft/git/releases/tag/v2.47.0.vfs.0.3
>
> [5] https://github.com/microsoft/beachball
>
>
> Updates in v2
> =============
>
>  * Re-added a dropped comment when moving code in patch 1.
>  * Updated documentation to include interaction with --use-bitmap-index.
>  * An UNUSED parameter is now used, reducing the use of global variables
>    slightly.

The iteration saw no comments from anybody, so I (naturally) forgot
about it for quite a long time.  Let me mark it for 'next'.

Thanks.
