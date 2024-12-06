Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B69D20A5ED
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491530; cv=none; b=NYzvKlJqut8ucGZ87HYMvrMrFXiuaRfg85so3NnO5BTxzNGgVPKoefLejJigF/O6iOfp7hIQD10Eia4uzCtWdojpAihMiDevqDWbIT1i4DP2B0flCYI7uXz+T1xwcdPd9BKNMuWvqQeNzrTlJOea8jmzwTrtSRl1pzD/jc9+5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491530; c=relaxed/simple;
	bh=G4o+MewaJRMw1aIAGQhnrJQS5hhlB+LNl+zTi8OqlRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6e7yzbXfjwQvP7LNaB0Te6Mwjlfj7PcD2Zh5huw8pJsUE4FPTocSSddHNbSdeIOUNhQ3tClaWX4w1Hv3aaUpEWbOVi4WqVGhOmBObHy78TVgBXHTn95YqLfJoGww9u1hK84NZzvbH/xb0c7KaMdMGviLHkVyfzvpCTxx5eYVMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nl8WR+0o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1JAUxAqx; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nl8WR+0o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1JAUxAqx"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 018BD2540174;
	Fri,  6 Dec 2024 08:25:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 08:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491526;
	 x=1733577926; bh=Lj2gx4iqVfdfY2GORjRQJV22LB4P059erTN+hAlfoSg=; b=
	nl8WR+0oaHQnQ3Iz/HjHrYgp2A++FbWJ9PbvsjBo57Akb4q9QKAiPw2DqfZzY0xe
	cZy7SsDTdFiY48jrSplovhoKmVi31irzXAh0Jr8q2iocBti1TVrznkcwVn2+BbJs
	Pj41Q9/TiZ7MaPxPyR5MuVXLIX9Ah5Fuo53GnJjJdlv5CSIT+oNXbnWox/yXd98K
	C0ayUxn+DhN4K2w1bRrQTstgKEKRKZo5f7vn9vqJQPWweWId2iLoZY0Ho4ZHCa7r
	mu3oPO3G0C/qdOGuOMZj0G+nQHr8iyYMxCCqiyN1xlFibVdQLzBJ/p5k8pFG+xUY
	Y8h1SwcGJalkLY3XfADkiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491526; x=
	1733577926; bh=Lj2gx4iqVfdfY2GORjRQJV22LB4P059erTN+hAlfoSg=; b=1
	JAUxAqxi7Q78lq7TVohnVi/rN1ZsBWRPy8d+n0LrmqKEhSwg1WTxt979r6nmv7Xd
	4oY8xrmC5+7vrxiKnLmUxL1xWIyILCyAtLHvHyOBn5a2Z14iZk8C54Xlq5aCUoMS
	MvOTTng0DaErLu4PHu7F+aDKrWJz26cHV913m5tdJlSNfI/efsgzf1L0ixi9ru2r
	66AmB/k/x/kvgdpiVq/sutHuLn40B8y5zrwnKV2ofsT2o16xNKOOjOGVCyPzXinI
	5h8rgKvRZS5k5LWGS6VNLQdU3or7PNrLs2lK+u8nWo7RYv3d7Ud91tC84oGYopvl
	iGwOlcOwC4FyYT7HYCm4w==
X-ME-Sender: <xms:RvtSZ1Y2UEH5pZD5r6JEBXw7oyIbB44g0Ak4sG3sEnXCyWRpaIJoJQ>
    <xme:RvtSZ8aCNtNwgO5SDRkd55JTM2F9WUaMy6kFRmmZRFONM78oeU1ftgamqkF4PJeme
    _dq9k9c5j_q-at2Lg>
X-ME-Received: <xmr:RvtSZ3_qmyGGuooJqh9v4gpaNBX1Yne88VcuwwheZXUdP6-YMf0RqarMI8sDXxZfP2FXVIQp4X7gi6c1lAU8X2uvdfMV8FSi9h_Ho5JEf-WmgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepfeefleeivdethefgudehueffheeiheehjedvheekleeg
    ffdtffevieeludeiteeknecuffhomhgrihhnpegtohhnfhdrihhnpdhrsgdrihhnnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthht
    ohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtii
    esghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtg
    hpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:RvtSZzpeCPjq83f2ohVn_BfuWuw8vV8s172C0QU9i5PfVhv3c3Nq5A>
    <xmx:RvtSZwr_84UjRqHg1CiG5OGgTZKNQx1dJm9khByGgeZEHKwMD8qnVQ>
    <xmx:RvtSZ5QvJYpKC44DJ8XTK3Ya5rJ4g2iMt4m3s8iy1bPhMfCWeJajwQ>
    <xmx:RvtSZ4rLoeEgAa2p1GG1NAqhNvN_ofKqx4bop7WfEEBvxUOQFnRwgQ>
    <xmx:RvtSZ1RPdqslzJP4QNTpPZ223PB3xYVo_b8NyFYIfodvugZxIuFzwNTX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cb231f82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:23:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:41 +0100
Subject: [PATCH v11 06/26] Makefile: generate doc versions via
 GIT-VERSION-GEN
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-6-525ed4792b88@pks.im>
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
In-Reply-To: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
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
 Documentation/.gitignore                           |  2 ++
 Documentation/Makefile                             | 25 ++++++++++++++--------
 Documentation/{asciidoc.conf => asciidoc.conf.in}  |  3 +++
 ...-extensions.rb => asciidoctor-extensions.rb.in} |  8 ++-----
 GIT-VERSION-GEN                                    |  2 ++
 5 files changed, 25 insertions(+), 15 deletions(-)

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
index 0f55baa252fffbcd506f0c6f410b26b37f2e9b11..9371f294254fb77c08a695daff0dd35f4073db4f 100644
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
@@ -416,13 +423,13 @@ $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 howto-index.txt: howto-index.sh $(HOWTO_TXT)
 	$(QUIET_GEN)'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@
 
-$(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
+$(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
 howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
-$(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt GIT-ASCIIDOCFLAGS
+$(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC) \
 	sed -e '1,/^$$/d' $< | \
 	$(TXT_TO_HTML) - >$@
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

