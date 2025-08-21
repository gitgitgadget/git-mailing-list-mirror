Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54CB3728B4
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806907; cv=none; b=GbcDjnvhGY4NO1MkVu6890uOD0hNmSld9lsVYRD42VgjUNKBI2kjQ8oIDz1uNSbN2nKp6dT2sJBf6CP2Yqv6RfIwcFAnDNOVYqg3GHZaxdbIkg9PQIvXN3ZL2K1SWUrbWNGlC3OxOQH/D6FWuS0j7ojQK1w7G7THKGJ4qN3iIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806907; c=relaxed/simple;
	bh=lfCgUFaUElS6hBzftuu1dmrja33YIa6/+JCaiESpruo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pK6uhnVJhrhVgOxZH4E0SAsa16ezAB4ju1Y9jKVhN1ABRcVmvxDgu6lK1BNVeq514GntUPLdpLz6IQIQc0qpNLAfnvuf+vQKhGWHuTPq0Yg4rBuZdjvsDM7pfIdXxJK9YTY9hrL/893XF1nF/V4ef7JDr91pfaC+uhTHTbcurCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lYDVMXlC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JlwceUV6; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lYDVMXlC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JlwceUV6"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74AAE7A0133;
	Thu, 21 Aug 2025 16:08:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 21 Aug 2025 16:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755806904; x=1755893304; bh=eCQ8DnntpU
	DxK7dXgPAyS2j976n1xigEplzWQ5o4+so=; b=lYDVMXlC1RXa/qGg1D+WtJbmAs
	VIeLaOw8F8zSxWQTRjcUL6JWX15sv6bx+Cwr21JD8ZMwLxZrIE7F1OS96YZeC4Wf
	t6D77MjXdVdkqMD1HwHNVbCPuG0vznRBvRBDR6Vq1Z9tveEybHaQSlw/Fw7m9Utw
	LmxDwHwi7Cffk6fjNDOdh0MP5SxpJXQ0RDUMQ695woGVEzGVK8qwyyndC8roIznU
	BXoEN9+t4RQHM2JK+8eCIQ6/5UgBjzZsKS5Vd9PdXmNqCkH1zyhLt2hCYKNrVS/6
	GLINRPomwOVXXJbw8mKrEEV51jzYbJ5BqlwkNgbcPhtWInsKZ/vC+oErobwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755806904; x=1755893304; bh=eCQ8DnntpUDxK7dXgPAyS2j976n1xigEplz
	WQ5o4+so=; b=JlwceUV6esHVZ7p5H/BZaPJoPo/nRTusBA0x/rtF5/+HL8IGtU8
	gUu1KP6IgLOz6+tyGVvgkOw2qOP/vrPWdFCZa0B6uTwhVXpxYAMUto2WqOTLxwdC
	gx/Rc/m1bszlq5CjICMTfuvh7R6oLTn211uCMlcCLf6XMEez/DpzeeOs+QZI7gcX
	PZ2QqgoX4U2xJpbcvaIBHt41xI1U5D+9RaXBSO7kAcSekjw6V0LAuumjtbYyLzeB
	lFcGMkQkAh+mYiJQ9X5+m3WEODuOeqLjum9qACC6YVDAdb69Y94UDAfhoqlIGVv7
	cisMygnvbK8toeKzNqlE9JYk6vEpOxSptfQ==
X-ME-Sender: <xms:uHynaBJU50MvwJrU2A8qsCd67_B9YqYfmjUSaV17wuyCqyJgn6LFAg>
    <xme:uHynaKvT4sYLKWBo06VmsubNTF6HZTxVN7GIOOerR_M4606e52C4GMzc_PfgFh2VD
    NwidgwWEo2DtWuZiQ>
X-ME-Received: <xmr:uHynaAIwE3P6sPJUpXFLU0zn8uiziVJw-nitT_36iLiZnI8h8w1tcoRRyAnQVnK3vwlKFJc3jsRvEljYNmZsBMW9Xg_pgpLabF6-ySE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgv
    vgdrfhhrpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uHynaD8R2oF3-tbqN_xPqb6WcGpwNWDLYTiSOWKsuEMC0yqd0dFC8A>
    <xmx:uHynaJxRuQ9IQUkCkXSpeHeGAW-QlRHdbA1qP6FNb7i_REVMI7nggw>
    <xmx:uHynaA5D5Ci-S-LJrBX-R3PSogiZg-g0Ml_mRutI3_ccrJO-16LnzA>
    <xmx:uHynaA8cwAAW--FiIxYiaD6fHLFVwCSV2U5lCqBx4NGJt-2ZW7cBeQ>
    <xmx:uHynaAmt6HxuJgfWmzPRdnA5wWhppVki6LTbqbVbLKQSvjgjxKMGv2it>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 16:08:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chris Torek <chris.torek@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,
  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 2/3] doc: git-add: clarify intro & add an example
In-Reply-To: <080720c059910c910161e250cd7eef54208c3fc6.1755636370.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Tue, 19 Aug 2025 20:46:09
	+0000")
References: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
	<pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
	<080720c059910c910161e250cd7eef54208c3fc6.1755636370.git.gitgitgadget@gmail.com>
Date: Thu, 21 Aug 2025 13:08:22 -0700
Message-ID: <xmqqv7mgzbd5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  DESCRIPTION
>  -----------
> -This command updates the index using the current content found in
> -the working tree, to prepare the content staged for the next commit.
> -It typically adds the current content of existing paths as a whole,
> -but with some options it can also be used to add content with
> -only part of the changes made to the working tree files applied, or
> -remove paths that do not exist in the working tree anymore.
> -
> -The "index" holds a snapshot of the content of the working tree, and it
> -is this snapshot that is taken as the contents of the next commit.  Thus
> -after making any changes to the working tree, and before running
> -the commit command, you must use the `add` command to add any new or
> -modified files to the index.
> +Add contents of new or changed files to the index. The "index" (also
> +known as "staging area") is where Git stores the contents of the next
> +commit.

Much nicer than the preimage text that is quite awkwardly phrased.

I however would not say "Git stores the contents", as it is you the
user who does the storing.  I may phrase it more like "... is what
you use to prepare the contents for the next commit." probably.

> +When you run `git commit` without any other arguments, it will only
> +commit staged changes. For example, if you've edited `file.c` and want
> +to commit your changes to that file, you can run:
> +
> +   git add file.c
> +   git commit
> +
> +You can also add only part of your changes to a file with `git add -p`.

Great.

