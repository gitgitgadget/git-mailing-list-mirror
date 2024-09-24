Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642BD1B85DB
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 05:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155990; cv=none; b=Wbi6bottsHcWrgooWRrWnE4TejWkesrQKmVlWF3++il0SiEA2a3GTncP5JGhmsMxHsB8Z6lJdadRLk2HGTo7OczZA8XMmVYfCewRXqtnJtm0RQtXoIm9d0KlzCGigyD1mJ4N5HQhAAVT1HH0D9j1Zm4oaa9riQv7EB/ajq5hMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155990; c=relaxed/simple;
	bh=SCv29y2vVxqvo4BaeF+60aN03ML7ymG3/hQXXryV7ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMV9Xoe0feZhRpBkd5EINgWa0/1ypx0Ti+zf+bCM6JDOllVAUnOx6fXfRHbaB1Erk/YQsHxIrq11Ts2ytRCXug994oD//YEX36YW03ct2K8kZl2H5ezAIqxDH/DjUT3vBw2wPmePVfYuNhJHzqdq/I4r1kHT5nzemihxYydUquc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pq8CmJpB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=prSpsvgh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pq8CmJpB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="prSpsvgh"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5368A114033E;
	Tue, 24 Sep 2024 01:33:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 24 Sep 2024 01:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727155986; x=1727242386; bh=JnRBcQ8Gh5
	GN8EABbFxdPnG4JIYnaPdPWBNyeauAf/Y=; b=Pq8CmJpB/xnZYvujfTpstp2DYu
	YP6ugdOQ/JEv/+ndth1wKLfV4Z0hgtYVrr8+5EAH7Q+X6iBY6JHhMAu/Bfq4Dfwk
	HUiNyF8nRtpacLE5+yEiKbS4x5ZJrtXdASXu0JCGGly8YHpgk1j/j1la2+MACg/p
	ZazVakZXIiem5EPdnfDgGcWUgfcL+oIvbsp/7tSl5vPJGnFmBd7y0/vol2cjuhwm
	8MH0mf+moRqL9cld71Bahjd0iinTvpPn50DYrkl09eR8ZxHsFR3ys13hXiKojAEW
	lS+4U4isMoegMt+wRlpVNggDD65EY/RX53Bdb5/z6dD2HeBGFDuOJmG40E/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727155986; x=1727242386; bh=JnRBcQ8Gh5GN8EABbFxdPnG4JIYn
	aPdPWBNyeauAf/Y=; b=prSpsvghCIrVikqxdIfKIjTuM8T0+3VQQbwv4AKXsbdT
	7m6qF6u/h+Jy3QVv1jDULyVh695kyJAWHMVSCwfepEas/oZz1OGwQhwCmb96Bytn
	zOtZsxcxtJV4+fCZJ+2oN5F7eh7r5pVwigPZF2BBE3/OT6vLjnrsKNpjI3OFTqan
	9oG971Dty56WM2e9T5riUg7q7yu1M7lL9fRIJdmTgSuKyiuyMZUWIu+AzzMQqakT
	BQPgxvTBxgYXcYgdFZJ0eupI1y7V2BmxIf7dt72w3+KXlXPK8bcGMbnNGDhOMUR2
	JOy9R8PlM9bjYWCIQFZFJbDQd3wW8wudB6eS2eL1rw==
X-ME-Sender: <xms:EU_yZuzfCoTlce0IVNTekIsew_lzis2kWweY0-lE0kJVmcibUBYROw>
    <xme:EU_yZqR7VVtNvyaKObtDi0wQ7_ZRh_JvHzjS1KK1aaViu7Z7E5_tLWWZO1rLoc4pl
    BHgEZuECAQerJgmng>
X-ME-Received: <xmr:EU_yZgVVC9u_6m9-H6dPuq1psAjLJaScjVH1edlVJf-ELyOJJDIw58vbv0EGSi7Wk0TC7unTYOVyu1zc5lX2mBCqMFjZ9N_QbEyuzhSlJVu91w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:EU_yZkgdtW0IkUKkZM0PGrAwKivYVF5gFhfzdgiaC1fY6rkHVTG92Q>
    <xmx:EU_yZgDsDxnj3Tp6d8aWDSw6VnotqBbvVKqwNE4DRdYwwHCC3va5Vw>
    <xmx:EU_yZlIYtgpSkuIXQfWAp9X81BoFUVPWiJKJ68PFcXYPQA9ch_4Jlg>
    <xmx:EU_yZnCYlyNXfja5kBhWBaUttAQwMz7rGj_9LUPUOSA6fSh5yrIJGA>
    <xmx:Ek_yZv6LzEilM67RPIjyOhmN2anH653h5Y0aTFWHJKLvakANVQrs7CTI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 01:33:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a3ea00b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 05:32:30 +0000 (UTC)
Date: Tue, 24 Sep 2024 07:32:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/3] reftable: graceful concurrent writes
Message-ID: <cover.1727155858.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726578382.git.ps@pks.im>

Hi,

this is the fourth version of my patch series that implements for
graceful concurrent writes with the reftable backend.

There's only a single change, namely a fix to the type used by the newly
introduced `flags` field.

Thanks!

Patrick

Patrick Steinhardt (3):
  refs/reftable: introduce "reftable.lockTimeout"
  reftable/stack: allow locking of outdated stacks
  refs/reftable: reload locked stack when preparing transaction

 Documentation/config/reftable.txt |  8 ++++
 refs/reftable-backend.c           | 13 +++++-
 reftable/reftable-stack.h         | 13 +++++-
 reftable/reftable-writer.h        | 11 +++++
 reftable/stack.c                  | 38 ++++++++++++------
 t/t0610-reftable-basics.sh        | 58 ++++++++++++++++++++++++++
 t/unit-tests/t-reftable-stack.c   | 67 ++++++++++++++++++++++++++++++-
 7 files changed, 189 insertions(+), 19 deletions(-)

Range-diff against v3:
1:  77cffd3b1eb = 1:  77cffd3b1eb refs/reftable: introduce "reftable.lockTimeout"
2:  6130565498e ! 2:  81a836062e9 reftable/stack: allow locking of outdated stacks
    @@ reftable/reftable-stack.h: uint64_t reftable_stack_next_update_index(struct reft
      int reftable_stack_new_addition(struct reftable_addition **dest,
     -				struct reftable_stack *st);
     +				struct reftable_stack *st,
    -+				int flags);
    ++				unsigned int flags);
      
      /* Adds a reftable to transaction. */
      int reftable_addition_add(struct reftable_addition *add,
    @@ reftable/stack.c: struct reftable_addition {
      static int reftable_stack_init_addition(struct reftable_addition *add,
     -					struct reftable_stack *st)
     +					struct reftable_stack *st,
    -+					int flags)
    ++					unsigned int flags)
      {
      	struct strbuf lock_file_name = STRBUF_INIT;
      	int err;
    @@ reftable/stack.c: int reftable_addition_commit(struct reftable_addition *add)
      int reftable_stack_new_addition(struct reftable_addition **dest,
     -				struct reftable_stack *st)
     +				struct reftable_stack *st,
    -+				int flags)
    ++				unsigned int flags)
      {
      	int err = 0;
      	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
3:  25d4e513a36 = 3:  9ce2d18dff2 refs/reftable: reload locked stack when preparing transaction
-- 
2.46.0.551.gc5ee8f2d1c.dirty

