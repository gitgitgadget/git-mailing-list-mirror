Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C4719DF7A
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906358; cv=none; b=Mi82YSdszeV3Surk3+m2m9pH8LwvdODoX0UU/10V0lpNjN5qNJuHChpAIW8IvBYtkqh15eb+gFjaED8rnpR6+x8oYGnznYV5SBX5/dHyCXrlOYcuQNy/Wf+JNatbhY+ettlzynuRvouRIGyTX5FGKk8DzAh98OHydFK+jMzYMmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906358; c=relaxed/simple;
	bh=CL6IOcxfVYtyCDooin498hgPfxp7iktprE4ymNnGjO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmbEEcigrS6LKaK0UjckQnqe9QPzQx97sYe9VVuXKq7Whd4yWJe50oIVbKaEJw/cg8GJoo2pbG3SHrgJ3ZtIbj0fL3Hr0EmvG3188/+mtzU++CgHPBckZSmh5q3ivpN9RD21MfYMOiNYqgHFYDWCtPLJgdNDwoGFUp2yYVpzhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NzK4DFyB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fKuqe6jw; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NzK4DFyB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fKuqe6jw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F377A11401CB;
	Mon, 14 Oct 2024 07:45:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 14 Oct 2024 07:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728906355;
	 x=1728992755; bh=TIbJbBkzcLdsR/bWBQzoJqEgdhIIFau8/uvysnZonRw=; b=
	NzK4DFyBg7MtAfc8Jo+BtA28ZPxxB9GEgObopyBX62/IlV0TY//CrLyVlpQin62q
	6iSA3W1t1qd3yWOvl/CSjMY7fwt3XSIXcbc6V/SRWbcvqxvrG8GXSKchAV2DcbdW
	/7eK3vPl2sQHc0I4LGQfog9ZhvRNd73NsijgL7x0eImOg4mbTRxGIxyGxj45JFwd
	iFMfdNiQ2v6Zq7qpuCJKamXX/p1+LO6QCLbPYI0lphTQyMIg0onGiIk6SDXWsgbx
	NW0goxSQqmSCzGkgBHbNYkqtrLbZfH7O1WkoSd5H2bgDlc7QPBe4L0QlJ1cnbZQR
	FQX6y7YtT8RdPFmE8YfqGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728906355; x=
	1728992755; bh=TIbJbBkzcLdsR/bWBQzoJqEgdhIIFau8/uvysnZonRw=; b=f
	Kuqe6jwZCvrwixDPQt3joFjP4myHQgMqrauhzvyy9u++bVDGoe6TISvMXEJyCp0n
	qvdVWxct8Y5ClK23kJNrksZ7xYnUqOHtbPGhsTwoqKz+96+9q5kYt5WGg4bq8wt/
	8fpWv/Pfb+nkx3Aqv9+hKSEmEnNDjWNKxSueePDXRavw6VOwmr+LWKhD+NPOYOcU
	xfItzTcmfb9YqCKuf3B89Va0cITBDPbE4QpD7rwmGMLUonYSjwrDuhMKawIAXYsf
	XFNpueBYgZq0ciFSSnA2mj7J6dgwTLQuZ0UsyIE1f9oBuqCroYgk+8cAJO+Xh+ca
	KUKzY3daAu3vonX92RSIQ==
X-ME-Sender: <xms:cwQNZ3Fp4SnzAQ09W0QIuiEyj62-Ti0XdpGTTcBYFlBZ9JCAgzFzfw>
    <xme:cwQNZ0WH19NG-Hyc0XiWcczmPew_cp_ClIAAofTnXbQ1KXIiQTWZJJ9QvZXXsetiR
    _fXY6iBL42KNPF3lw>
X-ME-Received: <xmr:cwQNZ5LuSFf6ukNx4CDcd6urOTLrs0Tfd8Qr11TH69EkT6jramnK8lmARfqAdxdxPWnFqtaWCfk2MQEiIzZtE5f4D5yW7xQEZDq--JRixuQTyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghsvgguvghnohesmhhithdrvgguuh
X-ME-Proxy: <xmx:cwQNZ1Es4H-2ZQl1f8XPN7kIhbVSXWCIDXxuzj1iU_zznlE4IbV90g>
    <xmx:cwQNZ9VoMy_7BYa7qCuyHjR4ZM-6wNt7ShuGKwDt6krQEwVD5GsXyg>
    <xmx:cwQNZwOdVSQHHF2bhjzknG3HaJTMlmgxRCIqaTwtyZtJNcheXyaz7g>
    <xmx:cwQNZ80d5i46Zexv93BlJP-KbsC4xshLtQENMFTUtxTyYZqSczD4hg>
    <xmx:cwQNZ6jbUDJvPDtDmSOo10jSUoLhSBF_qXyYxdmJDeQbnLtn6pHD7FA7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 07:45:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id faba5bc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 11:44:41 +0000 (UTC)
Date: Mon, 14 Oct 2024 13:45:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Subject: [PATCH 2/2] Makefile: adjust sed command for generating
 "clar-decls.h"
Message-ID: <dda9b8e033c2e32e17dff73cad43211dd355d3ec.1728903464.git.ps@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1728903464.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1728903464.git.ps@pks.im>

From: Alejandro R. Sedeño <asedeno@mit.edu>

This moves the end-of-line marker out of the captured group, matching
the start-of-line marker and for some reason fixing generation of
"clar-decls.h" on some older, more esoteric platforms.

Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index feeed6f9321..0101d349f38 100644
--- a/Makefile
+++ b/Makefile
@@ -3905,7 +3905,7 @@ GIT-TEST-SUITES: FORCE
 
 $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES)) GIT-TEST-SUITES
 	$(QUIET_GEN)for suite in $(CLAR_TEST_SUITES); do \
-		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$$\)/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
+		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)\)$$/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
 	done >$@
 $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
 	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
-- 
2.47.0.dirty

