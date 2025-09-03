Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9552010EE
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756923661; cv=none; b=tZcbROp/2myRYd8kkGMcSA3n8rMjL29PGsM8SftaZKcjelPjmN0kZeWX4cnOxR0qfzYnLbQr8Ts5wIX4SXigQkvYxynFpx6+pAl2E6Dsgv6x5fxLMlhXCx9IezBj/8gdBjlE6pfz3aMyAYTI3UTBZwUk3Nd5O7aos0CB85i57wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756923661; c=relaxed/simple;
	bh=lkdOo7MTTcFCE/rBnGtxjnociWmDcbspiBZrDqc+GWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oTbNfsRw4sAd4tPuy1zS1cDVWUKld2gSS7q4EsEL/WbR+OZmmyvpbqxWmmJDVbNHUdSON22Yavl8oa6DrgOTvzoU647zxQ3NwMWKpEhCVv2ulEQAmY2pl30Mm2xLLkBD+sydL+ICi5kA4cJbJINqq7VMgBva66gg4qEsLiOyIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fl3nrrsF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XblIkfcA; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fl3nrrsF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XblIkfcA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B3937EC03E1;
	Wed,  3 Sep 2025 14:20:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 03 Sep 2025 14:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756923658; x=1757010058; bh=lkdOo7MTTc
	FCE/rBnGtxjnociWmDcbspiBZrDqc+GWQ=; b=Fl3nrrsFExnam7961TnJqrS1Lp
	t6y1NYHicwqHEdEqAr9LV8q5DTMwKMRjdc6LZEMTiEykFd6IxYZx1EkyjM+i9adb
	lOXNWWwiytaX0OHAtfqHtwY6eINuxfULOl5KvqazvKxjUbTVNk8CYRTfsNZUlYts
	WGySgz70X4iTD5at61ZrA6FKyL/2McwVLv35bKSeSbifkwyP4mUnN/986gMQJWFZ
	y2qtEBS32xRx2VoEqALwpgOeV3wmEz/bqBWnpquL2CSWInxHBuieoec5TGUHwyIV
	8bwxVT7FjlkUSBL/eRUEO7eK2LeHO2xdB3Q2WiAG7PBo9lce6h9wjuvVsP5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756923658; x=1757010058; bh=lkdOo7MTTcFCE/rBnGtxjnociWmDcbspiBZ
	rDqc+GWQ=; b=XblIkfcAzedIglFNbHatABBO6/lQRRCF+KIqtDqm1cfRZeIcML+
	YRdO0BrnrbKIomIEWLE/Ne5RaIS9Ha0EYRrqZU3BLbhLjdYvOv9dpQTYsutAobWr
	ClN4u5Tr2C0oBwVlLF+2SrmmSifwSpb2ONEOp8TnT88b2poXXyAQGT33Hjin1IOa
	m60tDNhA1G4W8ZoLbFlgp2St+ldwyt9IIJTLE8fRo11TH1Os1EidtPjTjnl5ryxQ
	Q59zEgOqzOKU8T+Wc1IvD2NE+SEd2QKE3y7bkYfhokMqdn7LcEEgcUdAeb3K7a7I
	HutthVewQYuCTExu98cIunhFmriLlAgHB9g==
X-ME-Sender: <xms:Coe4aIIYQG4TzXcK6g3YeMEu4KtrWUNC5xaAF46a1qbLkkPUPopyRA>
    <xme:Coe4aDrOOX4njNa8YTmLF_9U2yzfsD2sIZm2JBDUpuqBMB0asqAQr8jWdrxj63FT-
    B9DWjSAoHmLHkn7UQ>
X-ME-Received: <xmr:Coe4aPIU_px-3_DR8AfA2ga92F2L0LPpMsNYfZFOTSSX6J7q41tXVwuzYF__zmlbaALz6Ie7NIVRgfjFwU8jfTwEu4Ze3LnCU3wfQZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieelffdu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvggvthhsoh
    hniheftddujeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Coe4aAQULn8B-m4mKMNSbec6Vu5YISsna8IJI0WByO_4OZo1g-eIWg>
    <xmx:Coe4aGt3RnwtfLogxb9ckj2h-0K5qBIBC4p1akcIfD5Rcp6wzr70Tg>
    <xmx:Coe4aJZCKHBK3Stt8L2V1eJFC5J5KKhsSlbyUKkVTh1wyJN-B2XORA>
    <xmx:Coe4aEFfsFq1NeiAvVhjXJKOKz67Derk4nR7Ki_-2TncEuCIAM2dJQ>
    <xmx:Coe4aHoC2M6q0yRYDEPNi5_1G0euJpIkfelolNVdvQr0USjjAu-cszLb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 14:20:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Meet Soni <meetsoni3017@gmail.com>,  git@vger.kernel.org,
  shejialuo@gmail.com
Subject: Re: [GSoC][PATCH 1/5] builtin/pack-refs: factor out core logic into
 a helper
In-Reply-To: <aLfZflWT4618ptCA@pks.im> (Patrick Steinhardt's message of "Wed,
	3 Sep 2025 08:00:30 +0200")
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
	<20250826073645.1074397-2-meetsoni3017@gmail.com>
	<aLbEWSHUotkmSiCq@pks.im> <xmqq8qiwgl9j.fsf@gitster.g>
	<aLfZflWT4618ptCA@pks.im>
Date: Wed, 03 Sep 2025 11:20:57 -0700
Message-ID: <xmqqikhzfldi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hm, okay. I still find it puzzling if the header file for
> "builtin/pack-refs.c" sits in "pack-refs.h" as it makes it very hard to
> connect these two. How would you reconcile that? By moving the shared
> logic into (non-"builtin/) "pack-refs.c"?

Yeah, if that is not happening, then the change is only half done, I
would think.

Thanks.
