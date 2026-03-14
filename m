Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056438AC65
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773530466; cv=none; b=a/JwByXXVQDMwamaITDTGckFJFFkDb/DMHfTxcavxG+cyTy41Mg/RIGJsFyDPiyPncKlt6GIIodfwlsy4S81v73Z2NB3SfwakoJ1YY7B+JlwYzBuI1lmyalKsQt04TrxvtbzfRFYGSiE7gZ/uvlqjWeCf8j+cmGxo1f/aw9BYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773530466; c=relaxed/simple;
	bh=rslktsimdRUXJE/9gjEL/FpCZEW+cPN3Q46fB9fRGXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgiJbDIsJhwuKuY7NsUFBhQPV65ictHyOx5MycgoBStnIvpKjb3fgNzOWqDgeDes3+UMfuLuL2ebm2e8TcoUB2G84A5QawKAFgnJMFqj7n3wLiBWPlW1JHsycJ5oZ6Hp/mk0UripFFKOsvtvq/CUJsLd8t8JvR0Tn92Y1TH9gk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=OtivUwDR; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="OtivUwDR"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773530455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+L9/zt+MryNe2o8Rv4WQCFq0ZPnDfi4vuRUcPwH5xM=;
	b=OtivUwDROlIKIHPMDgPYJ6sLtllS8ea3HXp/9S18qIg9agGdrJZp1k3wa/Rkfjtz1VQMhQ
	hIdkljpDHuFQDtjUM2G0KIKiKE1ybNPm2TpPKVulw/wxCgaT556zSitibmImQaXGsvVRxG
	X7PNy2aACvNjEZV+DHsTw3jrTySwftkT9tG+8bP7eGVxiSp8cNAduKxjpCNHzo1ltqySLJ
	P8zS6E1IFgwyBBJ6tX2OOKXJyesI2uSE+Nbsr2TscGQxPerJ9ZkR3v8NVo00knF+Xrv2Bk
	LGOfJyXxVEQP7AW7RpSSy0S6W79bXrFYLwSKk9fK5l3vINxDfIiSRkeVE3X28w==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [PATCH 7/7] format-patch: --commit-list-format without prefix
Date: Sun, 15 Mar 2026 00:20:50 +0100
Message-ID: <aa7802b653a44838ef78f5ae4a82b341c9853b33.1773530191.git.mroik@delayed.space>
In-Reply-To: <cover.1773530191.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3457; i=mroik@delayed.space; h=from:subject:message-id; bh=rslktsimdRUXJE/9gjEL/FpCZEW+cPN3Q46fB9fRGXM=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBptezEl3PlEeuTEchNwiXs71uVVM3QnLSs8Soj2 oG2ggUyJGOJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCabXsxAAKCRBIeX6hnBm+ 0S/MD/9I1sxHETeUN79Q56IjGObFedf6XSDfnvRj+q40Z68hU+PqXWz3QBG9N5C3WpnT7zqoAek QZRSbqUbSU1coMYVZVMWsR8p137hMWaVrm59sCuPZWA/MO7T969EvQhp3U7rWtD//+elKS9COzD JPdNolfVNTbCP62kXmYZOaz1O02vqgAvcu2MGiJ6GyEtZOaInw5ALb7G65rKg3M6uIfQYXZCWdC eRI3PW6ZKijgv3M9+LkF2nZyjQwgzdDf/eKg34KCR/IgcErNsFlaubB2ti/sA7VJt1RvuWwf+pf kMml8/Xz36zci4XNjU9R8rd9brLQx5T66kiB5vQSPhWeKwhv9xUFHJU+IpZSjJ2cjjkaZAL0r8R 6oB21KfPtE6acnm4cChvPPzvjRwZ7UVBT1Xith9iA4E1e+iWDcaoRQbctgFOV9eo+vjiUzMt7WZ 6DXIBXBRpNYudbKH/rLP0tRTrYHIaXwBOqVAviiQvde1rClsql1Br87ZbAApuHiAAIv+aaCB3ZK lvj00jgiCXg/5FYEzDj832C0ZXTkevAwhCkALKJcrIu8Or7wVH0J9ALzSVr2Q53XTdHmj1co5bK ve/zTLb9djOpsqTmn9KOI7b3Mfm0jMXx+NeKeeZIc5oj5n3Gt49U6zJAqCsVZ2WGKZ5d21TQtni 8Y5Xp3yjI
 IoEXsQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Having to prefix a custom format-string with "log:" when passed from the
cli interface can be annoying for many users. It would be great if it
could be dropped an it were still accepted.

Teach make_cover_letter() to accept custom format-strings if a
placeholder is detected.

Note that both here and in "git log --format" the check is done naively
by just checking for the presence of a '%'.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/git-format-patch.adoc |  4 +++-
 builtin/log.c                       |  2 ++
 t/t4014-format-patch.sh             | 24 ++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 55cc680685..c52dbcc170 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -326,8 +326,10 @@ feeding the result to `git send-email`.
 --commit-list-format=<format-spec>::
 	Specify the format in which to generate the commit list of the patch
 	series. The accepted values for format-spec are `shortlog`, `modern` or a
-	format string prefixed with `log:`.
+	format-string prefixed with `log:`.
 	e.g. `log: %s (%an)`
+	The user is allowed to drop the prefix if the format-string contains a
+	`%<placeholder>`.
 	If not given, defaults to the `format.commitListFormat` configuration
 	variable.
 	This option implies the use of `--cover-letter` unless
diff --git a/builtin/log.c b/builtin/log.c
index c6cf04350a..ad7b7215fe 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1448,6 +1448,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	else if (!strcmp(format, "modern"))
 		generate_commit_list_cover(rev->diffopt.file, "[%(count)/%(total)] %s",
 					   list, nr);
+	else if (strchr(format, '%'))
+		generate_commit_list_cover(rev->diffopt.file, format, list, nr);
 	else
 		die(_("'%s' is not a valid format string"), format);
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 7571cc582b..7517094bd6 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -392,6 +392,30 @@ test_expect_success 'cover letter with subject, author and count' '
 	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
 '
 
+test_expect_success 'cover letter with custom format no prefix' '
+	rm -rf patches &&
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches test_file" &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	git format-patch --commit-list-format="[%(count)/%(total)] %s (%an)" \
+	-o patches HEAD~1 &&
+	test_grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch
+'
+
+test_expect_success 'cover letter fail when no prefix and no placeholder' '
+	rm -rf patches &&
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf patches test_file err" &&
+	touch test_file &&
+	git add test_file &&
+	git commit -m "This is a subject" &&
+	test_must_fail git format-patch --commit-list-format="this should fail" \
+	-o patches HEAD~1 2>err &&
+	test_grep "is not a valid format string" err
+'
+
 test_expect_success 'cover letter modern format' '
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf patches test_file" &&
-- 
2.53.0.959.g497ff81fa9

