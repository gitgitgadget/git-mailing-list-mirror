Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6AA37E2EF
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774643241; cv=none; b=oiWataRedekCcw0XqtHJ1itJ1waDx0+/cbY7OQOLn8NnIZX0K1uvlgOoK73kRVTJ6CKCZr49MWAvhXVPSQ7LhAkcyqdT6zZPeHqP2fszrtQ1qR771yoZEcXC7CurcnjHXAShHEFKJ4WTsDutdx83r864fBaTUkV0pcFdKVff2KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774643241; c=relaxed/simple;
	bh=Q3lUJqkVhmRAVEgFhMT2g7SUuOQFZcUghv41vsOvs6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c0K+I8ctiImgvXqO2dP1sZKmxwPmv3oaL/V4+IDAGu+jA0r0qooyNqD/fZWS8QevmsENYec7tpDjZnHEoDWtX51GQcnY3yeiTJInhZYoDpFMNNBSTfz71ajx6ev78JQRC92zXcZasBYoVmga8609JCmZUVS5OaQ5Kn/EiBHu/X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y4pVdGGY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UfXi/AhR; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y4pVdGGY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UfXi/AhR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 233E21D001E2;
	Fri, 27 Mar 2026 16:27:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 27 Mar 2026 16:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774643238; x=1774729638; bh=oexSaasafX
	3tfB1vsvRW/5XjUVJyqBb96LLlMzcm4eI=; b=Y4pVdGGYVtRunwsvAGpoVxSkLS
	Wcp/6B8SPyMdEAhte+RJeu3nt9KyY0dZ8KGR2uCcCMifQjn/4IMPM8ubicMc0dZ9
	1o45f3Ih1gNgSnn/RNDjgq/PEu4vDC3YlAtNYJ5tbnS76uPeyqBKo6NpxVBic9La
	jo3MoNWqru07484A5JYx+Pxyfo35Kf+zH+N6FgKNflQBKeLVaUQD1cKxxHw+eR6E
	hV2RlS9WY8Z0zAn4HCRD+vmue08D646ICg5lnsiKEK//8XayuVv+4MKpCDJfY9Do
	uhz3WYJLcSsfK6s9KNRS6b9wEYhS7s+0Zuo7i+liX2E6VWNYAXk2W8A4/jog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774643238; x=1774729638; bh=oexSaasafX3tfB1vsvRW/5XjUVJyqBb96LL
	lMzcm4eI=; b=UfXi/AhRhlgTK0CO5fJCa1SvObrIJm9myU3+pztPneA3XMV2pZy
	N7+cqx5qBGkMEjKavZ73Xee8cs4BaSd5TdhGa2xHbO9dX2v7Rh/9xqhFynqCmv5T
	GfoQzP7uFFQ6vF83gwIPQjNVHLkC6Cd6dzvbR7ZY0fG3cZ0gPbMJ8Rb30rHEjkd4
	dEqLBWkP7TBbtqSvirqPC3BL4w2Qchr6jMno3mmNz7iMvS7aAKm5tao7fQ4g3dZh
	ZvP1N3atAXGmiPpoDssn5Dgqa5s6z1pDRiN4iKf30qapXeTRF129M//XChvCld22
	CFPL5AosCMDGbi1ZN87llfybVN6EgTgl7oA==
X-ME-Sender: <xms:JujGaTC5Vma14PX4g2cmmKCH4zQDttXECJtE4ixCcXqnOAYo2YwvRg>
    <xme:JujGaQ_xX4eM0A2nX9Unc1K-y9PCZLmetEUgSjTJGrPUvEmnK8imPbvGIcMVtSC9X
    Y0ihTTuJxIXRwDgwO0Ydtf1EZJLaTbWQTH7LQOTr9z0m6mQaHkL-cc>
X-ME-Received: <xmr:JujGab8lv0aRS_MiK547T_yLCGrAI4SG2k-uNQVDRwHhQ34U0gBv01NxZZMHbEweLQZln5_qxr5GM7SxDyarTjHIEJDtr0Iw7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeduvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JujGafcvKzJ95a5jmQSsZTCdiUUqoZGZTiy3wgVUhWBJjR_3jzkPUQ>
    <xmx:JujGacHRkP2K6J4biRbsE6QjS2Ow4l4b_1LHnqkGziphDdsTxwTzEg>
    <xmx:JujGaVc2mtmOP5bbjT7Q8-IQGcxc6nZiv3vdX0Fd36i9ya9Mmi5XUw>
    <xmx:JujGaeFWgivR2LZ7ZFcQUaubU4IpAkmsob2YDkdqSzxDqxjvAbj9vQ>
    <xmx:JujGadKnBBCWwhp-Zbgh2OR4OiHyZovolq05Dw9kTQqUXvUoxjlRxS-o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 16:27:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: removing unconditional wrapping
In-Reply-To: <204b9320f46529d16d3a4d9a9c4a57253b4db028.1774640789.git.mroik@delayed.space>
	(Mirko Faina's message of "Fri, 27 Mar 2026 20:48:10 +0100")
References: <20260326200643.20251-1-mroik@delayed.space>
	<cover.1774640789.git.mroik@delayed.space>
	<204b9320f46529d16d3a4d9a9c4a57253b4db028.1774640789.git.mroik@delayed.space>
Date: Fri, 27 Mar 2026 13:27:17 -0700
Message-ID: <xmqq7bqxj9wa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> Using format-patch with --commit-list-format different than shortlog,
> causes the commit entry lines to wrap if they get longer than
> MAIL_DEFAULT_WRAP (72 characters).
>
> While this might be sensible for many when sending changes through
> email, it forces this decision of wrapping on the user, reducing the
> control granularity of --commit-list-format.
>
> Teach generate_commit_list_cover() to respect commit entry line lengths
> and place this wrapping rule on the "modern" preset format instead.

Well explained.  I would have personally picked a sligntly different
default format, but this topic is your itch, so it's OK.

Will queue.  Looks very good.  Thanks.
