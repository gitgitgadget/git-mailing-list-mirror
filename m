Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D17B19A29A
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541541; cv=none; b=ZC4lupMz+whiNrvQPfmgFgh3nEzAjpzDnl1nQY1PeXTL9lodIi/jwBO1Ty3HTbIgNrOwhNOTUb1mhIJggz71pn/LHJnDLhETeShsAUiov1mRvt5SjeCuFiHqJNnx4oIypjUsWLqzEtQ6UHLIxOy53VZnSPpjYO4ZaKY+74DvYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541541; c=relaxed/simple;
	bh=vcoJvbJM1pGRGVHJToDh9JKl51Pz1EXZDsOFlVlTcQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRJvuUCkKFPExxrEdoEmp+mtsd3mD+Qn7azaEEQjtBmz/Ieg29orf7bkDTfT/sGVQD7/JDaiGSd76XzO7TRsA9ukrTy0iVC9V5AK6l25umatix1zejdIFbrMIOcqwNvkmKkmmQ/5Cb4TTXZ0/hqUpPklrI8ue2GkS+kbG3RBVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UWNMAgGI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qBsybQl6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UWNMAgGI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qBsybQl6"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 79850138FD97;
	Tue, 13 Aug 2024 05:32:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 05:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541539; x=1723627939; bh=CEcQoDcK3Q
	QoKfLk5yqIfvuZmFRzqrzQkFnFX+Ly45s=; b=UWNMAgGImq98aGA48NSuAZaprj
	UmM2h5gVCiL9dcEvsH3WjDZRFI3vDjQjfxNOLd247Cqzaxpwaq+FZobMQ6rO8C2r
	T23Jj5WpgF7y98qEnYANNqJKniDo6RYLN20sUZQcxA/XG7Kp0R1QVeAw+TF7tdOq
	qLexxzmxr8FfDEDXk7dYEIM9UfqQL/BQ5T8jX4Lf1Wv1QacKUL0B5YUTRiwVa/B+
	/sgXK3OkREMorvmoViHfV90AQiFfVGWZWEfsx1ar1fvDsYwgYW1keXcpNMhiFVv9
	b/D5eWReUCwhAu3AEZjmlP4dq2+Q9oSOzNc54qCoTYu/jLMVmJFiAIKgNLCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541539; x=1723627939; bh=CEcQoDcK3QQoKfLk5yqIfvuZmFRz
	qrzQkFnFX+Ly45s=; b=qBsybQl6TvFtPZA/iasYZZ0xDDl4oiqwAhCiIeCvnBkl
	wo3obQ8cx5MMk641Sw4dwnHSmsQ5McLmxZahhKopEOQ52UpK4FHLUeJyj5kJeRHV
	SglseWrW43k0jlHVtcEcx7u2Bhq96Xzd0XEmShw5MI7MkvlhsOrx2ei7BzWiSJAw
	CYBVYkeOo1jyXACYqiVrqi+P4RPAO4geMMIzDnn6Re2OR1mPmfSRC1MlMJM7ntGu
	VbyZeOwIwVbWb5bJSdEmqxrcclExA90qerMJbODcYwPyUOfL9bLGMFG8ipfgYMeG
	WLF2PQBLyx2xTgsjM5TzOp0k02RP+PzTOeRpZEKMaQ==
X-ME-Sender: <xms:Iyi7ZqwstA3hHdCGbyQdzvb4JfGFgnROgCWGqWR-RQnTsakilYMtAQ>
    <xme:Iyi7ZmSpX1Qsi-2PsRZTl-QjAmtGj-e8a7sd3jLDhGgF5THx3rO0OCu-BnCCIzLTU
    1C3Zm8IuyICcb1FaQ>
X-ME-Received: <xmr:Iyi7ZsVPe7b6n3ZIMZ73de7X3ArCriCY3xZHGG3KjhXsHVAB714B5TptiF14Y_EwCLiM8oprNSjAd1z2Ee96UqVR_68_jgBMZkkBVmKRZS4TIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehjrg
    hmvghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Iyi7ZghhqyBg-d8gySFGzj8hehPvuglVRit53w9ILPnYyzNhFkHx-w>
    <xmx:Iyi7ZsBEyYHPNczAEwyhlrl_9efd3XvM6P0DlxS9E1twWCzaD1G1jw>
    <xmx:Iyi7ZhJiXXjgFiwLB4fXrtB1XfN-QnoT8mez3oK8kf5N9jSXbBpFXg>
    <xmx:Iyi7ZjB_FJ20Exh83r5S8mOKzIEGZ1NqNHh6tZg824LMYOMdPSn3Tg>
    <xmx:Iyi7Zu0Udkzdb0KTKrP1ADWObgswQZBGKdxjpvTLjNunFxEyBWb5yvhB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:32:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ae28efd4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:32:01 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:32:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 22/22] builtin/diff: free symmetric diff members
Message-ID: <31e38ba4e150c9bc9e3aa1073869881ccba9035e.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

We populate a `struct symdiff` in case the user has requested a
symmetric diff. Part of this is to populate a `skip` bitmap that
indicates which commits shall be ignored in the diff. But while this
bitmap is dynamically allocated, we never free it.

Fix this by introducing and calling a new `symdiff_release()` function
that does this for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/diff.c                       | 10 +++++++++-
 t/t4068-diff-symmetric-merge-base.sh |  1 +
 t/t4108-apply-threeway.sh            |  1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 9b6cdabe15..f87f68a5bc 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -388,6 +388,13 @@ static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
 	sym->skip = map;
 }
 
+static void symdiff_release(struct symdiff *sdiff)
+{
+	if (!sdiff)
+		return;
+	bitmap_free(sdiff->skip);
+}
+
 int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -398,7 +405,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	struct object_array_entry *blob[2];
 	int nongit = 0, no_index = 0;
 	int result;
-	struct symdiff sdiff;
+	struct symdiff sdiff = {0};
 
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
@@ -619,6 +626,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		refresh_index_quietly();
 	release_revisions(&rev);
 	object_array_clear(&ent);
+	symdiff_release(&sdiff);
 	UNLEAK(blob);
 	return result;
 }
diff --git a/t/t4068-diff-symmetric-merge-base.sh b/t/t4068-diff-symmetric-merge-base.sh
index eff63c16b0..4d6565e728 100755
--- a/t/t4068-diff-symmetric-merge-base.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -5,6 +5,7 @@ test_description='behavior of diff with symmetric-diff setups and --merge-base'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # build these situations:
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index c558282bc0..3211e1e65f 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -5,6 +5,7 @@ test_description='git apply --3way'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 print_sanitized_conflicted_diff () {
-- 
2.46.0.46.g406f326d27.dirty

