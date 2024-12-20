Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4072210F9
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 19:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723890; cv=none; b=VBpmmGacbbkF3PKZxl+ngeVtKWRQ64vSNpKUPJPKD5NdCb2Cr7Y4c9UwOW7bQO4XLTqO2BNDz5wzwQaPgpTvbvUU4ezyuGyHKQSIiFGCVMcBGsBrztSWUB488ijfIuTzVR9cLYk3ZF12GoflerP8UfxRQlgnlruGv3Rd+WWQDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723890; c=relaxed/simple;
	bh=Qt4K0VUeeyaOODSM6n4ifONuJR1IX4ti7oAChoRXGk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vxqr7apqyC8u5mMImyM3HsoodShgH4EO9EAhzRvsVAUp9VpWIu3EvYuswUAiaxmC7ueP9iYKZwtxURHZal54ZP/6CxBgnk4Wkfijc/kU9dOTorIda70hZgtFTMKvZmy7m85L2xnFVz/Bu6iWY9cp9MYRMZGfM9oQOE2/K40TmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yfnMxm35; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L0AEQg/M; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yfnMxm35";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L0AEQg/M"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E62025401F1;
	Fri, 20 Dec 2024 14:44:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 20 Dec 2024 14:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734723887;
	 x=1734810287; bh=Uc66z8wWX4Y+6Ht83qyKskS1gIvPZQi4go7hBf6Ahzk=; b=
	yfnMxm35XMP01fHGlVTe5MPgsP5OApXJg/3lJQ8l/APE3dgj/W5ZBWvYkwI9fEIS
	zNX4GNPA/WZXhZ1KZwDXvKD8tKIM88mVHj+nuGEZ/ZFs+kF2Yz++7WJhMNcTkBJj
	wLt2tMgn7SXhHMHaXbGrlLQf0o2jvV+5mat3F4srwejFuQyAbE/KMrh2ntxF8Dvp
	t7ZZHJFVF/UyjglUrsPRPA8ebwZpEphuKH8AnDS13Z+RHq6Rf8qfMiaR8vGKCtve
	+AMnHIJ9bPsqOxgwibQfCsh4jG/nD7zoAK9M7qyHxtbW+GOE6Jj/JUk+PkFLb38R
	Sv2yJO3TF+Bsxk1A37UaCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734723887; x=
	1734810287; bh=Uc66z8wWX4Y+6Ht83qyKskS1gIvPZQi4go7hBf6Ahzk=; b=L
	0AEQg/MN57Dl30eF9Z5J2nWC4YI81BxwwW5i9cDnD3Mxjrsu52fONqy/jhY1dmLK
	oJPYHrgrg45o7TXNfOtCOXt2Cj478HiZZuawT2JcgCrK7HIU1WPjLSHjSeedphgQ
	tzJCUcI6LB6SyoFpS/xwBeLBPR61p1A+OnocdedOLbZHYvQYdYK8ZpGc7NlCga71
	QD56rElb/oTVpjtPuNStPPukr/IK3MWpE0xerWquLU/9R+CiEjC+NLDkj4VuUr9d
	redExqgO2vrQ7k9abvtOE+ng66Udn8jyZrx42ljQ5sY2vq0VIhcJCoRlANdHF/r9
	UmcROdmAivVXCpuS0Swag==
X-ME-Sender: <xms:L8llZx3I2StcvklRRxE7ZnAX9AGkvHPyoLTq6knC6KtxvFK6vwLlng>
    <xme:L8llZ4FeNj4Z8VAqbO0kJPpHzBPwg5k6VNC60XtKuUzeOraHmH3DycWUxpXuMrkFq
    392R-ne3qRqPUhFrw>
X-ME-Received: <xmr:L8llZx57WkonZUVaOgF0Uw3wYOiJ7SXvqSGX4DKMRdzPy_MLWdHl2toZMMMaNvPgcp-M4A3B4aSTarhNZEeZCSlxGzGeoeocx6ShxC4dAjOXLRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejhffgte
    etvedtgfevkeekleeftefgleetjeekkedvvdfgudefhfeklefghfffteenucffohhmrghi
    nheprhgsrdhinhdptghonhhfrdhinhdprhgtrdhinhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:L8llZ-3LrrvQCPAJuteROk1MsE9GqjvJcil2Z5VThhrZNdB0wn_l_A>
    <xmx:L8llZ0GGY7W4C58nqdiPWQDY2z1PAkteG46CWBJeLf5XwhEOasKX8w>
    <xmx:L8llZ_8r0UgTxttJRDHNichBUYzsgWxxnRNEfGuu7xt4i6b25hUCcw>
    <xmx:L8llZxlnSBLR8UvhpEkmqPrFxgxEdwH1vIdCyRzpkjDqFbhe2GpwUQ>
    <xmx:L8llZwhg7BX6ZMfg-eaGZAW0-tc0LDOOIpexA-684turfKWyWdrbTpKc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 14:44:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 64daf08d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 19:42:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Dec 2024 20:44:22 +0100
Subject: [PATCH v3 2/6] Makefile: drop unneeded indirection for
 GIT-VERSION-GEN outputs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-b4-pks-git-version-via-environment-v3-2-1fd79b52a5fb@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
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
index 44c9e9369a11a6a5091079b7221a085b2f08e6cd..1a398d0dc359671d461fceb7a1636268a51411da 100644
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

