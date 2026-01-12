Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5723EAAD
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249046; cv=none; b=rHIgvGvffv0jtqEs/fgamyo4d2jwE+OC5QyQurVnJ3qBq9r58v3Gv8cs2eJTDT75+++YEpsB4T/kfY2Ngd4nigePATYHZFl8daSXFlwdkFkT+uXqwq5A2THuJR6weCGG48Ra61XfnKwOlXSe1IpndDvL78JqQLx3zMOWDXoAseo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249046; c=relaxed/simple;
	bh=X+WQHIIT0WfNsqnOgSVzw1bcT0/f9I2DFdYcs6SjpYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TXwdHunUmkBVgJL6pt6sB2zehPmT1iMyawa+s4rgAfXf3UKVhCj0eSAMoob3NKVMge+HguU5tdxW7so27FxG+XriHrBaAEnjc4pUej0f9gLS6VxXi4lFQ/rHlThmI32Y/RoN+BM3OOUW3Ha21l2Z/iLOIGNrJkonQba9TwbPovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hlDd+uLe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xXr0AW4Y; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hlDd+uLe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xXr0AW4Y"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 488C21D00126;
	Mon, 12 Jan 2026 15:17:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 15:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768249043; x=1768335443; bh=WTGtPKPucD
	lkt9dbTLj/JdBkA2UGnIl+FCwryQPdgKo=; b=hlDd+uLektnN6KR0L965DnqICf
	tZruJjp4KqUJc/RSnr+tekgR1oq7OrBizV2ur0q5aSzHzzAgDqQlZY54Rp9A+2SW
	TigkpOAcO4oyCjRDi8cZDTmStpujj7T/D3KYx7ddgVbgmZe8O7QA6ofcrJF/2vrH
	e55T2U9SqgLamMmWrVQKByYsbnQ0U015MniZOJV7G09WJD2nishmrLwtLOrjtv+O
	NtAKXL9+pGcgIznkyxqKz5k3uzdh5YX7gH16HTWsyRkW+3bjOB+unlKmT5IdeuI7
	pqR+y2qecTDvXK/7bHertYkQNfgFvUN9qx1IAlDORyPuub8UQg4GGvKRBGAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768249043; x=1768335443; bh=WTGtPKPucDlkt9dbTLj/JdBkA2UGnIl+FCw
	ryQPdgKo=; b=xXr0AW4YWH5DAOGdW1hyuaDv9W7ZNus58CHOHFBhe36vAhkbJ1K
	5p+G7EY3Nud5H94pPpxCcOhXBE1Y5nhLmgbM4QkoUWCKO/c4B30ZXogmfRwFBm11
	Hv133b91K/hQGJr5qUlou6j0WNQP7BwSlJxpeRAwxtQSrhrFl6idKqOboxJxd42y
	0uKXqKh+OF7TEGbZpe9jKELBNRyyGI4FnA8x5AEpo0Ct6jBHLd6btgv/XXKP6A8j
	G5/9jhMdza2T8dW0RG/9RlBMpPbnhGa/IZRNT8njr/Cxr0DtB2iE2Kx6ii+bKiPN
	LO46K6Spfk/+ZcddEFf1yfHsGa36tSOpaHA==
X-ME-Sender: <xms:0lZlaa4TgRmx1aNkfkWZahFG8VN7SyAZPSzoqqNf7bEHDJpEJ3O6YA>
    <xme:0lZlafsfPZncloxMQx0GkmRcq8EgNWXAe9EoDYrIIL-A9SJhUFlKDFEyccHfcVXK_
    o3_BWebc6xEdqtbzlKsC5Y3Ijo0ECoaMY8cL9sa8NGeB-CZxncXLw>
X-ME-Received: <xmr:0lZlaU1Zdxfdh9bYUGwzCdZkTSWEg3BvM52gcnRvomPDHVxPX3CZ5VGdNC9qyEtl8nLQwbWz9zOJmi5TbhGU5WD9rj56CwsIzx70VsU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudekfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsoh
    hrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtph
    htthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:0lZlaQpxtoNigKQv2Ia9Hv3-kCBo5QSlBQHQfWwaLJS2mXwwGdoUGg>
    <xmx:0lZlacKz_yXEJvQMDCTIvcf8WUzqfBg2ZfCfGZ17gVWF6C2KGhJcXw>
    <xmx:0lZlaUSnNgdEWfFgA3CSterI1DPvkVkRWXsYEo2QFiOblhXPtHod7A>
    <xmx:0lZlacNd1SA3NJ1q1nqNQxvNkjfrM7-OWRXZHgVCVmWpkbrzPNc_Eg>
    <xmx:01ZlaZ10ExTqGgCEGC9Nw_M91Wa2MCXCowDVyyjrR-QsssdiJtiLOKg4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 15:17:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v9 00/11] Add submodulePathConfig extension and gitdir
 encoding
In-Reply-To: <20260112184632.1334495-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 12 Jan 2026 20:46:21 +0200")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20260112184632.1334495-1-adrian.ratiu@collabora.com>
Date: Mon, 12 Jan 2026 12:17:20 -0800
Message-ID: <xmqq7btmmvqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Changes in v9:
> * Replaced git config --global with test_config_global (Patrick)
> * Split die() messages to multiple lines (Patrick)
> * Moved some of the whitespace fixes added in v8 to the commit
>   which actually introduced the whitespace problem (Adrian)

Thanks.  It appears that we are getting to the point of diminishing
returns, perhaps, in which case we should declare victory and plan
to merge it down soonish.

Again, a report like Josh did previously about this not breaking the
users you care about would be very much appreciated.

