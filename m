Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5132989B5
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421055; cv=none; b=LST5roOAZ+bfilfqT72L6mjEWDMuFygjxpdeuL0A8RsP92KXviXg12Dd8gSjiCiguturDOQLHOHJpuZvISkwVJHKjoZ62K8VjDxAwdzvXz1tdzOD/9gJdXSoR1F7Z+RgXD+7IHUh1059UrbJH/dTkbgd1KrEdSWlhoHWXWTubHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421055; c=relaxed/simple;
	bh=5ZyR7vra1JNn4Y1y3NkL45r+t4O89ptfv5zUSeAwH5A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=K1mqBNp2fx9aIaFtjliYDpuItSJNYEFwzxNE4yow/4mX7+V8osMWvb0IQyBzYpCTqU7MT8BT5mWd+JFcNBCH8rrdh0BEgmhz2i4dD1cL7a1nxuhUjhQm0ZAkD6GtHXOSutba+z8d6LoTgxfL3IfMFnIdQFe9/ip4XeVY905Lah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrVCa/mZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrVCa/mZ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b794a013bcso5144765f8f.2
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754421050; x=1755025850; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sztv5yKn2l9iWtAaoCHOJAmg3hhHB5u23maF1n2mNc0=;
        b=jrVCa/mZnGAvKjh+tszZoDka2sHRkIU19HRaZVysnShB+Ce5oXvRgwIUjlsxI9ZjWN
         uScuYXPQF8/veypcYJR/z7ZUB5jcYzik8rpixxjxi6mwm58rSuphVbY2QnsR/8I67TJq
         robMLgNg05iGSgUGvXEMLCHqFzsRLa5vXKx5lUt4b4wxv1hTmqf5m1+3JJZfc5E+dM7m
         8P1Qa3oj90rA2Z7ma8piWbPnH+v8g+0hSpE5AcBfVIQFSHVNVyCnuJ4dvq/HF/58USA9
         UUpEw8zlt6UEqDIrJBwQwBelDq/+uzZuDaidT31wLVZpMIKbKVHPRMwdgiSvEVlD89OD
         7TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754421050; x=1755025850;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sztv5yKn2l9iWtAaoCHOJAmg3hhHB5u23maF1n2mNc0=;
        b=RiLm4cxskmcKF9Oos357QHbfxTQDN4pJWb9KfE1n6vJMP0tRnFddY45rEhrzglB6jS
         3iyEzwcg+R8lVaEN1PxFax7OpWx32FKZDXfx1qzTD9vJ4ohKSTgbgM1tkgGO/+Ee+Qwr
         RK6wdd+Msm7HZJXWR8kSPK4NbR7rSLbDf7jnyoIrBl3EEDP8etYS4ifP1NQsMiEooEzf
         9JVbN8hCIHVWjP/FyBqm5Q6tWWAD2NqQ6lPBZpZs5BJ23oY7Th7bKU7Wpho/zHIBoCYm
         ERSpMMX6vRh/H1zjBkj3VqZ5QEjH1IovToQ8S7N/hLwNAEekyt710yVojp8EEpxamk7b
         6pQw==
X-Gm-Message-State: AOJu0YytBNl96TFpDIM8NafBdo24p5/N9slagYTSJYUJtLdbjoWNQTgQ
	RrwIxmCTHaYMLIrUkhO4hYZrNHLvZTr4ALTj6TXRY8x4Hv3jrtlX38ujzfNQxQ==
X-Gm-Gg: ASbGncu38yeMrPnHgHjAIs0Z20aSVXr/LpdFt7Setb6RwYfncPdwUCajna9YEN2Q3MW
	pkJ2bsO6T1c/VB3EaMpjSmGw9WpUChQlGwtt7Na2Rp1pam0iyP7OZgjCV6ZGs/33NZao6MBLWs2
	9wU0iHzJVVovhQNYDKLR0zgNDWf4RjtBzbGsGPhmSoINDnnenMQmJ8rAlMQTsbaGJLeLUTFvuKW
	wS+Ildztt1qM068of3gvF3lLoQYiWEsrj+axR8ivSA4Xl3/1YNklVni7ijwM9i/0XUH2+15zOLR
	5C0hqVYABv7ITe4JtSO+jdIgV/tCiG3/sv6UdA1eGh7CH9BXeLe6S/LTlAFkTdP0AOsUWJz/68+
	yiXEbznNlKhLfVi9qLzbk50M=
X-Google-Smtp-Source: AGHT+IEinwiu5+WuDd+G2t/UyyrG+70ziKVEvwO7sXLb68mTZyY7lniAnmScRyC+jz99kKJysC3SGQ==
X-Received: by 2002:a5d:5849:0:b0:3b7:73b5:e96d with SMTP id ffacd0b85a97d-3b8f416d6a7mr154005f8f.15.1754421049843;
        Tue, 05 Aug 2025 12:10:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc900606sm79860615e9.15.2025.08.05.12.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:10:49 -0700 (PDT)
Message-Id: <5806390052b7a7cbdb8dc843bfcc24102604e2f6.1754421046.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
References: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
	<pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 19:10:42 +0000
Subject: [PATCH v2 3/6] doc: check for absence of multiple terms in each entry
 of desc list
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

