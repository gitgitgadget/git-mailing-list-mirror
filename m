Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D10213EEE
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431025; cv=none; b=aRarxBqD6r1tjATdwjuTd/pitbz67LiMjk2mr6ybUfuk2j8YpYga0P9GlEImccbjUdO7nmMDK2BZZYWPGiwSXoalz20CYYVMksRSENx2o9NVBQHIjR47dFDtGNi7Nkpca0F+c8Oj0hkwp2no0sWMZZeGgTU4f2KxxnK5A9t5KBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431025; c=relaxed/simple;
	bh=PB4gCYh6iBWqyPvmV2vEqoFZrv7f4OrcMFwyJy3yLs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DgVL5F6qIyNJvdIf3y0ZlGJqiUtJke9tWyQRsCV3uRLneDpY5W2lkFaDEXz6LF1l2KDJXmtKprwbBn5x7kG9fmlRRqthx3pXYTu8RpuTT8PTba6LKtxJ59TxuvphcPyJn4aDqt2KZkGrxKUWRwtqlWkDxpICOVNJtzO79BFiIZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TUC5gZ0y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AvCvVOVH; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TUC5gZ0y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AvCvVOVH"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A724D25400D8;
	Tue, 12 Nov 2024 12:03:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 Nov 2024 12:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731431022;
	 x=1731517422; bh=Gq9wXMotVLWclVQCVlpbc9GK3l0zoiGL9bwhYqpUr6s=; b=
	TUC5gZ0yXmrQoUO3t/AQUrMZNOKughsZ+q0z4VsMaC7sOjKGGMD0Is/kbtCENR23
	LoydnBTg0C2W+mjUTj099HnRHMKnMFSMpnBZqFQFnt9B7xJAeiRURnjHBGnmet6f
	SOiAw4UonsefokI/qnEMgbHegf+6JBRkoV/rEAZldNJd+57lpQVxMHhWtyjlSEkz
	g21Vrb3rCRTC9Tkr9Qpzu1HGLiS3OzEsrXh85GkrGJESIQZXIITQPjlbMJtAruTU
	S0Ht9j4bNcN7N+wWh0wgGq3HiJBIrW00Ui3Mn6GstqBMXCSSvXHHCFBkdFElEYUx
	+HslqcIjc4rIhO7bl4ETrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731431022; x=
	1731517422; bh=Gq9wXMotVLWclVQCVlpbc9GK3l0zoiGL9bwhYqpUr6s=; b=A
	vCvVOVHUt8hOAkl+ZAE1K1nl/7O866cnqC60YgcoqFTZ+xJ5kq7ctbrsNoRMEy3j
	CA9Nj54rsyYp4whNowHRoM1h+hkbNcjMa91hCvnMMv23UGtlZugvLfrVe6RdihJS
	YzySbbbfD2VbGeS0PMEP5UjC+gp/PMsCJkgED93QkGEmbIuooWfrYj20FcGC7n1p
	OGK8xJJ8e4bQR/5tG3mWKbHd3gfeKoCUb1Jv3ByXOi61TLHIS721BZH/ruqF/dgJ
	dL99EbsCxBDuXrz++OERUdGKxrwNrXMaC8ZAAUZuaThteR7Ho/yKpnYqjmHOsUGo
	ZCWq3QukGIS6beG6y29cQ==
X-ME-Sender: <xms:boozZxeeY-bDDQpph8y1uzgEd2QpEMS6bHSiCpRmi1nG9h_n_4coBw>
    <xme:boozZ_MVnY_RDFd1j4MdkHdmZR53F179sdRzqCi0jOncRVtvxh7aVjMMED16QFIQy
    OX18Rv1vvlmhjfZRQ>
X-ME-Received: <xmr:boozZ6gC_zSDJCKZqv_suSAqtNnFJIiEFvEhZXAis3a-fuVyk_9MDMn1rdsok3_iH1emSYMExLYwsY9Hdxs1UGvC1_Y-fdRhG61EXnlJVwFRVyE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgt
    phhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiies
    ghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:boozZ699uhSCszr5nnSI7r-ON8x9JmldAHhFcwiMJll9gYXBgESKpw>
    <xmx:boozZ9uB6jty_r4rA_noAYntalav1fZH6D1AfsqSqaaGEOCevTt04Q>
    <xmx:boozZ5GoTlQ3PcOCtOrlCjwZx9TURNR15biqgWl4xZS0Od0c9MnsWA>
    <xmx:boozZ0OdOSc3XsAwkQDcoVJHlZymIt4HikNnbdwMZcXHGulAN7f4NQ>
    <xmx:boozZzJotmgTQM0_wXYLv8BfNHdddjkugOCd6xg8-oj7ldGbLQmb-fh7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:03:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59a97e39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 17:03:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Nov 2024 18:02:57 +0100
Subject: [PATCH RFC v6 14/19] Documentation: extract script to generate a
 list of mergetools
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-pks-meson-v6-14-648b30996827@pks.im>
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
In-Reply-To: <20241112-pks-meson-v6-0-648b30996827@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

We include the list of available mergetools into our manpages. Extract
the script that performs this logic such that we can reuse it in other
build systems.

While at it, refactor the Makefile targets such that we don't create
"mergetools-list.made" anymore. It shouldn't be necessary, as we can
instead have other targets depend on "mergetools-{diff,merge}.txt"
directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile                   | 22 ++++++++--------------
 Documentation/generate-mergetool-list.sh | 17 +++++++++++++++++
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2b9fd37ff7021f3d44eaa282b942c623f403510a..e2ce98a751f090af8a8c095e7b138ef601e9c0be 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -276,11 +276,13 @@ ifneq ($(filter-out lint-docs clean,$(MAKECMDGOALS)),)
 -include ../GIT-VERSION-FILE
 endif
 
+mergetools_txt = mergetools-diff.txt mergetools-merge.txt
+
 #
 # Determine "include::" file references in asciidoc files.
 #
 docdep_prereqs = \
-	mergetools-list.made $(mergetools_txt) \
+	$(mergetools_txt) \
 	cmd-list.made $(cmds_txt)
 
 doc.dep : $(docdep_prereqs) $(DOC_DEP_TXT) build-docdep.perl
@@ -309,19 +311,11 @@ cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
 	$(QUIET_GEN)$(PERL_PATH) ./cmd-list.perl .. . $(cmds_txt) && \
 	date >$@
 
-mergetools_txt = mergetools-diff.txt mergetools-merge.txt
-
-$(mergetools_txt): mergetools-list.made
-
-mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
-	$(QUIET_GEN) \
-	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && TOOL_MODE=diff && \
-		. ../git-mergetool--lib.sh && \
-		show_tool_names can_diff' | sed -e "s/\([a-z0-9]*\)/\`\1\`;;/" >mergetools-diff.txt && \
-	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && TOOL_MODE=merge && \
-		. ../git-mergetool--lib.sh && \
-		show_tool_names can_merge' | sed -e "s/\([a-z0-9]*\)/\`\1\`;;/" >mergetools-merge.txt && \
-	date >$@
+mergetools-%.txt: generate-mergetool-list.sh ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
+mergetools-diff.txt:
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-mergetool-list.sh .. diff $@
+mergetools-merge.txt:
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-mergetool-list.sh .. merge $@
 
 TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))
 
diff --git a/Documentation/generate-mergetool-list.sh b/Documentation/generate-mergetool-list.sh
new file mode 100755
index 0000000000000000000000000000000000000000..696196fbcb86084abffc1d29355705a37b1532b3
--- /dev/null
+++ b/Documentation/generate-mergetool-list.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+if test "$#" -ne 3
+then
+	echo "USAGE: $0 <SOURCE_DIR> <MODE> <OUTPUT>" >&2
+	exit 1
+fi
+
+SOURCE_DIR="$1"
+TOOL_MODE="$2"
+OUTPUT="$3"
+MERGE_TOOLS_DIR="$SOURCE_DIR/mergetools"
+
+(
+	. "$SOURCE_DIR"/git-mergetool--lib.sh &&
+	show_tool_names can_$TOOL_MODE
+) | sed -e "s/\([a-z0-9]*\)/\`\1\`;;/" >"$OUTPUT"

-- 
2.47.0.251.gb31fb630c0.dirty

