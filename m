Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AAF1C4612
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697393; cv=none; b=jPhrGhCF4xam9ImqiA0jU6OCUOQJWtMEQmAJlZMRmu1k8e+hzU7nQm4I+81hgLq06+7zrX0uJeyrcdBNd/VShdsPRY5qun3lD/EQEy/xQc+DwiKwHzCMWL23XgykJRfdqCCRGEa0Y9BHFhVzjg2aZ3w29pdfXnGua+V1kkDmlQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697393; c=relaxed/simple;
	bh=ic7+mXkqhVsJtimnn8bOCl684AgLWvhlgZyUXQ9BuRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zbp71t8WaUotb2L3PRgrTyUZTDhmviBshgXSioAiCXQvmpdHviVcMpWUoi1L/8JmNDBnR6nL5LKrpJOflnEnDRKTJCxyrRr6S4/6HxG50bz8NzyxxQFTuGk+BRDRDvigvMIIwyO5r9lxIIBFNKTjiBzKfUlCWQE3NxdvoV3cNQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=0WQc2YWR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCqgqoez; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0WQc2YWR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCqgqoez"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69121114006F;
	Fri, 20 Dec 2024 07:23:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 20 Dec 2024 07:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734697390;
	 x=1734783790; bh=LA3qmVc4cwd1EBDe7rRX9RyD63W5mqVP93pHUW4776Y=; b=
	0WQc2YWRlYIy/IJ++ozuFWQstxpywFTywHHYslRcFrINFrSCMGS95OkknZGFE3hJ
	BfQdQlg64peCXPT2MLURKaMjxF+7CajEFMZHnbwZO/W5JG7t7oIEtF0HYNr8vih1
	L8G5YAm7uZDF1D4s5VfdnbuG1auP14kuakA2xUYCPA6DCNkHGUCB3erMSuYJAmhJ
	GpQjJ74utYanFL8v8/lSj6lVcyFA1XTSCJOr1KdaZG6gjzEGzXXOJHvspv9o3Uuy
	x0/mSlN+9JtFP4oiLPbGCrI6GEdYXmNUfxYFiMkL5cdz030q2qp00+qFEkNRnNdp
	RvmsrnEiG8B7oNVzlh61pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734697390; x=
	1734783790; bh=LA3qmVc4cwd1EBDe7rRX9RyD63W5mqVP93pHUW4776Y=; b=D
	Cqgqoez4vewRmQgeqmtBEJi0P492lYlt5h4NLoG2i0UNgKMC9taXq9e7N73GwvFx
	qGidQae5fIU60XGacCPVOzWquDVzvSV+E3hgtPWWrfx8AaRn9RkfBnb77msBIoI+
	ORw+rQylqhHdxIbuD9/LxDzTuZOqrK00kzRGkITCfcHG5bbgQZB1g2LrHZeAXzvb
	3e/IYEsenrgBKqPo4yGSwyNAMvtMIbFPfdnhpk9eN2k82SFkAVBtDldm1Dt1Bf26
	POSYV+0ngvSEcJ2AaKU8wkT00Y+J/CLSTGZi/ZBQJnvtgFTi8UpjPVWdbdIQ11HN
	DQB/WvRZtPSurhDsfmLvw==
X-ME-Sender: <xms:rmFlZz9ySCJia-rkyF1dmR96Nn05eQ0AYNxbXny833lXIgfrahQ7cg>
    <xme:rmFlZ_tah-u-nDb6-7jMWptNU92vwVK4mQcHgxhZJz08YVL1YemUUw4NNuvBDJbZ_
    0HghNpIO1a47g4Z3A>
X-ME-Received: <xmr:rmFlZxCXI2Uhg-prmsah8iEqCA7t57ZG-h8dplBiTCjD0WPd88cXq3kpPxONXH4GlnRj-S11KTr5P64IMeLLRDesdiY0ZQcegN2-kF9MacotSRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjefhgfette
    evtdfgveekkeelfeetgfelteejkeekvddvgfdufefhkeelgffhffetnecuffhomhgrihhn
    pehrsgdrihhnpdgtohhnfhdrihhnpdhrtgdrihhnnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rmFlZ_cdg3HZMyOBiI0pYLtpYsN62ZVhL_iFo87vymXsterH6ThWsQ>
    <xmx:rmFlZ4Nwty86G85SPsGgoltl1D4QvFQQtW1Qgl6Q5tq-F6gELktbKg>
    <xmx:rmFlZxk22_Pf7X2akSDXXK7dOnwdgUpa6ab4cmp81T9AMbwicPOR9w>
    <xmx:rmFlZysQmsaMXAoiik9zc64zNzLkBaWlBMETMH3807AFScNoJGbBkA>
    <xmx:rmFlZ1pZD6oi-jJMXe-kLAJViTdMTciOxLqLmniFk8SDZ8R-leFJDkLZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 07:23:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e823b8e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 12:21:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Dec 2024 13:22:47 +0100
Subject: [PATCH v2 3/5] Makefile: drop unneeded indirection for
 GIT-VERSION-GEN outputs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-b4-pks-git-version-via-environment-v2-3-f1457a5e8c38@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Some of the callsites of GIT-VERSION-GEN generate the target file with a
"+" suffix first and then move the file into place when the new contents
are different compared to the old contents. This allows us to avoid a
needless rebuild by not updating timestamps of the target file when its
contents will remain unchanged anyway.

In fact though, this exact logic is already handled in GIT-VERSION-GEN,
so doing this manually is pointless. This is a leftover from an earlier
version of 4838deab65 (Makefile: refactor GIT-VERSION-GEN to be
reusable, 2024-12-06), where the script didn't handle that logic for us.

Drop the needless indirection.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile | 6 ++----
 Makefile               | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3392e1ce7ebc540784912476847380d9c1775ac8..cee88dbda66265141b87d5e5c16bf86df22fa4ef 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -211,12 +211,10 @@ XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
 
 asciidoctor-extensions.rb: asciidoctor-extensions.rb.in FORCE
-	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@+
-	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
 else
 asciidoc.conf: asciidoc.conf.in FORCE
-	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@+
-	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
 endif
 
 ASCIIDOC_DEPS += docinfo.html
diff --git a/Makefile b/Makefile
index 79739a13d2132204f56b1ef4ca879bd51c5164b4..695a9d9765daf864605002d572129bae7a8c4e40 100644
--- a/Makefile
+++ b/Makefile
@@ -2512,8 +2512,7 @@ pager.sp pager.s pager.o: EXTRA_CPPFLAGS = \
 	-DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
 
 version-def.h: version-def.h.in GIT-VERSION-GEN GIT-VERSION-FILE GIT-USER-AGENT
-	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@+
-	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@
 
 version.sp version.s version.o: version-def.h
 
@@ -2554,8 +2553,7 @@ $(SCRIPT_SH_GEN) $(SCRIPT_LIB) : % : %.sh generate-script.sh GIT-BUILD-OPTIONS G
 	mv $@+ $@
 
 git.rc: git.rc.in GIT-VERSION-GEN GIT-VERSION-FILE
-	$(QUIET_GEN)$(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@+
-	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+	$(QUIET_GEN)$(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@
 
 git.res: git.rc GIT-PREFIX
 	$(QUIET_RC)$(RC) -i $< -o $@

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

