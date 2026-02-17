Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A562FC02F
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365966; cv=none; b=EL3Dpu5uD+nA8iUbyN2HejCGBJZdwQ8+WYKIEfvk0oN0YvtOR7NyMKA8ya/0VdMJuprfvbXOsiZRSSArvglZtEUVnp4pWIdIFgJMRcck/azzdGKgiEbySRPFTW0L0uys2oxdpgdOcs9d3MWLKTg44VxsXP9mCZuU345sMBpvujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365966; c=relaxed/simple;
	bh=mgVdCMHUday2l889POoyvP2siBGnGAvnM5z+EJSqiow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPdNvBB3HwYxj9gM/xAVHPyUA/HosmUuISrLuJXrm/YBdEhLk20ex6XDT+2z3LMJGboWZ5o+uFaHefgHvczSWnFC+Cg9GbTQZsp6/gt7kqMwmifznUaJDMLQ+b6YkebbHxgiqkFBhCJ8dRlnUABAZD6t+mp4nwW397T5urF8rRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=MhuakAse; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="MhuakAse"
From: Mroik <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771365961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6d/UdV/wleXJn0L2vfbFqc0K+Go2mt5vhxB7oSCauI=;
	b=MhuakAseHVCWfVegl81KpLwHzRNJucltvMTCkLoG1iF4z3CCxCDNdJaYKlX67A8/8MsqJe
	OdeC4aCd+W2aeNEZ0KGm62WXmhNbJyGa3pCCbaT3rA+W+mEAGdbCQysHDF2BP32ExVQAgE
	yoqiQlzZw06OMGpkosDuAPBHdNdmeAHtre4O0zma2s5Br2ktCZGeMGj0Xd2gk4HT3jjy/E
	J3xNJ1EGaHn8X4JYgtTH1J/lZJRFyHAYc4Pw9Y4AnDnDVBrSj0zxiUu9m8bnqmPYEQt/iX
	r7ed/kA9hge31P4G5fkThS82qkzqGuhw/9lxHrZ3KilE4j9ISB60zVj77IvAlQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH] format-patch: fix From header in cover letter
Date: Tue, 17 Feb 2026 23:04:39 +0100
Message-ID: <20260217220515.14127-1-mroik@delayed.space>
In-Reply-To: <20260216152730.37478-1-mroik@delayed.space>
References: <20260216152730.37478-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3745; i=mroik@delayed.space; h=from:subject; bh=Fb/gDHhh4YSw52c9r/I+VCRTZztCo1s6EgBqB4h35Cg=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBplOXPHUETKLZ2LJdrWYQsEuewhXH2hQNOAtgwd cvfa0tg06iJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZTlzwAKCRBIeX6hnBm+ 0Z7IEACyMbYnoF5pzP6Fiaw9rJDxAVnHMiLhndjRoA8F+pRoTL0Z3wcQvEdKDtEwrsn+mEf1/Uv oXCF0owIOBXqMRJSmC268DVZ/FkZ6G+1SkVjWkY2slPaj2f2tooYrqu1ooyjKZtuGX6yHIUcQmK gQ86oUMhQaNJVYdBGd5pD3U61DGCOdHdQJIpzpk+ucgpZ5vQGM2tJNbvHnPMqMV9+U7fH9M5Va6 5aGDIB3w7Xv6rd/C/n60cp8Y82uvSHdDSoEizFThVzULBGaaywHm00OCeNn7W1PZ9x192NYVmAi 0ozpOmifxtoUdqC0UJto8f6TUbFDApBpkApYdDz4/IKUVciHr3UfqvcQ2yel7/ONM+jPMKuWgba zFUSDWO9iNiXKrA1WRNGjZm33SmMMVpy056iccVCWRLReH2N36z5Gx5kpCLFd/uWscy3yfPgtbR V8/k/OX+XtOtj9OZLKM+lk/fBoHG3VKHKF1E8oWxX9QCLyPQfz3xj6GuccxHYkOCwA6oETndR8H Z/IZAj9S4iVfZ8niV+7wkTfgFMgYO4yHFLyMwwp8qRXQpHVTAmw6Udlg951iX+zsQrBLlcwgenK IZVxtXh1qmxu3CSpgHnRmDGoOXltRmCUs0cEwNhcCSQKf+5iigkdkWlPU1uWJo78v2OXVVliVq7 ggAH3uOMXRDLK1Q==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

From: Mirko Faina <mroik@delayed.space>

"git format-patch" takes "--from=<user ident>" command line option and
uses the given ident for patch e-mails, but this is not applied to the
cover letter, the option is ignored and the committer ident of the
current user is used.

Teach the make_cover_letter() function to honor the option, instead of
always using the current committer identity.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 Documentation/git-format-patch.adoc | 10 +++++-----
 builtin/log.c                       |  6 +++---
 t/t4014-format-patch.sh             |  8 ++++++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 9a7807ca71..05c4192dbc 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -282,11 +282,11 @@ e.g., `--rfc='-(WIP)'` results in "PATCH (WIP)".
 
 --from::
 --from=<ident>::
-	Use `ident` in the `From:` header of each commit email. If the
-	author ident of the commit is not textually identical to the
-	provided `ident`, place a `From:` header in the body of the
-	message with the original author. If no `ident` is given, use
-	the committer ident.
+	Use `ident` in the `From:` header of each email. In case of a
+	commit email, if the author ident of the commit is not textually
+	identical to the provided `ident`, place a `From:` header in the
+	body of the message with the original author. If no `ident` is
+	given, use the committer ident.
 +
 Note that this option is only useful if you are actually sending the
 emails and want to identify yourself as the sender, but retain the
diff --git a/builtin/log.c b/builtin/log.c
index d43ca693bf..42648dda54 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1332,7 +1332,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      int quiet,
 			      const struct format_config *cfg)
 {
-	const char *committer;
+	const char *from;
 	struct shortlog log;
 	struct strbuf sb = STRBUF_INIT;
 	int i;
@@ -1345,7 +1345,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	if (!cmit_fmt_is_mail(rev->commit_format))
 		die(_("cover letter needs email format"));
 
-	committer = git_committer_info(0);
+	from = cfg->from ? cfg->from : git_committer_info(0);
 
 	if (use_separate_file &&
 	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
@@ -1368,7 +1368,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	pp.date_mode.type = DATE_RFC2822;
 	pp.rev = rev;
 	pp.encode_email_headers = rev->encode_email_headers;
-	pp_user_info(&pp, NULL, &sb, committer, encoding);
+	pp_user_info(&pp, NULL, &sb, from, encoding);
 	prepare_cover_text(&pp, description_file, branch_name, &sb,
 			   encoding, need_8bit_cte, cfg);
 	fprintf(rev->diffopt.file, "%s\n", sb.buf);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 21d6d0cd9e..2135b65cee 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1472,6 +1472,14 @@ test_expect_success '--from uses committer ident' '
 	test_cmp expect patch.head
 '
 
+test_expect_success '--from applies to cover letter' '
+	test_when_finished "rm -rf patches" &&
+	git format-patch -1 --cover-letter --from="Foo Bar <author@example.com>" -o patches &&
+	echo "From: Foo Bar <author@example.com>" >expect &&
+	grep "^From:" patches/0000-cover-letter.patch >patch.head &&
+	test_cmp expect patch.head
+'
+
 test_expect_success '--from omits redundant in-body header' '
 	git format-patch -1 --stdout --from="A U Thor <author@example.com>" >patch &&
 	cat >expect <<-\EOF &&
-- 
2.53.0

