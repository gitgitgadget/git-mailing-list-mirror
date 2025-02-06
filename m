Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31F51A0BF1
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868882; cv=none; b=SlMl2xP/UU+otEL4AdU1nCEUyILCJXttIrTPu+RptS0yO12JlOoaO5AJvgQYYlisl5W+iWQIKKF2F6H+97+1h1JSh1ln5tCkuLuysGKmfkARfCbcrEKSor9oGj6xGUAZjKWDFgAqsrnfY/os+m76Ls4pF6o5GWSqM+aSoviBfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868882; c=relaxed/simple;
	bh=VJc/e/x1nMNM9bLZl95tXmx8vsn4ncFgZmcMZ+MrXLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cp+hpdXQkMC8DzHxMMvqThjo2J23hWhqt7aKvsM12ZQqAT3re05BCuhcrxSMF0v5RuK1uO1CH3iJOg+vOLHorAF57HWANfJEHDmGeJ1kTxV0QOdKtLXq3YY07+B3GK9YYxtXTPhbRL/Gmf4m1NGM5qCqyJvzkIh6M/C+Zv8Ybcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ty546xr1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uZ8LH/IF; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ty546xr1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uZ8LH/IF"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F65B2540146;
	Thu,  6 Feb 2025 14:07:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 06 Feb 2025 14:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738868879; x=1738955279; bh=6NjckxBC0J
	CKC7c7jIsLg9W9MNvB9kTagoyE3aAtZds=; b=ty546xr1JxZ+PFHmnf+3IQEY/4
	LAxEpKRex/syMlTHKw3nUP2ncVnh7o7wzaObvTfz0FtqhyMoLZFthFsb8L8okxqB
	HK5USfa4+uAwLaQoaivFe3JTzkMOF0uD/SXaQMvpC/H86US4tXkIg44TvDq3FH5K
	6es/cZOy8Gr0bUuoTwOi3S8mdEE2biROd8qJvlUC/rPjv2X+VozNCKtKWopyq8VE
	/oQOu+moihl+nEhqNQjKGUdC2k0nnq8vpd03DegI4zAYWpMvyqWqmb/NGkBb0BQd
	z1C4Jt8sIztMe3f1GLU5Md6GUzsvwEWuEASFuryrVFFNLo59MZaQthxiDj5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738868879; x=1738955279; bh=6NjckxBC0JCKC7c7jIsLg9W9MNvB9kTagoy
	E3aAtZds=; b=uZ8LH/IFx7qedyMl0T/OvjLD9geIWfwgiWUPhzxY4DEN0r+89tP
	gs+HKeLkMcjsX0bsKXPypwwPC32PQ6BgXdj6vuB5FnMmcZVB2Xap43nU1KH1s1lA
	CQMa7wnOrJT/qGMG0zH+I8b18FD6fGcjivYPsauH1swJr6EeTWjRnpIbISw595h/
	bOYsYeaXWmQK6O8YwdFUUaAT4GygaCB7jC9tH5NbbOwbIBm9kWF/xv10RVonIm/H
	prUEddsXIEYEvhPH2F6xwFpjtDa4OmeiYr/R5mJJ162ObNbXrIphvJN4v053aQFS
	2M6P3pgyFKYgnT60q5coiOQ2KIUlW/EtsUA==
X-ME-Sender: <xms:jgilZ7x4AN_SOL6EUGSpee701deJzQ6_-W1CKpDk8glFcAMePSd9eQ>
    <xme:jgilZzRs8vyFwTiN1a9wgKEmyg7gmIvZKj3PACxdZ2nCd_p1KCuUY8jYAOXu6Srs2
    hGCkwnZkB3QnlV3nA>
X-ME-Received: <xmr:jgilZ1Uiv0-d3ObotX8bYLnxLEDb2oMycYRiQr10ciU2UQmPghi_h7F1VuWoe4CHzfGaUJeh1je8Bnku-kxOqQs-q6tlaaksQTj0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jgilZ1hoeU5C0oj7PySOsicaoADq9h5-Wx1Qq6_aynxKmn1-KtMsDQ>
    <xmx:jgilZ9BB1Do6CD-6ZmSo6LiUv96m6JaNLeY9vP9pGJOYe-EP478rAQ>
    <xmx:jgilZ-KBJ0z2cOmFLwNopHs3zzlAiV5NstQss5DCt2zHRNVZY-zH_w>
    <xmx:jgilZ8DqeBYZK7ugvRTmGtOfOc0YnEDiuZL0kgl1OIFWuSkUBCKWqw>
    <xmx:jwilZ3BrX5hXLhooW6jMCbHZZYz7TKxdnCH2S4qex5GIrAMOt6uAS19I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 14:07:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: David Aguilar <davvid@gmail.com>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/3] difftool: eliminate use of global variables
In-Reply-To: <CABPp-BHpqSRy=G4HB+QtbFuP8Bohw6Cd99va2++PawehCDt0Aw@mail.gmail.com>
	(Elijah Newren's message of "Thu, 6 Feb 2025 10:08:29 -0800")
References: <20250206042010.865947-1-davvid@gmail.com>
	<xmqqy0yjjix4.fsf@gitster.g>
	<CABPp-BHpqSRy=G4HB+QtbFuP8Bohw6Cd99va2++PawehCDt0Aw@mail.gmail.com>
Date: Thu, 06 Feb 2025 11:07:57 -0800
Message-ID: <xmqq8qqiki2a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> stop using that global variable.  (The change to trust_exit_code and
> symlinks vars do seem to be independent, but kind of make sense to
> handle at the same time you are changing how has_symlinks is treated.)

Fair enough.  Thanks.
