Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EDD1ADFE0
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079751; cv=none; b=eeE62z1lc+kVBaXeyimJB/xQzTfps8aYoYV3Kwd3zSbB0n0KYGm83FA9RWSUz6IW7581b4xZ6J/VZBIKE0oJV+8JeYPsQvIAC0hsx1bSLWDTWk3/PAU62IkIhcuWNsXgXFj08F9Js0cu1QsV/wGX+1E6jabO+9Tf3L77q/JfQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079751; c=relaxed/simple;
	bh=wp54G6SaFXxkfMFeBttPsCjTKjxmIqisv35avsAv4Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QgX3N86jMIBjJBpKjdO0z1QN9Z4FB41t+3RTHO9BbkfIPX3lFcMZg7RH8cHQ7xzqM4JtOMEf4PWtJKT7bZooXiB9KdxfIq65IKS+2d/eDU98v4MABpBXOHhrNbAoXEUC1Lhz/9k1jL7mg9Xq6isXPfxHXdWO5/Z53UaZPBFmaoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wFxcG+fN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P/QdmxYL; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wFxcG+fN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P/QdmxYL"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CE8FA1140201
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 13 Dec 2024 03:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734079748;
	 x=1734166148; bh=Q3OzV71y9vvRYT9EGb6/D14nQ+vKTLUng/VQr70AXzg=; b=
	wFxcG+fNQ1Ozx/8l8JzmWEdynEcEpfHcguSTZoPrzN97cFxWryk+y6kDRJp6BojS
	CqxxLptjby/G4bcfO+2ubbHRZpfoLGh9eoKH21+oPCi1ykgjI2R/qY8yMR6tip4w
	THpWRo5lxhRLK1Iii749JLmzdsyqpbIMOxcWg9GwkRp/ifjpb2300U9dHwm07VoH
	ReHqTCyPc/5YmJeyRDnA+P2GCJymsuL3YaYj5xlKVQ26N3FbYyLyVr5EWMnmUSrY
	v26DBS1XnI2RuFDuxbX2TZLfcNFPAR9TYpwDJqjaj/2xm0O20CULjbk4pgUl5Pw5
	6m9OiuygA70KM57j54CMxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734079748; x=
	1734166148; bh=Q3OzV71y9vvRYT9EGb6/D14nQ+vKTLUng/VQr70AXzg=; b=P
	/QdmxYL0s4Q9/6ECzULbk51fwArcoVKzI5DRlArePtAUP5Ljf8XJYlMNkgpHx2gf
	Qx3W1udOyLqsO/9NoPE0Dc/CcxcF23IsVGEOC9n8XgQ2DtxNrLvJ6D594Gj/hjQZ
	s4mup09LHZyA1yTeNk4Evn//pUVGagnEgwvh+bGxNQwNUCH3oQvEjdaMW85d7oPE
	/37XHPoazgxAF/57sLTCk99PqsCuWGLHdDWzdNiStEF6AMxEsHG3udfsJmoLqruP
	E1qNXaPZTLsFA5uD+ENHi2uLBH2EV5dkh8ZowZ98NjSw8ECB2oZR5aLtHymFNEMV
	ZLfa3cwGEzgeVPDeB9OMg==
X-ME-Sender: <xms:BPVbZ09d7zCgRZbGvaTyXklmJ3Ks6c8donygKghF5znL0xJ4TS3IgA>
    <xme:BPVbZ8vQibJIiaJrbIhTm04dIVlml3Dn5EywQp08bAbjaiiEmQO96cgDdryql1PhZ
    1hhka5xIZk1o_e8-g>
X-ME-Received: <xmr:BPVbZ6CgyFIZcWZI370IjuL7r3aIh8eZTSAm9AZIPH370g2hXg9Upm6A9d6PPN6mOjoORQ3FJybWdf9Pr7XAqIs0QaVWvQj8L_Uv9DQRoOtnA94>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BPVbZ0eQH5jwAVmv4RCzVBDO1oxSbGXS4sxgNFVkv9vmR-kOhD_Wrw>
    <xmx:BPVbZ5P8x_As-Zu_gDYnu_vFG9szeXjODEmHYN9O8UctFF5WYCHnyw>
    <xmx:BPVbZ-k4fQQFDAci6QA1aesbfx9v3EZ1sBss2k-MympjxtMcLguD-w>
    <xmx:BPVbZ7si3GF13pEj7C7HIJAelOFk-9Wdxdukt1sJZIagqzt1U1J7vw>
    <xmx:BPVbZ329R0XK2ixy9iQEbfQhmRmaCzZGSrt8PG3v-ugce1HOmZcaAQEp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5813eb25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 13 Dec 2024 08:47:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 09:48:37 +0100
Subject: [PATCH 08/10] Documentation: refactor "howto-index.sh" for
 out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-b4-pks-meson-docs-v1-8-0c7895952cd3@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
In-Reply-To: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "howto-index.sh" is used to generate an index of our how-to docs. It
receives as input the paths to these documents, which would typically be
relative to the "Documentation/" directory in Makefile-based builds. In
an out-of-tree build though it will get relative that may be rooted
somewhere else entirely.

The file paths do end up in the generated index, and the expectation is
that they should always start with "howto/". But for out-of-tree builds
we would populate it with the paths relative to the build directory,
which is wrong.

Fix the issue by using `$(basename "$file")` to generate the path. While
at it, move the script into "howto/" to align it with the location of
the comparable "api-index.sh" script.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile                   | 4 ++--
 Documentation/{ => howto}/howto-index.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 44f68e7a53843dc5ea24085d5f48b592d34aec41..388b5ffef99f696948042ad2bed87d573fbd4e95 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -416,8 +416,8 @@ gitman.info: gitman.texi
 $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@
 
-howto-index.txt: howto-index.sh $(HOWTO_TXT)
-	$(QUIET_GEN)'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(HOWTO_TXT)) >$@
+howto-index.txt: howto/howto-index.sh $(HOWTO_TXT)
+	$(QUIET_GEN)'$(SHELL_PATH_SQ)' ./howto/howto-index.sh $(sort $(HOWTO_TXT)) >$@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
diff --git a/Documentation/howto-index.sh b/Documentation/howto/howto-index.sh
similarity index 92%
rename from Documentation/howto-index.sh
rename to Documentation/howto/howto-index.sh
index 167b363668b8b53d752d5971798d3ca26c8f7f1f..eecd123a93607998e8b4eb8511f4165973f9d93e 100755
--- a/Documentation/howto-index.sh
+++ b/Documentation/howto/howto-index.sh
@@ -48,7 +48,7 @@ do
 		file="$txt"
 	fi
 
-	echo "* link:$file[$title] $from
+	echo "* link:howto/$(basename "$file")[$title] $from
 $abstract
 
 "

-- 
2.47.1.668.gf74b3f243a.dirty

