Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0892DE70D
	for <git@vger.kernel.org>; Tue, 12 May 2026 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568580; cv=none; b=C7n2f3vjp3OuJybJCUuOUIrfVNazz62dToWYOw0J1MPyBAdSzAi9MTHHmJpQC5X9VBFEgayiYfpEeHCZKJ/zR/aCRbyVBblJz4S7k+wq2ys/IlEutJpX09KUysVrDqJTpaAoY+0rPz+/0WOn2ARDHkk+RYm1yEMF8M8fblVQRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568580; c=relaxed/simple;
	bh=66oWGNsL1/fGAM3xhY/58JkiYs7GYngDr4xVNuq5fo0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ocEqsGoSPdsCofUqtLU87pTvqXZSVG+Id05TzPNc5drs2KLyExS0Kv83F+h3RdydVhMh12+btybTw+ase+1yditDlHQAh0MFPhBHSiwDWfAfBtlwfomHUClgJkFAfCxk6/yEPh4LFNVlR06RmrfE2jQLm38RQhzg/9XCR4WZKk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UZHZ6fQ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h13ME2PJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UZHZ6fQ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h13ME2PJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 074F2140018F;
	Tue, 12 May 2026 02:49:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 12 May 2026 02:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778568571; x=1778654971; bh=DetoKRuYTr
	1UbW89cg+zFX2yDVpFXi63BSy5Yrsjydg=; b=UZHZ6fQ+DN5bsGSGBoAvqte2ge
	YVYtTboq+altMG7glT1ldTOdNWujvKinq21gdGsCbcAg3OYk7G6OdfY/AZsBPAYE
	FrgB+/63A0nyXyj1eH0CiV58ZuIzr1krhrQtXpbOqzlWcY18sJInPDG64ssY5QW+
	I3wNGRzBrh30zxwFA/LT6wosEYp+6Z7ttsfNZoL/FOqC/pJQXYYYpthtxaRpskUl
	9c52zDORJ+5JlLV3dryFKZFlPU3Y4siYJvLhRHp2hBxFHt8/+dgubcV/EuQJXq2U
	QFd4Im5HHQNI6zdm6oi562ee+Ei0A/N/aWYP5NReaf5sKlOZJV39vvyDQr9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778568571; x=1778654971; bh=DetoKRuYTr1UbW89cg+zFX2yDVpFXi63BSy
	5Yrsjydg=; b=h13ME2PJuKlm1kYneJsEIcTZ2xTtFJbTuexYNdhCuXMXM9UbjHi
	dW4jEP3i5wLeh/Lat4XhFPEqQLL0RX9jwiA0vCjLaXfhnxIbXeuTQxvsk31gFYTE
	PwWHcZp/1npQtnK/+Bu0Pl2bNq6ql0POgqJUKotQweLmqIywzHdoWaJtK2weJrEi
	8eA43gMmFvOFQYfWKj/SlY7CVVw+dAWHUiOMbrUbyQyAbLZNK0Uj9iE+vvAFFsma
	FWT6MW+fVDc4Ok0MqEEIkMteMOvcF3n4BuAjHJZZqOCkBojUm3e9qM5DxQJ06Ni+
	kQ3w4eDFtYj6R2gd0q+rR8SlkCaoksJdyyQ==
X-ME-Sender: <xms:ec0Caq2b6SR0RGisOVI97MgyypqM4wkU2ckDzJGVMeY-yJWIwc1frA>
    <xme:ec0CapqdnJpqJynnmnh21AmyaKMYwRVMnuFx4aJRWY-hb6VdxTnj_PMnF3MjBUqxi
    8RXL1AoLTWcRSCIQomRbVfKZVMGCi2dbERClSQpYohUXfV9QFkr>
X-ME-Received: <xmr:ec0CanWv5dN8goPmK9c7qWKJD9x__iqF1hblUxAXI4KNZo2BjKoahfaDhTtxW4EUyggmlFoPv8b_ow3-wky-hEJSI6xN6PKdbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheplhhorhgvnhiiohdrph
    gvghhorhgrrhhivddttddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    gtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhh
    ihhnvggtohdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ec0CairUv_r-Im_cZfjTM6CMbMuCgTrNnF96QQqeLcBqxeX5sbR5Jw>
    <xmx:ec0CauDpIHvXFn2RLlEfWZhxFbZzdwl_FuEqHfncdzbmhKACvBlR4w>
    <xmx:ec0CauhLpbI-0z5FuZ8wFVcRrj5vSy7rnNxwO7BBu2GdueI72XXn6w>
    <xmx:ec0CasYqNFBqccZAt_FJMF-Q4rn6q2UbMpDlSyEO7VaQ0L6JFhsHYQ>
    <xmx:e80CahvwZkKyBAg1l8exjCwoSAkYRId8xokoSX0YyVP03MSy1qk14brH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 02:49:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>
Cc: Taylor Blau <me@ttaylorr.com>,
    LorenzoPegorari <lorenzo.pegorari2002@gmail.com>,
  Derrick Stolee <stolee@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,
  Tian Yuchen <cat@malon.dev>,
  Eric Sunshine <sunshine@sunshineco.com>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC PATCH v6 0/6] preserve promisor files content after repack
In-Reply-To: <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Sat, 18 Apr 2026 16:16:46 +0200")
References: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
	<cover.1776384902.git.lorenzo.pegorari2002@gmail.com>
Date: Tue, 12 May 2026 15:49:28 +0900
Message-ID: <xmqqse7xm8av.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> The goal of this patch is to solve the NEEDSWORK comment added by
> 5374a290 (fetch-pack: write fetched refs to .promisor, 14/10/2019). This
> is done by adding a helper function that takes the content of all
> .promisor files in the `repository`, and copies it inside the first
> .promisor file created by the repack.
>
> Also, I added a comment explaining what is the purpose of the content of
> the .promisor files, since this wasn't explained anywhere (I found
> information regarding this only in the message of the previously cited
> commit).
>
> Finally, I added some tests to "t7700-repack.sh" and
> "t7703-repack-geometric.sh" that check if the content of .promisor files
> are correctly copied into the .promisor files created by a repack.
>
> V6 DIFF:
>  * changed the name of the helper function to
>    `write_promisor_file_after_repack`.
>  * modified the helper function to create the ".promisor" file, so that
>    is not required anymore.
>  * modified the logic of the helper function (as suggested by Tian
>    Yuchen)
>  * modified the helper function to check for possible errors, and to
>    check if the lines of the ".promisor" files are correctly formed.
>  * fixed memory leak.
>  * improved comments.
>
> LorenzoPegorari (6):
>   pack-write: add explanation to promisor file content
>   repack-promisor add helper to fill promisor file after repack
>   repack-promisor: preserve content of promisor files after repack
>   t7700: test for promisor file content after repack
>   t7703: test for promisor file content after geometric repack
>   repack-promisor: add missing headers
>
>  Documentation/git-repack.adoc |   4 +-
>  pack-write.c                  |   9 ++
>  repack-promisor.c             | 194 ++++++++++++++++++++++++++++++----
>  t/t7700-repack.sh             |  61 +++++++++++
>  t/t7703-repack-geometric.sh   |  33 ++++++
>  5 files changed, 280 insertions(+), 21 deletions(-)


Lorenzo, it seems that not many people are reviewing this final
round, and then I noticed that the list of CC addresses lacks a big
name in the promisor remote topic, so I added Christian to the To:
line of this message.  Christian, you have no obligation to review
these patches if they do not interest you, but just in case you
weren't aware of this effort, I thought it might interest you; I am
sure we all would benefit from your expertise.

Thanks.
