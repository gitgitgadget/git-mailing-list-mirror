Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D0D1D545
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 04:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730782152; cv=none; b=ciKtiUSq4i86s7UQmPmwBTx7FxbYDSpeenYEB14muH/OnwSyAz6NibYyLp77o26SmPb8gbnwc60S0ehPSNNauWEmY1gU6aXjmqf++ChR82LAfmqf5/EK0SCRGZom9JKNTgA2yzh+17k+k25SV1KJn4yIytL03YIX4kbPfgKf2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730782152; c=relaxed/simple;
	bh=hs3Ii8HtH5AUZazHcGbaZCSRtL68dyWnADDF0WgdrSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N1e7McGBsZcUDn8z+7sA8SJbZ8/JOFl9hxeN6qfGoAogOlZSW1pmP0DeD0UgC/0m6hZ+gjpOlNSF4oyAYA5QYqJV4UuWVimhJyvF5NahAPPUo5zhTqFaVuMAa7NMb7HpIdh+b7o+DFvpsA2FaHdFHrARfAyUsgLi0BpY2vdlfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lU/hVlM7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ay/aw5aB; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lU/hVlM7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ay/aw5aB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 55F6B138052E;
	Mon,  4 Nov 2024 23:49:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 04 Nov 2024 23:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730782148; x=1730868548; bh=6ezDqHkLs+
	9jakYxBkpalVsw8e0LJRoeQ2XLFaWYmE0=; b=lU/hVlM7TFhjOvfh+BCb+hyqZ0
	wOND6sNjP6JsVVcvwWPB09Nxp3OORXsFA+nT+QUx5gM2CV+wDjISLzwMH3PD8qlu
	uPYuVcn3CgpS+Ud9Mr0y5j8kcDTEjjf0o3hu70cQ4d8sWIHu8qsgvGUDTTR7h14P
	VQxFitzRV7NNIzTKiUWGiGpKXvOGuAiu4VW2YTxenTziLJHeOLAD8/5c/3gwdmwO
	GW1VYjdruptn3/4lovPD4VLoWMmHjj/gbSiq25Q7225ycwMqlEr9fRJ7sDb/lQIj
	GYuvYUmZC2gLzBpD4G9byVUpEZUJClhX5nf+quwyeopqncCuqgf5fUURkAAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730782148; x=1730868548; bh=6ezDqHkLs+9jakYxBkpalVsw8e0LJRoeQ2X
	LFaWYmE0=; b=Ay/aw5aBRe3CFg6qSo11vAod4I9mjddvaFxVhFCXsEIfzWGzkYx
	ZAI6eL22RROtoKxiIhlKc4GnCJUmWusxLgdLC0U6NgTXxyIb4pM9TFkEHVeHKspY
	HyMooF6l0S4zt+1rn6uCOK3vCnk06nfPYONnIWsvMust7XGQS+rmof4zqPMbU8Ud
	Fqih965z7i0XLGT3D2EznLRaKZHYHgyf7/LEKiZDcXP8pl7C2DG0WS6zD6qjwKgo
	6cHraSLlcO3OhGDyaCCd0w8bMIZJxHGGyUig2+VXYEMI1wEA8TS+1GpCCJ5UFKlx
	XXRZFn6T2EUeimAJH0MDKoM82eOwFXQIkaw==
X-ME-Sender: <xms:xKMpZxqqZ4wDE_N2WlMM8znUgBdmuUlENJoRL9rCzPCUVWrF4in5_Q>
    <xme:xKMpZzrl5I7hcZG-1nCeXjsQgIZgcAPjwU912l2qr3siZ5RXX9mymdk6PrztTb26K
    pOHmOxmuGFFeMkDOA>
X-ME-Received: <xmr:xKMpZ-MNQBL_RRV7sKIgz33joRWZ_PX02hfPR_nP3xmyfxL2k5bwYT8kN94JlSTOkeUwrIWdwgv0pbKliIgzM1_mUkMs6Imn6LIe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepgeffhedtudfftdevkeffvdeghfehleehuddv
    geehgfeuueffieeffeetieeitdetnecuffhomhgrihhnpehhthhtphgurdhshhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xKMpZ85H5z3atlDdtPOp1s2TgMwPGUVLEsXra9JZ7dlIOtRHESbq7Q>
    <xmx:xKMpZw5rKDjv6jF8fxqIEELwEDXJsBBo312vccccDVYu6v1BCtxZqw>
    <xmx:xKMpZ0jFMo9eCkRT-wY-Oekp4-FOOwWI-fi2dPkqQOVdtDQHproumA>
    <xmx:xKMpZy5B2lZ3D4XGXkG6A4yL5Gg2yLkotzy4FEGrg0NGOwn6cfEiDg>
    <xmx:xKMpZ-mLIx_sQtB9TiSOzLjEJGlEZHV8bUo3Yf8smkojH7UEUNpkca3I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 23:49:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/8] refs/reftable: reuse iterators when reading refs
In-Reply-To: <cover.1730732881.git.ps@pks.im> (Patrick Steinhardt's message of
	"Mon, 4 Nov 2024 16:11:32 +0100")
References: <cover.1730732881.git.ps@pks.im>
Date: Mon, 04 Nov 2024 20:49:06 -0800
Message-ID: <xmqqmsiethdp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this patch series refactors the reftable backend to reuse reftable
> iterators when reading random references. This removes the overhead of
> having to recreate the iterator on every read and thus leads to better
> performance and less allocation churn. It also gives us the ability to
> further optimize reads by optimizing re-seeking iterators in the future.
>
> Overall this leads to a 7% speedup when creating many refs in a
> transaction, which performs many random reads. But this change also
> positively impacts other usecases.

When merged to 'seen', this seems to break a handful of tests.  I am
reasonably sure that it is interaction with other topics, as these
tests passes in this topic itself without other topics merged.

Thanks.


Test Summary Report
-------------------
t0611-reftable-httpd.sh             (Wstat: 256 (exited 1) Tests: 1 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t0613-reftable-write-options.sh     (Wstat: 256 (exited 1) Tests: 11 Failed: 9)
  Failed tests:  1-3, 5-8, 10-11
  Non-zero exit status: 1
t7424-submodule-mixed-ref-formats.sh (Wstat: 256 (exited 1) Tests: 7 Failed: 6)
  Failed tests:  2-7
  Non-zero exit status: 1
t1460-refs-migrate.sh               (Wstat: 256 (exited 1) Tests: 30 Failed: 16)
  Failed tests:  9-15, 21-27, 29-30
  Non-zero exit status: 1
t0610-reftable-basics.sh            (Wstat: 256 (exited 1) Tests: 89 Failed: 53)
  Failed tests:  8, 10, 12, 14, 16, 18, 20, 22, 24-27, 38-42
                44, 47-52, 55-56, 58, 62-71, 73, 75-89
  Non-zero exit status: 1
