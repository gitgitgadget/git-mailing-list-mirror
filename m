Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABE223311
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758308539; cv=none; b=BrbIfBN8FiYNzuGv+vkdbTQGfMx7dGldXufN6ZcfZIkmQ5Ndzf31qBEssA7GxO3ksgtBkiYG4OsxjfMVqG4hZwiOwQ8SevgN4ZJDfYf1Rf/ypgPUD9Lw6x/Ac6dEfR/zSLR56TwuntiEH5/QxeEt4CXgL3QNdbPBdXl24wRYZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758308539; c=relaxed/simple;
	bh=wE3Wpd+UX/RiVXHCGY3v1wgrwEpYdBtEm3ymQxRkNUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ovoqf5WaZpNmkpjm61HREM7Szpjb+GjiVO4lhGzUlA6bny3hSpqZefbzdhH0VyO3DVJv7JAanwfFR+BpMr/8YcYhv+woAoz3hNgLztvOzL9qUCT+V1nJhLkxccaSwOTBQMngzLQ4mZ79pTWJ9hCm/62NOMH8OSYAAzjEJ9IPza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FZworiBt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YrPuGQ6R; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FZworiBt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YrPuGQ6R"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E67721D000DE;
	Fri, 19 Sep 2025 15:02:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 19 Sep 2025 15:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758308536; x=1758394936; bh=juiLxL0LgU
	jDyoTHmG+UPIusttFbZkEUeUsywy4Fn84=; b=FZworiBt+ywUX9x+dEi87tvszI
	UrUB328CK9pYeT1IvMF1+xWW8yBpToFXCg4Thxy1lRjXM1o6GaRb2HvXbm4VLkb0
	VweyLcuOj5CsINiTuD+yDVpknTZIJN+4iDXJSySTM+5UMXpJPU/omouG5Xrx25Xf
	bNCQqApevFv5ERurEnsVHEPIs0Tb0dCwGECpiSOtJ2TzWJhnOafG+HZtnspTaJfM
	1ZFeNKH81bmjEidsARyFtjU5WU7U/bY4LK3JBKr+Fv+u1LdCtlUYTGqNuLLB4V1l
	6UK/LaY74j4mw1X9VyO9jxtU1w8nWgGfmjtjOP3XJiEfeGQArsvM1J+aKPPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758308536; x=1758394936; bh=juiLxL0LgUjDyoTHmG+UPIusttFbZkEUeUs
	ywy4Fn84=; b=YrPuGQ6Rx9wVWYGoMX2LHJ58FcddP0mC3BAsVMtHVuIZvKQwXOD
	aj16FKIfDTb2W64QYDRv6NWdu/+7jzbidmbKfwVO/TbimJ0qqTd213v4B9w7HpWu
	Brjutb6g2ZI0kGdxJewUQauLY656wmQFTH0T3AMUoWjJou4DWQmMpU/AqOy4mn35
	LzNlOcwoeT2moNVfbiLuyTm4uIzLDkZxA3TPefZRrLAqS69cQmYzCb186KSa5htj
	j90MdKqrxg9EbQqd2P3PgLMoBC+6ZOmSc68NkpuZIRLPL74a7icJNWmao1vptcXz
	Brh7uskfdoX3k3UiHQqgZjdi7ydn27mRdHA==
X-ME-Sender: <xms:uKjNaAiJhCxeMIWYVgsjovS0GZLGAyz9rBGmaeg4T6gpXgBpTXI00w>
    <xme:uKjNaDmW1bixmwLoQj1kJiAGK_Nz-6ZX9U5RRcu8tzMKWozq9636VCMHVXJsODDzG
    fvNtnneE-WLurvvwA>
X-ME-Received: <xmr:uKjNaEo6lFtpAXyZBzhJ8FYzfS5bN3mElwFe0Z1zw8mH-Vc1bHmJX5U5R02jtbJnkOekOuE-AoYUR7kLhtmXbQKpY-fGPunjnmSmnKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uKjNaEGD9L9xyGoMVLpWZQTQ4bBEgjSe0evBF7vECn-L9nnaEWxodw>
    <xmx:uKjNaIyWihVwJKw8qPw0uzlDDYLFUeK4H9qzgrh0-N1D9QU2erNPKw>
    <xmx:uKjNaBr1PmhgS3-Qp-aPqM-VNqezqYx8ESXdHkBxrXwCQfagTLcG1g>
    <xmx:uKjNaKieKI6YI1_TPbyZdn0Rzc43bb1UhOK9bK5j02P6gWft91Qq1Q>
    <xmx:uKjNaJRoDX8PsdgMz_lSZMv-MwGahebBnEQdFm_JlSa1q8WCso-8g4tv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 15:02:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 04/18] make: merge reftable lib into libgit.a
In-Reply-To: <3061cc46c1910bdc4f66855db7a07d313b37fb27.1758071798.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Wed, 17 Sep 2025
	01:16:24 +0000")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<3061cc46c1910bdc4f66855db7a07d313b37fb27.1758071798.git.gitgitgadget@gmail.com>
Date: Fri, 19 Sep 2025 12:02:14 -0700
Message-ID: <xmqq348i5kqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  Makefile | 39 ++++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)

Aside from the comment already given about the fact that the
proposed log message does not explain any reason why these change
are necessary, this step and the previous step are fairly hostile to
merging the topic to play well with other topics, especially given
that there would be topics in flight that may want to add, remove,
or reorder these two existing lists.

I wonder if these could have been arranged like the following instead?

 * Drop "REFTABLE_LIB = reftable/libreftable.a" and the target that
   runs "ar" to mantain that archive.

 * Leave "REFTABLE_OBJS += $objects.o" lines alone.

 * Add them into LIB_OBJS so that they are included in libgit.a,
   perhaps a single line like this:

	LIB_OBJS += $(REFTABLE_OBJS)

Wouldn't that have worked equally well for the (unstated) purpose of
these two patches without incurring unnecessary risk of mismerges?

Similar arrangement for xdiff.

Thanks.
