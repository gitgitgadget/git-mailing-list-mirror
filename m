Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492131CFEB2
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177536; cv=none; b=WdjJgohFWgFN6+wZccsrjOEXA6q13Aj8pblGZqAbLCXpaOo1ivkbViBz7aldVW2/xqu9+EgW6xXdeyFcwH/0qvn5Lcfb934GojU68HXKeF6EANunavvITKbW/33miCSAB/xM0NVuPNRhCzKn9+WLKmIfXvHNQiYW3bAn1SUFaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177536; c=relaxed/simple;
	bh=cHoAsPy53XdUFtVvz/INLb5K53urydyHKkzz2RKHL1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jXyCLhBV1jEjQxQ7Qlz9zyn7ZTV5pH4Jx32JYFJRy9Iq1gV1D4g6bK7FSMljVVRRrlqq1v0oKR8TkzkRZGBAaarJA1mODSncc+ph0qiACPBb1+kJOE3UReZVG2eeqTcM3mu1ukFKGZBtl/b3zQd84hV4Z+T6ptkAy6XJMZ1jf6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=3Nxlse57; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VscQFpQU; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="3Nxlse57";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VscQFpQU"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1129F25400E5;
	Mon,  6 Jan 2025 10:32:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jan 2025 10:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736177528; x=1736263928; bh=vtrK1HE3eI
	qIx2oH1sjOB3QfeqlOSRBaRzbuMRLAByk=; b=3Nxlse57oJr+bDqfdbsBaMXqgL
	RO5AqUf9bRCqExYI5DtvVq/rBqbGLDwKfV8Z4i97pSaR4li9nFsifMqCkFKoXDO0
	IKAOIGlNlNxG9PPK9/TeuuZQ0OEc7cj55NIpbFYy78ZIBNoTKq4Pujpv1QXUw8bT
	yLre99QgtwofmFiOgti+NOdcdHWCb2Tve6qlpOjNZOe+xmQ5whGxGCDb5mL0fsiQ
	e+oql1gNf5Ftt2bbjvra2Alee7ZSKwSWYD9M946YBQZg5Dz+DgNRox+6nfIJMnUB
	B/nqpNNtqLM16TJkRJCG/FeZuRr+j++FRiVjbVqDenDWsOgkiPcsB7nG/nFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736177528; x=1736263928; bh=vtrK1HE3eIqIx2oH1sjOB3QfeqlOSRBaRzb
	uMRLAByk=; b=VscQFpQUVHROL0SbNk2L8wVc0lQarjLBsV85YbkYN0NVwBaHQkn
	KaUun1k9e+5iC+XeNaswr9yBQmpZFbzrb3/Kw2bxTr8Lcw7amBqIwcJDWk4uZe/C
	/s3aMrdvGhBqk+bseZ8WpbgVmA38CA4JTThsxIBaatMciElXPVMv74sdmW7p7Zfo
	PinBPPkSi/cPiUeLINRn2NatB2wmikDIZgft+u1OL2iNbgeJD3OGa/Dlmx121Wyf
	gdtZYQ07wrHnTg4tqygk42dxiX//lnGiwaMZwHFmyRn+SEeJj6HqZy01M5FY4y4N
	RRgPcUFofanONSTt+m/aAQGZ70U+rozcPeg==
X-ME-Sender: <xms:ePd7Z0UPeQZMyp0KZUhwB5qFjHXAzxpmsH-GAGwITqNNokOi9pWvcw>
    <xme:ePd7Z4ma1bZ_vejIQhJcTAlknNXhVHmiOAJSPVUFESqtsnZiTtqYZoI21qb4U_6do
    9PsZNBL1D-LL2gIHw>
X-ME-Received: <xmr:ePd7Z4Y6dv1rvDkejyXqnl3N6UsoelLuE_5fmyFg1GSuzRwGDx2T5Vdmc5L2Ej7tK7qCtYqKj-AqK070Zs4Y3wqO8KoFk17CbEPn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvh
    hilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:ePd7ZzW7VpDB99ktbw6VrtDDr5h3mLHnM6oP7K8_UG2-O2nisqgSkQ>
    <xmx:ePd7Z-kXPyiA_IOVe-RXnnhq-BG2XfpWBwsCABRlb14efVLf38k-Qw>
    <xmx:ePd7Z4cgC2zJ8UzRUsQOEY4wXB9hOPMpAH83je5ZjOx3nlVUdQIGGQ>
    <xmx:ePd7ZwG1B4EPKyZSbhZ1iUVHOcFMGHeQ4QGubXl3SOHL9ZKgH6ciVQ>
    <xmx:ePd7Z1tW5J1X4bDEmllwGcfepF9167alCswoNKzAQE9rz-qcX9xJjeZp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 10:32:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] doc: git-notes.txt: migrate to new documentation format
In-Reply-To: <Z3t_GvqfZL9y-_9p@pks.im> (Patrick Steinhardt's message of "Mon,
	6 Jan 2025 08:00:01 +0100")
References: <pull.1846.git.1735924216993.gitgitgadget@gmail.com>
	<Z3t_GvqfZL9y-_9p@pks.im>
Date: Mon, 06 Jan 2025 07:32:07 -0800
Message-ID: <xmqqldvo0xhk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I think it might be a bit easier to send related changes like this and
> your changes to git-restore(1) in a single patch series going forward.
> It allows the reviewer to bundle related reviews together, which
> requires less context switching. It also allows them to more easily
> refer to similar review feedbacks sent for preceding patches.

Thanks.  I had exactly the same reaction to these patches, and I,
after reading all your responses to them, agree with you.

