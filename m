Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38DF4FA
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734687112; cv=none; b=iqsvq+ITWb6c/fmdilq/wz7Wwkr8RfoEU6XQgyTI0WcqZdNBb32+P48n3alfT/+fugtqaXw9UX9CjGBL4bapUeBTBF3A/P7rgjblyU8Kw0bd+I3azToF/2J+lIvpe8lULboIfMDgFmhbGqE1Q0QbC33yj2n78GbPe/3GLjz5P4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734687112; c=relaxed/simple;
	bh=UQKzc/QyTFi3lNpvxlz0dGZgbonG+t5VL4kZg5m1jT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPLK3wo9d9/6t/4SbYQYacKiBhgUFC+DC2BvZ8idMhcTkSQZMnkhffROVWQ2dfTpRlhTePci5oyDZTKdtrrug+s1F+KnnYp32h8PdbAAcli6owdxMv4SoKcBqSZE2i+oSldEv36vFZmwm+eqSs1osFCTuyN0WB5NjU1m3nkwciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PcsbYs88; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PCnFCVBd; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PcsbYs88";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PCnFCVBd"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id BD24013801A8;
	Fri, 20 Dec 2024 04:31:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 20 Dec 2024 04:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734687108; x=1734773508; bh=PL1/COUqJI
	9m+A3vmXP/LqFSf0Q9+2qQR+JivpPwhEo=; b=PcsbYs88IVCgxUO26M1iwWpC/9
	wJzeFAeesA07DyskzYxewdeq48MqXZj5rE/S55V3uQnjiAv3JFB3/xVhKHztiDoc
	jHYB336aDKjsS9mfKmd0JPkh2udOBa6+ttsnNFHMVJZ3aOC2MFpKXnr5g392fgMH
	Rf902hOsiPjndPGrwkJS5sFfAmxq38MI4b47n1kHLep6bA/Wa8BSkH6KktWUDVAl
	v49QfFNwsZzWlElHWAY4GNuzVaxGIrrScJMrEyokdnqPAJTk1s1wZRyb62BHcRHu
	236FsC+KIwy6TXtkqiDgLYphZFw0edqeVFECOGETQ66aEc7qpyqWWdm16UYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734687108; x=1734773508; bh=PL1/COUqJI9m+A3vmXP/LqFSf0Q9+2qQR+J
	ivpPwhEo=; b=PCnFCVBdb1OsL7qm1S+lDDu0g+/zWzkhN9VhbTxgECffJo3MIvM
	NxymhCgctPLSD1LnqoNLUzXhyfZYMHm9vvL7Y6edtfx/feoJzufNlzvQ09Ydo3+D
	ZORw62TdXg0eAs8vU0qlI+FhLTBg22JFoqt1dW0Olr96K5s+d0y07uXug8pDeySz
	TmllFlb1/KxM97PhWxJItUE2kSHmgRd9GIYrOlkEG9XfyLNWneaICPHJMkIFVtIe
	wdDfF1m9JHzIfLyzCRDg/Qsn731QBfikTlJd193OZmyy9IEcg/Ip0e/8M08+S/qG
	GdcIAQ3ykVM+WWjJ7pSd0ez2UJ65yncqOVA==
X-ME-Sender: <xms:hDllZ1FKhqQPzkLN93DclFBhJH1akBgKu5S7-a7zWcL9lXZUt0UunA>
    <xme:hDllZ6WGlLxz-DTlSGGqWsKZTqCRBk0uy_aM63jyAQAATFDiJzbDaIOpkbLJrEFR8
    wA5A9syl_vZkajyeQ>
X-ME-Received: <xmr:hDllZ3LqselIRg9htwx5WK3Z536ecpj7GoFEcA1-4gRI0WrobtidsxGytHrVuPI_qyw_NJPjLHYkOSxOF2NmtdF4q5fmg_sONJF8564y5LL5BGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeuveevleeuve
    eigefgkeejledthedvveeuudegtedvgfdvieefkedtueegkefgudenucffohhmrghinhep
    rhgsrdhinhdptghonhhfrdhinhdprhgtrdhinhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsphgvtghtrhgrlhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:hDllZ7GqXps779z0ij7FIXmxGlwc7EtZaAj_B4MnUa0kMRVP964m-g>
    <xmx:hDllZ7V3GUorgMmFLI772vuIZvgXXv8ReYl_UvQ0NUz5ZVKPGkUoCQ>
    <xmx:hDllZ2MyJ0CQxKzQCoJJGFCVjWuQCKGP7RVpLjoc16-nvUgDyCtvRg>
    <xmx:hDllZ6331kcFAmJLNabphyM6q_FjIQ78TxOqlWEdrmZx6ezg2zyWdQ>
    <xmx:hDllZxzvfFrMr6LeQlG7y6j9VlxUL5fwoQh8r2yeE32hamKzRozxqjTF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 04:31:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d1aaffef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 09:29:56 +0000 (UTC)
Date: Fri, 20 Dec 2024 10:31:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 1/2] GIT-VERSION-GEN: fix overriding version via
 environment
Message-ID: <Z2U5cslf10hs_-Az@pks.im>
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
 <20241219-b4-pks-git-version-via-environment-v1-1-9393af058240@pks.im>
 <20241220073437.GA2389154@coredump.intra.peff.net>
 <Z2UlpaDFjvl--zau@pks.im>
 <20241220085626.GB133148@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220085626.GB133148@coredump.intra.peff.net>

On Fri, Dec 20, 2024 at 03:56:26AM -0500, Jeff King wrote:
> On Fri, Dec 20, 2024 at 09:45:36AM +0100, Patrick Steinhardt wrote:
> 
> > >   version-def.h: version-def.h.in GIT-VERSION-GEN GIT-VERSION-FILE GIT-USER-AGENT
> > >           $(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@+
> > >           @if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
> > > 
> > > Should we do the same thing for GIT_VERSION? And GIT_DATE, etc? If we're
> > > going to do many of these, it might also be easier to just add "export
> > > GIT_VERSION", etc, in the Makefile.
> > 
> > I guess. It'll become quite painful to do this at every callsite, so
> > I'll add another commit on top to introduce a call template that does
> > all of this for us.
> 
> Is there any reason not to just do:
> 
>   export GIT_VERSION
>   export GIT_DATE
>   export GIT_BUILT_FROM_COMMIT
>   export GIT_USER_AGENT
> 
> in shared.mak? Then you only have to do it once, and no need for
> templates.

You could do that, yeah, but the user needs to be aware that they can.
I'm happy to not go down that path and live with the above solution.
Alternatively, this would be what the call template would look like.

Patrick

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3392e1ce7e..a7cb885b67 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -211,12 +211,10 @@ XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
 
 asciidoctor-extensions.rb: asciidoctor-extensions.rb.in FORCE
-	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@+
-	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+	$(QUIET_GEN)$(call version_gen,$(shell pwd)/..,$<,$@)
 else
 asciidoc.conf: asciidoc.conf.in FORCE
-	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@+
-	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+	$(QUIET_GEN)$(call version_gen,$(shell pwd)/..,$<,$@)
 endif
 
 ASCIIDOC_DEPS += docinfo.html
diff --git a/Makefile b/Makefile
index 79739a13d2..9cfe3d0aa9 100644
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
@@ -2512,8 +2512,7 @@ pager.sp pager.s pager.o: EXTRA_CPPFLAGS = \
 	-DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
 
 version-def.h: version-def.h.in GIT-VERSION-GEN GIT-VERSION-FILE GIT-USER-AGENT
-	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@+
-	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+	$(QUIET_GEN)$(call version_gen,"$(shell pwd)",$<,$@)
 
 version.sp version.s version.o: version-def.h
 
@@ -2554,8 +2553,7 @@ $(SCRIPT_SH_GEN) $(SCRIPT_LIB) : % : %.sh generate-script.sh GIT-BUILD-OPTIONS G
 	mv $@+ $@
 
 git.rc: git.rc.in GIT-VERSION-GEN GIT-VERSION-FILE
-	$(QUIET_GEN)$(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@+
-	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+	$(QUIET_GEN)$(call version_gen,"$(shell pwd)",$<,$@)
 
 git.res: git.rc GIT-PREFIX
 	$(QUIET_RC)$(RC) -i $< -o $@
diff --git a/shared.mak b/shared.mak
index 29bebd30d8..8e0a19691f 100644
--- a/shared.mak
+++ b/shared.mak
@@ -116,3 +116,14 @@ endef
 define libpath_template
 -L$(1) $(if $(filter-out -L,$(CC_LD_DYNPATH)),$(CC_LD_DYNPATH)$(1))
 endef
+
+# Populate build information into a file via GIT-VERSION-GEN. Requires the
+# absolute path to the root source directory as well as input and output files
+# as arguments, in that order.
+define version_gen
+GIT_BUILT_FROM_COMMIT="$(GIT_BUILT_FROM_COMMIT)" \
+GIT_DATE="$(GIT_DATE)" \
+GIT_USER_AGENT="$(GIT_USER_AGENT)" \
+GIT_VERSION="$(GIT_VERSION)" \
+$(SHELL_PATH) "$(1)/GIT-VERSION-GEN" "$(1)" "$(2)" "$(3)"
+endef
