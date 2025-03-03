Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF0213E67
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018626; cv=none; b=M/9NVCpqly25+ihx39Avs4/FDOHZiFbj4O4N4bNY3mja7T5gbgJQ9TNwCOu6SUSWyPwlICP8/rCkFoYUSWrzyPSdxC5+RlquZBfKIusqlpNu4oTOmEJMSOaRpNsn1SVtu6Nzi8XO4NQZ740GkmBXxGc74NpgUnhAk5Xd5sJIEVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018626; c=relaxed/simple;
	bh=9yCeNQuNAq2b6YGUUouvgXUC4ri+UcdmTiqxIc5UgEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sCZf2F2ElvTUZOmsVSJMk6PjAhuLjsld+PrVT/XiiK5m6viwa9MlUlEHves/sF8OhbwLz5mneEXPd13mtOhEGiJTwIQUx3kMBM+Xe2dmZAyDuvEVQD1fHOzmsPLkj1Rb8bNANXGiJ4GczRhEdUZn2ZEaIcOsFXy6mjB5dTPuhEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=alwkkZHk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+bV7iuf; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="alwkkZHk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+bV7iuf"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A54925401C7;
	Mon,  3 Mar 2025 11:17:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 03 Mar 2025 11:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741018623; x=1741105023; bh=0ZIxzbjW6A
	ry59vOZi56nKjvRfcHazG/2zW5TGspjaU=; b=alwkkZHkOpMH00FEuqiFIQ0IUG
	N5JVc+8lBa1xYjRcvQr6qQQ05fahYO4OCDFTGk5up2U48qBK5a2NnEVkU8yWmKYy
	oGVJyUosIV0aQ8hHd0pTSD1ti8Dmke5RAXTMVHUkvBONJRAHxFZ4C3PBnEWmPPwf
	QnznftK1LcZrhR7JYR/GpVlorEhNbaya1B6ctDMfsvzEdaBgY+wMcZe4cY1DlgQ5
	1gOZ+Qrb4z//L83TmNnu2Q0kE19aXjZ7aMjlnqdD/NujKfQpTcm3VAjd/eqR+d1X
	MuXjjjTUs155kdtxWtvyEarCN0ZTXHlIPMN4h+U6vUlZNVlnC5MMF4JG244Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741018623; x=1741105023; bh=0ZIxzbjW6Ary59vOZi56nKjvRfcHazG/2zW
	5TGspjaU=; b=W+bV7iuf5sA6Y75gJ5aU6nBoIQ1LuRNG709QD/4+8zcu+U/bSv9
	Zsu0LWQL0L0q2CFb6bDwXDNzWHFp3IrO3ORyD3fvcAXo/DHEJmNSvYgG9eti+4D5
	YX9oWxjeHF82W18DQ80ydmfgYmAuECrtbGIAVPyw1xYivmNs5sctMC3/XbFp5Wp+
	z1mSuY30pKKJN8oUxR56ik1wX6MbgtDkXtvg03hUQ62VVm0luceZ4jQjt7xguwt5
	Wo6QmFZRejgimhaT7xPG5Jn6WGtoE6rNlTokDhmToWeJQRQ6wrzjtE+XGdz6dBuj
	pdts1VakGMsJtRKAtd3s/LCZnLB+2xF3EQw==
X-ME-Sender: <xms:_9XFZ9rYohLyz5gYIfHkiW4q8IuDsCc5hx087CTCfYGh_o8D-NohaQ>
    <xme:_9XFZ_pMGHv7iIajHB2y5QRHHtzcILZuItFcH4wrCpTyBWZrdJR6G2FUU-Lp0e4aL
    zHszWW-vDI3R7C1GA>
X-ME-Received: <xmr:_9XFZ6O6WfgGe3zlNhnJ1W7FCHA0w8cmkb_01f_rc9RB1sbunQCHtTiRHOEz3i4WSZGVFWkiyWngNOJf0Bdw58gGYtsWc02kFSin>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddv
    feesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:_9XFZ45VCgkTkVTEw1fwRSUDW0OrB0R-Dndr9vaoiEeoF5iXCfsiNw>
    <xmx:_9XFZ87Fb2FzP7xpdAtlPTP6gWo5tqChrVtKHXhXplOnF68d45tpdw>
    <xmx:_9XFZwjpHGdW4uk5tquJqplf6pdHVc5tjRR_QnLcwkPWOR4i89QMfA>
    <xmx:_9XFZ-75qRZmGc3-MW1q3glWND1iKshcmDwoWm91XsNBfAJ_kdvxuw>
    <xmx:_9XFZ5soQK-a55HUlAtf8FQG9oYJGFSECDMVuqVl-jCbcv019_GRktpW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 11:17:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 1/4] diff: return diff_filepair from diff queue helpers
In-Reply-To: <20250228213346.1335224-2-jltobler@gmail.com> (Justin Tobler's
	message of "Fri, 28 Feb 2025 15:33:43 -0600")
References: <20250228002604.3859939-1-jltobler@gmail.com>
	<20250228213346.1335224-1-jltobler@gmail.com>
	<20250228213346.1335224-2-jltobler@gmail.com>
Date: Mon, 03 Mar 2025 08:17:01 -0800
Message-ID: <xmqqpliyxf5u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The `diff_addremove()` and `diff_change()` functions set up and queue
> diffs, but do not return the `diff_filepair` added to the queue. In a
> subsequent commit, modifications to `diff_filepair` need to occur in
> certain cases after being queued.
>
> Since the existing `diff_addremove()` and `diff_change()` are also used
> for callbacks in `diff_options` as types `add_remove_fn_t` and
> `change_fn_t`, modifying the existing function signatures requires
> further changes.

Sensible.  The patch presented below looks a sane and safe no-op for
the existing code paths, which is what we want to see in a preliminary
refactoring step like this one.

> The diff options for pruning use `file_add_remove()`
> and `file_change()` where file pairs do not even get queued. Thus,
> separate functions are implemented instead.

This looked a bit confusing, but it is an explanation for the reason
why we simply do not change the function signature of the callback
members of diff_options structure.  These addremove/change callbacks
are designed to be a general way to allow applications to react to
discovered changes to paths, and I agree that it makes sense for
them to be usable to perform something that has nothing to do with
the diff_queue structure.

> Split out the queuing operations into `diff_queue_addremove()` and
> `diff_queue_change()` which also return a handle to the queued
> `diff_filepair`. Both `diff_addremove()` and `diff_change()` are
> reimplemented as thin wrappers around the new functions.

Nice.
