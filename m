Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00E270575
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929084; cv=none; b=G8F8ljy3PvBpQrz/dHFRtFTG6/tZzDntg82MYQkWGExyxEcAdHbpZhZ/5bYEznfKX5qzNlbkMoe84bRQ+Nz0p4pabOI0jTyNDCwY4eK3TXcIiyi+Z7mxhJ1cYI1gQ6IhY9j56kD6nrYFQSwCG7dWLX9e/eC2J7S+JxZlop0cB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929084; c=relaxed/simple;
	bh=JZG7sd0kXomC/hQe1vsEIml6yEb7/04p9p6nv8U2kqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jjpnsQMQ0ASV9/Fk4fsYhQVbfmihqp0/+b1G1BKONfWocxRGwLQaBhhMNWQsE+wYV22fS4/KSqVqdbZAuvbVoFZej7uxxKz14uIYtc5eV5R6dtJoN0njW071uOeW+0702Ydvl/YWju2zUuHwBt8+ATuEfY4A6IqXdtTFL562+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sFcABHg5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TSVFxOb6; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sFcABHg5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TSVFxOb6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F21617A021B;
	Fri, 24 Jul 2026 17:38:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 24 Jul 2026 17:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784929081; x=1785015481; bh=S05bJk+zF0
	OxkdvZsJT4iQ3ZRw4birQ8Rk8KFUIxUYM=; b=sFcABHg5mkIGQXJmBBYU+mIOut
	SkTGuAWK6LBiGl0mlxDuOYzxDUscE+nqcCuWF2NSbbquhh0PRbFMDVCESCkliQmA
	v3sFArnIAdibxOPxCm8r0htKr7PqgkqtGpndYcwxaQqEYgkzobvWRak7pHDnWtbh
	GCOBVxWmS8DVpqzhDZptKJ0WLLgdCVOV+aH1AYBtoy1e+75GDSkBP80+HdHFuRFX
	WbxzoiZX70yDfDmOitX5td34zGCyet9J+ntm5EqnObOOmCbZjSXt6Z0284LdAjSs
	PbkWLbsYrHOK/8Oh48uICb8MDlf2yR0AUOXnnqZkHsnXUisJHsvZxQ9rtAhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784929081; x=1785015481; bh=S05bJk+zF0OxkdvZsJT4iQ3ZRw4birQ8Rk8
	KFUIxUYM=; b=TSVFxOb6UYBphFGSXc1kTSgPPOcKmfVj7LwaQu6gL3ec+ZZ/fq1
	MZWfQN4XZmou07LCO9WngnsfDtoS/ea6sHVzFp1qjvEVBbIQN3BhG0v1cKhNSfpR
	/wIg6ogwmpCXtm0IeCTXFwun/qRncHOQzmMtQVPlEvtAq8UKbtSkEX99J4dBTnFw
	WfTuOdDkmO+vXD3DchL8mq6jeH7Yjg8l6QRQ3zL52z9+VjGsPN/IdEN0Q1BRxESb
	wKDSKrQbYQFgTenS9CNKTwdFpz0quSzm5ZpXCWLCEyp5khEtOx5ENq6JGpFnCzxZ
	C4ZaD1wzFFuZEOaJqxDDrarmxwQOnjAtiVw==
X-ME-Sender: <xms:Odtjaj_bG3VEVfDG5sPSR0Obkzks8Zf7pn_NrO2c3DI3KERC_Ji4RA>
    <xme:OdtjamnaF7-ez0bhz1OFyIqQSaMLqtA11Psi33NpwZVIccQBnJS9lS9b7jXgAYGcI
    gWkEXdBZUB-3j7EdAVvJCf334RuhNj9OB1ZDsoXAEAOXRbw6c8c>
X-ME-Received: <xmr:OdtjapXnQNV99XVaz2giA0LPDtl8oY4jKaETASKZUIrwQou91cr7ALxBv5MLDtbHCLdpP22HqyoWnmOOwqWxilDAIKMpK-Iz6w>
X-ME-Proxy-Cause: dmFkZTGhuP3yCSjaffS6um0wuigs6jaw9y9BCuJttGFkU1JZN9vz44A4tLBo3mSDrFhwWb
    fTOTRNnbmpIGQciICoOV+KY29jzwrZ+/tCO6dNvTFvmYljU2EdqkBbsb3M+EdV5i65r7lL
    pT7EyBVB9d8gkCli2POcHeLbTTkfYbxfWTUKUUYPxBqNANmlba98jqLLszwvoIjcxxO36h
    YzZZN7e33KTSRpwY6dq+pT7N35JuPqTHPObzQR/pOlQcIbZrCpKRgfopwk1A/W/e21hIIw
    CDS74A5Bw8nDEoW/I9ableE9obhD0eamUDpR2ntn5FwQZx6jnVlyhfJRHIhcjWjCRJnifc
    rvK1yX2zhZWWvtk/1yZTaIdQs63Euc2C7WeCWDt/FHTnk1snb/GTBtVk9k4jEwzLebuGhB
    Lzi2Ogcd9scGJ01O4Oj8/KwJ53Grq/NsE2v0e2lFVwr68TcqBevFu9yBi8mQhYoiFNHHr+
    1YaAtmwSxiSbso/uf3hNIp9A2EXzb4vhOQvdM5fBSDDB7EYhw/mUqASrMVS2sC+z8UZHdO
    fSoqaEdRejqfQyC4zjbiF93i5zs3GqV5dloTthgRTxZzIZE7oDA7fHIhehxF19EWLMCus1
    WyohWrAjV6mKU0BiTAX9f2148OOpesjTMaza5sWg/ShEB17JlabwtOVUVMKA
X-ME-Proxy: <xmx:OdtjarGir1X31OWUdtaspkfdugHzE1d-JQveXF0roO_67tWH1mPAtA>
    <xmx:OdtjalcINfb25svi7bFh3lBEighFwQrBdL_2TTbyAbat0n-ZOCKzqQ>
    <xmx:OdtjasIQQ6CVupNLVy53khPpzHrK0xjVeIMkX9pWizjG089nKmCfrQ>
    <xmx:OdtjaqG2rYKZ1Gx4wrXF9tkry-frpZIqi04XIa0S8dF4rpPNLFVJ-A>
    <xmx:OdtjaiXsYBgITiMWOyld-YrTMG5UX81zUJSD3ylbjVt7-NrhZYCNydks>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 17:38:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Michael
 Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH] revision: make get_commit_action() a pure predicate
In-Reply-To: <pull.2169.git.1784143793613.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Wed, 15 Jul 2026 19:29:52
	+0000")
References: <pull.2169.git.1784143793613.gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 14:37:58 -0700
Message-ID: <xmqqjyqk3w7d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Add a "line-log-peek" subcommand to the revision-walking test helper
> that evaluates get_commit_action() on a commit the walk has not reached
> yet, plus a t4211 check that the call leaves the commit's flags
> unchanged.  The flags are compared rather than the commit list because
> add_line_range() merges ranges by union, which is idempotent, so the
> side effect never changed which commits a linear -L history shows.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
> ---
>     revision: make get_commit_action() a pure predicate

Sorry, but I completely lost track and I do not recall suggesting a
change that amounts to 100+ lines of new lines.  Are we doing any
code clean-up?  Bugfix?  A new feature?
