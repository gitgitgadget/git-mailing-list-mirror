Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B114F9D6
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080457; cv=none; b=il/ESklbJMHybMeWIoIfEUpxhar7vayQ+Vfa6eqQUA6HMeinqxldpEfx6VqMp8faYhf8usT3z2Q5s3Abj89GiDYFr9Ww2LF3H4N37DKre2DucV9vboBr80fwi/E3YKatqeiFKYDsIKv/tGTrFSOCkTn+KEKnZ+MZ1MTsycpvA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080457; c=relaxed/simple;
	bh=gUX09qwat1WxD/zCtNQn2seZ2TlqE8RLQWAhAJA/l5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GmVZMNdxfFtWOOLiMcGf2fnb+z47BYlz9qVREDCD53C+mKKLgTjQoXpXlfTY1aMjoJxjRKrMEwtSmLw6PfRj/Lq3+QPpuCqRq2Kos0Xlz8mjMF8eqajohNEPf8uI5tEs5F/LMvxikSJlQSO4L1Z/GmCE87xlTMcZQrI9OKSeNvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NzZuyelu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HnuAReKb; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NzZuyelu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HnuAReKb"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E68614003A4;
	Wed,  9 Jul 2025 13:00:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 09 Jul 2025 13:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752080454; x=1752166854; bh=fZGUzUyj2p
	0j/4lEJw6aFO6W9ndJIvj48xrgEfbCDzk=; b=NzZuyelu2N/cW5QDLgJvOyG9sv
	/MIvoU8BIOF7z6Bt2KCluX3nmXqFJf4GfZr4mobBgyFi75TYQ5lK8N2tFrizRUNO
	9MshF6VbW3GwgGbW5I8GpIt5TStS0LNOcr3aCBDpZ+/ri+bViIvWdrk1EZm4toh/
	BvHbBfwS+wVpenrqncqlpUUVU1EZwI9s5H4tlXCWwrD5dw9rEqX9Bd/VtwSS8QnR
	YCMTZ+ExD0qOrzXHgAYWbDR6UTvo2Pej6U1OVAokjTKgZU+2ZMlKscF4iJeUSeUJ
	NyhpBLQ1/vK2SWwvRapyJKBmPVkelOrQ1aE3xtt2iNZ8KDArYISUaGBsIsAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752080454; x=1752166854; bh=fZGUzUyj2p0j/4lEJw6aFO6W9ndJIvj48xr
	gEfbCDzk=; b=HnuAReKbLcoXZtciQuDCQHPfHaN53PNlpH9Kg8xT1pjJISj/Z0h
	LMtDl9u56iEr8O0upkm5uNMh8mjRQW5/ppRqXm12V5I7zMwqhwJboMTIMLehjR0N
	Jm/Zan3p323679neLb0HyPwihRzONFnPmkiod0QMpgsA6u+YvB0nynzRKYtvebm7
	/1cvUbmmHna07gLPGEJjfBNMdSTFzStLByIgPSnu3N6coRHrbZXbJhH0wxWfY/qh
	eKwHGbI9HibH+D+pPp1xVtPZmOXd34tgNC033HQaGWNsIIQAV8dGwWkeTnzHgHd8
	SXkGkIxgkVRd6yiAd2XExG2uCebWH46yYsQ==
X-ME-Sender: <xms:RaBuaPKJX5sYhb6-1v49qPsKGaJ5YfRwQKGaMqeNEU4ZNaIZhNzK5g>
    <xme:RaBuaAHmQZg3uSlndLjcBxlYWFPL5q7nSPUzYsKz43m1rdh3bARCwin92WG1H4b2q
    Ncn9fqbYywc7eKMag>
X-ME-Received: <xmr:RaBuaDXyiGTgrgMBCpRPR1FcWymXEv_IAQdbM1qR1vex6OZXGY9FyO0zrE3EzxbH7fqGsOHMb_TpEJxKGjJYs235zyCmDEaWSGksQt0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghvrghrrg
    gssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:RaBuaAxNBT8PKEV2sHnOj34vqL5tqdylB02wyR5n-ehkMNrRlnYBdg>
    <xmx:RaBuaASUQuiaIb9mg1sDXyRzirOt7tPPgWgUPUJ_bh5Xf4FE7Tn3Yg>
    <xmx:RaBuaEjuxyM-Vg34tCUNeu827V5F00ao7vnF8XyFf7i01lUSVLzhKQ>
    <xmx:RaBuaPkESSkYo9bybOLxoDV43x6wFBlih3QRW_klM0Gtv54zwTiTaA>
    <xmx:RqBuaMa9XqnYPS9jGjN9ginq3ATtSspHrFh7P3H-1taUfObpRwNhF2Ja>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 13:00:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>,  Derrick Stolee <stolee@gmail.com>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC v2 0/5] Introduce git-last-modified(1) command
In-Reply-To: <87y0sxpdi4.fsf@iotcl.com> (Toon Claes's message of "Wed, 09 Jul
	2025 17:53:07 +0200")
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
	<20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
	<f0c508cc-5c6b-4c4b-a3f3-0cdd8d1071e5@app.fastmail.com>
	<xmqq5xgbk4d2.fsf@gitster.g>
	<d93c9199-80b1-4834-bfbb-8263a80d90d5@app.fastmail.com>
	<8734berbmj.fsf@iotcl.com> <87y0sxpdi4.fsf@iotcl.com>
Date: Wed, 09 Jul 2025 10:00:52 -0700
Message-ID: <xmqqy0sxb8or.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> After some more testing and tinkering with the code, I've decided to
> keep the behavior for several reasons:
>
> 1. While behavior differs from git-ls-tree(1) (see above), current
>    behavior is identical to git-diff-tree(1):
>
>    $ git diff-tree HEAD~1000 HEAD -- refs.c refs.h Documentation/git-last-modified.adoc Documentation/git-config.adoc
>    :040000 040000 810861a07e1360d3e3fa00db3c0d01e0604ff27a 1b01b770c15e7ae586452bb3587c3ce7c01abd91 M	Documentation
>    :100644 100644 55d2e0b2cb9e959443e98eb329fdf97eff9073a9 dce5c49ca2ba65fd6a2974e38f67134215bee369 M	refs.c
>    :100644 100644 d278775e086bfa7990999c226ad1db2f488e890d 46a6008e07f2624239139cd8b2ff712545f07d3f M	refs.h
>
>    Both git-diff-tree(1) and git-last-modified(1) are marked as plumbing
>    commands, git-ls-tree(1) isn't. So I think that okay.

Good.

We may want to "fix" this "inconsistency" someday, and I think it is
a bug that ls-tree is not marked as plumbing.  But this is a topic
about last-modified, so it is fine.

Thanks.
