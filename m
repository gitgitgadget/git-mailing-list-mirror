Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428620E022
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491540; cv=none; b=qaKUBgmzpzB9EiRzmoABesdU/8NDUG7ie2neoWjPV0GP5xscd0X7ceBUO6iOhfm8ngYfcgp7yg83KCtnSa7ixSc4Ch+n31+r4KCWs3xoJFwTqBlfm/O4/PeU+vGke3qVfhZx7Epwp811KsXdbdy47dsnfjTBg4w1QmnPMYa9hgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491540; c=relaxed/simple;
	bh=4cmAegn+ZglErBucHTQ0lDfrAnlE7/DMH5urE5ZECQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+8ONbjkYHfClGCklKfyC3XUUyOttk/s+eCIsLcE+MTMuGkL4RzP/spUzUHEtFd/oQVxCUrwE4/2UfARKho8NZghzNGsqdcYwDMDu1ENul2c1DBGpgB/6WUZL3CxnqVahvUBo3adsbGVGeXiUwBbIMn+c55vqVoNyacxtwY9tqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mn8FYwwZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wZlSNqT7; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mn8FYwwZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wZlSNqT7"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B7F531140141;
	Fri,  6 Dec 2024 08:25:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 08:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491537;
	 x=1733577937; bh=dSYVQPah5CU4+/fTs1EgCL22ISD1q7tUuwhveHzQbDg=; b=
	mn8FYwwZS2UR/KovtJ0DmDwXhVx8U/4cmtvmaGnIf4iR7pNiHN3OLnqyPdecsmEm
	/8+vU6otRDJEblfJ9Qc+1uKkkuuFbFdQB+kcdDPOTKeBq5K/BS351FWVjkUjvyyf
	+hiX4ml9ijN3uuwluQVnGOo7UzgpfFRxeiTvdDYO5T+ZKlSPg95cUEiipS24JUMj
	J+o77q698AA7UtW0T/waaiTZliCIqj8/OiNnc//+rWjQEkGAcIfqE/4TXEb/gIs3
	/PRsxnJ+4BKlZ58ZRSYQvGmQI1wJvkvhWFS97JJqgHoSVGEXib0CSA4qFVFREt5O
	UpgexArPssd/aa7Gw4zocg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491537; x=
	1733577937; bh=dSYVQPah5CU4+/fTs1EgCL22ISD1q7tUuwhveHzQbDg=; b=w
	ZlSNqT7cL9jR5OycNDLKHzBs0eUyF6yU0cQ6qIIM1kZjHM2lJu4PAbNtRIuTmTX3
	R0BbEQryJ1UmsRTnL8drZo4bfmbBrDk5TOtRMdEAcn15e2UXoUDnsXFTkxwlZTJq
	l5r586uRPwxh7csIEnFM6gv1ZaV18P+CeJAKIY4ilGn+zmaEJNh25J/BiMhVkYwl
	q/BO8OOngFK+Kgx/nDmQJOWLxpcdg2XMKeJh5yY2HS0bqmNwQaRxFeguA0VvcrB4
	huztBvW/Pw/MzTZtxSeOMqwCMu3j1zXkuVWWpjUqfrPkmLXkr1eGi5lVw/s8kcCJ
	SYcRiQF6MQ0hqWp1AwRuQ==
X-ME-Sender: <xms:UftSZ3uysfQDxN7Lk7DRWpEUwg2rwJgqonq7d_xFBof1yB6u8VBLIg>
    <xme:UftSZ4ecXVFzVU4qtGT9tJx7RRuNqzerOSRZu7CuRbj8aJISciao0yUhTE-nScCzc
    vbaBw6pz7UIJGHa7w>
X-ME-Received: <xmr:UftSZ6xHURUZ7AIQfW0D8ntWTRKelXfPaWtqD6jPOfm0cFHJp0adr5e5pmcrOZhdLM4n1zJKe_BKJ_WiFYz3rr6l-uV3j2fF84fe3I3DBXin-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjiehtse
    hkuggsghdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdr
    phhluhhsrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:UftSZ2N4c5lYBEsJ6g26cX_X2g90rJk7sjCvfZfhjQbMYSx8SSOd0g>
    <xmx:UftSZ3_42iXPJABetSktbd9D2ryxaZ3bHFlAdloJIDR7aMB8SBrdcg>
    <xmx:UftSZ2WEeJGhmQR5ue7bcweQu_fL-AWdizqLn_Fe1KpaA8J-_jjQlA>
    <xmx:UftSZ4eu_Ez0GKXHW6NYG-Ot35QBkl_DpsQM7vtLihDkBApywG334g>
    <xmx:UftSZ2V6_PzwoYLrsbw7rC4HBcDnF4lMTybHWMzqKJ9r4l4KmaO5cxwD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f9cfc59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:24:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:53 +0100
Subject: [PATCH v11 18/26] Documentation: allow sourcing generated includes
 from separate dir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-18-525ed4792b88@pks.im>
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
index 9371f294254fb77c08a695daff0dd35f4073db4f..a74fc0ff3d3721daa991c675b3f1f212e6e1e243 100644
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
index 45f3fe855c5bb41472281d49d6b09f98dd374529..fdae13a2122935f549874b4d0af95f94d61fc886 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -218,7 +218,7 @@ endif::git-diff[]
 	Set this option to `true` to make the diff driver cache the text
 	conversion outputs.  See linkgit:gitattributes[5] for details.
 
-include::../mergetools-diff.txt[]
+include::{build_dir}/mergetools-diff.txt[]
 
 `diff.indentHeuristic`::
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
2.47.0.366.g5daf58cba8.dirty

