Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73EE192D8B
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528641; cv=none; b=UIZ5ocYiOQLLbFa0Z45e3byjbROJs7cmA76HLV23kXJjmx13Q98IiOsm5zYpeb40x703MUN3Rc7vzEzfNkmFAZ3FeiKHY+I/R8HuOH9gCpjoZT77jUaAWF7uGYDlwafwB4sBXMb3SQKOw+tKq5c+c+2hec1uEagc1A7GOAn4M50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528641; c=relaxed/simple;
	bh=jBtl8DwOaxG6vkSVgghUalCtw/yo+41/HSBj9McaVDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d93qLSAsEQ9QOSRLprmKWWMeSBI90uvxuiDYKY2RqdmXDsfSMuOSTX6FMMAWYHy9PaWYtbNYAD2NEZC1r/Ao11V+vETqZVqWY9XQF1NfyLlH/LV4+PPJCC3byXdtzIIN13YH4bNN9p9pmiHAwbBbRNgX22pF4kAg5FU3AAsFhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CnoLhqVm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sk3BVg2W; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CnoLhqVm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sk3BVg2W"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C606E254017E;
	Mon, 25 Nov 2024 04:57:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 25 Nov 2024 04:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528638;
	 x=1732615038; bh=WY/Wbikjo3F1gonqGPpDn4N9M8Ks32DOpjVuKpxy+wQ=; b=
	CnoLhqVmplhcMuGVKU/525UuMu2c7gHDDNzWup6KrSEfD+kwB1dDjy0WEJmyH8XX
	e1TshJ+VBp1HkNSHovPuTRim2XWEOTv5sQRaX5cmryYSAuvNEra9J39SVpndbkPX
	curg5ZHq+piudEJ32B1Ib9XB2AYmVQkTVhu6Nb6iGxUzeX1o0HOq4tELchWOYT9K
	IDiasb2bbQ7U1mZiq2MulLodp9UDOQq9+Jv2uiuSAhUz2fVUxT4Lwo2H4vT4Gj0r
	KWHvxS7RCTBXxdK7HSJUhIvuyHKBQMuzC9oXIYbu6FEgx0akM9sK7/lftAyQCHaj
	Hq754jZgr3o/clJ4k7bLbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528638; x=
	1732615038; bh=WY/Wbikjo3F1gonqGPpDn4N9M8Ks32DOpjVuKpxy+wQ=; b=S
	k3BVg2WT+HMQkDtOJclKKEyvaFwgaFYi5ABPTzcpk0G/TArxYRfx0z3pyfyEsze8
	6z04Y3LMwGJbR/sa3SDWvZf0Gw6H0XNRvMz6U5apLq11+XpODUMs2XzKK3iAQ0/u
	fIFf3a+P4QeA5iAPM1b8yMkoACcYuz0YZMDvShc5MsqR+Z96ciZC5nUUnYlyPdbM
	Yo5DOyrlCUWjz6ShHD976XQg87SqwdnwxRIbcPOIXpo/p+Kurse3madhNDxFs2hF
	y2YJ9Oht7RGghzw6WWKhRPr7ggm01gtgKNrYNMKWzhENztieZm8C40Phw+LVIA8U
	hP4d9vlWThftd9C7BAK7A==
X-ME-Sender: <xms:_klEZ2VHaXRcd29tgQoMOQRZdfOO36DI2pAKvTUN3nY8w0IXdUshYw>
    <xme:_klEZylACtZNovHxVGAsrz_jmALUdjUt4Fut0d2jUbVT1ZU5ahhC_-cGeazxw9cTu
    U9K39GugDB8MZAAwg>
X-ME-Received: <xmr:_klEZ6Z_LgP_vMgFabmQjixjUoiog0Dsx-QJXbJV9VuU04hsSfDK6hkFoPF306hIsLoUFU7PZ4k_zWMRGm8J9OcDu1OtkbT4ud2Kt8OVrOKWUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepfeefleeivdethefgudehueffheeiheehjedvheekleeg
    ffdtffevieeludeiteeknecuffhomhgrihhnpegtohhnfhdrihhnpdhrsgdrihhnnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhush
    drtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    eptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:_klEZ9XpZgcSA058oaT1H-MROJ8DtsntuFSykCjo5NClS6zulCzh_g>
    <xmx:_klEZwmyhh8GKgZVTXB0T6g2tfS0VvEepvAfEejf_TrdKKJp_SrxNw>
    <xmx:_klEZyeAgN86tmLVM5EvEZHTBpSVTImpakNynh3MQgYQkJW1jynT8w>
    <xmx:_klEZyEsawX64iGDKVrN9uIOtyUc7AK8W-HbJJjqKeMYqi1VWVGJIQ>
    <xmx:_klEZ6fq4rA6VhIf_2CxpQyV7nCaMdB2aGsLAsyFO-qeNK9g-DxecaeY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b0773048 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:56:54 +0100
Subject: [PATCH v9 06/23] Makefile: generate doc versions via
 GIT-VERSION-GEN
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-6-1c6cf242a5f1@pks.im>
References: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
In-Reply-To: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
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
 Documentation/.gitignore                            |  2 ++
 Documentation/Makefile                              | 21 ++++++++++++++-------
 Documentation/{asciidoc.conf => asciidoc.conf.in}   |  3 +++
 ...r-extensions.rb => asciidoctor-extensions.rb.in} |  8 ++------
 GIT-VERSION-GEN                                     |  2 ++
 5 files changed, 23 insertions(+), 13 deletions(-)

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
index 0f55baa252fffbcd506f0c6f410b26b37f2e9b11..495c61c85ed18bc9c4643f9e5478e5146bb5f196 100644
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
@@ -341,6 +347,7 @@ clean:
 	$(RM) SubmittingPatches.txt
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) GIT-ASCIIDOCFLAGS
+	$(RM) asciidoc.conf asciidoctor-extensions.rb
 
 docinfo.html: docinfo-html.in
 	$(QUIET_GEN)$(RM) $@ && cat $< >$@
@@ -364,7 +371,7 @@ manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 %.xml : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
 
-user-manual.xml: user-manual.txt user-manual.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+user-manual.xml: user-manual.txt user-manual.conf $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d book -o $@ $<
 
 technical/api-index.txt: technical/api-index-skel.txt \
@@ -373,7 +380,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
 
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt \
-	asciidoc.conf GIT-ASCIIDOCFLAGS
+	$(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
 
 SubmittingPatches.txt: SubmittingPatches
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
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index a1c8146f05cfa7fbc6c47804aec5fb848e67c69c..b4687784c1c348b6efb110c5e8b935b788723f59 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -53,6 +53,7 @@ fi
 
 GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
 GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
+GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
 if test -z "$GIT_USER_AGENT"
 then
 	GIT_USER_AGENT="git/$GIT_VERSION"
@@ -72,6 +73,7 @@ sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
 	-e "s|@GIT_PATCH_LEVEL@|$GIT_PATCH_LEVEL|" \
 	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
 	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
+	-e "s|@GIT_DATE@|$GIT_DATE|" \
 	"$INPUT" >"$OUTPUT"+
 
 if ! test -f "$OUTPUT" || ! cmp "$OUTPUT"+ "$OUTPUT" >/dev/null

-- 
2.47.0.274.g962d0b743d.dirty

