Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C6325704
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694947; cv=none; b=MzvzrHTrvHeb7KyTYeIdzAEbLLbaTV58CrKZ34XTa21qjkWVJGIpAGcsnQn1aHsBunspiTEktnjNmFYtG4H4ayTxXfkHzu5U+uLTk2Gh1HUaj4+xekgwjcGC8OgqRSheAvN4eVGQgDyNGZGJrIU1Cagq/xYRnJTHYc2oR2E+ZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694947; c=relaxed/simple;
	bh=bza+2nPlgCR4rYnU6Rr2hUcLVmmPaCzfWHnT2kxDx74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=otD1/tGMzQgpMEW0fkkVZZWj66HaeKBV0MQ80KNfGUpdUIIvEJpHZrgz00HSuwWAplR3PLXDi+Jh0rjCefmEg/oeK1CnQlh9js07T/3VKFYhsK6YQcKZWypwDEcNbfsfpxW5KxCYI0WGVuuunUZyAM5FG9zHefodEIhhGtN2VMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bY3kGKdq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RpKIxnMy; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bY3kGKdq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RpKIxnMy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 07B937A00D2;
	Tue,  6 Jan 2026 05:22:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 05:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767694940; x=1767781340; bh=WNhwb3ac1O
	Au1hvxt+76kytN5QYtmPyeigpPvLLdwqk=; b=bY3kGKdqarxQiYlSTsaC9sFnYg
	s6sadfsMcBRbTUoMiwVPXvAljjayuHC3+BSQVU9+6YAZw9e3OqAnQUrycu3Z0XuR
	U2hdox1oNFlocW0TcI+aA5e1vHCi5xKif7p0MFiHasENreVyYmDP4gtkPOWVKi8M
	Frq9okd26Ud+SJDeUeXyuJBWOG93BWH8NhsJ8e2ml9BxzdCjPqqlCkgBPBZ/kOZo
	SKGPq+DNdy1wfXK/4leDG+XLxiRCgIPbL47u2O8aUE8aKX3J2urFAt0le9E8mI4E
	vHkCgwH+nzebk9F5dDl9RBxJ+Y8JAROIheFDZo13Cq7hEJewv7PHbYDfKW0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767694940; x=1767781340; bh=WNhwb3ac1OAu1hvxt+76kytN5QYtmPyeigp
	PvLLdwqk=; b=RpKIxnMyWZIZiV4Xs2GyeGbtpZYqUrH/kR75LRy+XGTLCuOKzTc
	2Qp0liYmBF8K/5Zu8beBoruB0s3hacMOcqw7QFGo1VsvF/K5YIrJXEk5cDXA/zVt
	THv5FsL5z/suk3AP4o0j/bW3FxAcOOL+kNFTTME3E5uJ5HoEYiqdkJL6A6WpYxnF
	wviOSbXGLxBMs3XxcY6NinPrTxvGJ2zcNVAPss8A+MqLSe0CNEpxJt8Ps+GPB1Tl
	l9b3K2IWSbBB62yv6wGBXWqb3GwbTNFtGCVfxPw8a0+qPHgsBLwWGj63bmi+M5HS
	6xFaFT0Yu5dCaSMiY/JiumOC/9ebvVV2liA==
X-ME-Sender: <xms:XOJcaR1URqUiwiS-KXV1xKW0Bs5JLY4jKfZN1VcN_WNMhb-C1Zd6_A>
    <xme:XOJcafjVEfGMaRua1yjSnXPYKnsUrQcChNFvegItzScHCoDVpLFrzt_4ue7EXlmE5
    AVyf2D9rCS7DvEXA1QVgiBDI1bI7JQTF22opUIgOBDNSrdTs0Gkcw>
X-ME-Received: <xmr:XOJcafTy8i_f52bTc690AR2BhcOMpGMUMOZGVhoNGeLXs3ADYy7evcJu75_J_QutgnlprTEzRF1yCvKxe_RZaFmCmSDP9zWwHztLVTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgu
    sghgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XOJcaYgtcyp958GLNJflpsFnHz2ZQ2RWBHbp1n0ZYnDHm_HEkrTLaQ>
    <xmx:XOJcaX4OtOGcIBfbFyHE_UNZyh6Trq3l3UVsaAZYQLCpxW5O9zu04Q>
    <xmx:XOJcadDgaIlmwgz7Z367eia1o40FOKAmYtpRAIO1sX9gBnS4GkYdwQ>
    <xmx:XOJcaWaiNclz5dLG3-a6hVd-sT3GtNh7QRKC0xavFZy0_vnPCE750w>
    <xmx:XOJcafOxIYNBmRkL0Btaa4ighAgZLTyzwjBRhTusetjdexDz1rXsylxu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 05:22:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: How is git diff --relative supposed to work?
In-Reply-To: <f1cd3ca7-9b31-45b0-b990-05f4d1f6b4f2@kdbg.org> (Johannes Sixt's
	message of "Tue, 6 Jan 2026 09:15:03 +0100")
References: <f1cd3ca7-9b31-45b0-b990-05f4d1f6b4f2@kdbg.org>
Date: Tue, 06 Jan 2026 19:22:19 +0900
Message-ID: <xmqqfr8jjb1g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Try this in your favorite repository:
>
> $ echo foo >> Makefile
> $ git -P diff --name-only --relative=Ma
> kefile
>
> This doesn't look right. Shouldn't the path specified with --relative be
> interpreted as a directory instead of an arbitrary textual prefix?

Sounds like an utter nonsense to me, too.  If we assume Ma were a
directory, would the result be "../Makefile" relative to the Ma
directory?

