Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D821ADC3
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024010; cv=none; b=Ku4iNDS0I+OndnG3F2X9EwomMu08VJTzAxUMF17azYW7BB4WpBuEkUWncf6r5tlmIyWom8bma6lp/r+x8L33ovdKg77/s+pj+i+xg7D/d2kLv8w2AVgngMEVo0SZhYnJQdgTqzNBqqUD6rJt+fKE+/5x0H69O/pKFMZfv8ow72s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024010; c=relaxed/simple;
	bh=TS1nh5d6BRqeyCu6fWUSqm9FXuwpfMf2EB4BtWcDZJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mV6mka5dJU2yXvLvIfPIXLU4cHUa2U3Oo+EOVErnsWhwA1TP45aspSC0gVd++AGSHAPT+aH/YKiI5dhn84rL+Z4BLSnCf4sT+DV/qOyNaAikueLNHm+qvtQeLosl+3QufS6hsCYT70l+nwb9m8ULaBpbrLARldqz4eTL+rocbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=blYW6Pp/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IFsIx762; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="blYW6Pp/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IFsIx762"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id ED4FB11401F3;
	Wed, 30 Apr 2025 10:40:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 30 Apr 2025 10:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746024006; x=1746110406; bh=TS1nh5d6BR
	qeyCu6fWUSqm9FXuwpfMf2EB4BtWcDZJg=; b=blYW6Pp/8L1YiA/IteQFAiQLW7
	Rn5zO2/qjxi/tdXqRrHDK4Gr02QLcYsVVB954pGWz/jA4s0BRUwZTlK2dN0TCgJd
	UWsf2YaPTOtuUFymJNaejRbOhCB2xUNkf/bjOj92n4suwo4Zr7ETvWOT2olV3gU8
	53zKU34r6XwXhi2N0Rw3FmDeXqsFbphCi37KM8ePkm57/k18nFus/yzRCbNxD/5R
	CXY9vqIjbOwXhM4p2wsnyRkhWCHItExQpx5M0p4ZtMzFohiORI0Pv0UfRb+E4Js/
	BYem9FB7G6mgccrqfn64t7ybrv/2yGukHGxGIFWZJeaZFzDQCNZYQFT56Dug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746024006; x=1746110406; bh=TS1nh5d6BRqeyCu6fWUSqm9FXuwpfMf2EB4
	BtWcDZJg=; b=IFsIx762qr4b7EfNvnz6XyqHKmM3GaAlo5Y+6cRajimxOnK/vPe
	8wMs9Mdc8mC/t/FMRRU9AhmW6skBzJtxf8UUqGHWLGGpTrjOZQdPNKBONIFAdX7p
	l9PpY6oZSx3rWcwMtBC2l8VTspt5loo59GB3OaQHjL93EX6H2mvG4zROIiYH+zSd
	5fRJdaEVwKOdL7JHrSOdGWIblH6fgqHogJ0DJ0kR9OVz9grpZJmd8OF4r6Il/eze
	xgTDd2+e+TsNPSswR3Em1ZGlO6Bod63rNqux4mOQTD5bv7wZiUF2llQQpJmbVg0o
	sJyxjo0vMDeMv7kpxSBHli+AwCBMG56JtQw==
X-ME-Sender: <xms:RjYSaC6qVdVPoOdUy5MaQQOxVexL1xJ5sZaORt6B5Tcl6b7U1UN-ew>
    <xme:RjYSaL7lvNoonwb2iFJVztfYbJmyzsC0QqVPcwCKI5B0L_-4WL0xnap8Nriti5l_U
    96QOkvWgcvJzEJRtQ>
X-ME-Received: <xmr:RjYSaBfeXl9hWviic4CyiiW9l3mery_ac4EFTl5IYncsEUlH580doR8uMgnNIXdS2eOjKYKgaK4d8CkfrBVfy1hCA3sJlDSpxJAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeileeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvohhnmhhitg
    hhrghlrghkieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RjYSaPKlBMs6gM4NXdB553_fDkCCgmASNapVloF4I2iosGpxo86W_Q>
    <xmx:RjYSaGLYbbFGBFU0XY1zytOu9ADSX55VSPFrmOd42WY8N3hSgRgNgA>
    <xmx:RjYSaAzKazP7oIhu4yZZozXi4BMfjf3jL9zAZD2Z65MHy64dXWfSCA>
    <xmx:RjYSaKJgGdqGX-0sXAHLoVjwJ7hbxv_pc46jHodOVEqeOW_Wv3q07w>
    <xmx:RjYSaMDGeDJa8E3WNYw1aAa7u3yTLuwxNnmBjDJL03JMCGyldtpKFV0H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 10:40:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Leon Michalak <leonmichalak6@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: Discussion for interactive --patch commands to get --unified
 support
In-Reply-To: <CAP9jKjF5suY6mx19knKwWAEHrTJ_meWhktOuMTFixq0hmFsjuA@mail.gmail.com>
	(Leon Michalak's message of "Wed, 30 Apr 2025 09:04:46 +0100")
References: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>
	<20250429220933.GC36727@coredump.intra.peff.net>
	<CAP9jKjF5suY6mx19knKwWAEHrTJ_meWhktOuMTFixq0hmFsjuA@mail.gmail.com>
Date: Wed, 30 Apr 2025 07:40:04 -0700
Message-ID: <xmqqo6wd3e7v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Leon Michalak <leonmichalak6@gmail.com> writes:

> With all that being said, I propose the following:
> - inheriting `diff.context` and `diff.interhunkcontext` as the
> defaults for the various interactive/patch commands
> - be able to override these defaults on the command line with
> `-U<n>/--unified=<n>` and `--inter-hunk-context=<n>` respectively

I think the usage pattern when people use "add -p" and "diff" are
different (with "add -p", you get only one hunk at a time, and you
may want a bit wider context to avoid getting disoriented, for
example) and I agree that it may be useful to be able to specify
different context lengths for them, which the above should cover
nicely.

