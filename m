Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92D273F9
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 23:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292333; cv=none; b=M3S0ItCGVXFtrjU9iNh273ZqC160wbrkdRzIpG0T8D4IFpeDcveE0QoQBLzkVYA7Lye/PWAmjPUtwwhuAqfNln/hVs42QWkkWSGVHcuq5o8jUx4DcQaE5Ru4nnQTlR32buv5ZZQSPcLEONL/CHYdQ9zjQP+kxnK1T/flrLB703Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292333; c=relaxed/simple;
	bh=A0wmuQccEfLWZzWeH5jWhZx5D97dHKwmECATH7Br8/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I9urCWyly2RGnqzx89rpCeyGgXn3gsHguQ0fdGRCSSTmZ6fmRaEyjPDB7SV02bcL0i2kJ3sGn3WokOZoqs0QF2TK0GiVwfsnAq2DGkoRTdANIGuW0hj5SvDx0iws9D0xopvYeaAboQ80qThy2msl4qaKNN30zn+zLFNzccEcLHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B5ebRu2Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cboGKNHj; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B5ebRu2Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cboGKNHj"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A098B11401D1;
	Tue,  7 Jan 2025 18:25:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 07 Jan 2025 18:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736292330; x=1736378730; bh=8rRJ5zdD4p
	NRgoMXUIGuPhcq4j5ODGapcxYaaP1yFVo=; b=B5ebRu2YZd9T4/Gl/uPSbJrnbR
	7b1DI4qqRvbiTbwP7I7HNk6BWHJopnZWtuxA5n0LS/g0qbBiwYCedRyI8vz44XOz
	QlHF8BmJv7/qemFazgNdz3MBg0gmYd7dq6VztycTWXXU/it4swr0r5RC0qc+qiC6
	UbgQucEyNpIE86/RQBoQ+sxZ23BRbModw/cBme7OIyxbruVGqThaooQRH7FVjMqq
	8dfK+BcbAN4IWQQ1XJD4xrk2Gm359Eam/dDdCQt0iFcv0xgFpjp+fJjOKMtoG7Jh
	iV/OnYgXkmU7r+O/5CRahNvvbh9c1m7c7nVWFXh9a6M9IU0wkI9TZtOET8Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736292330; x=1736378730; bh=8rRJ5zdD4pNRgoMXUIGuPhcq4j5ODGapcxY
	aaP1yFVo=; b=cboGKNHjaVGQDGjftAkJdUzOAifUE733hM0IDQMIwGs9lKyfDGW
	VUrkhDCBcQYbnW4EDLKZ5ZGHvqy5hHHITUvhJtTpUCUEHOXWs7O4UlL4vAF/LQSb
	EcVMBTp6rZLVJF3xk7sn3w0uNyALuLIbWLimff4eRE7dn4AHyT7vGNfxJ2HwKZs3
	RdbYHhbjv1CRxsZi+EEXTZLfWuDrNLaci6QFC93zUkAJpYdNfyui61mzOhTYu3DR
	Myc2Y73BvVjm1wCwM0vGTymesRgFesr3lfr40hWAA4nBfAuOzuL1YvWeDJ7Cn27k
	CdGBalNaVoN+oQQqqLSPJC6wIIw4UD2HaoA==
X-ME-Sender: <xms:6rd9Z6hJvR8-IAqJmIfQ8IUqHQv7kG3UTvwU9UTdrDDa6TiKICaWrQ>
    <xme:6rd9Z7Bom3LlwpNEWVhk13F4L0nuiydI3__o_M9A3FmDkA1okelAAoFvrFMgk-Tiq
    HZEP_AbE4ir0-cQXg>
X-ME-Received: <xmr:6rd9ZyEL2oWyBz87P1Piq1qt2wxJDPJR_EWxLnGXnwVvmUjFBHPOjmXBsXyQwB3Gd1-uNIvbNMnvIwassS89DwDpijrt8x8uC98W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopehviidqghhithesiigvihhtlhhinhhsrdhorhhgpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6rd9ZzTPJQngFgde2tCuYkvpCa9Pbr4N7-gQPellCsw32Q0rBsCHyA>
    <xmx:6rd9Z3y1dTUAV7zzDQ__rixzPH6nWszvOSQTnAcTxcX2n9rMFFyKvA>
    <xmx:6rd9Zx5KYttvBvHC6lxsTBPyP6LFpnLiu2n0jMyTLadURqDe9EUWSA>
    <xmx:6rd9Z0wUtoHbEtExMi2Zs0T1GEhvtMBrB7XiCtnuHsLpsnYisdB8dA>
    <xmx:6rd9Z5tgAUceVWmv9ZWtzKKHVDkxraXaC3uAM3Vnn8te8tLdbGWN4QoR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 18:25:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Vadim Zeitlin <vz-git@zeitlins.org>,  git@vger.kernel.org
Subject: Re: Would it be possible to add an option to disable validating
 submodule paths?
In-Reply-To: <Z320RGb0tqNyvvxt@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 7 Jan 2025 23:09:56 +0000")
References: <Mahogany-0.68.0-2854301-20250107-230058.01@dark.tt-solutions.com>
	<Z320RGb0tqNyvvxt@tapette.crustytoothpaste.net>
Date: Tue, 07 Jan 2025 15:25:28 -0800
Message-ID: <xmqq5xmqqk9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Since this is a defense-in-depth change and it seems to have broken a
> reasonable workflow, I think adding a config option for this would be
> reasonable.  We've recently had some discussions on trying to limit the
> defense-in-depth measures we implement on the security list in the
> interests of allowing better discussion and feedback on the main list
> and avoiding regressions in people's workflows, and I think your email
> lends support to that approach.

Thanks; I was writing my own response and said pretty much the same
thing as above, before I saw this message.

> I'm not presently planning to add such an option, but it shouldn't be
> too hard to add a global variable for that (or maybe something under
> struct repository) that's updated when parsing config, and then check it
> in `validate_submodule_path`.  We'd need docs for that option as well,
> but that would probably be it if someone wanted to do so.

Sounds reasonable, but I wonder how this would interact with
bootstrapping.  Should it be configured in ~/.gitconfig, possibly
with [includeIf] to specify the directory you'd store a bunch of
repositories you clone from outside, or something?  I guess "git
clone" without "--recurse-submodules" is simple enough to be used
for bootstrapping, and then the configuration can be set at the
top-level superproject after cloning but before "submodule init".


