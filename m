Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D8F1494A8
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336228; cv=none; b=XZcpHeQtCekYNUs/5nUyIJwVP71D1ImtJEH0zdRqzmyLhJdflc1YLi34WYqpszXJni0fQxQ2IITn1vkrDlo9XGG2mvi2LZaz1unTTfMafcqLgkmwbc3p41Nr9xq09OJsv9K1NOXE+J+ISSrAJqEM9pbytiX+bAljOw0xExyKszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336228; c=relaxed/simple;
	bh=vhHjKqQ9Dey+2N/uzC2hl24TdjLTBAMvQqe/rT8dvs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CEdrh0d7QUXvN4mtz/kTnVv9rf6/DOTQ47ATxASYhbcdcARbOn2j5U2++5w/mBebg4g5uAuwZ3vnq87DBdjiJphilXKqBhP/uLOsNOKqzqXe5uS6tOR3N8J91nS6Px5XRZsmPoutei8LJ6bnOD7jicwjzLNjfZuEj1PDujAkMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W5z/Dcue; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PIZozH71; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W5z/Dcue";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PIZozH71"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2E471140247;
	Tue, 22 Apr 2025 11:37:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 22 Apr 2025 11:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745336224; x=1745422624; bh=Kb7+zfommL
	sifzh4HuSAAgHoGfFJH3v2CAb8mdEwgKw=; b=W5z/DcueLHRIlOmASS1snv0BWu
	GFiPKgzvJ70bAEzjICfQlW/4yH5yAjiJlAwxVQaRSsOzNp55UuOm5cIuyCXZHwDS
	YIMghWOedXwdhu4ooUZahFebgV89OJPjkfAdqxJOdc6LN9esq7fFeV+CnegokW7Q
	2uwmIsOmjasknYhDsvD/Zk58KEgYss5nXt/sA+9iy+R4vldLByiBOESHgKpImuV5
	SzHzBomDOXxX2W91Y+gPGkRWZ2bF0nOiKGS00HESz/fzWt0H9emjUiJPIe0iaSKx
	Q+vGtqLgRMCbaZk220OcmnZX9/m4ww+Hm3vTDxwKF3REG2nYybiblRnkpLaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745336224; x=1745422624; bh=Kb7+zfommLsifzh4HuSAAgHoGfFJH3v2CAb
	8mdEwgKw=; b=PIZozH71V6GVPp6BjAkGnH/R23hH3Hea3ZPsiAXOf1HUzwBPaIt
	TkJiga9XUkqRQP3dE1LOVTcUhPI1Y1Xpo9qOydZSPxMNKYThMJDyMGKlt6v4IbmZ
	BrCwEqJtPkjNj0cpyDz8BLn2BKcWGee78K7vulpzBr6cmD6wyRSHLhyPb/VpWJwt
	BtyCaRqWwCv2zoAAPbC1L6t8NLCsjOqjkqhibsbjZkq7PSRmM2DHARM0hFjhhZYk
	eIm+HLEeT1/yb96HGVBqq63Z18Oy/orF+rbZF3JO0zSDY2nvoaICZtBtXlQgJlXV
	2gYdco5rkEzN2oyWCm7ilnSZ1d/ORqdvSNA==
X-ME-Sender: <xms:oLcHaH8CwOZA44y1_F-VlLAzqNT4phZ-42VHx6zdSuyeI4JpVd0p8A>
    <xme:oLcHaDtGCXnKomR8nuXlj576ZBkrbBS1oYIT9WZtsfrMI4cRi_t31eJBE9UcKcqMH
    HGK30pRSMH0Fn-25A>
X-ME-Received: <xmr:oLcHaFBB0L2xNbrhVT9hl6meNB7g5gR7tLd8SUxoE73Oc7gm2qCt-jOP_jrtNtnwvPF8YyaRqX91npAsNFgo_c9N4pUSkbeGj_NO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeguddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oLcHaDcb_cYhvmKkYDfALG3UwBoCVuhlQv8TxqAM9Hr_WP-dc5lrHA>
    <xmx:oLcHaMPELyWkW1d72AgSFIW03kJlwqKOdz4DbXtQ9Qroc0WISWukvQ>
    <xmx:oLcHaFmVyL5LkhDijCMacDyY8G2sXk4zoxN0DwxgiwMRArznnhiD5w>
    <xmx:oLcHaGseP8BTvZhNSnf_unnfvkl7ZrpzwrjJ0xC7xmmZz7POQGjEYA>
    <xmx:oLcHaPQJDAetnLWOb0jz3AAAy1hIq8hSzDvF_wvqNbTgZ3fekm7vrht6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 11:37:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] perf: do allow `GIT_PERF_*` to be overridden again
In-Reply-To: <20250422104125.GA1460472@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 22 Apr 2025 06:41:25 -0400")
References: <pull.1900.git.1743764167548.gitgitgadget@gmail.com>
	<20250419035407.GA93039@coredump.intra.peff.net>
	<xmqqfri28rlp.fsf@gitster.g>
	<20250422104125.GA1460472@coredump.intra.peff.net>
Date: Tue, 22 Apr 2025 08:37:02 -0700
Message-ID: <xmqqzfg8438h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The original patch in this thread did something like:
>
>   git_perf_settings=$(...pull GIT_PERF_* from env...)
>    . ../test-lib.sh
>   eval "$git_perf_settings"
>
> That is, we stash away the environment, then load test-lib.sh, which
> overwrites the environment, and then we restore (some of) the original
> values.
>
> In that merge, the test-lib.sh inclusion is moved (and in fact is now
> accompanied by an explicit inclusion of GIT-BUILD-OPTIONS), and we now
> have:
>
>    . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
>    . "$GIT_SOURCE_DIR"/t/test-lib.sh
>    git_perf_settings=$(...)
>    eval "$git_perf_settings"
>
> Which of course does nothing. We need to set $git_perf_settings before
> those other source lines (and the eval must remain after them).

Right.  Thanks.

