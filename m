Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7F2E8B8A
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770414799; cv=none; b=JiillT2pRkn7ouVD18GQndCwfT6NyqWr5ezkx75FnGJMcIz818jiBLo7jBOHUZR3KQ760ZS6kfCZvZnO5wYNC+TflzOWTJfEfnES7Qpqcrz5nA/vByNSKRFbwhBv0MlIwEvmHWLIOR8HJjyRHVFyCb98J7oBIv/YbaI8N1LlV3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770414799; c=relaxed/simple;
	bh=7QoxDHJAt2z5Y7PF+BPdkvso9ZIWXqIhi399Bb4C/SQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WgzVbHqt8WtLacsjG/Htj9xExbFdY1JCPOaLjFd4Bh6+5XurVaM36vwh1Nw204sfOskMm2kwA/+aUlWus1oCQ3XCIwlTPE0+qAE+tJ7k2l2GOhlBHzMKV/pNH3ga9+LPm0hmrsqn6DVAqcAItFXyteWzLREM7f3qo2QaJW/TdpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Au1pE7xm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IYXDEjMU; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Au1pE7xm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IYXDEjMU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B5573EC0547;
	Fri,  6 Feb 2026 16:53:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 06 Feb 2026 16:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770414798; x=1770501198; bh=ZciEevmtFJ
	Px6HU7aJujmc1R0ehrfp7wtulpa74S/ZE=; b=Au1pE7xm6xCX7O/E/NLnApLKsF
	3WpPhjNfthiW8Y171A33+jGJlT8l4OCxoVPGHbePYsB/21SLoXFV0SqrUtWxMIJE
	VDUQYPA1d5Bu3T9TaT2gb9GUVA8Jpb8vdvHp4vt5XIQXXXx32tv5KxUKOtHL2ZUI
	xERPFUGzU7hlub92Ztw1CAr/0wGoyEsyv1XWZ2UA/4wE1zJDExFebcpI3gY3mYhQ
	KnHSdZ3fEQbGb716gLFq/kd5KbV5W1nlxJLlv62Rdg38uGCbLZZ1gFfEqjqTQ+PS
	WKip/Tb2jQbLHqKDxkboMAKUCq0UoUAv4lgIdSc11Opgg7NThl4STy1Upe3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770414798; x=1770501198; bh=ZciEevmtFJPx6HU7aJujmc1R0ehrfp7wtul
	pa74S/ZE=; b=IYXDEjMUVJ/v5GcXeMwUpGqCBAafZpfcCrcZFJPQKKHEeLXJe4c
	fjuaCYT/N8ZpmMEmT3iA4GIuJgB0/bOzRJCxVRbtrLpCVQhMD5qLYnbmNNSvthC9
	6HRQ9ad0acW8osnD0o9UIlnSTCG/sBkhUBb/qR1ySQ/PWcY1ae+YBM9Q7o/40duQ
	UsF49a43LQeHa3NzVYZOigHeQ3CdWueXzBEvk4ZvLT8wgio6wW3MYe4rRKmOTuDY
	GhOd6JqXwFcZL+KFWWk5Lw+8RHByeB3byiuz/7/L5oPwYI4ph8RiZf/0fI4hl3Uv
	eCwJRV9IPlcIDk9d4mhzFdips4c2iqBzKOQ==
X-ME-Sender: <xms:zmKGaUNYskIKrvtwO_omKexpqb43A-bQc-KDz_V3Q1kW7nSIQzRdXQ>
    <xme:zmKGaeoHcRAeqoYlO87QRPpcnnt5cv-KjKQIP8qE5Tc8Dd3HC_aYwjccOvG1hzgb0
    kw4AtxgxRMoPwXb7zNijGhHWgnM96gica-0gNy_BVK9HlDrVrJQcg>
X-ME-Received: <xmr:zmKGaVH1tw0xSIu8cS-Fu7IqnXA-L_gC2dRFwOF1YMJs8ucYoCow7vo4xsJGNyNE7YkDazHSJGSV7WPg2g81LLZZGxTGslY4cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeelfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggvvheshihtrghushgthhdruggvpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrg
    hnuhgvlhdrlhgvrhgthhhnvghrsehquhgrnhhttghordgtohhmpdhrtghpthhtohephigr
    nhhnihhkrdhtrghushgthhesqhhurghnthgtohdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zmKGaTqpU2aNWIg3FKlzKgyQmSVWjWBAKFJibi3irAjGPEtqhwv0aA>
    <xmx:zmKGaeb4lm-L--lTT7XZbjx0HDhGsWQXNdIWItqOTgpt2WbJCJlC8g>
    <xmx:zmKGacW8Hp4qi5dYhtcTKGEvqULeTB58XOjbA3oqRBXyzH29EHwmOg>
    <xmx:zmKGaX_UU9r_AbK-wFdk248rx26gxou__P4AcjoRTmeXUvU59yj0ew>
    <xmx:zmKGaaCsl6XI-ThdfNkMGAI2ACup0daiuYoJdLYdAqT-em62fxd2kZCE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 16:53:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Yannik Tausch <dev@ytausch.de>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org,  Manuel Lerchner <manuel.lerchner@quantco.com>,
  Yannik Tausch <yannik.tausch@quantco.com>
Subject: Re: [PATCH v2] merge-file: honor merge.conflictStyle outside of a
 repository
In-Reply-To: <D514F3BA-36DD-4DAD-BF73-609730390A27@ytausch.de> (Yannik
	Tausch's message of "Thu, 5 Feb 2026 22:55:58 +0100")
References: <48B1AA62-D7FF-439E-B770-1127E1EE0E79@ytausch.de>
	<xmqq4invm2dk.fsf@gitster.g>
	<3724733C-FECB-47F5-841C-84DE9792332D@ytausch.de>
	<fa7fc215-03eb-492d-9af4-457482c56a48@app.fastmail.com>
	<D514F3BA-36DD-4DAD-BF73-609730390A27@ytausch.de>
Date: Fri, 06 Feb 2026 13:53:16 -0800
Message-ID: <xmqqqzqxczeb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yannik Tausch <dev@ytausch.de> writes:

>> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Wouldn't it suffice to unconditionally execute the body of the if
>> (startup_info->have_repository) block to pass "repo" we obtained
>> from the caller to repo_config() instead of the_repository?  The
>> caller of this function passes us either the_repository or NULL and
>> repo_config() does the very-early thing when passed NULL as the
>> repo, signalling that we are outside a repository.
>
> Jup, looks like I missed that. Implemented your suggestion!
> ...
> Done!
>
> Here is the new patch:
>
> From 9fa437c70bfd328cfdfe9cfca982b49b70ad033f Mon Sep 17 00:00:00 2001
> From: Yannik Tausch <dev@ytausch.de>
> Date: Thu, 5 Feb 2026 21:09:52 +0100
> Subject: [PATCH v2] merge-file: honor merge.conflictStyle outside of a
>  repository

Please do not send patches this way.  Giving responses to review
comments is very good and strongly encouraged, but stop the response
message with "a new version of the patch coming!" and have a separate
message for the patch itself.

It sometimes is done to interject a sample patch in the middle of a
discussion, but then the convention is

	... continuation of an existing discussion ...

	So, how about doing things this way?

	--- >8 ---
	Subject: the title of the patch

	The proposed log message for the commit comes here

	Signed-off-by: you
	---

	... notes, diffstat, diff ...

i.e., use a scissors line to tell the receiving end that the rest of
the message is a patch message, and override the Subject: with an
in-body header.  Omit the (From <object-name> Mon Sep 17 2001)
"magic" line, "From:" and "Date:".  The last two can be taken from
the e-mail message anyway.
