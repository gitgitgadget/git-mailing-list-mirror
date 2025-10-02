Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96217A2E1
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430316; cv=none; b=u9SekLZn9/AZZWDrBG58knbMIShenqc1bg1kBnJ2yiXzlrXf+Xb1VuO0tClYpDqgcVVA5wNhZ5/24VKu2BZ7JQmD0jbXX2Fa75IzFN8X4eRpb+JDWWEuXg7kPm+8AxPO4R2Tc8bTbfYtK4MfuAGzVyCWR6rB1/Az4AvOWvWpcNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430316; c=relaxed/simple;
	bh=3kD0uE+a6s3QULD5LA39V2IurFJDu6YV1ZCQAfAinYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhsgnVSyDSRONeIt78FXjwuKs4x6WrQy9DmbEhbqiI/UYV5Aw884bncvdzkGQ0WGvNH+nNlbM12yh7SVrth8i6ZIwDDnD+fA9wD3Lw7fmf98b3z2Fm/ZUm6+JgEKw8xy01p1oH56gOoV0GnsGQvCmXQRRvn86nw9z5AJeRUHefc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Cjnsd/WK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eidHjWHl; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Cjnsd/WK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eidHjWHl"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 18E901D00093;
	Thu,  2 Oct 2025 14:38:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 02 Oct 2025 14:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1759430313; x=
	1759516713; bh=htE0kM1BpUjW5nO1DaC+3p1F9rPdQgQHEjC/QdBvPy4=; b=C
	jnsd/WKcvM4QSKHk3OV+67ktqzlLw4JBWwwnDevi6q+sC1hp27KUI8GIzyFKZ3Cp
	HL58D0QjSHzFirj+RMyWpNRiiWBUzKxUXaIuYTYvbQNqsuff1O8DIqa+r13ucWeR
	l5yS3vU0RCr9AY2D4HWwaNPG27LglLBriLY7jzKyw/Le6rVSp3I06QCT++k/qF6d
	M1GVBGKy9HMeDwhOneTHGuWJIhzfmy/UejYzqITdiN5cAxDmMDPzIsO+ZpdSHj71
	fCWG/3aYLyPWeHstmqBNbWqqHiDuD0tRWyH3mgXVioiAm1s/dTq2PJKuzIemkpoc
	zXQVV5HC5DD3S9rCN4KXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759430313; x=1759516713; bh=h
	tE0kM1BpUjW5nO1DaC+3p1F9rPdQgQHEjC/QdBvPy4=; b=eidHjWHlFHOHPxvP5
	JgukRjlpFrdZ5s21LfTvEtVwG6BxmXZFP+3DF1Rq5vWlyYxPV/JkpyAI234vfT0a
	cJEwY7RJsfyIkI7JFWeme5XXKOPDRbBa0s0Zknzwf3ETsXqYrKIT1yaEzfq0xLGR
	yZsEtDjw+TM4VlpPVTwqetMH8GXNQXQG4sCMrMAq9tlY9wo1jAWm7N4woGiAG4ub
	pxFVT2jncTh21zAWS/HCr/cns8ubordU+io/X3WQqPWaPW1UA3IEswJPqVig/Gkk
	VWGAShymRV6Y0iJp97z1kj9U0jOyrUBe7vlSZPicmqsHiFy2OCKQ12yX00544hJ/
	/gziw==
X-ME-Sender: <xms:qcbeaOIFKCxjZoxBcZHKGj3ccmdm7ZF_Dh1t5B5IvJAPjZCByXTnhz0>
    <xme:qcbeaNBz2EVfrOOeqEIKmbU7ZvSfxKMOVG-lEYpEhEFlJTN_mNCpuAbaQcCxGSO2G
    saxQJsYbm642YqN8KhtqRoxnlc8yx38CnZSyujmoiTl52rt3Tm5>
X-ME-Received: <xmr:qcbeaHDCCPzJ2NVLjaihE4tRk6Q9UeRy1GyNN0dfU9kpbLrCf8mbOaW5gBrjnIy_NMQMDBeZYsvSNI17fPSPhZEljRzHcRNyl2csbxU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekgidtre
    dttdenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmnecuggftrfgrthhtvghrnhepueelieduvdefheejfedttefgleeuhfeije
    elieeiueduiefggeetfeeuveetkefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhs
    rdgtrg
X-ME-Proxy: <xmx:qcbeaPCTTBNnBpvIoNJbVMkLsdbEFeUmzkjFC6O-teIYtFTQRiEo-Q>
    <xmx:qcbeaCpa2roSBN_Q4yoSCRQfepMi9xpPsFSN5vKp_05siNJgINPyjQ>
    <xmx:qcbeaJl5rkqKfFxmsIeYd5swUKqWNdiaqJhHXeCHvT1qVguyB8VDmQ>
    <xmx:qcbeaCyEzqoKZCPkfg10RQ_-8O_xWaq5D8ysHlqah0AFJ4Ov-PpSrw>
    <xmx:qcbeaCRCgUrdruBSoHeHhwowZPzzq-nH0bU4_54Dm4PLXzAA_jKqc4Xg>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 14:38:32 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: kristofferhaugsbakk@fastmail.com,
	git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com,
	julia@jvns.ca
Subject: [PATCH] doc: git-checkout: fix placeholder markup
Date: Thu,  2 Oct 2025 20:37:52 +0200
Message-ID: <359afc34863.1759430054.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.327.gddebdc8c038
In-Reply-To: <df251b0c-c593-41ed-903e-8fb1c323b874@app.fastmail.com>
References: <df251b0c-c593-41ed-903e-8fb1c323b874@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The placeholder markup is underscore (_), not backtick (`) as well.

The inline-verbatim markup (backticks) handle interior formatting. This
means in this case that it applies HTML `<code>` to the underscores and
`<em>` to the placeholder.

That is the effect, anyway; we can see from the rest of 042d6f34 (doc:
git-checkout: clarify `-b` and `-B`, 2025-09-10) that this was probably
an unintended mix-up.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Since this has landed in `master` now.

 Documentation/git-checkout.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 431185ca0ba..6f281b298ef 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -61,7 +61,7 @@ uncommitted changes.
 `git checkout -B <branch> [<start-point>]`::
 
 	The same as `-b`, except that if the branch already exists it
-	resets `_<branch>_` to the start point instead of failing.
+	resets _<branch>_ to the start point instead of failing.
 
 `git checkout --detach [<branch>]`::
 `git checkout [--detach] <commit>`::
@@ -155,7 +155,7 @@ of it").
 
 `-B <new-branch>`::
 	The same as `-b`, except that if the branch already exists it
-	resets `_<branch>_` to the start point instead of failing.
+	resets _<branch>_ to the start point instead of failing.
 
 `-t`::
 `--track[=(direct|inherit)]`::

base-commit: 83a9405e59e9cdfb587b19c50f0c040f346dd4ea
-- 
2.51.0.327.gddebdc8c038

