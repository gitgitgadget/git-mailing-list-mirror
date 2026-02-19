Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF2D24A067
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533455; cv=none; b=KHfbME7pCDUCTL4iW3LUntA8NvtsMv7IaCqNAGLerwehkrB9vPmSZkgEjzZo/aFE1vAhotUx6UyK8YcB2/rg096p5ml65CkccmCd3OG1AXc1er0DRq1GkLqH9ZjXDMdEbK1iJDqnZtu3hpo31W0FwXZdKJZmIQ37Xvi2LMy1UuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533455; c=relaxed/simple;
	bh=HIaL0VKFcClTnBQul9l1XX6iH3aL/HZD7ZxuuyJPNbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QBgV571fnBvk1B9fU32dfRv/7H7xw8cGtHIneVkcKEu1k/Q5TY8DU/6SDHIICbjqppYD/L94UCmGcuA2MI60x888R+9zpVQd17ZoUVLvqH2eHlEt9lkaoheW0uTdE/hqSLirJNGDVW8ihykrHlbcSwpmKWOJAaPU0UCgB/zAkzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I5O48RmQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AfbJxhOA; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I5O48RmQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AfbJxhOA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2410AEC023C;
	Thu, 19 Feb 2026 15:37:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 19 Feb 2026 15:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771533453; x=1771619853; bh=/arLemmXPI
	ylHkETG05Ad5lA6jCitCoPTsSrpNt7ZFg=; b=I5O48RmQRKBwjmtl88yMUYOtdY
	rYfyY0VBcP5MLJiH6/axDw9/GBcU23plxsGeHSNQwcPF9VUsSgf57roQ8bzCqLL7
	vZqP6S0xwXmf4SF0ZIkJkqd5d2dZeQZMuIEY731s2bnAbvxpjmdF8cxL5Z3FuJao
	jYqAoi65YuGGaZjmwIUXFD/D1HWpa4FSP8lCCCb4WzkRYo5NUPW0H+LrBmQt4nP6
	rxEVNTufzzG3FZX6vqOCNxAs6zl+Vq5t4gqpb8++47Ve6LvQQ/C4o4FrJf3cca03
	9OfPTdO1fXw0oaRDUfXM50z0UXVFgpB+W5hhQrQYSTj9jIc4/pvCGOrXDj0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771533453; x=1771619853; bh=/arLemmXPIylHkETG05Ad5lA6jCitCoPTsS
	rpNt7ZFg=; b=AfbJxhOAYrRBIReogac0qbUpkHF2ouMYTugeoK4ZVvtxzMKYMVr
	TqB8p4gFExtI/dlH5HMacnQAYdty0xUbBsxeMFoF+1oalXljfhGr4dcRBp8OlYcL
	zhmSkONI8yHKMIecO6htNB/M2llZDsDzHRxnBTBW3IW2GOw7AgQLN06OWIBjO8wP
	OdTRKH9bk9UUN+Tgi9bLpc+I/ZKUzadLCqSx2KNGB0CrfhMgdaZJZgOald+kIO8g
	Dy3dRMnsmwUeEtISIBw9CVDw6oBt2U9B2vCA+AsY7Psct5cbAF55N5wv1c6Z4Fm5
	ul2kmLMp23EV1Ec3/g1aUR3iOSy806RuV2Q==
X-ME-Sender: <xms:jXSXaY0OzFkw7N4kDiYOLtsTF5FNoaERhWQI7dqx1ObXrMHjIARX8w>
    <xme:jXSXaWwhYjixvtGHlq9loX0AcorQ2EglsyTZdoisrqe0UBVzIGdvhbnDauu-Gtzmi
    xLKb4JEauoudG4KTzc47cry9Pmk8d9bwIzXgvG_ajqV0Lf-hwnYFQ>
X-ME-Received: <xmr:jXSXaaudIuyLCkSb6UFf7396KG2vctbUFwYsh6A7TfIY4GvJOPKDiGyqDrXeCiCpGq5Mc7u5FFkFHvPigQhU4wYaBzRehD8S8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeihedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jXSXaYwz9ivEslRx20BYHBWx4_Y5IyXBw89yeevCgOjcVNNY0SnSjw>
    <xmx:jXSXadCJqT235oUy2ZlLPRdi83oTfEnFdrgffDx6wLZ0Wuh0ywvWRQ>
    <xmx:jXSXaWes8I3uydTfN_hpuZHxts-GgrraOE6d89cpemoN1M5ydzWxPQ>
    <xmx:jXSXaXloWvmhCKU_jnHZT7h-hp9Vnw26NzBPIbLz-POd9BDK46Q4Og>
    <xmx:jXSXaQgGtcOEiXpaI4x1E9SkP5yMFdL0EW25cjYrMlSUuHrcE8r2YBZZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 15:37:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Shreyansh Paliwal
 <shreyanshpaliwalcmsmn@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/2] wt-status: avoid passing NULL worktree
In-Reply-To: <xmqqv7fs4jlp.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	19 Feb 2026 11:30:10 -0800")
References: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
	<cover.1771511192.git.phillip.wood@dunelm.org.uk>
	<902295b87146e5cb5358cebab51f8d66701290a8.1771511192.git.phillip.wood@dunelm.org.uk>
	<xmqqv7fs4jlp.fsf@gitster.g>
Date: Thu, 19 Feb 2026 12:37:31 -0800
Message-ID: <xmqq4inc4ghg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> In other words, the function is_current_worktree(wt) may not take a
> repository and always compute things relative to the_repository, but
> once we wean ourselves off of the_repository, we would/should have
> repo_is_current_worktree(repo, wt), making is_current_worktree(wt) a
> thin wrapper for repo_is_current_worktree(the_repository, wt)?

Eh, in light of 2/2 of this series, since wt knows which repository
it belongs to, what I wrote above does not make much sense.
Allowing callers to give repo that is different from wt->repo to
that function is a potential foot-gun.  In other words, isn't
is_current_worktree(wt) using the_worktree and not wt->repo a bug
already, I have to wonder?
