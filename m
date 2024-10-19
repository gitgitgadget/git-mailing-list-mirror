Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD61922F3
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729368038; cv=none; b=CvJQonlrgHS/aQEPFzvgW0pOCrQqKKMmV3NLJDicgw7932cShjiDIs/CIqjZZQbyeBslALdYF2OvQHe+JwTs3D0q8duH3biJe+OiORkahI8r3IcA94Ooj2ZRsc8KSOPNdw3NZmSYV2U5BstgCuZxUrmJJvGc020inCSkLVWkGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729368038; c=relaxed/simple;
	bh=9r7SumsvYpExKTdHHP0hHDaJPD/KDwbWT11nP+8KHrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ke4I2SliyTpByfGMZwtwGkzsAj4+WojkueCsebj8VhPU1LFyH+3ibYUC1lkVlkXb+3uR3cAEuT5uScEyDrIXemkKFj+ycMHH/LE31a72sqp1JwFChEjU+kZ8WTWLzGTcEcwe38HWmbNjxuo5BlnRvjlgakTdnnC06MWPdW2e9GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=F9PiRR4y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HccAU8QB; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="F9PiRR4y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HccAU8QB"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C64AE2540078;
	Sat, 19 Oct 2024 16:00:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sat, 19 Oct 2024 16:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1729368035; x=
	1729454435; bh=hwKc7CnlziamuVIz7+hPUMiHzDp8SH1qQU0MPNOSzJs=; b=F
	9PiRR4ySSLidQPF2i3vL1+Kt/FV/tc8dqdu0nYUWb7aF455AQvDz5Jajo4DdZ/A3
	oDm/58B/LL6qpdZGP4XaWjvEHMIMiTV1c6LAKcGOcd6ja5WNpwYe1heqDOgRSrT8
	uooBcXMfsBYgf9KaDYGFiVxDBbjvPRea1l9bcE6CJ2Z3jH9Z8mwJk+6P540EvI2D
	GvTprbjb/0rAUIWjMl1527Q/L6pRyc4/TrXYWhLHo0si0swN8VEVyBEcOu+BD4cJ
	m9IuvZVzUL7LJFBMTo6TThl2Q33CRuMxbQoSS2qYbI5Z0jxr/4YoLz3YqDc7YbRC
	Pk9VIk2/7Da07RaZ/Souw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729368035; x=
	1729454435; bh=hwKc7CnlziamuVIz7+hPUMiHzDp8SH1qQU0MPNOSzJs=; b=H
	ccAU8QBhl4lAYQHYBDXaUDRWKxYxnd67d9/aRWNHWvkcx9bsBIP2aAxSTqvbUibX
	mUt3dF/i4tyGPc0pNT3Db8Tps4KTGHR0VsF1bRNQZvzEwOBEPtqhtPgo6LRPZTCl
	hblDY+HK0sJ4QHQp/It/ZrXeY2GjKDGQ56D/g/+BwS4CR+t4neRjhNXxyqlaVcV6
	RsLh/Y2qH8zXtI29hisjKJFhHd3UK1PJAQyPWd2OFbikottIMTrlVzCyVIYYhB3B
	qNsVsZ2z7n1zQRvpxs/JiuQNjgXe+Ndis/S/iUWJE6QOpiqDzR3DK7jdDTKUPAFX
	xV4U8HkLzvEL87l4ExUZg==
X-ME-Sender: <xms:4w8UZ8xgJWnNK0R4rrPOFpoVXPcV2y3jv1Dv-j6iNze6PNOAvD05IxM>
    <xme:4w8UZwSb58WuZLSpVDUj3dpraDGKOUMzcjLHuLOLn3lEoJjD2RPYBo6A545BhveTl
    d9M8SsmlS-jP6rBqg>
X-ME-Received: <xmr:4w8UZ-Xw8q-i_y40fRF0EbzboL4PNGnrLn0vfBWQgvpalhwpSGVs1fiTgkhyOEF53AdypREgLs_16UHx6n2Sfdhu73jWS4fNQSo4XHH6zY1STBS7NQ933qtxaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepfeehte
    ekfedtieffvdejteeutefhuefgtefgtdevhefhveffuefftdehiedtfedunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvghntggv
    sehfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:4w8UZ6i73RzJgE6zvWcbMCGhlLikc9YVrrqLbSS_C_vKibsX83frhg>
    <xmx:4w8UZ-CaJWyxkO-FGpfaWhapmjDta29h3CjtFgUKdQjm0Jta2bwbMw>
    <xmx:4w8UZ7LNjlxza_4Cozq3_AmtgkCK7FDlC7NyfRsxuZpDYsz8ABAaWg>
    <xmx:4w8UZ1ASUSQd4H4ZxREsp7tdMeM4Xw8ye9dEjq8h0QECQ-qQUCmqxA>
    <xmx:4w8UZ63cA9JEmSRFZDHFQP9C2KerMXcUyzVpE08Iqd15ZGHuz-7Qzvjf>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Oct 2024 16:00:34 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH v2 6/6] Documentation: mutually link update-ref and symbolic-ref
Date: Sat, 19 Oct 2024 21:59:23 +0200
Message-ID: <fd3c7585a0f84b26debcc216b86dc09acb219799.1729367469.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729367469.git.code@khaugsbakk.name>
References: <cover.1729017728.git.code@khaugsbakk.name> <cover.1729367469.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: fd3c7585a0f84b26debcc216b86dc09acb219799
X-Previous-Commits: 9e775a65eb3ff49ded231aeeeddd59ccdce3c8a8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

These two commands are similar enough to acknowledge each other on their
documentation pages.

See the previous commit where we discussed that option-less update-ref
does not support updating symbolic refs but symbolic-ref does.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-symbolic-ref.txt | 4 ++++
 Documentation/git-update-ref.txt   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index 761b154bcbb..33ca381fde0 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -73,6 +73,10 @@ default.
 symbolic ref were printed correctly, with status 1 if the requested
 name is not a symbolic ref, or 128 if another error occurs.
 
+SEE ALSO
+--------
+linkgit:git-update-ref[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 5866b6f2d37..c64d80f5a2d 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -190,6 +190,10 @@ otherwise it will just try to read them and update them as a regular
 file (i.e. it will allow the filesystem to follow them, but will
 overwrite such a symlink to somewhere else with a regular filename).
 
+SEE ALSO
+--------
+linkgit:git-symbolic-ref[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.46.1.641.g54e7913fcb6

