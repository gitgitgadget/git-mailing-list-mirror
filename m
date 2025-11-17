Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E42949E0
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763420266; cv=none; b=UdQINKKA1yTy5ndgUk118yQCM1pq11CH1aGKwAig+kXS70u8ktf8FTgfwXK0yd7uGS8UMltrGap4P42XYFM/AlOQsMOwk1xTrizlLJ30oepIIBuxVARejkr7jNs5Gh5lJ5i5HLXlq5JdsKdmBwsfaN/SKtkhZUiCWv5QXnFg5dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763420266; c=relaxed/simple;
	bh=JTHaSUksoo+mLklq6R/PuwadsyRzTS6CCXi//f2URfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rBccfzBdQYwnRVYuprnohATYAGRlyqJBdoXSgTo1k3GTSZ44j+Jp6STxPGApa9yA2TR44WOuFZc965y4jeYWBMPu6nq/DfuhTQr+Jz2NnMs6qXLiVeZSXT0kp9WSP01XdrXGDJvCDC41ZXcOPdmOm0tYoAZP4aDEHstIF5LvCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e2EakhzL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DP0tEq1u; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e2EakhzL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DP0tEq1u"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3384A1400221;
	Mon, 17 Nov 2025 17:57:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 17 Nov 2025 17:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763420263; x=1763506663; bh=MdrFxUu+wN
	3GGB2D5UINK4jjY75uZG/yucbjHLyd3iU=; b=e2EakhzLyHm1xlRqlzE3y61vwK
	aTDbyyx68p3AProZYtvtjtj3j7gUKq/sXrLjSlbq5JM/vR6AdC8dZI5sUIvUwSYj
	QteYP8g/rDzmU07duX3fEfAc5WA7JZAUBwTC9gTMTiAcbTPpZRN+YbJis7eeAtZs
	/i3yUxsslslSXzci9Bd/L+Qlz6m3Z9461oWEbzaxSjPZWSyvb6XAYm8bgjAdl4BT
	qnzDHkdSAkpsU44XGy8cOxNlpaxh4cKxWIlMuQahR8s5lEU4u1wcMXwlWu8KuTfn
	+WmJFaTXnJcLUnt51KYX+lJ7ih5UUF7NU8CD9se8JTkdn/x0V2BSnGbifdvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763420263; x=1763506663; bh=MdrFxUu+wN3GGB2D5UINK4jjY75uZG/yucb
	jHLyd3iU=; b=DP0tEq1u3Uut8EfhXkwhgyjbXbADoBPQ0qdwVX20P60sSBsUWbZ
	NRUeHVcWjgQJpL72uGWlC9i4pbt/xrbb5VTsrrCbV+yJhHZd1uBiCyPlIqOcmTLY
	m43O7KcY+IlwvfqlF+juulx3hsgzVNlwn0ngdI/Wv6Iaj24YnBNEE/e4vAVAZB/O
	z1fOrjQoSisGOR2CAo87HF46OslDFvfPPfPNQLYS6W8mTlDJO0aJI6gZhApM8BYd
	KRaCiAI/CX5DRsy82D6FuZUlZRsTMTOrGEPOUYnSOLRWDBzH42NLqgX1ooS6ya8L
	SyrJn/f/Yd1FF8eJPPgU004OxfrtNGVORlQ==
X-ME-Sender: <xms:ZqgbaR0QBIy2C9F5jaLLAXTDBRpywagQcExgNeWiIQivwAE58SdPLQ>
    <xme:ZqgbaarKpHeNy6UoIRl_GIe3olJOsJBOxEnf0fZLc33NZKPuMwg3yr5bJwRYT9SJw
    RHy4_1KXT-GXmcatyvKG39Wui0CmzpCLU-hB5J7pge5fNnkKYADiQ>
X-ME-Received: <xmr:ZqgbaVjbFMeDtxy_ZPKDwlPFEgLTA85-xHAKR7PgacAtcyYCcXFq7AhlenQ2FT2wg5ZNTOlpIVMHy1cr8kiknkO7bkfoTN4b_nvy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehmshhutghhrghn
    vghksehsuhhsvgdruggvpdhrtghpthhtohepjhgrshhonhduudgthhhotggrsehprhhoth
    honhdrmhgvpdhrtghpthhtohepjhgtuhgsihgtsehjtghusghitgdrphhlpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Zqgbae8pnxO0s9YTumlDNIq4csWAr8v3mB3AQZAFXduVj--em4NmBg>
    <xmx:ZqgbaZXERcaP7fgWoetzpHZIpjXOvfvVQlo435Wx_Xd9ymVRmr_Kqg>
    <xmx:ZqgbaaBHUJsTjnaFJY-QU8fJ5U9VTV9ek7c-1JBQFlFsLEQA8ZIhXQ>
    <xmx:ZqgbaWE7D9LRi0I3bVv5pqpTYvTkX7LYWom3t9TMpQs_Vwk32yJuOw>
    <xmx:Z6gbaQ97iLIVd6lSzzclrkjTAKqRvIZ2Xbcjel_2E9HjjwPIsdD5MXvo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 17:57:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Sergey Organov
 <sorganov@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Michal
 =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,  Jason Cho <jason11choca@proton.me>,  "Jakub T.
 Jankiewicz" <jcubic@jcubic.pl>,  git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
In-Reply-To: <8cc4ca72-c87a-acc1-e200-53be14d649f8@gmx.de> (Johannes
	Schindelin's message of "Mon, 17 Nov 2025 23:36:06 +0100 (CET)")
References: <aNuy1aab954D3rJ1@kitsune.suse.cz>
	<E311F5BA-F88C-4C3D-88B5-F8508B106D41@gmail.com>
	<xmqq3482312r.fsf@gitster.g> <875xcyfk3k.fsf@osv.gnss.ru>
	<xmqqa52a1h6x.fsf@gitster.g>
	<CAPig+cQgZijWi8VV1_QScKPhm9cqhQVvow4N-VH00R4oO1m2xA@mail.gmail.com>
	<8cc4ca72-c87a-acc1-e200-53be14d649f8@gmx.de>
Date: Mon, 17 Nov 2025 14:57:41 -0800
Message-ID: <xmqqikf8gtcq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> that main worktree after verifying with `git status` that there was no
> unfinished business to take care of before deleting the repository.
> Because that secondary worktree (which did contain unfinished business,
> including a carefully crafted series of commits) was now obviously no
> longer a worktree but only a tree without a working `.git`.

Ouch, that is a tough one.  It is very hard to interfere and stop
your "rm -fr" based on what Git could find (in other words, your
"rm" lacks the "pre-something" hook).

Of course, an argument can be made that you should have also asked
`git worktree list` if there are other worktrees, in addition to
asking `git status`, but I wonder if it would have helped to have
the information in the `git status` output so that we can always
trust that it is sufficient to ask a single command without doing
anything else?  As "separate worktrees" is a feature to allow users
to more or less independently work in each separate worktree,
without having to worry about what they are doing in the other
worktrees, cramming too much into `git status` would degrade the
end-user experience and it takes a fine balance.

I think that one of the reasons why the "outside the working tree"
layout is recommended is to prevent us from "git add ." (or other
overly wide pathspec) to accidentally add these embedded worktrees
to the main project, but such a mistake is at least not as
destructive as "rm -fr".


