Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BBD3793CA
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773530466; cv=none; b=Biy6ELY1PRenIWjlDqp5fuFK4hvkMlYg1mOOTK8BAJLaO9fLKIvvVsk1tA2WLZK1pc+iIMl/T5X0qS1lx4MIxuHfmRCRocGWBVT0hrXEvF1sB7BITXN2tsf5XI7heNsJDyVbq9F5gEDbQO9hExmBs4z5ldXTowFr4VZOOVzjkCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773530466; c=relaxed/simple;
	bh=8xoPDZ1L7ozyLn00CxIk1V4c0hK8ufXfZMmjziiLLNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ifka2g9vK2SD9Ty5Yu9Lz0WhDsC5Ui+F/SS1X13aG+Kl/YH7mfAtm/1vXtH92cpYYgp9fjRVAlfsqhmyE8hNHrwi9Yi2GLe6E6MUcGOQcnWt2SE4g81FpLUQrk0ZUcou7EEIAHxyLgOBoaQ1D3Q0qW9J6lDwWHyBh1rDasUXAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=U7FFwPYP; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="U7FFwPYP"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773530454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2jAv0aZWf7Lmxtjp5pUuF7NRqiDyTIxxTD3VeUt9OU=;
	b=U7FFwPYPvoNddOMTdO7PUqV5ulB4JNP/4lPTHLuzC01HOb8WFB88CepdXZewFdLuB7A918
	so1vs+cVC5knBEY/iSLroaBgevPmI14HtVjLibiMpz850G8o01pPkSKL+3+84s33D66CNv
	f8YPBwTQOGl6GqgyH3vsOPF3TJW8Yramn13EXEjg+MOOKS7zBpCLOPdEPDpf28s0bj0/uV
	1diE1pAjAty1ka+NRdayK6YwCT24Fa2jK9+FIDqE/0ENFMhMyvyeaTub5xNoYzVmsgbemb
	Dj13MR354kSZHbLXl4ALSyiMP1NhlpvvxOPI8pYUHqgCaslfjJRoEPCHnY0/FQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [PATCH 6/7] format-patch: add preset for --commit-list-format
Date: Sun, 15 Mar 2026 00:20:49 +0100
Message-ID: <2a29c31fbb7143867b680ce488f97e9b51150b97.1773530191.git.mroik@delayed.space>
In-Reply-To: <cover.1773530191.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4611; i=mroik@delayed.space; h=from:subject:message-id; bh=8xoPDZ1L7ozyLn00CxIk1V4c0hK8ufXfZMmjziiLLNo=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBptezDFzg4W6dodk41F7XF15YTQTO0uPIa/UMWD bBbZ2tNwZaJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCabXswwAKCRBIeX6hnBm+ 0dyiEACHggN7W2Fuj60nHnl8/BgfqMnsg6r0EYC0v6a4Uz2ga4jaIXebRTgXaK9Qp6eq8jl4xK2 G/DQ1ji6Qxgsv20qh4voVCOZptarDxUzKw2Ee3w7JSyZKHkRF9v/0Rr4EkrcDy90ROQs63Oq997 w6ZsBTx2HsScUKG2Cmv52WETNssnGSRU9UJEUH69a6jAy5Wbb1kkbtY1kSPIqMmOaN4Ny3dcj97 i62Jx1Obr3BD+tiiTOuX8wxM0bxxcup9F5FdoTM95v2PYR89Xjnvbml2t8BHG+Tg2Ak8Ep8BoOF 4l/zRJa0JESRZeh0FqY7h2X07Yt/Fa6MH/D2ZJAQ8UJeo2tSO9B0qAaEWWBgGcyMJEeZdsbCVdp M0Zx685Nj4CxT6aUwAs8Eq4laNrz4qI8KAfFaeVd/l/Rg6nwwBqWOelVyHSRm5/7CDzZL1SEUDE sjmfsSdov4fpFKj9QZbHLNhl4F6XWchhVrb8f50OJ1ox+uObzJMWMQR1BnLjXaTjDcGNc2Dcie6 BvOnCoOIhDXWH9yqnHBcE/Qsr9zyuYhU/68z0+vLBRGl6GWu8mE6sHQ/qSZeMfpa0dgL7eUqgl0 h4I1+6PgGL0gHL5ZlVJs4kFs4u/U+XrGzNvo4wGfhk9wfjIzZKb2lJZm+YgGIMdO3YARtkPV6rM ncqjwO3M3
 BKfSFA==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

"git format-patch --commit-list-format" enables the user to make their
own format for the commit list in the cover letter. It would be nice to
have a ready to use format to replace shortlog.

Teach make_cover_letter() the "modern" format preset.
This new format is the same as: "log:[%(count)/%(total)] %s".

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/config/format.adoc    |  2 +-
 Documentation/git-format-patch.adoc |  4 ++--
 builtin/log.c                       |  3 +++
 t/t4014-format-patch.sh             | 20 +++++++++++++++-----
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
index ea5ec5df7a..ef1ed1d250 100644
--- a/Documentation/config/format.adoc
+++ b/Documentation/config/format.adoc
@@ -104,7 +104,7 @@ format.coverLetter::
 format.commitListFormat::
 	When the `--cover-letter-format` option is not given, `format-patch`
 	uses the value of this variable to decide how to format the title of
-	each commit. Default to `shortlog`.
+	each commit. Defaults to `shortlog`.
 
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 45ca72e670..55cc680685 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -325,8 +325,8 @@ feeding the result to `git send-email`.
 
 --commit-list-format=<format-spec>::
 	Specify the format in which to generate the commit list of the patch
-	series. The accepted values for format-spec are "shortlog" or a format
-	string prefixed with `log:`.
+	series. The accepted values for format-spec are `shortlog`, `modern` or a
+	format string prefixed with `log:`.
 	e.g. `log: %s (%an)`
 	If not given, defaults to the `format.commitListFormat` configuration
 	variable.
diff --git a/builtin/log.c b/builtin/log.c
index d1765ce4ad..c6cf04350a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1445,6 +1445,9 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 		generate_commit_list_cover(rev->diffopt.file, format, list, nr);
 	else if (!strcmp(format, "shortlog"))
 		generate_shortlog_cover_letter(&log, rev, list, nr);
+	else if (!strcmp(format, "modern"))
+		generate_commit_list_cover(rev->diffopt.file, "[%(count)/%(total)] %s",
+					   list, nr);
 	else
 		die(_("'%s' is not a valid format string"), format);
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ca37f40a6a..7571cc582b 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -392,18 +392,17 @@ test_expect_success 'cover letter with subject, author and count' '
 	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
 '
 
-test_expect_success 'cover letter with author and count' '
+test_expect_success 'cover letter modern format' '
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf patches test_file" &&
 	touch test_file &&
 	git add test_file &&
 	git commit -m "This is a subject" &&
-	git format-patch --commit-list-format="log:[%(count)/%(total)] %an" \
-	-o patches HEAD~1 &&
-	test_grep "^\[1/1\] A U Thor$" patches/0000-cover-letter.patch
+	git format-patch --commit-list-format="modern" -o patches HEAD~1 &&
+	test_grep "^\[1/1\] This is a subject$" patches/0000-cover-letter.patch
 '
 
-test_expect_success 'cover letter shortlog' '
+test_expect_success 'cover letter shortlog format' '
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf expect patches result test_file" &&
 	cat >expect <<-"EOF" &&
@@ -451,6 +450,17 @@ test_expect_success 'cover letter config with count and author' '
 	test_line_count = 2 result
 '
 
+test_expect_success 'cover letter config commitlistformat set to modern' '
+	test_when_finished "rm -rf patches result" &&
+	test_when_finished "git config unset format.coverletter" &&
+	test_when_finished "git config unset format.commitlistformat" &&
+	git config set format.coverletter true &&
+	git config set format.commitlistformat modern &&
+	git format-patch -o patches HEAD~2 &&
+	grep -E "^[[[:digit:]]+/[[:digit:]]+] .*$" patches/0000-cover-letter.patch >result &&
+	test_line_count = 2 result
+'
+
 test_expect_success 'cover letter config commitlistformat set to shortlog' '
 	test_when_finished "rm -rf patches result" &&
 	test_when_finished "git config unset format.coverletter" &&
-- 
2.53.0.959.g497ff81fa9

