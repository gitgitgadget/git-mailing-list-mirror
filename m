Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909001A0724
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914809; cv=none; b=crSSS+YG3b27u9EkieIr1NYkxHgTt7OuhOkxFxYeei5sQyKAcoHmmwhgr6et6NwICZ9d+A2Jg1JUK95GM30n30aVqKbx/fzLkE3HWyzLFqetCgKb3AvtgtqMk4v8T9xenVL9sB5YkU+BGONYlO9mcCTD19JKPv5uJbZcrFXVIs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914809; c=relaxed/simple;
	bh=wT/WLnuP0m8AahY9739F/pF9KHkH1I4mJwQPtUfC43U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+RyWewmKsarqj3qp+pBmm7/yWVLN+weLCjxNx16I/EzbqmsftJLe5RQDm/NIEjI6KWyecFoYY40mZbmkf1UukGlBsbPsWcQaOgfcEA/uh/2qzC7+jKk9/oTDEuEHgOFBrtg7qpl0+4zeHvy8BoFrSVYemhI79z0NzF7b/vlEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uqbau+Ji; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=itKeSe3O; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uqbau+Ji";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="itKeSe3O"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B7D8E1380214;
	Mon, 14 Oct 2024 10:06:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 14 Oct 2024 10:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728914806; x=1729001206; bh=S1U9PHRDHL
	wDox5AkVkNYiaBNc0mAX6xsG7NWaKEJT4=; b=Uqbau+JiSVikApGYDyyx5H0dl5
	UIDRUhIxOhyiq/q/sphzr6JAe/4t8HtXc6QM4nyjEe7hOCVasSeONlHfvjWcJgCw
	hacpZCkxbEJ/6in9bEOVjFH+IzjPa8okCZoqjX4YLEBB02S+KloZg/1uoR4tRdA8
	1b+3TUGEDlQgpEJQTW9OMG0SBDgVBFVCFxsl9gRuttUcixETXmL511toexoCtWgi
	D/IFQt6PUgYdHC/J2GE+BfZdV3nforGCXvUmoPkRmUFhQLDbTk4QvIE+c9ONYmWU
	4hybLZDNVal877IqfavMx5Friowp8UFt8KcxhAo4UtQwbglM6Q7ejrpQmf/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728914806; x=1729001206; bh=S1U9PHRDHLwDox5AkVkNYiaBNc0m
	AX6xsG7NWaKEJT4=; b=itKeSe3O/AUXql9iwLjzTtEdAkdsa7xfTw+Xqfj6bRv5
	X+DxWbD5h0odEEUNcvNDvYgfYMBWfFNZBgxiSI1SXDEO8KDOYaUd+76yhjEN9Eqp
	oJeO9OF7ghd+3bHk/o6NAN87jRnlJb8h+oNm7x/6w5S0bDFbQX+0yJXiEXRe0sDd
	/UpGnJIPejRZ+2XLxpy8LkaoLUWVq1hKHqXh86e036MAh2v0cfwuFKEUIctNe8H7
	d9VNq82mAl4BImFuv2L/P37wytD0nNy173mMoQtYlT0bddGyzxu6apgXkH8Pa2Jp
	ylEDCFVkTS6rpFKMsyNdbrtD1KE4dRyQZehcl3dvZg==
X-ME-Sender: <xms:diUNZ6NTyCamSOif3TKyhs2AEsbJNvQ_0cug1rYBM13AAQT121syiw>
    <xme:diUNZ48qqjqoofSfJOOXBc7lEbfikcXb8l1EDj3OzhvLQFCi46-V_QNyYNtVY9IYl
    qaTGtfFnss0ucTATg>
X-ME-Received: <xmr:diUNZxTx5BEg89UQOrJ8A7Ls6hK5k7Qqe0RtzRZNUxhqcJwW8bTrkDgfnbn_JgeXPLhKw6Tq_oaH6-OzJVPr78ivDTSuAWE5WGYcOFKCn7MjUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvughrvggvlhesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghn
    nhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:diUNZ6sJZiqcP4y6HeaiQXxiBSISRO99Cz9O4CdoCD6zeO8XuwhceQ>
    <xmx:diUNZyeECSoWCXdX7eiZQUGghNGBB_cJiFfcJS5tWKsedHE-kEZ08g>
    <xmx:diUNZ-3qoplTtWHo2fX_KKSz4LrEE5GNiraM9upIVI-eIIhgLdb9uQ>
    <xmx:diUNZ2-GiFSTwwzRJfKLs1XD0Kv_rMPeuX33l9_g3_ZEOFrX0YQYgA>
    <xmx:diUNZy7h0gpuY6J7LASD2ZZq1dWGNz-LJEvnF80dVsS6wYtWrUwSqvft>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 10:06:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 11829577 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 14:05:30 +0000 (UTC)
Date: Mon, 14 Oct 2024 16:06:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] Makefile: extract script to generate clar declarations
Message-ID: <346aa2f08307fb9c501a4b9ac3322beb44dc9d5d.1728914219.git.ps@pks.im>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
 <cover.1728914219.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728914219.git.ps@pks.im>

Extract the script to generate function declarations for the clar unit
testing framework into a standalone script. This is done such that we
can reuse it in other build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  4 +---
 t/unit-tests/generate-clar-decls.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)
 create mode 100755 t/unit-tests/generate-clar-decls.sh

diff --git a/Makefile b/Makefile
index feeed6f9321..87b86c5be1a 100644
--- a/Makefile
+++ b/Makefile
@@ -3904,9 +3904,7 @@ GIT-TEST-SUITES: FORCE
             fi
 
 $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES)) GIT-TEST-SUITES
-	$(QUIET_GEN)for suite in $(CLAR_TEST_SUITES); do \
-		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$$\)/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
-	done >$@
+	$(QUIET_GEN)$(SHELL_PATH) $(UNIT_TEST_DIR)/generate-clar-decls.sh "$@" $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES))
 $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
 	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
 $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
diff --git a/t/unit-tests/generate-clar-decls.sh b/t/unit-tests/generate-clar-decls.sh
new file mode 100755
index 00000000000..6646a90f711
--- /dev/null
+++ b/t/unit-tests/generate-clar-decls.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+if test $# -lt 2
+then
+	echo "USAGE: $0 <OUTPUT> <SUITE>..." 2>&1
+	exit 1
+fi
+
+OUTPUT="$1"
+shift
+
+while test "$#" -ne 0
+do
+	suite="$1"
+	shift
+	sed -ne "s/^\(void test_$suite__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p" "$suite" ||
+	exit 1
+done >"$OUTPUT"
-- 
2.47.0.72.gef8ce8f3d4.dirty

