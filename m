Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350181E573A
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071810; cv=none; b=Cjk9bZz93MeN4SLIXmoh3NYZ/LybFapbZoi5RqvBrIWtk9wqaOommpEThnZfrqyFEEB4v1p0YkCQGN7RO7VGprk/hS2o58Bwg0b9keP1UuV/1kiEQgKtf5egkexcH+Pp65XfXVVOOC41ycmgnRZqvZzRAZ/clu346ECw3/d+jJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071810; c=relaxed/simple;
	bh=tgNZSXqJpeH71x7Y2HLTACO6t9mU0604RxK7SjwYtdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aivmnG8hFKnvqC+NfELqMRBKakDnbU/g1w/o+iEVLQaSDBbEHCA84svtjrouv7rQ4oupqJPcoXuWIruhDOmXSKStd8qvYxYqx1F0+AU6qf4snb6IHH+JnwJ243Y2ZppKCJDL99yJia2bQKEPmOtduzMjrcieUOvxlRvm1RwxAb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qf9Xcs9/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jIPSXfO4; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qf9Xcs9/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jIPSXfO4"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65632114018C;
	Fri,  8 Nov 2024 08:16:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 08 Nov 2024 08:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731071808;
	 x=1731158208; bh=KwtD8ze5cB8D+bzP2jTyF8fb8nPUFTuMcWWrHTQdBl8=; b=
	qf9Xcs9/AOih5lr1t9SHjlS6lxaTZ1h4ATmiGmD27kJxrNPPME4B8CGITX8ElNox
	OjZubCLm0CxVt/4n7VXwjKmJl98m6OYbHS7ZhWUaTSSqxENisOzugdq4T+tNrVJb
	jDgrIvUjQB53BpPpCoFivK7GqEVAwqL7NvDuF+eyv/krnhWhZW02SmnP+e1DFbQ1
	8s0qRotJpxXtDnnqiaZu9BRR4bm7tkVUzgw/QJT/sfF0RTsBh6E2GlBuA1ZNxNVj
	+B/1YLpFE14RyrjyoU143eBK1m/qUdQOlhnxeJsnTwgJFaN/TxAq0gzNYyULG+aj
	kn/Se0khHJQo4UbddhO2Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731071808; x=
	1731158208; bh=KwtD8ze5cB8D+bzP2jTyF8fb8nPUFTuMcWWrHTQdBl8=; b=j
	IPSXfO40tQ/qpI5A15jcwVTsDDEsFFgVDxJjuq7UoB/wENVqrIhhad5nHaS2sJvS
	X8JL/veUztYA4IeMjiXkPfFEQrzr5Gx9rx3pyA/tIqW3eSnlNNJi6+U99OgyXQwl
	k5VEsXNQ5QuftAE0LoNxNZNyH0WO4pJwM8OjldMhjNb3/H/LXKvgiIo/ENZZLa19
	hed2xR6PGmFok9DxW+A0SfHhc3m9ezzPXNwCo7dQAh0x0ihsHHTiArBssHEIaIhd
	2cdBPmvx5ggG6A5xH1+2Z2zIug4bayHhQBzoQMkdoPlzoH0XK6snVYKdUA8w8LAG
	gDcpc8njYoJLcsDD60OkQ==
X-ME-Sender: <xms:QA8uZ802CDMUHgxYwFvLDVNlJH8dCbJpP_Ui1dNLkMK2ZFHxbzFN_w>
    <xme:QA8uZ3Gfra4SULHSKxwQ9jf9Dlp_iXTe41fjf97SbGEZjx4Tyav5vnI9B_xo0sVsk
    Qza6LHR4BnzawET3g>
X-ME-Received: <xmr:QA8uZ07BuE5ow4kVn5rmrPBTGZIiGceE4bSQyYxtP1ZQkgNdZCv_BY-gMsKF5w-VhywCfHqlSC_kGElNiYfVV5RwTcpqXTSXZu1znt9oSMk-fEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:QA8uZ13OIZ8ybZl1WjrzcclD7pBP3Nv6_N3JaSJAbgzmsprz4ZE5Nw>
    <xmx:QA8uZ_EvzEAWwVrPLnu2mI8dB6bucOiWlZpZQwQT7Mvhi3FmJxfgOQ>
    <xmx:QA8uZ--LFbuoFTwnCf41WWoYn_zet23ren8rJflux8BYRxpqYnmIyQ>
    <xmx:QA8uZ0ng1rjw2N2uyJBY45lIFlQ68GF5KQn8mCcL4GcIRPpoK5SqFg>
    <xmx:QA8uZ3Dg4w8S3GzN9ux85OBHNnUrGXN1LIKHF4-J_8YIV-LHQ0XYkVIB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 08:16:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ef58038 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 13:16:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 08 Nov 2024 14:16:25 +0100
Subject: [PATCH 3/3] Makefile: let clar header targets depend on their
 scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-pks-clar-build-improvements-v1-3-25c1fe65ce37@pks.im>
References: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
In-Reply-To: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The targets that generate clar headers depend on their source files, but
not on the script that is actually generating the output. Fix the issue
by adding the missing dependencies.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5232b913fd20f01a7e5f41d46178e93d52c9f534..549b24e7fdbbdc173dfec79cdaddf67ccba52e14 100644
--- a/Makefile
+++ b/Makefile
@@ -3904,9 +3904,9 @@ GIT-TEST-SUITES: FORCE
 		echo "$$FLAGS" >GIT-TEST-SUITES; \
             fi
 
-$(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES)) GIT-TEST-SUITES
+$(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES)) $(UNIT_TEST_DIR)/generate-clar-decls.sh GIT-TEST-SUITES
 	$(QUIET_GEN)$(SHELL_PATH) $(UNIT_TEST_DIR)/generate-clar-decls.sh "$@" $(filter %.c,$^)
-$(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
+$(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h $(UNIT_TEST_DIR)/generate-clar-suites.sh
 	$(QUIET_GEN)$(SHELL_PATH) $(UNIT_TEST_DIR)/generate-clar-suites.sh $< $(UNIT_TEST_DIR)/clar.suite
 $(UNIT_TEST_DIR)/clar/clar.o: $(UNIT_TEST_DIR)/clar.suite
 $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h

-- 
2.47.0.229.g8f8d6eee53.dirty

