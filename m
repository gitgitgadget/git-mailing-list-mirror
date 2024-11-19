Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9621CCB41
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017074; cv=none; b=NW5mlqTf7Nh3UJVs2GysRV8S1y6+t+q5p9p4dDEIpQprzkJUCcPQ4FiqoASB2YFY/wqmAMrCuQAcqhF6EZ0rmQ9SeChKW+a1faDh/lJheL7IE9GGZEobBKW7F8oXninyjm0x1ocHbDDb4aQH6MCKPZfE16OXuPik4nTlvMObJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017074; c=relaxed/simple;
	bh=prKrZ7eSjyjUuafOosSnGdwF6g5bxkTxe8tJKqRK4rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWQncqHEO+0AgSWzUdm00nI3BgAwg5KF6ua2vms+qJLdfv+G/MBuicBNXFrfRW2m0CrfsfEusuYZe/9zQYft6IliZ/W/YnDv0vN7vJ1A2IJl050TDZoRJwoGpk9EO5lHjqaoyZRmL7ZIM6cCYAQ2JGwvxgGokSOgu/bAuWXs4oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qps3TOLB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dSrWX/Jw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qps3TOLB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dSrWX/Jw"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C13E01140173;
	Tue, 19 Nov 2024 06:51:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 19 Nov 2024 06:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017071;
	 x=1732103471; bh=r0pchwXZwDsBCPpQjWI9FMJVqL9QR4nnroNCr17sgTI=; b=
	qps3TOLBQ1tF56DbhDXQAC3ixcmIAGFggYkynjq2t7ymrCr5UmBwQmmXavgPKTFN
	rGtZ7YyUvwKzIL3AljgS92RQS3lc8roh0CqphxPN3eL36R9WeUBTOGugQ/H/3jiF
	AGyFyaowRSVtKRPQv5WjS1rEcU6Z96eJAeAB+JinKFIEGeIwbAkuvnHB/eLqLp1J
	tPvfHxwP2IaeXOH4DApjxn7wcpg289GIHPDNk+aL8IYTDVOkVT/g7XGcsK34oWuX
	dFAChAI/Sx2zgRbfjW+XUUAUd8vyLmaiXCg/3zStAt/8muqS2IcyOxeMCpTRhyh+
	vttl0vNwZCTFE0WUuBzj7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017071; x=
	1732103471; bh=r0pchwXZwDsBCPpQjWI9FMJVqL9QR4nnroNCr17sgTI=; b=d
	SrWX/Jw2dFHKOI8t3q8Feiew6Akg0jdjaG1fQpI1w0UOQc8PlZd47Bn/sQcf3g4i
	C0lOj5uA4Jh3TrIP8f04uTpEXBCtGT05+FfFeS3+iumB8VTKXRGu0+UiSm85bIBM
	LMHogNBmKUOvUE67kgYmaLwzhgc/PIS5iwu2XPADnuv4Ob8zxM5rOw4zH/V9Pte1
	kUJ4AzrlnUmWDu7XHw7sJuRpDAH0BO7t0TDwoD1h+v47U+0HhOeVjWRAj+WXvzue
	jWX0n8t8Y2O/Zk3SLkfu+bC0QqcbIAROwOPYCUJa6auTzccVUaXvpbUa8n6ba09D
	Xudbk2sp00SfZmJcFXVpg==
X-ME-Sender: <xms:r3s8Z3ENJZx0H4UaF9cMUGDaJdQJSszEOgzFyjPInrnv3t3OxK4N2Q>
    <xme:r3s8Z0Vb_G83Z-bNxjzdL6PYLRhLo3of8JnkhFdZ28lImgUc7Ya07XsXo9JmD-P5O
    aBbzSXY6Bd9KQv0hQ>
X-ME-Received: <xmr:r3s8Z5Iyb1mbB3NbDo_X5Ux4tZdeWbsVLWnx063Hjjzc8oh3MWG9ehJ_Ph1EJe4WCKqTdO6AFoQDpd4CdWVd2LbVIORTaLUcwQGQ8Mv1oaLES-E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhr
    ghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvshgthhifrghrthii
    sehgvghnthhoohdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinh
    gvtghordgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhp
    lhhushdrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:r3s8Z1EgQ3tRW1GOwe8ffLuXOSV_6bqQodKBtOmHiUHt1qJ547T3uw>
    <xmx:r3s8Z9VMjQ-5rCVdSaFoNqEeKtMeQqw4CGuBxLsC52AdM9yeAMdUTQ>
    <xmx:r3s8ZwOxc53WGFfG5r-orFhO9kkVrL3XB98ffZ2FYsCBU5Cnkv-t7w>
    <xmx:r3s8Z82hrDZ-y8qC3E3vSt4d-PzI9S09-TCm9xhjxFCkdggSgSgL7A>
    <xmx:r3s8Z2O-ZE6utsE4x30wpLJpMQiQ6-o4UxGi7Eaj7hETnaY-43xAOKa5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:51:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9ec9a886 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:50:55 +0100
Subject: [PATCH v8 18/23] Documentation: extract script to generate a list
 of mergetools
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-18-809bf7f042f3@pks.im>
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
index ca59581df65ca478910321fc937f98b23d597bd2..7e3a6e1b32fbbb0a0308bbda125c0abbcdb121fc 100644
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
2.47.0.274.g962d0b743d.dirty

