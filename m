Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502C7E9
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488229; cv=none; b=uqC6RyPX+Q8MfzRytK65VYnAunbZmAcs9okeE77LQoOhVO/nGjwnDEmLB7XcHKlbSp8C3KxBD0kToNo1cdMC0ykvW2jBss/qTFCR+nwJYHhjstxHBBUZMdO7vVBRkJ3tqKNEZv+UhRS3jY5baaWOSNOQ3P1umJaFI7tAAKktJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488229; c=relaxed/simple;
	bh=09Oi1Yqfn3ActfuU069zpHdZGO1O3IIpIMHoi75C92I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uEXjuoKDK+WRlkSb4iePGWRpROqAJAT1wYbotyB49sEqCgDqOd8n9obzeA/wePL2DAUJeGIUNJt6E0skbuN2SDmVEGFU3HcaYHsPW8UsAFx/MC/u6YVS0CvqjGb6N4k5CU2MI46ITiIzIBMZQ3NrNzT+QWO7WCnNRtpLg/mCpC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z4DGX9Nx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B3WOoEsp; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z4DGX9Nx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B3WOoEsp"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B1CE7A0A9C;
	Fri, 25 Jul 2025 20:03:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 25 Jul 2025 20:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753488225;
	 x=1753574625; bh=7wvefgsb5gH8TCSyNr7HVr82LeaJIRghrzHcnZYPzBI=; b=
	Z4DGX9NxilCxbAKiYOyo0I6SHqT0d2h0pl1nnfeTGkxM61EJPH8fLSCDHcm2J9Cm
	Hlk4WKhxADmmkGD+KEcICgSXmSIYyvYXepwlcJCf4/X4TAJkkc5fn/yw2wBQETEL
	B3tOnxgjKmyLMuq6oLSIShoHxDmO9xiGNKzuBhBALrBlxlJRCePbdondbC89PobL
	BJbUlCF8cqgp0OaoBRiP7/l120o9g4qORzu56hcOd0+2Cah9jiOnheTU94a9wVjd
	aDn5HdspVUJ114wVIUtT8IAsu49fZbpJ65Xfp9k6rnEpPmTk/27w8PZtGsbmEzji
	l0QrSrHF1zBtp20cTcSGSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753488225; x=
	1753574625; bh=7wvefgsb5gH8TCSyNr7HVr82LeaJIRghrzHcnZYPzBI=; b=B
	3WOoEspqcCD5Ihn5+bzhnGs9DDf4rpAC9I9Is3e1HbQNCGpNA78NLG5yVxWcrLOl
	2g6/0wmQs6eqB9Qps/PsOm/HwWUhR1sov1P3SqO37XcVkD+/Bfd+gQBjZ59yOe5b
	5KtUBT/Yb1uDZ8uFSb00CtdmGqedxUASwjbgICmXGEdKovw1e9oO3QRCHN4uB7B8
	fBi3IL7Y8iK+H2fnzQxjEK+Wml1miPzlSJdZb1OzYkWS3s7XiZDCz2zpoHsYWw76
	0z9Vv6g+vOXuugkxqOBa4vZP1Z1iSYlNSHnOkKVEk5a6apbp3h4aQc0OITAdE6Xx
	dCWKEkSjPwUZl3DceSFBg==
X-ME-Sender: <xms:YRuEaE5rMh1Zmo70HOJsvE910y1QFw1kvhTuenTVX_teMLDeP0a3oQ>
    <xme:YRuEaAfSsbiFsIQBmbnhnrnCZZ4HqOXc_wgZchfD8QPBza1OVbiCBuyUy9E2z4nHo
    TTd4gfiVbKXNLEafA>
X-ME-Received: <xmr:YRuEaADF_O_v_04KWkaTqwuRcYtt4zeua5NfpwsTMtY0aecysKsSBr0VUrJlDeupG7HJce5TTwgiZ2njD0TRYQr7A3a4E0EMcRyRKcI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekgeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhope
    hsphhlohhshhhnohhvudelleeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:YRuEaL8W35DyB_b0l8RZgMCb39RshKad93ADiOQb77qtHCkzxV7gMA>
    <xmx:YRuEaDKXFgZ3gjKKIniyGTwKcYlyGrelaQHlIKTBMlv2a0aJPN-aPg>
    <xmx:YRuEaMhfeCm-PycPV5nBI0mEZzysOc6S2lUubBIuxt0QsoGvu-laFA>
    <xmx:YRuEaL5e26XWC2YJ77qY0x3Gk5RYpwEO0DLcC6YhbbuzmWOyfSAdrA>
    <xmx:YRuEaDIIjc4vFUnRbYcD2lIcCjVEA4Xee0_2KlOuSNAqTJzLfScAIVxn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 20:03:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Kirill Sploshnov <sploshnov1998@gmail.com>,  git@vger.kernel.org
Subject: Re: Subject: [RFC] Add config option to enforce committing
 .gitignore / .gitattributes before other files
In-Reply-To: <20250725163650.GA5869@tb-raspi4> ("Torsten =?utf-8?Q?B=C3=B6?=
 =?utf-8?Q?gershausen=22's?=
	message of "Fri, 25 Jul 2025 18:36:50 +0200")
References: <CAOUUZ_wzNC=D4ZLf9Qw0xhFP+3ycTcPinRSCQA7aOJsiXA_FUQ@mail.gmail.com>
	<20250725163650.GA5869@tb-raspi4>
Date: Fri, 25 Jul 2025 17:03:44 -0700
Message-ID: <xmqqa54r3jj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

> Since you ask for a new config option: This needs to be applied
> to each and every workstation in use. How could this be done ?
> And if it is done from a central IT department, the there
> may be a way to configure git hooks on the work station.


Unfortunately, I think it is way too naïve an approach to help you
all that much to merely stop you from committing anything before you
have a .gitignore file, because presence of .gitignore is no sign
that you are maintaining a good set of exclusion rules.

Recently in one of my toy projects, where .txt files are build
products (hence I have "*.txt" excluded), I started tracking one
externally-provided tool that is used by the build procedure of the
project, but the tool comes its own "*.txt" template files, which
means "git add NewToolDirectory/" left out half the files that come
with the tool and are essential for the correct operation of that
tool.  Disaster recovery and history rewriting ensued, but the
damage fortunately was small, as I caught it fairly soon before
piling many commits on top.

Instead, you would want to catch a case where "git add" used to add
_new_ files with a rather wide pathspec (e.g., in my case, I named a
single directory and meant to add all the "relevant" files to the
project---the problem was that the definition of "relevant" is
vastly different from the contents that were tracked in the project
historically and what was in the new directory) and ended up
ignoring many files that _would_ have matched the pathspec and
somehow flag it as a potential problem to the user.

Thanks.
