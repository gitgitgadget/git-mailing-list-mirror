Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009C716D32A
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743291411; cv=none; b=LmS/isI/DYd1cWKeVAQU+2QorBsx+oGQMj1KalqVR1Uk2tgtyrj/FPwFz2wqZXuRvN2ZpL24+2i2f3Bkaq4kffPLbO660SAfDDsLGD8vEC/hP5cHYLpTRQ7j13ETlhlnBEFnSxhWc8ng3Ac2XE1EgOuXc46CQQb7sbvjRAIZbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743291411; c=relaxed/simple;
	bh=uwM2NS2PmhA7gEZ00mbT2i1kzdMf5hV6RvRUEKKwXPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cTBx352fyr5BWhKzrrK5IWIwKxLSiO7gSNhpK1zGcNAj50N3o98SvQtSeUlPHboowY3Yt8UzrvirwRnDQ6WLgWZjxI94BzPpd03zkloZZZhEEb+anzAkihYDSEV9cu+9EZ1zmCFQOey7n4aPGjknAg9zBN8dQ4bthBJdOP6P03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ux4cb7H0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wpbaZFJC; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ux4cb7H0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wpbaZFJC"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D15681140104;
	Sat, 29 Mar 2025 19:36:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 29 Mar 2025 19:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743291407; x=1743377807; bh=EzwVoGQtQ8
	KOrW8gNlLxH/JWWhAMhcNpxvty20rMq08=; b=ux4cb7H0Y/ye6IF0bbMZDc1180
	bOG8ToQdcxS45aLV/ghoNgd2YL/0DikO95eSv5Rjt69XDAY8cmy27jfVnQZ6L6cG
	TUyuHCMIHp0GFehgraNYOX3nLk+srnIZtRU2WkHOcbTmMTtxxglM55M8hAmCOxnI
	ig1tDS9h+iG1Ml0MfbpFtM6N+ZLnI1jgnEJ36MO8sG3kn0ZjvVGhhiA5V5UBg/CN
	CscER2aliaaO4C1xOATbWP7i1AogqQjk8Gq7/5rJ1Z2M4Co87gz8Gmus8lguEoSi
	bvjXJ6PFZYNWr0vKTLVaDzRRs3+5ZpPhcoopqngg/JNBxLI4UZovBGtvIlHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743291407; x=1743377807; bh=EzwVoGQtQ8KOrW8gNlLxH/JWWhAMhcNpxvt
	y20rMq08=; b=wpbaZFJCM+Q661KM91b+dllr97ImwX4AYW2QqhpVK1OGc228R8U
	U1KkxVQ/AuyzRdxqlYUtrFs1Pi4fxYbWTLosWFZXyVZiXwUGm6dKc5U9GdyvzPNJ
	xn++9Z9p3syyi9TOa6O8dWnFv5+nOZZa0rKDwhJavbf3vhGvjpc6cwzpZtSq7ZU4
	OyYlBwRvG+C6cxnEnG1uGrhRVYmmtpqT13BZwZylvghWoHWDWx/UFOU9s248hg01
	Vqnr4v7dHk6w+DNgnxP3f92XML0LnobjtZrBz30jvxItLYOMEJ9+yh1DXhttZsd/
	/cSAi/hrulbqz/B2Q47pnuHR4KXPggVxlLg==
X-ME-Sender: <xms:DoToZzegp0xFuAqizZkivJfSuFvX0r8zlkR-0jc-n_-5dPLglO3-VA>
    <xme:DoToZ5O9-ukyZATZn3ZUmayFZyDNKLeWzSl-OHyJHaCM1OF0zpaBN1ek_4PxfMnKL
    i8TZZpJkr12Lh_3Mw>
X-ME-Received: <xmr:DoToZ8gh-RqcYa3zH_1nR5InjT4pul-lguRkgqgkS1Rf-jLSd33X9lk9BlBwJEN3pyMARbjGE1-Xd7Aw-bJ0qCBDwOl20atBbyKxJZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DoToZ09-sCl8ECm2DAxt1Wps6hztz9eafCWuTn9bV7Ek-wShOoESAg>
    <xmx:DoToZ_uFuIBwJLUu4qo4vSA_qGuqnyyzFp1NVIxxF_N3g2ltDFT7fQ>
    <xmx:DoToZzEqO0X-pLNnyM8uLbPDi8sOybyBWS_HX979MzS5JIfnXOxxqA>
    <xmx:DoToZ2OO4nfCBpQf9o4o-Rf_i6l1ILl_P24SbKmeoST1pXGXTUMzhg>
    <xmx:D4ToZ5Jm5JC2YUPQOYtboDkqqlmJh_3omlCsn0POfClGgp7Cv7S5meEW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Mar 2025 19:36:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] merge-file doc: set conflict-marker-size attribute
In-Reply-To: <pull.1895.git.1743173140253.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Fri, 28 Mar 2025 14:45:40 +0000")
References: <pull.1895.git.1743173140253.gitgitgadget@gmail.com>
Date: Sat, 29 Mar 2025 16:36:45 -0700
Message-ID: <xmqqv7rrbe9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When committing a conflict resolution for a merge containing
> 1f010d6bdf7 (doc: use .adoc extension for AsciiDoc files, 2025-01-20)
> my pre-commit hook failed because "git diff --check" thought there was
> a left over conflict marker in "merge-file.adoc". Fix this by setting
> the "conflict-marker-size" attribute as we do for all the other
> documentation files that contain example conflict markers.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>     merge-file doc: set conflict-marker-size attribute
>     
>     Grepping around I can't find any other files with conflict markers
>     without this attribute set. (If there were I think my pre-commit hook
>     would have complained about them as well)

Well spotted.  "git grep -n '^<<<<<<<'" tells me that the
git-merge-file, git-merge, and user-manual require them, but this
was a rather old line dating back from 2008, so it is a bit
surprising nobody caught it before.

Will queue.  Thanks.
