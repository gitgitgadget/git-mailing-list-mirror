Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4B7DA6A
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742767689; cv=none; b=nv3vOewzAU/YIHs2U8qkezeq25rjB++YCANVB/b94A2ASV+boXVbUSJAix/0k0Xq1WhMiqzFKLWbPElKzT3WCC/lEVxHop+MgraWjKGzcSTePUh7Od1oyWq5/NZaim2gVsR6kcM5ScVALnGrBWP+0WFs+veBZmdNJVQBdQ6Mkks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742767689; c=relaxed/simple;
	bh=ukVkK9fqSbFmo0R797Wkb29//qEfYxMc11MyV4Ifwys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ci3HNNAlBD91kVzOyattjoHgdBJ/MlttKzvR3e/bGsnOWVIuLKmzvG58KyA/X8foj3ca2WKa34vugB5DAtZbu+JlHPmtnQ473ho1N6lOYB1/AH7rDB9qZGG+pab2GkYtzRn7naPBejNm+lkpe/9yXQw/an15XkHmv3OZvEMBLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NaWLP7e/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gVvL6J9y; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NaWLP7e/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gVvL6J9y"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id C65C2114008C;
	Sun, 23 Mar 2025 18:08:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Sun, 23 Mar 2025 18:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742767685; x=1742854085; bh=LrNdWdQKki
	Ge2M7QNPEHYm8u/P17qwnNReIcZZT7PtQ=; b=NaWLP7e/DBpWMd8FLiNG/G3cZq
	o0jJ4AaxkEbPvQU64veTT0jit2BBv1u3edIwwF9870nVOUc2nCEylQLIUGxvgLBT
	B2P4wHK+6m2Y7bFMCxwRhYhpa4hTHCokLnO5AuRWrvxWlESF+UrKDtjI+umStp2D
	kM98EQgwAi3zvDbYUgCVMaLy9tRb9zEqTfv9GIk2AX+7/ENgYvCbtKlPjhEC1ryA
	9yuVf5S+Mf5nL4T0gy+rY//pcjTXbab/JD+BV+ivIRpClHrRjKBmljq1RYnYlHjK
	mQ5l2wXqaDtk6L79B4Z1QPc0yg3X8UfhyVhmiMWYuPRORfu7p6xwJABnHOPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742767685; x=1742854085; bh=LrNdWdQKkiGe2M7QNPEHYm8u/P17qwnNReI
	cZZT7PtQ=; b=gVvL6J9yQwUSJzn4NaWp0XysbdrJs/1gl2n6VhxCYwo502Ne3Nf
	ydNyp8fng6NAF2C+kXOrFwi6aX3efle8Ko7/RzLQRibjbimN4HRUpFOj8hxI8wck
	Jf6lXKKGG1aze/K1e4k+KuxPTGp+DQJYWJQglEbKOe7mN9T//x8lMj8GYh2Q2ehu
	UFWUQnyyvZuoHv2jV6JGtqPBgubN0HIhW9tNB0OWoxP5Q4s5YF0c+NP6QdNKNXyc
	du23eIWMhJ9OJRqhmg4BkPSz1aIe+JQ5NvzrpJqDGq7wdXLSwDVah0mMh0/Xv3EP
	Tsb/GjjvP1oRBjxicQJOFt+nlJBhY1ZCW5g==
X-ME-Sender: <xms:RYbgZ5jIv8FR62srDyELQbDePwSG1iPsWA2eby03ia7RjK71KBUYJA>
    <xme:RYbgZ-AU99AsYw4JYdtilCt1GWs9N_Du5o8b1fF8rIhdA9hviZOlFVtIi8U5PmHOL
    tQQcRJExL9IKmm13Q>
X-ME-Received: <xmr:RYbgZ5F71WtAxTBOjCjnS520VDASpzFucdxVM2i7r9e8TsKM1kF1GdvQ6IlOdeOGMfIDzvi1aLcFA-i305Y-6FQ2Pm9L3_HDepKekIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheektdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthgrrghhohhlse
    huthhurdhfihdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RYbgZ-ROeaMAW7xBYZ7H1vdrUjgrDgRjuYfGcImQ5Q-868AfsSoMoA>
    <xmx:RYbgZ2wz-0VEc6ja9Oj904AXHafHsdVGSk3lHr2D5AyRJZ6l71MW3A>
    <xmx:RYbgZ06JngzoIATAZR5tLMs1bU_nnenILJbQPInkRYknqHo62mdBSw>
    <xmx:RYbgZ7wbYnm_DlWhsJESKlexBXLpwW-kSqtnOSaATMIFbCnyZU8OAg>
    <xmx:RYbgZwvm_K846jkvSBBFD2S02ZY62MzW_FR5YMSfGB2RHU2wlIRaZYFl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 18:08:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2] bulk-checkin: fix sign compare warnings
In-Reply-To: <20250321221404.10727-1-taahol@utu.fi> (Tuomas Ahola's message of
	"Sat, 22 Mar 2025 00:14:04 +0200")
References: <CAOLa=ZRN5m0bccMdabUYwNJLg4HX6jcOe3PN-aBTHXBOuM71hw@mail.gmail.com>
	<20250321221404.10727-1-taahol@utu.fi>
Date: Sun, 23 Mar 2025 15:08:03 -0700
Message-ID: <xmqqo6xrqu2k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> In file bulk-checkin.c, three warnings are emitted by
> "-Wsign-compare", two of which are caused by trivial loop iterator
> type mismatches.  The third one is also an uncomplicated case for
> which a simple cast is a safe and sufficient action as the variable in
> question only holds positive values (from sizeof() expression).

The point of the sign-compare is that a positive value that is
assigned to a signed variable may wrap around to become negative,
causing a comparison with an unsigned type with the same size to
fail.

So "only holds positive" is not a good enough explanation for the
reason why this workaround for the "-Wsign-compare" false-positive [*]
does not make things too bad.  The key thing is that the value
assigned to this "ssize_t rsize" variable is a small non-negative
value that can fit both size_t and ssize_t.


[Footnote]

 * If we take -Wsign-compare too literally, it is warning every time
   a signed quantity and an unsigned quantity is being compared, so
   we could argue that there is no false-positive.  But that is an
   obviously pretty useless warning, when we can trivially tell that
   the value in a signed variable cannot have wrapped around.
