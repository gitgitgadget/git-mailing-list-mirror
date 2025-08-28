Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B5122A7F9
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400757; cv=none; b=W/L3GexwBZlyKW9Mf8COKu73jh5gmTGjqXQng7LuoTuxSIyNhTKWF8oKeFO8Y60SAlRyN/ETYi2UIxLKxY0PcCM44t2UQuIXLuDxq4tPG4FF8jBdPhNfimZbfdGM8CuImx8/eroGdIFX/310bCBSEibycbO0ftMktvzpk4zxpyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400757; c=relaxed/simple;
	bh=fFJiBlDDKnASXKjrBWJVllwRIIrnN94jqvP5YBxywsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bTpfOyTINOUmd+rvRTGSCcGWJar5thLjQ1ZZavOxMwm92xW3/jzE1nYaBVFgrXoPPKEFXdTZDeo/wwgOT3Sa6IeLT6ARkn0+11YdcsERMqL+v8NRdO0DzGQoJvZp8AGljYmZUd2UpKyIAxhJN4g4NmRHhGR9HlKPsfCVWDFF8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KxohQ0zx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F8ZGEPEY; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KxohQ0zx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8ZGEPEY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 990727A0191;
	Thu, 28 Aug 2025 13:05:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 28 Aug 2025 13:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756400754; x=1756487154; bh=eB97KK1mHo
	OxYezTo4izV57pCsvMKDPcrV9Zy4la8/4=; b=KxohQ0zxR0nJxloaUkRKlFjVrh
	iPWaMPKhQ285SIDAba0Y5gI5WDxSOtVTGJbO+pPkGNuZ7bTrNkwgpZNzGT2tgifn
	MqmI9g2jd63v7RCO9hKr3lRmw4NQ+lskzRFkMBAQ+MC0s03aawg8mATvMG3B+bAK
	affOcwgU4QHcJKWaqmLq0EV22VLxGl11z1zzXSbPKaM+OBiHaSGHnhO9I3cxShBv
	shKu5AfB72FrlC+9AoBCijqm0/t26XPyjFfM5YrGTxNi7tshcMVA4Lz32IEu3UIS
	V/BtXMXUIRMIXsI00PvsKG4QTyKwxyPNdmDhGvZEpIyMz9n6rMFHYaKAhrsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756400754; x=1756487154; bh=eB97KK1mHoOxYezTo4izV57pCsvMKDPcrV9
	Zy4la8/4=; b=F8ZGEPEYyeH+1c2zlP2YdhhQfHxOh5IWBOCfI1SjeaMIQl/BNRK
	NjOqLGllSj/qzOetR/n/03tZEidsOQ+Ntbu5Zjht6Us0wQVekFbT6qBco9J7pr1M
	W5Xd4N0bksfVn+AXNPoeBwS2Rf5kCmWqlkHzo+aNTQlvYvNljqHQBPhBx2I9bMmr
	G1PCsFXnnMBXwX1MZMtYhOQFoCbaGQSwqi82qYC3HWjHr2DfkHLHhQqI1jTFwdF+
	LA5DQ8gLv72lSqY746EXfqXAfghvSWQknXwGTHRR3wxG9Z7X+2s3pMNoKRSy777j
	aecave0I0+0sTnDtkO3+oNow4Z9DUOoy2fg==
X-ME-Sender: <xms:coywaMT9Az0hiwpFK2y5ysB9QIYKq_rk7GgVJKm8v1t_cq-01Lp9Gg>
    <xme:coywaNAs363DP2BLGUYNv7i3Ki45Tpmlb9fjJA85aH6m7DZBchTpuUe1n7HEwvL63
    QD6jhRlx8rymR-35w>
X-ME-Received: <xmr:coywaDR40yIk4tBZxtjzuQ9JgYm6e0kTSNEFIRKFUrt3q_rHe-gMALeJv8VqtcQbtLQT6LnzOsz68iJD5A0VozNMvDHfomT6gwe_hks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeduheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggrnhhivghlvghsrghsshholhhisehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:coywaLphWiRchH8e_j0x_7obmGhdzmd1TU8HnaOKdxe8iocdAJFgYQ>
    <xmx:coywaFw5Uhw4RzasXW3yq-M2g4rY_bxzoUitGeSBApNkkZxQ2unWSw>
    <xmx:coywaAIeLgWeyeXIgKE5C2J6qTUSwqhDN7wpyUwKqOxLq6QtewRGpg>
    <xmx:coywaHJTn2zueZRzGOumCGWKZftmSAkLH0fwFDacYq39RJMmtd5rcw>
    <xmx:coywaFrFrU0ILlzcV-4-xBlq0rxvGqUUaQp8u1ZpWm6QNtNZhbGbKVhf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 13:05:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Daniele Sassoli <danielesassoli@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: question: what does "garbage" field in "git count-objects -v"
 represent? Is it broken?
In-Reply-To: <CADR1ei4LFVoLhMyya+wx8dXBmrRNSNy6L5Ye_MJgL4kzgtVR_A@mail.gmail.com>
	(Daniele Sassoli's message of "Thu, 28 Aug 2025 18:32:10 +0200")
References: <CADR1ei4LFVoLhMyya+wx8dXBmrRNSNy6L5Ye_MJgL4kzgtVR_A@mail.gmail.com>
Date: Thu, 28 Aug 2025 10:05:52 -0700
Message-ID: <xmqqy0r3v0jz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniele Sassoli <danielesassoli@gmail.com> writes:

> When reading the output `git count-objects -v` there is a `garbage` field. At
> first I thought this would highlight objects that are considered "garbage", i.e.
> could be garbage collected. However, I kept noticing that this wasn't the case,
> despite my repository having plenty of dangling objects (that where removed once
> I run `git gc --prune=now`), garbage kept being 0.

count-objects is about quick housekeeping stats and does not (and
should never) analyze reachability like fsck does, which is required
to tell which objects are dangling.

> I then turned to reading the docs, which state:
> garbage: the number of files in the object database that are neither
> valid loose objects nor valid packs
>
> I don't think I've ever seen a definition of an invalid object?
> I tried adding random chars to an object, effectively corrupting
> the repository(which `git fsck` correctly picked up), but
> count-objects kept returning 0 at the garbage field.

count-objects is about quick housekeeping stats and does not (and
should never) analyze object contents like fsck does, which is
required to tell which objects are corrupt.

> The only way I've been able to get count-objects to report some garbage is by
> creating files in the packs directory (or in any of the sub-directories of
> `objects` folder) with random names, like "test", or sometimes I've seen it
> report the existence of lock files or even preserved files.
>
> So my question is, am I fundamentally misunderstanding what garbage means, are
> the docs simply unclear or is the functionality not working as expected?
>
> Thanks for taking the time to read this and respond.
> Dani

You are fundamentally understanding correctly.  The command tells
you it found a garbage when you do this:

    $ mkdir -p .git/objects/00 && >.git/objects/00/tmp-garbage
    $ git count-objects -v
    warning: garbage found: .git/objects/00/tmp-garbage

