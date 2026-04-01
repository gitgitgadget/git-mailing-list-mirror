Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3274418CB
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062190; cv=none; b=U8J1ecddvynGOS0T2mQGE0G4I2V4es79eObzHgqWNTvihN0SypdTRwINUKTqjduwETKiLBwZEsHEHxVeJRQy1Vkt0oyGjNSag2ugxuaFOChDSun1gAabXxQ8awNHbovlAwfIQmJTDs3kedkLJuBPjbD5uGIqgmA3Ro7O71MI6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062190; c=relaxed/simple;
	bh=Yhi6rsj9iauguVsyqxMwRTHQMk5etvMY/7g/ErVI5T8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dOoXjYpbQD8a/ACM7wmtKrkcrwHZTVRNdon1/i44Q5jgVI6ALGTtbTn0IkjWr+zSE/8o5X7tVeVfmnkQzYezKcObHF4OPRal4KdO7XO5wtBGTtysETlvRJC185eNov99CP2RdIIXMfg6bHwk//jg2ccroL0ltvFpXIip36K7jKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vsirMHgD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GlSShxL0; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vsirMHgD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GlSShxL0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 35C0B1D001B7;
	Wed,  1 Apr 2026 12:49:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 01 Apr 2026 12:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775062188; x=1775148588; bh=MMCJmyszWK
	7N6j9vRVtazVT0a120YZn7YqTatYR9C2A=; b=vsirMHgDB62MkGwifzC9qaJSMq
	e8KmL/SVCntxtR1JLwlBslXcnMEHDu6R0XHicVAtZm2QUA3bCkp6ufHddYodh9+z
	4MGatzlN0Ckli5hqAkBFYKsKP+EKoi9+6fUXnKlg6IquHAgKw0RO7m/eae6OpHWE
	auQbT06xaAtWK/iLB4PRg25F1GjPShFRr7dPfWcPzGmeM0w/EmQ5RzIx9rq2Pvwb
	1MDujTO/aNUz3naAoodPuFsN5yCpAh51gs6GF1VvUYd2HxxAma5IEc0H3l3xYdno
	xPMGbbARBOOGbgkUBO9QVV3PYmHogcjGBbTIZhgefboUP2qUzNPEn55RuhVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775062188; x=1775148588; bh=MMCJmyszWK7N6j9vRVtazVT0a120YZn7YqT
	atYR9C2A=; b=GlSShxL0tJHzlzNeL1Yim5mSOiSbISUi4wWz+806R8iIiZxkGZB
	cM+TlyFrZiGwb7zGDgY9NK9Ydn7ozV+RNpTfGxiCOUAraBQ0T0kfUbe0k1evpF+H
	RkWAOa4saD5PxHGA/DmIk+3AhWcDFgPLBwATPiXsGw9V5g7iLSiCaFjzLYY2npHC
	Uwc9lhCPBStESyuZcUxRXY7eN2J073+Xa5c0QWYk0AOy3YYpp0aaba0EBRtf/0se
	CkQOhty+5gudh2z2P2fSOJHn0jn8LZm9gInmNsB5W8FAmPyU4TYsLZ4KB86zXBGV
	0PfJIB2DFRYpaBAqsZNdFxdn76H7/y8LRRQ==
X-ME-Sender: <xms:q0zNaeaRILydYTT0qHUbVqzAyGV8sxa6JBL74ShdkFmPu8kDKrpAzw>
    <xme:q0zNaZnTbBONilzDhr7AqFgYGVBIBceIkPGOJRThjKXP2DXTWyV7whW3c84Tz7aa6
    RTBXzKzNRUCzC9GCIeCRgXj-DRc05Q12qGlUGwBN2IatMwiIikL4w>
X-ME-Received: <xmr:q0zNaUhQ-FPevQLaMD-B_3jLHGZWlEn0bFUTzDsmgw33358OC963t4aJtm0K0Njw-UlpY9ES2QMYwlDSOxVCXq_VzlNTNB-NSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggf
    efiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrsghlohho
    shgrsggrthgvrhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrd
    horhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegrhihurdgt
    hhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthh
    grshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrghnughrrghp
    rhgrthgrphefheduleesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdrug
    gvvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:q0zNabRks60NTHQ4I9ZJZ8SD6RaOht_3xgdJK6qodhVxa0hVTr0Fxg>
    <xmx:q0zNaVbcGQeYRbGTL4GGhAMBOZXih5slSUKPS3Yv8ejo7AFO7LmS9Q>
    <xmx:q0zNaYTnJOy0WJd6FTHUzrMQ_GPNBmxLQqcInoHCd8XgJ_V4a-zHYQ>
    <xmx:q0zNaU9GMmnfT2lx8QZljVj_5e6QVF8Cty3MQc2bONRDAT4CVHzZzQ>
    <xmx:rEzNaUYsv9x6Kmq4P6fSygkp01p-sm1ogBs0lsc80fc1OUERwdI5vpek>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 12:49:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo <pabloosabaterr@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  chandrapratap3519@gmail.com,
  szeder.dev@gmail.com,  git@vger.kernel.org
Subject: Re: [GSoC PATCH v6 0/3] graph: add --graph-lane-limit option
In-Reply-To: <CAN5EUNR_yfkv_hC4wg-nHNg=3FnkYdvFm6FcOUNG2A=MdGs7ZQ@mail.gmail.com>
	(Pablo's message of "Wed, 1 Apr 2026 16:42:26 +0200")
References: <20260325174401.217577-1-pabloosabaterr@gmail.com>
	<20260328001113.1275291-1-pabloosabaterr@gmail.com>
	<bdff0a5d-b738-4053-9b72-08eba88156de@kdbg.org>
	<CAN5EUNR_yfkv_hC4wg-nHNg=3FnkYdvFm6FcOUNG2A=MdGs7ZQ@mail.gmail.com>
Date: Wed, 01 Apr 2026 09:49:46 -0700
Message-ID: <xmqqikaawrpx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo <pabloosabaterr@gmail.com> writes:

> While working on this I spent most of the time with graph.c and
> I got to understand well how the rendering engine works. I think
> I have an idea about how to tackle the column rearrangement
> like gitk, which I believe is what you thought it was about at the
> start (and the
> TODO that's been on graph.c for 16 years c12172d2ea).
>
> FWIW, I'd like to send an RFC about the column rearrangement
> because it would be better overall, no information is lost, you can
> still limit the number of visible columns which would replace this
> in most cases (only scenario I can think of where you still
> want to keep the truncation would be if you want to keep the
> branches going straight vertically).
>
> I'd like to hold this series and send the RFC with the idea for the
> rearrangement. If it ends up not being viable I would come back
> here and add a 4th patch to remove the extra padding lines
> (merge and collapsing lines truncated) to make it more useful
> making the graph more compact vertically as well.

Oh, I may have found a volunteer to fix one of my pet peeves ;-)

Imagine a history with multiple root commits and you are drawing the
history near one of the roots.  Immediately fater pacing that root
commit, the graphing engine seems to say "ah, the next display row
immediately below this commit '*' is vacant because it does not have
any parent.  We can draw a commit right there" and draws a commit
that is unrelated to that root commit it just has drawn.

Which of course makes it impossible to tell that the commit on the
earlier row is a root, if we draw a commit immediately below it.
We'd want to leave that column/lane open for at least one row.

Instead of 

    * a child of the root commit below
    * one of the root commits
    * an unrelated commit X
    * the parent of X
    * the other root commit that is a grandparent of X

we could probably draw

    * a child of the root commit below
    * one of the root commits
      * an unrelated commit X
     /
    * the parent of X
    * the other root commit that is a grandparent of X

or you or somebody who stared at the graph engine much longer than I
have may have even better ideas to draw such a history.
