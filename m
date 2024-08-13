Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF90217E8EA
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541497; cv=none; b=Fd8TFfDnOzrnBvZ06pI0kQEjeOuaDaFL2qXcYyf7XKdDOwSCf6omzOxk9JSKtI8dhH/1xrOGI6+dFka0kBlPtAPaarC0fLHUueWXvCr5TWcuFtFwPsspbe5PMPkiSbnHEji3phy1cdkTfDigg/eBRdfKQcMTqnfjtvKQ3bYXeRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541497; c=relaxed/simple;
	bh=i+z0Ja1UQC9OBf3tk7CNnJA2y7Cbl+JFKmwwPYAvNuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT9zzCzFzqkUDjcUgAfi6pWVGF8abloaQinZtD9CM5pZpy8+g+EfZCjlmqfv8A4MHdgE8uTw0bGlWL6eLVqWVMtwktOIi2qLjyKKjAcPRqS5ol3+ZRIwoYhWriNHJHFbCjHUTOeV69T12B5FIBu0CEap3QMAgYTqG/eckwSvjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S9XNQJ0Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cox3naoP; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S9XNQJ0Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cox3naoP"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D849E1151B39;
	Tue, 13 Aug 2024 05:31:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Aug 2024 05:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541494; x=1723627894; bh=BOqUsUHyb3
	BpG8+cATWFsGtJ7YKoNLA0txlZw8OisMA=; b=S9XNQJ0ZuiWtWEJeK9P8SwdBB/
	HVz1PYJPA4d6RmBRVL5H3FOhC3oUrd/bGQ54vhDZFuaMYg6jr8ly36jmelobnzxq
	LCefuHYeo1hsgZM3FlFjvmb4WQ3ni5V49ZsATcyZoCdw8TyzwWxJ9/AnNIlVe2DM
	brHO0izRc5DqjtFSSTSu/GbptwlVB+RKSdvEmqvpXPc2DekBhpwLqsw4IEC8GJ6X
	s/MO1qtYdbQcVJ2brRoo2Pag6GMnAku1pMsU2A/Xd8a19Caa/6RbR3OAzprKwDtE
	6lBB+LIHoadnLo78Vn9oa297mnC+xPoJ3sbmZj742OXG83n0VafXyg3/RX1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541494; x=1723627894; bh=BOqUsUHyb3BpG8+cATWFsGtJ7YKo
	NLA0txlZw8OisMA=; b=cox3naoP+0dQykRVJ6GI+aLDb6CD9NU64LcDgJ1SB+qS
	lKjPsSz4lA/6E4N/b4L9xDEwRamlC7pZ4qSI1/zf5BnTzaLGvGPXBLA2vaqCXQxw
	uXA75MfhaXF6fLI744jzZBfSmE1JmCLeb14WqeeDkyvKKzchSOI5M3MGmXwOJ0jA
	1i+VisB3rGaxrALL828fbgro0wRpFgPApQiPqDgEVmUWQi7PQx9qT29nGer4DXmV
	0rnAcKAXc065a1K+/7fWXfknQHHQiR0tQuk5TGuZADFJqXczEP+Y8ZjuCmmabsaL
	XNS0R3CKHs702vzTxQv7/V/eO4b+CEOLRnMnBLtuxQ==
X-ME-Sender: <xms:9ie7ZhgLUBu_pKuwWG1i_DG8vPGyH2VWr2nVl4q1kcRSS-bVAclv0A>
    <xme:9ie7ZmBlIt31-kkj9cDYIS_T66CMagqwg1-fsJ3LiHzBbrRaZWGUJkyLkOwtpyuXa
    HRyN7Vwpdz1OAXxtw>
X-ME-Received: <xmr:9ie7ZhHCmbqZBBC9PbsfZzJUTGLKdbY6G4NQ1KR5ZOYOo7mFtO3t_YcPJdUAcGAiRELLKEB6KzAE1AQEmc-u94xdLKUmnf_HoDJYB3W9z0QTLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9ie7ZmRTYoJZRIFAS_76f2MxWJB3qfCDWENkcw9lNnrrWMQ6fQ-JEQ>
    <xmx:9ie7ZuwdPa8OMS0RdJ4WxN7gtfcuV7t9VAk0j5C6iQI66GG2Up1B_g>
    <xmx:9ie7Zs5hXkQft7XKnwHojUOCdX0S3P-lFcBWHYg76kngvdlQjwwPig>
    <xmx:9ie7ZjxKlCjJxlrB9vLbAJXHmrxKb-OFGK-rOLcZ1q6drBR5dUlrkA>
    <xmx:9ie7ZllmtkEAGx6H5u8ttUY1NU9kXJeuE9N69vBx6au317LPot9E3FI3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 253c7f1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:31:16 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 09/22] builtin/rebase: fix leaking `commit.gpgsign` value
Message-ID: <1d3957a5ebb527d672a66f6f6226b6668924a2fa.1723540931.git.ps@pks.im>
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

In `get_replay_opts()`, we override the `gpg_sign` field that already
got populated by `sequencer_init_config()` in case the user has
"commit.gpgsign" set in their config. This creates a memory leak because
we overwrite the previously assigned value, which may have already
pointed to an allocated string.

Let's plug the memory leak by freeing the value before we overwrite it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c              | 1 +
 sequencer.c                   | 1 +
 t/t3404-rebase-interactive.sh | 1 +
 t/t3435-rebase-gpg-sign.sh    | 1 +
 t/t7030-verify-tag.sh         | 1 +
 5 files changed, 5 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e3a8e74cfc..2f01d5d3a6 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -186,6 +186,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.committer_date_is_author_date =
 					opts->committer_date_is_author_date;
 	replay.ignore_date = opts->ignore_date;
+	free(replay.gpg_sign);
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.reflog_action = xstrdup(opts->reflog_action);
 	if (opts->strategy)
diff --git a/sequencer.c b/sequencer.c
index 0291920f0b..cade9b0ca8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -303,6 +303,7 @@ static int git_sequencer_config(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "commit.gpgsign")) {
+		free(opts->gpg_sign);
 		opts->gpg_sign = git_config_bool(k, v) ? xstrdup("") : NULL;
 		return 0;
 	}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f92baad138..f171af3061 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -26,6 +26,7 @@ Initial setup:
  touch file "conflict".
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index 6aa2aeb628..6e329fea7c 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -8,6 +8,7 @@ test_description='test rebase --[no-]gpg-sign'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-rebase.sh"
 . "$TEST_DIRECTORY/lib-gpg.sh"
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 6f526c37c2..effa826744 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -4,6 +4,7 @@ test_description='signed tag tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
-- 
2.46.0.46.g406f326d27.dirty

