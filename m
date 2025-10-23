Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33929408
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248654; cv=none; b=Jpe/7Bb/cr1t2fzPmPNOgP8N/2xzo97LKw7upGJQc8qggj3H12+ceD4RLFZMeEFzOEU1J5TlENBselkzJQGq57afndwyuSF1/h/bz+7vnrWWwHTp06IemYTQsVAzhs4qEr2oD1hVmBKon7SgAkEMKl29QPWwHyI4K+ZtNzS4+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248654; c=relaxed/simple;
	bh=C6j8M50lVs/rNcJt0ea47md/HyjZWIKV0aUyLyygr0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m2IAr/t/hHxr8xhlMnUzTLa/40MDY/Ta7Y1Vg7tuRvRsgzMEfzsIDJsEkcHiu2LsoqFgpkJw2zA7Mkh2t8NBtKLvuexZBnI8IjeYVSNmwpwteEJnoc4rPaOvQlwXlu7Z88Ixp8RfbhaGAPp7pzNkg/7W+rMTpg9z267lgUf4tkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZoREX7pn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IdKuheRK; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZoREX7pn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IdKuheRK"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 584C07A009D;
	Thu, 23 Oct 2025 15:44:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 23 Oct 2025 15:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761248649; x=1761335049; bh=HnCH3SBUGM
	Pgkump+EqpD8cYtdufLF2HoK+xtdnfcu4=; b=ZoREX7pn8D8UlkcKOusy3xpGTn
	jOoWBL43dPrvUKj1JLsjR9441h6+oEgIxClDuhUKe4rJGnv91fSal5KbcD4ES+hv
	g6H5VCdWeh4ydXwymFSMEFo7W8oHQX0QH+wE366pMlKuM+YYI6NCPCItjQ18JLJo
	0OaMDrm5OsHvP/j7vu/9SqWEpI0oDtrkUi3XxNhhIhc27v2KRyXicm57GGITO5Aq
	8sL1jVMvqRYdgRlcXVAW1AkFcnGU7YKi2UC8sL03Jzp8mbuKBLRJmcuYxjv7PZfj
	WJIEkd2RBKgExM4uIzlNBA2QNbmq3cbajz8Nx+uLQksjkitpiw6KlYxxeWGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761248649; x=1761335049; bh=HnCH3SBUGMPgkump+EqpD8cYtdufLF2HoK+
	xtdnfcu4=; b=IdKuheRKhdLDK32jhnv88vYLLb25v6z26E5S0a8t3wKx9MNKYba
	FHi3+o4nQc3HqGYfOaVguz91r0TlpkUEM05+BvjYPmKgq2LI3JlW7eoHoPGo/Zw8
	bynCmc2T4CL/Nnp0FNAlv8N4KqX5bBAQnlP56mmE2ZqbyQahjLXTzBJLMG3jgb74
	rZ+L4I0gNnFESslt5/b+IJhU+vFTaoYfwQHP8nuMovlaCu2++FzSZ4BmwamK7/Kc
	Zq1Bob+f1o7N9nMd8z0B0C5XxyoYMmmJvrH83wXGNYKPGuO3YnC0AxYzrRUThjAO
	JFepa3HrFeHFflkEdQDl9ZsWIa3rg2q28OQ==
X-ME-Sender: <xms:iIX6aNOWVkvUQ1XYiKAr_MOyrNZqrOcxCzjGT-fZTvz1PTpCuZijaQ>
    <xme:iIX6aG2wEP9iJztzistTMPWWz9EIvS75JUGL5Oq-Zib3gIueWcas6xVvF2Uax0uvH
    bGNquU5cRbV0MEUaCKmiW8O4YZa8sPCoNfXqWtFix8NYop3loeYWg>
X-ME-Received: <xmr:iIX6aEmfK2YeUD_cGEVoSHuaFmBTbkUpxSzUjqyxTuZ053bKtb4CmUTazQ4A8g7mPlo4XPq8R7nmDmmPARSXyGaEOaMwsoXWcOKb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:iIX6aFWSm1zgeSbDi49MUugtFhQlExPgxI_ig8-eLzTGyjYtH9OgCg>
    <xmx:iIX6aCtpJwVtkv3SZPWP60ZfR9kDtArt3QaP0_S6limJZivnDuLTKg>
    <xmx:iIX6aAbD5NvuOHUNKIF5fHRm1QVCpEeJUgdQfktN4XrfR3_hG2eklg>
    <xmx:iIX6aJW1X3vhvyebRCdhBa-CpGwSNcqFaxlPQ4xfpS_eD_JeuOX4mg>
    <xmx:iYX6aIHpSmTKjib1h_bdCInumayHS8bC7_cv-5c3zblS7sPPZXYgwX5i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 15:44:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org
Subject: Re: [rfc] flip rerere.enabled default to be "on" at Git 3.0 boundary?
In-Reply-To: <CALnO6CB3EZkAyc_fWdU+P_MLcipZ4T90RSk0+46Fc20OmWEpmQ@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 23 Oct 2025 15:19:57 -0400")
References: <bec27479-c53f-472c-87c7-374321108ad5@kdbg.org>
	<80220653-7302-4E4D-99E9-1A8CB5B4F23D@gmail.com>
	<xmqqsefaydfg.fsf@gitster.g>
	<CALnO6CB3EZkAyc_fWdU+P_MLcipZ4T90RSk0+46Fc20OmWEpmQ@mail.gmail.com>
Date: Thu, 23 Oct 2025 12:44:07 -0700
Message-ID: <xmqqtszptnco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> Was this intended as "another todo list item to work on"? If so, I'm
> afraid I'm having trouble decoding what the issue that needs fixed is.
> My nth re-read suggests that the sharp edge here is "delete/modify
> conflicts often need re-resolution favoring delete" and that doing so
> is not easy today?

It meant to add to the list another sharp-edge, which is that
'rerere' does not even attempt to help you deal with delete-modify
conflicts at all.  Either it needs to be communicated better that
the users are on their own with delete-modify conflicts, or a good
support needs to be designed and documented.

