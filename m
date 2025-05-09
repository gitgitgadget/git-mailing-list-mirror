Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14E101E6
	for <git@vger.kernel.org>; Fri,  9 May 2025 01:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746753074; cv=none; b=EmaWjon2MJX+YOZdgpQoQtV31PtqPjOjTjNe36oppYuS7h4jlnPnImkdJ2RlzE+nHd78AAjplprexd/ApNf5r6+uLCT2rgmExW4cIQqNyfcw5mADSsEbummcI0BIIVdVe1tQNKgTHbK6kMTu1VsBqeUvFkUtuswFbgGjQsVEt/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746753074; c=relaxed/simple;
	bh=WWsyY8ldYG4AzlkleUKE7ZtTCB4FMPthQkQ+DBrr6CA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RuG1BkD2xUyyfP9spyLWDgvyyJP+FFPX2Denc+ptHh00/iE3ng5d5jJJMHh50uL4gnxnB8is3QWSbjqA1LkSMO6VnlUZGiusAkTVJVuDQP/TakAVp8H0hGmr+bYu5zJ2j84+RXw1sdJ/ZroJxKsZERQKLGS3gwigVoVeLjdaapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UvXu6K/c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cz4NwC2R; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UvXu6K/c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cz4NwC2R"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF5D6114019C;
	Thu,  8 May 2025 21:11:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 08 May 2025 21:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746753060; x=1746839460; bh=N86PuJEjnp
	9ajP7Od7ph/p56e24c1ZpdMx7wudXlOqs=; b=UvXu6K/chmyx34HsP25x0P8Z51
	pWgzC6ZSGjxNnx9vZS9AGnjtHJQrSfrA6csulGgnLFvwOQ/EibXtFyVHpRPgizS9
	KpqAOXp7d8Bd3zZtVxASYQ8gUDTHCMYVKHRXyKZhVIgyYLqke7nGKeZqsaevNoFE
	m2v1C3jTYkGMpTPh/CivpENW5H+CR1AWV/sL6PIR9VZLAMQX4FHsvzM92VhLtdFX
	3dD34PFA/I+MdTaD4h/VtXn9N/b5zBcNCXaZmDP599dPEFxvHshPYGdE1oBwUt9v
	LGAyunc7QT0R0yUHVIBAKpHKH+R/mnvyM9aweXQHtejpLJ0XXRfb8B62n6nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746753060; x=1746839460; bh=N86PuJEjnp9ajP7Od7ph/p56e24c1ZpdMx7
	wudXlOqs=; b=Cz4NwC2Rx8OJ9tGyZvKKsRQuPEoMRxjm22VOaMSOF1lq7am1J1Q
	Tzn92alhA2bvmPLZl5Ca8SEx44SUiA6XD2sQIEr5xX+d4++c5B8EnJ3G2DewPnem
	+2Im17HiLnk50LHYhzl90FpIf+as5PnQDbHPY2N7s7dHrE82yLBZEwicgY9QyuXd
	Hi9fbJZvZuiuLGFwMKbLg9fPhFAhlqzk4m3+InqJ1t4EdhZbF4/VFhZhhaKsfW1X
	cen/XQdHi7KOeUZyzMXcKkokZEcZFamdff147Zcv5Cqawbg7CWOsKpqPKIqMd0Rl
	6YHpdiCPEOi7au3MoeOMjaoy9rq5a91/qYw==
X-ME-Sender: <xms:JFYdaHaPdWxbm5OKH6Z60HYlWjXH1BdWSWa0ZPHorBD4HQA6CPTCAA>
    <xme:JFYdaGY1sKlWbn9tBb_WYiLdCeoVXdjxLzR_c0wLfgvuZYzXI6WRz62DwtsjsUXZl
    LR604wJtkgE0XB_pg>
X-ME-Received: <xmr:JFYdaJ-4aDUZQKTOq964uGXM0KlWex24w0eYngosPEs5_Jo6QXugpTxSptrPXCpC2R5jK7Z3fScLSinnQ8z5yfRbLaIx69P2J_6D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:JFYdaNrh7CwiKcOo9XuR2vjso1fBrlXeqcFLBdWYSIeYIf14wrWB4Q>
    <xmx:JFYdaCrKAXEnXK0dtuRfQZXXa_ThMayp-qcTJvD9eG9c7BCjAGVUwA>
    <xmx:JFYdaDRsAwVsAUEb4KeO0uW5u4nqxb1eEijcQGkR9rxRn6cYcTtb_g>
    <xmx:JFYdaKpbOYBIYwH39f1SWSnaWJktEMhoCCPbtlkW72gua2Zjo6lGyw>
    <xmx:JFYdaL8CAF9toDQc0rWaLZ2GNZD-eu7pT5mcjM7tS3sHN6579VJMrjN->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 21:11:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 0/4] Importing and exporting stashes to refs
In-Reply-To: <20250508234458.3665894-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 8 May 2025 23:44:53 +0000")
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
Date: Thu, 08 May 2025 18:10:59 -0700
Message-ID: <xmqq8qn64mho.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Stashes are currently stored using the reflog in a given repository.
> This is an interesting and novel way to handle them, but there is no way
> to easily move a stash across machines.  For example, stashes cannot be
> bundled, pushed, or fetched.
>
> Let's solve this problem by allowing users to import and export stashes
> to a chain of commits.  The commits used in a stash export contain two
> parents: one which is the pointer to the next exported stash (or to an
> empty commit with no parents if there are no more) and the second is the
> stash commit that would normally be stored in the reflog.
>
> Original thread at message-ID: <20220310173236.4165310-1-sandals@crustytoothpaste.net>

Thanks for resurrecting the thread.  Once this part gets sorted out
and the outside-reflog representation of stash becomes stable, the
next logical step would be to teach the "git stash create" and
friends to directly work on the new format, perhaps?  But first
things first---export+import would certainly be a logical first
step.

