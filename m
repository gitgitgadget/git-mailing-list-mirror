Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D11C1F3C
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810362; cv=none; b=TLgW5VwuqxD4zKPQpC8GapAl9mSdhbc8VZfcl/1RrspCETLCtzO8HyYx/CKx3qDO4Mle07FLuYyN6od9WQqt0yQzSXp6mtuMFSM8YxtsPWQBr6HCAU5AZ7EfeSt0XZ8O38QJpc6WyE0lEdVxCKjodlqADEjbo18vHpMtwUxsdIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810362; c=relaxed/simple;
	bh=y2tSY0K9cGLAhGYUbRsZMzypk79O0z7OrOjS/jXLCDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lq1mAyYS+6xEgJnOofQerhWxtR8f+QndOFaeLnMKs9iCM/lp871phcRXkxNFz/TCOMD/ZwbhMp5obXYtnQP3+e9NLGb5o/arvbPKaX6kUA5hKtq4WdZXLfSASLvUbh10XBS7EbF6srkuHxXuHpHYjBpEwmttUWQ0qzeo4d3bGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zRTcwvS9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H67qoja0; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zRTcwvS9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H67qoja0"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BA8E138039B;
	Thu, 28 Nov 2024 11:12:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 28 Nov 2024 11:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810360;
	 x=1732896760; bh=5K0p4aDWtQsqoQWL+l6ChV73Jp24jOlt6cWLXh2fuJg=; b=
	zRTcwvS99SEFoCskH1eSNuq4dWHaU3v5Pec72pxxcVutW5RKjnLKaBRts5651RHu
	HlD/d0lPCJ++vs41YB9SVks7KLUtKAfKwcM8iT/0f/4B4N1yIW6NFUSWG91mpYxu
	rC7jo4WrFXGVl+gUNvvw56aH+S59rNu7UA9RafA2VaukmuygKxM5u5ZbE5/j11G/
	/+mwcEyl4wHvZaj66sPe1qipGngG2D8cGJzySQT+L4zyX0Ma8D0mzRfK7tzAUajI
	XN0OtEglWgOjOJLirb3IQ61ubJ0WLdS1q7M3deuPmsZutgWQ6Wcn1z77vFGr7DVd
	rVdP11dyoasErTtIXmkDiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810360; x=
	1732896760; bh=5K0p4aDWtQsqoQWL+l6ChV73Jp24jOlt6cWLXh2fuJg=; b=H
	67qoja0t1CP1448GZztHZNIMAeAMusgveg4VjUL1yhQJOVcaNnGJ+yTSglC/7Csi
	x5zJEAh72jk9pnLCtGbH/H5MQi7oswyn/L4S/wP1z9SZfuqHH8Rr2v2XI46QEKDa
	nfGrlsVMuOD+VLozQzIYJOQjwSLfUSj2X7FKQhceI9IT0+0NTGZjhX2cXCcLJYSA
	qxSxBWUQ9sUt9ekMfJ9tKksCOIlxJWckuY3MdpITT10PEk53e1k4uTTO02002nkB
	Jlpca+vc0QXle9jzPgTT8946QV2fL985bpCoypl7aKtwcvqydq0yA1oYHOVtzMdX
	+46L29r4JpVWaaI9awy3A==
X-ME-Sender: <xms:d5ZIZ1GUn937aR7mYAv1Dpjn4IbrmgV2F8GuzTwaHouOGLc8zwocUw>
    <xme:d5ZIZ6UI1fzxilZ6saAH8z78yguRD_jqcS2-gJDRvfi2doS0ULsn15L9AG0ckABzN
    zBq72YDLbPVhFagRg>
X-ME-Received: <xmr:d5ZIZ3JE9RErdABgHlz3cIHRUa3C7X3K7BV0if3yEm-t1YM_5_ZXDYnCofUDtvbfmxHmgtjXuQZIy3WYwcqgkIq9ax6lpJE37I22cHRR4pHp2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhes
    thhugihfrghmihhlhidrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hm
X-ME-Proxy: <xmx:d5ZIZ7H85zrljt45xQbIiNxZklsw6Hlo0alM6osRs19XIeyU0gh1oQ>
    <xmx:d5ZIZ7VhPS-_Ka0V8vRK5nOOxOmsfS5Uf9TJKfpFNdwedOyZxsfdNA>
    <xmx:d5ZIZ2PUrcxBUQfMGky6Tg7gffVP6dpjxtjNYIJmgnfTHxOt06v_xw>
    <xmx:d5ZIZ63xtWofYTPaeA7f7iAhNegqtJo-4da-q2JJKb0kuBByMfzqwA>
    <xmx:eJZIZ-PFPe8G3VxIe-A4H2haTS9AIUKZrE418D9062Yp1WkiH19uMmV_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 346575dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:17 +0100
Subject: [PATCH v10 16/23] Documentation: allow sourcing generated includes
 from separate dir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-16-79a3fb0cb3a6@pks.im>
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
index 495c61c85ed18bc9c4643f9e5478e5146bb5f196..c3d5ea1d46a57744bcacdc63b6c97911607e9fec 100644
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
2.47.0.366.g5daf58cba8.dirty

