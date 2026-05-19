Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B842D8370
	for <git@vger.kernel.org>; Tue, 19 May 2026 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179368; cv=none; b=YvtV9JdPRAXO5bQkgeF/g/MW/Z+Wl4MmJtI02gO9LXkZMMAevcVXR/bARzZdqMKGuu0JWfha66Hf9Uw8Nj1Px+wXFm16Hjht/fHl4WGS4E/5wA0jcVK3vq9CrYntWLZSzVZw7JBsSo1R9AUg47OUTnGidy2L2c8pGJZ2X/b5yBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179368; c=relaxed/simple;
	bh=hPkA5Urj1FOUN/rRsJR4YAls1Y1Yw80IGOKM6rQRgJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LEz/xPYh3HxwuVfDGfbVv/9UocCaJqkY33zDNWajSPxyWH4pyLxK5SRXLMJm9OAoRpltjIQe9P503utaRwSbpRw5c/SL/S0TQXNh1q8e9PXdLZBo/+s1f69Doxnrh48/qX+0lu4hNkpQb9850B8ZM0ZxS9FTYmVgRi6Bkx23N/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QO6okhbV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RDqWTSMD; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QO6okhbV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RDqWTSMD"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 48A327A0109;
	Tue, 19 May 2026 04:29:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 19 May 2026 04:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779179366; x=1779265766; bh=aUZzMFJPJQ
	QC3vXKvDR3Mw61g1c3psIJ5SNFBq7NzC4=; b=QO6okhbVPVusUNKiwfd3o3rBLk
	QUJTVcSqRUqRDj5LqMIX0c6LJKnBWYVursAZp0QVTauWdopTvC8ZEr8gP1C7j45N
	albBhhETCbqTC7mYj1jHdZt/3AiRIE2lx4FszCvNwgqE5drfD7md/yTO0TOvrkYo
	anyCGqaZALCi/1+3X6eKTIscexDpkvBtV8EmLGS1aCmR2oINVFt1P0c014HyjMby
	CUkUqJCX8/xd18k+T7F2LK+0nm0mQd/1t6F323Zxx/YHhlcIypa8GwAYneMwZjZk
	jw3/0w305+LM/wur+1tMVigcclP5vSth1N2MiyauR908QDt2kwmpi/iJ6k2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779179366; x=1779265766; bh=aUZzMFJPJQQC3vXKvDR3Mw61g1c3psIJ5SN
	FBq7NzC4=; b=RDqWTSMDqvVasStiMf20BAv6a372H1yqkayPPfRIJ9HW0shwIrZ
	ooZOISuPHVOawiRZm1UiM89f4hZRvJUmWb8rdKp5Dsge4r8BqwrlRJ/M5NEJrLZR
	ywGhbMHHWkLR+I7vWMSA93opcrrjK+MKtlVGlQBXfzSVoGnN4Kgh99Bb8jkF7tHY
	C6OMG3hZYDlt/1DGWTBHhSnxyzZo+QWabwD8W1mSFArOoJD8ZLYo59XzegEIo4Wg
	FZCd/XpOuNZQ8jsyO4F/hU9RjYslQcz6SVK7w9FTta1hBthURHixDOljwhMRi9e1
	sjY8hA1YrBKC6FEhFcvjgmuAxU2V2MdaxGA==
X-ME-Sender: <xms:Zh8MatCpiczt67BsiQ0IA3iAJAP_P6ag4Qo3SKEEgmlnFRztcPtv5A>
    <xme:Zh8MaijuHBTdw-EbJJSuFgWoT0lF5A4ZI-NCyjoS4mYPPmZfIT5OqrWl2Q4bgwHPH
    MiB46fSYTxnf5lScbD7Yu7cFoxQthwQr8Yp2xhq3j2OxoDwbl0ngAw>
X-ME-Received: <xmr:Zh8MatlkEzm-ZcjbXuZo4aqYjuzw574S_1S_Q4oAVA3EQpJY-D9L6DPSj6n0rj7pfXPD_W9tVUmsru-AKwGMKCxAPaDPwva0fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeduvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Zh8Mamr0CLkNnE4qAPud80ac7c9Pse6ttw8j98oixBQCYcm-i6QmeQ>
    <xmx:Zh8MauGCYL8PRg6ovU_ZFuXXRSsi51nSTrb5ztuO5MSCrcl_-eBabg>
    <xmx:Zh8MaqwtsEXWs-ktjRXQAlVoHuZJTIOEb1jEA6g5GJZOZ1354i1QTg>
    <xmx:Zh8MaroNh7_5P-jGTJrfD_ImABsiaCNzhph-iVLyzX9lQdkf0373FQ>
    <xmx:Zh8MarQKxCnKgzI-7Fm7BF4b1E2plZtNkpaqxFkDc41S5yljhQFum01q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 04:29:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] remote: qualify "git pull" advice for non-upstream
 branches
In-Reply-To: <pull.2301.v2.git.git.1778665812261.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 13 May 2026
	09:50:12 +0000")
References: <pull.2301.git.git.1778623888178.gitgitgadget@gmail.com>
	<pull.2301.v2.git.git.1778665812261.gitgitgadget@gmail.com>
Date: Tue, 19 May 2026 17:29:24 +0900
Message-ID: <xmqqbjeb7qfv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> When "git status" reports the local branch is behind the push
> branch, the advice suggested a bare "git pull". That follows the
> upstream, which may live on a different remote, so emit
> "git pull <remote> <branch>" instead.

Hmph, shouldn't this be done conditionally, though?  Most new users
follow the recommended pattern to set branch.<name>.merge so that
"git pull" would do the right thing for them, I presume, even when
they are using triangular workflow to push to a different remote
than the remote they pull from, so the new and more verbose message
would not help the users any more than the existing message, right?

Can the code tell the situation where the extra part of the message
would help and give it only then?
