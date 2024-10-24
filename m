Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416E1D5AD7
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773637; cv=none; b=FV2hDmbg++wze2hnGJvbaNe8Q+DqA6K6mW9qGUAVj5Bzhotr/fvp2+sTOJY+MGsWcj7Gpj9RUUh77n0hU+AakyPpACJ3Lj4v2grjK5ZZ2WulY167LbApVBJp+lFJpu+O5XVz1cb2MV900qU6GYBddgW/yeBimgT7VmZEk6i3BJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773637; c=relaxed/simple;
	bh=P4S7tX0csRM1Li3TsHDi+qB4aQWrgB91lMSeJ6rR/oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P68x3NBQvBhoUSHYXYKcp+qj2/+7+m1ocGxa51AArZvL1iRrX9tokFhz0RQUFvHgVzToWejXGLndQvAlYVZBai0k6f+wLtSXI0SZ+2tSuZKVipDN3mlgRqcDeH7y7jVAaLCvsibxyPLFEcXMmZcQAFngjSVu9J9jesMdk4kRcGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JCDTop9g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PdwldszS; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JCDTop9g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PdwldszS"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 01C0B254014A;
	Thu, 24 Oct 2024 08:40:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 24 Oct 2024 08:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729773634; x=1729860034; bh=8rjNf++A7o
	lk6RHATw0+oOMsJxTYRMo+c4bDKlnZRas=; b=JCDTop9gbg6092doikp2NYq2fo
	OdrG0LXlRtfYvFvFI63uYWUMLc54uZyD94jdP8Veao4tR9sjMDMYK3vX/ls2G+XJ
	zrJ725Iv3QLCq7XLb1WV+ZlWC6YwXFnn7dmmhWR8DFB8A/UnXQH++7ZPasnbqXAs
	GBPJWK5NuYIWV97Lqnn4T/GbvPww3TOqFs5agxCVwYn9rHLnlNb1guP5wbw9ExW4
	8Al36CMAT+QHzhqylDSDgxslkxm/urLF2h2Hpm4vpaPqbbeWBOv397E/v3GdW7xF
	CWJCSDNq38H1wtx7XE3VXz7oEbFG8nlaa46B+yYcBcar1foUe9/GnVHXH2LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729773634; x=1729860034; bh=8rjNf++A7olk6RHATw0+oOMsJxTY
	RMo+c4bDKlnZRas=; b=PdwldszSP7IkY3ia+WIoWzYaS+3sVYeCrefN8T5YgLjG
	PSipIOr+njXvjut1rm9Zh15QKSQsQv3H3cLqJ8ZzUW1ZVYsJVgzz7qqoYbUJMFGV
	XEuAAFJkLY6uvmOzoBxuzd7XwcTAKzzFHSMMZq6Iq0ypHZmtaDDKPHxxLLC7Bt52
	z62o8iKLfJvhsNFwwznYH9vCrYTLBC+eDD8+Jj5PvDv4LQmybc8UQft2IKBIuAgG
	CmlZmp7yPKArOojE/imIiG9rygu0ZRqOap4xBHDn4x8dV6C/51AZxF1o0vyGtK7K
	I8ueb/vk2BEO0yyUuDjGMfQZpzTwdje+DWErzkVu1Q==
X-ME-Sender: <xms:QkAaZ14sBAttnY3eNcRdWPNg8GYwbunfnLR-O96FrjTu-aIYc-qLnA>
    <xme:QkAaZy50QSNyfVQ2WaeiSQqFaV9Xx-E1axwXZUWKrKpv_bFhCTYigk9miHR-e1ZLu
    PiKzmjrd80iEVMhHw>
X-ME-Received: <xmr:QkAaZ8cjCMc8y8fskxl9YhulrQKH4FiwAzpWgbNuWZC08J-B1-yocYDgVu3q27luVTcQ0IaUuOIqBfxxQ0e2w-BlWTzeRAxysd_fPM2QL12iZ-ID>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QkAaZ-Jx8-Cp47-2lc2qYtO9qQKkRlLvYK5pVWAiThacqxUnxwUiHA>
    <xmx:QkAaZ5JNlLTKPmj7Q7PVBjd_1SlZjXiZQasPFQz8r4-E-I1i8y5g4A>
    <xmx:QkAaZ3zPVMAO7WwLggCWcvbbs4yjWe2CgNHJJi7koOmoQld8lgTPCw>
    <xmx:QkAaZ1JRc1fp9dezHodtKs2e4AcakkemnHzGm9yyly75fe5rqXozLw>
    <xmx:QkAaZ-plyE06D_2zCo3iQ22ltZdY5g0ScLpTDR3JsCG6yIhb1L-39cKJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 08:40:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5a578989 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 12:40:35 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:40:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [RFC PATCH v4 14/19] Documentation: extract script to generate a
 list of mergetools
Message-ID: <6926a282a80d521ba03047c0f05c7b868fa7796e.1729771605.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729771605.git.ps@pks.im>

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
2.47.0.118.gfd3785337b.dirty

