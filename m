Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25197189B9C
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655983; cv=none; b=G8dZd6cADe10Yp33tTZaBWi1f9uxsX0uIJCkDBIaYiirxIymExQ19sYEYmG6GGuoCqbUITEpoLUT7QzCPBIxzsUcXf7zxvY9KOTlTpBQCZz287jK6FqCve32h7oyVIyopP5c9vo7uVSyhJkewP7ojdVMNWO7jeeEBYYNzZn+u7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655983; c=relaxed/simple;
	bh=HmaWVd/qlEX3tK1wRRZvVUyEo91a6JvLpfLYGeEEggQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sh1P+YPdXHQt8w06Td8fFLGcvxYJl+uC72+WwkRl9bAx0zKjuupwbdp9RbzdY+HXG7sDjnqs/wztJr65JkHTY2hIZKg2b126fH1jUbuR5m8xN2WKyTuPm9FsN4UTn7dD6qZwhl3ymrUvzwvY2dzYjiA+SYGFtlfRm9VV4Ohu6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qHValeHA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wvc4giP1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qHValeHA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wvc4giP1"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 24DB41380224;
	Fri, 15 Nov 2024 02:33:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 15 Nov 2024 02:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655981;
	 x=1731742381; bh=5Rvx5axuIW+VFIvPcVnw08I3DJHTxTBtpsOYdElkLQo=; b=
	qHValeHAYxbTnQdCwJwBhWbW8BTFn3YedEov7txTdp+4O4B7X00tFauWsQXxp4fW
	lE6JltX8uwyL7PonYaH3S7doTcvf0G6/VsMnxRh2OJ7e9qghJtR2E+8QUbaNRpK6
	S3B2HfjXkGt/5m7dfiNprOXqscH3/2GRthkgMdayrmV19rvoDLf3m6bOn58hxv5+
	Taosa0bjqlo0zLNUoyL91rx6g/lsHbfQSFJvGipv2APb2RU0EtwQmB1oRRzBfaZg
	OVSi/GE+hdw4an+aJds1zJQd7MBdpU20FlEPZ0pcgZ/AEWI4z/DE7G5ma0Oh5buf
	i8OmEsLwl/hgPAr+yt4Q8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655981; x=
	1731742381; bh=5Rvx5axuIW+VFIvPcVnw08I3DJHTxTBtpsOYdElkLQo=; b=W
	vc4giP1iMd39g/eFHNOwsJMdDh9d2LUBrSmggkU8GBfQhgkt5USMLkYKq8BYIYll
	YxmAylAIrM8CcQthv6IMWgC7jkY1o8Bj0W0YnFLVoAdYjTuPIMfguoeuI8XCWygy
	W3Pbbf7VTB5N8SRN8oz0AzyJL81/u5CYXzZKtaH8bhfj0Nd3SNwIVXfaFVlKuntY
	5PakLAmNIggAxEw6UZuZBY/bw+2bV343yS/YpEBJm4xdYgr1LYxEuM2Di5d2bwuE
	T7Ws3Hy+BccLowtc+HSYH+ysOtCm7pGd8GpSzAl7WFoigeShB8FTvG1J2CVUw5B1
	vTWvPNPRgAjMy1TRVbbnQ==
X-ME-Sender: <xms:LPk2Z7xd6v0tyzEKbPE2K7Oh8d19-FnAUFkvEexGH_m4inZ5N3RjHg>
    <xme:LPk2ZzTtRma6rHuua80K7trOypW3DDmHiZhuYbCcrP6rLSUKeMUx5Ecd0VxK8poEK
    sZ5vtGpMCpp47R-_w>
X-ME-Received: <xmr:LPk2Z1UPoACJ9X2ugxdpxQdRautlv1so5lvSys-eHlo02XXCd5m7v1F8FSzXn61q-TmmeyOtNgSDSNx6ENvz2t5ek07m_xWLHUfZ45bvqd0YYDB98g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilh
    hlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Lfk2Z1hRLC9MCes528XTXtBJUCbXCg8lQh2RT2QS1Xp9ij40RfQj7w>
    <xmx:Lfk2Z9B2V3AbmqixaLICHLiL8z2lDtfBXsqoBX7q-V6x3bDwLe7Tvw>
    <xmx:Lfk2Z-ISo9IIrjUPQDotFm__YDVYvHA2nNaqJ53nJdPFbQsylWXV1g>
    <xmx:Lfk2Z8CnWwmFpXNxBvj3BYq8zwbv4AeyjH4JTPirCy6EmL-viIir8A>
    <xmx:Lfk2Z49usvXPYtWhemIHrpQ8Q97Rq4z1UAiG6grUVvV-bIX0a3SZdKHO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:32:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 27cd089a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:32:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:32:44 +0100
Subject: [PATCH v3 4/4] Makefile: let clar header targets depend on their
 scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-clar-build-improvements-v3-4-29672bf65ec6@pks.im>
References: <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>
In-Reply-To: <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
2.47.0.251.gb31fb630c0.dirty

