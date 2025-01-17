Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EBE166F29
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134797; cv=none; b=CYpMHlNV3AAGt3n7/NztcLyd4I2duh9l0Rpca/CXsHuKvN6CLkKN+wZpIVUcjoM0YHZBwB4YTjLv0IADA2TdgT1sT2QLoodHcQemj1xKnPIrz+aIxRK4yLHm/O9By2OKrLnwRkVtmT/Fwyc7CKz9QoYeTKsqV5/f+l35aVLdrL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134797; c=relaxed/simple;
	bh=514Eey534cGdZ7p6RzOuifDF3GHocE8wlNliTE9+D/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T+Jdqa1jXvnHVtZ3lDphwtGA5Au9Gsy4qui+uw96CvQFMqA64zinsqmA9WWm4v1kIOrfn7iqUejMVt5topamuh2lFaP9VT3Y180uc5xztiWYH/sw5CdH2keFXk7CwVqIjPeLReF/yFxT6po2Sig3dUObqxbIX3T7tbu/znCMLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YZSTnMMq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J+QSBvc2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YZSTnMMq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J+QSBvc2"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 99F3011400FE;
	Fri, 17 Jan 2025 12:26:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 17 Jan 2025 12:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737134794; x=1737221194; bh=l4z7yHYkk/
	CkHGNuUlPU7BrfwlaZP9nfzhIVWna+OLc=; b=YZSTnMMqNv9L9aZL6o+bsr/dzb
	GqLa4oZq2NGiNmnKm9eCHvww2cXCn2AQnP1ln43wthKC1tmvD9Ok4byZLgoyS/s4
	sYH0CmBOqmBHvSL5uBM82cw/9qUAV9FoGoApTnS6ExHVkk0kp/aTF2tmxw0+XJRL
	gKMyXAhKwbTC5CXcEybZw/WXAk3txLNXD7Uue2XIgRJXs6+DzGvtQcdlXnW76lAI
	qFOJIDZMlBbCOQHg4N+x7zCZToAazjiLiZRYyRyRaygV8IrCnE7I26eHglWlhaoZ
	JDMGeGgMykgfihgtdpI4MWubGYYIPTrUr1CFKYRU7udqN+NQ5MfsYRg4wT2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737134794; x=1737221194; bh=l4z7yHYkk/CkHGNuUlPU7BrfwlaZP9nfzhI
	VWna+OLc=; b=J+QSBvc28linP18je2gUPNIPI8/c1ISGrcbMO1tQTmaD0jTyIJd
	wGQZkIWyQioktjysnBplBBAmCHiJBTCVxDo6yRaFOvhEmlGkmuvDiNPT/tWOaLtB
	/OtSaKswwSP6oKZjK65FvLevzWI+DbU2INY4AJc5VxpsWWMh2sX9zHJxjski5EfF
	3jswjQEN3PjyoEp0+T9LOURLSfOBbslU6QuvjzL+wo8GN3KqlQwr/FmNu+bzlS7q
	m2I2Ten3w1q0Js8ZGG5xwL7o+pyp8iqeACNo3+IqNYOoaGGAfYV5NvM7IW0Lszi2
	6+FV7RXGHNHpGCB362fx/7mVPBVXfH49WZw==
X-ME-Sender: <xms:ypKKZ6G8Fu-SsAv2UXOxlrU4nfFxkVWGs6p0J7nehSasz2Q1trMPDg>
    <xme:ypKKZ7USiQTAuxC1qc1d38OFsok1yqt-N4_ri66zbkdDPh8RHF56-ZOJILWuqSO93
    1PanXvVQxojDnWYSw>
X-ME-Received: <xmr:ypKKZ0LtZ0EsPFYq-Sn_ZhS5gCfccAHzmKmB71YFv0cWqf_R43LWw3z-yV35hXNB22DD5uLbPpVIuvp67idcXAho5omlKwiH2Le5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhhsehglhgrnhguih
    humhdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ypKKZ0G9JHKwZm51HkkKRq2AAJzVC20G2YbVqJ-fR2kZohqaTB6g4Q>
    <xmx:ypKKZwW_3K1H8wCuACvr7UJAgqkp5AQWvizb_UZYU4m9QDF42Au9Mw>
    <xmx:ypKKZ3NvHko-foKievhKHg_n1_tACa32I1gXMXXwJQ_PiavSg5BLGA>
    <xmx:ypKKZ31XuNFZtMSDStTlRwg11Q18Ef8rkbHpA8wudfSfKY7klvIGFw>
    <xmx:ypKKZ3QwbONV3DvxBvlj1f0cIlwT3iy5NE-thRbt1qmSllZHsLsxfigI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 12:26:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] connect: address -Wsign-compare warnings
In-Reply-To: <20250117074909.1430067-1-mh@glandium.org> (Mike Hommey's message
	of "Fri, 17 Jan 2025 16:49:09 +0900")
References: <20250117074909.1430067-1-mh@glandium.org>
Date: Fri, 17 Jan 2025 09:26:32 -0800
Message-ID: <xmqqo705mjw7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Hommey <mh@glandium.org> writes:

> Most of the warnings were about loop variables being declared as ints
> with a condition using a size_t, whereby switching the variable to
> size_t fixes the warning.
>
> One other case was comparing the result of strlen to an int passed
> as an argument, which turns out could just as well be passed as a
> size_t, albeit trickling to other functions.

As long as the blast radius is limited (like this one, which most of
the cascades were within the callchain of file-scope statics), and
the changes of type is going in the right direction (in this case, I
see all are using size_t for length that may come from or compared
with the result of strlen(), which falls into that category), such a
change is very much welcomed.

Even if the primary objective is to squelch the -Wsign-compare and
even if we are talking about a line in packet_reader object, which
would not exceed 64k bytes and using size_t is way overkill, that
is.  I personally do not think -Wsign-compare cleanliness is buying
us all that much, compared to the amount of code churn.  But this
one is well within the level that I can tolerate ;-).

Will queue.  Thanks.
