Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5B156F45
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 04:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763872170; cv=none; b=nob4pOHr1upSCxGjX427C7S9GIL1UDnN2jy0Ct4tQ0N6o26XOSeceTbhMgNH7BtGZ7kHZyZXVoNyye8AChdJg6eE7CMjPNh3qSQ/qzzjK3LcmsJ/zrhnp4esGIQMhMFzCgl39eGe3rJm0w196SYA/qhvbjrRj8QGIm9NrKS2TNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763872170; c=relaxed/simple;
	bh=xIutRElnrmwgayLiHkbOe+NCCgt2FAiZvQg3dQt9OUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tsKxzW23MxF+U91F/Jt4K/61vR0ARP3AVaTIY4kM+iqDQ+HyyK9g9Yc8pzy4cYYF19jK5+GS6o3/WEyZBnGmdI27l+fVBHFS1/Ugz6GoE3tu9Tup0sSHM3A8l7RjqzlDpuRqWFEiD6DCFK8oIomZ8VAmN7i91S/px3O0PNkJscY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NIj6QrZz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FvQv8j5Q; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NIj6QrZz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FvQv8j5Q"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A53CEC018E;
	Sat, 22 Nov 2025 23:29:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 22 Nov 2025 23:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763872164; x=1763958564; bh=HsWuTxT26i
	f8qA2KmbQLUnW8PQNNJuhwD5nOtr47rdE=; b=NIj6QrZzS3sK1a7UM4pMfzMvGO
	3/thzsmE6DLVItB+eP/RNRgFCT06PFlRGYy18hZ7JWTz0rgARqNUZwIic4faW6X+
	ZCYsVpkJH/V2kDg2+ngtBPwGe4jn1LIQ3/4cyvuTAU7DeOGgMfrr3eOtc7zHOL9I
	F7zCk0Ft12u8RJgjqfBr0A0M3aCtdfWcd4OxOR4Z6uKa2UdNDo16ByCBcF07bavZ
	ib9B08seSQ4TpsPCzBmTKE6ansTHDCsVhJn1Y2xu+CtWkdn35OWtliix2P2JT+qK
	Tto5H0EVeKHlMmAuZKuEKyrq+RRN0p/5qBxRr0x8OCgxlB01R6BaaDYXFlXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763872164; x=1763958564; bh=HsWuTxT26if8qA2KmbQLUnW8PQNNJuhwD5n
	Otr47rdE=; b=FvQv8j5QkW0+ik5JKObt0V6EGgLz8jBVYDu51OmbBFbLuakEstn
	iRxNCSN2FAQGolAE6wrdOBD7o32+KDYodpHjC+y9QkJRDKtepT3tJCLf7Z2bp2A+
	sMCuMNujrrrS2sZ3ulqBsuVgXrwP+9f3icsqyr9pOIvORplJaTcbO4N8tKCT35Ss
	P1hZ/3OXwO5EnSnfiD7Fx4y9U1TgXU0bjL25szyxyBmUCEWXJwo+JuAL+WfBWK4I
	gYYrxTfAfYCUgiT40oxA4i7Sa56SN1qsiUM+NHfyTHycBv+V/VNp6BuBO7x+6nrf
	/0U+LqtKMFNj7h/LrXmT24+uHt9eK/N+4xw==
X-ME-Sender: <xms:pI0iaaiH1fltwNMTY8k6Izc0cJsaO1PQ8SAbKE6ZICJZyajRyGyiQg>
    <xme:pI0iaSeqfagmMimmObdIHgkkW7Nan8nMbsGXP_zpCTRxhoj-brD4L9yjsXoLfc4z7
    U6W4eLM_MT6j1Zo5MnbPLPzlwkJFAHE42F9TNtzmtSjqF7V2Gx->
X-ME-Received: <xmr:pI0iafeE0oaFoXX2nh0UjuhvfBFsLeD6MoJqczPqX2QEpF7rtwhe1Qu2AODp_m1WDUk_43wauCcXfSGXjjNrURux8qIiYGVsa2Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeegjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepleetieeiveevtdekkeeuudeifeetudffvddtieetieffveefgefhffejgfek
    udegnecuffhomhgrihhnpedtgigsshgrtddrohhnvgenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:pI0iac8Klzka6Nx5jgoARvtKyWT_ZoACHnTLI3URrjYyjqLhN2-awA>
    <xmx:pI0iabkPOxyBGa7DOBwcwXI-WazlEVNxr93TBwb28OngE0XRHZZWJA>
    <xmx:pI0iae9oYwwga91hKZhS69xXgBV68oQIGLSbhQ-H-9bPyJBt2UJzCA>
    <xmx:pI0iaZlxwQJgoB-Rvq09Re5qDiCDI8c4q2p_iBgClxTLluxUhufDxg>
    <xmx:pI0iaUE0qzjuZC2UptKo1KH_MuHntRDilUC-KWSQcjkSvIR_tMM15ghp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Nov 2025 23:29:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] refs: allow setting the reference directory
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
	(Karthik Nayak's message of "Wed, 19 Nov 2025 22:48:51 +0100")
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
Date: Sat, 22 Nov 2025 20:29:22 -0800
Message-ID: <xmqq34651ie5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> While Git allows users to select different reference backends, unlike
> with objects, there is no flexibility in selecting the reference
> directory. Currently, the reference format is obtained from the config
> of the repository and the reference directory is set to the $GIT_DIR.

I actually am not sure if I like the proposed environment variable.

The proposal is based on an assumption that any reference backend
should be able to move their backing store anywhere, and they should
be able to express the location of their backing store as a single
string <path>.  For a new backend, "where is your backing store" may
not even be a question that does not make much sense (as "somewhere
in the cloud that you do not even have to know" is certainly
possible), and even for a new backend design that does allow such a
question to have a meaningful answer, this "you have to be able to
use a random place specified by this environment variable as your
backing storage" is an additional requirement that its implementors
may not need to satisfy in order to please their user base.

For reftable and files backends, these assumptions may be true, but
then it is not too cumbersome if these stay to be backend specific,
as there are only two backends.

So I dunno.  In addition, if this is designed to help migration
(which is the impression I am getting from the cover letter
description), don't you need a way to specify more than one (i.e.,
source to migrate from and destination to migrate to)?  With a
single GIT_REF_URI, it would not be obvious what it refers to,
whether it is an additional place to write to, to read from, or
something completely unrelated.  For example ...

> This patch series adds a new ENV variable 'GIT_REF_URI' which takes the
> reference backend and path in a URI form:
>
>     <reference_backend>://<path>
>
> For e.g. 'reftable:///foo' or 'files://$GIT_DIR/ref_migration.0xBsa0'.
>
> One use case for this is migration between different backends. On the
> server side, migrating from the files backend to the newly introduced
> reftable backend can be achieved by running 'git refs migrate'. However,
> for large repositories with millions of references, this migration can
> take from seconds to minutes.
>
> We could make the migration non-blocking by running the migration in the
> background and capturing and replaying updates to both backends. This
> would require Git to support writing references to different reference
> backends and paths.

... I am reading that the above is saying that the system will write
to whatever reference backend specified in the extension.refStorage,
plus also where GIT_REF_URI points at, but if that is the way how
the mechanism works, the variable should be named more specific to
what it does, no?  It is not just a random "REF URI"; it is an
additional ref backend that the updates are dumped to.  Maybe there
would be a different use case where you may want to read from two
reference backends, and you'd need to specify the secondary one with
an environment variable, but if the system behaves one specific way
for GIT_REF_URI (say, all updates are also copied to this additional
ref backend at the specified ref backing store), a different
environment variable name needs to be chosen to serve such a
different use case, no?


