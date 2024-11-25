Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E11319B5B8
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528652; cv=none; b=WDt2un8Zw+Fu9ETUbtJSCfnWdPzX7fVjedX7B7FUV0wNossCtYAsaIP3PpXmBV9cc+OP3BCUbUGd+amRx0JI9oYqVeVgeOW6gOJv76vcX/+uIRYFbKxruEINEs3OFn2C7XWRL/OVdsRdjRW8l7uTu1U+Hy/65j9jxWLv1lXj3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528652; c=relaxed/simple;
	bh=NKWTPBze+CTwEcmtTTuxvy0hWEVUllnj3t+m8XDQmZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CQ/4RiNdDGhqSIJK9c1Qo5lWse4a17/kkUZCL+pGGaMNOpUl/bfEjAIllehHOSbW8qu6c+BLFMV9raFxDZRMOLFBJkAxo8KSb307F+TpT3KhXeS9RGv+JsVv4FfR0iPJRmZ7ZuuH4qZYzqC2jsaAE08+eQKXZivUksSKMnZdJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WI2cG1Vc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MdY0qm1F; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WI2cG1Vc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MdY0qm1F"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7760D1140164;
	Mon, 25 Nov 2024 04:57:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 25 Nov 2024 04:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528649;
	 x=1732615049; bh=hZBzvADWzIIySSNtRDR1ctbBrynjEHKZQmFohRXz3nA=; b=
	WI2cG1VcYkqyz60Z9XgvCJ1C4a9CAKGuVRzlgkU46bCol2+JpGtFYIU2e7bX8Sf4
	lkCos4i5L50bJxhJh7ClvPQy5i4WdiYwKuuAVE8jq7++aa3Z9IQ0dar0sKnzqW/t
	lvREEuLZLRYF/hiyPNgQzFjr9gXEE88fD633b3iAcZ/ykAKg80PvSJGBpaVHVJCz
	66vIlJULM02vyKLzg8BAiN8T2zhOjHYrMZd8SYBde1qtqLgnLbVqBb2oj1avLYFS
	R99v6EBwtCdv7oC3ycduBcVDXZZmvY6d8cC3c9LlM0TQR0k7WMAy9fUkK7Hh3toU
	omsjHWNR2kz23oGih3O+/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528649; x=
	1732615049; bh=hZBzvADWzIIySSNtRDR1ctbBrynjEHKZQmFohRXz3nA=; b=M
	dY0qm1FJvujvqSaX4rbEB9VFKLaGAxbDEonkbWafxO1f84qHwIRkoMuKAGvuKJNB
	ZZ9K7KeX321ma/Bau5z+m85PXPu5+VfrU9ni4mMkbauHUYyP6e7TLWNCfWRJvhZ7
	MCpFE+xz4k6WwKuLz8C9xynjlzlLjM+JFb5zJZv6yhynEW18oURp5jHR3srzYOoy
	rO2QQ2kIzDujAiRBETcizDjU9Ob20OXqe1zlniqF6HzBRZRc3FidKd518oQMQqzD
	zMmFLcpn83JlsNFpDwEoDKyB+ErnqwUggOCkDWXRc/p3LjVdqAcAizCAQu7btVUI
	dfmiuLbFrRyDMyYoYj/Dg==
X-ME-Sender: <xms:CUpEZzrGIg7LND14IHsMP_qcl86tCzBzV4E4UQqqWNTUZIeG_yN81g>
    <xme:CUpEZ9qeVJTbfO-FUZ-s7xjUkt464msAUZY3Y43sgMHdQkpXAJ4YwK16oyU65phyZ
    Y-PLmZZQ9ThvdvWPA>
X-ME-Received: <xmr:CUpEZwPXF6OyvdtkdP06NBTqhfPuQDlN2GLdKwqXaQ_E_rDnzjdE2fMQ1iv2t-rcMdhziaMFrtjB5VNbjegyFA_JqWD3HJkk518p-2DqKcUhqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopegurghvvhhiugesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:CUpEZ26q-vHBR3ZKHkPrefXJmijvV80_XBIcXhgLNkm1grmB6KQO-Q>
    <xmx:CUpEZy4phfqg8S4Z-x41XPaSQ1ay3ICkpLONqyeeP-bJ2IdaNsc-1Q>
    <xmx:CUpEZ-h4AKlMQqz-qFCQxhPx7drdI0OLPMfUsHaaam_m_kWAkmdGug>
    <xmx:CUpEZ058UXqiIniq0rt5rZKJCYI8hPCxl3YZ3urEk6AuVH1JtuJ0mg>
    <xmx:CUpEZ6iVxvH8_3bFur0NKRYkuCM_tLQMvMoZwygR4O_MXqHRJdThWnOj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bcac4a3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:57:06 +0100
Subject: [PATCH v9 18/23] Documentation: extract script to generate a list
 of mergetools
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-18-1c6cf242a5f1@pks.im>
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
2.47.0.274.g962d0b743d.dirty

