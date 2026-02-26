Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007BB43E4BF
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124758; cv=none; b=L11rprglhqltSazdTJH5Wj9jZRKzgJzakD3MpXKlkeqKm3ZNjP5MKF3hcAz/tiOtQC4ZecffGRGH5bed/36fB6/C3enXLAnReieIQ3nc99iV4Eu8NLmorYddkAbxKFvL/U0R8rhqCk14p2ZYGduEwUy2VjBNKKiZwHDwdJpL40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124758; c=relaxed/simple;
	bh=S82flx3urjtPMSHVxvUI9GMar0PX0krRqXdaRP3G1gA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U3VG3PE6NYukQMNXK7SWCD8JHvqUuc3MlwwXukydz2G5k5W79KfFC6wl4sLaCLgnCoTlvYJo9V9cPFjBEi/LKmAWAmieiqp7rgW4J8W4Z3F0YND4HvzNmHvjFBnVbKqkQvK/QSr630zw5sTblT9yDLTkl9/JACE/y1GSYRLLh84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ryt+CuHJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hIMZ5P0k; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ryt+CuHJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hIMZ5P0k"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A92BEC057B;
	Thu, 26 Feb 2026 11:52:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 26 Feb 2026 11:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772124756; x=1772211156; bh=ZOZunnfokg
	EHJA2+fFZlu0eAC1rsdeZ9CxL3lfnN1no=; b=Ryt+CuHJcCQvdfHOv/+vi94xzh
	QwV6pNHVt11fSqJ7eXC/EqmTLsGQVoj32gGhgNIHHT1V4at7KYvzcdLWrqjUMheN
	udpXZ7KVjHxWSC7BvoaI/pCMqYaFdiDSPNWHaDlBIfr99YvSN+5Sm8ztZKTw+Bo3
	n2eHc0S5opvs0TO943LjEySKQR5315OelzXVZuBq1U8wpAQBtYcN5HhyLfPcQICo
	5TxAU7E/q1wtcXpag0TXRBw+Dwjr0CNICfZA8qm6eOLNnGqLbgp5X9PMSBq5yggy
	sqQKizCHv4CxvGacCPkaFyHbKfFmv2WSGhQpmW5450yjzsrzzpLt0aUyR1pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772124756; x=1772211156; bh=ZOZunnfokgEHJA2+fFZlu0eAC1rsdeZ9CxL
	3lfnN1no=; b=hIMZ5P0kXkcTWxZZyYDvpY7bzReRYZR+ag22vuGhxjFhFQFpbvX
	onrXvhH6PxJrFjjJxwEWbsSa6yh17AMz1D/q06xE6uDrsCHDwDr2a89N8juy1jwQ
	7J6vwPR19mCZp3+n26n/DiKHIQQGXXF58l8kY0ppJgU3L/Avm4tW9oA9VwtZ005F
	Nr5OKbfsDoOyaV6pR0mmkewAjbUUFe0IsXdffUYj2GKh8JInC1VKYi0nhghOlQbk
	Qwuuu4jXUxD3ptyVAbmo6UP9LGthi2owbWdRWl1mxgnuaO/V2LALhFu+jMoPF0Ey
	c664tE9whMnRuE2X3m4ETeZvTbS6j8JmWUg==
X-ME-Sender: <xms:VHqgaQtiXI8p5R74b7D3LVo-N-CLDm-g3ZB-t5wJt8at0m_1L8y8gA>
    <xme:VHqgae_KMHyOZP0jAFj_xJiKn3uy79BJuwAULsZHnsdC3X3ZKQelj2WHNxv_Wcufv
    xcM4glr7RuxuR5XJh2Ux46qQef8zYj1BOd5qvbSzss4n3wH3hWW>
X-ME-Received: <xmr:VHqgab3egkIm8yhQnasqOvOZKgDDwUg8bXOByklRE1ldzFdTF0BlSjiTl7lV510SawCh03x4W6BQU6m3cGznwnGZOsd0Sd0TOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeiheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehlihhnuhigrdgsvggruhhthidprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VHqgaTD-DiYa2fS_uxvkRhXxXQbNpWJ_62d3R8oZUeIM0NfDpBthew>
    <xmx:VHqgaXeiOvcba9B57oLPQtX84kUmKXusi7M_xBd5OxavQytYEoUubg>
    <xmx:VHqgaQ5YE-H4CMzBX89nJrE3aaA8p850R1Dr6x4H5ELrbsnrkL1sfw>
    <xmx:VHqgaaVsBNArzQ1OrUjGBBwynVITYc_Tmi6KrbymWr73gAgVkrR5TA>
    <xmx:VHqgabVKmWuLcIXsGbCc7Jmz9rD1MxtQe7w4jvLb_uWeE_mZdzkkB6yG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 11:52:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Li Chen <me@linux.beauty>
Cc: git@vger.kernel.org,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
      Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v7 0/5] rebase: support --trailer
In-Reply-To: <20260224070552.148591-1-me@linux.beauty> (Li Chen's message of
	"Tue, 24 Feb 2026 15:05:46 +0800")
References: <20260224070552.148591-1-me@linux.beauty>
Date: Thu, 26 Feb 2026 08:52:34 -0800
Message-ID: <xmqqecm74fcd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li Chen <me@linux.beauty> writes:

   > Apologies for the long delay in sending v7.
>
> v7 is based on origin/master at v2.53.0-154-g7c02d39fc2.
>
> This series routes trailer insertion through an in-process path, removing the
> fork/exec to builtin/interpret-trailers.
>
> The first four commits refactor trailer rewriting in builtin/interpret-trailers
> and trailer.c so callers can reuse a single in-process helper (used by git
> interpret-trailers, git commit and git tag). The final commit adds git rebase
> --trailer, currently supported with the merge backend only (rejecting apply-only
> scenarios and validating input early).
>
> v7:
> Rebased onto origin/master at v2.53.0-154-g7c02d39fc2.
> Split out a new patch to parse --trailer with OPT_STRVEC in git commit and git
> tag.
> Use strbuf_write() in interpret-trailers when emitting buffered output.
> Restore --in-place rewriting semantics via tempfile+rename.
> Drop wrapper.c/h and validate trailer args via validate_trailer_args().
> Drop redundant rebase basic-state save/restore for --trailer arguments.
> ...
> Comments very very welcome!

Yes indeed.  The discussion thread for v6 saw quite a bit of
activity, but this one is quiet.  Is everybody happy with this
iteration?

Thanks.
