Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4EA2DEA7B
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808347; cv=none; b=V5KajIbhsXWNMkhyPK4GbxM4D+r/cpkQDbmmiiSc5WxK5Pi/pTlDME6pNzBUGYJk7lAwJ+5jhAkKI2xpfNQg4z3j1lWA/iSfpHSUKaoo9fJxVM98AMbQ7xKd+f4D9x9GkiLpO3CPHm1UTBu/zqRz39QK/8gCSA8gz3jD8/QG3zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808347; c=relaxed/simple;
	bh=c/xZzs2K72AdjfVBHv9wrp57mahofFWIXgLoLIQcjm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sgMjYKon1le8+Z4G7HvAWUPhF7Mv8kpFSDB5KEfg1IwJeUK3ecIW49/c/67iqnLCE3cb9xeZIb4a2KmMD11biSO93mV+46RMZC9AsvZCRbHBcHgUSG5ZdrBPn1toc8YB85h1rqyBo5aVYlMskIRsfsaw52Mztz7amgeysJDSZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IF06uYX8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fY8V6kis; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IF06uYX8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fY8V6kis"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6D5BF7A0150;
	Thu, 21 Aug 2025 16:32:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 21 Aug 2025 16:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755808344; x=1755894744; bh=tsW+sEIFFI
	BtOukKE2bAr3nu5eRbnyoqRy28ZUNmFnY=; b=IF06uYX8lD+Qj8fggjryqDcToZ
	+JKGiNgbnvIUvFTGE0gdugRZvXFxE9qTPSDi1VPpFX0Gw74XleC9ZubXPUG6jnvT
	8F7eOV/7MV8C9bIut59ccgJcyzoyv1Xr99R0edNeGPCVm2UwfvbECTBrdqCnGbOz
	R2HJBjlI/setgNCGcWVTOgrADEXtj03TxICnXE6oClXNhlRSRiRWH6HMW/wRePTt
	QI4epZsrrwfIMI9DQT6/aTGrLSGWC/4PSy9a1UKNZVuCCajQjZN8nqd148yGgjJa
	7AsmxYQ4mryCV8r1+SkaE4dz0K+EVJ+LFsjyFwqelVp6saX75IJK2gYsZNKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755808344; x=1755894744; bh=tsW+sEIFFIBtOukKE2bAr3nu5eRbnyoqRy2
	8ZUNmFnY=; b=fY8V6kis1BBYWlBDHlU585jvmaWRit0OEOwL7AgG89M9/8cV4xO
	F7da61KtpHJKijUeTUEh3mBC2nAxLtJtXSSr8A+9bMLAF0IH/aOb74IO3WXA6MqG
	WJpfywECG4BckfnKydNSWgVni0o9J41NxJ1wx3HaB+tgZEqdfXB+YZu9gV93GYN5
	Ht1cJdoRwR+T7tdcBlyCkagre0OyvwLaqa89GWEbGMBOA5+kbRMRpp9hWFKp1Yaz
	mWShbnywS3G6x0mcMcy/KEfvGS8wwqdoVjp9DFp5v0wtYGhipys3ov4Ix84NPvOz
	LqXodEwP6AxpMOvLemZx+vB8L3XEz4Cxk8w==
X-ME-Sender: <xms:WIKnaC_iAWOn-qNvKcJKSUM5sz-LuS3yU8kKQutT0bSx2dPiZ5iL0g>
    <xme:WIKnaNSVQYyye5KwVJnDHRsUOH0Fteo4_yF3IAATsWjfE_EhYiPoo-T051G0sB9tg
    nCEw7XUXdGBnmyImA>
X-ME-Received: <xmr:WIKnaElRGXWavdYdP1gxtx1Y-c0dSvkwMeSeR9u7AmTnA_XYoRgPK0g-zjwTriwQ9Cf0ccIplT31I0uPH4iRP19atLQlxssRxKLybN4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WIKnaNRnXIWwcmypv7Cx-ryrUF4G1-p2s4DmW5M3n94UUsnbnZuE8A>
    <xmx:WIKnaCP7pqt7RXjSmQikcBs2tCllh7Frg4WPuL7Y8L85-yNjj_jxjw>
    <xmx:WIKnaGVz6YFtGDWbF4fb1S5f9Z0ZWm9pKQO_Y6vKY5yA6rnpYZ8XDw>
    <xmx:WIKnaJfGWyCWUN5R6xOQKvkTgGgoM6gyS8kcHeY3i-l96v0M74Kd4w>
    <xmx:WIKnaFOU1rQp8cn4RUcauo28bFD79G43qIqbwmE8OiCVsXZB5Obj6-vf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 16:32:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 3/3] bulk-checkin: wire repository variable
In-Reply-To: <rhkhmaozjaogm34xfwagagy2qifsq5p4fbtb23nhdu7jfg2627@qkrv57gg2k3u>
	(Justin Tobler's message of "Thu, 21 Aug 2025 15:26:35 -0500")
References: <20250820225531.1212935-1-jltobler@gmail.com>
	<20250820225531.1212935-4-jltobler@gmail.com>
	<xmqq8qjd7coe.fsf@gitster.g>
	<rhkhmaozjaogm34xfwagagy2qifsq5p4fbtb23nhdu7jfg2627@qkrv57gg2k3u>
Date: Thu, 21 Aug 2025 13:32:22 -0700
Message-ID: <xmqqms7sza95.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Thinking about this more, we should probably just require
> `index_blob_bulk_checkin()` be provided a transaction. Callers will need
> to ensure a transaction is running so that a `struct
> bulk_checkin_packfile` gets set up, but this shouldn't be a big deal.

Thanks for thinking this through.  I think reducing the number of
oddball callers-from-sideways leads us to good code hygiene.

> With this we could easily just propagate the transaction for all these
> function as you suggested.
>
> I'll do this in the next version. Thanks!
>
> -Justin
