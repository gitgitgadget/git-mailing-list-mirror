Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28E4683
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339078; cv=none; b=U7HCwlTo855koOwbNWZa5SzkgQnN0SYUokcKkK3SZXEQUqu0s23cz5gFQ01ttcMgTsUaCG4+AimzFNd3UaSJY5XoDaEnWCduQIusvMFd4slRL1qvX+4xc6ndrYRaERnSbT+vdqgsVuJAzFFg8+uBz10AlcABjImIlILlWNv2UQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339078; c=relaxed/simple;
	bh=qXKPddySCWhj5wifiLpttRUJpxzImS27fLEtFAMr12Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0jlUessx+jQJxIFzjlqgttugUFVDyz0fznILugF2fcVnh/MK8fftLCMasi43M0WG/mWZM7SEWbwbrPVE+Jo7AtwqJ0t8dSsqbdwuQEjjKcjo8iUfqZi4dO4MUTsuPptBnYHPoCrFwKkf7uy5yTBdflczBHIPtOGusS2/kpR0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vKAejNka; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F9apyptX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vKAejNka";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F9apyptX"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 51DD411400C0;
	Mon, 11 Nov 2024 10:31:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 11 Nov 2024 10:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731339076; x=1731425476; bh=kHIPtqdx54
	dlTXRlY3v0NU7KhL6NnbIQwNj58ETRdVY=; b=vKAejNkar2L9qUbV9TWFcac8ZF
	Um70Ow8Ar3PiTbQRcwKGEpwnXzVfsZP8wEfE+tfHS7ymsj4fKNgEtvsM0PfMn4cJ
	WDS4jXo5f6jGIcIDuSfpjisrlybazrusma7ymsKblQnPrxa3XK0m3wBhN++CNdGA
	kEdIQBYtRV31RUJ8r1CAXWI4AmVBOPC//Prv3xONzMHrS2azwGh5KB23YnltXc0E
	Fql8Krk9eEcYacOaFHxTlXY52dh9yBOpDXcR1bZRNeBfkF1h7INIjD5mrmeNEbUE
	CzpjTuHo5DCtmq5ozLHoxj2QLWDnzyM4V52Ytihl3hqSRZbg/pdPkKFbBdJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731339076; x=1731425476; bh=kHIPtqdx54dlTXRlY3v0NU7KhL6NnbIQwNj
	58ETRdVY=; b=F9apyptXjPL1Z8u0jtS8nS/cGqaTHQZdqpdBw8qM7hH9bmve9AZ
	dEeDs+oR6gIKLdTpxqk9scVKf+TNDVOsdoKaUgqUZkjRtB7N3hbbgb2az6jgWct5
	j4gZcEpo8+01aDIPUUNATuCW3E1c+nUCFFo+kPjGlRfL89pWm2cXX4mXDH+BrSZw
	VxWKDW8E97zawUNPK9Gaa6f7iqxxXljZ/Fu2HV2Bp2VvbYsUhF79Cur7505JfYLh
	+buKTQ5UgGgBnFfC1d8Dxk0IK8+NlATkHGMZCHXlHYpUJtHZaio3VyA6rTbjYUw/
	m9jMq8s0hUwv/dm1XjmoyIZx31LFzOUCysw==
X-ME-Sender: <xms:RCMyZ6sF0dJoZoitbxoJpgRUNgHNGkHyz1YCPkMSDTymMNTcbP_GbQ>
    <xme:RCMyZ_cnsVnppUbsJm8OON6DDL5NAPTBWuLSVvpLS7XbwUdHuELeG5BS66iWKw52g
    f2Bq1vi4-hF7O_lTA>
X-ME-Received: <xmr:RCMyZ1xGalu87QUHsyNBYAkjXfDQVCCiPlXQ_e0SbDQZjdWDmiMen5h6d7I-MNplV5tXz2gtaq6fBRQbm1eMy2pB_4wABv37cgOzL9epfWw1ryRu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmh
    hsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfiho
    ohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvg
    hnthhoohdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RCMyZ1MJKlGOx-4pe9_9jNqWAmNSkT56B6GOHWLLkxNjy1bBoQ-CRw>
    <xmx:RCMyZ69ODiLgaOdysshVlbkJcmTzs6YfF23211cBRtXgYGElIE0tMw>
    <xmx:RCMyZ9VWAyfW66TdGvF79jlah0Y-vPBNVyNedVBtCF2StRVijZUVKQ>
    <xmx:RCMyZzfoaNEvCCJ3_7PPYJjV7BmlQXrXgg3Aj15-6htqCI8rmZoMJw>
    <xmx:RCMyZ-R956MEzdmCGNfIswBqzdWgrKsjw8YV_f7oh_vTQ_90CvubJVQw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:31:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cb6c5da4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 15:30:40 +0000 (UTC)
Date: Mon, 11 Nov 2024 16:31:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH v5 12/19] Documentation: allow sourcing generated
 includes from separate dir
Message-ID: <46667dc608c62bc1af820c18804f7c36e3a419e4.1731335939.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1731335938.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731335938.git.ps@pks.im>

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
index 0f55baa252f..75755ceec18 100644
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
index 1b3ac8fdd95..315efaa2fa2 100755
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
index 190bda17e51..9575af91fa5 100644
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
index 8851b6cedef..82554d65a0a 100644
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
index d15a8697625..44f0797ccff 100644
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
2.47.0.229.g8f8d6eee53.dirty

