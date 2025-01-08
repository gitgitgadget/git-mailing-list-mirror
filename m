Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A780604
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736356173; cv=none; b=OWoVXOsx/MDqglHnZOK4hCEpjTX6u6sB1ajISrr/TGGVnIG4DRLDk3v24BJ0lyd8+JRx1bO/aqi3KrBVJbUPFtvjxE1azzoSgnzMc/jXXKNdo2fhCcWiChZXggtXBTet2vJ95peeopTh+6ywoc6eumoq7xp3a9DF8p9l2PVTxMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736356173; c=relaxed/simple;
	bh=Dhuf7kOQcQA69IS0jZePYrV9JDYLsHzTTNwF3NtyV9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QABjNIjpNebRGylAFCBQfNpkprhOAzeg/IJSvXqedURwEW58aHLCt7VWyW2gMQwQIEfCcQ7dUoC2oxN3fEJgzjUpD2rmSi13jk9CSLtq/BCyublXKAVjFV5Quo+Zu4SrJoeCGfZE7cMkp9tYv41HXrDknKgk05cf3UqyIo3AI9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=El/uQzeI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=STuVC/Ph; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="El/uQzeI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="STuVC/Ph"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6D0CF25400EC;
	Wed,  8 Jan 2025 12:09:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 08 Jan 2025 12:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736356170; x=1736442570; bh=H8RuchrrtG
	HYeQQbIUFuy92SIdFf0l9NIMDlK4LRpK4=; b=El/uQzeIVQoa9Hj8YCgYHs/Tbx
	Wlmbo95+/3hLmUzcSoH4E/u5YVSwSpV+0LwWME3K+URMZf15kiFCe/ulvL3S8z0S
	nCnyUIM2gs/pnjt6y5h7+CQsSgp+RupHlVe/V0hto8NF6VrQiwP2y678DYMCZYD8
	HZDu5PR8An+q0FuS1oji3Wy4TGyJPRrHrGYMNEKEcFmP9fbhdt1X6i4E0umDwv/X
	YHDuxvlBpm0HuG5KJx46+SXdysVZl2Jfu0Ex6D72U5aqagvqu7TNXQT9e8CsAAgR
	sxDXknk81zDkskhGqMjrJEw7YiFTYUDYhZOdJAQAT9UD6fRD17RXBQ/tjsRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736356170; x=1736442570; bh=H8RuchrrtGHYeQQbIUFuy92SIdFf0l9NIMD
	lK4LRpK4=; b=STuVC/PhFxJ3H1X+XwhCuPvKd2rLy8vLAXnlxRTC84pUMwHaBHS
	/ba1SDKXEuevrU954LBWo1IyAJrqcbc44okWWj0FbFVwUHI/V3OrrFDzsA7NXHkT
	1d7BjbDqDKa/OAsvi6H3Ol7oePzBIIrj2jC318Z+ivo2l0DeqrJ2XHk5ljLD4ufX
	Sp6tCSYTzTBGEz2u/IXFiJkUOkvnn+BgR3VikhD+uUc99moF/mQo1Zu5PGm5jRfm
	0clJF8Blfd4J5Df9tZwf2vACee5mZHuVkA8dU5vcj4LPe29PtkUiEgS5JRLqVKuw
	1jtPYsfddEgw1G74BSl2vlApY9YZdjr0IDg==
X-ME-Sender: <xms:SbF-Z_FvdESSHWZuyjw4mFqSrMTEa7XgHWDTgvsMPOz6Y9YnDZg5qg>
    <xme:SbF-Z8VLSDoeExwHeBsWhY2Dwm6Qx8FpX0Y-90PUyotKD1QrNDtqUH5jUzGU2LMcR
    IvsUjK7XfNp6Ii1WA>
X-ME-Received: <xmr:SbF-ZxKZ12svZLisEqxr3AtbTzEe_gIdS-f71Ob0i46AXRElcXspR3-dg5p2Us9T5Lu6qXP_i5ueObXV6naUC579wWTCrn-WzE82>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphht
    thhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhn
    ohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:SbF-Z9HEzZvqddFc9rFBfGLRRWcJo_X1qQFy9_PSsU6MsQ0HwGRBAQ>
    <xmx:SbF-Z1VXYCCzot6lH7pwVzuIN7JS4FiMXDtgZwTW2fVVYwq4NDEpDw>
    <xmx:SbF-Z4MpvhAeNkZr5-xJoHKAWhsgoIA8peqh7R8c5itszSD6vVxoAg>
    <xmx:SbF-Z03wpEvA82c6nhwsysf-dPNegsCOsLhOd30H4TvKa42RXK6lKw>
    <xmx:SrF-Z3KzEQ8_Pfmx4p7-q328vJ--gQam0RB-61W2LUlMm-cThBOuFVj5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 12:09:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: rsbecker@nexbridge.com,  'Christian Couder'
 <christian.couder@gmail.com>,  git@vger.kernel.org,  "'D. Ben Knoble'"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 5/5] remote: announce removal of "branches/" and
 "remotes/"
In-Reply-To: <Z34c3rj0E6hP_kHN@pks.im> (Patrick Steinhardt's message of "Wed,
	8 Jan 2025 07:36:14 +0100")
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
	<20250106-pks-remote-branches-deprecation-v2-5-2ce87c053536@pks.im>
	<CAP8UFD0Lzazxyq9nnT-vwN=MijKAsYySFC2dvDEj33cS7VB0kA@mail.gmail.com>
	<xmqq34hw0whh.fsf@gitster.g> <Z30hnx43mEwjWqzA@pks.im>
	<xmqq8qrmvap5.fsf@gitster.g> <xmqq4j2avaam.fsf@gitster.g>
	<006701db6124$f16f9420$d44ebc60$@nexbridge.com>
	<Z34c3rj0E6hP_kHN@pks.im>
Date: Wed, 08 Jan 2025 09:09:28 -0800
Message-ID: <xmqqwmf5mdvb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jan 07, 2025 at 11:55:16AM -0500, rsbecker@nexbridge.com wrote:
>
>> I like this but wonder whether there might be some way to inhibit the
>> warnings one a user gets it and decides they will act but do not want
>> to see the warnings any longer? I have had requests like this on other
>> products. Just a thought.
>
> I guess the best idea I have here is to use an environment variable,
> e.g. "GIT_ALLOW_DEPRECATED_REMOTES=true", along with a hint for how to
> enable it.

Hmph.

I may be missing something, but wouldn't the whole point of the
warning be noisy and pesky as long as the user _uses_ that
configuration?  It is not like "you can set this knob and delay the
removal past Git 3.0".  If the user migrates away from the mechanism
that is being removed, we would stop bugging the user about the
stale setting, so I do not see why we want to add anything extra
(other than possibly telling them how to migrate away from
$GIT_DIR/{branches,remotes}/ using "git remote" in the warning
message itself).

Thanks.
