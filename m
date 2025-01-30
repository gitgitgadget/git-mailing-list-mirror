Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0CE3B19A
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738260291; cv=none; b=flfLt82XVM8Uqwzzw41LCayaq60mExlW1/j8HQkdryF4KpEA5ewm4q6NYvwnjR1Sv3cyFQP3InwHoZQQz7vyV6zLGeqSY72GrSO375LIdHQif7LwecKaBT4Ht+6jXhQ4uCFbr5qaWXBqtXBYMK9N417e+Q+aGnd0aBEXGsr5Y+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738260291; c=relaxed/simple;
	bh=6mT1qQdwmOj2bKXi+fJF/wBU8UHwSy2hB4ZD89AZWFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gsZk/DiY2zHh57kPOy7+P56TCZOYa5eEI8Ubt5D3OGkzp9quN2cQZn5MxIc21leSp/NQ3PFlM+k/74qzDNFuLHlF44OraBK14SvQC+wCZAnMWwx/Js9Vd/rNtFvpcAxrumgd35+kabcxsLOrcMkLFrAqVbLVCzq6M0FC0f28h1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NLOZew3/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E9pJbzcn; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NLOZew3/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E9pJbzcn"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 40C9E1380178;
	Thu, 30 Jan 2025 13:04:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jan 2025 13:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738260288; x=1738346688; bh=0DDGzisQfl
	jskn9+IJFGLY7tVk5yhryYM5npU0YThk0=; b=NLOZew3/QnjgiDBPh7zo4b4zgC
	Wk4SgSYQtlzpY1YauVOddYZw1H0cfEAXF0RO/o3ULatG3DFqTtLc+dfOCFTfSQFD
	WEU1Q66p269NXdkiA/TmAtIKuOPBLFONR5i4LV8o0BTiUdDaE3+XLfhSHmePUY28
	lRdEs0UBCasgimo+FrpmaY7IFeVXykb8j03giQ4Y8gq4cAYZ3xXYdkot7hrcfXYj
	4gaNB+zDHzIsCFpui+eySp7D3nT7efuFhywKaWNTgYJm7BPZITMS0zUfslDm8jhd
	WWaV6NFL2dbW3s6XbyPsGbO0kFN5SWiu7JkEzy8m32+kAIvwyOARAO9LJYeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738260288; x=1738346688; bh=0DDGzisQfljskn9+IJFGLY7tVk5yhryYM5n
	pU0YThk0=; b=E9pJbzcnAsiO3vR0T55HXc3C/0kF6B+A2lY65Vs7jQQUqVHs7gN
	XMzo90UgvA27LBLwiKopuYmw8ElxXJQcOVvXIOUiJzV/BHCXtNfJb3W6MC9NNdVN
	eWxGel+Uw2RXH5lM4wyjFsXz3875sNG1iQGFgXb2jd8icTAfPHZp0i63r7yBAb5D
	ArUSMqqIb+dGUda0zTiYQ5Fi65tJwt3trDIWjwzCpbYqAPXtl0iaA9C3M80WG5j5
	Qi3YDQ87XGfAlKMzga1usYWrEBbzq58AKG4v5b3AoV/YK1LjdE0QQvWlgOS33BeU
	ScqCQWv7GYO/eMp09QnCqjgA53JmtZkBvyQ==
X-ME-Sender: <xms:P7-bZ1N2Urw43ZWYjtg2-KUILwJArRqywmIQweE4O81nKm1_NVxoOw>
    <xme:P7-bZ38P5ZtM9kCXhKlW9svxRXRYpnza-YYIKHuuNijCGcBwETsiyDkMOZA40h94j
    wlZ66UJNNT_lbu8Fw>
X-ME-Received: <xmr:P7-bZ0QL6I5h0qwCKLbR7P42KLD35ZVml_D28LpBwiV1xB6qUw22aSVI8jDDLkhlfTNM1PsqnzAvN22v3rHPDlljrs_Iz7bHLLAK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhm
    ihhtrdgvughupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QL-bZxtQf_JV0WHntRDNjc3kuZNADGsGUOSJp90QyEAO6NDTkJu72w>
    <xmx:QL-bZ9chVSFVMaHiV3FEdYaEVysaRs4YF_bw9hSoJTcOOviqZOGTWA>
    <xmx:QL-bZ90uwdJTFp4Ppk9cyQBlcz2JkGb21zFHpo-B2INHX06R2O_tsw>
    <xmx:QL-bZ58TtZiyfrbPB_J14rJuewSmyw0OzeX1Uw7noqpU3S952LW5Hg>
    <xmx:QL-bZ1QW5t4_LOs0vsTAxAFvN8i1zh3u5FXoGwy4it61adAUIznxzK8Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 13:04:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 2/8] builtin/refs: get worktrees without reading head
 info
In-Reply-To: <Z5r679AyETgMO5Ge@ArchLinux> (shejialuo@gmail.com's message of
	"Thu, 30 Jan 2025 12:07:11 +0800")
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux> <Z5r679AyETgMO5Ge@ArchLinux>
Date: Thu, 30 Jan 2025 10:04:45 -0800
Message-ID: <xmqq5xlwfa9u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> Although this behavior has no harm for the program, it will
> short-circuit the program. When the users execute "git refs verify" or
> "git fsck", we don't want to simply die the program but rather show the
> warnings or errors as many as possible to info the users.

"info" is not a verb; "inform"?

I can understand what you want to say with "show the warnings or
errors as many as possible", but giving errors on the same issue
many times is not what you meant---rather, you want the checker to
keep going and discover errors in many _other things_, after it
finds a single error in "HEAD".

	..., we do want to diagnose a broken "HEAD", but we want to
	notice as many breakages on other refs as we can instead of
	dying after finding the first breakage.  Dying on a broken
	"HEAD" done by get_worktrees() goes against this goal.

or something, perhaps.  Such a rewrite makes the sentence "Although
... short-circuit the program." unnecessary.

> So, we should
> avoid reading the head info.

With one reservation.  We still want to diagnose a broken "HEAD", so
I'd probably strike this sentence out, and add a statement that says
we still check the contents of "HEAD" elsewhere as a substitute at
the end of the proposed commit log message, if I were writing it,
after explaining the use of get_worktrees_without_reading_head()
you did in the following two paragraphs (both of which read well).

Thanks.
