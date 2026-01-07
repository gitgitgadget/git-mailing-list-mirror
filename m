Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03F2848A4
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767827010; cv=pass; b=CMpf4OBmrb3VqXB/1TpjCGD6N/AXZvsoNpsFujaNWyfHmfgyo1MMe7CpyXVMSZ1poBzyMYDa/c8n7t5cc/lNXRHNYmHEeAdt7yZDpmlpL2a4n9mUX0GSnm7U6oWGs5Uu+f7I+w8iwkLy6LW5soexPCdBhW1mgc3LhPUEQh1jOfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767827010; c=relaxed/simple;
	bh=2fAtodb1QbMm1+ybxgSfYcnChHW6cukoGJ5FsV80Pdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYaSD+fYEa27BIUi67u+Md7DJ5e2Aot/uTfltvazRp4G1zgsEINtAADnr1NtNWAMgCv5lH3v5PU9Y45bDD8+bI12/7JJkRz7WwD6ikZybpSP36QRYuamqE6bhe/BrY9iknZP7odglyO4MO/1pLZ4jmIogTUW+FWRAT/12WmzGy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=FP3+09r+; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="FP3+09r+"
ARC-Seal: i=1; a=rsa-sha256; t=1767826995; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ADVvaI199JP1xPG0H2kLVTW6DJ4tmi6LChGD5Rx4ufHIED9umhYYaiNWZ1PrcndPbh6afYO+UYosd7H7ee8xi++RsTUTcPr8bvwSWJrpRnWZNmCPf/fEuSsdn3mixIWgCAuXeQZU+5H+Ef8l23kGovSshbbKpHAhk8B60rcIA60=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767826995; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yy444KsqCtWPm6mr9CjQr0A+tx6hWCGUaUJpMX0b7/0=; 
	b=hUSvq0v9F+OcL+t9FdC/M+Jwc3FLONJhTcGuJxJeGY06TVTWUuDtCIOOT0V2hBkAA2TJl+1lJAxJdDFuHrY4o/yb4kqmmsyFPqyF6j+z1f6O3sMeh9x48qrVniPm64s42WLZdADq+bRaRpyPrZ7bQfl8oasA5eaB6XgMi6jNM8E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767826994;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yy444KsqCtWPm6mr9CjQr0A+tx6hWCGUaUJpMX0b7/0=;
	b=FP3+09r+Yh27hA0Q8umajDux1kfGE+nxcEXrd2rEaShXnP2C6ja9eIyAV51M8CyV
	LD2ZqNV7YdTu9nBxtfQV5v3JDxudsyaalobCdPch1AfjX9EF2cB+oOlGRhK5G/f1T4h
	lW8JbOfIZeZdUtNDiLBWWYt12yTZusw6UXY2eeHU=
Received: by mx.zohomail.com with SMTPS id 1767826993786609.3683387721038;
	Wed, 7 Jan 2026 15:03:13 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v8 11/11] submodule: detect conflicts with existing gitdir configs
Date: Thu,  8 Jan 2026 01:01:45 +0200
Message-ID: <20260107230145.517562-12-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107230145.517562-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260107230145.517562-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Credit goes to Emily and Josh for testing and noticing a corner-case
which caused conflicts with existing gitdir configs to silently pass
validation, then fail later in add_submodule() with a cryptic error:

fatal: A git directory for 'nested%2fsub' is found locally with remote(s):
  origin	/.../trash directory.t7425-submodule-gitdir-path-extension/sub

This change ensures the validation step checks existing gitdirs for
conflicts. We only have to do this for submodules having gitdirs,
because those without submodule.%s.gitdir need to be migrated and
will throw an error earlier in the submodule codepath.

Quoting Josh:
 My testing setup has been as follows:
 * Using our locally-built Git with our downstream patch of [1] included:
   * create a repo "sub"
   * create a repo "super"
   * In "super":
     * mkdir nested
     * git submodule add ../sub nested/sub
     * Verify that the submodule's gitdir is .git/modules/nested%2fsub
 * Using a build of git from upstream `next` plus this series:
   * git config set --global extensions.submodulepathconfig true
   * git clone --recurse-submodules super super2
   * create a repo "nested%2fsub"
   * In "super2":
     * git submodule add ../nested%2fsub

At this point I'd expect the collision detection / encoding to take
effect, but instead I get the error listed above.
End quote

Suggested-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 submodule.c                                | 61 ++++++++++++++++++++++
 t/t7425-submodule-gitdir-path-extension.sh | 28 ++++++++++
 2 files changed, 89 insertions(+)

diff --git a/submodule.c b/submodule.c
index 2fb0f404fd..8c17da6a5a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2290,6 +2290,62 @@ static int check_casefolding_conflict(const char *git_dir,
 	return ret;
 }
 
+struct submodule_from_gitdir_cb {
+	const char *gitdir;
+	const char *submodule_name;
+	bool conflict_found;
+};
+
+static int find_conflict_by_gitdir_cb(const char *var, const char *value,
+				      const struct config_context *ctx UNUSED, void *data)
+{
+	struct submodule_from_gitdir_cb *cb = data;
+	const char *submodule_name_start;
+	size_t submodule_name_len;
+	const char *suffix = ".gitdir";
+	size_t suffix_len = strlen(suffix);
+
+	if (!skip_prefix(var, "submodule.", &submodule_name_start))
+		return 0;
+
+	/* Check if submodule_name_start ends with ".gitdir" */
+	submodule_name_len = strlen(submodule_name_start);
+	if (submodule_name_len < suffix_len ||
+	    strcmp(submodule_name_start + submodule_name_len - suffix_len, suffix) != 0)
+		return 0; /* Does not end with ".gitdir" */
+
+	submodule_name_len -= suffix_len;
+
+	/*
+	 * A conflict happens if:
+	 * 1. The submodule names are different and
+	 * 2. The gitdir paths resolve to the same absolute path
+	 */
+	if (value && strncmp(cb->submodule_name, submodule_name_start, submodule_name_len)) {
+		char *abs_path_cb = absolute_pathdup(cb->gitdir);
+		char *abs_path_value = absolute_pathdup(value);
+
+		cb->conflict_found = !strcmp(abs_path_cb, abs_path_value);
+
+		free(abs_path_cb);
+		free(abs_path_value);
+	}
+
+	return cb->conflict_found;
+}
+
+static bool submodule_conflicts_with_existing(const char *gitdir, const char *submodule_name)
+{
+	struct submodule_from_gitdir_cb cb = { 0 };
+	cb.submodule_name = submodule_name;
+	cb.gitdir = gitdir;
+
+	/* Find conflicts with existing repo gitdir configs */
+	repo_config(the_repository, find_conflict_by_gitdir_cb, &cb);
+
+	return cb.conflict_found;
+}
+
 /*
  * Encoded gitdir validation, only used when extensions.submodulePathConfig is enabled.
  * This does not print errors like the non-encoded version, because encoding is supposed
@@ -2315,6 +2371,11 @@ static int validate_submodule_encoded_git_dir(char *git_dir, const char *submodu
 	if (!last_submodule_name || strchr(last_submodule_name, '/'))
 		return -1;
 
+	/* Prevent conflicts with existing submodule gitdirs */
+	if (is_git_directory(git_dir) &&
+	    submodule_conflicts_with_existing(git_dir, submodule_name))
+			return -1;
+
 	/* Prevent conflicts on case-folding filesystems */
 	repo_config_get_bool(the_repository, "core.ignorecase", &config_ignorecase);
 	if (ignore_case || config_ignorecase) {
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index 1c2d4905b1..50d618045b 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -501,4 +501,32 @@ test_expect_success CASE_INSENSITIVE_FS 'verify hashing conflict resolution as a
 	verify_submodule_gitdir_path cloned-hash "Foo" "modules/${hash}"
 '
 
+test_expect_success 'submodule gitdir conflicts with previously encoded name (local config)' '
+	git init -b main super_with_encoded &&
+	(
+		cd super_with_encoded &&
+
+		git config core.repositoryformatversion 1 &&
+		git config extensions.submodulePathConfig true &&
+
+		# Add a submodule with a nested path
+		git submodule add --name "nested/sub" ../sub nested/sub &&
+		test_commit add-encoded-gitdir &&
+
+		verify_submodule_gitdir_path . "nested/sub" "modules/nested%2fsub" &&
+		test_path_is_dir ".git/modules/nested%2fsub"
+	) &&
+
+	# create a submodule that will conflict with the encoded gitdir name:
+	# the existing gitdir is ".git/modules/nested%2fsub", which is used
+	# by "nested/sub", so the new submod will get another (non-conflicting)
+	# name: "nested%252fsub".
+	(
+		cd super_with_encoded &&
+		git submodule add ../sub "nested%2fsub" &&
+		verify_submodule_gitdir_path . "nested%2fsub" "modules/nested%252fsub" &&
+		test_path_is_dir ".git/modules/nested%252fsub"
+	)
+'
+
 test_done
-- 
2.51.2

