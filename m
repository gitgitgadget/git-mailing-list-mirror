Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010A91D6DA9
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736149905; cv=none; b=Tzs41tX1HAYQAtko/u+DRk+3NaUBIARYrzvjHnD498Yh/hzpGfvPxL34R5WVutwO001Bra4ISt/9q2CGV5gLNExg/kiuDMZiatnw6PDtbrLDHw/P4lufVlGFby/5btczjTF5mFmHqQXh9ooY7+09pI38wbcQ30IE5fo+53e5wTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736149905; c=relaxed/simple;
	bh=xxWzgQPuaLofyomp8vAxfneALb8zRfEwR6b4kRe1y/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGGdeEH3qzngEkaYS/TiW40NEBDhIFfkyqaUUosMyU1COEKIyZHlmyszmho3TRLIrc4xHGLQE+yzTJdJgpCU+AV5NG5o/BNNqbI2SDj0V2oIwz+ABQ2I/LqMFC7ikhbMMwEatn4sD1GoT8/BnsdKqLjkCkP5dHVOjEvvsY2lRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ssa9vKtl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDimeJPR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ssa9vKtl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDimeJPR"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17AA111405C2;
	Mon,  6 Jan 2025 02:51:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jan 2025 02:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736149903;
	 x=1736236303; bh=eqqY8LHio88BRcUhsFkwGEPLafQ0cBHf/5dcK7YyGls=; b=
	Ssa9vKtlcXItPIapHXrnQSRj7Pg0johtA3aJ18GTc2tszosgBxZOdVAHY3gUaUkg
	J1DrCzwwZ6CCyR9L8BJfzhtIrOaQMrNwBJsGoyvvw4Stq6wtpO24kRG9dSKwfCbm
	hIiEkDe4Y+cdFWgdRgjE35rmgT6bj8pi68E/nG3G3CC6VID+M+cebiZkW3+jlBaa
	HG0T34K3/geUz6C35quF68biMY9BPt4XN5vF49VNS9F7lHphmewIibPKzFLwuDhK
	6ZxVB1UEYLEMnolQp4INpZzlZSnK/WlFJDXu8TV7vxBwZQRDjIX6VBe4CjTRjcR+
	AKdOQE2B910hWfasAt0NLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736149903; x=
	1736236303; bh=eqqY8LHio88BRcUhsFkwGEPLafQ0cBHf/5dcK7YyGls=; b=g
	DimeJPRVWx/H3wyJES1H8wAJU++yWMxCpn33rE4GBJdiGof03M+ukKRy0mfKk8qf
	bnmcJqNBvRcP4HxkrbmN03GFs41XAnCzXSNytbMjWsrh9zxCHGIoP3HM3sJVcs7E
	YAv0KIyuWjIbKZx5i6/K/OJHnSZpLNyuO5dCC8dDCgllfkbi+ZsC79bDqOVYswbG
	7Wjt7B0IiLTQLLLR4MLmvpCF+J2V2nhemszbi6FEK1k17yxkGe5hBLbd6PWe5lPZ
	typBvL60MoySErLFRY1WkdqThEpYjm4U7GUxgPW6q2ZTE23hSQULSSC+q8TCAtpr
	PT8IMqN1SUODPGtiO3ftQ==
X-ME-Sender: <xms:jot7Z7d6-sYRCkiQNNrZSK2vPRUzRlrbgVo3FA5Pd-V81Fk_3-UQxQ>
    <xme:jot7ZxPGkN3ShOvfid3WjQhIjA-FCFF_p_3qRYwJriLXOegHWrNFyU-A4l87MvHjC
    47hrDDEWvRfxdktKA>
X-ME-Received: <xmr:jot7Z0jAfXNJ1XuAkszNtQ6L9wQ-FA0SzKDjONoXcWR7zUktX_EkLrYOr0aV0HxqTQfSPra0ClgJAmj3DYbV0MG3eH0UUAoa-ui1WIXJ4o2ngQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefledgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jot7Z8_6jh4dPM9gsD2GjO1tjGzVcD6Tf8TfAuPZWs8gHBkp_SKSGw>
    <xmx:jot7Z3uITm35Eetph0DvF3zUB30HZrDFWCrBZ3LHfh6BHuxJRayXLw>
    <xmx:jot7Z7E6WRVIy__xLNIor3vCt3Q3aiMvbxmcOwmuj7ghOgPPvOi50A>
    <xmx:jot7Z-OUgk20VGGTfNpLxXT_TvqLm_7xYHq3YVAwVqkARgxlw6tDsQ>
    <xmx:j4t7Zw4Kdrn0Sq9kDIO7lyK1BRok474j6WjYk1HP7A0Rn734TOVWRoaL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 02:51:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 34499e2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 07:51:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 08:51:36 +0100
Subject: [PATCH v2 4/5] builtin/pack-redundant: remove subcommand with
 breaking changes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-pks-remote-branches-deprecation-v2-4-2ce87c053536@pks.im>
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
In-Reply-To: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

The git-pack-redundant(1) subcommand has been announced for removal with
53a92c9552 (Documentation/BreakingChanges: announce removal of
git-pack-redundant(1), 2024-09-02). Stop compiling the subcommand in
case the `WITH_BREAKING_CHANGES` build flag is set.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                  | 2 ++
 git.c                     | 2 ++
 t/t5323-pack-redundant.sh | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index dc3c980aa7a4f42d27ed72415a636ac82b2a5684..e6b0d859803ac4d53079ec2a39143441a5662203 100644
--- a/Makefile
+++ b/Makefile
@@ -1278,7 +1278,9 @@ BUILTIN_OBJS += builtin/mv.o
 BUILTIN_OBJS += builtin/name-rev.o
 BUILTIN_OBJS += builtin/notes.o
 BUILTIN_OBJS += builtin/pack-objects.o
+ifndef WITH_BREAKING_CHANGES
 BUILTIN_OBJS += builtin/pack-redundant.o
+endif
 BUILTIN_OBJS += builtin/pack-refs.o
 BUILTIN_OBJS += builtin/patch-id.o
 BUILTIN_OBJS += builtin/prune-packed.o
diff --git a/git.c b/git.c
index 46b3c740c5d665388917c6eee3052cc3ef8368f2..a13c32bcdc694460fcafe8079d3aa6e8caea1b4c 100644
--- a/git.c
+++ b/git.c
@@ -589,7 +589,9 @@ static struct cmd_struct commands[] = {
 	{ "name-rev", cmd_name_rev, RUN_SETUP },
 	{ "notes", cmd_notes, RUN_SETUP },
 	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
+#ifndef WITH_BREAKING_CHANGES
 	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT },
+#endif
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "pickaxe", cmd_blame, RUN_SETUP },
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 8dbbcc5e51c06d7c5f56fcb3107860fcb66a5106..688cd9706c876a7edcaf0bcd642ae08ece188d4d 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -36,6 +36,12 @@ relationship between packs and objects is as follows:
 
 . ./test-lib.sh
 
+if ! test_have_prereq WITHOUT_BREAKING_CHANGES
+then
+	skip_all='skipping git-pack-redundant tests; built with breaking changes'
+	test_done
+fi
+
 main_repo=main.git
 shared_repo=shared.git
 

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

