Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73B2080DD
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215175; cv=none; b=kxGTgT01cm8FAMj2r8SdQ6M9KGbzKBBmf+seeTcXkxmv2FHKN15wzAiTMkiuY8hHQsTTCyXQTXx7veU3FGg2b6i7Kpis225Qw7ZX1QdfoML5uv979lUx4Pd/dYyuZ9O6USwUtw7W5hmhs9CSwYf7hwKY9ukoNlwwt3qyML23du8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215175; c=relaxed/simple;
	bh=XVzDj9Kq/2eWFzMOdc9j8T0IUI9HCd7vsV+wHTdomeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pUYnv9ZHQuzkvB2Xt2hZOHIyT82gzYrxkVDiXC0uvkEx+54Xk9xaJ6bA4MBcl0dKEROunj5y3KjxWtWcIS5YqSVbhpMdFmHAk6l8+ZWkPJELJ3N7MbPAqfeE37gVhA/0wLgZus4cygldmKrLJv8eDW2bUD/hpCh0eDLoZPnEuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mm1LZaOK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V0WfvKLS; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mm1LZaOK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V0WfvKLS"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55A92114018A;
	Wed,  5 Mar 2025 17:52:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 05 Mar 2025 17:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741215172; x=1741301572; bh=kurElo++m0
	S2AKAMhAD5Zgq9Eyd+sMkCDRGh679Jbvk=; b=Mm1LZaOKzrtIj8sM9wuhweniph
	+AhA8iQR/WBBoW0OGVCDVxX9gjkQHM+lUWjDYyueQ+Ljeuq8xciwrYr1Q7P4Tqub
	nU97L3zIzpfpOXwjWxiPHcCCqTAHUYS0m2kLKjGcauq1vwGnliWDBIDA7Mfm7ImF
	o3Fyn12NLi+L+5S1zdHl+8oNMKnRRkos1i3p7arSJWjgRrUjQDlPhBjQ8LbFrw9o
	ousOSa7+29/k5W1q6R6WqEJySmLuKyKnmXI7PwMv3SuKhdualR1flPQQHeISQQNl
	3viwXgKSm1So3AgDj5yfKxFimdubo05PUD/Fst3JXV85tgNz1VUgbO1qqK5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741215172; x=1741301572; bh=kurElo++m0S2AKAMhAD5Zgq9Eyd+sMkCDRG
	h679Jbvk=; b=V0WfvKLS9KNasS5RqnIuoERWGWsex+wvJpuInNA3QK2fXIksN0z
	Y0xEHBDfP2L6tIdZW8gR6b0hzFakw9CXUS76dffFvapW124qlEwvE1Y/EgksTQEJ
	mExUKFOZiI9Jki7Z2SEw9xLIC2v3Q3lOYHJXLoXwdE+p+b4QQoKL7xXI/nAk8TcL
	zBOKhlnvgwOzCKE21s3GzMHlP7cUREII10AGHiOuRknLwZfiNP7VGKopwV5ijrA0
	nHJ67/hPgQ0o7MDzO6pNjNaF1fzV0OBUo8w0SWEyH6iA+65u49+ylftXxZmOheMf
	2l3E6iaMibzA7xCLeVZ7UIe7loL50kX9nSg==
X-ME-Sender: <xms:xNXIZ3Pytx5CzB8kVFaXdmA_RiBeSFVCCtEypo-taLe38bJccBBc-w>
    <xme:xNXIZx-pH9y5EgwGY5xuoORSlWky7mzN7HROfzLQBB4r599XYKdX13n7-XVmMFfg-
    a_U0_1ourpR-jBiqQ>
X-ME-Received: <xmr:xNXIZ2Q0Ye1O2Vz0980XU_y5Lbuu7Qf_-YVZ8MKqakSk8S9Ru9_3OACXw7H4Usinhw2LkTOlD9QE45Jbi_gFpRzlJP4ME8r6M3ny>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdeitdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepthgvtghhkhgv
    nhihrgesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xNXIZ7uSiLAb-9yAY2pNnBQxJFWLgaTc8w0DT8bI-h18e4OY3J1TOQ>
    <xmx:xNXIZ_c_oohlhxSmTHMk-BT17DAzg9Wfe395FDm5GPf-oz9TzDDqyw>
    <xmx:xNXIZ33CJ51ea3HKpR4Cq6aemtM5wXOY1G73chd6Tx2EgF18Uh7cXA>
    <xmx:xNXIZ7-ug8Y6DuPlesng9HOiDYzK0kvyyUipWA2cxKkOeqGSXbanMA>
    <xmx:xNXIZ262DpjKRUNTd1DciS1L8YPcF1HbQfNYVhCTwUbWzDz9zb4wpmqD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 17:52:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Tech Kenya <techkenya@protonmail.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: Suggestion: Enhance git init with Language-Specific Templates
In-Reply-To: <Z8jTjt1CQ7hp8KSP@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 5 Mar 2025 22:43:26 +0000")
References: <qMn1k_iuZCe353x0BBxdD5z4-17Abk_ZHoPr8nVDLOgLhGf8Nxb3-bsXPH2GiATUsuGLVqAaEESua5G9qBaW0qqxwz-7AbcNyRwSXJzbKMs=@protonmail.com>
	<Z8jTjt1CQ7hp8KSP@tapette.crustytoothpaste.net>
Date: Wed, 05 Mar 2025 14:52:49 -0800
Message-ID: <xmqq1pvbks3i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> What Git _does_ provide is a way to create a template of objects that
> should be in the `.git` directory using the `--template` option.  It's
> possible to create a template that contains an initial commit with a
> `.gitignore` file.  I personally would not recommend this approach,
> since it will not work gracefully with alternate ref formats or hash
> algorithms, but it is an option for people who want to use it.  This was
> in common use for setting up the default branch name before `git init`
> added the `-b` option and it's related config, so it is well tested.

I wouldn't have thrown objects in the --template directory, and I
wouldn't count on things outside what the mechanism was invented for
(namely, .git/hooks and possibly .git/info/ files) would forever be
copied in newer versions of Git, but certainly "git init --template"
mechanism sounds like a good escape hatch than mucking with Git code
base to teach it myriad of languages and their dialects.

Thanks.
