Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404079D2
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735832497; cv=none; b=Z8wfi1g24S2mY2NNLZIAQ4nxGmXfXwOxQb3u1ST1SXU/2XeuHZYt8YM27INc7yhnnXfNvasiAxMcGCT1SpltvW83ve5rROcPI78yTWOdQ38Awne43Cien4hmMckS2o23BqOSd4uWOMRI/B8DeCY0tGL84NviXzYuDC4yFoBfdE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735832497; c=relaxed/simple;
	bh=J2D3Z+tOZ9qfs+qxLOYNZVkgfbrIuv/Kybf0TTjZ54k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bhHOcDkdVrLZTc2Nr/eAanexJ5MvEl3Z6NYqb/aYO1s9Zm3LZHf374kvLS+hR84/CHQtOr4zZpVWRoOiFl0rZW8Wj+cw87W4z7oEAGN924aHtS24kHAgGIYngGzLFh6XSWRMqXkdvR2zxuBQ1tXzsC4vwECpAAHrvJFr3VWCAxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X4OTza1t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=koVGYWPP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X4OTza1t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="koVGYWPP"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3366111400FB;
	Thu,  2 Jan 2025 10:41:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 02 Jan 2025 10:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735832494; x=1735918894; bh=nnGgiI7pNw
	p+SGif/9fK+3UrqefiAPb15zXjQHP4hng=; b=X4OTza1tTUnnzIq6zXBh8YIIQ0
	zwtyO79pU7ogIsOc9dCdctPdQApGsJI5djzmVl8blDDnWsvYiTcuNig3NWRDRWnN
	qYaS+B+wmbwJD8+LpCXUOlGJT/lbyL4a5Z1Akf/mab4HnVNl89L539Bd7y78mims
	Az7Sdc24s9Jad7UydRgCpjHdxjNRccaRABsdaauQjhUYu6az7jAb4ng86sUIl+0L
	85wyiKJ/PplSLlMpIw19s2r5E+oBNk9lEEH9xXa+3Jnoh+D5m5oEA1VeQGrCUhqW
	tOQUqr5lpRGXwHaasAQip010KxWZLJeYkQnJAbgC0clHrmLi97+cQ+yb6W9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735832494; x=1735918894; bh=nnGgiI7pNwp+SGif/9fK+3UrqefiAPb15zX
	jQHP4hng=; b=koVGYWPPXXrfLCl/Kfvypi6qNzBNnAV7bi9BEB9wBmAaPtmS9au
	/x+t6uVzLjCFH9n9Kbvg78JOH+eoLNtEFtk4jsopkiZUbj5gZqcJk6ZdriMgEBcy
	oqqC5SBofh0uLpxtuyzh2bxQ0em3jOX6bdx0WmZqsOdzIrDwRx1Q4e+fQZayRtwj
	GJ6l+EDPr8o8ihKJNdTT2fCcW1UMgwYzZzUZXLk6zvjTvCmWw0pbZOeQ6oCnWFVQ
	rlZ85386dHdd+EPIOq3cfBf+v6XdyuxV0BFbnjUvPKaF/ttJWM6FPaQwPkOE2O0y
	C9QgupjjkUIKwipuPwKYXCGMNf6XuDzcnxw==
X-ME-Sender: <xms:rbN2Z6rBKJO8_nMjaqQTxqKyjBFpgQyW5rm9j7vDclI7z75bxeZn6Q>
    <xme:rbN2Z4pNB4ODiSeVByWCMR5sfJF1XJ81_o-cvvv2jMFTYo0ob0ixRhfwtzAJYW5_a
    XvQuiboZurwLIv6OA>
X-ME-Received: <xmr:rbN2Z_NXXnh0RZQ5aGE0DwksBkHutC8sAnPUm3mF7sPD4scHH--zcEC6nnm1SwBqJOs_7kp-rRjc78MTbjNHd6eHdNHbpYq3HA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhrnhhivgguvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnugihrdhkohhpphgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:rrN2Z54wFxawS_pkN3ARMDwdEc5179yNKXqRIckgr7GS8sdLtZc05g>
    <xmx:rrN2Z55reU9T0DgTPhPb4-Z8s2GWw4DKah1Jy8FGA6xHSuAa1Z0Fng>
    <xmx:rrN2Z5hi8acBPt6BT8FQSYixIhliW-3vjs3TQZHzjKEqUPuCTwSsvQ>
    <xmx:rrN2Zz4cGYebFw3CUDHWQtdZzgRpSsXupVE5_1EcMU1a6xY4WQOsbQ>
    <xmx:rrN2Z3QfGD5hchbkOSR_kzHPtBCwbkljc1QxueZZUVTyf0mja1-drFCc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 10:41:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Andy Koppe <andy.koppe@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: meson-test syntax error
In-Reply-To: <xmqqr05lusvp.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	02 Jan 2025 07:39:54 -0800")
References: <CAHWeT-boK3x6mup11boEinNDQiAxxf0vwvZkxsGRc_GRvXYA8g@mail.gmail.com>
	<Z3ah2YQSx4ZreBpK@google.com> <xmqq5xmxwabj.fsf@gitster.g>
	<Z3avRmaMr70FOs8A@google.com> <xmqqr05lusvp.fsf@gitster.g>
Date: Thu, 02 Jan 2025 07:41:32 -0800
Message-ID: <xmqqmsg9ussz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> One thing I had trouble with is that, with /bin/sh linked to
> /bin/bash, none of these
>
>     $ SHELL=/bin/dash make test
>     $ cd t && SHELL=/bin/dash make test
>     $ cd t && SHELL=/bin/dash make check-meson
>
> seem to fail for me.

Ah, I had to do this:

      $ cd t && make SHELL=/bin/dash check-meson

to make it fail.  Sorry for the noise.
