Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D352A946A
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767967274; cv=none; b=FZoCB8DlPv7GtybSMVZi4qXCga5mvD2PlHZtaBDoq6ZibivLwQ4APlo7gMeJqnfONfjSCopkqGSsnesawzI6Tsb4P9zyZ4sJHLIRbH6Scs8vKqIysn5oDs73SByUrxNoRHljs+IbP+RDe/C7xYKYykD7d2pijbs0yylQLO5rvyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767967274; c=relaxed/simple;
	bh=SF2VnHi7iJIKugT+5rtaVVKYxuFzoYCZjBubNVfz3II=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S5Wjt9xrpJWo9pyZLGSf0cg106q91rC8Fr9XYrbUD49qBLE1601+SdYtElltlgJVwsm+ZNHT47+m/hfg4DlTLhjRwy2stKV140MK8eBUN+nak2RCPNzt8jbMQp79GnNsXbk7beO1j09M+YyECZznR1eBtNyLfeSXiSjdRX3R9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TKqJE1e0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zw5VY9RI; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TKqJE1e0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zw5VY9RI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD5887A012D;
	Fri,  9 Jan 2026 09:01:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 09 Jan 2026 09:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767967271; x=1768053671; bh=dwnohCP/zX
	+Fbehko3lsyJWYbyH54GlWdFCYeqJUPA8=; b=TKqJE1e0AC+JOzgafkt7YA7CS5
	KSlUoIrDC8zBJ5CfDLaYOr1QOJ/R5SQHQmkJG5AViJrq7tNxa2hho5lj7OYQFDs6
	xai6XeKFKFfJT/LhuzECZosm+Y/z86iX4fp5uKnDvH/TFgNDhQm7OwxjaKl6LE6P
	x5umB/+pThtHeuxx0a/r8dIQgGDZBX6eQCYRvdZMFcUgDQhtNPtGrA5OfInvk0gL
	/W0cQOiMRKbzBru3HLiCSRnxcW22w/hDuwoxdYVMdn9EBECY1SmqImhjashFfIDr
	kaK3xTIW//rU4D9e77KasgZsbh7d/koGmFrSgI6AdEEM247FWIvLvpbMhHGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767967271; x=1768053671; bh=dwnohCP/zX+Fbehko3lsyJWYbyH54GlWdFC
	YeqJUPA8=; b=zw5VY9RIG/kTiJ++AQsiwOjYCyVtfYrkmMmusJh+gL95iYz7Ye1
	mCwecRzFHp0p1NoKT69uhKpU87fuACGLkAcrQDn2Sbg2sqKnWYt+FYjtOJcH46i7
	3e1sbCnQdxbvCdWMu2y7BdhNgEKDj9FftZlGyejhwomz2Ze33DOVbxRqfmJEB6Cv
	LMXPZuQR5WNa9ruu2mBifbBDY2VpOjrFY8nRILmtNbifi8BYd861JxksRZiVCyUO
	6SSaWzrluQt32JA12sZYQAeylNUbjHhm5g8JsEa+hLYQ2jybuzC6OcUClaRRhIZf
	HlD4MAU4Egdd49YJLiITaGoovHEHywyTK7g==
X-ME-Sender: <xms:JwphafI0CCY92e7hUPSPuBXc0zeq-uPM6a1NwyW_cjSdWsvGyxoadw>
    <xme:Jwphaanu-e2wkEO2OkYzYHMzNA3c37pI095pLmuoSPf62symEMChzmqmuWatfCOAt
    KhdUgv8vhgCF9GRdrbfkSys7wPgeFvMIzMPQSVq-hBLPgoCJrENdg>
X-ME-Received: <xmr:JwphaVF8IKZFJ-_2R5DpcdWJvf32Wl5os0f88xqQSp4URunf4CVp6Rf7cMsNrWdN6X0F0D5-nSaXz0ipCbtGxbrNNDRof16xVjRlExs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeltddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JwphaSE4_KySfQ2bat5MpA--jFOs_euEKZiXUO5m3kDmozfzVn-8pA>
    <xmx:JwphaaMHnwhK0wTbYityrB97wCeC0-4uSEx83Kttv_OPsY8JdiiHkA>
    <xmx:JwphaZEzaPu0ctc8vyyVzNrDENckfOv0Td-udRlle-ZW2VVD5kdMrg>
    <xmx:JwphaZNEMV_p03KUsmpIBpA3KzP8tRx8Sef3DFCn3n7wajLTa4JBkg>
    <xmx:JwphaSvlRmIagE5EEsGDnMYs7HdX8ASE_uz1Im6Q0bOyF_pJjppp9tp6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 09:01:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #03)
In-Reply-To: <44cd16d2-eabf-4ff4-9bc6-da370bbe858d@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 08 Jan 2026 14:08:33 +0100")
References: <xmqq1pk0gvxc.fsf@gitster.g>
	<44cd16d2-eabf-4ff4-9bc6-da370bbe858d@app.fastmail.com>
Date: Fri, 09 Jan 2026 06:01:09 -0800
Message-ID: <xmqqpl7ivqai.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> * kh/replay-invalid-onto-advance (2026-01-05) 6 commits
>>   (merged to 'next' on 2026-01-08 at 1024748f91)
>>  + t3650: add more regression tests for failure conditions
>>  + replay: die if we cannot parse object
>>  + replay: improve code comment and die message
>>  + replay: die descriptively when invalid commit-ish is given
>>  + replay: find *onto only after testing for ref name
>>  + replay: remove dead code and rearrange
>>  (this branch is used by ps/history and pw/replay-drop-empty.)
>>
>>  Test coverage of "git replay" has been improved.
>
> I still disagree with this summary. ;)
>
> <460f1f96-4236-4d19-bdfa-6c86bad811c5@app.fastmail.com>

Thanks for reminding.  Yes, I too disagree with it.  I knew the main
change between the original two patches will need to be updated when
I first wrote it to queue the initial version, but it certainly is
not true with the main change (split across 5 patches now).

