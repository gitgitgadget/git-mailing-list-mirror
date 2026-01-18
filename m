Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3E2144C7
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768758641; cv=none; b=Z7xe5sTv/Jpok2CSnMpYUuwUpW5eAEyicctafupUF/LUqk/LYARYCzj5R0dMno9KKTSOxCBHRJgXofKB1DrfsYBzIwTP3XA8pgz5DrYaCSUc+OtD84AhnNQwp5y9qexkc2A9YDXmdm9fK4FSKHE5eYxJ6xC1tEsnYOMTFUJWXHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768758641; c=relaxed/simple;
	bh=p0xWsdVHWt63W68HTh/V4LPCnuqwxJUIQTOmBe+/sXo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=enO+nxJYJP8R3q0LN9FN60MvxaRiAYcRnroqTNuFoni5/TK73zmli+AV0y+BZFgBdoqetpxNGU52vdnZVreL0amdKNfr+YBrS+s9fKHd3rNDoLD1shYrT4niIlVIssAg/LYK/wHe62mRwxeJb0qYLQPddbPQNUM5gBNs/slYYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AT7QD13n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DA09vXrc; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AT7QD13n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DA09vXrc"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D69C1D0021A;
	Sun, 18 Jan 2026 12:50:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 18 Jan 2026 12:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768758638; x=1768845038; bh=IUwDZHwKDY
	MkO81Fvh5/prhM0AYgE36LIx8PMGNcj8c=; b=AT7QD13ntEusTs8bwSvfQ7fx+u
	/gObpVEe/AlNB+9m+W9q38dDVTSRN1cCpxWANPRJa15Kl+5CKt7kzqP1z7kLdFuG
	W8B8s5urBOPGEp0S3UHpLD5KPzr9sEHMjr0MU4sfMIhBeOXPYIkLig5YM60VGDRw
	i3w0sI27rVsQH1P9pKnxo9dEShiIz8Ts6qYfy4Wojx70mgC9lA2ucgeDMxQ6s7z0
	stAc74ZZROTamf2S8LRwkYNdRURRbFhBgGRN8/q40ySqGx8HeUuWABIle6AsFORR
	IxB7lDyzS4lrvaaO/XbeLO00y75Sxn38ICa7uLHjZ/XanFtyvP57v5zg3PHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768758638; x=1768845038; bh=IUwDZHwKDYMkO81Fvh5/prhM0AYgE36LIx8
	PMGNcj8c=; b=DA09vXrchvbajteHAawQ1a22thYcZ+kwcTJLSB3rzzrv5oNwkqX
	DR+7Z0Q/XjER831y3ihYHYfc45BtFsALg/5R7BufcmNZzCTkkhT3nRWQjr1o4kH/
	PQldlfHO2ygIz4g71oPU7kxCF6gx8FvMoHiRhdkimB/BWtlc34vXzNKmgtLxVw6T
	1D2Ju0c3ZwaJVKbvH1+2yMK1i9VCuwr8yhFUAlfjlvsjhszO9qWGJliyq7uWTzEM
	tw/oaZUriqsB7fBaLh7y49eUhYBTk8vStBwxShpR0pA5E8LDCGGYF+cos5b2DAjH
	1e25FNETqYJkjfpkVxsWxMLrvLCCsqiPstQ==
X-ME-Sender: <xms:bR1taUGJdbKIvr-TzVu4XYI2qAm1VeeI0UMfvBc9B4UzEHbcBvqi4Q>
    <xme:bR1taTtVss2hxkB__XqrkRg6ty55CducKyCJo7nJHQVJa3cscF1kjr2nEwwGVSy3i
    M6hqj-VSL26t-YLt6YWBivcR4KUazgmKk8VaeXNek2AX-JwTBSjtTA>
X-ME-Received: <xmr:bR1taaZt1QaaLaKZO7vbpUoIMk6i0VGfhaRaapYUs6cu-0vZbdQNXx1Hhfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeehfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteevteehgfevhfdthfduhfetgeefjeekhfelleetueevuedttddthfdvieej
    teelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehs
    ohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfh
    hrvggvrdhfrhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdp
    rhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomh
X-ME-Proxy: <xmx:bR1taT5z2BdPzlb8HrhpLksdBgB_uot4RgK5UjbgM1Qzty-6S5ragw>
    <xmx:bR1taS_QxDg-HKugnwYWKZfxaMBtEw0-NVgRFNgCetCExUKnC4g8KQ>
    <xmx:bR1tafYp1blC7U9ARU7PREBdHpcOHoTfHMEp72ItNpyQhg6KE25EEg>
    <xmx:bR1tab7EKyAhILFlHF6-KkFDd71Ld_eucWhhxD2etBmDLt2QQBgo4g>
    <xmx:bh1taYuGKwC0IV1du_mQYS2w8PnBcqj3pNBV2SDOByj0lm5RBG4oGEvz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Jan 2026 12:50:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,
  Git Mailing List <git@vger.kernel.org>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Sergey Organov <sorganov@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?=
 AVILA <jn.avila@free.fr>,  Martin von Zweigbergk <martinvonz@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v11 8/8] builtin/history: implement "reword" subcommand
References: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
	<20260113-b4-pks-history-builtin-v11-8-e74ebfa2652d@pks.im>
	<aWpnFqTmWB9XIWUW@szeder.dev>
	<CABPp-BHkNLdH4C7U4sFoVhrsSPH8KAaDtOdLEQGyajmXZz9hVg@mail.gmail.com>
Date: Sun, 18 Jan 2026 09:50:34 -0800
In-Reply-To: <CABPp-BHkNLdH4C7U4sFoVhrsSPH8KAaDtOdLEQGyajmXZz9hVg@mail.gmail.com>
	(Elijah Newren's message of "Sat, 17 Jan 2026 14:56:19 -0800")
Message-ID: <87ms2a3j4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> ... that they don't want to undo and lose.  It feels like a
> hard recovery story.  In contrast, we can consider the case of the
> default being to update all branches for a user who doesn't want it.
> If that user finds that other local branches were also rebased and
> they didn't want them to be, they just go reset that branch or
> branches from the reflog, which is pretty easy.

Very nicely put.  I originally thought that the "reflog is your
friend" argument would apply in both direction, but leaving the tips
of some branches behind while rewriting the tips of some other
branches, that can reach the tips of these left-bhind branches,
would mean we have no other commit to go back to.

Thanks.
