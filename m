Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B124F185923
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728424668; cv=none; b=ICEoqmK8ud6iji/qPqIIrYhGpa3hKoQ+KSHtvbwNr9b+jhrtZxbtdYIswAVpIDcC8pXgoJ+H8yikT81Hky5L9WxuDuVgUyGhl97LBik2AXzSeV5DcbNIjE0I40l8WmKD83xXQFWwjhCTbAJl/iNOVCUp44aLHUu60RpMonA1iSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728424668; c=relaxed/simple;
	bh=ePxIpvfBqtmuu66vEtn7fHHrt0ummLxjUfPddBJ9bQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dPJAGDn7Me3E3z/Ix3NupAP81lChmvtn2mfaEykBtz6pt7Mmk0UKktpNTwKxwR+YEGM00WdzcqVJxRqytP9Cxz2EyoF/HG3Y0NxHWcLJSxn9HSl+H/7UdzSL6G4FLW72mFODtJ6NMs3W5I02SOFmOrPHXXiUq0nsCnsfyoJlBD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JCQBhdNK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I8iM/9kI; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JCQBhdNK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I8iM/9kI"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B16A138077B;
	Tue,  8 Oct 2024 17:57:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 08 Oct 2024 17:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728424664; x=1728511064; bh=3ufFQQYDiS
	fYnd1F1/m/2cA4aul2u10W+q/B93cQxAE=; b=JCQBhdNKLYcoGPQEvVkvM9xmB1
	pnWXK0PKXANY+EPHkvkkjJ7WStUOCEcKjw0U4oJZzhkGOFAU8J8bNAF+I/iKADV3
	t4ue+u6Q25v+CMIwjP8Ghe+0knU85OKY0Lk23CH6Pvjyn/rGtkALDuUjo7Qm0GpM
	cKM92qrcQyy8xEUmMuY7h09Sot+Z0ClgykCm+8OiJKYsZ2ayz3jHhTGZ22noPDny
	fvUtPnb7grNQQgZcB6afd0I8Lyhfa+LHo2ASZgzqUq6NWVpNGt/DU3NxdnuhtQQ/
	mr+34vlYjnispzsZHqbvogKFSsv9OsGVzViiHAeNXntxfQrLsNwRTxZa6+oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728424664; x=1728511064; bh=3ufFQQYDiSfYnd1F1/m/2cA4aul2
	u10W+q/B93cQxAE=; b=I8iM/9kI0i0LUD1HYBQkPSNTDG3gNfnMwO4LRuih8Ok8
	B4eyppVQKL6rap46IaU/X+4JWcSwPCYCZe25Bdj86mo14PtA9gsthcbINTOQ1dfy
	S3ucJxdGBmSrwiaVQEnAQ0OZbEVOyS+6kvM31Lwitmgzh7rcVVifCTDZYI53G1ch
	LgdQhIoq7E9Rdm74BX8tOnxJvkQelIknq5+Mxi3lPtWkqFJETTwFcQ6E8qKxM9jP
	NWB5KZwYQlnWZ7XGD8yKaG9+7ggjH4iiNKMdeWEcO/ATvGy2AE6Vr5iijbhTQ+3x
	tuc30xwxlqvR9mU+ODFciZ45pS/Uq8FTEovgQYVxmQ==
X-ME-Sender: <xms:2KoFZ6r2P4frmxcUyOX78XStxie07o7qDkPzAU7h1Up-w-PGI4b6jw>
    <xme:2KoFZ4rehib6JzDOQQZXUZyteTfrUoP8yqSFsEMosDTP8sp_o8JNLhYn974g5PwRX
    _hbrcY2jhjl4Y7clA>
X-ME-Received: <xmr:2KoFZ_MU9V3PGvi8vTmC4nOYIrVxCBIY0EP3xWEWXJAyKDUxgbpeAtLxTq3ZoazEy1pM0yev4512EG7WYepIXrb9JrXNL-dijkINTts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettd
    dtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeeludenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrnhihrghnghdrth
    honhihsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehsohhktggvvhhitgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2KoFZ56pE4E1bUaxBFfGTdbjw-1iYCxy8L2Efqj8axywPwUKqQuTWg>
    <xmx:2KoFZ57wrj3BWbrDixlu65kqS5g9gkI-99KwWTP7tX7LkH1c4cB7OQ>
    <xmx:2KoFZ5gDOca62ktuPxWH02Ka7o3revGZg6rOPuzSl79hbDkkcpmzEA>
    <xmx:2KoFZz6pPjLGG_FZQrrRJ5nm08wLmdR0ig7qY_urcey5jZ12FQXCtg>
    <xmx:2KoFZ0Yf7V7GiZdz_L2EE_RYskSu7Ig-uUDDuyVOkXKyTpTzG4SjMdnD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 17:57:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  jonathantanmy@google.com,
  sokcevic@google.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH v2 0/3] repack: pack everything into promisor packfile
 in partial repos
In-Reply-To: <20241008081350.8950-1-hanyang.tony@bytedance.com> (Han Young's
	message of "Tue, 8 Oct 2024 16:13:47 +0800")
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
	<20241008081350.8950-1-hanyang.tony@bytedance.com>
Date: Tue, 08 Oct 2024 14:57:42 -0700
Message-ID: <xmqq4j5mz295.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Han Young <hanyang.tony@bytedance.com> writes:

> As suggested by Jonathan[1], there are number of ways to fix this issue.
> We have already explored some of them in this thread, and so far none of them
> is satisfiable. Calvin and I tried to address the problem from fetch-pack side
> and rev-list side. But the fix either consumes too much CPU power or results
> in inefficient bandwidth use.
>
> So let's attack the problem from repack side. The goal is to prevent repack
> from discarding local objects, previously it is done by carefully
> separating promisor objects and normal objects in rev-list.
> The implementation is flawed and no solution have been found so far.
> Instead, we can get ride of rev-list and just pack everything into promisor
> files. This way, no objects would be lost.
>
> By using 'repack everything', repacking requires less work and we are not
> using more bandwidth.

OK, perhaps.

> Packing local objects into promisor packfiles means that it is no longer
> possible to detect if an object is missing due to repository corruption
> or because we need to fetch it from a promisor remote.

Is it true that without doing this, we can tell between these two
cases, though?  More importantly, even if it is true, would there be
a practical difference?

In the sample scenario used in [1/3] where you created C2/T2/B2 on
top of C1/T1/B1 (which came from a promisor remote), somebody else
built C3/T3/B3 on top, and it came back from the promisor remote,
you could lose 3's objects and 1's objects and they can be refetched
but even if you lose 2's objects, since 3's objects are building on
top of them, you should be able to fetch them from the promisor
remote just like objects from 1 and 3, no?  So strictly speaking,
missing 2's objects may be "repository corruption" while missing 1's
and 3's objects may not be, would there be a practical use for that
information?

> Promisor objects packing does not benefiting from the history and
> path based delta calculation, and GC does not remove unreachable promisor
> objects. By packing locally created normal objects into promisor packfile,
> normal objects are converted into promisor objects. However, in partial cloned
> repos, the number of locally created objects are small compared to promisor
> objects. The impact should be negligible.

> [1] https://lore.kernel.org/git/20240813004508.2768102-1-jonathantanmy@google.com/
>
> *** Changes since v1 ***
> Added tradeoffs in cover letter.
> Fixed some partial clone test cases.
> Updated partial clone documentation.

These patches are based on the tip of master before 365529e1 (Merge
branch 'ps/leakfixes-part-7', 2024-10-02), which will give mildly
annoying conflicts when merged to 'seen'.

I've managed to apply and then merge, so unless review discussions
find needs for updates, there is no need for immediate reroll, but
if you end up having to update these patches, it is a good idea to
rebase the topic on top of v2.47.0 that was released early this
week, as we are now entering a new development cycle.

Thanks.


>
> Han Young (3):
>   repack: pack everything into packfile
>   t0410: adapt tests to repack changes
>   partial-clone: update doc
>
>  Documentation/technical/partial-clone.txt |  16 +-
>  builtin/repack.c                          | 257 ++++++++++++----------
>  t/t0410-partial-clone.sh                  |  68 +-----
>  t/t5616-partial-clone.sh                  |   9 +-
>  4 files changed, 157 insertions(+), 193 deletions(-)
