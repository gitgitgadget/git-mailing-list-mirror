Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3DE26E6FA
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539789; cv=none; b=NLX/AlEhlgud/Sp+Gi0/X9UHTX0qfhgHtAW4pkcWfkwctowY21VYgmKSDTxQ6bK7WqKdMRfWzpjWu84rqtP1/Yn7KFa0fmMyxxNBvf2mxw1FA+Xvvtyy+fKP1/6iTJ5LObrp678tm6U0Mn/lY/XFIDGPNtgYcikP/hzzsfKFFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539789; c=relaxed/simple;
	bh=yKPt5oUoVJ8cjcp0NcR09nF7wZCHmhL/gBJ0AhsZVSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u1+w9s5ZOs8Zbu7S2MfoHti9k7Z81GlxfGAt0BeuxPOUMqP9+6cH4J0aEPI+QoDC3HLfmWgjmSMZWaOjP3MlhoPLXkqzC+ni5v5CmJeEjyH4XxoDNDvF5IAY9G5+nfvgTZxgaT7Kg6V6BOWwes/ETrgQzLW3NWn+aejHv3++9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SArtLcNk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fir7KepV; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SArtLcNk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fir7KepV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F1EE1EC01F6;
	Wed, 15 Oct 2025 10:49:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 15 Oct 2025 10:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760539786; x=1760626186; bh=ouJtwWd4m4
	vHtJenMV7sPt07vo+AV/6B1t8QMNNR0k4=; b=SArtLcNkNNuYGkH4gwpcA4pdwU
	ZMnw3sAY+skigTgZXn2hJpugD+swub/WzQzxgF6flFNte2N1QWO59f6uUxKSyvHK
	X+hqFOZi8FtQ3BeUxmotGq62K9AaUv3hu1pGCLv08anizl4VNSXZlTQaN2+DyVIc
	jDYhUciqwAHOl1GoHr9BXaeGPoyJ9cNgRrvpK17EnB+N22JB/KeuGB1PCI7AWPgc
	uY+CJ3TdMf7SldV4dwIZVl3cwVEmelfv3oWqKsN+fi4DbgYOeNSF5Afg5kuK78XU
	/6vjekCW/FWhgCfVal9Tm4O8bbsCF9VfTpzS2lXB0fia4vHMrSLp/YxErBDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760539786; x=1760626186; bh=ouJtwWd4m4vHtJenMV7sPt07vo+AV/6B1t8
	QMNNR0k4=; b=fir7KepVJFEGFe4bV6ahVWiWjZAPtkyDjZf5D/4TN5EAvZ1IxVB
	Bp+U5y3PgUxgC+zeyMDwzc0tdvq46031xaqIgH5t01nlSDPV2eif4W6pdhBw4ezJ
	X0VEoQTsEIKOtFodnPDg5cMQTyfKob/jPKCq2bo8SV4zHhqafzcNl6uWeStS7aaZ
	rZWnk/4EJxOxAX0qZurnpBxteQvFnB2IUsZ5oRoM1yaNKVz1DhVZv4RWe/hkQZPr
	AY17d7V3/2898ubXYi+Eun4ZT8kgVWkhidZr0siLJVHTQaTgFv7d28y12RCQ3T42
	rAHdSs0knJxm7dlsDQ5px5xtQmp5UOxfmWQ==
X-ME-Sender: <xms:irTvaCZIUfrddQU69pkIr6tGc7AuBKdY4WKyGIMEuJuW_oRtVKqlqw>
    <xme:irTvaMacpHVuW2_AhQacdeR2eqzspNOG6Wt9yTWJsxO3kmseGIK9ziR8piTNSvAQn
    I35Wui4i7cWzB9WxWdwOxAfN1hEpczSZ7PWfruxe01Ae-vJ2P7Y>
X-ME-Received: <xmr:irTvaB-yYqSIstBCngT7rn8W0XXWNpS2tsR-A6tsPzkG9uS27DUd1oGK6G8b94j9E5My0oruoS6_gEDz0gFf94RG1NlevxZshgmN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghh
    ihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:irTvaDi_wZkyjp0t31_dCvImupGr57LNwj11JDt9AUGjRrIer1XUUA>
    <xmx:irTvaJfwKw7kXngQnJhKwLD4qKtyL6ArFRE2YsVbj5mJPyzdMZFWQg>
    <xmx:irTvaCpop44zYwe8BBHqgUEWJv3TmvZeadNpepgJMbHL2mRgpOeleA>
    <xmx:irTvaGApgB_5ii1t614t4_BfBW72mTjm1YIgU4ebV-N58bDAWJiFQQ>
    <xmx:irTvaD7PrXp1Ajy1mkJ-YUtuxSRY0KWC8GmuW_6G0edlVhE4GAuOxkGq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 10:49:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] refs/files: deprecate writing symrefs as symbolic links
In-Reply-To: <aO84NamCzFXH1eUl@pks.im> (Patrick Steinhardt's message of "Wed,
	15 Oct 2025 07:59:17 +0200")
References: <20251014-pks-ref-files-deprecate-symbolic-links-v1-1-4bcd6a4ef6f5@pks.im>
	<xmqqplapxur0.fsf@gitster.g> <aO84NamCzFXH1eUl@pks.im>
Date: Wed, 15 Oct 2025 07:49:45 -0700
Message-ID: <xmqq347kw77a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I don't think we do. I'll say "textual symref format" here.
>
>> > +	warn_once = 0;
>> > +
>> > +	ref_path = get_locked_file_path(&lock->lk);
>> 
>> Was there a reason why we want to first warn and then attempt to
>> lock?  We are afraid that we may die before we have a chance to
>> warn()?
>
> No particular reason, no. Happy to move it towards the end so that error
> messages are given preference.

I have no strong preference.  I just wondered if there were deep
reason that was unexplained behind this change.
