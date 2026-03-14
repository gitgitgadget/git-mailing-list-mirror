Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B41684BE
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773509066; cv=none; b=EaN31TprCKpM4WoU6Ovuree1tMSXqRxdtj5sDYgAggF5ppufksODXxSBt9o2aVJ+8QeM/smoRe7YOy4hfLpYTP9m8xkTkUsxQpRXCZBHDUYSFLRNzu33C/ipJGOsEcTp1p70k8T3ooqQY9EcIdLAxJcc8DwHsYW/5JK73GFiJhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773509066; c=relaxed/simple;
	bh=TCfh7f0VvAeKdu0kzWusdOdzWltE3jRY/oWjmCx7Djw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aFGLrK6r+iUtd4xPs8luK+87AZNUBSScO/56gNueHSAs4SZtdVxPN6QzwvggeEwTnFqs/UL++EkRQubqSFY+eX/EwWATh+vrFHg5aH2344FT9QZx1CEyt93g+6VEXY8r/PoIqbfugrXQWsvAw71n7L20SnPgcsMQ9vOyzaPga58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a3Nd2mTi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yfs07Hvr; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a3Nd2mTi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yfs07Hvr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D438D7A0067;
	Sat, 14 Mar 2026 13:24:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 14 Mar 2026 13:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773509064; x=1773595464; bh=cgOACVvKoO
	dd6lUL4MVtE4oRW9aa1Wl3haaeqidycUM=; b=a3Nd2mTi/c/y6YE+uk9n2St1TE
	AJwTQMPFSt/LwkGTMobug4ptOei+JlKwiFaQmLb/7CHJgyFmv2BwwMjr8mRBFbTH
	fs2PKERchwd0MSKPyZ2hnirMpZN7hy9D1H/0lvnJLXtYp//YHMIiHraAGwsqsYeG
	rzNaPNfquoi3XOz42fL8WZ4WJiWGY0LIe4sixI+I/UUAmGGjaquAF9FR+OzClc0A
	wmRZ+6u72/cwMUL1o7pEr+SnkBzXpxOhjA4XrRnB+WsLZ3NLahz3sFJWiS3kGRG5
	37ddcULRNp7YsQAhfM+x/4xGQa7upgksW0QhIMgEi9kjk2+FsVPb93bNEkcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773509064; x=1773595464; bh=cgOACVvKoOdd6lUL4MVtE4oRW9aa1Wl3haa
	eqidycUM=; b=yfs07HvrKrd0NFk7GYV9NgWjy/wTS7qBv9Rn+4Ej8q59icsRXXk
	ReoCJF2Of/OeJcnsQLYGdirWh/lYGNbOjEZI9w+5mgL0MZgqnJUfCIT6Lh3IlZW0
	EEdEH+jgzqgp/IxAmpw5rRTV5p/84nhPxfrowZ0myrDRr5wOIvjg5MpE7Ba3lgG4
	3g2CWYbI8yrss6N8Hkvm4nF5iaBFf+yxeeV3UUdy1CAYyegiEMXRKFVDWcdCtaAY
	utOMEoxvfVTzRBO8bq3xjIsvT6JQqLupB1NxETylR5OxU2n0nJ76e6fE1/Fh0OVR
	vlheuS//J7whF+NPUGUhGiDHxdwwWQt8GKg==
X-ME-Sender: <xms:yJm1aUzzjuhqntOJ4gEQ1G2Q_qQRu9dfYLJY7vvcIW-EMWQTkR3bFw>
    <xme:yJm1afSfsgiOJf4dXj4fyXvlCVuPporfltIZd__jgt480mJKiIgHZBkn03awxMGTu
    2MXQvGWmLGSjZrlwvljwT8c0IFIam2ZXQZh0R2rmRTHWJAKN3F2WWY>
X-ME-Received: <xmr:yJm1abVgnaqC2s2kE5Vpaw70JHhCOsvUjkDHPrHx_1Niq-jQjUYagr7Wo-hfrmwKdpQN1O_8N6bA6wR06ePQhLhjz81kZKkaew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleefudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhff
    eggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtoheptghshhhunhhgsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yJm1aRbZ4P8_IVuDlXwZPje4GvkFsSNWN398zNP6NUynj2fMnw2PMw>
    <xmx:yJm1aR1oT9eGEAyhujX64NdY4NcHWdBFWz7RnQNezOa1JdzWAMuzXQ>
    <xmx:yJm1aTiwq3P2uCkOxrWsD517mDVBEGpDPm_XPRuFg6qfEDNMJ5SS6A>
    <xmx:yJm1aVZr9ws08yJPDfwWQu_mNpVxza0ZY4tlke0SMCZ4p3tBA5r0_A>
    <xmx:yJm1adRl24OdU3jmcry1_C9CgltI-UUYOg4rP7Du4JTFIygve9NJckho>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Mar 2026 13:24:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Andrew Au <cshung@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4] transport-helper, connect: use clean_on_exit to reap
 children on abnormal exit
In-Reply-To: <20260314160814.GA918806@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 14 Mar 2026 12:08:14 -0400")
References: <20260311184206.GA1911377@coredump.intra.peff.net>
	<20260312214945.4050010-1-cshung@gmail.com>
	<xmqqsea4aen2.fsf@gitster.g>
	<20260314160814.GA918806@coredump.intra.peff.net>
Date: Sat, 14 Mar 2026 10:24:22 -0700
Message-ID: <xmqqikaywchl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>   1. Many types already have a repo_config_get_X() variant that handles
>      this for us (e.g., repo_config_get_bool()). But neither colorbools
>      nor colors themselves have such helpers. We might think about
>      adding them, but converting all callers is a larger task, and out
>      of scope for this fix.

That certainly is an interesting #leftoverbits project.

The patch looks good.  Will queue.  Thanks.
