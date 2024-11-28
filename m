Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053231C07D6
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810355; cv=none; b=evE6Z918TaeREotOiAgFPAvL7GgnJKKBE9Fgs+Xzlc99DYEAtITQfJTBFRcgEs0TjVhzmvhcCjMJAlAooA2dXUrcO7wfFIvTDJthl/qmsbZdBnH7zuvvLMIf2pEHfR1LWIrBua7iXL4HbWmMHsnHZoXX8TQoYLrn1x9AG4os8ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810355; c=relaxed/simple;
	bh=1haNA3w9y72aZxpwLNNUbrwRkvGFa0jBnVBfr7/c/BY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pu34yr2J9hevvqSqYhdXD3di9bCpLmfrhlPXwe8uUmAgniKXyGauB0MZY6GGph3hieHJef+PF6CrMsHBG2VZHjvIP//8a97CVsmYhJxMbYORCuJpIVTDInGlpA8F3TIDoiieCNxvKOr2pk0E2NaXz+VnGMhUFUKlWQ7Kckneod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zz6sW/Gj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WuZh4zVn; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zz6sW/Gj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WuZh4zVn"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E839114013F;
	Thu, 28 Nov 2024 11:12:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 28 Nov 2024 11:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810353;
	 x=1732896753; bh=5vNsZvOiJ89AL7mpax7Ra8Rvr0ZDXR/7BCV8iUFa5H0=; b=
	Zz6sW/Gj10JGioNDPayJzy4g4nkB/wxwplOeX0zKJl0I2zj4sEQIXjUK8LJHr+Sm
	w2tYSP+cui4LkAYp8sq8tLKw0ACYicjZjP5WLc7y9n96SWcVy1aOOlpck8Ye6hmO
	/BdfZ+7lgcqa7nk+PBR0QBnSKBsHwEqPJz6sHwE7v8A1LXqpx8TN3iZEzBWtco0l
	yJUVebxL2T8GCehFnHugHUZmJh6F3RPxe/7vlgPJs8A2hMREKj1i1FWOs+t/L/oH
	1DtgUSdPWMyJHrR8JTMstHakFAjC1aboobytmK2c/Cq4jcBponCHi7IYZ0MtlIxe
	UDe4u20r4otta9aE17tfxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810353; x=
	1732896753; bh=5vNsZvOiJ89AL7mpax7Ra8Rvr0ZDXR/7BCV8iUFa5H0=; b=W
	uZh4zVneaqBiYIJruPTgXCphdp4xhMdCUWVbRwLY6v8xALh+t8JfGIoBBd7T5weN
	puEONeEclDZ3TY+NI9DSuupqDjN7D6h67maylBmsd6X+WmwyQd+b2h3R1XI8/SJz
	HYeLxkbW7Lk/a3oTtvBdUEZZbZSL06GNqDoqB98cW/XcQDzNB8+rfmDmRBt1+EbZ
	YGdZ/Q4L4ZFfVjZ4Yfj3Oa8yru0SrfnhlPT8IMLgo/NZVZ16E+FOTPFDMKRuaKpo
	zXcGX49YtVX47DCO9WkC6kiBHJ+DeuQW2cF6AoTetdVdogSrsKq8v38BC9r+opm+
	Ypy2xKSyr8BL6wQrO/y/w==
X-ME-Sender: <xms:cJZIZ1byEaQaR_US0sOZwTCAK9sP_AO5ucBcC5sd51rNm83D2I-kqA>
    <xme:cJZIZ8aOmz51Zzib_f40MAeX4kMQH4K45i03R4qJaBJTSbiLPCzsjwzab3MQB4SKa
    0R38PKj71sNyklNxA>
X-ME-Received: <xmr:cJZIZ38GarQM9uja0Q6Fzh6Q3BHF85HyhdcTXipr9DIKuGFWdYBiJyLHihV264z07wm7bWcyhsasUzMXAOo-nwX5UCRbMdYqMdM71pbzPC20Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepfeefleeivdethefgudehueffheeiheehjedvheekleeg
    ffdtffevieeludeiteeknecuffhomhgrihhnpegtohhnfhdrihhnpdhrsgdrihhnnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshh
    hinhgvtghordgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegurghvvhhi
    ugesghhmrghilhdrtghomhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtph
    htthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:cJZIZzpK8naIFpjL61vqJjYW6moQ52o2W3-HH6rE46NS2K7wd_cf-g>
    <xmx:cJZIZwp7lUmxciLA4szK1za8Kq6rYFZN7SCXbRiJmsPBXcN8S8gKPQ>
    <xmx:cJZIZ5T7TjtAp3u367hGJkTSWkIx6EiAZfxsOPOAAsbIQjyE7WwSXQ>
    <xmx:cJZIZ4qnte2GQ9XJZuVtOB6FhO55JX9FOVIJh8vDnUv9WkZB15v5TA>
    <xmx:cZZIZ1Qbq2peWr80UvGO9OQz1q8LlhKvr2BSvp_yuPx9vmFVazeEzMBT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf5fff04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:07 +0100
Subject: [PATCH v10 06/23] Makefile: generate doc versions via
 GIT-VERSION-GEN
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-6-79a3fb0cb3a6@pks.im>
References: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
In-Reply-To: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
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
2.47.0.366.g5daf58cba8.dirty

