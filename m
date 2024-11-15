Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C6185B78
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655311; cv=none; b=j17T2TayXmC47F5GHCUf1KHlcorD6lBD664VRjaVy5mJuZgrfgFRZeU6mpUb7CrK6oqNzCbojYwoNqJdKNr9juIP2CBJnuYje1FIdrmWfWZbRh9NO2Cj64JvlmoagzXEnRmywfxYhB/sEEFJHpjzPln4QfGSz9dv51k3LhV2W5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655311; c=relaxed/simple;
	bh=PB4gCYh6iBWqyPvmV2vEqoFZrv7f4OrcMFwyJy3yLs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F4crmJuX8aLIG4Xm8Ae8E1DcEOEar2ubJmmn8Q0oXXFi3pbXP/1S+IyDx3eGbIa90A2GC84p1VNu1Z8bL/PpQgVyfKARssNtIidpTadlcY6xZZLP989cDDoJNzZcNQMYpIqFjN4qnTBlWp+z86QvpiJrzww66a74+n9BycD47os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dTDbEqj9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FU53RGZR; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dTDbEqj9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FU53RGZR"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BB2213806DE;
	Fri, 15 Nov 2024 02:21:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 15 Nov 2024 02:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655308;
	 x=1731741708; bh=Gq9wXMotVLWclVQCVlpbc9GK3l0zoiGL9bwhYqpUr6s=; b=
	dTDbEqj9/C084wIWRHeT22Pi7fW5kBFYR3b3DSkpo92+tGIG3zg5URjj9ZrXVT+E
	QukL+ZgcL4AYDMvmgMckNIKvk2R3n+1DIKNvQ3db3B30lVYZFbmKzRg30USZHMHW
	hURdL6f2o8kMsZH4m/5gsTqiCYZE9IBJk2ZsQN2J2lCGemZYNdfEPWUT1gcs/e6P
	S5zUayf5Uvatdh/p1EBOc9n52Mi9D0VN1CGR/62wrNix79yljEvjSE6vhdM16kQ4
	Du2AwvadQYXFmJ/43Gxq0bYRf+zB0tOzRyZnGSxi+HYzl+6/UjlXEmLCSG/iB8xs
	Ahnp3jDaBycAQRGLMtEcGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655308; x=
	1731741708; bh=Gq9wXMotVLWclVQCVlpbc9GK3l0zoiGL9bwhYqpUr6s=; b=F
	U53RGZRyrYO1SW10pdXiSzpdA4JiWy6qkLrlBvYRHZ5GNvaRKTRUwB7wL0hYFAnH
	eB7HwoCIJ8jawfcxdJJq6ne06ngeRw1TJQQdiL84eQlk9hqTpPJdzV2SlaI6eMaT
	2737oLa4XVH2thNQ8m4LnpYvR00ty2MWkHwb3iV/HhvK6sNSipO0ByWSf4eUR4A0
	ZAI7MpqhoHcgWTJJIgX/2jEDLEbtBcsZbHYBlJauJlRTtIq2HTVlGb4Flk34AcqZ
	kTz62lGajexYZ28bR4CmPUSaBQDouHMLsTRx4o4UQp/GZH96Ri0Mq6odWLOdsYwe
	g970bvGpOkWX9W1AUMaJw==
X-ME-Sender: <xms:i_Y2Z3endhujKfk5cA2c7y8FyOCQsV9Q4JQHOaXL3WZ59Y8ifNU2CQ>
    <xme:i_Y2Z9NTpCcc0gF_rmYvmiG4GMp4jhzlh-Ua9YwRLMYbNg_yHrRIwE3ncE_IqN3zX
    wTGv3Vbz7SpcjLH0A>
X-ME-Received: <xmr:i_Y2ZwibK7yWJVi60b4b0fQ3NGMDlrfyLMUKKBfwKMRhb-UCj8kNb6yEjhoeZq_6k99dWDflVLqA3dWRq5IbZn91cvaflPoQF8uD_ntia4iRLq49mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhn
    vgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphht
    thhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthho
    pegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:i_Y2Z4-eHWzyXaTFnoN5nvYbXaHqaNGYKlQ9pqI3s7Aadlp1UXXA5A>
    <xmx:jPY2ZzvBKA_OFJwRBwz2tEbU00LMY58A3nKdN9QVwA-fBbE7Cr3wvA>
    <xmx:jPY2Z3HkP98Ijbb0YK4-UGBPLauLzg29BjWkGd7ok0gylWMqvilTbw>
    <xmx:jPY2Z6NbO36Ug81rqRjv6oXqn8J1h3byAdZ4dDJWZBINib3MY1nreg>
    <xmx:jPY2Z0kY_mmbzxsJtKbXa4rji6ousMBTbIlYcOEA2Wrll7H7iwg9LhG6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0820fd00 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:21:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:29 +0100
Subject: [PATCH RFC v7 17/22] Documentation: extract script to generate a
 list of mergetools
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-17-47ec19b780b2@pks.im>
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
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

