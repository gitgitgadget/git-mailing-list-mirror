Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838A2E285D
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945611; cv=none; b=VEAACDxB4pG47KvCgJUrPI3HM76yBvMRpXd0UDPs5m3w33Mmm/I4uQVefCxS5H/kUwPdu1TJ+MlZZlFAuvVUYfI/x/Fw/hEwOcBNNO8pCfHrinp8EBNwqZwrBgV/FUg/Xyk/OAirpgWK6RzZHeN8h8e7bqiVX5D3fo3FUDf/9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945611; c=relaxed/simple;
	bh=0uS/5TsI2WRrFzgvlPXSKq32tnfOu96gsxElrkyb2Rg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Bzr3s2S0fpZPa9e+RHjYYB+sArgDRnzgf7MEgAVOX5K32NXM9DMqQtaMjU3U1R3FBq1t4xZnP+dgiBdNLKWVSBfwDrT3oT0FL3CnAaHoVCsVXnTPnx1sobN7Vr6qTVgc+ISyStR+mu3GFYvt6KVcGHJ1RRB7qi4/cEMXBcxiu+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPzXD4Q2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPzXD4Q2"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45994a72356so38316415e9.0
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754945607; x=1755550407; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mUZddteVfB8Sh/kjvFeCLmTFQHUc7+PZOzKeApBT6c=;
        b=DPzXD4Q2ju0nSQKs55T9tYYk06Rut51+OmAgEOkSksPrEVYUImSfG9Y81UCYshczzB
         k8cA3a4Nm484dZjvV5J7gYgVK5DQaJcY+bMgFrpMyK0g2b7X9sRteY+1RltgbBSEvUoi
         7EAgtR9j20E6U9xg1VgF8cA9QdKNfXFTJmXM14mRNGo9UtS99XQ43Eb3HdrpBBDtacbu
         KB/SOFkyWYHhROFsiW1N6ORsGRpqBCnWqs/Ge4KZpv4qEHGcfwYRCNtZTGPBXnDNP7c4
         vr2BqfCUKrA8PCr9Jdykz8z6TPmY4FQayVqErM/mnebGwCaUffJCh1RCjTJJsJKx7Q+7
         2iVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754945607; x=1755550407;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mUZddteVfB8Sh/kjvFeCLmTFQHUc7+PZOzKeApBT6c=;
        b=T/jQ2fhUkNf+lSiSu7Nw/mGSAn1rots49y50wDLPGwYa9NEvPj/2gFTkLSWGkLJ2Qd
         3wnjZJSLD7dJ7jA6/gyX0ZSgEdD2eM/15M0KMUpdzOr2cwZNRxp204QlbtWMoOKrAubI
         t7JJEkzjWKITHeCR/H5ui8RWCq2m/xwed4177jfcgXa7Wn8RDVMYkT4T8Qqum8tkAipd
         wH6oeNVCWvjy2u81mGfs7l+zyjzfJQAS4xYax4lGAjKUheW1qjEfXyTjrXjCZcT7Br4t
         sWG+qWk6j2o5GJ5HylxZeojIZINE1WDcYWBxytzF3jxSnycHrdCDbS17VeSp65sm5q3o
         ejmQ==
X-Gm-Message-State: AOJu0Yzme/6HLerjdOj82DKdOOwEAvifmcK0W9W8/qhGr5rYJvj+udd/
	x2ldNoJxNqYDK0HwQ7kS6DCpgVpcBCiNAzXerpQDFYiV4gYl3kwgmYGV8bJpKg==
X-Gm-Gg: ASbGncvSa26KMX8HQHy32eJ0gw/UsNJ2eNgS21JWXXFe0oDvDJf/R5Fqgt9RzSNyVIg
	JkjdxvgkOgisKhIkRTOvq7b6rp8QPqDisPXyDiUyaH2B/B2r11ggaftu98HsxKECWSjqitHJv6s
	U2Md7jeS8YeWzqCM2V2sbHlnL8+qfQp+gZvX4RuQgwHvIBrfJxBBA0eLSACMapd8AzjYWmDKCZL
	SZBxEtkYFMhWxWG2uNmE+zyPVsvaemPD2U0P13FTfEpl/3a7hW3nbhlzb9CYJNZcDrk8zXs3BrJ
	Vl4Xxr0eGlgbtAiJyxD7vHSxYGCsPII+vvy9r2o1vc3OaAnSo3DJ7YZ7pDNfJL5wHqrSFc/KyDM
	PyERff48KXR4fa7RZip1Jjn98NuPMImhCDQ==
X-Google-Smtp-Source: AGHT+IE8WIRO8piX2NFvGSAFJCdazkxrQ3M6JLZoIveeLlqykahs8ihzlbtNEnUlckr6qc9VPw+4xA==
X-Received: by 2002:a05:600c:3146:b0:458:bf15:689c with SMTP id 5b1f17b1804b1-45a10d40481mr8225915e9.2.1754945606736;
        Mon, 11 Aug 2025 13:53:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0a24bf1sm290754215e9.1.2025.08.11.13.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:53:25 -0700 (PDT)
Message-Id: <322df2d8dde35916f91601029c4db89837776b5d.1754945600.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.v3.git.1754945600.gitgitgadget@gmail.com>
References: <pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
	<pull.1945.v3.git.1754945600.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 20:53:16 +0000
Subject: [PATCH v3 2/6] doc: check well-formedness of delimited sections
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
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Collin Funk <collin.funk1@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
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

