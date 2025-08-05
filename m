Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBED2737E7
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399042; cv=none; b=OOf1hUGN8hVDk2n250/AN9QkEl9xCN2mja5jTgeySgFvoq3jzyniGqPrKSCaxIymp4KGO/vKcTmCaa8tUstZ7EHzHVdCrdd8IcB1JP8LgKQoqoHJ8+J6XjNh98KpX+XNHg0CppZ0hp8Ja2AbBt4DemLi/3muzLGusfo6l/d1xjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399042; c=relaxed/simple;
	bh=5ZyR7vra1JNn4Y1y3NkL45r+t4O89ptfv5zUSeAwH5A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=aGB7ml75/VLX68PtuKQVf4SwEczjbMBd/Feg7Mr6LJ4XfcK+zuFzLKHWt7hGlCroW6WdkXmO9od5DiRCliJYM/1s3h8WU/UifqJUq3RSImnuQA7tX6S+5pS6wsAbYxm7hzpbQvz/K/wudn8j6oSCtJ4wuET90n9Who25jr62QPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ef2rI5Ix; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef2rI5Ix"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-458bece40fcso16038835e9.3
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 06:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754399039; x=1755003839; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sztv5yKn2l9iWtAaoCHOJAmg3hhHB5u23maF1n2mNc0=;
        b=ef2rI5IxHZVQJPwzo02/P9tjahAdByIe1eK2vNT3bj0zNS19s6T8Y5EdBeU3P/3pYy
         r5JTxenQvv+lIP/IeDfVw4T8sDeMqstWurOiFJhjnYp0ryA2gV+R5s5QCcjaiR6jGRDN
         WcyW70erILcoutZVCVo39MRcSBUy3qk8LMGJuAJ2dDJigzRvnqJzHKXuAaY3qf2HzoZI
         dWPc5Tx1KerSFIvGeDiXQuvBNco/z3pPpOsLe5yyQoKurXYYI4wdcAWONGoWk0k7a2mp
         ket85X0omwzpSM6g9OHtWNJaqY8asWQ2TGfhA4PsPeG/dCMMxqKUtS8nTthMEMQ0vWuw
         55AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399039; x=1755003839;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sztv5yKn2l9iWtAaoCHOJAmg3hhHB5u23maF1n2mNc0=;
        b=qqMAl2/L+RPKIheooK/KNahQ1toomVVTWBfBo9kR2dBCcFqRu9Li/QpcNcC6wHY8Sx
         lODeGPmTXcK3UZESfMXSimDvJ5DiSpqZs7RVME1VR/Uqxgr0fBiBt2NPwrImcIZ4Z8O/
         wl9DijZyo3uJgsuhx3yvfGpSoq7Wh+nj2ELURbHW0NOyF+Ld3dd8OtDC15l87OPBFmRl
         pVP5uL6hktLtRM6hDBsaycnOZOzpClWPkgarVbdj/+u86Wd7dnMHIrCQfs6r6xo6cW5W
         hSe6gmvD9bAwi34gCK2Vp4eVIsuWnbGR0JxFZ+MFn0mjSG64l3sXWYe0uOqCKviJaaYX
         y1Ww==
X-Gm-Message-State: AOJu0Yz6BDCmiKnUeZ90nj6rynlWoIhaDzccCw+H5/nyUJ6VoEi9WQvU
	HMNjVy6h0F06AxRqwO3qcy7GTMDKU5A1PIJBgmNryhc1IxFbdJ3MlL0RkDmp/g==
X-Gm-Gg: ASbGncvHmPpL8PZdT01paeOn/jJUP7g9KBjgJFnhXb4l7znAtAiwl0UfJ+xDRszv+sE
	/AcCMji3vOJC+RgPIjwe6c5eusVV0ABlHkdQynzaCADgYcLu2N57O+qpRBwNjfc5uWZdRLRGScZ
	AMyjyHgMbj0Jia0xhabZWiHDAy/0hdXUg85EhA67B/XUjh5F4JS9Lylg5w4N4QzRk9CdOrkOxF9
	HbihBvlT0PgjHOsCT0zF4rbepYbua3OsL/25qDHmq8FdzDehPMR2G97LDQGFKZYip7xvGRj41iD
	vL4bEmQw6RhNcV4LP00FMCU92GsvZkeImpmwM5lVAfxVI4iekRDq4qlINDKF3ETSsg7nc5d9fLV
	HM0coeiCyCkWtVlO0BinzcQM=
X-Google-Smtp-Source: AGHT+IEeZAycquarNCvCaHgCTY5L0Ys7OH3zTUiu0GY84C73qFB/UPO7+Z8jSOhcVgM/8mk5JFsFkw==
X-Received: by 2002:a05:600c:17d8:b0:453:5c30:a1fd with SMTP id 5b1f17b1804b1-458b71903edmr70191985e9.8.1754399038522;
        Tue, 05 Aug 2025 06:03:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5c84b8csm10615e9.4.2025.08.05.06.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 06:03:58 -0700 (PDT)
Message-Id: <5806390052b7a7cbdb8dc843bfcc24102604e2f6.1754399033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
References: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 13:03:50 +0000
Subject: [PATCH 3/6] doc: check for absence of multiple terms in each entry of
 desc list
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

Due to portability issues, the script generate-configlist.sh was fixed to
not use carriage returns in the output. However, the result is that it no
longer correctly handles multiple terms in a single entry of the definition
list.

We now check that these entries do not exist in the documentation.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/Makefile                      | 10 +++++++++
 Documentation/git-check-attr.adoc           |  3 ++-
 Documentation/git-check-ignore.adoc         |  9 +++++---
 Documentation/git-http-fetch.adoc           |  4 +++-
 Documentation/lint-documentation-style.perl | 24 +++++++++++++++++++++
 Documentation/technical/api-path-walk.adoc  |  5 ++++-
 shared.mak                                  |  1 +
 7 files changed, 50 insertions(+), 6 deletions(-)
 create mode 100755 Documentation/lint-documentation-style.perl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 76a9e1d02b26..ac8a21e3015c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -508,6 +508,15 @@ $(LINT_DOCS_DELIMITED_SECTIONS): .build/lint-docs/delimited-sections/%.ok: %.ado
 .PHONY: lint-docs-delimited-sections
 lint-docs-delimited-sections: $(LINT_DOCS_DELIMITED_SECTIONS)
 
+## Lint: Documentation style
+LINT_DOCS_DOC_STYLE = $(patsubst %.adoc,.build/lint-docs/doc-style/%.ok,$(MAN_TXT))
+$(LINT_DOCS_DOC_STYLE): lint-documentation-style.perl
+$(LINT_DOCS_DOC_STYLE): .build/lint-docs/doc-style/%.ok: %.adoc
+	$(call mkdir_p_parent_template)
+	$(QUIET_LINT_DOCSTYLE)$(PERL_PATH) lint-documentation-style.perl $< >$@
+.PHONY: lint-docs-doc-style
+lint-docs-doc-style: $(LINT_DOCS_DOC_STYLE)
+
 lint-docs-manpages:
 	$(QUIET_GEN)./lint-manpages.sh
 
@@ -537,6 +546,7 @@ lint-docs: lint-docs-gitlink
 lint-docs: lint-docs-man-end-blurb
 lint-docs: lint-docs-man-section-order
 lint-docs: lint-docs-delimited-sections
+lint-docs: lint-docs-doc-style
 lint-docs: lint-docs-manpages
 lint-docs: lint-docs-meson
 
diff --git a/Documentation/git-check-attr.adoc b/Documentation/git-check-attr.adoc
index 503b6446574d..15a37a38e3f7 100644
--- a/Documentation/git-check-attr.adoc
+++ b/Documentation/git-check-attr.adoc
@@ -19,7 +19,8 @@ For every pathname, this command will list if each attribute is 'unspecified',
 
 OPTIONS
 -------
--a, --all::
+-a::
+--all::
 	List all attributes that are associated with the specified
 	paths.  If this option is used, then 'unspecified' attributes
 	will not be included in the output.
diff --git a/Documentation/git-check-ignore.adoc b/Documentation/git-check-ignore.adoc
index 3e3b4e344629..a6c6c1b6e5be 100644
--- a/Documentation/git-check-ignore.adoc
+++ b/Documentation/git-check-ignore.adoc
@@ -25,11 +25,13 @@ subject to exclude rules; but see `--no-index'.
 
 OPTIONS
 -------
--q, --quiet::
+-q::
+--quiet::
 	Don't output anything, just set exit status.  This is only
 	valid with a single pathname.
 
--v, --verbose::
+-v::
+--verbose::
 	Instead of printing the paths that are excluded, for each path
 	that matches an exclude pattern, print the exclude pattern
 	together with the path.  (Matching an exclude pattern usually
@@ -49,7 +51,8 @@ linkgit:gitignore[5].
 	below).  If `--stdin` is also given, input paths are separated
 	with a NUL character instead of a linefeed character.
 
--n, --non-matching::
+-n::
+--non-matching::
 	Show given paths which don't match any pattern.  This only
 	makes sense when `--verbose` is enabled, otherwise it would
 	not be possible to distinguish between paths which match a
diff --git a/Documentation/git-http-fetch.adoc b/Documentation/git-http-fetch.adoc
index 4ec7c68d3b9e..dcb05890aefd 100644
--- a/Documentation/git-http-fetch.adoc
+++ b/Documentation/git-http-fetch.adoc
@@ -25,8 +25,10 @@ commit-id::
         Either the hash or the filename under [URL]/refs/ to
         pull.
 
--a, -c, -t::
+-a::-c::
+-t::
 	These options are ignored for historical reasons.
+
 -v::
 	Report what is downloaded.
 
diff --git a/Documentation/lint-documentation-style.perl b/Documentation/lint-documentation-style.perl
new file mode 100755
index 000000000000..1f35a6a116da
--- /dev/null
+++ b/Documentation/lint-documentation-style.perl
@@ -0,0 +1,24 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+
+my $exit_code = 0;
+sub report {
+	my ($line, $msg) = @_;
+	chomp $line;
+	print STDERR "$ARGV:$.: '$line' $msg\n";
+	$exit_code = 1;
+}
+
+my $synopsis_style = 0;
+
+while (my $line = <>) {
+	if ($line =~ /^[ \t]*`?[-a-z0-9.]+`?(, `?[-a-z0-9.]+`?)+(::|;;)$/) {
+
+		report($line, "multiple parameters in a definition list item");
+	}
+}
+
+
+exit $exit_code;
diff --git a/Documentation/technical/api-path-walk.adoc b/Documentation/technical/api-path-walk.adoc
index 34c905eb9c31..a67de1b143ab 100644
--- a/Documentation/technical/api-path-walk.adoc
+++ b/Documentation/technical/api-path-walk.adoc
@@ -39,7 +39,10 @@ It is also important that you do not specify the `--objects` flag for the
 the objects will be walked in a separate way based on those starting
 commits.
 
-`commits`, `blobs`, `trees`, `tags`::
+`commits`::
+`blobs`::
+`trees`::
+`tags`::
 	By default, these members are enabled and signal that the path-walk
 	API should call the `path_fn` on objects of these types. Specialized
 	applications could disable some options to make it simpler to walk
diff --git a/shared.mak b/shared.mak
index 57095d6cf96c..5c7bc9478544 100644
--- a/shared.mak
+++ b/shared.mak
@@ -89,6 +89,7 @@ ifndef V
 	QUIET_LINT_GITLINK	= @echo '   ' LINT GITLINK $<;
 	QUIET_LINT_MANSEC	= @echo '   ' LINT MAN SEC $<;
 	QUIET_LINT_DELIMSEC	= @echo '   ' LINT DEL SEC $<;
+	QUIET_LINT_DOCSTYLE	= @echo '   ' LINT DOCSTYLE $<;
 	QUIET_LINT_MANEND	= @echo '   ' LINT MAN END $<;
 
 	export V
-- 
gitgitgadget

