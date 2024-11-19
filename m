Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226A1CC8BA
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017072; cv=none; b=OwBDV/0TcbSiKcaEkk7jieGAbkueRDnS6UEu4+vt1RXYLpqF+KxTCNcFcn/7sf12XdRbldHhrGGGyV/rcglbY3Kl86Aw1mZOPM9zDh8f+VvnOuT7vSvAm20OkJVLuf3rIVtlic8EtcRn0k51RjPJAFbwP2WequdJUj+YM1oy8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017072; c=relaxed/simple;
	bh=5B6UzjYO3sQVAEbt38MGoViqOM/8vj4AVXa7kyGxSdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lJViXy0anYnfmrNNdJQK8JAuKbRy0Mzfw1vME22kL9x52JuH2TS0/ZujyRqUUDHChPbSAjlrVKBRh0e7iObY+iuJStN7xCs0FGdzapAREwiB5ksfM08G4qcj2hkEo2/Wqm8VRJGWK4gJu3nZDtjFy1PZz6QyqTCC6TT49Njm7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EKUnyJJs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MG5jHA//; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EKUnyJJs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MG5jHA//"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 589E213805F3;
	Tue, 19 Nov 2024 06:51:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 19 Nov 2024 06:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017070;
	 x=1732103470; bh=l/Bj+F4DpOaSi83BZu7gsZ4rBZE1YnMP2oW3Cu12cps=; b=
	EKUnyJJsDmt6v9FByM+InU3rY/QA6kjKqCGRXl5e6aA8r/bQuSwBoo+qZPKt+0Cm
	pHnYOr4y5oi9nRzB9Dtg8G/mllxvyTj99AIHK1WS9FX8kdhp6oh95J00aO1KE2dg
	5Ai540yDFKh6rjezXR4gANrSa7OyLG4CAIkQOEVfGhnvY2Vc7N2w7KwB8R0REmJk
	A+2OT2XU8R8k7cVb4QAs5wlvFk4b+tmkOHQ8xoWsvr8eYcuEZLGhqDQ4hw8ydP3r
	Qt8lg7J316vJctVWfHMLE1wGQQxIhLphQjB5CDOhipCNnupafK285mYv/ggmxxYS
	MhuOe91wCqfNGqIUg9JydA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017070; x=
	1732103470; bh=l/Bj+F4DpOaSi83BZu7gsZ4rBZE1YnMP2oW3Cu12cps=; b=M
	G5jHA//cD+JVs+i3ymM7BhPt29HV6qteeMtsFJuSDdVDmf2EEwsG+oU9/FVwHEMs
	fK8LiyItrdsIBkdGx+Fj0L8sgP8rAUrZV05jchQAhGIxjBm5Im8mjHemVM2HFGvT
	lbTD8fQdzGE3OC01RzceFkQF0mUjRghvVYkQFsGExKGRUTumCsIsUF4FmueMoAOp
	nlQy2dcUIH8Yp4/l6CedO3qOSKUB+XqNZAcxgDRp5Vcf2LIvOh2s7Dq4BwqysN48
	ARXdjGcNnE+H5k0Pz45ZORhyOv6qoHcZ7TqLEwHke1F+NkXfJP4bjCEDc0Gz40p7
	AhLneEma/txDQLZZdA28A==
X-ME-Sender: <xms:rns8Z-tnPaEBhURyIu93GZIhMlBtZ-s8rxqtzclajbID3WUrAwm1wQ>
    <xme:rns8Zzd9HLE_ZEaPTfNucbmUr-unB9J5zFG69UEVBjKvM8cdzt3MVzHS0xCNyjY-e
    UKJ2OPhHwMODm2aRQ>
X-ME-Received: <xmr:rns8Z5wStRmpxc5NTKNCOknFRRD2cxF8l39riQwAy7VqVdQ-wTUzK9Ig7ghhhf9E5hRPov14-SzmEUBwpKt4-UAIMCSUhTKq0TdFs45iBIw-aB4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonh
    gvshdrphhluhhsrdgtohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegthhhrihhstg
    hoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:rns8Z5OAhFVsx0swobxJ-9rmrwnab6iAV5ZX_5_WvueOwM5JJHj34Q>
    <xmx:rns8Z--UtrLahl84Hwk3zvlujjdpTYj2p_PPu-SU4O9AEQhoBPhTZQ>
    <xmx:rns8ZxXAxjAE2Q7-LlQ7iRUabYKJHh1OGWGJYfGMAYsdO62NDDJIoQ>
    <xmx:rns8Z3c4LBF35d8kRiLyzCJk9FVAC_MPjlGe9k0hi3Yb_EucIzj3EQ>
    <xmx:rns8Z_1AOHqL6DPFiTZhfYIy8WKY_i3lgZ34fl_TIFKadbASaL8FkI3_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:51:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d2f964df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:50:53 +0100
Subject: [PATCH v8 16/23] Documentation: allow sourcing generated includes
 from separate dir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-16-809bf7f042f3@pks.im>
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

Our documentation uses "include::" directives to include parts that are
either reused across multiple documents or parts that we generate at
build time. Unfortunately, top-level includes are only ever resolved
relative to the base directory, which is typically the directory of the
including document. Most importantly, it is not possible to have either
asciidoc or asciidoctor search multiple directories.

It follows that both kinds of includes must live in the same directory.
This is of course a bummer for out-of-tree builds, because here the
dynamically-built includes live in the build directory whereas the
static includes live in the source directory.

Introduce a `build_dir` attribute and prepend it to all of our includes
for dynamically-built files. This attribute gets set to the build
directory and thus converts the include path to an absolute path, which
asciidoc and asciidoctor know how to resolve.

Note that this change also requires us to update "build-docdep.perl",
which tries to figure out included files such our Makefile can set up
proper build-time dependencies. This script simply scans through the
source files for any lines that match "^include::" and treats the
remainder of the line as included file path. But given that those may
now contain the "{build_dir}" variable we have to teach the script to
replace that attribute with the actual build directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile          |  3 ++-
 Documentation/build-docdep.perl |  2 ++
 Documentation/config/diff.txt   |  2 +-
 Documentation/config/merge.txt  |  2 +-
 Documentation/git.txt           | 24 ++++++++++++------------
 5 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index aac489d3b01e9ca08f24a7f604d4b8dae50860d6..d26d9b155dc511494da4124ee22630d02f5d528c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -224,6 +224,7 @@ SHELL_PATH ?= $(SHELL)
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 
+ASCIIDOC_EXTRA += -abuild_dir='$(shell pwd)'
 ifdef DEFAULT_PAGER
 DEFAULT_PAGER_SQ = $(subst ','\'',$(DEFAULT_PAGER))
 ASCIIDOC_EXTRA += -a 'git-default-pager=$(DEFAULT_PAGER_SQ)'
@@ -289,7 +290,7 @@ docdep_prereqs = \
 	cmd-list.made $(cmds_txt)
 
 doc.dep : $(docdep_prereqs) $(DOC_DEP_TXT) build-docdep.perl
-	$(QUIET_GEN)$(PERL_PATH) ./build-docdep.perl >$@ $(QUIET_STDERR)
+	$(QUIET_GEN)$(PERL_PATH) ./build-docdep.perl "$(shell pwd)" >$@ $(QUIET_STDERR)
 
 ifneq ($(MAKECMDGOALS),clean)
 -include doc.dep
diff --git a/Documentation/build-docdep.perl b/Documentation/build-docdep.perl
index 1b3ac8fdd95fa1d57afbdffb1a9743f36ed22fdd..315efaa2fa2f2efc89b2c8073cc97cd2cc83611c 100755
--- a/Documentation/build-docdep.perl
+++ b/Documentation/build-docdep.perl
@@ -1,5 +1,6 @@
 #!/usr/bin/perl
 
+my ($build_dir) = @ARGV;
 my %include = ();
 my %included = ();
 
@@ -10,6 +11,7 @@
 	    chomp;
 	    s/^include::\s*//;
 	    s/\[\]//;
+	    s/{build_dir}/${build_dir}/;
 	    $include{$text}{$_} = 1;
 	    $included{$_} = 1;
 	}
diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 190bda17e51c57a00b25bf98afa038b8a89e4ea5..9575af91fa53d3f67925d31e77b81222e737fc3a 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -206,7 +206,7 @@ diff.<driver>.cachetextconv::
 	Set this option to true to make the diff driver cache the text
 	conversion outputs.  See linkgit:gitattributes[5] for details.
 
-include::../mergetools-diff.txt[]
+include::{build_dir}/mergetools-diff.txt[]
 
 diff.indentHeuristic::
 	Set this option to `false` to disable the default heuristics
diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index 8851b6cedef980c106b9e86541862b517aa1f2ad..82554d65a0aa0826fdb53c5d834389d38f308e3e 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -101,7 +101,7 @@ merge.guitool::
 	Any other value is treated as a custom merge tool and requires that a
 	corresponding mergetool.<guitool>.cmd variable is defined.
 
-include::../mergetools-merge.txt[]
+include::{build_dir}/mergetools-merge.txt[]
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/Documentation/git.txt b/Documentation/git.txt
index d15a8697625d6b6c598a2bc774bf243675ab68ea..44f0797ccffb1a7359bee9c20182953293b70d6d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -245,17 +245,17 @@ ancillary user utilities.
 Main porcelain commands
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-include::cmds-mainporcelain.txt[]
+include::{build_dir}/cmds-mainporcelain.txt[]
 
 Ancillary Commands
 ~~~~~~~~~~~~~~~~~~
 Manipulators:
 
-include::cmds-ancillarymanipulators.txt[]
+include::{build_dir}/cmds-ancillarymanipulators.txt[]
 
 Interrogators:
 
-include::cmds-ancillaryinterrogators.txt[]
+include::{build_dir}/cmds-ancillaryinterrogators.txt[]
 
 
 Interacting with Others
@@ -264,7 +264,7 @@ Interacting with Others
 These commands are to interact with foreign SCM and with other
 people via patch over e-mail.
 
-include::cmds-foreignscminterface.txt[]
+include::{build_dir}/cmds-foreignscminterface.txt[]
 
 Reset, restore and revert
 ~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -313,13 +313,13 @@ repositories.
 Manipulation commands
 ~~~~~~~~~~~~~~~~~~~~~
 
-include::cmds-plumbingmanipulators.txt[]
+include::{build_dir}/cmds-plumbingmanipulators.txt[]
 
 
 Interrogation commands
 ~~~~~~~~~~~~~~~~~~~~~~
 
-include::cmds-plumbinginterrogators.txt[]
+include::{build_dir}/cmds-plumbinginterrogators.txt[]
 
 In general, the interrogate commands do not touch the files in
 the working tree.
@@ -328,12 +328,12 @@ the working tree.
 Syncing repositories
 ~~~~~~~~~~~~~~~~~~~~
 
-include::cmds-synchingrepositories.txt[]
+include::{build_dir}/cmds-synchingrepositories.txt[]
 
 The following are helper commands used by the above; end users
 typically do not use them directly.
 
-include::cmds-synchelpers.txt[]
+include::{build_dir}/cmds-synchelpers.txt[]
 
 
 Internal helper commands
@@ -342,14 +342,14 @@ Internal helper commands
 These are internal helper commands used by other commands; end
 users typically do not use them directly.
 
-include::cmds-purehelpers.txt[]
+include::{build_dir}/cmds-purehelpers.txt[]
 
 Guides
 ------
 
 The following documentation pages are guides about Git concepts.
 
-include::cmds-guide.txt[]
+include::{build_dir}/cmds-guide.txt[]
 
 Repository, command and file interfaces
 ---------------------------------------
@@ -358,7 +358,7 @@ This documentation discusses repository and command interfaces which
 users are expected to interact with directly. See `--user-formats` in
 linkgit:git-help[1] for more details on the criteria.
 
-include::cmds-userinterfaces.txt[]
+include::{build_dir}/cmds-userinterfaces.txt[]
 
 File formats, protocols and other developer interfaces
 ------------------------------------------------------
@@ -367,7 +367,7 @@ This documentation discusses file formats, over-the-wire protocols and
 other git developer interfaces. See `--developer-interfaces` in
 linkgit:git-help[1].
 
-include::cmds-developerinterfaces.txt[]
+include::{build_dir}/cmds-developerinterfaces.txt[]
 
 Configuration Mechanism
 -----------------------

-- 
2.47.0.274.g962d0b743d.dirty

