Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218F27056B
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399042; cv=none; b=kxwMwcdOdC31fC1MoKx07JTOuTKj2QQrnZ4tbwi6tT2izqyW8yASgOQkbAJr4zYAoytsrTlgbL9c3HKVKr5IGM9o6dqrCCmbd6B+3qbLvU0Jp5dfl2rQhWPfZ4F2Vtobg/nx6sZkbFoNCdCmbazA3EBShiaeztx5RcfqXCC+i9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399042; c=relaxed/simple;
	bh=0uS/5TsI2WRrFzgvlPXSKq32tnfOu96gsxElrkyb2Rg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=a2t/betbtlIoLsd8beLdBEjzhmO4X0HVEG6acl/mGvL7taJMW/GSSuyFv0ZG7gmmHd7Mtd4BWSWJN6fxiMORHOQcgY5QtQQEWpXBvEHH+3UWFvEeQY9Po6TmZk7yXMG+XBq/PycS+5wuNKnQG0oO1zhPlcTPqpJKGl2JEsSs0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvrd0GFt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvrd0GFt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b7823559a5so3269840f8f.0
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 06:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754399038; x=1755003838; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mUZddteVfB8Sh/kjvFeCLmTFQHUc7+PZOzKeApBT6c=;
        b=gvrd0GFtlC1l6Z6JnkoaoViqfooq2qh4iH6yvjZJbhUkMG+ALtEOReG8ghL707xP73
         u2ZNRGcT8B+QtBGc3XYQq0UQit3yJ0YQ71CXKnUHOooz0qmBjkAY0lNRkB8uVgvKdmzm
         xw14UY20ZZFT0oxQzRotz6kQ0Q9VlH44DGNeHGMOdysmCHnLZpLGYjV/03+UV22BL/O0
         OQTRvqEgooN21vfAGY4QUZA7dWGxfrEZhVcCyOqPCpBWlQBWo9NspiTqx3iBmYDsMBuE
         +gTudLbMdtOftA+aMyheclwviVh7NFdBHu02y8oyp3r5N5T9IPGnChtTA8J+MqpF2SmF
         c4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399038; x=1755003838;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mUZddteVfB8Sh/kjvFeCLmTFQHUc7+PZOzKeApBT6c=;
        b=PxMPHqhMgyg0My9qohS1/fK04gO1tGq8+rRnExtP5rorcJCo0n37Us8t4+rgd1Q4gF
         f4SMpyK853OhpUwwG2ywY/rZI8O+W9Rzj2kRlTHPLqyT2idlCMD99zeJnaPCppuI9IS1
         CswAiZjfEyEZ5uy8xICDIKjWOeK9/szrg7N4VpbHXZ5l+EGB7V+LPwDqALXERFF0KxsE
         2gcpKc50x8Kk3OOazvGLIPPzQ3YGtitY6fKalSQnDix7HEt//06X4Cco5dYN8WTiZ9Dh
         7JE/l/cOfBWjnszqHcd+7tNl0IKarchRAMO9nD6rqiSShUNN50WphYIHvfjIFbpxntK/
         FNCw==
X-Gm-Message-State: AOJu0YxlrPCrmBBuzoDk1CeSetdnqTl0utxwPmMuotO3/eCr10GJJDMO
	v/BNrMUwgmw+uQV1kr79VuA3tuuGterMFU9R/YrjG0rjTEcQ2hh8ZeQSYWyRzw==
X-Gm-Gg: ASbGncvjQVt0S0yqwstf3oyILkdchK8Ye1MlItDqsQtmluqepa8Q039wUo/6TqaAjLB
	rDdIq5KNIrFBE0fgTXIk30vi/9332pvqxCDSwR+fd8TpenwyYAb7ZNK3z0jed5WE10SpTW/EhaG
	9qXjk3dSDDZzkGoWTFIC7/DpxcI1gcsXp8Z6GrH5RQoUe8fdppctEpqqoR+OXCMUrQNm2cSaaEq
	0z7IdhM5j4Zpv1r6D3rqjChqDy7/PDfHTm6u+MEc4Tqqqr6wAFINlzZbFHPaBQeoNd5xJKJFv33
	Z5pVX/FKXyq3EXfQP7e16tx2d19YyQPZADObwHrgqZoz65y2WLxa8dS5B/DIgxCG0PWWttcTuNm
	mb7tBUN5A14W0vwc9cIqtA7ARqxQpwcZTlA==
X-Google-Smtp-Source: AGHT+IHvuVULHKin0b81pIZkGLOoGz4QakzsMqeS0tDtaaI/C2JsKTlqhOlGVaWCXKen3Oox/jHbcw==
X-Received: by 2002:a05:6000:2385:b0:3a4:d9fa:f1ed with SMTP id ffacd0b85a97d-3b8d94727e6mr9547689f8f.13.1754399037649;
        Tue, 05 Aug 2025 06:03:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4532c4sm19022633f8f.36.2025.08.05.06.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 06:03:57 -0700 (PDT)
Message-Id: <322df2d8dde35916f91601029c4db89837776b5d.1754399033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
References: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 13:03:49 +0000
Subject: [PATCH 2/6] doc: check well-formedness of delimited sections
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Having an empty line before each delimited sections is not required by
asciidoc, but it is a safety measure that prevents generating malformed
asciidoc when generating translated documentation.

When a delimited section appears just after a paragraph, the asciidoc
processor checks that the length of the delimited section header is
different from the length of the paragraph. If it is not, the asciidoc
processor will generate a title. In the original English documentation, this
is not a problem because the authors always check the output of the asciidoc
processor and fix the length of the delimited section header if it turns out
to be the same as the paragraph length. However, this is not the case for
translations, where the authors have no way to check the length of the
delimited section header or the output of the asciidoc processor. This can
lead to a section title that is not intended.

Indeed, this test also checks that titles are correctly formed, that is,
the length of the underline is equal to the length of the title (otherwise
it would not be a title but a section header).

Finally, this test checks that the delimited section are terminated within
the same file.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/Makefile                        | 11 ++++-
 Documentation/RelNotes/1.6.2.4.adoc           |  1 +
 Documentation/diff-format.adoc                |  1 +
 Documentation/git-commit.adoc                 |  1 +
 Documentation/git-fast-import.adoc            |  2 +
 Documentation/git-p4.adoc                     |  1 +
 Documentation/git-rebase.adoc                 |  2 +-
 Documentation/git-svn.adoc                    |  2 +
 Documentation/gitprotocol-http.adoc           |  2 +-
 Documentation/gitsubmodules.adoc              |  3 +-
 Documentation/lint-delimited-sections.perl    | 48 +++++++++++++++++++
 Documentation/mergetools/vimdiff.adoc         |  8 ++++
 .../long-running-process-protocol.adoc        |  1 +
 shared.mak                                    |  1 +
 14 files changed, 80 insertions(+), 4 deletions(-)
 create mode 100755 Documentation/lint-delimited-sections.perl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index df2ce187eb84..76a9e1d02b26 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -497,9 +497,17 @@ $(LINT_DOCS_FSCK_MSGIDS): ../fsck.h fsck-msgids.adoc
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)$(PERL_PATH) lint-fsck-msgids.perl \
 		../fsck.h fsck-msgids.adoc $@
-
 lint-docs-fsck-msgids: $(LINT_DOCS_FSCK_MSGIDS)
 
+## Lint: delimited sections
+LINT_DOCS_DELIMITED_SECTIONS = $(patsubst %.adoc,.build/lint-docs/delimited-sections/%.ok,$(MAN_TXT))
+$(LINT_DOCS_DELIMITED_SECTIONS): lint-delimited-sections.perl
+$(LINT_DOCS_DELIMITED_SECTIONS): .build/lint-docs/delimited-sections/%.ok: %.adoc
+	$(call mkdir_p_parent_template)
+	$(QUIET_LINT_DELIMSEC)$(PERL_PATH) lint-delimited-sections.perl $< >$@
+.PHONY: lint-docs-delimited-sections
+lint-docs-delimited-sections: $(LINT_DOCS_DELIMITED_SECTIONS)
+
 lint-docs-manpages:
 	$(QUIET_GEN)./lint-manpages.sh
 
@@ -528,6 +536,7 @@ lint-docs: lint-docs-fsck-msgids
 lint-docs: lint-docs-gitlink
 lint-docs: lint-docs-man-end-blurb
 lint-docs: lint-docs-man-section-order
+lint-docs: lint-docs-delimited-sections
 lint-docs: lint-docs-manpages
 lint-docs: lint-docs-meson
 
diff --git a/Documentation/RelNotes/1.6.2.4.adoc b/Documentation/RelNotes/1.6.2.4.adoc
index f4bf1d09863c..053dbb604de6 100644
--- a/Documentation/RelNotes/1.6.2.4.adoc
+++ b/Documentation/RelNotes/1.6.2.4.adoc
@@ -37,3 +37,4 @@ exec >/var/tmp/1
 echo O=$(git describe maint)
 O=v1.6.2.3-38-g318b847
 git shortlog --no-merges $O..maint
+---
diff --git a/Documentation/diff-format.adoc b/Documentation/diff-format.adoc
index 80e36e153dac..9f7e98824183 100644
--- a/Documentation/diff-format.adoc
+++ b/Documentation/diff-format.adoc
@@ -103,6 +103,7 @@ if the file was renamed on any side of history.  With
 followed by the name of the path in the merge commit.
 
 Examples for `-c` and `--cc` without `--combined-all-paths`:
+
 ------------------------------------------------
 ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	desc.c
 ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	bar.sh
diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index ae988a883b5b..d4d576ce665f 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -281,6 +281,7 @@ variable (see linkgit:git-config[1]).
 +
 --
 It is a rough equivalent for:
+
 ------
 	$ git reset --soft HEAD^
 	$ ... do something else to come up with the right tree ...
diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 6f9763c11b3c..6490d67fab56 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -605,9 +605,11 @@ Marks must be declared (via `mark`) before they can be used.
 
 The special case of restarting an incremental import from the
 current branch value should be written as:
+
 ----
 	from refs/heads/branch^0
 ----
+
 The `^0` suffix is necessary as fast-import does not permit a branch to
 start from itself, and the branch is created in memory before the
 `from` command is even read from the input.  Adding `^0` will force
diff --git a/Documentation/git-p4.adoc b/Documentation/git-p4.adoc
index f97b786bf98a..59edd241341e 100644
--- a/Documentation/git-p4.adoc
+++ b/Documentation/git-p4.adoc
@@ -66,6 +66,7 @@ Clone
 ~~~~~
 Generally, 'git p4 clone' is used to create a new Git directory
 from an existing p4 repository:
+
 ------------
 $ git p4 clone //depot/path/project
 ------------
diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 956d3048f5a6..727160c6db77 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -687,7 +687,7 @@ In addition, the following pairs of options are incompatible:
  * --fork-point and --root
 
 BEHAVIORAL DIFFERENCES
------------------------
+----------------------
 
 `git rebase` has two primary backends: 'apply' and 'merge'.  (The 'apply'
 backend used to be known as the 'am' backend, but the name led to
diff --git a/Documentation/git-svn.adoc b/Documentation/git-svn.adoc
index bcf7d84a87d1..c26c12bab37a 100644
--- a/Documentation/git-svn.adoc
+++ b/Documentation/git-svn.adoc
@@ -1012,9 +1012,11 @@ branch.
 
 If you do merge, note the following rule: 'git svn dcommit' will
 attempt to commit on top of the SVN commit named in
+
 ------------------------------------------------------------------------
 git log --grep=^git-svn-id: --first-parent -1
 ------------------------------------------------------------------------
+
 You 'must' therefore ensure that the most recent commit of the branch
 you want to dcommit to is the 'first' parent of the merge.  Chaos will
 ensue otherwise, especially if the first parent is an older commit on
diff --git a/Documentation/gitprotocol-http.adoc b/Documentation/gitprotocol-http.adoc
index ec40a550ccab..d024010414aa 100644
--- a/Documentation/gitprotocol-http.adoc
+++ b/Documentation/gitprotocol-http.adoc
@@ -318,7 +318,7 @@ Extra Parameter.
 
 
 Smart Service git-upload-pack
-------------------------------
+-----------------------------
 This service reads from the repository pointed to by `$GIT_URL`.
 
 Clients MUST first perform ref discovery with
diff --git a/Documentation/gitsubmodules.adoc b/Documentation/gitsubmodules.adoc
index f7b5a25a0caa..20822961999a 100644
--- a/Documentation/gitsubmodules.adoc
+++ b/Documentation/gitsubmodules.adoc
@@ -8,6 +8,7 @@ gitsubmodules - Mounting one repository inside another
 SYNOPSIS
 --------
  .gitmodules, $GIT_DIR/config
+
 ------------------
 git submodule
 git <command> --recurse-submodules
@@ -240,7 +241,7 @@ Workflow for a third party library
 
 
 Workflow for an artificially split repo
---------------------------------------
+---------------------------------------
 
   # Enable recursion for relevant commands, such that
   # regular commands recurse into submodules by default
diff --git a/Documentation/lint-delimited-sections.perl b/Documentation/lint-delimited-sections.perl
new file mode 100755
index 000000000000..140b852e5d46
--- /dev/null
+++ b/Documentation/lint-delimited-sections.perl
@@ -0,0 +1,48 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+
+my $exit_code = 0;
+sub report {
+	my ($msg) = @_;
+	print STDERR "$ARGV:$.: $msg\n";
+	$exit_code = 1;
+}
+
+my $line_length = 0;
+my $in_section = 0;
+my $section_header = "";
+
+
+while (my $line = <>) {
+	if (($line =~ /^\+?$/) ||
+	    ($line =~ /^\[.*\]$/) ||
+	    ($line =~ /^ifdef::/)) {
+		$line_length = 0;
+	} elsif ($line =~ /^[^-.]/) {
+		$line_length = length($line);
+	} elsif (($line =~ /^-{3,}$/) || ($line =~ /^\.{3,}$/)) {
+		if ($in_section) {
+			if ($line eq $section_header) {
+				$in_section = 0;
+			}
+		next;
+		}
+		if ($line_length == 0) {
+			$in_section = 1;
+			$section_header = $line;
+			next;
+		}
+		if (($line_length != 0) && (length($line) != $line_length)) {
+			report("section delimiter not preceded by an empty line");
+		}
+		$line_length = 0;
+	}
+}
+
+if ($in_section) {
+	report("section not finished");
+}
+
+exit $exit_code;
diff --git a/Documentation/mergetools/vimdiff.adoc b/Documentation/mergetools/vimdiff.adoc
index abfd426f74a0..b4ab83a510e0 100644
--- a/Documentation/mergetools/vimdiff.adoc
+++ b/Documentation/mergetools/vimdiff.adoc
@@ -3,6 +3,7 @@ Description
 
 When specifying `--tool=vimdiff` in `git mergetool` Git will open Vim with a 4
 windows layout distributed in the following way:
+
 ....
 ------------------------------------------
 |             |           |              |
@@ -56,6 +57,7 @@ needed in this case. The next layout definition is equivalent:
 +
 --
 If, for some reason, we are not interested in the `BASE` buffer.
+
 ....
 ------------------------------------------
 |             |           |              |
@@ -72,6 +74,7 @@ If, for some reason, we are not interested in the `BASE` buffer.
 Only the `MERGED` buffer will be shown. Note, however, that all the other
 ones are still loaded in vim, and you can access them with the "buffers"
 command.
+
 ....
 ------------------------------------------
 |                                        |
@@ -88,6 +91,7 @@ command.
 When `MERGED` is not present in the layout, you must "mark" one of the
 buffers with an arobase (`@`). That will become the buffer you need to edit and
 save after resolving the conflicts.
+
 ....
 ------------------------------------------
 |                   |                    |
@@ -106,6 +110,7 @@ save after resolving the conflicts.
 Three tabs will open: the first one is a copy of the default layout, while
 the other two only show the differences between (`BASE` and `LOCAL`) and
 (`BASE` and `REMOTE`) respectively.
+
 ....
 ------------------------------------------
 | <TAB #1> |  TAB #2  |  TAB #3  |       |
@@ -119,6 +124,7 @@ the other two only show the differences between (`BASE` and `LOCAL`) and
 |                                        |
 ------------------------------------------
 ....
+
 ....
 ------------------------------------------
 |  TAB #1  | <TAB #2> |  TAB #3  |       |
@@ -132,6 +138,7 @@ the other two only show the differences between (`BASE` and `LOCAL`) and
 |                   |                    |
 ------------------------------------------
 ....
+
 ....
 ------------------------------------------
 |  TAB #1  |  TAB #2  | <TAB #3> |       |
@@ -151,6 +158,7 @@ the other two only show the differences between (`BASE` and `LOCAL`) and
 --
 Same as the previous example, but adds a fourth tab with the same
 information as the first tab, with a different layout.
+
 ....
 ---------------------------------------------
 |  TAB #1  |  TAB #2  |  TAB #3  | <TAB #4> |
diff --git a/Documentation/technical/long-running-process-protocol.adoc b/Documentation/technical/long-running-process-protocol.adoc
index 6f33654b4288..39bd89d467d6 100644
--- a/Documentation/technical/long-running-process-protocol.adoc
+++ b/Documentation/technical/long-running-process-protocol.adoc
@@ -24,6 +24,7 @@ After the version negotiation Git sends a list of all capabilities that
 it supports and a flush packet. Git expects to read a list of desired
 capabilities, which must be a subset of the supported capabilities list,
 and a flush packet as response:
+
 ------------------------
 packet:          git> git-filter-client
 packet:          git> version=2
diff --git a/shared.mak b/shared.mak
index 1a99848a9517..57095d6cf96c 100644
--- a/shared.mak
+++ b/shared.mak
@@ -88,6 +88,7 @@ ifndef V
 
 	QUIET_LINT_GITLINK	= @echo '   ' LINT GITLINK $<;
 	QUIET_LINT_MANSEC	= @echo '   ' LINT MAN SEC $<;
+	QUIET_LINT_DELIMSEC	= @echo '   ' LINT DEL SEC $<;
 	QUIET_LINT_MANEND	= @echo '   ' LINT MAN END $<;
 
 	export V
-- 
gitgitgadget

