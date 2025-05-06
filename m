Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007E219DF8D
	for <git@vger.kernel.org>; Tue,  6 May 2025 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746554873; cv=none; b=fBGuKQMoy5D1pysHN6uf6bAMutls4WLPdhb9M8XiMNr0hGfTsz62J+lGsrUz7LDqEFVSuTJLDpUDnh/Ish2gUw1dxNUmppCKvjXMly21RuzOodyhQx6uD+BLswwNKAuD7OOEer7ioMJEO6CXH4ox7Alyt9v001x/v+J0st5C2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746554873; c=relaxed/simple;
	bh=2Zouje0SxbrIcV73D07zpSRoW9u+dhXusWaFIVoZ9dM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nl4ckj5UUqFvGB038NoLPWMbQuibDYFy8Oy3EN5e1JHb9X175V9VQvSQOIqSirCKwK3GlMP+56+KUWqQCcvkM9+Jm32bFyFgHd5k8kLUxEXz4P+G1UzXY/Bf5wFfJT1AoA/fzbV8trqNUnwgnLDFLj/O28U1girclNDrdHiIl7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jy6nMwHS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=we8iLVF+; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jy6nMwHS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="we8iLVF+"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D0FE91140219;
	Tue,  6 May 2025 14:07:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 06 May 2025 14:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746554869; x=1746641269; bh=2Zouje0Sxb
	rIcV73D07zpSRoW9u+dhXusWaFIVoZ9dM=; b=jy6nMwHSS8EGySCVDrIwPJPgAe
	cYmexENMpkbtVEnCq5lELh+zXdPMTi18bhHtDkc/Jzq+YRUR/wiI3D/RbyxYe+nF
	f9DlklEHhdOQVzO/s5pjjyn+ya6YtYHP9oxmlMtqfY3M4V7+dpB5yaODrVcE2Xtt
	gM7FnlRye0oRG7WqXG4wNvBo75/HrsfwAwsvVsr1Y4rTNCXgShNlxLl/oRSCl21X
	844tB+hLtO6n4KqHovM0WEU7Da+fgQNyGiZlf6QP1HDh/Vjw6kSlhaAku3ghGKk9
	PrCN3bRWB+DpjGaa1sOku3zeYgXZRQxoZB+gTXYa8H8L/nRJakcusIcV3O/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746554869; x=1746641269; bh=2Zouje0SxbrIcV73D07zpSRoW9u+dhXusWa
	FIVoZ9dM=; b=we8iLVF+U/FHue8F/S2oifOZbIbq4wuTuZ+mLGTB3/C8SHq0IB8
	A7BzlfRJ6UV3wrEDLPDnvth2C+91gjEkNFh3i7bVI0z+w2i6zNwSFZ05+0597wqF
	ncwSDGsJHYvE7CRzPzpRisTS/OB2YScBfk1ghCkkfO1QXdnNCSi4Da5RLrcFUOt7
	SPdeUeo2KErJr81zq8vpX4lzcQLw7YxPN14f07IUs5WTcOoDS9srSvUu8d80uCPt
	YISkmTt2pJ/U+v4cXIRykdBhsbE5QuiK5BvT/9no9/cR8K/YeAwjoVovsGxhlckL
	bCWlU7hU/ptlkJUPEmPRtlGWN5G7puP12Hw==
X-ME-Sender: <xms:9E8aaOJ1h79YNE0ondG7fJUinM91hZDoBoa5RAtZRlSehvOTJbZdqQ>
    <xme:9E8aaGJZ5DAhn6OYY88jPnoqPFX0bLNca-moEOXFgXSiDp_UGHzDnEmEc8pABl65j
    n-FGYDwiubst7zNkg>
X-ME-Received: <xmr:9E8aaOtyQFPCY20XtwrlOa7EBG1b8uzfkKHUI19iBkHWTw2lWVC5KI86qcZWx11cfFYgntAq9xtzoNMw6XtLgzuFuxWToYWrzcuZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmvgeslhhinhhugidrsggvrghuthihpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:9E8aaDZ8N1ndwfI73aSIZhIJcO-ant1izIuQAC_5Yf57SLkOmaKRxg>
    <xmx:9E8aaFYrRGiNcvuk3WLW8l6R1jB1JdZolvGU391zQ6l7tXp-QSyKkg>
    <xmx:9E8aaPBTJKyFb4ZikehEcbFjnWTpiNU4iAOpL3xulExI1t-6FyFfyQ>
    <xmx:9E8aaLbuvuITz1T572JwwoWE-bzTaeab14D00aXdBq-ZBUrHEdeBkA>
    <xmx:9U8aaBY0ayWKbGq5et3gT7pMAWZ_HY8-XtdhHploNj_BxHdsJx3Hxck2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 14:07:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Li Chen <me@linux.beauty>
Cc: "git" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] rebase, am: add --reviewby option
In-Reply-To: <196a5aceb00.fdc2d9ff187843.3547183335386278718@linux.beauty> (Li
	Chen's message of "Tue, 06 May 2025 20:58:15 +0800")
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
	<196a5aceb00.fdc2d9ff187843.3547183335386278718@linux.beauty>
Date: Tue, 06 May 2025 11:07:46 -0700
Message-ID: <xmqqv7qdk3yl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li Chen <me@linux.beauty> writes:

> From: Li Chen <chenl311@chinatelecom.cn>
>
> Introduce a new `--reviewby` flag to `git rebase` and `git am` that appends a

Shouldn't this (and possibly the other one, I didn't look at the
patch text) be using the internal machinery used by interpret-trailers
so that we can do the usual "do not duplicated existing ones",
"append only at the last one is different" etc.?

I also do not think we want to see one option (like the above) for
each trailer elements (like "Reviewed-by") that is commonly used,
which would lead us to adding "--helped-by", "--acked-by", etc. to
complement this one.
