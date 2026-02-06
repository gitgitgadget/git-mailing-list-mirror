Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9D923183F
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416592; cv=none; b=BLCU1W9rqoV9eIDaQm4QPjmMZHCFOsmh94/oWrKP1t2mSwlNGoX8rcq9H9MUjdHGLFuyc6S7oLe0nSRCWgY9ndtMSgREpeqHmBr4/2UhNCg2y9z0sIQ3v2Z1uykJOUfIt4DpUXb7KtTwZfHpZ4hOx+P+iqEfgl2Uwn42/NtP0RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416592; c=relaxed/simple;
	bh=Uh4hcLjbtAwrkXd660z8knNsii02+x4rbSP1f2ZWWDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t31u9KBMfFKhCwFjN5+M8xyaJKWvlbPMfjHxOR2rnNivU3kufHLxYvcX1rXs1jMhArYQN5xRHVQM7RL0YMUPbCcnz7d80FIws1jXMAyqIilHU/EiQfGn+QQZRnZdB8SqVR+PqKOpKk8UYTkNunBuMY5kAvP4n62WsR6HUoWRR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W1Tbjq3R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EykDsf2+; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W1Tbjq3R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EykDsf2+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C7E13EC0312;
	Fri,  6 Feb 2026 17:23:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 06 Feb 2026 17:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770416591; x=1770502991; bh=bluEmxy7pJ
	pF/ScDkjt5GyZi+0Ir7eMEM6Ck23TW7g4=; b=W1Tbjq3Rdk9PlxebsgJXaAqCP2
	589oBvbnCxZIRsXYYqX+DNMFTlEVNMCLhGq3RhCPuO6wvAMy9th0Jut4EvIp98IV
	gSRGQnyMTleieArFrNS648SC9300GO5yGQ/FYUzct3F1zIVxqa7bAfF5ZSVj3Iw4
	RF6t1keME5mvFgmuEfbNzbweyuHg/SB4ov2CNGxi7KwSQ9OHbMyZm5IeVYXb2a95
	Q6kFkpDX0zrH3YDGt0AWYjsNkNfe8BPToE9Slgde9+lMde87CFRd/Rb4624YD9Uz
	JFQHshCLNw0ey3RVx2ECva2retOJXKmjfdxXJQxdtgaJlDIcbsODQoH6QBoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770416591; x=1770502991; bh=bluEmxy7pJpF/ScDkjt5GyZi+0Ir7eMEM6C
	k23TW7g4=; b=EykDsf2+lgHfor/5VstfyodqiNZ1mDj3lE0sZ/HjiubWjuZubad
	8+DYpFpSX50v25MiamvCWdZMVHigtIMDwSgkJ5yoMc+GjpzGOaomlN+fQaNrZbo6
	86pUzja+8XXMk62O5ptlxD7ehVwkimGaQypsVU1TB87AGXELdrS+dpJ7uxM/99AM
	PyHTTIkOLanClRfk1gThYpNsGN0ZosNA90gbA88qOhSLdpEQ7EfaM08RVu+OwfgE
	xOCnQf/N//F9N4jdd1ZrNmCdryn2nhLt9+c13JlZc1cgxY2m/APH40pb0wAGWAUi
	aAkxDZszQHOvhKrRI35K3wkcq2w3lD3BENQ==
X-ME-Sender: <xms:z2mGaS5SHuk0xdXrfPRSpyCD0W00oTwXUZA65MG3ujZ20gLZbfUcVw>
    <xme:z2mGaSw4U0HjMNnc9y8dLnWJJ8dGYBoLmRne49elhDNJld3uIPcyuRH2K39M19r2I
    zDScEt4pdHlxu57DgsdvYHOVbbghckENYyzTlkGaHrLQgzbSifg1g>
X-ME-Received: <xmr:z2mGaZwFiShREgJKPGesfvugPZbQOq6zfcfSDfJ90zvIpdZ3aJ-V5pJvyU-OT21CLQKxh6wFbBj4UYk2cMelIitGDgB-WIGY0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeelfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:z2mGaay10lZrk1gSUnHoujtLvpssnVbro_2XqSRb8xgu_hHDF5Blzw>
    <xmx:z2mGaTaflR64mRZ9uJMVEAIz6pMh88mYWQxw-UQIePN_t28O553Hdw>
    <xmx:z2mGabWngxCJos1Q9mgLiOtz8N2so07h4OSvnlg3FHZvUNhghjZd7g>
    <xmx:z2mGaRhO0DdJHVFtdCC4SUu85zQWkbvsthNPWaiVgSvrY6p4kncNOA>
    <xmx:z2mGaTgX7g6YBrJARAYtO6Mx6MAtEBX8vD9pGPt4RclbcvsVvNORBgtO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 17:23:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v2] meson: wire up gitk and git-gui
In-Reply-To: <aYYLLI2Gb7YlBtKt@pks.im> (Patrick Steinhardt's message of "Fri,
	6 Feb 2026 16:39:24 +0100")
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
	<20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
	<20260205093748.GA2177239@coredump.intra.peff.net>
	<aYSFGG7lCg6Sw8vy@pks.im> <aYYLLI2Gb7YlBtKt@pks.im>
Date: Fri, 06 Feb 2026 14:23:09 -0800
Message-ID: <xmqqms1lcy0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The fix has been merged upstream. I've created [1] to verify that the CI
> now succeeds.
>
> Junio, I'm not really sure how to proceed here, as I cannot send the
> subtree merge via mail to the best of my knowledge. Shall I instead send
> a new version that just includes the upstream commit, or will you handle
> the update?

Whenever j6t says his tree is ready, I'll pull from him to get the
update.  This "wire up" patch does not need any changes, right?  If
so, things will start working when I pull from j6t.

Thanks.
