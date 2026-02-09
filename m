Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD21C3806BE
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653640; cv=none; b=neV8up1vOE3KhYfiQkVDFaiH972Z3j5M5rYTzL+3b4/qTkLZ0zHZQ7jBI6HrVpJ3A1zw8f/THesp5jcrlOUhYlNj7NhoefM9GTzxJ+zobvdoayCwlwU0cNlLQ79UMtaA5Bcq9SviPZk8+M+HeUsTrthS4eu8vHE4wyoaIIGAukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653640; c=relaxed/simple;
	bh=LxRqCrTNyqn9K5gKZbrT5geEwRb90NJ1W3LWpnPbDKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jPuqK15yGh1rWNtN0Q1SA0VjNldoQo40oRpzWKd7ema82nx9TMuovySCDiHn16vX/SFUhSe9YtYo7THubHTZR9JdCSWjX84kQtngJc7C0S/IHFSOy1WmrRUNcjf6zPDCvrFXVJvLjScO2sdYNTm9mXoGOmufOpyGirSrGYPTotE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SECTR4tu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gt/6slU8; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SECTR4tu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gt/6slU8"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 038837A0114;
	Mon,  9 Feb 2026 11:13:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 09 Feb 2026 11:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770653638; x=1770740038; bh=2cBoE9oCq2
	H4yhT+3hENYJdcfhu754dpTVI02K29c+E=; b=SECTR4tuGS11RYLfoAOf0HuYWj
	6hJmaqgF3AEj2DgpjXcJbLOxIwnl6cYlS8iwzFn9VIhomoBpN60E7vE5ZrP3TBug
	i5tf27hB8VtEbdw/ZET8Sfd5HRJwGlMwFWtphHeQjqlHBtMexGGpzp+dq/2FxmKl
	nBgLzfU5ZB4ENzP//MGF1m9uQdHRog8tqmpbAXSRk/Yj8lLPpNudIBV5OWFIttnL
	JrkNx++Gr84QDWnoXDZIjEIAbDjbX4bVKAxGlthq0mS4214lEh6JqDWM0QydcvcU
	6N3P9htNncD09LE+uN0ZshpJqSetrtQMuZTWG4FShPY192FEfb4EUABIrLUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770653638; x=1770740038; bh=2cBoE9oCq2H4yhT+3hENYJdcfhu754dpTVI
	02K29c+E=; b=gt/6slU8PavD5doU8R3k3mXJlzNV1jEDC+PRlhGgBtstBzbpt2U
	M6/YYBb6E/uTcOkrdxgRulaSezmPV5EzN4tDytILBYH9wTI8M0ivuoEbUOjFJhAY
	Jjfd1zuqZwzKhZqXZvGY8ZC2D7TRjXdeeEQ/8dk4epkQLKclgX83B+VanIB4cfJx
	LSzy37OCHBf0m1CFl48SIXRGui+BnAqAPN4PB+cNjGXMjTuer5xDjfvYoSfpAgi7
	U0tJ1Ci/Ne4OBuA5aQNZixtBsUzJva/yU4WOj+BKu0OWC1vrHT67HudvWgrRHxG0
	hJcAZHolVmPgMMpD3x8bThdH5ZZ3+ZF5NrQ==
X-ME-Sender: <xms:xgeKaZ1iiYXK35836JUggHyPZNXJY8hh900hlya0lUIWm6HdHkD4xw>
    <xme:xgeKaSUPolf7V1Deh7_QQ3eZfQB68vIWHHQkoWV1zatxXDnmza_04LQyjJs7ehTeF
    egstxYimFsgy0IMtmVrdC__4Wjmys2RgdfY53V6l0xApL53vyx-Rw>
X-ME-Received: <xmr:xgeKacKM--CHY_7L0gMfd-0jSG0lswJmTstTrLeXu4hsWkLHNgUHRI451BDWEDetiXNb6sLJkM6xFu5mk0LmlUeAz5wYU_pWFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopeguvghvse
    ihthgruhhstghhrdguvgdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggr
    khhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepmhgrnhhuvghlrdhlvghrtghhnhgvrhesqhhurghn
    thgtohdrtghomhdprhgtphhtthhopeihrghnnhhikhdrthgruhhstghhsehquhgrnhhttg
    hordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xgeKac2oGFnBC_zj0PdEZGedJiWaMkgMfuaq-Uo9_s6Pb50rZy8i6g>
    <xmx:xgeKaa7h2MFbKHQQz_G7txGOQZb_gpTVvVDEnbwPGj4XVYSy3h-Umw>
    <xmx:xgeKad_Kz6bz8B1cfH5UdH9vSPDgU49VLY7Go06mMslDh6SzSVYtog>
    <xmx:xgeKaZUWLJL7iXxdh5rdgKeZ1dWod__Ew3fMhBppnhFyXO_zis29vQ>
    <xmx:xgeKaXhxhw_z9QogB228LKNQGvMOibTj9Qr8lStZT-utEHtZ-hz7RrjZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 11:13:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Yannik Tausch <dev@ytausch.de>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org,  Manuel Lerchner
 <manuel.lerchner@quantco.com>,  Yannik Tausch <yannik.tausch@quantco.com>
Subject: Re: [PATCH v2] merge-file: honor merge.conflictStyle outside of a
 repository
In-Reply-To: <aYmkCLbhZPPjKqNK@pks.im> (Patrick Steinhardt's message of "Mon,
	9 Feb 2026 10:08:24 +0100")
References: <48B1AA62-D7FF-439E-B770-1127E1EE0E79@ytausch.de>
	<xmqq4invm2dk.fsf@gitster.g>
	<3724733C-FECB-47F5-841C-84DE9792332D@ytausch.de>
	<fa7fc215-03eb-492d-9af4-457482c56a48@app.fastmail.com>
	<D514F3BA-36DD-4DAD-BF73-609730390A27@ytausch.de>
	<xmqqqzqxczeb.fsf@gitster.g>
	<75AA7DD7-F8D8-48DC-ADA0-74E56CFF351D@ytausch.de>
	<3488DCC3-D127-465B-BB95-3D87BB2E48F6@ytausch.de>
	<aYmkCLbhZPPjKqNK@pks.im>
Date: Mon, 09 Feb 2026 08:13:56 -0800
Message-ID: <xmqq1pit7v3v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Feb 07, 2026 at 10:37:48PM +0100, Yannik Tausch wrote:
>> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
>> index 46775d0c79..f9de636884 100644
>> --- a/builtin/merge-file.c
>> +++ b/builtin/merge-file.c
>> @@ -95,12 +95,10 @@ int cmd_merge_file(int argc,
>>  	xmp.style = 0;
>>  	xmp.favor = 0;
>>  
>> -	if (startup_info->have_repository) {
>> -		/* Read the configuration file */
>> -		repo_config(the_repository, git_xmerge_config, NULL);
>> -		if (0 <= git_xmerge_style)
>> -			xmp.style = git_xmerge_style;
>> -	}
>> +	/* Read the configuration file */
>> +	repo_config(repo, git_xmerge_config, NULL);
>> +	if (0 <= git_xmerge_style)
>> +		xmp.style = git_xmerge_style;
>>  
>>  	argc = parse_options(argc, argv, prefix, options, merge_file_usage, 0);
>>  	if (argc != 3)
>
> Makes sense. I was briefly wondering about error handling in the old/new
> code, but unknown keys are already handled by `git_xmerge_config()`, and
> we'd die in case we see one.
>
> So this patch looks good to me overall, thanks!
>
> Patrick

Yeah, looking good.  Thanks, both of you.
