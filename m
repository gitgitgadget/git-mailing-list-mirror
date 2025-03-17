Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB715205ACB
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742255615; cv=none; b=REM/x/p/mNrWDgPVBpj6JXqtj1Ej8noh/S2yB/euKmPnbbk4cogYiS8dueZHZ/MrMo1gfrc4hApwb10zFvMklkAti8Mx54q0sEVhvQAHN9cPtusLAlQI2iRi/higIWCXzqwzKn6bYbPNvwueAXnBbG0pnXuC8eA/utX3syvkZ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742255615; c=relaxed/simple;
	bh=c6NyAXSBwTI6RhSNhJpAlxT1aEUlgM0s9bffIbu3XLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOvHkrkK7knpplSZUzXR9IncrS9UXpL0De54CUJvIFwns+DAbQkgLsUM80QPy3c8RxA/we52WgdskLdRtFx3tEBKNM7VsLDJJo9EYDui3sTZzPzf/QTiKxuWIgta9UQmc52am/+/aQMEmrLZ5DNX6X5hRjytLtWCNfaAS4Newo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zOQ06t6J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sZV8zqFy; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zOQ06t6J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sZV8zqFy"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id B15CB1382DA0;
	Mon, 17 Mar 2025 19:53:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 17 Mar 2025 19:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742255611; x=
	1742342011; bh=GhjJbeD/SilT/o2bYzHQhyI1u1N6DDWiuOR0/3t9Iak=; b=z
	OQ06t6JfgO0z84A3BFs1Ds4aBkOpch9dfpsOBzBE5ztO6aZ1QqTbFs4ms9BTAJZ/
	C6Riz3NV6yWLS2sCkI0vhvoyzHuIOmsis0glxjt2wy3JsQRRw4AjFdvdtqM9imqG
	u3OP0PvhLsMdIHiesxoo1tp0D7JW0A9j+FPm6ryoZoP4254cBGt3I6JwhWTgN6Ax
	tSlQappxCTFK3w8DWGh/L8mtAE2oys8GAuiemgxfmLweqMtK7+F7eKpdTUec75Ea
	rEmdC19+vqz4BgQBiZDneQ3bcdkp1BokSUL76Ri25vcGjfemAuHcyecTpA61eEoX
	2rVt8ylpJglTEDKyKhrgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1742255611; x=1742342011; bh=G
	hjJbeD/SilT/o2bYzHQhyI1u1N6DDWiuOR0/3t9Iak=; b=sZV8zqFyK6J+RL0xv
	5eV+hBzONkT5l9d3EBpp8xUUyLsAsrYORitzjEfFXqlR4XChd0X54BAM49plcM/N
	E3FBWvI65CYPcct1nncA+DDtcqvrb8o7JM4sPD7dUeT7D0CCKV9Bn6O29JQMC5lv
	Hb2tTbJ4sZDh55r5/Xr8alswxDtPBmu5/2RXUW5JG5axA5KQz+Pyrv9RLiPRKLse
	y3T7DFkk8nYIO1xRoK1sbQWYg6Wn5CWUMyJhhbYPFGORMspuSPBsHInDBnwPtSIB
	jGns1Fe0aqqrfpW/SRrV6H52owp9Sw2XCMOG/9dnCqGsy+4GashrhU0WLlA3sdD9
	z3wTA==
X-ME-Sender: <xms:-7XYZzUM5xnYT1ab4MLzzjl4Ljls-fekW3twT_TsSeGMR7EhTQxutw>
    <xme:-7XYZ7nsKRut83mB4f9P1DxOtL268AKuyGqYGxyu6GvZiqxaHTWvFWMo_Ntzb1JpN
    pFUVMQXP6Ibq1zhnQ>
X-ME-Received: <xmr:-7XYZ_ZYdNtEXkjmYF6WqPTO-EDmcv7kj1Sc55xllj77luEUBvt85EL8ChAE7rFe-_uHLOHK6hSNdcxMNdHWJUi0yNj3beJpemYT-E0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dutefgueevgefggeegfeevuddtueekffethfduueefteelgeehueffvdehteeiueenucff
    ohhmrghinhepmhgrkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:-7XYZ-VQIpQDRx-4ekdkJg6oIooMCHkriSudYbA0iS65vAK9QSqBWw>
    <xmx:-7XYZ9nzqUyF-PoVevqiIKShl3MQt7-7jUsI922MHsEKnR1HHNL42A>
    <xmx:-7XYZ7dlZNARTD6PyuAvatpIi9A11foBmMwjWvUvt49cg7-B8KUQ4Q>
    <xmx:-7XYZ3FKc9fVsLftWd1YLcZKszP1awTwGUq2ANgP2gQeoB9eFRq5iw>
    <xmx:-7XYZ2BWX6eKGpWBnbj47oCvovFBTR4qmAeQ_xVtF73TcvsoDBs73QyT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 19:53:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 0/3] -Wunreachable-code
Date: Mon, 17 Mar 2025 16:53:26 -0700
Message-ID: <20250317235329.809302-1-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-207-gc8924421c3
In-Reply-To: <20250314210909.3776678-1-gitster@pobox.com>
References: <20250314210909.3776678-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Taylor noticed, we can still help macOS users by first dealing
with the false positive in the code, and then flip the warning
option for developers on.

 [1/3] run-command: use errno to check for sigfillset() error

 This was our first "workaround" that is very specific to the code
 that gets falsely flagged by the compiler.

 [2/3] git-compat-util: add NOT_CONSTANT macro and use it in atfork_prepare()

 This adds a more generic way to work around a false positive from
 -Wunreachable-code to prevent compilers from optimize away
 expressions that are used in conditionals, and rewrite the earlier
 workaround with it.

 [3/3] config.mak.dev: enable -Wunreachable-code

 Now we worked around known false positive of -Wunreachable-code,
 we force it upon our developers, including macOS ones.

This is totally offtopic, but I often find the short-log (list of
commits, grouped by author) in the cover letter very awkward to work
with.  Between v2 and v3, aside from the NOT_CONSTANT() improvements
in the patch [2/3] that used to be [3/3], one large change is the
reordering of the patches but that is not seen in the shortlog (I
ran "git log --oneline -reverse" to prepare the list of commits in
the order they are applied to describe them in the above list).

Jeff King (2):
  run-command: use errno to check for sigfillset() error
  config.mak.dev: enable -Wunreachable-code

Junio C Hamano (1):
  git-compat-util: add NOT_CONSTANT macro and use it in atfork_prepare()

 Makefile                         | 1 +
 compiler-tricks/not-a-constant.c | 2 ++
 config.mak.dev                   | 1 +
 git-compat-util.h                | 9 +++++++++
 meson.build                      | 2 ++
 run-command.c                    | 8 +++++++-
 6 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 compiler-tricks/not-a-constant.c

-- 
2.49.0-207-gc8924421c3

