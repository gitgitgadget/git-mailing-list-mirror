Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED402063C3
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736521343; cv=none; b=mUMv3pewMRn5yulpfiyHew+8+OoQVYClYS27xX9qQo7GdgnXzus2pS1VdVO9RovSJtGSW+mqTnzqrNOb74yc5HKM5RlFlnS9qNKo4VTmCSFikN6eWAnW7FR4rPmz9soGpKD37u46VBWRPcyF/He1EaIeGgr6S+Zig1LyByyu12A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736521343; c=relaxed/simple;
	bh=Ru37S6S+35BG3O1w9mP7mXYLq5kE+cfAml389rucbz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a6ymULD9rdNMNH/lxbZ2077N5nOS4nEjqRZ1AtEu/cr4BVUYqyJgp4dKAQqJnqd1/WR3WstVHXtPaUo0C08cDzrLmqhiKe501frcS79RCCm2kCj5ahB/ePwVKUUeRkqrxRkkEt5nErg2ARloXXV8g9HqD3zoRLuSCSNKOWLylPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pOO3Jsux; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AiKT4aFe; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pOO3Jsux";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AiKT4aFe"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E3B382540116;
	Fri, 10 Jan 2025 10:02:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 10 Jan 2025 10:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736521338; x=1736607738; bh=Ru37S6S+35
	BG3O1w9mP7mXYLq5kE+cfAml389rucbz4=; b=pOO3JsuxDVll6pV/Gntg4UulPv
	ZwaMEXpG+qzH9uHgBCCnFGfVOWle4m9nQ0/xVp9jncrX8v1xNoxQdUNsFq8wydl2
	cveTBDU6vPQNbyDZn1TwXYjud++mUkv09XPyXam6AD3538na8GYYIpwHLD/1yAs6
	XxPjp4Lbb1pgyrIkEsYABIZ/7gDuL+Gmt9LMLtBh0XuHGJqnaNJSsDsChejkoNRq
	Npe3mU03ebHC8MUbyM4/HbwE3416fjmg+MauIcT/Fx1nPbwiJhdQDi2FM43I5tWZ
	Dt/468KBVxuvAijw8Brpwp+UFoQB3oToBLZzAOvuSbrsbB9R8z5kSsK78xZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736521338; x=1736607738; bh=Ru37S6S+35BG3O1w9mP7mXYLq5kE+cfAml3
	89rucbz4=; b=AiKT4aFei9PmgW+WctnY+eTJxzRl6yASyHfGLpCe2Hm2GIi68+2
	LQh66TsJPoyM5OerePp2SkYYfRA+K9stIiO2PMpywgWtQ79ah0cALpt0Pnt1KjTm
	eipaRYBBTr8Uru/lyL3IyfQrmQx5ZAFieTtlUvgzoMtK3PuGEsJhz1Bd8IpxRzGl
	uHK+XnSLWsilY5JhVP80uu4iDL44XQeCRvs0gxRltdnnjvDxf7U85AJL+sg71bi0
	yUr6dm6ppEi0aOBliFaH5kk5/HGqDjHppR2vE70vZmP8AWZ+1wXZB84XOM+yad5n
	Nn5ff+xhpBnk+kkAjmOiwh7+fucyDrA/Muw==
X-ME-Sender: <xms:ejaBZ5CwZ650t_kDYKEqFTXhwQULp6iHir-KLnKVRWRuRXZwN5keGQ>
    <xme:ejaBZ3ipfVeB6fqfxvMfFVlE1NUus5JUDdMJkGf0Y_aRyqICgPDEg_5NefOSm3W3g
    2i6s45bY9erMOKRnw>
X-ME-Received: <xmr:ejaBZ0lQw2h0fNwGoMpCdJdWM0nXR_-MtO7TXdNsLGpCaxdCuDAVN5P-3JY_l-Pggp3vF4gE4JegaCg7Xv0LUVCJC__dKa08Gnei>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehstghhrggtohhnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopeihvgifohhnsehr
    vghvihdrvghmrghilhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ejaBZzwxequFCkeriONwJ_fst5FINlbhA-dI5JCSiheMcT2SKH8XYA>
    <xmx:ejaBZ-Si1nJ5_eoyBv2LLMr5BDuIL_ajxINtGcg2abKfM35xuRKw-w>
    <xmx:ejaBZ2bP0h5aA5XP6gbnR1LlXON5aOn6aVWfOmKHDTpedN5eZ49bQg>
    <xmx:ejaBZ_SDvZ5BY9Dn0Qj0U1QlW2cGDOx_ugQ44nbmsjCbkstmqdVIrw>
    <xmx:ejaBZxHd-hgTmDrvmAcSWsBD5x592p_A0VR0PMX8SO8DUgksmjuPTa7X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 10:02:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Scott Chacon <schacon@gmail.com>,  Scott Chacon via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Yongmin <yewon@revi.email>
Subject: Re: [PATCH v2] help: interpret boolean string values for
 help.autocorrect
In-Reply-To: <20250110121100.GE1014503@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 10 Jan 2025 07:11:00 -0500")
References: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
	<pull.1869.v2.git.git.1736419777235.gitgitgadget@gmail.com>
	<xmqq5xmoj6cz.fsf@gitster.g>
	<CAP2yMaJzHM+AyDwjfVNJrDeJt0iip5h_ZxgNJL3V-gVSOjoBWQ@mail.gmail.com>
	<CAP2yMa+5ca22tNMc4qu=yBVd9t74uNnLFbKE3_=EcA5_goM6zw@mail.gmail.com>
	<20250110121100.GE1014503@coredump.intra.peff.net>
Date: Fri, 10 Jan 2025 07:02:16 -0800
Message-ID: <xmqq1pxaaf0n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> It's not corrupted; that syntax is allowed for boolean variables[1]. The
> "bad config line" is due to the early "return config_error_nonbool(var)"
> quoted above. It is passing the error back to the general config code,
> which then just prints the "bad config" line.
>
> I think what Junio is saying is that if we are going to turn this into
> an option which accepts bool values, it should accept this special
> syntax, too. And that first "if (!value)" has to either go away (and get
> replace by a maybe_bool() call, as mentioned earlier) or has to set
> AUTOCORRECT_IMMEDIATELY itself.

Exactly.

Thanks for filling the blank in for me while I was away from the
keyboard ;-)
