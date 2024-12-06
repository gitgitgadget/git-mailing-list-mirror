Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FD920E03D
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491541; cv=none; b=dDPrL8YGeoSuOs6uxr/VyRa2BMmwugGk10U+ckeujI7wASOijvLsnInN21T8N98DvFxoby6hSUnWwrMkXIy/EEYYTi9AKDrbh0+k1t8iDu6ZgTugTgdIBWpPCxEQXGJyv5rBx6Vi0rJL3pjUW0jA0nAntcyQYB5kHnalZ0G6Unk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491541; c=relaxed/simple;
	bh=RMtQBjTffCQzJfbDiEq34iGCJFxWELMPIjHj/OryLsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m6jO8I+LBIxgNkQ+oQbRwcYRzdOq+o4o4nvT2SftfEROeOcEEd6taUDXCu1/muYulVTy2DaM/Z4X2I3QL8DyoXu3hX1nAtNAQ0aWk22dnFqI5wliGy+iOfk2wuF9SJ15OfCvRWuBqzaHB39MILpfgjpRuebiKb1BpZHmw4PBD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hsbPVRdd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qbF0bt9b; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hsbPVRdd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qbF0bt9b"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0CE082540183;
	Fri,  6 Dec 2024 08:25:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 06 Dec 2024 08:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491538;
	 x=1733577938; bh=rfPSL0MDNp8IFw4P9JONbiPqSK8BKmmRJVyK9/NIg0w=; b=
	hsbPVRddnBLw0sD9SjUtpZdlvziLCkqpciEJ1ZQSJkGYc1NdMSlwHhp7GF+ZCxJK
	o0k1rYUwLg9tlXFlUwan8X61IJDqzvRpbMuiEpde1+ribDE33iCA3KcRfsv2F7n/
	vY7Ic7gQmrizhL6WJ72LpfSiSLiRcZ9XxsaSUDSuTy4UndmWHuxj/M/tn4VeQzqx
	/rIIYFGvNswKJ6y/R+deQD2i/3OrL8Lrad7Y294svO1gBxvJlsBg+UwDXunfcUwr
	rPlATn+nPcjUy2jLr/b0rquY0QyL242FlFxGRznaQxxY0o/RjOFIfXAiqQWVqe3I
	qqpLn4PmEzcZAbEBUME4uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491538; x=
	1733577938; bh=rfPSL0MDNp8IFw4P9JONbiPqSK8BKmmRJVyK9/NIg0w=; b=q
	bF0bt9bEc5hHrsiICzmdvyODjgAC/L4S0xyLGSiyPZ/lZRz/OoE9iUL5O3uqU3ke
	cSfY/JuUtRG1S7k1g0ob9rHdkBvZY4Md5uWmYQpaC5aoMKK1jhKxQAlGM3vTxGO4
	4URxkNKULPuoD2XOooUP2Wc+w0ywVIAlnbKkdi7b4jR7xaC7mC/oga1ZaItr0J6L
	6XkM9PkXvHRh4uW16yi+08x75DSkVP3ZD7j6vlyFRUBXkXWwcKKgTWO123s8TNMr
	ktOxTPMe/qpLqIHZ1LbFCcu1/dYccuaxicAk6doRgucnwagsooFSXdsN7JJ8jX8v
	oolPUovAUvzGaxLr5KPbQ==
X-ME-Sender: <xms:UvtSZ7o6f8iz0OrzLlmh54BnBrgy7eoUMamrWmMt9VpPP-D4dLuGIg>
    <xme:UvtSZ1o5XWTpNBggoCQYiwJPJ-tkONpdz5OMvrnh2aaaNa-OSiPL97NAg3Ub2TwHY
    yE9rs-hZJJcID8nEg>
X-ME-Received: <xmr:UvtSZ4OfkF_Eh1Mly_ozU6jS3cLCqWMKEtN6mBIBh3rtcKPh0uJfWlw7xI96oLSoiItqvubgn-o3ZFu6_Jq92wtT0QWcbje5tA_DUmA2NsPhnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehj
    iehtsehkuggsghdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghm
    shgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhig
    fhgrmhhilhihrdhorhhgpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:UvtSZ-4Ii4srnX2B4CJXv76Tgvye8QVrmko4gJacniBHHd-Nt51rHQ>
    <xmx:UvtSZ65l5C_J5OqOyOHL6go6fs9sjA2SRRe3CtH1b-BLgxxnpsauHQ>
    <xmx:UvtSZ2g76LgK0aRGa8boiQ6hfTiTtmx8lqTk2nmCgxEPfVEn7fmfUA>
    <xmx:UvtSZ85MvsY6uqEJ9H0PtQu7PvVEiJXk9FKgiBz6g6lW7xQwiQEZOw>
    <xmx:UvtSZyj4I-1xfBd8FWzUHcIk8Jk7eUqaj006CbKzRwHzxRTG04cJrVRr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b7ac0e9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:24:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:55 +0100
Subject: [PATCH v11 20/26] Documentation: extract script to generate a list
 of mergetools
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-20-525ed4792b88@pks.im>
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
index e853d89eb5d6c89eb7e7bf10c5b75e5ad0db531b..f0e5bc9c0c64ddf83b2d9fde0bf877a4f4b847f3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -282,11 +282,13 @@ ifneq ($(filter-out lint-docs clean,$(MAKECMDGOALS)),)
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
@@ -315,19 +317,11 @@ cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
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
index 0000000000000000000000000000000000000000..6700498b93be5358d992530b8dee39c08f02bd8d
--- /dev/null
+++ b/Documentation/generate-mergetool-list.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+if test "$#" -ne 3
+then
+	echo >&2 "USAGE: $0 <SOURCE_DIR> <MODE> <OUTPUT>"
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
2.47.0.366.g5daf58cba8.dirty

