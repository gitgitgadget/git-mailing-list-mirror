Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E571CBA1F
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017068; cv=none; b=X9HTthy0WuZxo869yrQzH9Y0dPWO6/bDz7dwKDuzrUb4P332zjPvOQbi6h0XqYdDFF6g0f2/nYmPkFYaA4ECP9BiK4pkflRW6Js7fHLi/8GPRLiy/z+oeIKbkk3Xy05N/69UueaInGADQCRfIV7lQA6g3Hoo1mj2/s9D/q8HZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017068; c=relaxed/simple;
	bh=yqlfq/h6bsAWpDXH3+hX4m+m6Q2bx9lysCOdaYoFHhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dI62MZsMWWlSjCRlSpgItdD+BBek0W1Z2SME790aG8BL0MDnzJA6xKffWk9jCNPoa/YooE5ksNVCfn+24gUFc4RTXOPRconhekMSeV1yMUQnXYofOkhUCcvVkI3Avh9YS38TWnHRG2z/ROjqqoZV2DtMqYA5reYP2Y8j0/x48v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TPQubvZ5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HoUqyqJf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TPQubvZ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HoUqyqJf"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 10A9913805D1;
	Tue, 19 Nov 2024 06:51:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 19 Nov 2024 06:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017063;
	 x=1732103463; bh=uN0l/Si9yrZwS1RI8Oc3YBbT+HUghLJwq6pF0XoUSfM=; b=
	TPQubvZ5issc+oJFju2VxW8nn/pi9K9neh5yw0dSJl4W/DByoXaP+o4ovnntQdKc
	Wb3q1Ir01xu00iLyiJosw1jxi/1qy62eaBz3Fb7VnQTIJs8VOsfVHuQJ+Hq9od8v
	e8/1cUGkYR/Nm2DE4dVwOz4GmuttiQQq5xCEmJQcd3kaUDj23hmgeinvHrOg8L1v
	Z1XpnwbM3TEyOMSuMnPlLOawxmeQRDZcZKwnQOBwVKsXPfXivR12ryjXr9U5T1Ro
	UuGBLrmrco7E2IgE0DUx1wQrHL8g9jlxNfNse+PkLVxmU4uvvVAq8qsfz5uPEOfN
	f8mIGKYFXRQu66T2EwXNlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017063; x=
	1732103463; bh=uN0l/Si9yrZwS1RI8Oc3YBbT+HUghLJwq6pF0XoUSfM=; b=H
	oUqyqJfdjGu6YOOaFrd02nIopg4vXNlSd3erImxp+T5izFGt3jLRrwUnR/n9Ifku
	LSmPcZRD8a0WCKgOctiiTmUhI2FpiLJd0nFnCM6zcNs7lNxoI2fc9XuXkKorxfOZ
	pjgo2zeZMx/jKxhdF3KHGymkfScqwuC1G+sR+fBy6988mHXy8xLMfsJmaAQcVg3Q
	7vpmujFJwjitSiJNYKQMWtdA0spB5pyZR2NRVXMeLHnShG5uN8pcBqDTP7FL1w/e
	Y5fKbcX+Fb8QAoqhs2bbeaPf9blAEMc8CztTne2etjh15nqjR+1tUYqtUewukQ8T
	9aBPbYwJVCNVf5rnjiHTA==
X-ME-Sender: <xms:pns8Z-V_H09H0FbhUfOB68DHYPeMYdIgLyDDqPs9t750MTnUouGQyQ>
    <xme:pns8Z6lOY8LEcogM3jHpYQxVaJSHZnRosUe3PWIOPWfVyfWLRd-BJY3opUyS8B500
    A5jzy4oHg3o8sOufw>
X-ME-Received: <xmr:pns8ZyasIAamWCaDX4n0U4upCxKZfI6om3Tghye1V2hiosN0XpmHM7Hlh2uUgLvY6Bz84Il4qJs2CbOJi55WI9FP8gpawqU6XYZJE2nSU_QwKEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepfeefleeivdethefgudehueffheeiheehjedvheekleeg
    ffdtffevieeludeiteeknecuffhomhgrihhnpegtohhnfhdrihhnpdhrsgdrihhnnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    gurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtoh
    hordhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghhrhhish
    gtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhm
X-ME-Proxy: <xmx:pns8Z1XcfuJ6_yjF9x68m2n0cXn5a2TyvS2ifUgF97ZV09Bc20241w>
    <xmx:pns8Z4nyl3qjlimB3oBMDFlYnVnxecmq4Wg9nOoIg1iMlCilv_tFcQ>
    <xmx:pns8Z6f2y5tKPNFjae8JjuiEN8cjlOhX5m2eQpCKjfXKQ-mx3jMQjQ>
    <xmx:pns8Z6GgAzzsYNTls6EkxO32ceSRi3k8uv5jvZZV_rhETUCWQRYrCA>
    <xmx:p3s8Zxc59CajKO3WQA3gPdIl7aWCPYI9sxIkVLmLm1RRfBxfcdrQkAIG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:51:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8a9daa33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:50:43 +0100
Subject: [PATCH v8 06/23] Makefile: generate doc versions via
 GIT-VERSION-GEN
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-6-809bf7f042f3@pks.im>
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
In-Reply-To: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

The documentation we generate embeds information for the exact Git
version used as well as the date of the commit. This information is
injected by injecting attributes into the build process via command line
argument.

Refactor the logic so that we write the information into "asciidoc.conf"
and "asciidoctor-extensions.rb" via `GIT-VERSION-GEN` for AsciiDoc and
AsciiDoctor, respectively.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/.gitignore                               |  2 ++
 Documentation/Makefile                                 | 18 ++++++++++++------
 Documentation/{asciidoc.conf => asciidoc.conf.in}      |  3 +++
 ...ctor-extensions.rb => asciidoctor-extensions.rb.in} |  8 ++------
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index a48448de32f98b1a054b36e886ea920bccebc494..649df89474d357ccc91109b5c35fe2d0910f968a 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -15,3 +15,5 @@ tmp-doc-diff/
 GIT-ASCIIDOCFLAGS
 /.build/
 /GIT-EXCLUDED-PROGRAMS
+/asciidoc.conf
+/asciidoctor-extensions.rb
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0f55baa252fffbcd506f0c6f410b26b37f2e9b11..aac489d3b01e9ca08f24a7f604d4b8dae50860d6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,6 +1,8 @@
 # Import tree-wide shared Makefile behavior and libraries
 include ../shared.mak
 
+.PHONY: FORCE
+
 # Guard against environment variables
 MAN1_TXT =
 MAN5_TXT =
@@ -148,16 +150,12 @@ man5dir = $(mandir)/man5
 man7dir = $(mandir)/man7
 # DESTDIR =
 
-GIT_DATE := $(shell git show --quiet --pretty='%as')
-
 ASCIIDOC = asciidoc
 ASCIIDOC_EXTRA =
 ASCIIDOC_HTML = xhtml11
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_CONF = -f asciidoc.conf
-ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
-		-amanmanual='Git Manual' -amansource='Git $(GIT_VERSION)' \
-		-arevdate='$(GIT_DATE)'
+ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF)
 ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
@@ -210,6 +208,14 @@ ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
+
+asciidoctor-extensions.rb: asciidoctor-extensions.rb.in FORCE
+	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@+
+	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
+else
+asciidoc.conf: asciidoc.conf.in FORCE
+	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@+
+	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
 endif
 
 ASCIIDOC_DEPS += docinfo.html
@@ -364,7 +370,7 @@ manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 %.xml : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
 
-user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+user-manual.xml: user-manual.txt user-manual.conf $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d book -o $@ $<
 
 technical/api-index.txt: technical/api-index-skel.txt \
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf.in
similarity index 97%
rename from Documentation/asciidoc.conf
rename to Documentation/asciidoc.conf.in
index f6da6d1fbd2b208b072c1158dfcfb29c6c01f93a..dbe36a52eabfabef59e31d3be6518549e4f90206 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf.in
@@ -21,6 +21,9 @@ tilde=&#126;
 apostrophe=&#39;
 backtick=&#96;
 litdd=&#45;&#45;
+manmanual='Git Manual'
+mansource='Git @GIT_VERSION@'
+revdate='@GIT_DATE@'
 
 ifdef::backend-docbook[]
 [linkgit-inlinemacro]
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb.in
similarity index 92%
rename from Documentation/asciidoctor-extensions.rb
rename to Documentation/asciidoctor-extensions.rb.in
index cb24480b63d2ecc5c4ef267f4c501da53fc5b5be..c4c200dace85cf0a89dbc0f54ef25e4d1b6fec4d 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb.in
@@ -29,13 +29,9 @@ module Git
     class DocumentPostProcessor < Asciidoctor::Extensions::Postprocessor
       def process document, output
         if document.basebackend? 'docbook'
-          mansource = document.attributes['mansource']
-          manversion = document.attributes['manversion']
-          manmanual = document.attributes['manmanual']
           new_tags = "" \
-            "<refmiscinfo class=\"source\">#{mansource}</refmiscinfo>\n" \
-            "<refmiscinfo class=\"version\">#{manversion}</refmiscinfo>\n" \
-            "<refmiscinfo class=\"manual\">#{manmanual}</refmiscinfo>\n"
+            "<refmiscinfo class=\"source\">@GIT_VERSION@</refmiscinfo>\n" \
+            "<refmiscinfo class=\"manual\">Git Manual</refmiscinfo>\n"
           output = output.sub(/<\/refmeta>/, new_tags + "</refmeta>")
         end
         output

-- 
2.47.0.274.g962d0b743d.dirty

