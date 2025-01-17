Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AC01FAC4A
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107782; cv=none; b=mlcnGJGyHCx0P+DnWzqt8o03So5rm5cmtQOMqYNXaJlmATjsYUBO2XNCpgRkFw/ylrdscSr1ZDu9lM52GFRVPF6zuq9tkQml/1Qo/074EReyWl1zqAcYkA+DgnJAQwcrNt03Hq+PQGFTBds2+eiV/XroNETl3vui96ukCHVUDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107782; c=relaxed/simple;
	bh=+kubdm+exVz6WeR7lOGEsUtWWbWLxBAG9ZSceja3SZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qUGEge4LJWCWa2jRsm9No7bX/PonwT86/ojKeLtxk1HHzPqgbFgeYv/aqZKy3gElH9f9Iw1dmZpCWCpaGRzugN24J2yeJdT3N2kpTvdFvlfqUM4lLkf8iC5+EpMPWS0oEMdNtkgFwQXkYPnVJ9r9jEKL0qVYgDE9+hTl5AENnxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=liH5zyJQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iYsf6UI1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="liH5zyJQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iYsf6UI1"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BF31B138085B;
	Fri, 17 Jan 2025 04:56:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 17 Jan 2025 04:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737107779;
	 x=1737194179; bh=cyKAl+9ImX3z0KnMVrS2buBpXmpxKuMim36YEZEEFeg=; b=
	liH5zyJQN8/k+XD00skKriOG+cHes+XdlyUpRwbVGGMvhDxKJckA+3vmy31y+nA/
	aNcdaJISb2dfVMSDW6sMbLDavFKdKVCh0amHXjxK68tTvxYBFY7x3iIRj/BxKB0W
	z1f0sFZKWjokyIeidY4v8Ld+uq7X7MzhBkJ4gc9U+F0DdNfwxquNHEgxVtXatGZM
	5SITRZYaAkeJIlnQhMEtXJ/7RGG43oCDGRB5M1J+DfvuaZ/Zwq4N269ZLgBWm1W7
	hgnkWoHC9vLQpPcF21JHsffx57BwhNMLcuoxD6MQMO7ZPgvXUVXaHiGHDNkSdORd
	QhemGvHw/zuAlIQ66aaxNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737107779; x=
	1737194179; bh=cyKAl+9ImX3z0KnMVrS2buBpXmpxKuMim36YEZEEFeg=; b=i
	Ysf6UI1RrbxH1J5VUITwvA2G6EMVmJkWWwmootWkrWMxfFb4pxTu35hQW3RqpPhg
	AcFpIOG8StJcScDXKaiyRpRp+kodTk7e5bghiauMlkLQmYypuEYDfVHD8i9KfQk0
	mFAo5MZ5U37eH8hSPb63GVUy2CkdypZKXO79JHpWadviPSg0bNT7jSecEFQ5Nkc+
	HqWXsmKoftNuUA+L/szzMJe7NfePQgtB1D1iXC5OKx7wMCgEWLNFLXzwGga+j8Sv
	3jony7kVHSFWA1SQglAFvL4Bmf2p71vkUQ669IkecozzSmTGboNzziUEK2stzOYQ
	fk5VLLdiRKzkrMCBHsJjQ==
X-ME-Sender: <xms:QymKZ-DyOne6-IXXSLCLsCLjDcyJjF6HZMHm4PiAO0XZzqt3lRyRLg>
    <xme:QymKZ4jFxCgBIOAXrIT5X7_rKj_vT-ZCkzOERFwR-MhHGHjwttI3NInVASMYNGXRa
    1gRiOxtb4GbSTcvjA>
X-ME-Received: <xmr:QymKZxmjACYMh3eb7bKterNYe3noA8ap5_w5xLOuu3HQLmXhBro-repoUR1fh9zyaKMdle0CsBf-r2EYx9HoFGcXiDxOLhoKqHXj587D5u7t0nE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfeefleeivd
    ethefgudehueffheeiheehjedvheekleegffdtffevieeludeiteeknecuffhomhgrihhn
    pegtohhnfhdrihhnpdhrsgdrihhnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgesfhhrvggvsghsugdrohhrgh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QymKZ8xTvQ4bDE_PnVSYa14vmIzlLOB1UzG8wNFtF_ubGOqX7dbHCA>
    <xmx:QymKZzS6OcRCIqLdnpF-wldteNWd4IN2yWsZuPae47xBxJ8pfXZAaA>
    <xmx:QymKZ3actaoOoR1Y4uvz3VMAGJ1ueVDgHQpeJzBulEyJ1iefAVmZ5A>
    <xmx:QymKZ8QzS915SjFIZEnUlZsqVQ013RsPGtsc05WnrBQB6qIX8Os2Cg>
    <xmx:QymKZ-dZZhizjF0wc_DJQdpX6JKaq5x8xyHZqNXT-Z_X70jelcctdT22>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 04:56:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f89a48b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 09:56:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Jan 2025 10:56:05 +0100
Subject: [PATCH 1/3] contrib/subtree: fix building docs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-b4-pks-build-subtree-v1-1-03c2ed6cc42e@pks.im>
References: <20250117-b4-pks-build-subtree-v1-0-03c2ed6cc42e@pks.im>
In-Reply-To: <20250117-b4-pks-build-subtree-v1-0-03c2ed6cc42e@pks.im>
To: git@vger.kernel.org
Cc: Renato Botelho <garga@FreeBSD.org>
X-Mailer: b4 0.14.2

In a38edab7c8 (Makefile: generate doc versions via GIT-VERSION-GEN,
2024-12-06), we have refactored how we build our documentation by
injecting the Git version into the Asciidoc and AsciiDoctor config
files instead of doing so via arguments. As such, the original config
files were removed, where the expectation is that they get generated via
`GIT-VERSION-GEN` now.

Whie the git-subtree(1) command part of "contrib/" also builds docs
using these same config files, its Makefile wasn't adjusted accordingly
and thus building the docs is broken.

Fix this by using `GIT-VERSION-GEN` to generate those files.

Reported-by: Renato Botelho <garga@FreeBSD.org>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/subtree/.gitignore |  2 ++
 contrib/subtree/Makefile   | 23 +++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/contrib/subtree/.gitignore b/contrib/subtree/.gitignore
index 0b9381abca..6deaf177c7 100644
--- a/contrib/subtree/.gitignore
+++ b/contrib/subtree/.gitignore
@@ -1,4 +1,6 @@
 *~
+asciidoc.conf
+asciidoctor-extensions.rb
 git-subtree
 git-subtree.1
 git-subtree.html
diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 6fa7496bfd..8fe0bfd401 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -1,6 +1,7 @@
 # The default target of this Makefile is...
 all::
 
+-include ../../shared.mak
 -include ../../config.mak.autogen
 -include ../../config.mak
 
@@ -13,17 +14,16 @@ htmldir ?= $(prefix)/share/doc/git-doc
 ../../GIT-VERSION-FILE: FORCE
 	$(MAKE) -C ../../ GIT-VERSION-FILE
 
--include ../../GIT-VERSION-FILE
-
 # this should be set to a 'standard' bsd-type install program
 INSTALL  ?= install
 RM       ?= rm -f
 
 ASCIIDOC         = asciidoc
-ASCIIDOC_CONF    = -f ../../Documentation/asciidoc.conf
+ASCIIDOC_CONF    = -f asciidoc.conf
 ASCIIDOC_HTML    = xhtml11
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_EXTRA   =
+ASCIIDOC_DEPS    = asciidoc.conf
 XMLTO            = xmlto
 XMLTO_EXTRA      =
 
@@ -32,8 +32,9 @@ ASCIIDOC         = asciidoctor
 ASCIIDOC_CONF    =
 ASCIIDOC_HTML    = xhtml5
 ASCIIDOC_DOCBOOK = docbook
-ASCIIDOC_EXTRA  += -I../../Documentation -rasciidoctor-extensions
+ASCIIDOC_EXTRA  += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA  += -alitdd='&\#x2d;&\#x2d;'
+ASCIIDOC_DEPS    = asciidoctor-extensions.rb
 XMLTO_EXTRA     += --skip-validation
 endif
 
@@ -82,13 +83,13 @@ install-html: $(GIT_SUBTREE_HTML)
 $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $^
 
-$(GIT_SUBTREE_XML): $(GIT_SUBTREE_TXT)
+$(GIT_SUBTREE_XML): $(GIT_SUBTREE_TXT) $(ASCIIDOC_DEPS)
 	$(ASCIIDOC) -b $(ASCIIDOC_DOCBOOK) -d manpage $(ASCIIDOC_CONF) \
-		-agit_version=$(GIT_VERSION) $(ASCIIDOC_EXTRA) $^
+		$(ASCIIDOC_EXTRA) $<
 
-$(GIT_SUBTREE_HTML): $(GIT_SUBTREE_TXT)
+$(GIT_SUBTREE_HTML): $(GIT_SUBTREE_TXT) $(ASCIIDOC_DEPS)
 	$(ASCIIDOC) -b $(ASCIIDOC_HTML) -d manpage $(ASCIIDOC_CONF) \
-		-agit_version=$(GIT_VERSION) $(ASCIIDOC_EXTRA) $^
+		$(ASCIIDOC_EXTRA) $<
 
 $(GIT_SUBTREE_TEST): $(GIT_SUBTREE)
 	cp $< $@
@@ -98,6 +99,12 @@ test: $(GIT_SUBTREE_TEST)
 
 clean:
 	$(RM) $(GIT_SUBTREE)
+	$(RM) asciidoc.conf asciidoctor-extensions.rb
 	$(RM) *.xml *.html *.1
 
+asciidoc.conf: ../../Documentation/asciidoc.conf.in ../../GIT-VERSION-FILE
+	$(QUIET_GEN)$(call version_gen,"$(shell pwd)/../..",$<,$@)
+asciidoctor-extensions.rb: ../../Documentation/asciidoctor-extensions.rb.in ../../GIT-VERSION-FILE
+	$(QUIET_GEN)$(call version_gen,"$(shell pwd)/../..",$<,$@)
+
 .PHONY: FORCE

-- 
2.48.0.257.gd3603152ad.dirty

