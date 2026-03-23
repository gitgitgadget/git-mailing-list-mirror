Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E583C13E2
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285080; cv=none; b=pIYferHIzOBx/KJokSOmA/AoIJnxdVcsyeKE6ueckCtASW/JVIMONey+LiTQM0SxJjAbjwR8zqWGzreRNRm+bXNzaWNXxKOrGimeydeIuk+iA+5YOqvoJEDPWyF2Khx9orSIkTuf7Fk7NQMTuI/5j/tjiYWy3YIrrAZHK8i4OlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285080; c=relaxed/simple;
	bh=DbpLz2dysXorO5kq5COmnu3GXo+Ub0jSgxUHWou/FnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLuEbNqBA1CWxV/I+K4wAgvKXj7WzBYpUdnLG7e3nnBXF2vaTARzEARTFhWnVX/7UK4Wnt4n+BV8517tjVkgL42pvKSlLy2rLWGYL9ZJZUg0ppxToZkysaKto0qECII28IqCAvaX/Wd+wsxAWax5qcC31jQoLi2GxYopYhOYSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Am8Us2rd; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Am8Us2rd"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774285077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OcK0L0QD7P9CtJLRrMhD8aDlYY2r3/aA7mENFk6ssCs=;
	b=Am8Us2rdOWhUUPx1pAssu4lNE9R6qkcOsAiG6YYzfPqcemDrUkCCPCys8YWEU5xFEjkCWj
	93+ezrbzqoiqT4l6rtjvS+1tSyRmarr1Kk5uMbOrN/VO6rTUMZbBr4D9eI+PAd1fBFQynv
	rCHQ4Aj1AakFr6crEJg1bFLVCcD9iC1Lky1G33eTmxkLtwHJxMT1FVasMdCCIVlggRZZi0
	dDJJuVzeNEIGluygF3QOcOoiCFJ4jtGqO5t/sB+ZDaX0topXAOlr5Gcga5cktSk8Mx/U41
	bEklWdCOPGc1OCifmWXcwNqAe2iG2rzwqgHoP96M8u+uUmw+cXItMBeRjm6uqg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 3/8] format-patch: rename --cover-letter-format option
Date: Mon, 23 Mar 2026 17:57:30 +0100
Message-ID: <5d061d6398bae368a7cc95700b5df44854d1d8e8.1774284699.git.mroik@delayed.space>
In-Reply-To: <cover.1774284699.git.mroik@delayed.space>
References: <cover.1773959395.git.mroik@delayed.space> <cover.1774284699.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7229; i=mroik@delayed.space; h=from:subject:message-id; bh=DbpLz2dysXorO5kq5COmnu3GXo+Ub0jSgxUHWou/FnU=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpwXDzftiXwDhR2zvLQyR7wg5BeJZw/0vuM004Z ohhwsBDc4mJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCacFw8wAKCRBIeX6hnBm+ 0dBDEACMBLfffNQlIqM0CECWn+LwnbntHuKXfQHOqVLYft2zIqX5zn8I15HEWtXWBtqzdalx+8z GxbawiMxfEo3yMFVbZmQE1j0mi9emn7pR0DsktemMaYGq1DxtSsFmIvOgtXDBQYWHgkOtbelcg3 oRBgUCu0kyHS9OR4Wk6M9UQEse9BWVAH4RGdgO1ru3O87qDSZAmBiaikQ+rURmrYJ1Lree0B/8W oZ4Vps2AG7L9/1lFthn3PdH3MPOFnff8PkK2huMiIrwfTkhIF/rWgTBIlCK63nSJ+Kbdxe04T7K /G8C/kMbpL1goUiM0Srv7gFV77E3ZAmGAV72RaJ3V4natNmJJJHhfTH/xXuSSTbl8kK4Hkp2y8z im4GMCm7e0Vnvpk7cDoXTUrIP8lxaetNVI9bsJNoMbzyAcglAiFWZt/mXk+kAOIcARZCQWPeL4l U6bNDxWobtbA4yXzLpcTk7eo3tKx1nuFHEqC0lApZAnLqBhPbTUjwOBfHKDmGeHgEngfjwcbzlS yxZ7TKSPdmp5KrkhkUI04aNjfPYx6ILns69svL4MFnoih7g66NkaPgjq44XVJvVl42DMCUZD4jW q/qTLsZnVaxaQrsHj8X/xdr+4o62DqVjv4PDvqsPXiOo3URR1vu7tHncaeQFPa/9i7nWU7hFN5H dEDlcTevR
 JTNiMg==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

To align the name of the configuration variable and the name of the
command line option, either one should change name. By changing the name
of the option we get the added benefit of having --cover-<TAB> expand to
--cover-letter without ambiguity.

If the user gives the --cover-letter-format option it would be
reasonable to expect that the user wants to generate the cover letter
despite not giving --cover-letter.

Rename --cover-letter-format to --commit-list-format and make it imply
--cover-letter unless --no-cover-letter is given.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/git-format-patch.adoc | 17 ++++++------
 builtin/log.c                       |  4 ++-
 t/t4014-format-patch.sh             | 41 +++++++++++++++--------------
 t/t9902-completion.sh               |  1 -
 4 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 31fa492335..45ca72e670 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -24,7 +24,7 @@ SYNOPSIS
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet]
-		   [--cover-letter-format=<format-spec>]
+		   [--commit-list-format=<format-spec>]
 		   [--[no-]encode-email-headers]
 		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
@@ -323,16 +323,15 @@ feeding the result to `git send-email`.
 	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
---cover-letter-format=<format-spec>::
-	Specify the format in which to generate the commit list of the
-	patch series. This option is available if the user wants to use
-	an alternative to the default `shortlog` format. The accepted
-	values for format-spec are "shortlog" or a format string
-	prefixed with `log:`.
+--commit-list-format=<format-spec>::
+	Specify the format in which to generate the commit list of the patch
+	series. The accepted values for format-spec are "shortlog" or a format
+	string prefixed with `log:`.
 	e.g. `log: %s (%an)`
-	If defined, defaults to the `format.commitListFormat` configuration
+	If not given, defaults to the `format.commitListFormat` configuration
 	variable.
-	This option is relevant only if a cover letter is generated.
+	This option implies the use of `--cover-letter` unless
+	`--no-cover-letter` is given.
 
 --encode-email-headers::
 --no-encode-email-headers::
diff --git a/builtin/log.c b/builtin/log.c
index 997bdd608e..a7f129d583 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2014,7 +2014,7 @@ int cmd_format_patch(int argc,
 			    N_("print patches to standard out")),
 		OPT_BOOL(0, "cover-letter", &cover_letter,
 			    N_("generate a cover letter")),
-		OPT_STRING(0, "cover-letter-format", &cover_letter_fmt, N_("format-spec"),
+		OPT_STRING(0, "commit-list-format", &cover_letter_fmt, N_("format-spec"),
 			    N_("format spec used for the commit list in the cover letter")),
 		OPT_BOOL(0, "numbered-files", &just_numbers,
 			    N_("use simple number sequence for output file names")),
@@ -2358,6 +2358,8 @@ int cmd_format_patch(int argc,
 		cover_letter_fmt = cfg.fmt_cover_letter_commit_list;
 		if (!cover_letter_fmt)
 			cover_letter_fmt = "shortlog";
+	} else if (cover_letter == -1) {
+		cover_letter = 1;
 	}
 
 	if (cover_letter == -1) {
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7c67bdf922..d2a775f78d 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -383,49 +383,50 @@ test_expect_success 'filename limit applies only to basename' '
 test_expect_success 'cover letter with subject, author and count' '
 	rm -rf patches &&
 	test_when_finished "git reset --hard HEAD~1" &&
-	test_when_finished "rm -rf patches result test_file" &&
+	test_when_finished "rm -rf patches test_file" &&
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --cover-letter \
-	--cover-letter-format="log:[%(count)/%(total)] %s (%an)" -o patches HEAD~1 &&
-	grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch >result &&
-	test_line_count = 1 result
+	git format-patch --commit-list-format="log:[%(count)/%(total)] %s (%an)" \
+	-o patches HEAD~1 &&
+	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
 '
 
-test_expected_success 'cover letter with author and count' '
+test_expect_success 'cover letter with author and count' '
 	test_when_finished "git reset --hard HEAD~1" &&
-	test_when_finished "rm -rf patches result test_file" &&
+	test_when_finished "rm -rf patches test_file" &&
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --cover-letter \
-	--cover-letter-format="log:[%(count)/%(total)] %an" -o patches HEAD~1 &&
-	grep "^\[1/1\] A U Thor$" patches/0000-cover-letter.patch >result &&
-	test_line_count = 1 result
+	git format-patch --commit-list-format="log:[%(count)/%(total)] %an" \
+	-o patches HEAD~1 &&
+	test_grep "^\[1/1\] A U Thor$" patches/0000-cover-letter.patch
 '
 
 test_expect_success 'cover letter shortlog' '
 	test_when_finished "git reset --hard HEAD~1" &&
-	test_when_finished "rm -rf patches result test_file" &&
+	test_when_finished "rm -rf expect patches result test_file" &&
+	cat >expect <<-"EOF" &&
+	A U Thor (1):
+	  This is a subject
+	EOF
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --cover-letter --cover-letter-format=shortlog \
-	-o patches HEAD~1 &&
-	sed -n -e "/^A U Thor/p;" patches/0000-cover-letter.patch >result &&
-	test_line_count = 1 result
+	git format-patch --commit-list-format=shortlog -o patches HEAD~1 &&
+	grep -E -A 1 "^A U Thor \([[:digit:]]+\):$" patches/0000-cover-letter.patch >result &&
+	cat result &&
+	test_cmp expect result
 '
 
-test_expect_success 'cover letter no format' '
+test_expect_success 'no cover letter but with format specified' '
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf patches result test_file" &&
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --cover-letter -o patches HEAD~1 &&
-	sed -n -e "/^A U Thor/p;" patches/0000-cover-letter.patch >result &&
-	test_line_count = 1 result
+	git format-patch --no-cover-letter --commit-list-format="[%(count)] %s" -o patches HEAD~1 &&
+	test_path_is_missing patches/0000-cover-letter.patch
 '
 
 test_expect_success 'cover letter config with count, subject and author' '
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 35e20b5351..2f9a597ec7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2775,7 +2775,6 @@ test_expect_success PERL 'send-email' '
 	test_completion "git send-email --cov" <<-\EOF &&
 	--cover-from-description=Z
 	--cover-letter Z
-	--cover-letter-format=Z
 	EOF
 	test_completion "git send-email --val" <<-\EOF &&
 	--validate Z
-- 
2.53.0.1118.gaef5881109

