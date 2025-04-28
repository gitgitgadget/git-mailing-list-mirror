Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B52135AC
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745880032; cv=none; b=RLH808asrh3FfHwLoknj8VR7tw20/5ycbQ89f3aJKTQo3XteWwRlaOUqeHjGl2fUnJv8F5OhmJJpwVMbYes20xf7EpeEbiKbhwp+AXtSob0C7+bQnkF2LjnrxdW44fQBl4HNOelyXV1NByUogBSDrfu0BIxJoXuniqECwF4sRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745880032; c=relaxed/simple;
	bh=G5c6LjT0X61flw5w7dkvhW3NFDMcWgmXgNXw1fqOUr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WpkFn9DuXzaQd5O7FfF4r4cT4ZD6fXKqqrtNaVWhon7pM4VnNQg0IC7EkEThyFlhjeSpGiQINwkVkwsPefsEyKPlVOrU9CkM6DxGHjoqWQPZbkuoWKeAFbu4LENIse8gJe0mpIxarkz5rmy5Rpqdfs/19jV0+QNbBBFo5DXdZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cFqvvHPY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBW98CgA; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cFqvvHPY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBW98CgA"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 06CC113808C2;
	Mon, 28 Apr 2025 18:40:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 28 Apr 2025 18:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745880029; x=1745966429; bh=oXAtUD3e9H
	iwfUZe2E0N45NN4A6lwuxsYlI4S8+jEKY=; b=cFqvvHPYfukdDdFjbhbqPwa2ff
	Jz+SUtfI9wZQEhF+ZWFlNJIy3VYvoqwWJU17f4peINOG0pOEVIoMUIaFfTTfK7b+
	AossbpKrODSEpyb29cY0f1Q+WO4iij6PW0NqjK/pkH4u2s6nNsSnBrhEqcYY2Qmk
	Gwd8I19eraofsfMLDejjUS5TEsMiRMZ8SijiGT31huXPABvfwoiC9qfSOi1YLOIB
	9l0V/OvdMz4tVevsHjEhWbveJZR6fl3A5qZkQiU+gsSeNBp6roQhjLlCCIglJxEd
	t4F8cGLzKVutnNX/UoTpbYCUUTq/PVe5ZUe+C9KranpVCQ5VAMFFAgDle/Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745880029; x=1745966429; bh=oXAtUD3e9HiwfUZe2E0N45NN4A6lwuxsYlI
	4S8+jEKY=; b=kBW98CgAqciyGEeaZJKUasE2+dwvAxeW6f3C17SviBZtdDCgxoA
	h3Bomvv0zlTDnmbTRKKmcVvXpduEl+FHfWs3E6knFj6QtikqbDJwmyC9/MOMwPLl
	YUYXLKa1CN9VhiFjiBNd8IWIuVIdauJn6uM++Zvzjs4CL7ibe6oC535QTuvlgcxy
	l04uEn7dFDMbgnMITgWh+3TuunCQ8mwbeXhZKTGoSz11plAE5RvHk94kdKnEh0/x
	+dpsCOS2nfEsILbfaKQBAvkGDqpaSAFNAKpNHsuIM6BgFHFhbxIDprF5OTOzB3QU
	Pa8S9eQpjr2KWbgBVpgOpwKbZd9HX6lsaNQ==
X-ME-Sender: <xms:3AMQaNJps_LIom9WSWCNL1geUw6W_bKqFVaU0SxEqnVoplq56Me_nQ>
    <xme:3AMQaJLWBHn-3XmXau2emyct2Bm_GFrT90fDIXdpRvqbm3T9S-n06nEvshpoHXo43
    pIe5W9eVhba0qjB5A>
X-ME-Received: <xmr:3AMQaFvgzkFIcHghAy4REhLsDJjCLNRHF6V41VhSDL_CYet7iHlksmdTIHUBaKFDlviZOwhEU1obwk-7kQymlg5ZtE3nnx3DVqRu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedvudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3AMQaOa0buX20tYtEOQPZBXoPeRAUwBmvgRa4P--ExErbFagKbj5uA>
    <xmx:3AMQaEZu9ZrbFEPza-B5hgv6Vo5IOoVBOjxNpdhWK5b7WEZJ9nIMig>
    <xmx:3AMQaCB0AVkKQTK5rBxn6q26tm8ExlKGrphi2O_-Jr4Sdkvh5rINgA>
    <xmx:3AMQaCbDEHQnQ2BHsUVHbDq8UOojklJ_K79GUuME66mEeRinShcplw>
    <xmx:3QMQaFk0dhL8oZJqeyoLmGhNJLFSWq5SBAnYAhYCfNx49GMAg9bOBIa9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 18:40:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  Patrick Steinhardt <ps@pks.im>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH v2 0/3] Fix REF_DELTA chain bug in 'git index-pack'
In-Reply-To: <pull.1906.v2.git.1745871885.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Mon, 28 Apr 2025 20:24:42
	+0000")
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
	<pull.1906.v2.git.1745871885.gitgitgadget@gmail.com>
Date: Mon, 28 Apr 2025 15:40:26 -0700
Message-ID: <xmqqecxbap0l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Updates in V2
> =============
>
>  * Fixed a memory leak in the test helper.
>  * The test helper has a better CLI that makes use of the parse-options
>    library.
>  * The test script skips the in file and instead feeds the input directly to
>    the test helper.

Everything in the changes relative to the previous iteration looked
quite sane.  Will replace.  Thanks.
