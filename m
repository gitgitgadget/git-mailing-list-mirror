Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377218F2F8
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655310; cv=none; b=gH+P5sPpd/9ChYmPMMtU8YH16HEhFZo8OV8mn32XLzZddhDzvjLQeqd6v2QHVzAl9rLbgpH8OFtlz3ZN7+/rXja6v7zjRc5kMTUpirn9nSoZSdUeA5MIDqW40bBkiRSF2cpdtebWi2e7tB+O+QOJ9IGqh+73SgFGO2ht+X6d8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655310; c=relaxed/simple;
	bh=7ZiH1bpHY6W/piS9oNMzg20ZIGUvEZSFGsNo1cllAQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UhPyUR+KtqJ/b8dz5IC6m0SiWpgy05H5Zx6XzXw5LcXoGaVqpnqFHrSskKKzGc0cBn7DmvZScmU/xYhNfqU60ABGqX9DDv3jyEXIiwGq9o42kdSW9tfGNU7PnaEvnsUrG2sJjFWqvBObHIOQv2OaQQXNT6ZmQQN21B4NxEGSN40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bm+1Lev/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvNRYhlD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bm+1Lev/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvNRYhlD"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 93E7D13806D3;
	Fri, 15 Nov 2024 02:21:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 15 Nov 2024 02:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655307;
	 x=1731741707; bh=W+LFxFkj+AjFzAt9/cC1wTuXdcea4FCTF34KCsnVWNY=; b=
	Bm+1Lev/whG+xYUFPwqYHoJlDMA9teppr2VbbyiUxI3L5U1EVLsBqOpi0asUkH7q
	reoRw0aMRsaS+JXcefH7oP8gTC74dzJb6KXl2VODN/Xd70ZH74DMqar3ZgdrxLtt
	Ssg1hSvXUUIkkCBFlTO33GXzy1FVwQQtzP3WtE6GMalxnwk+zLS8jzruUJRuDj6k
	KCR6AcKdQNUmBL8cHQhZprX5Q6wxb/hVeRsR1ki3RjZvUyZ8sMZOqKYeTdh7DFWX
	AvGytxjGgA0e8M8MehcpBAy3tYpRVgmyI+cyvge8HE/55Wbf9fnwDR2W3fIv/rMJ
	eBWlMtD7zdgbunEkq4Ku+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655307; x=
	1731741707; bh=W+LFxFkj+AjFzAt9/cC1wTuXdcea4FCTF34KCsnVWNY=; b=b
	vNRYhlD5f0MLCYWWkrFYAPG6StBDut5QgDkN2a7GGf5Iek6YlMGnE8Pnvc5BF4Z5
	bQyfXmBzekkio8WB31q3VlRPCAgO6mW5aH1PnCntVgU8xCXHbFYtvWqOLTngwV0V
	9hIVfKkqTcnNiNAMQ4pG6iIIdGMU5/7+HXUxUn2SQCeE5z5BVjO5Xp0GoGqdHRad
	KCi9bHWg51P9nD8lLu/cPVQi98Z0W/XcKuQlMXqFIoqj4fA9sqqZfehtl/VN4xdd
	l9D4ABnHI/AREjGbAhjImcbXaII8TywrXp/DqsRQJcwFm51Di8jy50gSJWCrjvIw
	MpaBYCU/Ekyv0K7m3vvuQ==
X-ME-Sender: <xms:i_Y2ZxRfrPwLxND0ce2Wto9w1NbHGeoiVKOwbt-FD7NKjdKzx9DWUA>
    <xme:i_Y2Z6yPNrmDwQ-FhFDU9aHbfg6UjjO95_R31hm4r8kpMBA-SoX_UYVMMK23u-ynm
    83nl6-gbkGkDTDiJQ>
X-ME-Received: <xmr:i_Y2Z20MQHOo_UDPi9QVwoFddsoIgxtbJ1ctVx6BtXZ9eMJkxXZbkRh3KAj2vYO__i0yCgWB8TK-7j0ig8Dc9kqD_GL_-FVuyN_CZGWtO5X3YHRybw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghstghhfigrrhhtiiesgh
    gvnhhtohhordhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgih
    jhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugi
    hfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:i_Y2Z5CkztyDmOCzWfkZiK4kKJvwhNKJCpa-qOwBPFOnnsDDYJhlqg>
    <xmx:i_Y2Z6g12XwSRnTEJ7xAC-vgcZy6_63SXl6zyHZW-omFQSIW4LmmJQ>
    <xmx:i_Y2Z9pkd_b9xqH7GjQbhRNrco9ntOf9lkmlUvD5HCYwSPo-UgljMA>
    <xmx:i_Y2Z1heB61xQp5-rdR46VUUYSxAnR9hq8XZ6iRrQveIUW2LWrnyrA>
    <xmx:i_Y2Z_aBGEZWGnVo9T5N2JEV0MDAJpFbE5xNySsNuNxyqXTBnYMrYpkd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8d9cadd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:21:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:27 +0100
Subject: [PATCH RFC v7 15/22] Documentation: allow sourcing generated
 includes from separate dir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-15-47ec19b780b2@pks.im>
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
index 0f55baa252fffbcd506f0c6f410b26b37f2e9b11..75755ceec189836813e01fa43bae69bdd2083f3e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -218,6 +218,7 @@ SHELL_PATH ?= $(SHELL)
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 
+ASCIIDOC_EXTRA += -abuild_dir='$(shell pwd)'
 ifdef DEFAULT_PAGER
 DEFAULT_PAGER_SQ = $(subst ','\'',$(DEFAULT_PAGER))
 ASCIIDOC_EXTRA += -a 'git-default-pager=$(DEFAULT_PAGER_SQ)'
@@ -283,7 +284,7 @@ docdep_prereqs = \
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
2.47.0.251.gb31fb630c0.dirty

