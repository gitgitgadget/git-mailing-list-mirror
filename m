Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9421B5EAD
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881504; cv=none; b=kWQriw4LbhyYx+sUiv40HywxmNDNj/ruK+yms6Ia7Dm5gB0y256KoKKg8ypP6AGV5oOSVpHstiW/+rKCmewyoqTTfU+7yDETdLXGMd+nNzmYxBtaacs5DvflnrRx2K4YKw1ug0FId6nl9QbQPvix97Vn8eRgvlnyrIf9Sr9I5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881504; c=relaxed/simple;
	bh=C7z/iCE/1hur9/8VMKHO+GI/sn2RvwS6Y3WUYRC7idY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apCEQnir77I35QXAqVciuK5SGY5IOaYhHEgqavvS1MnPa/eKW/DthW8ITqPPSxsl3Vej6WXMdDWmoN6g4Wp1mpXCPTGzNF+2UBSSpSB96dmNqT07QB8lB7HLi6b2s4MLEEe7pbO+FogaboqvSlnoFnjOLhqKiXYofyYQis3nGt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JnDaYi7v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IvbCYJLE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JnDaYi7v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IvbCYJLE"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7238A11400E8;
	Mon,  9 Sep 2024 07:31:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 09 Sep 2024 07:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725881500; x=1725967900; bh=AkmkpDVajB
	VV7+ylWdzYV0buq11FmZcCcv4QMp1OXg0=; b=JnDaYi7vxDh0RGves4wJm8bcXS
	5W109uf/ZfFIrCo4QtdKZGQHWmf4ArSqGuHHqpaMEkz8Mql1VibQNxaCIxzVifHN
	M2sfc/Cg5Qp4AU1yvqBNvg0bjetmAaona5KDtsJCW/RT4xrzqysGzVurstcBCVav
	Kp4J9cqiHsKOrKthHRxTq0oXwOl5LaDUftvTR954FDOOJuWhwPqrP0kcFvcPH4fx
	busxASRT5n8TbhMKpqzazrghGm+h2Z6D7bR3QyPLHjyG7KNhgpSSdtPN0DxfQC04
	K8cWZoM9YxHAoI6wwjO9XYo1oEwQKaoV8lHaKXMsxfc2Q2AaFwjre/juC21A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725881500; x=1725967900; bh=AkmkpDVajBVV7+ylWdzYV0buq11F
	mZcCcv4QMp1OXg0=; b=IvbCYJLEKcsnFGMnqF+i0e3X1aqETP7phyulTeDi9Ct+
	it3y55EpfebVjvNiJaMzSJSnFMd8fwLEjlK6eayyQF8wOQCM5xan/sgb+iREBLJU
	8LtWd3BFX44SADo73gN/J0cg+nFtkfwV9bgGtdJwkTnAftDe2wPm/uFfUlgHTWlq
	iWd7bIs5jLnkp7kqaRcE11jgIZ7K5uWT5K1LbKVlRf+Gdd+OgrvjT4hMCQ8gZfZd
	0RuNOMDqnsMmv2mpyM1qhX9vmzq4+bU7CW066E2IjQwNBPOW8gYFVEkFLZXEnnhh
	M3jGW0jzo302sOBWR3JQI8dolB3UBwAq+Um78PDOrA==
X-ME-Sender: <xms:nNzeZndLAHm4AeEOdEUm0l49wZIMWDhB-ZKAdngeM8uIyguC8WatmA>
    <xme:nNzeZtMnl9QJZ5M1bQi1_2jWapp6iPgmwIyVBBB3cF0Lq8v_BmcxEhl_AXpBXZ85t
    izbukYcfQHm3appCw>
X-ME-Received: <xmr:nNzeZgjfB_p-SKLXlaMbWKnhzFIo9PwHbpJkpNyfpYUDbd2lJuNd_5HKSlk1CF4BnKiPdRxENma-vV0vRiBv0X3YaTy73fdpDG3m7dkovIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homh
X-ME-Proxy: <xmx:nNzeZo-S_ldXxE1ngUxQnz4hEvjhfvDnvInzsRcak1pPlcuT3AAX_A>
    <xmx:nNzeZjulKIn-KQpzxvpfJWGRPA8wMbeAWM-jrboxic8eoLSk3qqt4Q>
    <xmx:nNzeZnH4C-jElq17HWM5_GYXimR8hHL4JKX8lwrzB_6MOPQmSTWWRg>
    <xmx:nNzeZqPfFwfdMf5n2CsVi-jlsoekFgdiHHd-jWHTR2Sec-c9buBZHw>
    <xmx:nNzeZs7-LjDMYVYBdCYrkWpJ_R2e9qjNpS16l-oX_4VRXmg31uPrFdLt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 07:31:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9992d74d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 11:31:37 +0000 (UTC)
Date: Mon, 9 Sep 2024 13:31:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 3/6] Makefile: stop listing test library objects twice
Message-ID: <503c44e6cab5b574c02175154a5234974f6da439.1725881266.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725881266.git.ps@pks.im>

Whenever one adds another test library compilation unit one has to wire
it up twice in the Makefile: once to append it to `UNIT_TEST_OBJS`, and
once to append it to the `UNIT_TEST_PROGS` target. Ideally, we'd just
reuse the `UNIT_TEST_OBJS` variable in the target so that we can avoid
the duplication. But it also contains all the objects for our test
programs, each of which contains a `cmd_main()`, and thus we cannot link
them all into the target executable.

Refactor the code such that `UNIT_TEST_OBJS` does not contain the unit
test program objects anymore, which we can instead manually append to
the `OBJECTS` variable. Like this, the former variable now only contains
objects for test libraries and can thus be reused.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index bdea061971a..4ed5f1f50a8 100644
--- a/Makefile
+++ b/Makefile
@@ -1356,7 +1356,6 @@ UNIT_TEST_PROGRAMS += t-strvec
 UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGRAMS += t-urlmatch-normalization
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
-UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
 
@@ -2715,6 +2714,7 @@ OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
+OBJECTS += $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
@@ -3852,9 +3852,7 @@ $(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
 		-Wl,--allow-multiple-definition \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
 
-$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o \
-	$(UNIT_TEST_DIR)/test-lib.o \
-	$(UNIT_TEST_DIR)/lib-oid.o \
+$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_OBJS) \
 	$(GITLIBS) GIT-LDFLAGS
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
-- 
2.46.0.519.g2e7b89e038.dirty

