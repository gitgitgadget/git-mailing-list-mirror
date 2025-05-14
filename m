Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE6149C4D
	for <git@vger.kernel.org>; Wed, 14 May 2025 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747233543; cv=none; b=KFfrTC4k09ZME8PdZDayZNCf0Gq/oUz503XBKeS1GRtUIwrLcSZoOfx/fHBr9Ra+tf7yDfKEQI6XxsMVn1MT3U6MxYc0I9xDtoD0rFjVrNldTQqrkSkZiC+pz+7UbIWcz/pdW0srIy0KlDDdwiGvcEtnudJY26Aicz9ISzdMy6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747233543; c=relaxed/simple;
	bh=OzF82fnni7ZhvPEQSLe006mVk4YYd96+Bfnxhq8s6sI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MoQ5SQyGA413zHzX/5OTBB6a96UOuXJe19j4oOQ+zUiJmsZZaimtnMVz0Hs7lSal+Bf8Sz/eJP0WMvOiwPUdA6h0tm0wrixYXY8Hss4kHvs21/WCYzKIcepDHdBSyhtrofD+8qJQNKxzq98O1un8TCbX7ui9A+cNDvHweOXMdMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U7ft3Eg7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b7ikb2DB; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U7ft3Eg7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b7ikb2DB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C222913801F3;
	Wed, 14 May 2025 10:39:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 14 May 2025 10:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747233540; x=1747319940; bh=SPrY4jtuy+
	S5IB1turxjchItdaDKIpwcQsrtNNAROPU=; b=U7ft3Eg79kOG0jHTTaLYxYApw1
	6fJX/stiNd71f/BvEHjU6SigsKSJ2s5o0DVlQMAvVQ1NQwuptoiqhwwvUjVyU34E
	6UlCeqvK9RW+jg+2UD1Ij4grsCJ6E+Yp6WAHuZddxma5aX8FAoWaDFzYO+ZYAZVd
	Dy1XoVNvCtg4dRTO8Dw0C2I/2Pz+DWDubqmdRW0iztYZg/92L3HZZt/yiVFwtukq
	bOfvChDxtUZQbOcF2q6oAd8CPmtOauZxDm+d8WmIm+LJycR4vMh9Ce2BLbcfihRU
	IHQzDVK0ohL5Mda/gcYzMdyGm2BeNn2hcs4oDe7/cbmrIkGXPR5hm8/n8j/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747233540; x=1747319940; bh=SPrY4jtuy+S5IB1turxjchItdaDKIpwcQsr
	tNNAROPU=; b=b7ikb2DBcKXCkBIN9iAi9iyTDXqBAflF9KgOdG6+sadVnO5rU73
	AptJ+qz/i23a8EiAvua/VoOclhCiuRMoWMc4nMgQAhAZ5lVPVdZJYdXoTTIqt3FF
	aSeGl3w3+BKoWXaibf/2kI50J9n0ZXdAfXDPHQDNdNoFe4QaKhvTDwrorKX7C19z
	bZcoUbBPLEhH9zh+Pl9n6y3a/qbNvPb8T7XlYTpRDU4V/HPYyvPx+Bk7RpO1itgL
	HiGF+yJHszrcY6+lp2CAg4nS8eBO5bQuSoPGi5x4FgI/IgiNA/UqgumTsKxK+Op9
	AnNzbx+7ntMi+3f+F+L6pM+ablrtHx47JIA==
X-ME-Sender: <xms:A6skaHc7vNkntf5UvROsGjUddVQMyW0SRECdhdC_5lHOAyEgfv7jwg>
    <xme:A6skaNNXPB5nLvpC-vtGOUpP8um4L1h1y7yiJM6OOfVvVe3XO1_vFvvZFDdZBZmFh
    JQsk81-NiE8lNFUUw>
X-ME-Received: <xmr:A6skaAhPff4mUUokx_aMFU3L-Se0e9T-yZ9IQaNE3_CL4AhJMY4xhPxCwH9LemGjSKLjhtlMv7F9EGPiEn8RyGOKhHP7adFARSgRM4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrthhinh
    hvohhniiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepnhhitghosegtrhihphhtohhnvggtthhorhdrtg
    homhdprhgtphhtthhopehrvghmohessghuvghniihlihdruggvvhdprhgtphhtthhopeht
    hihtshhosehmihhtrdgvughupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehstghothhtsehgihhtsghuthhlvghrrdgtohhmpdhrtghpthhtohepphhhihhlih
    hpmhgvthiighgvrhessghluhgvfihinhdrtghh
X-ME-Proxy: <xmx:A6skaI9CnwCdkJbFvlbU5_j1XSOJ3PJTxQ24PCmIdhLeD8jM39jegg>
    <xmx:A6skaDuVs_Prd8Yi2z6_ZJ5GNnJwKRQVCAxp8jbqRWkh__seWF1f-Q>
    <xmx:A6skaHEo1Fh8qvilFx-Zn1smcC6OYvl_ZOezGKQKaXOz4_6YSNdckQ>
    <xmx:A6skaKNPdCcvP2rGDtGlSDtiwkef_F6DtUIEl_oZvAwCloGfg14QXg>
    <xmx:BKskaASXV_-yiB85L4ODQzatdk9vzLA6EzRBPB_dpcRlvbgX69HfNNUG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 10:38:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Nico Williams
 <nico@cryptonector.com>,  Remo Senekowitsch <remo@buenzli.dev>,  "Theodore
 Ts'o" <tytso@mit.edu>,  Git Mailing List <git@vger.kernel.org>,  Edwin
 Kempin <ekempin@google.com>,  Scott Chacon <scott@gitbutler.com>,
  "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
In-Reply-To: <CAESOdVD-8j9k2Dq9WgiR9WWO09mpfR9Xxe3pMUWg-KoTfELG8w@mail.gmail.com>
	(Martin von Zweigbergk's message of "Mon, 12 May 2025 10:19:16 -0700")
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
	<xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby>
	<20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
	<20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
	<CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
	<D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
	<CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
	<aAgWytQNqtLzg2TU@ubby>
	<CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
	<CALnO6CD8JTnNGfuCtb1QKFhx+Vv1txUZ+wCL1nZCDGAvHx6A6g@mail.gmail.com>
	<CAESOdVCKTnUbVuXq-=F3df4i2T-GcDpJMENr8wwm-ZXR95+59w@mail.gmail.com>
	<xmqqtt5pu5g8.fsf@gitster.g>
	<CAESOdVD-8j9k2Dq9WgiR9WWO09mpfR9Xxe3pMUWg-KoTfELG8w@mail.gmail.com>
Date: Wed, 14 May 2025 07:38:58 -0700
Message-ID: <xmqqjz6jb6kd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin von Zweigbergk <martinvonz@google.com> writes:

> Sorry, what I meant that those two things (limiting it to 0 or 1
> predecessor and transferring predecessors to the remote) would be
> needed if you want to be able to use the predecessor pointers to infer
> a "change ID" that allows you to do things like `jj describe qx -m
> 'new
> description'; jj new qx`.

If we limit the data model so that it cannot represent one commit
becoming split into two (or vice versa), and instead one old commit
always corresponds to one new commit, our design of convenience
operations may become a lot easier and simpler. No question about
that. I am not sure that is not like a tail wagging a dog, though.
If most use cases are one-to-one without split/merge, then you can
still perform operations that require one-to-one correspondence in
most cases where "predecessor pointer" and "change ID" are moral
equivalents, no?

In any case, that wasn't what I primarily was interested to talk
about.

It sounds like the "change ID" being discussed is a simple and
useful thing that can and should be a commit trailer that is carried
forward automatically across "git commit --amend", "git rebase", and
"git cherry-pick", i.e. those commands that duplicate a new copy, a
refinement, of an existing commit object, without any additional
support from Git proper.  More importantly, unlike the "predecessor"
thing, which may be helped if Git knew that it can optionally affect
reachability, it does not look like it needs any meaning that needs
structural support from Git internals.

So I do appreciate that the wider Git ecosystem like Gerrit and JJ
are talking to adopt "Change ID" with the same syntax and semantics
(if they all can agree, that is), but I do not think it needs to
affect Git at the object level.  From what I have heard so far, it
certainly does not fit in the commit and tag object headers, but
more like the usual trailer thing.
