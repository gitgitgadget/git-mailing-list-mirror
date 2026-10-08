Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7543712D
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791492509; cv=none; b=hxED01xO0pLpHPfBtKI3TA8ypEKoyz+wGqUhNHKhKiLQTpzsFZzr3s9CsJ6HEI40useQS+oNXz5KIVvAdabmllkhHbduJ7398idyNF7ihi2VyBe/XweocuAFbtSE+ezo30jVQ5wElmJWfMeeZO7UwHWUyDtpv2IH9EVwPKvyG5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791492509; c=relaxed/simple;
	bh=Wf6cgB7vyipEu80CjzH09S0O6M2VeMj6Upy3mCFmjkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5FrBuJnOngxLN9ioI75XrMnwfpsa0y4ec+suWE9gtrqx5tplO9JGYSh/Jh7ivNeNh59Kj12PKwv5PaF1aABIxQRrcEVPFGTHEhGnqj5FjLau9hpZfvdY5EdTF7ocLuPYowqUvdoIWO+poudFto+ILt53wyhgFAqjQ8aJD9ZaUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6nxdQto; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6nxdQto"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3535aa147d8so52816eec.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791492507; x=1792097307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eRlfrtvT4ZEIJS3OCRoQ4Lr2Q+bRDhE9oUxp6l56oaQ=;
        b=C6nxdQto7aWLlFluQPXTHr1HOR/vCcCSrzjxXRSE4sJtchHp31vLZClVfxun+UU3G5
         SyxMUhH0nKuv4vtfu9xH5bqaPrcE3FnJ0ZLtm0FIlaYOvZjRx0J4PM+UOEuMm05MdkH5
         GlHP12eGbEgRFDuJ5i72rInBo3L30MoVxHJIQs2cHb3jN85UyO+Rgv2Kzg8GsehfTbbb
         BRiJfIxaFd3aPnJaTcy1DRl3jTneM5Mbjk7WOqBeqJQBg0lMJhcDrggz0BpKVd/ptErU
         mg8R0RLafr5eTUHGsPQ27vVU+Apv2cGU1JtHS25ELV3x9W3nWEIQv68e0lhqlM5cPLOU
         D+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791492507; x=1792097307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eRlfrtvT4ZEIJS3OCRoQ4Lr2Q+bRDhE9oUxp6l56oaQ=;
        b=OaLPufuOYxJJmtDKZEd2AIEQz9zdqnGy1S7amo+cnu9hikdAGIc5NJmZqRzMJEgZgU
         8RW3AmdIfQyNATe99SrtXBF+IRJxbfkUF3BxLD1LRgwzrPT5P2b7I3Nd5jPqVLhrrqK7
         XoGVjiP+NUWjJ7A9gd+P+UUrgHbKhAHnxkvJFKabiZOIusXNgm+aKjfQzrlQbLbPpaoX
         QCilGLLSOQw7BwqMzHKLMKLDq9NRrN2tLRAd3PgxsvDfJ+nDVad+eOxiwY8H4PWii3s4
         eIokh+avVrSiNjnct6e9gWiDbEkFea+McACh7aSioSkKHgYUA4WIspbvK4P4e36F+UTq
         gw0A==
X-Gm-Message-State: AFq9FYLBHHY0H2oIhC8DmZWhlh03bsSgkyXGKkR4pW8cnjeQlZM1Uryl
	Q8cxRQs+6G5WHy82ycxpz5VYF6txvrg4jv7C2joder70/eQObXwRcKNzjtrNEw==
X-Gm-Gg: AYBFou1hL9I8tlLP4YS7ovi6TEwPPcpD9tL14qPu+LMuN+ESGMpT2ltnmk8+2BWfeaC
	OK+sUSlZNh+o1bpNCL1BfdnuDqQg4yFIgUw66aSxucRrJNB8o4xDr6TbSXR4x5sKu8PXBlLVj9i
	EihGl/dtFlAFrkhB8W43w0Tw0OGMiEnMPGep7VDiRnghGpfvF9zp4uDDU/2z11XrOaqnelUdNRS
	fKAnCzt/OVR4XaKfd329e3yJPgXsX4FPJpewd89KBPaXnpunww5R9y93DDFPdMpr7l5x01K5T0X
	tESiBAziUUP9NICtXCp0HJP5kUnPiWbU1mkZq6v6xf5RPU6iw6BvmohSyk+aAiToMWWTCjG/99t
	7fm7tLmMUm6LlmLcRBFK5ki01FiHLTF6PLax7wW26nC4v39rMf4V9oXno3yyrodhxUwdyHylNer
	8TA2RqNe5Aya2sAFxx31IcCe3qOQtzrkscDW4Zhfj/XR20+cQlvYA1sQTTHX4dfr+0R1OQUQfuK
	vkhQpv+7dn6iqiCGYd+pXKFq+Hlz10T0O48EsbPqspr9qbo
X-Received: by 2002:a05:7301:4d0b:b0:33e:6714:3945 with SMTP id 5a478bee46e88-3537e0129e3mr62566eec.2.1791492506763;
        Thu, 08 Oct 2026 13:48:26 -0700 (PDT)
Received: from WF-A7VVAKE ([2605:a601:9a29:ec00:9c8c:3311:1812:c51c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm433930eec.28.2026.10.08.13.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 13:48:25 -0700 (PDT)
From: Curtis Allen Smith <curtis.allen.smith@gmail.com>
To: git@vger.kernel.org
Cc: Curtis Allen Smith <curtis.allen.smith@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 2/2] core: add core.convertAwareStatus to opt out of the content check
Date: Thu,  8 Oct 2026 14:45:04 -0600
Message-ID: <20261008204603.1988-3-curtis.allen.smith@gmail.com>
X-Mailer: git-send-email 2.56.0.windows.1
In-Reply-To: <20261008204603.1988-1-curtis.allen.smith@gmail.com>
References: <20261008204603.1988-1-curtis.allen.smith@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit makes an index refresh read and convert a path
whose size changed when conversion is active for it, so that "git
status" agrees with "git diff" and "git add".  Reading costs more than
trusting the size, and when the path has a clean filter configured the
cost includes running that filter -- Git LFS on a large file, say.

Reading is cheap enough on current hardware that agreeing with
"git diff" is the better default, but nobody should be stuck with it
if their filters are expensive.  Add core.convertAwareStatus:

	true (default)  consult the conversion for any path that has one,
	                including paths with a clean filter
	no-filter       consult only the conversions Git performs itself,
	                and decide a path with a clean filter on its size
	false           always treat a size change as a modification, as
	                Git did before

Being ordinary configuration, it can equally be given for a single
command:

	git -c core.convertAwareStatus=no-filter status

Paths that are not subject to conversion are decided on their size
alone in every mode, so this costs nothing in a repository that does
not use conversion.

Signed-off-by: Curtis Allen Smith <curtis.allen.smith@gmail.com>
---
 Documentation/config/core.adoc | 22 ++++++++++++++++
 environment.c                  | 14 ++++++++++
 environment.h                  |  7 +++++
 read-cache.c                   | 12 +++++++++
 t/t0020-crlf.sh                | 47 ++++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 0b697f53f..9737c804f 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -156,6 +156,28 @@ some fields (e.g. JGit); by excluding these fields from the
 comparison, the `minimal` mode may help interoperability when the
 same repository is used by these other systems at the same time.
 
+core.convertAwareStatus::
+	When a path is subject to content conversion -- the `text` and
+	`eol` attributes, `core.autocrlf`, a `working-tree-encoding`,
+	or a clean filter -- the size of the file in the working tree
+	is not determined by its contents alone, so a change in size
+	does not prove that the contents changed.  When this variable
+	is missing or set to `true`, Git reads and converts such a
+	file before reporting it as modified, which keeps 'git status'
+	in agreement with 'git diff' and 'git add'.  When set to
+	`no-filter`, Git does this only for the conversions it
+	performs itself, and a path with a clean filter configured
+	(Git LFS, for example) is reported as modified on a size
+	change without running the filter.  When set to `false`, a
+	size change is always taken as a modification, which is what
+	Git did before this variable existed.
++
+Reading the file costs more than trusting its size, so `no-filter`
+and `false` trade this consistency for speed in repositories where
+running the filter, or reading the file at all, is too expensive.
+Paths that are not subject to conversion are decided on the size
+alone in every mode.
+
 core.quotePath::
 	Commands that output paths (e.g. 'ls-files', 'diff'), will
 	quote "unusual" characters in the pathname by enclosing the
diff --git a/environment.c b/environment.c
index c83cf4483..b079262c8 100644
--- a/environment.c
+++ b/environment.c
@@ -344,6 +344,19 @@ int git_default_core_config(const char *var, const char *value,
 				     var, value);
 	}
 
+	if (!strcmp(var, "core.convertawarestatus")) {
+		int b = git_parse_maybe_bool(value);
+		if (0 <= b)
+			cfg->convert_aware_status = b ? CONVERT_AWARE_STATUS_ALL
+						      : CONVERT_AWARE_STATUS_NEVER;
+		else if (value && !strcasecmp(value, "no-filter"))
+			cfg->convert_aware_status = CONVERT_AWARE_STATUS_IN_PROCESS;
+		else
+			return error(_("invalid value for '%s': '%s'"),
+				     var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.quotepath")) {
 		quote_path_fully = git_config_bool(var, value);
 		return 0;
@@ -766,6 +779,7 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->apply_sparse_checkout = 0;
 	cfg->trust_ctime = 1;
 	cfg->check_stat = 1;
+	cfg->convert_aware_status = CONVERT_AWARE_STATUS_ALL;
 	cfg->zlib_compression_level = Z_BEST_SPEED;
 	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
 	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
diff --git a/environment.h b/environment.h
index b336459e9..49a88de27 100644
--- a/environment.h
+++ b/environment.h
@@ -115,6 +115,12 @@ enum object_creation_mode {
 	OBJECT_CREATION_USES_RENAMES = 1
 };
 
+enum convert_aware_status {
+	CONVERT_AWARE_STATUS_NEVER = 0,
+	CONVERT_AWARE_STATUS_IN_PROCESS,
+	CONVERT_AWARE_STATUS_ALL
+};
+
 struct repo_config_values {
 	/* section "core" config values */
 	char *attributes_file;
@@ -130,6 +136,7 @@ struct repo_config_values {
 	int apply_sparse_checkout;
 	int trust_ctime;
 	int check_stat;
+	enum convert_aware_status convert_aware_status;
 	int zlib_compression_level;
 	int pack_compression_level;
 	int precomposed_unicode;
diff --git a/read-cache.c b/read-cache.c
index 8875706d8..2bb27a388 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -554,9 +554,21 @@ static int size_change_is_conclusive(struct index_state *istate,
 				     const struct cache_entry *ce,
 				     struct stat *st)
 {
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+	struct conv_attrs ca;
+
+	if (cfg->convert_aware_status == CONVERT_AWARE_STATUS_NEVER)
+		return 1;
+
 	if (!S_ISREG(st->st_mode))
 		return 1;
 
+	if (cfg->convert_aware_status == CONVERT_AWARE_STATUS_IN_PROCESS) {
+		convert_attrs(istate, &ca, ce->name);
+		if (ca.drv)
+			return 1;
+	}
+
 	return !would_convert_to_git(istate, ce->name);
 }
 
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 88b728d50..4c127207e 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -442,4 +442,51 @@ test_expect_success 'status sizes a text file by its CRLF pairs, not its CRs' '
 	)
 '
 
+test_expect_success 'core.convertAwareStatus=false restores the size shortcut' '
+	git init convert-aware &&
+	(
+		cd convert-aware &&
+		echo "* text eol=lf" >.gitattributes &&
+		printf "one\ntwo\nthree\n" >file.txt &&
+		git add .gitattributes file.txt &&
+		git commit -m initial &&
+		printf "one\r\ntwo\r\nthree\r\n" >file.txt &&
+
+		git -c core.convertAwareStatus=false status --porcelain -uno >actual &&
+		echo " M file.txt" >expect &&
+		test_cmp expect actual &&
+
+		git -c core.convertAwareStatus=true status --porcelain -uno >actual &&
+		test_must_be_empty actual
+	)
+'
+
+test_expect_success 'core.convertAwareStatus=no-filter leaves clean filters alone' '
+	git init convert-aware-filter &&
+	(
+		cd convert-aware-filter &&
+		write_script stripcr <<-\EOF &&
+		tr -d "\015"
+		EOF
+		echo "file.txt filter=stripcr" >.gitattributes &&
+		git config filter.stripcr.clean ./stripcr &&
+		printf "one\ntwo\nthree\n" >file.txt &&
+		git add .gitattributes file.txt &&
+		git commit -m initial &&
+		printf "one\r\ntwo\r\nthree\r\n" >file.txt &&
+
+		git -c core.convertAwareStatus=no-filter status --porcelain -uno >actual &&
+		echo " M file.txt" >expect &&
+		test_cmp expect actual &&
+
+		git status --porcelain -uno >actual &&
+		test_must_be_empty actual
+	)
+'
+
+test_expect_success 'core.convertAwareStatus rejects an unknown value' '
+	test_must_fail git -c core.convertAwareStatus=bogus status 2>err &&
+	test_grep "invalid value" err
+'
+
 test_done
-- 
2.53.0

