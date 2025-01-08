Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD21FFC4F
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736356471; cv=none; b=cMWUN2jdT7jeL3VezCCh08nzQaIuwcrUP1Kg4A5ie7VPBiMg28wWFW/TrcCCNvgB/v/dbrM3dh1KOmh315yRnS4B70oy7gka4OYUJfkxk3KjbG+LiwgSIPc5hFNgGkquiX3VYRoSWSu7YfiYkDjNgHsRQmbvdgYvt+h2Juw3jZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736356471; c=relaxed/simple;
	bh=e4UVlG8rF437yFMagxjGQadmxWnn66tui47E6/oXHP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YNBJfXAwr8CF/dHBpyvB6TMxxBYWXb8lnskFYfFfRI4wSs8SkRLo3yh9Us1DbjSftvsbtvim9cHuZCGLLav0XF6K4mpEJMDrqQuayYDrVRVaKnrxnrgUCHEK/z3LQ7WumOk05Pv2X0GtulxtcFA6ccaIB9HcO95WJtvNH8EufBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=3cexjn2j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wylXNO7C; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="3cexjn2j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wylXNO7C"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 84281114015B;
	Wed,  8 Jan 2025 12:14:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jan 2025 12:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736356468; x=1736442868; bh=seH+U5rSfG
	TNZ+c8Yoo12eMdiSkgwdBCn5plu6CXoDo=; b=3cexjn2jUYl+3yCrligF2cxRrF
	Xr2kE1W3KD5SkIMa0KsAEXcN5lMV+yeWs8SQ6pMthf3A9DNNvRCSVHmgOzioEqeI
	1DQ38zE26g7xHpo/ClnixxUT3jG0bg4/SBtLBAytCg3/LKPfG+sL4wl45f699YWU
	Ppieo66rIbrUcPy5BgM6T9EKlK5mE6VZJF5eeeRwkVihMl/OF/RlO/gV6UEc5A3c
	+Sd6HnX0vmurqBTNuCMMSrwKa7tuzYcYYdxmi1h5uAQHRIrzkN4qsPvlrLWSWRuP
	v83byVLBJpXPD1EkEfdDQIoMrBnIAwZlVtVUDoprBrjTP62Wl8OlvRvirARg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736356468; x=1736442868; bh=seH+U5rSfGTNZ+c8Yoo12eMdiSkgwdBCn5p
	lu6CXoDo=; b=wylXNO7CMRztinHaJwzi/Llwhpjqc44QyzZsqHcWNCyj1Ut0hf7
	xJVP1TwvMSeDHH8Cu7KXkcJCM0IHTgfUI7mi+ojWC48js0YYDhT/qvlmCrymxzVf
	gnwvQXyl09I9Jj5f3ejR/3HFUemyFNdyIO8/HosLCmDOa9mJOkC9qO7jlkKYkcNT
	DoPUYhBXSu92rKMpoG2NpHG77gIE8S+dXYMWYJR5Ezvr0ojafeGouoIAYfyZQbtc
	kdbrzcXmuvpM9NgqKiH8KFLJGCfFoh0sF6JSJx51mnhCey4H4NSRNKyT4ahxb4So
	UQnOw4z7p4stzPFtM4/pbnDxHQZ2Xjbterg==
X-ME-Sender: <xms:dLJ-Z09z1bsjkAAx8EcM3Gkh8zIGc_MyiYZr7JNFFJ7mnySMD42cZg>
    <xme:dLJ-Z8suRdZeSNBhFnLi0bac35DeSlrVOmiQ8oH2AR9mhsShu2SKR-d5imd_lBgIg
    bbepfBo3GOtCqaDWw>
X-ME-Received: <xmr:dLJ-Z6CmA4heGQgtXs7VKnsObOLgPUkfFmmii5id-_I4yeqlS7QJ_l6b8VR4g6hhBaabSVKcWWbMblDpv6bKFy7doewQq19_KaUV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dLJ-Z0cepdEB6ilvU8YTPQTdHpi0inOsz11SWp3puzn7R3GXmANabQ>
    <xmx:dLJ-Z5NyOVQvkmC0oRV3SHrrJBDF0Agg2iXkY8Z1XMnSQv7Yb2hcYA>
    <xmx:dLJ-Z-l20BPsgCgGg-vynVtty5mUJVG2XrSy2oT0kcNCcucQumScqA>
    <xmx:dLJ-Z7uIAdrcRkjToUK3b_5JPMMrhUSpZv5RmYSnTP8W7xpQNDfh5w>
    <xmx:dLJ-Z83sU2qMgXr8vD0qnM9tC_reoZxk8av-TIDp5rS08Ub8gOi_CnaX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 12:14:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t-reftable-basics: allow for `malloc` to be `#define`d
In-Reply-To: <pull.1848.git.1736352005578.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Wed, 08 Jan 2025 16:00:05
	+0000")
References: <pull.1848.git.1736352005578.gitgitgadget@gmail.com>
Date: Wed, 08 Jan 2025 09:14:26 -0800
Message-ID: <xmqqseptmdn1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> -		reftable_set_alloc(malloc, realloc_stub, free);
> +		reftable_set_alloc(NULL, realloc_stub, NULL);

Nice.  By setting it to NULL, we force the use of whichever "malloc"
is in effect, and thanks to the way reftable_malloc() is written, we
do not even have to be able to take the address of "malloc" ;-)

Will fast-track down to 'master'.

Thanks.
