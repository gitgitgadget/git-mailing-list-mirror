Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D31A0AF1
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339083; cv=none; b=MIU8QRVa7ouWV/86CDgOtt0Ujz4u/rm2ZabmxyMkNNtpcD+WMFzylyGRib7kcX0OGfxgXjkcaKnGj3VZN4cF3o/X7V+CoyNPj7KXvNpf35XjMysPh1vWMSBeQYKTkORtZ/+yxpxbrK4UH1yLHIA+8GozD9eyf+/EK5S56ADBCQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339083; c=relaxed/simple;
	bh=YY56kMBFVYEL2OkDgnZ28ZzRWXdhTB/i+vQ9oQ697h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSxFmCOd2fLdswgpmA1SBoZImBUmeycNJXiLQE9vSM9ZSRRBVJ13Vk440C5b3q2RSFWFbE06YSkdHX0sqBVDc3L+75tO7IMKxLf3/mUfbrXYDc5tNYpp0Kol3aDj0m9saY/DR1yVAIFO+9X6rscydXkUETAqM33PsPcyauppaCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ipkHiLoo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QASqg6PP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ipkHiLoo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QASqg6PP"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5411B11400F4;
	Mon, 11 Nov 2024 10:31:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 11 Nov 2024 10:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731339081; x=1731425481; bh=X4NTxEMXqP
	gvs2TizFPwrG6jsX4eVkOVp+AwgIAgg5A=; b=ipkHiLooj71yuKSefPTo7JJBSK
	ippQswtp61TKF3IuTYXmhHWV9Y0lqwzGx2V7InLSe2ihBeZIuX9ouQvE/clXSCdW
	NqeVaBTzIMCUoOn6w92BhC6ZIenXt72FaC8/7S7PujzoaSDy6HAF6/o8ptmm01bD
	9heBuOwtFxyZ/lEAvmWJJ/lv0PlWnFs+VV9BkygSI+adgqBqC9yqXuVaKW3jOTh+
	bqeGSTUZ9C08iBtO1pEVQTaytQ411GmROq5d4cXwdDIbR4H3ZoNc0iwL20AsNRHb
	h8DbcgTpOuu/v8tfvwVTmln3EA7OXJfwJmSwoqz3Su5GGqw7TEEdysvM7iww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731339081; x=1731425481; bh=X4NTxEMXqPgvs2TizFPwrG6jsX4eVkOVp+A
	wgIAgg5A=; b=QASqg6PPJPoqHuai0JGEVGCSvM5deIjCtPUbLGaXkKcef9TNqH9
	Kv29ohgq4qEh/3p0liogZFjMHeTVI9iQ2iY2L1ytJXecZv5Jj+hXMyvP+lSfv4dJ
	AKUG+wplnU8Yi+YSKFIbQo9u+RhRuf0JlSdfgbd7QzOoormhC5jtFVc4S1vreqKa
	Zer1/ZOmDeuOSVt4SYqreXNa02EqTs/PACcxmhM1HEF1wkPVW/VHNocTAZBhIHZx
	6J9AwmCsOHutlrbVZQWODO4ERtNVUQxXjDlnwXGizKiLJ1lEDBkVi6I28YywUzQr
	NJvatSIP1DAbl2aj/46mMDcQ3+oZBenpqWw==
X-ME-Sender: <xms:SSMyZwwCRHUNamRDij0MZC3XLKjrApq87c0G9VY-7cXapB9EnKsFEA>
    <xme:SSMyZ0TD0Zp-0cuscr0dbAq2QO6-iFsfl30-7LC20wP8rjAbeZ0LVAsgWC-7XAg8c
    hGLWsiN8xaVky_B_w>
X-ME-Received: <xmr:SSMyZyWUz1Llt6sarPLbAt597u4gW3pB2xRNeQx8PKWJK2LWOJ0NotPlHScF1dCtL5to5H7jgWKoVlGppqQAFJHoImSPsj-pnVLpOIPRUj7TePyH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepvg
    hstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgt
    phhtthhopegurghvvhhiugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:SSMyZ-i9eq7H0_2mLWJZjFBzSee00wdvk-_bbGt6_jdFSVF2Q74ipQ>
    <xmx:SSMyZyAQBQ8Bxw6mYNWejCl0S7twNVPfCiosAwU85rLQUf7otnHiaA>
    <xmx:SSMyZ_I5CxDNLD-SqUIWx6M3uioGRcumCRXcZMPFkdV80SDO-bJ28w>
    <xmx:SSMyZ5CpjKRtgtqREZarwka9mfKIlTT2nYhzX9X5cM0GGKUi355t9w>
    <xmx:SSMyZ-3PT97CfxbwlU7mK5GeyUrjognvxEN2iC9B7xTpIqxlQ-1raQUx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:31:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a71a38f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 15:30:45 +0000 (UTC)
Date: Mon, 11 Nov 2024 16:31:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH v5 14/19] Documentation: extract script to generate a
 list of mergetools
Message-ID: <4ef7262aa044dcc7c59b83644c1c5c59fdcc2392.1731335939.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1731335938.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731335938.git.ps@pks.im>

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
 create mode 100755 Documentation/generate-mergetool-list.sh

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2b9fd37ff70..e2ce98a751f 100644
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
index 00000000000..696196fbcb8
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
2.47.0.229.g8f8d6eee53.dirty

