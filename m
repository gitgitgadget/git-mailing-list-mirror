Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C43093AB
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713580; cv=none; b=HVvMItRI5QAju68mTcrF/XybHaubZf+zCQZdQzA+6Lnn6RoCzpcHd3Z9qZ3fxkwWEdXRPZskxS4KtJ6AoS5P/lNDxJkSMgqa8iwdzpMcAPalxzgs/F+EX5TLNV//oMxE4KZfvdARqF3ToG/8BK7soNAkmM6ZhhWLhY45hUP3iZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713580; c=relaxed/simple;
	bh=P1hELCpSjg90wj+cUEJOTvNsbxq2wLkpvrxL91Piw8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOgEELeo0qBX4QR0FOsxfs6pgj8MxTTT4B6yHrtchYHCL+i7C07xpZ44/cwH/kgZnfcvSwIMpqHT/nS5sDR+bOjVu7XdjnccaTygS4fOlpBcLGC37O632VAFxQmvYFAhISvB9mQ9ZL+CaKwOWUEJsoKGpmF6RJ1lt6B7oIsaUKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I7R9/8Y+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IDmQQLvz; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I7R9/8Y+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IDmQQLvz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C7A914001A1;
	Thu, 29 Jan 2026 14:06:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 29 Jan 2026 14:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1769713578; x=
	1769799978; bh=AxIn4PgQL9LlZ9oE42YsRVbC2sW2R1MHIxroasJHdL8=; b=I
	7R9/8Y+56ZJjz4gKFN4Auro8j2Kpc/OsAMysDFF1VHMyDg/v3PecImkGPztFCmuZ
	8hHxpte14jeRAFM2tP9Z1O08hBSlweDDWizjGqMjXaCELCyV2Mgkmrggya+uptNp
	ainsJ9cNhuT+9U2wJf6BjyKkxQeGvtWmOxMHc1PNhbd5pls1Ft4p4kLyldp/2j4W
	lZsQZFQ6ifT6vKaA/736Lr2DQL5a7CBoHbV0B2BXrG3RRkGKSkNsM1/F1xtLd6bz
	mckwdvW9AYON0EqVBbFDgjTnCKIuCu8YEd84KI1vgQzVRPlY1NbwYXJQgUvh2TAG
	RCYmXGojR28hKCq8g1pdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1769713578; x=1769799978; bh=A
	xIn4PgQL9LlZ9oE42YsRVbC2sW2R1MHIxroasJHdL8=; b=IDmQQLvzDkIhLpT5g
	bIWpgf2T7ELyL3Yka0bG58d1cB4BQWPREHqSaUtl75TuJaDG6v5wKKPCfVGB0ANj
	TT7qCmp70ZilrdKUnTF0Rgk3Gc4Oycbwod/kGLNqgrB0LUqUpJPBQZttOpv+6Lsb
	/MnmSpgKM0+T0S7QYIbXaz62xVrS91S5PDosTfOs9heURYQmfpFh0+GCnrl4Tfza
	5Oq3mWusWlbOIUtNv6hWpAZpfR3FmBqC9i2Qr/P5VZ1YImX82wlPfbzKw35T2ABi
	5OKWLBwMxFriXPvO+cqVwf9jyvI+TIPjLiudbPRGPHikx7vzHtYBfAHfWOpVglge
	ZANIw==
X-ME-Sender: <xms:qq97aawd4bhPA8xqRPgsr5EFjiE-B0EygQBmko5zwi98nRFVJNLnPA>
    <xme:qq97adTqQN7O0IL6XYw-w3w20RvXzk4r3wqyDlxfY3AWzTxqXieMEDI8B6gZ_NmRm
    pTmSa3aeG2U1qAW6JHhOmNXTfxUE5knWOaHO-MVAm9MBTRGBDwKZw>
X-ME-Received: <xmr:qq97aRWC-LV4fbpdLzoIyetJp_oIfY8iW_lyg20I_Qb7SQ2KV_ToPBHwjjuet0gl4LDiKPKiKuCHj_BgDBwiLBsQr7isBjeQJWJ6ISU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgfdvfeethfekgfeihfehkeeiffeugeeuhedtheefkeetieffheeuhfdthffh
    tddtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgihqhhsihhmohhnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:qq97afZOKrqNVHcyyctB8L0E65gFm_F2dbR0-Lts8crp2gIlo-t2lw>
    <xmx:qq97aX3Y_RKuI7Mr4adsDoclhPsAUjAcFAeflTIrUyLzp08384UV-Q>
    <xmx:qq97aRjJZ24Sb0DGEC1JvmC6keRbxm5bE-kiWJXIgfnpNd-BLrdYsw>
    <xmx:qq97abZC5_r6m88aXkhXmERxIiDPwlVrmdjbXoQ1qxbXTWauQ-98nQ>
    <xmx:qq97aY00VjJxdeBr2pkNNGR_NlrYlyyoC-u0NmEL9r5sbcx4Ae__dnju>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 14:06:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Simon Cheng <cyqsimon@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 0/2] Improving advise messages from "switch"
Date: Thu, 29 Jan 2026 11:06:14 -0800
Message-ID: <20260129190616.645471-1-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-rc2-149-g6536429cee
In-Reply-To: <20260127192936.904719-1-gitster@pobox.com>
References: <20260127192936.904719-1-gitster@pobox.com>
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
 t/t2027-checkout-track.sh | 18 ++++++++
 2 files changed, 85 insertions(+), 25 deletions(-)

---

This second iteration simplifies the tests in the second patch
somewhat, and rewords its proposed log message, as suggested by
Kristoffer Haugsbakk.

