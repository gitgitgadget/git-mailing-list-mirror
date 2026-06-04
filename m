Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E40369D7A
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559167; cv=none; b=RVQRDylGPby2k6zP0ccj11M3R9KoEV3rDdPmIU/FwbyRSGO2LJDFKRV5iHyKCmNV84DGI8wwsJAix69zOhI9l5qt+uDRbOAKUZZFc9bb+OFV29vdZk03w/+Tz5wGhYNHjNgzbdsPVkxF65LKH3w5KP/aOw8781tnGx6rPpWe8FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559167; c=relaxed/simple;
	bh=3d5eXE+SiP7kCmUQ8aGCzJv0+TBH7AMdlkhqWrJO7f4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W8NGoEijLKdxYFg9ttSZcd7V0oI9Nu1nIGCli1zw2g5gzEYTZBdy2CjCLc2Cf2tVaN/kDhKbBEW4JSYGNH4af8WdUNoWOi/rdygHBk13WKbdbSnA+9nLDJ6DfmRF9NU50EKkR38mY1UZ2tnY6ChWwPh+XdN3lE9Ixhj1sEukHYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1d6EusW; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1d6EusW"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9155183b42cso54306885a.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 00:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780559165; x=1781163965; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNDoHkS5nEVPkdpJ7+aNPP5ee62BpZYiuH1PtAQkNz0=;
        b=T1d6EusWrH5fkK86TU6JrRcD48OWET1qArbKqD9SSkKtRxfLsnvYHISKEfe9A9Dctd
         0iGmXmh7DdOEzvgYpREeNOKwldv3LZlSr4Sc37xADYyLwKkV/HX8DoR6CePuH4MDtGWR
         9X6X7S4nYfGDuJQNZaP4fhZWVv1czNWh92dn/XCEnXbjCXetxd2cf/NU5D9fUcfY5/hk
         0YCcX101TalHduloXhXky9/6ee8hT44lZggm04ABZaHOOlaUjl4TyVDIvU7EGcmGyDog
         CMthQXBzTTLAeVoTbY1fGRdoYi4j63ccBZbiXNRI8pkZ9GmdwYpmtfT+aPPESzCK5v91
         dO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559165; x=1781163965;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VNDoHkS5nEVPkdpJ7+aNPP5ee62BpZYiuH1PtAQkNz0=;
        b=anY58/0LfpTRmzymLlTFYisXixnay3v7mxsAYCgXwu+4gI0EZzSA5GI+G2uNPj4mm5
         Fw4eGmhZdsKS3NMXiMzpnhz254Pg9zSpYyPFm1B6+o0dfmF4ujHt1VbXyLGmEWTYrCaS
         Y9pKTJf3EZZ2GlVga/6Tdfr4NgDz+K9AaMJBO8zKYjKSip2GvEEl5TYoq4zdmb6DOIXo
         II6vMEAgqzAGZmmKB/KtRnFepnp1ieJn+zzPZDQKdLf2B6vUL33u+jEQ9CKo5BhmEsql
         rntXHgOpGiPrYp2qlAWLNVhzKaKX+euauo9tx0mkbAjXJu+7/yYCVKN0ouZUnlDJxwhJ
         sweQ==
X-Gm-Message-State: AOJu0YxJ352DMOH296I2qcUFZ/cLSndExJjAPaacjdueIEL4c/TNc5rV
	wS+INBf9G/BIXMDYX8weIDLxqsnwXc0DdtVYhkrnm2rEaRr49fx/LKFlo9kXJHGX
X-Gm-Gg: Acq92OEpmkTGrP3bCsmAjWrkg7DFC1pApgW2tXMXQHsJKSs53lf13rmez83ryja/X3c
	STmlo302+OO2Ab32oXdyUCQSidslLFad6vHEDyQyyq7b4I1DdOtw+J9BcIE4ScAoxzYAUFHrCEX
	ZwYmaOludygbDAgVlhEuEgzRI7sAcsE0Y1fQm3ZWuz9BDgnBMN6SfYBG4/KEK1qIktNxAuHkGOJ
	O1wv0ETtO30XtQl6XfhCbSn4kGi/RMTr2zKYRpFpPxPOQAbka1ncF0WDQQIpWELllPD0T6YmBSA
	Xv8coxuf3gWzFyQpZ25gyobo/Q8J3cDp21rgxyRAWyuf5+v2N2b3Sv6XY9vWjXy+FVmoVll5iAd
	Rzz8VUOihzGEdJWGTcAQeLtKUzaslODXgnsmM4l/jRIiXNCwYCoGO7bMqAO8SZdFg7YWG1e4AFr
	Qg0BFhowyX0mHg/i1n9OzvJ8Ts1+KXoGK/ySXY
X-Received: by 2002:a05:620a:f0d:b0:915:8654:dc9e with SMTP id af79cd13be357-9159af98085mr396541585a.31.1780559164787;
        Thu, 04 Jun 2026 00:46:04 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.86.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00afafsm512692385a.2.2026.06.04.00.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:46:04 -0700 (PDT)
Message-Id: <93c2b29683ff158920013af37cd28e1c2f4e2617.1780559158.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 07:45:55 +0000
Subject: [PATCH 3/6] t: fix Lexer line count for $() inside double-quoted
 strings
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

scan_dqstring's post-loop newline counter re-counts newlines that
were already counted during recursive parsing of $() bodies.  This
happens because scan_dollar's returned text can contain newlines
(from token text of multi-line strings and from \n command separator
tokens), and the catch-all counter at the end of scan_dqstring
counts all of them again.

Fix this by counting newlines inline as non-special characters are
consumed, and removing the post-loop catch-all.  Each newline is
now counted exactly once: literal newlines at the inline match,
line splices at the \<newline> handler, and $() newlines by
scan_token during the recursive parse.

This does not affect chainlint's output because chainlint annotates
the original body text using byte offsets, not token line numbers.
It does matter for tools like lint-style.pl (introduced in a
subsequent commit) that use token line numbers to locate and fix
specific lines in the original file.

Add check-shell-parser.pl to verify that the Lexer reports correct
line numbers after multi-line $() in double-quoted strings.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/Makefile              |  7 +++--
 t/check-shell-parser.pl | 58 +++++++++++++++++++++++++++++++++++++++++
 t/lib-shell-parser.pl   | 11 +++++---
 3 files changed, 71 insertions(+), 5 deletions(-)
 create mode 100644 t/check-shell-parser.pl

diff --git a/t/Makefile b/t/Makefile
index ab8a5b54aa..25f923fed9 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -139,7 +139,7 @@ check-meson:
 test-lint: test-lint-duplicates test-lint-executable \
 	test-lint-filenames
 ifneq ($(PERL_PATH),)
-test-lint: test-lint-shell-syntax
+test-lint: test-lint-shell-syntax check-shell-parser
 else
 GIT_TEST_CHAIN_LINT = 0
 endif
@@ -160,6 +160,8 @@ test-lint-executable:
 test-lint-shell-syntax:
 	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS) $(TPERF)
 
+check-shell-parser:
+	@'$(PERL_PATH_SQ)' check-shell-parser.pl
 test-lint-filenames:
 	@# We do *not* pass a glob to ls-files but use grep instead, to catch
 	@# non-ASCII characters (which are quoted within double-quotes)
@@ -185,7 +187,8 @@ perf:
 	$(MAKE) -C perf/ all
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
-	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
+	check-chainlint clean-chainlint test-chainlint \
+	check-shell-parser $(UNIT_TESTS)
 
 .PHONY: libgit-sys-test libgit-rs-test
 libgit-sys-test:
diff --git a/t/check-shell-parser.pl b/t/check-shell-parser.pl
new file mode 100644
index 0000000000..7d4ba6da7f
--- /dev/null
+++ b/t/check-shell-parser.pl
@@ -0,0 +1,58 @@
+#!/usr/bin/perl
+
+# Tests for the shared shell parser (lib-shell-parser.pl).
+
+use strict;
+use warnings;
+use File::Basename;
+
+my $_lib = dirname($0) . "/lib-shell-parser.pl";
+$_lib = "./$_lib" unless $_lib =~ m{^/};
+do $_lib or die "$0: failed to load $_lib: $@$!\n";
+
+my $rc = 0;
+
+sub check {
+	my ($desc, $body, $want_token, $want_line) = @_;
+	my $parser = ShellParser->new(\$body);
+	my @tokens = $parser->parse();
+	for my $t (reverse @tokens) {
+		next unless $t->[0] eq $want_token && defined $t->[3];
+		if ($t->[3] != $want_line) {
+			print STDERR "FAIL: $desc: " .
+				"'$want_token' at line $t->[3], " .
+				"expected line $want_line\n";
+			$rc = 1;
+		}
+		return;
+	}
+	print STDERR "FAIL: $desc: token '$want_token' not found\n";
+	$rc = 1;
+}
+
+# Multi-line $() inside a dq-string: MARKER should be at line 3.
+check('dq-string with multi-line $()', <<'BODY', 'MARKER', 3);
+	x="$(echo one
+	echo two)" &&
+	MARKER here
+BODY
+
+# Two multi-line $() substitutions: verifies drift does not accumulate.
+# MARKER should be at line 5.
+check('two dq-string $()', <<'BODY', 'MARKER', 5);
+	x="$(echo a
+	b)" &&
+	y="$(echo c
+	d)" &&
+	MARKER here
+BODY
+
+# $() outside a dq-string: no double-counting either way.
+# MARKER should be at line 3.
+check('bare $() spanning lines', <<'BODY', 'MARKER', 3);
+	x=$(echo one
+	echo two) &&
+	MARKER here
+BODY
+
+exit $rc;
diff --git a/t/lib-shell-parser.pl b/t/lib-shell-parser.pl
index 1e521a94f8..fa9b44d6ec 100644
--- a/t/lib-shell-parser.pl
+++ b/t/lib-shell-parser.pl
@@ -89,8 +89,14 @@ sub scan_dqstring {
 	my $b = $self->{buff};
 	my $s = '"';
 	while (1) {
-		# slurp up non-special characters
-		$s .= $1 if $$b =~ /\G([^"\$\\]+)/gc;
+		# slurp up non-special characters; count newlines
+		# inline so we don't need a catch-all counter that
+		# would miscount newlines from recursive $() parsing
+		if ($$b =~ /\G([^"\$\\]+)/gc) {
+			my $chunk = $1;
+			$self->{lineno} += () = $chunk =~ /\n/sg;
+			$s .= $chunk;
+		}
 		# handle special characters
 		last unless $$b =~ /\G(.)/sgc;
 		my $c = $1;
@@ -107,7 +113,6 @@ sub scan_dqstring {
 		}
 		die("internal error scanning dq-string '$c'\n");
 	}
-	$self->{lineno} += () = $s =~ /\n/sg;
 	return $s;
 }
 
-- 
gitgitgadget

