Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484CF23C8A0
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744412288; cv=none; b=Naw7wTYY/54jeliQvrGrEkGHt1HAzuj/j7Ay7XUx6oXix/j/u04cP24zUfxz0quaXj0rkCIl6YGrXM9erw4s7FC7ltrRkGUGh2+qFRRa0XaJp9stmcaPnBwH9EzYlRRkXHNDR96CJFBn8rsSJy14MYPcvp0PWcBQs7UGD0YUcjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744412288; c=relaxed/simple;
	bh=h/8yrP/6r3T/HZNOeKfK9a5YL14X/+bW6MktiUQmIkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mn1g25gLOtYqtYsVFktfzPkMMca92sUTu+h+XVN6zN9EiO90C2/jw05MdBqyS1FPDwRhcn0j7d9C/zkEU8wqI5NRQB9G+7jMe3n7LF6DkkcruPrzurtF0X4IyHHcfaQ061lBX585MNrNvYyxuVlhLvLFufQPVJjJu/TUEVdCUJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FRRSYt3z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yz+8xKxl; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FRRSYt3z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yz+8xKxl"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 549F313801A2;
	Fri, 11 Apr 2025 18:58:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 11 Apr 2025 18:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744412285; x=1744498685; bh=XQmnYdV74J
	eqB5PimplUylac+ePF5mQ/TRz6bap+sEg=; b=FRRSYt3zCSRyKwZ8iwkvEKj3JH
	lCqgd6MZKWrMYmmgzUi9TkyDYNVb0oMxoNDDt9ruFovLMHv4pK/Orq0t4/cluyMH
	Q0kHlC3RZh/e7pSV3SgJVMizJSendqBIVrvfY+79DHBbBcW7gBmsaC6vlU3OQwJl
	qt8KRfx/K6YnBSwJyCDFvWGqoPbGKnNoLD6Z8tzPeqa5IgdPtsV42DD2H10LhXSy
	QwBbXeYUKzPFlN+iFhNxgTJ1FUMuX6lgQ/QqcrvsTd5P23za1MsaZGvUdWSajzPJ
	AWk+3algJClh1MR3uRcgsCEn3sf+EpaHB+N2RK4rci/8/MRhDJOTwP2drCzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744412285; x=1744498685; bh=XQmnYdV74JeqB5PimplUylac+ePF5mQ/TRz
	6bap+sEg=; b=Yz+8xKxl9fqaONll9UxbpkCv5Is95JeIi5ZN1uz4cuS0+TDlGM3
	IzZGlUpy+ZDZpHqM31hailGQ5y8qEJGV7jk6rmltpi7w9NaIk3c06/RKnDwNWtAc
	csC0jISGRUCvxoO6YzCZkzbj8hPJlCXRqCfMBQFVFLlsaO983C9TZ8PZbmUqgHQE
	TUyeOVHAutiY/uqR+S3hfiLmjFndsU7wQxF0JUrKLdN0T3Oai/S0aszajHbpd6RA
	9yfMJs+dgcGVTUxeajFC7bqnPuXUCsH9ez2PXjq0Vx5RwCTifxNf5UEwuU0WQR5A
	ql4rFroLl2a4kWD4ZEsB6Sp0M2Lpu+L0YZg==
X-ME-Sender: <xms:fZ75ZzJY680ROkMf0PQIwO-sDwjYLtCAqHlqNXUF7IN2FlW82Bv15g>
    <xme:fZ75Z3KVfxA5VnPYLv4setSAmyOerN-A18cWp16Anq1VhCV1tgg45I2X7FxjGD5FE
    XI_swKJnn_t_H6rgw>
X-ME-Received: <xmr:fZ75Z7tlDz9SyrQNbr50bAdu_YbFkE3hXlkN3ptwlQBBu-SzZU-gy9XSKsikbLYvWxJmFKQHT_Vrho2ludF1UcAxJ6IEIQDi9M95>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudeftdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:fZ75Z8a-O-YZB-G9yaV5WnPugwApbR7pNcPFeTF8c63rve-6dbo9Wg>
    <xmx:fZ75Z6bioYNqGJVNJ1ltSDeWylj8q5d4lmD6GmDKg2cvwtcz3cgykg>
    <xmx:fZ75ZwBBfeNfHP6Ai_Iwuoy6pMXxnInN6kmzrLundbpu2m3ocjuHpQ>
    <xmx:fZ75Z4Y-WMNhCGrrnN4v9mIWJP5SL_r1EqM9wKfI2rlL7OAg7OMpow>
    <xmx:fZ75ZzkeYu4qdy6lxn0xV1uSZ3r5L4cMcwPxfDKHqfyGAsqh-5ao8KPP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 18:58:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 8/9] object-store: remove global array of cached objects
In-Reply-To: <20250411-pks-split-object-file-v2-8-2bea0c9033ae@pks.im>
	(Patrick Steinhardt's message of "Fri, 11 Apr 2025 11:29:57 +0200")
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
	<20250411-pks-split-object-file-v2-8-2bea0c9033ae@pks.im>
Date: Fri, 11 Apr 2025 15:58:03 -0700
Message-ID: <xmqqtt6ul30k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Cached objects are virtual objects that can be set up without writing
> anything into the object store directly. This mechanism for example
> allows us to create fake commits in git-blame(1).
>
> The cached objects are stored in a global variable. Refactor the code so
> that we instead store the array as part of the raw object store. This is
> another step into the direction of libifying our object database.

While we do need some execution context object to hang these virtual
objects, once we decide that it cannot be global, I am not sure if
epository objects are good home for them.  If your application
running in a repository needs to give one object name to a virtual
object, and then that same application wants to access a submodule
of that repository in the same process image, wouldn't you have one
in-core repository object for the top-level superproject, and one
for each submodule?  If a submodule commit bound to a path in the
superproject's tree is a viertual "pretend" commit object or if it
has a virtual "pretend" tree object, don't you need to expose these
to both submodule and superproject repositories, if your application
wants to seamlessly cross the module boundary (think "git grep
--recurse-submodules" or something)?

For now, as long as the_repository is being used as that "execution
context object", and not a repository instance passed along the call
chain, then the globalness of these virtual objects is maintained,
so this change will not cause breakage (e.g., such an application
may want to pick up the virtual object from the repository instance
for the superproject and it may find it, but when traversing down to
a submdoule, the same virtual object may not be found in the
repository instance for the submodule it descended into and working
in, if you make it per repository and pass repository instance
around along the call chain).  But eventually somebody will start
saying "let's remove USE_THE_REPOSITORY_VARIABLE", at which point I
am not sure how subtle such a bug would become.
