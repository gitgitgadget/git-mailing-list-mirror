Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C87F1EABAC
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508205; cv=none; b=mhPBmDpthZlbcm5/yyCeTCFIDIe+KH5G5n09HJjJ/hucbUO4c4qWa4n/BCIyQE19kNh5fZ5EgOcu6Dw48MD+FExRW77zAh90bMBf1RrDi2dkSgn3LnaOG82IW92ilx75pIt5n5rsBeIjKrMGc/+ZxNznzEh+G6DXK8yYhbE3q9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508205; c=relaxed/simple;
	bh=heQD6RiBc84s/U9Cl+vV3Q4jHGUiksGseHFe+1ueKLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5HMETYf9NaiWlWMFVXU3R2yJkPVunUkP0iLK26dttRCa5posCSXvh2rxPhbiOGZbRVqG8jYpKZ84IucTxIQvdHLs3QB89M7GUTNP6rW/iTgE91ClGL+QEubsd9G2KUM/XNyGs9v6tY4ZglGHUdqE15iF9ZqQ9sJCo+yoiswSfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h1D+cz/Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kg+VlBiQ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h1D+cz/Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kg+VlBiQ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 498FF13805C9;
	Mon, 21 Oct 2024 06:56:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 21 Oct 2024 06:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729508203; x=1729594603; bh=pUxOpdGLnx
	uHasWNxzpE758H4lxrYuAvkx7y0fIAgBU=; b=h1D+cz/ZP4ZB5FAgqSWf5uqmJE
	O9O4hszv6ODi0SVfrsqcFoE7Cp5XKdLWGdrvS4UbCpdAkMRJCV+fWgHyGE9QGPOS
	pTgQqftgbpwVYpRxZwzUaC4wlLukyCcrpp3/ZgiP/vErECVyYeQ/3xVasyH3qoSC
	BV+KxYObwmQgAVW06drcIVQpCKdcm0twXtEviD8jaNEiUq98nFW38i8/hSFbYeqA
	JUqwyy1c4SqqTud34c1uh/ata0mBIH/ollaxY4fx2s35c35MC1AqrOD0APF7Eclf
	IasLO3D3dNpKkF7pXGtHbruBdVKSOVPayzuyCc+VABz7+549vfPRLj9RHrZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729508203; x=1729594603; bh=pUxOpdGLnxuHasWNxzpE758H4lxr
	YuAvkx7y0fIAgBU=; b=kg+VlBiQXWHo/Zfw8JPM9+soDiBt6zKGDa/R5CXCRRUA
	YG+4BQDikbeSG1pHJJfgBd19YK2DekCUmTvuxG4zWyku7j3C+7g1Z3HL1Exqo+F3
	9vwAL7lIj/rAJZ8jP2Vdk0onQMyjs+A55o0KvwrAEw42vMIOh+x3evMxfo1oSsC/
	wEtp66UuJQ7dN6sFTfJopCmTupFOMk8KWjxOBnz3p1cStLjUyzmo4/rnjKJ8pzsq
	0DbRs6rHGrIsOZT8k/kIvS5+hEB6omDzlfMSbXnzPQeThVm6ilb2K84jiUJ7L7Es
	2Rz1t7UdEMsxxchuy7+7oCqPpcbJDURMzRSVXprDVw==
X-ME-Sender: <xms:azMWZ2vqTbJYBpWh9NDdxRqJtFrHnYmS9JCXK4PZVUEN8AYCEOyLGA>
    <xme:azMWZ7cNYxgjUbisVulBwfUyAmIuf8q00y3nq4cZBwlqKUi9-HQxVZukEkLiPucqN
    SqnxYTwA6fIDubUbA>
X-ME-Received: <xmr:azMWZxyZk67C-h6QmwotESTQJmoicydN87EZpbTQ6UvlgfUndxFeNC17PPtIJ4D7eWrBoSrtAi7prz03G4SLa742Ynr3Sq7SqXFH4DoJm0AZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrshgvuggvnhhosehmihhtrdgvughupdhrtghpth
    htohepvggurhgvvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgt
    phhtthhopegsohhnvghtsehgrhgvnhhosghlvgdrtghnrhhsrdhfrhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthih
    thhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:azMWZxPFGqOCpVqD8QXplngapWy7RuLLwb7gtTIp-7ZH987KJJF9fQ>
    <xmx:azMWZ2-_PONNxW3j9YxTUl00eZQIrioUnkn58hn7LbSheuFD-pgqSg>
    <xmx:azMWZ5XYFZJ1m-ILtNSGuxnqZnINqNcx9_59fA8HKdm1NHnW5L0SDg>
    <xmx:azMWZ_em3CX4Gm5H4IoHS6SUFod_EMK1gAaT5djRmwDLhw9PpHX1qw>
    <xmx:azMWZ30LnhqEi4de8WAot9W0F2-g8WJoyTHaaT5NIj2qCIuAHvxJgbBe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 06:56:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3ceb8d40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 10:55:13 +0000 (UTC)
Date: Mon, 21 Oct 2024 12:56:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>,
	Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Edgar Bonet <bonet@grenoble.cnrs.fr>, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 3/5] Makefile: extract script to generate clar declarations
Message-ID: <c2e3fbcd8532038158a0ead6f0a2f752f557ab7f.1729506329.git.ps@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1729506329.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729506329.git.ps@pks.im>

Extract the script to generate function declarations for the clar unit
testing framework into a standalone script. This is done such that we
can reuse it in other build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  4 +---
 t/unit-tests/generate-clar-decls.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)
 create mode 100755 t/unit-tests/generate-clar-decls.sh

diff --git a/Makefile b/Makefile
index 0101d349f38..6318ec0271b 100644
--- a/Makefile
+++ b/Makefile
@@ -3904,9 +3904,7 @@ GIT-TEST-SUITES: FORCE
             fi
 
 $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES)) GIT-TEST-SUITES
-	$(QUIET_GEN)for suite in $(CLAR_TEST_SUITES); do \
-		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$$/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
-	done >$@
+	$(QUIET_GEN)$(SHELL_PATH) $(UNIT_TEST_DIR)/generate-clar-decls.sh "$@" $(filter %.c,$^)
 $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
 	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
 $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
diff --git a/t/unit-tests/generate-clar-decls.sh b/t/unit-tests/generate-clar-decls.sh
new file mode 100755
index 00000000000..688e0885f4f
--- /dev/null
+++ b/t/unit-tests/generate-clar-decls.sh
@@ -0,0 +1,16 @@
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
+for suite in "$@"
+do
+	sed -ne "s/^\(void test_$(basename "${suite%.c}")__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$/extern \1;/p" "$suite" ||
+	exit 1
+done >"$OUTPUT"
-- 
2.47.0.72.gef8ce8f3d4.dirty

