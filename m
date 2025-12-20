Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAB830C353
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766225810; cv=pass; b=prlaCYhmVGlc1Zt77d0R2gb970xsX/M88MGBys2DNEsnYg/gt0fzTWCncVA+4z1iTZe1ThoTnrtOAZpYbNOrP0cVUMMPYhBVY1nxktmYJXsKauHHGObasA5SlCPs5SapzRZH2UOp0LYxSxiDq4iNd5YaN0wgTF+v3+a8QSoJSuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766225810; c=relaxed/simple;
	bh=5ZQ3h8Fww206rp9NmiLjHp68mah6R33MWhpNd2+KXpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUlh8IA9Vya10363Uo2d3jGsjAZcsCaPsSugBwqS6XMCZ7+Z9nm4F4qtbzZ9JeJBEDlVqMsZXfD1qa6TLSUsV3VqhWI/0KxJaoddQoi/Ur9MHwk1NndQlIEEEVwCpVW7lBXiq/+vJF7iPF1p2wmviC5rPhDUHUYjYUnqlJvBcHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=KAXF0vp0; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="KAXF0vp0"
ARC-Seal: i=1; a=rsa-sha256; t=1766225793; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BGkjT1dvubAmtQRSklav2rsVz+iNiL50aFcysUbOfAprKLdPoX/O9PmZbe37x5wz5RRxnUmTh7Chnyc5G5aDVFjLQTGr1f2bb0GhwhScP54WkBIU+zik9naCCYe7ShUJzuX4TkHAc/Q7dgUmUERW3/o9iKoK0iEpFhrF/AbxJiY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766225793; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rtQSufD0wSaeLHZmX6NLn03pQY14hXjqcR3qsuDbjKE=; 
	b=OPBgEPchmO/qkqyRISOXOPoh+FttwqyLRDK8SEDlBsRZBvYzPX2VibCwKgEK4xA2xdxT6UAjnmzfGS9VV6gusbagzvULrLl+ReF2AQWy4kaXQFN3E42tTTMqk9TtHLP8mLaQYK3RtcN0I4xwFIgRfnTtlAuwXrGvA7TLFoL43Ls=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766225793;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rtQSufD0wSaeLHZmX6NLn03pQY14hXjqcR3qsuDbjKE=;
	b=KAXF0vp0rDsTp6EcXZYFNXh+A+fhGH3WsizK1QyIveKk2HSqYfuO7mCmFYHzwUiO
	tkWup8eVesF7tVFCmVa/F1y3puJOKvs80scoNs4Su1U2ensY/XO5voBQs7GBMMgu6tw
	cTKFUYQlCdq7wUvGO4uCFwvDdYtNDP5X9h26sKW0=
Received: by mx.zohomail.com with SMTPS id 1766225792306949.4736449722732;
	Sat, 20 Dec 2025 02:16:32 -0800 (PST)
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
Subject: [PATCH v7 11/11] submodule: detect conflicts with existing gitdir configs
Date: Sat, 20 Dec 2025 12:15:28 +0200
Message-ID: <20251220101528.1227487-12-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251220101528.1227487-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
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
 submodule.c                                | 60 ++++++++++++++++++++++
 t/t7425-submodule-gitdir-path-extension.sh | 27 ++++++++++
 2 files changed, 87 insertions(+)

diff --git a/submodule.c b/submodule.c
index 834c794b7d..d778e8eca7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2289,6 +2289,61 @@ static int check_casefolding_conflict(const char *git_dir,
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
@@ -2314,6 +2369,11 @@ static int validate_submodule_encoded_git_dir(char *git_dir, const char *submodu
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
index 5fcfc29363..5f221c507a 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -478,4 +478,31 @@ test_expect_success CASE_INSENSITIVE_FS 'verify hashing conflict resolution as a
 	verify_submodule_gitdir_path cloned-hash "Foo" "modules/${hash}"
 '
 
+test_expect_success 'submodule gitdir conflicts with previously encoded name (local config)' '
+	git init -b main super_with_encoded &&
+	(
+		cd super_with_encoded &&
+
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

