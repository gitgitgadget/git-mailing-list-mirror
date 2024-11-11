Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8B15CD55
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313518; cv=none; b=GLLXrgt3cpUryZikw90/lB+X9ENJBCwX5/TmwwQAv5IgnAirPyuidpYu9JWrdSOs2GwEW+6EkuV/1DpQ1NNVkh/cd1s28U8ueZsYUgU814Oq58j6o0FaBsABOybqw89Ayt0Nf0cHh2zvya1sy0Qk6hBnSqEFIe6CUrFLEHRLu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313518; c=relaxed/simple;
	bh=tgNZSXqJpeH71x7Y2HLTACO6t9mU0604RxK7SjwYtdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UvEayvzvOn+gL192iUjvLnQcOC3LgIgFGZK+ydZIXM1SWzcEu4rmTv13OkOJjNQkC/knOAXJbJh9f6C2hNKIqVK6opHDpNnrh4H7FutDXHY4D7G2gU8uLkSyRdf6WUiTQ+MyrIfcbzV/CE32was2Cx2dElSfISUs66sKpiJPeHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q7zorpG+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EFFvyb8t; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q7zorpG+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EFFvyb8t"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B7D1D13805FF;
	Mon, 11 Nov 2024 03:25:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 11 Nov 2024 03:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731313515;
	 x=1731399915; bh=KwtD8ze5cB8D+bzP2jTyF8fb8nPUFTuMcWWrHTQdBl8=; b=
	q7zorpG+MXfohjU4GB67BBgl6XU2Z5aFK2CVQxHTJruPhmTRp1S5ld7AIRGJ39AV
	LZe+T8bkNRlZiW4PZUbI5cqnoct8iBKJax/OIEgFPL7USlqNhfWI888sU1JRjFa2
	UfpQMAWbGXz8fhRN31TjW/uNmHOFMGNzGPbMiOt2/N7+8LNBE52LkW4ZAHF3c3SL
	Su3f8Pbfx7a1Vrl4P1Iv04yeoa8jHDv6dJ5WDKyDz91SDqZHY9VFI+7ibHggpN78
	OPCpRUyjUr1w/dzjdu7qnU1imr9cAENGjmwCZsiK7iaZGKKSy0CADk1UG1SCNFrv
	cuXxXXQbJsXEMjgC/UWw0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731313515; x=
	1731399915; bh=KwtD8ze5cB8D+bzP2jTyF8fb8nPUFTuMcWWrHTQdBl8=; b=E
	FFvyb8tOCs6MtgjXvLusX6B/c25yUtFOw/xMmzSeI8JxeOF8xU0TsuX4E/rWgLCM
	V0kxD6V9RZSj2HlCcHxq36gjOEb0JiZ6JY2ossOUqCQ8S47wl0T5jZKiKyRgTDv1
	DRT793ICNKE1llAcerBb5WMdPQb5jyopAcohJGEl6etmytJzoDnjq9k+22uduTxu
	wWBRA+ALebh0LvCQAVpegr09MRtQ54/SD2d07zGmsc74ce0KWdPwXNdr/i6w63SZ
	ieT/SRKC5hwdjH3NW59yUHdG9kGRK1Auw9NmOa5XN6JUzn4eoBrPlT+QQLQoF3Gh
	BVp1Jf8Uaa7R9b0NqXxgA==
X-ME-Sender: <xms:a78xZwga2jJzxq73jSHGK6f6dyIwgMXLPxJf-UOdwvge4RW_ayaCPQ>
    <xme:a78xZ5BhltEFMtriDFWgRWMYK0TQkFbzyWlMVgS3hEB4VNy5aCZLlba4JcS6U4YCi
    M80LbRYPL_IR7mtbg>
X-ME-Received: <xmr:a78xZ4FCzyDMx2B6pbc-Y614Tx5A1hZBSqjx4hdH9lFLYg4q-Ab7IrLNi1Xkf9T0fb5WbfQKAB9HVZyV7TM8ERyV8By3eDw40gJ8LpDdOXeHK3PJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:a78xZxSjzp_ucIn6AIPkUIoz1KfNfudpn98DZbqyS7rz0h7r7ifylQ>
    <xmx:a78xZ9wrM5zSMnV8Aj9RL4IRt14Reax2y8r3fU7Og4ApbrgxxJVukQ>
    <xmx:a78xZ_7w5zIaYl4VI34a7mrJsO0lqrHIQuKmXCbc5YofdtTzEKIaGA>
    <xmx:a78xZ6xhC_BmpC4fcDQ0qVaDzAmD1cYQEZSvpcEmzR2UnaJxbUa29g>
    <xmx:a78xZ_v57km5lYiIVwEja5yTdOr1eZI3vNOTBZJTKn3iwxP4jn5nna0t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 03:25:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9661bbcb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 08:24:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 09:25:00 +0100
Subject: [PATCH v2 4/4] Makefile: let clar header targets depend on their
 scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-pks-clar-build-improvements-v2-4-d4794d8d1b30@pks.im>
References: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>
In-Reply-To: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>
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
2.47.0.229.g8f8d6eee53.dirty

