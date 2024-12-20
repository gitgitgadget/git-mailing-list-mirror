Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC730221451
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723891; cv=none; b=cswdI04ihakzFJI8luADK0m6wPjnypHWa15tpZ1Z7VOd2VHUnJ0F8CC/2c1vPxxxAiGcwHkFpnpGM/rj7vGIZxm5jYJR0rqbmEmmQkRbB2CKOcNsy0MSYQal+4vFqldGESrpnSu45uzTHpb8vu06jjWKMWLa3o6d5K/mCNl9qUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723891; c=relaxed/simple;
	bh=khWASZt9OzT9zOo/+Gkb1YNdn2fhbRkdguSUILvGqFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ivtO3r/G/dxjdqcBSowlflV8xyXEfotpfeLe1ZUOWtEOB6noDcK+jTMZwHsnrqwCE6iMbcgsRIx/VZdbcwCx1OsY7jhJXAL8cKafqYV7SMoSiAQp5RBfT6MWJlbLilvHnDGwtQVOR1bCzt+MBloYwk2aigxOvyNz52+1E/i7ebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U2hbd4nG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tydPGWrG; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U2hbd4nG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tydPGWrG"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CBF9525401F4;
	Fri, 20 Dec 2024 14:44:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 20 Dec 2024 14:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734723888;
	 x=1734810288; bh=cOFY9nXY85SJb9rdYs0wBD+2W+TlhaVUbONDAE/zzyI=; b=
	U2hbd4nGzTNzRzyH18iwDNGKpxRB0/mmQtsRGznEWMgb1ifNa6ZBBbFwWJNsby0M
	VQj/ydosrbo5ADswxD2ojTU6wyam2r0rbPczk3ZCfWwBpuXPmnOenCauk59r7vMq
	mQ0Z4xufzCIIAEvjCp26eOkJSjgR01MPDYeJ+n5AqClY+RWrRZlbLawYuczCczJX
	QIuYDxCfcHKxZrsFAt2qpXqCvz+qSMxXrvbYateM/tMh7he3oGgp3pQNjtfkqKNx
	h4T3FuGalc0NSH3oDAyGbgOrg5iV5pxEOwMJUDEdTD6dkd2ExHGUWShY5eVR45OS
	nG8ddlhhSFXFr6//YN0U0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734723888; x=
	1734810288; bh=cOFY9nXY85SJb9rdYs0wBD+2W+TlhaVUbONDAE/zzyI=; b=t
	ydPGWrGbJxWCGuVZ3qOydCcz4QFb6fIOKGwFLl+fJXG6u7X8d0JI13WjGKJCLa5E
	5j0C10NQK7fJCIFWHMlOiTR0ZapK7ONA13sM7IS5zBBodGx639KX3mbojxYEZwgf
	/HwCQ/HRB19wr8IQrAWDk41JxtASS9wDlhWeBNBNjG2CpYUJHnbwfXMQf2rNbLU6
	WoTI0XFXsHkxwtwV8Jesij08rCrMNGDGikxSrTtZySYiOcZ49FYHJPFSp5dzl0C/
	Dcg7bsB5JE2VQ0wFlkgMnsLveB5Upz8rDV1qQrz52dD/VlOmyvlO/Hdmx55A9muK
	DlMS7rjN+t7Ro0utfmURQ==
X-ME-Sender: <xms:MMllZ5okMo9vJaPp_-kj-VV3z14y9XZxvxiQbfA_NLbBPMt85Pk6fw>
    <xme:MMllZ7oNKpe1vCCBWGS6BuU-p983qR_ei9Ia5iXl9myBI5lahY1gZGtn0s2uvoUeb
    qZQdHhxqKXFkX7-xw>
X-ME-Received: <xmr:MMllZ2NMFRBiNWqnRCFFyhHSazqLTQsjQoG9XdStPtIBPvlBasScR5hZFMdDuKDSqboe4f7baokp8s_oa77yJVMXaAunMGTHnrzXkvi1ZdYJZn4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejhffgte
    etvedtgfevkeekleeftefgleetjeekkedvvdfgudefhfeklefghfffteenucffohhmrghi
    nheprhgsrdhinhdptghonhhfrdhinhdprhgtrdhinhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsphgvtghtrhgrlhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:MMllZ07k2YUdwK0DUYFTDjdc3rLEiiWYkGGZXGdDTHgC9V6o3m0-VA>
    <xmx:MMllZ44NEBlW5BCEAIencHg604o6PCVyIauvcW32wHTrnyipmQaGSQ>
    <xmx:MMllZ8j10TtN7lUNyuZfeAkncZWCU4PQnQ2Bvm2TJd9ZOdFOCjfAwQ>
    <xmx:MMllZ67nNJKxvYtem6Uy1mMQM0x81LvB5ka5q7_cv0-1tqdUlTjwjQ>
    <xmx:MMllZz1-zpcv_hBPm9OJPQcQHpIs1DD6kzq-5LslEbi2_p1QkZL8IOyG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 14:44:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07a855e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 19:42:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Dec 2024 20:44:23 +0100
Subject: [PATCH v3 3/6] Makefile: introduce template for GIT-VERSION-GEN
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-b4-pks-git-version-via-environment-v3-3-1fd79b52a5fb@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Introduce a new template to call GIT-VERSION-GEN. This will allow us to
iterate on how exactly the script is called in subsequent commits
without having to adapt all call sites every time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile | 4 ++--
 Makefile               | 6 +++---
 shared.mak             | 8 ++++++++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 1a398d0dc359671d461fceb7a1636268a51411da..ff30ab6c4295525757f6a150ec4ff0c72487f440 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -211,10 +211,10 @@ XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
 
 asciidoctor-extensions.rb: asciidoctor-extensions.rb.in FORCE
-	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
+	$(QUIET_GEN)$(call version_gen,"$(shell pwd)/..",$<,$@)
 else
 asciidoc.conf: asciidoc.conf.in FORCE
-	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
+	$(QUIET_GEN)$(call version_gen,"$(shell pwd)/..",$<,$@)
 endif
 
 ASCIIDOC_DEPS += docinfo.html
diff --git a/Makefile b/Makefile
index 695a9d9765daf864605002d572129bae7a8c4e40..9cfe3d0aa968eff10379d22edff6cc6f4518c2ff 100644
--- a/Makefile
+++ b/Makefile
@@ -593,7 +593,7 @@ include shared.mak
 
 GIT-VERSION-FILE: FORCE
 	@OLD=$$(cat $@ 2>/dev/null || :) && \
-	$(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" GIT-VERSION-FILE.in $@ && \
+	$(call version_gen,"$(shell pwd)",GIT-VERSION-FILE.in,$@) && \
 	NEW=$$(cat $@ 2>/dev/null || :) && \
 	if test "$$OLD" != "$$NEW"; then echo "$$NEW" >&2; fi
 -include GIT-VERSION-FILE
@@ -2512,7 +2512,7 @@ pager.sp pager.s pager.o: EXTRA_CPPFLAGS = \
 	-DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
 
 version-def.h: version-def.h.in GIT-VERSION-GEN GIT-VERSION-FILE GIT-USER-AGENT
-	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@
+	$(QUIET_GEN)$(call version_gen,"$(shell pwd)",$<,$@)
 
 version.sp version.s version.o: version-def.h
 
@@ -2553,7 +2553,7 @@ $(SCRIPT_SH_GEN) $(SCRIPT_LIB) : % : %.sh generate-script.sh GIT-BUILD-OPTIONS G
 	mv $@+ $@
 
 git.rc: git.rc.in GIT-VERSION-GEN GIT-VERSION-FILE
-	$(QUIET_GEN)$(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@
+	$(QUIET_GEN)$(call version_gen,"$(shell pwd)",$<,$@)
 
 git.res: git.rc GIT-PREFIX
 	$(QUIET_RC)$(RC) -i $< -o $@
diff --git a/shared.mak b/shared.mak
index 29bebd30d8acbce9f50661cef48ecdbae1e41f5a..b23c5505c9692b032cd0b18d3e4ede288614d937 100644
--- a/shared.mak
+++ b/shared.mak
@@ -116,3 +116,11 @@ endef
 define libpath_template
 -L$(1) $(if $(filter-out -L,$(CC_LD_DYNPATH)),$(CC_LD_DYNPATH)$(1))
 endef
+
+# Populate build information into a file via GIT-VERSION-GEN. Requires the
+# absolute path to the root source directory as well as input and output files
+# as arguments, in that order.
+define version_gen
+GIT_USER_AGENT="$(GIT_USER_AGENT)" \
+$(SHELL_PATH) "$(1)/GIT-VERSION-GEN" "$(1)" "$(2)" "$(3)"
+endef

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

