Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14E61C1F37
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810363; cv=none; b=F9OvQE2rZiswgMALETgOEZ0MAczSL5BsS7P6PJQG8doqxSF9WJqLBj3VMOc/VQpAKfq0gJ3ax8gKuohF5LCXb/UEI2Wt/aW4yJWxyIRMMOnMDdlFh0pi74IAPyNqSyR2WKg+YwzH7725/BiSDTqRLNCIBdD/SNRGHvnLSbr9Mok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810363; c=relaxed/simple;
	bh=OWGm0Fl7mzo5hFuxceT9M0WtlKSGkXEjKQjkxwndu+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gCK7nbfZ6eYZoxHm7ZGIy4zASZYazIOfYr0eho1ywTN+RL/CdOMLSMSnNHNHBdWWFy78lqbrHEA0muTExqVHtgI2OyynEHLZMvKFYaYUdpH0fUypWh3zuVKiqI8rIATFfQQDgKVT3maPnE8kaZvFD+qO24xlC0GKhD4kKlGTFww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qc0wQ2ma; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v9nP8EvA; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qc0wQ2ma";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v9nP8EvA"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id EF2871380368;
	Thu, 28 Nov 2024 11:12:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 28 Nov 2024 11:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810359;
	 x=1732896759; bh=26qcectKdt/FZRgL2kwmLs8iF0vbd0zDV+Ht65V1P04=; b=
	qc0wQ2ma/tXvACPIpG00bE8STve8FdTvHD0wVIU4LwMmwUTv3ptAZ0gtyFiwy4qZ
	2PxeVULwQlJPbs4MMpeL4xvme/v81cnYx6W9hs0H4XLw+GilkkI6EsCrzpOZ9Qz+
	PYYUmyUQ3pgvlxNhtd5mXnXnrhd6T9YOLTyGOySokH0eq4YXVg81b3LLe9IrgFNf
	TQQP3+LcacBJX1CIFNjEC4MlhctfQedMh2SKasf2ExAnCIhk67XxyFnVQHUfWBV2
	Kibs89FehyVy5bzUsGV5kLsI0oGkVs+BHbRXdU6MaCxMSlyzbbyttsRz/g2zOLAf
	2qR17qYMq8hrqAPogul6zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810359; x=
	1732896759; bh=26qcectKdt/FZRgL2kwmLs8iF0vbd0zDV+Ht65V1P04=; b=v
	9nP8EvAnO89nDhTagEx53+TGxHqyswGxJTj2gAduX10V0e77YMdW1mpawoNPNf2w
	SK/N5YxqvsGmSbk4NF3SZsvhzkUJU1fWckdToz+CBhTmMQO3D13uw5aO5uhSuHLC
	aOH32PQq6vuMdHNLYk/ZsZrrqI/MMdofp6shCHDLEMhwVCex+lV1ay0wRM3cUUJ2
	9VT8Sjr6bruiVau2y1Ega2xS9XVq2b3tbIdoMHyUQqTpxG00Cqmwp6VhCh6xViv4
	k8YHgOCXsOArrMyWF/VJE9l7ZJe41B/CQO2ojfhSomjXekN86c6hayGVk4p51wEU
	7utvbuFDWfmMs/6+lGO0g==
X-ME-Sender: <xms:d5ZIZyddHVSEWw36jgiDZf-3bjSWBZ9bgOERSGItV19oH0Bl4nZkxA>
    <xme:d5ZIZ8PPGyzc43GY0htOzi1zIMqYxqJAb7xNCA65SyUpYq9Q8HymHf1NGmzhtesRl
    zI5SaaK2vhHWSs_Uw>
X-ME-Received: <xmr:d5ZIZzgApV3BQZ5mM_83KDfD3yQW-lrg69a34h0W56kSaSIxHl6wog3WhxHycKef2d6DYlExaT-Gbpo4owLlK9qgNXfRtXHGElHYq7liwyPKHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgih
    sehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhu
    gihfrghmihhlhidrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:d5ZIZ__T9iW8BWW5zNl1HmY8fZAhSwEdplYGfsbKBypFNiGgkneFlA>
    <xmx:d5ZIZ-sh57kKymIs4QSphLRc3r4omAXZIuL7R2JnGcHOSmwWe6jtaQ>
    <xmx:d5ZIZ2EvbV-tEPr1cEHH-TxXGq4K0m04rLa5NcLa3uho1083W6WZUg>
    <xmx:d5ZIZ9PjF_hkBDiv2zfk_KFY_ebn1iBvBlaPqAlrx1qB-IiibJHQtw>
    <xmx:d5ZIZ2HcoSt0xSAtbwz5v4425LGYCQrtqlaQGoih552p5q5SbGv7a4DA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f42a73d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:19 +0100
Subject: [PATCH v10 18/23] Documentation: extract script to generate a list
 of mergetools
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-18-79a3fb0cb3a6@pks.im>
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
index 6c3f9b5ed13ab0b0ceae05128ec4086a7f61ca34..d19ee3c399f337ea9ac7c9a1b595ac760ebed095 100644
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

