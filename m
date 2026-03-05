Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015713A9630
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722111; cv=none; b=Lbix0G0xy3ebj3dqNJ3n/6JPJBPaCTxdw5t5AcODo9xw8XXj2Z77yHdPSfj9CbAVJqvUt4qcFyDZ8noep2/TdMVnFJoXteTS0fdA5Ytx2JMgPGmuXC1300+tMySTmp7zLchTBb+m6Mixt3SJGt01y5Oeq1d9N4P6ZSUaqgdI7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722111; c=relaxed/simple;
	bh=EGsOgIw7XYPRcSRm0m+HNZwBklmDoVGmgC9EYHzUPTc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=itM2eU1msrkvTLIwzVgyYzgiD7vKlLtZ9K9955nJCZQkiw4hCFGBmAx1QuZAc9HdsWPmmTHQ26CmdVl52c/zhhwpGohWOZK7bFHx9UnojHjhyoU8YAxEEKg9Q8mFcwXZyogFTiMf6Zyl2AGAmABDY/v+OARYtZonAWxgWn6HtOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YHnb5vSG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OQX7I/de; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YHnb5vSG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OQX7I/de"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 256217A0182;
	Thu,  5 Mar 2026 09:48:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 05 Mar 2026 09:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772722108; x=1772808508; bh=sHfsp/yvCY
	B79uEEMQAdCzaHX1wdrCYfm5ffVkn4qTo=; b=YHnb5vSG92jvnrZpSp/j5LZJJj
	cHxP85hQ9whKT8U4mpW70y6YztbA8smH7W+EaLa5ogKRmR6qAjNxdfBwlLVtoOMq
	i4IA0gzTP3QfFm4dmRPK3YTpyR7rRtv7qqCc21I4hgF83pmJvRR/89x73CsJ5NWk
	p0kQOawiRcfCiieNJO/zsR18H5T15M3izlSF53IBdMqBVRuszbDoC6yp2EbKXVBP
	QXstncf4D9Tk8zXdGATINco9ZChgVBUQuyrK5wzK9Vsxzh7QhBCiE9KE+EgOLuOi
	aHaX67fI5jE4KPf48wVQIULI5UQZp4+5XYgaYLVLL56DyShrzdDsVsSlV8Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772722108; x=1772808508; bh=sHfsp/yvCYB79uEEMQAdCzaHX1wdrCYfm5f
	fVkn4qTo=; b=OQX7I/de1XB9i5OvcUnVals1yVi7l5AdyCq92EugZCaQrDXFhyg
	hLsxpt0ToF1RwSb0JmL7xI9lHIXZOdPsuXM+85cxnWWgCsT7hX5KJMnQixKK42OQ
	01iI8lh51nWBQGXrpMD18AaSFtdHfZkta0UE/alLHW1bkkI9ZmCqku1dcH4i7Zg9
	ZLiSs/cv4xIsUOWyleveyyjbIhk4sB40zzJO0I/Kj2fodicoMhKbH9UWy5br/rxc
	Z7/ApXtZRlW0QhgnLgTipuy0AKm+EGG5YcW1Nt9Wc6JWQaQ78VUD/ldCUFz7av37
	+u27/K30qzqm6+kkwttJ0LwhXpvsYUjDftA==
X-ME-Sender: <xms:vJepaT6sM5BBUbE8a8-S3dHv7kfInsS83rezcUhTBnHDe7gL2HUtiw>
    <xme:vJepaSN61UPdrYsgwnRjdoPhx7eJ1O2LD-b4p4uuXq4d1ujV17LjBfMy9yjegwG2T
    ccq77O9tmGUMIlk0SATWHeohnz3qHZlnQc0qCQYUGqn-NznQ_dKy0A>
X-ME-Received: <xmr:vJepaRtCWgbDfL3gEIJWxq-oK3JCugypUbLArseZ3c1OXLQLzHFTGFu4tak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteevteehgfevhfdthfduhfetgeefjeekhfelleetueevuedttddthfdvieej
    teelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheptghh
    rghnughrrghkrhesphhmrdhmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:vJepaVaG5rXhRP2RDsrrGptL_03VE2BRx068DDJ4s4CDl4UNSpbyfg>
    <xmx:vJepaTztKAks6y1Y-g5wmglvNbva5MGURjiLtaaj57u_GlCuYujM9A>
    <xmx:vJepadjurmWFcDHXYwxdh7-yQr_FMK9bV0GXSd4Rif_DEqHpNyEseg>
    <xmx:vJepafmddeDBZHBrWt7SGpTxCoeJUV-ZFxLAgvmsqcPyZ9PuyvmYkg>
    <xmx:vJepaUVcTWwVrUuSfqJlIKsWOb-yctGEfY48x-bEFsQGov2frl1PkJiz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:48:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Chandra Kethi-Reddy via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  phillip.wood@dunelm.org.uk,  Chandra Kethi-Reddy
 <chandrakr@pm.me>
Subject: Re: [PATCH v3] add: support pre-add hook
References: <pull.2045.v2.git.1770822312474.gitgitgadget@gmail.com>
	<pull.2045.v3.git.1772171692465.gitgitgadget@gmail.com>
	<27ee9a9c-0caa-4b6e-a968-51c71c8b6e5f@gmail.com>
Date: Thu, 05 Mar 2026 06:48:24 -0800
In-Reply-To: <27ee9a9c-0caa-4b6e-a968-51c71c8b6e5f@gmail.com> (Phillip Wood's
	message of "Thu, 5 Mar 2026 10:47:27 +0000")
Message-ID: <87h5qujps7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> paths that are staged by the current invocation of "git add". That means 
> if for some reason I need to bypass the hook when running "git add" I'll 
> have to bypass it every time until I commit and cannot check the other 
> changes that I'm staging. It also means that running "git add" several 
> times, each with a different path runs the hook multiple times on the 
> same content.

Correct.  You'd need "git diff --name-only HEAD" twice and run the
results through "comm -13" or something.

> These caveats are rather unfortunate as it means to be sure that staged 
> changes get checked I have to duplicate the "pre-add" checks in the 
> "pre-commit" hook which is rather inefficient. It would be very nice to 
> be able to check changes as they're staged rather than just before they 
> are committed but I can't help feeling that what's proposed here is 
> driven by ease of implementation which leads to a rather incoherent user 
> experience.

True.

As I already said, I am not sure of the value of the proposed hook.

Thanks.
