Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A7EEA6
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430466; cv=none; b=rbTSdv3jwNapkaqZ0ZV/Y0XJJsVQcB1mgxhxzhV1nog7QZl7zuFenLMYlOikMB/noIzhOjibBh8Z2SaQwRGd/rTnkBNYWOiDy2J3hNgkJ6TSXhm3T68Ne8qWJaJC634R6/DfJOdIQx0bZ3latEyYPMP6ctDoQ+dbK7mdrpiGLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430466; c=relaxed/simple;
	bh=nseH4VbjK+xylV/E9TGdAB3r0Fbvk/jA8WaXJHBmcYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OpRxhAJMFgYilcZGswFcOVNL1DO4xcp1v/MMj+kUBnHFX9YreoYHaY8b/aJoWvz9wtCm1tsB3qJ/ZHZiAWBgRezH2dViiM9vmVPPzab/kt/RyPd0QHIH6fa2lSMxP1ex4lr+ftx9G8oxGRNuvHHOKOgFzaqyw9i+HC7eq2TTNTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SRIWBDE5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+EpIH6C; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SRIWBDE5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+EpIH6C"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 01D0EEC018D;
	Tue,  5 Aug 2025 17:47:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 05 Aug 2025 17:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754430462;
	 x=1754516862; bh=bxeZqWT/mx5NrsK4Rxd3m5gWzXD1EadswK7fMW2ANLc=; b=
	SRIWBDE58dzeIhNTqV33UvFQ9keJZ8PplCSFN/ZYHt4UiOmDyIE6EAzPMd26gBJ+
	C9eEBih5OpnZwOgGW6sXaxkEZ9QXsmpwPBVurGKsM6LGMYBtS3aOnYQ9erd2f4Lb
	GLukGHTBw7e/iQsMKXjM2vUN5TCZ7sjlB7aU56/EMcxQkkekQ9fLQSZwm1EcnkVM
	ag86ZZfK0YfS5TjzJrlopDmr8ygMxjMTvUY85RldqQFcrFcUpmuxDqR7UjFpOD/O
	H2Qwtc2TbZNTO6M3h32hRlk5qrUMtNcsJRqGLB84Anu+nr8gA+SBR8sfNwsNy9Rk
	Yi7SqKdiPYYhJ3gF7QX0VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754430462; x=
	1754516862; bh=bxeZqWT/mx5NrsK4Rxd3m5gWzXD1EadswK7fMW2ANLc=; b=W
	+EpIH6CBBM07Nzuyk9AeRO/95pWjqep/GGNxUZh3LpKnnPergZVVmXBO2mLPiZ/X
	hvcmjrQ/M+mrv7RVQ+ueYXgHuLPB1ePgO7HCpWPJrM0/mpXPYHf/89jaccT0jkk3
	TYbO5X/tXmfPqDb6Kqtoix6nzVtHa+Yfdn9MyQIkFlUrt1nKHUpilx7biYndmoEa
	1K0kavoyKTXhUawsYuuYSHVF13u2KCdptyi4zQIDYqkKXKwK0jYQePe58mUbKrPF
	TRPPMWcEUzM5Pqdt20c+96WD/v45ehMt4cRfBNLLrY2Ws8ylqphtWr/dK0Ar3X9I
	ZaIdUk1HIqQQl7nLesJMw==
X-ME-Sender: <xms:_nuSaGMi3G1qfUrv5eS8MDUt3b37Ti_0xLnlWAkOTBSRuidl4Gm7sw>
    <xme:_nuSaEpYXqQwNtnd9dyZz-gocR8VN8KNE4PaaoPPFWbyeyOXnMiOtewdwWTq6ufhX
    VsBlBTTnWvuOrc1fQ>
X-ME-Received: <xmr:_nuSaI6ZLrJBGFU_GcZC7ChOAKv9ThL-eksnDqQQ65yWwXog5rfFgdW9lE7G1ptdyCS467vDEbblDaXtPELzD_0LzOF_Jgvi1xlNYBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeivdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedt
    gfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehf
    rhgvvgdrfhhrpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehs
    iigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_nuSaCg5A2Y5fDW-TX7IVJCQS58c9-SU0glLt-nzAYrdxcbHQvnsww>
    <xmx:_nuSaO4YfqwfLm6dJ6vPR1w1t0zfFIXZLs0w3udPwwW-ha0xWVZSNg>
    <xmx:_nuSaHGMSevVlmSs51WFXwbK-RP0D-9tpzevDQhn_aaR03FYobU_OQ>
    <xmx:_nuSaAK923XINTFo4OyGKQDyRM0FGCuUmz4LXfZLHe2UGf6AIzVecQ>
    <xmx:_nuSaGL2JYEl0tr8_gipaPYoACMUDZQVoSuJRNpoB2c4JAHh_S7zjVYI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 17:47:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Karthik Nayak
 <karthik.188@gmail.com>,  Justin Tobler <jltobler@gmail.com>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Toon Claes
 <toon@iotcl.com>,  Jeff King
 <peff@peff.net>,  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v5 1/9] Documentation/git-reflog: convert to use
 synopsis type
In-Reply-To: <5910515.DvuYhMxLoT@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Tue, 05 Aug 2025 19:04:23 +0200")
References: <20250805-pks-reflog-append-v5-0-050997db09d5@pks.im>
	<20250805-pks-reflog-append-v5-1-050997db09d5@pks.im>
	<5910515.DvuYhMxLoT@cayenne>
Date: Tue, 05 Aug 2025 14:47:41 -0700
Message-ID: <xmqqqzxpxwxu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

> Be careful that with the doc lint series I'm proposing, this change will raise 
> a failure: one of the tests checks that switching the main synopsis to 
> [synopsis] is linked to switching the definitions lists to inline synopsis, 
> using `backticks`. This check may be too restrictive though.

This is what I've queued on top of your topic to prepare for today's
integration.

--- >8 ---
Subject: [PATCH] fixup! Documentation/git-reflog: convert to use synopsis type

---
 Documentation/git-reflog.adoc | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index 34232a539a..38af0c977a 100644
--- a/Documentation/git-reflog.adoc
+++ b/Documentation/git-reflog.adoc
@@ -88,10 +88,10 @@ used with `expire`.
 Options for `drop`
 ~~~~~~~~~~~~~~~~~~
 
---all::
+`--all`::
 	Drop the reflogs of all references from all worktrees.
 
---single-worktree::
+`--single-worktree`::
 	By default when `--all` is specified, reflogs from all working
 	trees are dropped. This option limits the processing to reflogs
 	from the current working tree only.
@@ -100,15 +100,15 @@ Options for `drop`
 Options for `expire`
 ~~~~~~~~~~~~~~~~~~~~
 
---all::
+`--all`::
 	Process the reflogs of all references.
 
---single-worktree::
+`--single-worktree`::
 	By default when `--all` is specified, reflogs from all working
 	trees are processed. This option limits the processing to reflogs
 	from the current working tree only.
 
---expire=<time>::
+`--expire=<time>`::
 	Prune entries older than the specified time. If this option is
 	not specified, the expiration time is taken from the
 	configuration setting `gc.reflogExpire`, which in turn
@@ -116,7 +116,7 @@ Options for `expire`
 	of their age; `--expire=never` turns off pruning of reachable
 	entries (but see `--expire-unreachable`).
 
---expire-unreachable=<time>::
+`--expire-unreachable=<time>`::
 	Prune entries older than `<time>` that are not reachable from
 	the current tip of the branch. If this option is not
 	specified, the expiration time is taken from the configuration
@@ -126,17 +126,17 @@ Options for `expire`
 	turns off early pruning of unreachable entries (but see
 	`--expire`).
 
---updateref::
+`--updateref`::
 	Update the reference to the value of the top reflog entry (i.e.
 	<ref>@\{0\}) if the previous top entry was pruned.  (This
 	option is ignored for symbolic references.)
 
---rewrite::
+`--rewrite`::
 	If a reflog entry's predecessor is pruned, adjust its "old"
 	SHA-1 to be equal to the "new" SHA-1 field of the entry that
 	now precedes it.
 
---stale-fix::
+`--stale-fix`::
 	Prune any reflog entries that point to "broken commits". A
 	broken commit is a commit that is not reachable from any of
 	the reference tips and that refers, directly or indirectly, to
@@ -147,12 +147,12 @@ has the same cost as 'git prune'.  It is primarily intended to fix
 corruption caused by garbage collecting using older versions of Git,
 which didn't protect objects referred to by reflogs.
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Do not actually prune any entries; just show what would have
 	been pruned.
 
---verbose::
+`--verbose`::
 	Print extra information on screen.
 
 
-- 
2.51.0-rc0-162-g220549999b

