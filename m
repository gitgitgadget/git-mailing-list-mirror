Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4454E2773C1
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542180; cv=none; b=saC039W3O4WBpFLLpIW9HhuXolER0IjW/g6z8XB41zpNuzHr6DBOFrypAB+x3mhmcBoyNuZE2mtOp69dXLrxVrCDbo7X1uUJupYrE1MNJ+jzyQinRnwVBxy6Ghyq4MsOGIohjrxi2WXEX4+5D0WTePgSXXEiyQGQIPGfRrXtSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542180; c=relaxed/simple;
	bh=WmWSE+HnX6at3AMDxeeG8l81qU4fjy4ikzukxPzGBGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3B1piM1akhz6UPecjIdt/wf5MJDEiVK6AY+ljv3CY7hwicR3DXRaY3y7WK/EnAsYnBaSYYIEFoIME+wRG48WHYf7dxol7wTSGByRe+H6TwSL67to3OLIVRKWJsqVuvItNk/GG8vaSfi8zT1fWmFmnP8rhTKkTi+hCrO92t76Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UP9tFdIA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oWJKlaP9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UP9tFdIA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oWJKlaP9"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 717B41400152;
	Tue, 27 Jan 2026 14:29:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 27 Jan 2026 14:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1769542178; x=1769628578; bh=JO95qSgjkC50XX0/M1+ri
	9y8uBqig0kl1vPco43cdE4=; b=UP9tFdIAQkb/3yOK03Ja94Bp0FmR4vvHpqiH4
	RZ0yQfLXwWWmaPQYDP4RMfsIf4CkfSyGgu5tLqmhtZDwKazl8gOEBkLW5OF9xGJh
	KKjh+49nxETRFWaMQnGVIVdY7fluCtw8Y2/Avrm8jlgafhnbfHVPtPusvpHq1qc3
	T0xmovMcJSPDZL/NHBBct2Mxps9vfKvJinKYrRmKBab3u+5x6KQnpJnZQe1BUO+d
	N562pZAq/aq21ivpxMWhxx4HfpF9HZIx8TsZXK+gC/An5v1Coa4I6VmNG05m036F
	1KCC/lKr21+OP8hBn6C4iZfcZkVLdANQOgCgilyJxjRNy0OyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769542178; x=1769628578; bh=JO95qSgjkC50XX0/M1+ri9y8uBqig0kl1vP
	co43cdE4=; b=oWJKlaP9a+Bjhgt12xtWWTNtLf9sDDWtlZEp57GKAPRabTKkHBT
	5blx7Td8+HqE+OxmlGMGcbshwfTDvmToFlBCLcq0BvbgtKvRRXZJQOkEky2lVK0j
	ZFRuGXRfZVjQmrC0ZLDRDB8iBDeLxBDUNSWuZONvVCfnY0uTnqOsDpjg7Q2NsE/u
	x9miGTrVROOtm/Tmy3VEiImxbbvXf8daDRjCMIDImUmbaeSh2bRPceKJxQdSLYuo
	iym1re/o1KNh9feMrSnTL9XDYdcH4Uy/O7Jv0NrOyZzjMRz6LSOhgA0geKJtD2xZ
	TPA4LEIsRoaJYdo+cfyvuLYtLlk/KGL1EYw==
X-ME-Sender: <xms:IhJ5aWwSXvGi39dr6lQ0OW44GRsiKYgdVFV4AomrgY380xWana143A>
    <xme:IhJ5aZvX_J4zLQfaOBk_08FiMZ_9NvmpB2DToMxaGOQeAAeIRK5DQ-6UONy6Bv03w
    hHssqlsDeeSVvhO33b9IDOLfLwwC800WqzAjD-tgNdIVqKM5JyPSQ>
X-ME-Received: <xmr:IhJ5aVsXvzwxIp44EPQRvaMelma9GzF2Ggzcp82l1ResrpMXcHVkS9eFMb8DmgnD-zJ6X9wzUJjLZAPWUeUy9SDcJrmSx3iQxfRA9JU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedufeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpedvjefgveethfetteekuedvteehudffvd
    fhtefhkeevffegueeujeeitdehgeduudenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopegthihqshhimhhonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IhJ5aWM3B-fVwKZnx9LqOtJstojySB7Co9vwqaIhRgiO1SUGVH7bQg>
    <xmx:IhJ5ab0Cey2YvRuZ4z2rUxOtXggO2wr7comShABPVDfqaE2vsKg1Kg>
    <xmx:IhJ5aaN5o1iAZ-iMKBfolkFsMTBPlK4t5OQr47J6KbieA9lf9ymHNw>
    <xmx:IhJ5aT1G-ob6aaylPr0zMSwbXXtjtl3h9HdHRgrBloErZ9G5JMqsAg>
    <xmx:IhJ5aZvxTk7RyebOFlrfwKlmoVA0fI6WX_f6uDatn4SepaDJCufuc4IR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 14:29:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Simon Cheng <cyqsimon@gmail.com>
Subject: [PATCH 0/2] Improving advise messages from "switch"
Date: Tue, 27 Jan 2026 11:29:34 -0800
Message-ID: <20260127192936.904719-1-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-rc2-135-gb1217c0133
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simon Cheng noticed [*] that "git switch <name>", in an attempt to
create a local branch <name> after a remote tracking branch of the
same name, fails correctly when multiple remotes have branches with
that name, but gives an advise message to disambiguate using "git
checkout".

Obviously, the user wanted to use "git switch", and "git switch" is
equipped to do so, just like "git checkout" can, so it makes more
sense to give hint based on "git switch".

The first patch of this series restructures the call chain of
checkout, switch, and restore commands a bit, so that a helper deep
in the callchain can find out what end-user command it is working
for.  The second patch takes advantage of the new structure to tweak
the advise message in question, given from a helper function in a
fairly deep part of the call chain.

[Reference]

 * https://lore.kernel.org/git/CA+itcS0iyqNyzOP0cueLg7B3yadoEr_VWJ-QoL+YPFUPJiE2RQ@mail.gmail.com

Junio C Hamano (2):
  checkout: pass program-readable token to unified "main"
  checkout: tell "parse_remote_branch" which command is calling it

 builtin/checkout.c        | 92 ++++++++++++++++++++++++++++-----------
 t/t2027-checkout-track.sh | 21 +++++++++
 2 files changed, 88 insertions(+), 25 deletions(-)

-- 
2.53.0-rc2-135-gb1217c0133

