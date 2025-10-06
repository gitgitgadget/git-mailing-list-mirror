Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71707222566
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769489; cv=none; b=CNakRhvVh5mKQ1uEhgYJF1OnL45tm5tZsNheRhigreeC6AkaD9RXMqDtT29w58YzEeoh7sr+KsBtcEYeaXC2KNgwB9Pv4fgYg4n4jpirqnwYcgh1t9rsoFhFegetIAqyjUTfjlvzxUwi64Ng16KIwiIfwH0XneOVhKqPRr6phdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769489; c=relaxed/simple;
	bh=z1KzAc1JzFVbrW8umbTswhTEhKx2WhSyodtiZfkBhXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hdpMmRNtWLTCLKt0oSJD2qPlOv6k5fnq20YyZWwrTOk6SRZOIqt3ng4gm0Thsi/7Adb80VfQdMPGi7jeVX+q+lDC4AcCixL93wjgcLb9jwSEfEFPuibp2CGkajVzjVpukbDBeGgBZi83XFtb4u1tVV5UyVTYFDtX2X4oDdfs/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BW4oJfnu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ABvD6X09; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BW4oJfnu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ABvD6X09"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6DF007A00FA;
	Mon,  6 Oct 2025 12:51:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 06 Oct 2025 12:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759769485; x=1759855885; bh=rs6TG+3Cl0
	yhJroE+Hzl4QohsU9hoK4pwlF4177LE18=; b=BW4oJfnux+jNot0XC9yidjzOY5
	t8iZyatTC5C8G9nLH1FPzbSPPrXv4u3BCDtKTUWI9trKWcrAzccbZOK5AP1Yrd2K
	FPeWhAb3zfUtWLylWxaCiDVgtrzsnWNBdY54qWkBhluwhOEOtekToiD1MUqi65VS
	uTDJ02+sO6ac+lu3NusInxoy99vLLIfSOlsItN7RmG3VE63dCcmFKvrZBV44JAqT
	Tlbsj2z70Aas1Mr9oiGWUlvOcF7Kl+wYE6COJAjYDfXCtC9n0P8ogfPfHzvI4i0b
	BqOPXZ+CXcIR2q22hvqxCft82KjQsnK9QbvFG4gTQY2sPiB/1D+mUm8l7n2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759769485; x=1759855885; bh=rs6TG+3Cl0yhJroE+Hzl4QohsU9hoK4pwlF
	4177LE18=; b=ABvD6X09rk3CrNM8T+qHsudEiwznaAqtCNjlM8CDpAtIKOk2oN/
	i929f1r/6AG0FKFbAWJd5zJbHLCYLD6A8dUpMK9OeLefwf1K5TST3Z6FyiIGhP/d
	UGc3tk01CEFKRHXVtZO1Yeg7+ModKIXep6YjaWIWdHnCjLb3lLIQQ33QVKxI1xsS
	LruaAyQJ2y4p5c3Uq/3RrB9Oro03TyX22ph/3bSkSlpC9/IbLEroHVJMb8mXtFvy
	Q1R6AGlaxt5mgfMOXgyhvVrk4B3JhPZOZkq6OIG4AiqgeVF5sgQ872kiqGO2ptqG
	+BDytw6yBEUS9MI6uJHPtYdXP+Co4UBag3Q==
X-ME-Sender: <xms:jPPjaAwfQfTyKI0OMM15uofTKUukZoniRXCigc-0PWCfpxwdszDl7Q>
    <xme:jPPjaAFr4EUFyOAN39YxGGpT13rcX2jyemYg_IsBSiZow5eHFZVu9s6Ylo97iX7-w
    1FamLhH4oX4ewX9etyclNfM_iA5HO1jHdt5AtvlSa5iTvUpKdM7>
X-ME-Received: <xmr:jPPjaNuu7av5E0dCQBTEzlqstidJMmjFILsdzQ0sVIvWdGX-zEtV8itLEyw1iTeQ4OT_OpEfQzSCNxhxihUSo8bXLZ_GXgEN6NL5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtoheprggrrhhonhesshgthhhrrggsrdgtohhmpdhrtghpth
    htohepjhhrnhhivgguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:jPPjaIBy3g05HqJMlDDF-8ADLmCnyraPlgxz7RE7nJMnuejM75nx5A>
    <xmx:jPPjaABXIJfoqn0bBi0OBi7I49wTORbUryOVfWnNKy2CObSp_wVV4A>
    <xmx:jPPjaKrc7cVpUWhVv57o5wrXzqnE8HMJEu5f8LM1zL-0-32xcbaNUA>
    <xmx:jPPjaDG-2JzDdcihPJNxXw02rl7x0vKu74iZK7vSvajIPOK2qs5j3Q>
    <xmx:jfPjaGuaCIlBEVe25LaDBnK9avkHRT1ncpW08lqw9-gEe9UA69wQdTNv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 12:51:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,
  Emily Shaffer <emilyshaffer@google.com>,
  Rodrigo Damazio Bovendorp <rdamazio@google.com>,
  Jeff King <peff@peff.net>,  Aaron Schrab <aaron@schrab.com>,
  Jonathan Nieder <jrnieder@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Josh Steadmon <steadmon@google.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/5] strbuf: bring back is_rfc3986_unreserved
In-Reply-To: <20251006112518.3764240-4-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 6 Oct 2025 14:25:16 +0300")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-4-adrian.ratiu@collabora.com>
Date: Mon, 06 Oct 2025 09:51:23 -0700
Message-ID: <xmqq8qhoq8hg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> is_rfc3986_unreserved() was moved to credential-store.c and was made
> static by f89854362c (credential-store: move related functions to
> credential-store file, 2023-06-06) under a correct assumption, at the
> time, that it was the only place using it.
>
> However now we need it to apply URL-encoding to submodule names when
> constructing gitdir paths, to avoid conflicts, so bring it back.

Why to strbuf, though?

This does not have anything to do with what strbuf does.  I could be
possible that strbuf.c had some function that encodes/decodes 3986
in a strbuf and this may have been a useful helper for that feature,
but it is apparent that this helper function is needed by
strbuf.[ch] in today's code, so moving it to strbuf.[ch] makes no
sense to me.

