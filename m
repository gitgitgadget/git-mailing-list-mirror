Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB1219FF
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770938357; cv=none; b=nKV6jAPzYx03EqolaKJPmryCc5DCKhFiNDkQkl2rofNTfIgzm6ppOuWchzhzb30yp4WCHHh7LD5vtD3RiF4iIYXejBGcomI9XIJDMfdzZeXH+fsmMEKLn530piMQ8J26vTqTdtNeNi109M0mIoy0R/8S+1j1keSSzVaTVTDUBvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770938357; c=relaxed/simple;
	bh=VJXYhYSW0ONsweS/VWYy/9umXP8yUYlsOREyVIEgYxQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dqq4qfXicQH2cBc9TOzJbGmlLqMH31YaVrWEsUrZKXt3ytweA+3korhjlj3huXLgZgh2AwNEqGS6SBVXprmwE6+HvT1vErpwsh2x96GZ2GeeD9mQl7ABs5I0tegp9MPDcwaMW+FLFn17p2E8UOHKtiMC3v9liiwn8OLRQ4VBM2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=myXURzO9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SAMAo9H4; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="myXURzO9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SAMAo9H4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B1DDD7A0054;
	Thu, 12 Feb 2026 18:19:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 12 Feb 2026 18:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770938354; x=1771024754; bh=vbkVCGItIW
	4z0GjsSYlCzR+uX5R+c25AA1WTr2XrqQM=; b=myXURzO9v6Zv50OGw1U4qHaEhX
	6SV0VYjZ/LclVGP1d62Oh79E4B6RacQvx3psS88XENTB1v5idPbssEFebyeWE0RC
	8ZMZdakJEQ4FB9gM/FvbaiMd50Z53NedMBZEz0WvkAiPhR7NOA2gtcvE0il3RuzL
	FoBMcrNbftoOdvgdNxwWAvUjUF9/qlsR9Q9DB/8grB41OOUGxvH1fBiQwryKiZim
	vol0rCAI6akSe80MNAMwp6TSGwfjcAjjJJS7uBx52IaIdvnFEP/ljvF68VQujXw1
	YewVtgXo3LpXH2gPw4eE1h1gPrpKglmCArAjl9qS8otXQMJsudKY2jUJXb+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770938354; x=1771024754; bh=vbkVCGItIW4z0GjsSYlCzR+uX5R+c25AA1W
	Tr2XrqQM=; b=SAMAo9H48wSFQzAM1aWmx/tIq0wlzHlzQmifycI9A1YF+Qf21vz
	j9Nl7IOupYP/D5IE3IvbS/W5OFdO4XFjf971gMhOrT7Jc3y6n7oGbPJ5T6oSWTvF
	Li98Q1YnGCQ3Ytp9I96jglRYHE+M0O28f34WVn26dy3YDSxBTa3F92vMNZLLbTsA
	Cmf7rzr7Xhuvt/y+GNJ5KWYdSddB3Q6je3U4zfamDkgkj3qTd3NN6gaOPrG4KGc0
	DWJ01aT3vGaGLX/MzygQUAIzP2kEeS46CsfmQ62zxYpoIFl5USUPuo1pPcWJeV2j
	NXHnCfX3mkX8x6AJC9uPh85a3dAN9B0Sd9w==
X-ME-Sender: <xms:8V-OaUUgIXIXLRjN3-eHTK2gzl-f8e2sqB0K_3B03d8odZJZDBLfxQ>
    <xme:8V-Oabq8KSEv01PJzbgaKzAkvup1ZneD6JLO7mfK8RJwgBfKHtnqYm9NwIFAjX7a7
    3Y7lQhQH4AyQoQhpwfBafdb0TZb3ZUxU7t1FO__6V4u8022BdGqHg>
X-ME-Received: <xmr:8V-OaTBP6kHAOXlWTkF-_IsKwzno-lEc6kzPbn99sjLSJqqX98-Yi1YB8amuIEp9ZWnScCwx3SWN201oGQ8lbkRJ6UnbOwMULg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeiieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtg
    hpthhtohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopegt
    rghlvghsthihohesshgtihgvnhhtihgrrdhorhhgpdhrtghpthhtohepmhgrthhhvghush
    drthgrvhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhuughgvgdrphgrtghkhhgr
    mhesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhrhehrsehsuhhrhehrrdhnvghtpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:8V-OafhOKw020JVwTnwiYg4ByeTPbwgENC9zc5gelrBzmub_zSPyEg>
    <xmx:8V-OaZbYw_Rd_pjWD3EJszaepHhVX-Cekqtb9_pJ-zpk0m7DBSa70A>
    <xmx:8V-OaYkMtKzKl8StJl6GmGhbgxhkpxmqdMeXnrEXIr5ut3ewPnmRhQ>
    <xmx:8V-OaXguszGvJchAlF5h6kqKVocbNCmZ7shdQ7JkIC0pSp7OSWXLZg>
    <xmx:8l-OaWTCzOTfLSViNNMfTRa7my_C7fdp9jMCEfMg8HLLkst79oPRYGWV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 18:19:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Matthias Beyer <mail@beyermatthias.de>,  Christoph Anton Mitterer
 <calestyo@scientia.org>,  Matheus Tavares <matheus.tavb@gmail.com>,  Chris
 Packham <judge.packham@gmail.com>,  Jakob Haufe <sur5r@sur5r.net>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3] doc: add caveat about round-tripping format-patch
In-Reply-To: <V3_format-patch_caveats.354@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 12 Feb 2026
	23:28:23 +0100")
References: <V2_format-patch_caveats.34b@msgid.xyz>
	<V3_format-patch_caveats.354@msgid.xyz>
Date: Thu, 12 Feb 2026 15:19:11 -0800
Message-ID: <xmqqtsvllfdc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ...
> All of this is covered already, technically. However, we should spell
> out the implications.

I've read the new text (without formatting, I have to admit) again,
and did not see anything questionable.  Nicely written.

Shall we mark this for 'next'?

Thanks.
